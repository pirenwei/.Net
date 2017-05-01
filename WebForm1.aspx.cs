using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;
using HT.DBUtility;
namespace HT.Web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string startDate;
        string endDate;
        float Currency = CurrencyHelper.Convert(CurrencyHelper.CurrencyType.TWD, CurrencyHelper.CurrencyType.CNY);
        List<string> arr=new List<string>() ;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Timeout = 200000;
            startDate = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
            endDate = DateTime.Now.AddDays(2).ToString("yyyy-MM-dd");
            var list = EF.DN_ArrCityRepository.Repository.FindList(x => x.code.Length == 3);
            string sql = "delete DN_RoomList; delete DN_Hotel;delete DN_RoomPrice;";
            DbHelperSQL.ExecuteSql(sql);
            
            foreach (EF.DN_ArrCity cy in list)
            {
                GetHotelList(cy.code, 1);
            }
    
        }


        //获取酒店数据
        protected void GetHotelList(string code, int page = 1)
        {
            string url = "http://open.settour.com.tw/open/rest/api/v1/hdp/prodList.json";
            string parm = "{\"prodTypes\": \"HDP\",\"arrCode\": \"" + code + "\",\"dtSt\": \"" + startDate + "\",\"dtEt\": \"" + endDate + "\",\"ps1\" : \"\",\"ps2\" : \"\",\"keyword\" : \"\",\"pageNo\" : \"" + page + "\",\"sort\": [{\"type\": \"HDP\",\"code\": \"Sale\",\"asc\":true}, {\"type\": \"HDP\",\"code\": \"Price\",\"asc\":true}]}";
            StringBuilder sb = new StringBuilder();
            string jsonData = HttpPost(url, parm);

            dynamic list = JsonHelper.JSONToObject<dynamic>(jsonData);
            if (list["msgCode"] == "000")
            {
                for (int i = 0; i < list["results"].Length; i++)
                {
                    bool isContinue = false;
                    foreach (string prodNo in arr){
                        if (prodNo == list["results"][i]["prodNo"])
                        {
                            isContinue=true;
                        }
                    }
                    if (isContinue) {
                        continue;
                    }
                    arr.Add(list["results"][i]["prodNo"]);
                    string sql = "insert into DN_Hotel(prodNo,price,nameTw,nameEn,photo210,photo60,lng,lat)values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}');";
                    sql = string.Format(sql, list["results"][i]["prodNo"], list["results"][i]["price"], list["results"][i]["nameTw"], list["results"][i]["nameEn"],
                        list["results"][i]["photo210"], list["results"][i]["photo60"], list["results"][i]["lng"], list["results"][i]["lat"]);
                    sb.Append(sql);
                    DbHelperSQL.ExecuteSql(sb.ToString());
                    sb.Clear();
                    sb.Append(GetHotel(list["results"][i]["prodNo"]));
                    sb.Append(GetHotel2(list["results"][i]["prodNo"]));
                    sb.Append(GetRoomList(list["results"][i]["prodNo"]));
                    DbHelperSQL.ExecuteSql(sb.ToString());
                    sb.Clear();
                }
                //递归查询
                if (Convert.ToInt32(list["totalPage"]) > page)
                {
                    GetHotelList(code, page + 1);
                }
            }


        }
        //获取酒店补充数据
        protected string GetHotel(string prodNo)
        {
            string url = "http://open.settour.com.tw/open/rest/api/v1/hdp/prodDesc.json";
            string parm = "{\"prodNo\":\"" + prodNo + "\"}";
            StringBuilder sb = new StringBuilder();
            string jsonData = HttpPost(url, parm);
            dynamic list = JsonHelper.JSONToObject<dynamic>(jsonData.Replace("'", "''").Replace("\r\n", ""));
            if (list["msgCode"] == "000")
            {
                string sql = @"update DN_Hotel set descript='{0}',hotelAddress='{1}',htelTel1='{2}',
                                    hotelUrl='{3}' where prodNo='{4}';";
                sql = string.Format(sql, list["desc"], list["hotelAddress"],
                    list["hotelTel1"], list["hotelUrl"], prodNo);
                sb.Append(sql);

            }
            return sb.ToString();
        }
        //获取酒店补充数据
        protected string GetHotel2(string prodNo)
        {
            string url = "http://open.settour.com.tw/open/rest/api/v1/hdp/prodDetail.json";
            string parm = "{\"prodNo\":\"" + prodNo + "\"}";
            StringBuilder sb = new StringBuilder();
            string jsonData = HttpPost(url, parm);
            dynamic list = JsonHelper.JSONToObject<dynamic>(jsonData.Replace("'", "''").Replace("\r\n", ""));
            if (list["msgCode"] == "000")
            {
                string sql = @"update DN_Hotel set htlDesc='{0}' where prodNo='{1}';";
                sql = string.Format(sql, list["htlDesc"], prodNo);
                sb.Append(sql);

            }
            return sb.ToString();
        }
        //获取房型数据
        protected string GetRoomList(string prodNo)
        {
            
            string url = "http://open.settour.com.tw/open/rest/api/v1/hdp/roomList.json";
            string parm = "{\"prodNo\":\"" + prodNo + "\",\"dtSt\":\"" + startDate + "\",\"dtEt\":\"" + endDate + "\"}";
            StringBuilder sb = new StringBuilder();
            string jsonData = HttpPost(url, parm);
            dynamic list = JsonHelper.JSONToObject<dynamic>(jsonData.Replace("'", "''").Replace("\r\n", ""));
            try
            {
                if (list["msgCode"] == "000")
                {
                    for (int i = 0; i < list["results"].Length; i++)
                    {
                        int price = (int)(Currency * list["results"][i]["avgPrice"]);
                        string sql = @"insert into DN_RoomList (roomTypeLvl,viewType,roomType,roomTypeNo,bedType,mealType,roomDesc,projectName
                                   ,projectDesc,projectBegDate,projectEndDate,price,prodNo)values('{0}','{1}','{2}','{3}','{4}','{5}','{6}',
                                    '{7}','{8}','{9}','{10}','{11}','{12}');";
                        sql = string.Format(sql, list["results"][i]["roomTypeLvl"], list["results"][i]["viewType"], list["results"][i]["roomType"],
                            list["results"][i]["roomTypeNo"], list["results"][i]["bedType"], list["results"][i]["mealType"], list["results"][i]["roomDesc"],
                            list["results"][i]["projectName"], list["results"][i]["projectDesc"], list["results"][i]["projectBegDate"], list["results"][i]["projectEndDate"],
                            price.ToString(), prodNo);
                        sb.Append(sql);
                        sb.Append(GetRoomList2(prodNo, list["results"][i]["roomTypeNo"], list["results"][i]["roomType"]));
                    }
                }
            }
            catch (Exception e)
            {
                return "";
            }
            return sb.ToString();
        }
        //获取房型补充数据，目前这个接口都返回“該房型無每日房價”
        protected string GetRoomList2(string prodNo, string roomTypeNo, string roomType)
        {
            string url = "http://open.settour.com.tw/open/rest/api/v1/hdp/dailyPrice.json";
            string parm = "{\"prodNo\":\"" + prodNo + "\",\"roomTypeNo\":\"" + roomTypeNo + "\"}";
            StringBuilder sb = new StringBuilder();
            string jsonData = HttpPost(url, parm);
            dynamic list = JsonHelper.JSONToObject<dynamic>(jsonData.Replace("'", "''"));
            if (list["msgCode"] == "000")
            {
                for (int i = 0; i < list["results"].Length; i++)
                {
                    int price = (int)(Currency * list["results"][i]["price"]);
                    string sql = @"insert into DN_RoomPrice (begDt,price,status,qty,prodNo,roomTypeNo,roomType)values('{0}',
                                   '{1}','{2}','{3}','{4}','{5}','{6}');";
                    sql = string.Format(sql, list["results"][i]["begDt"], price, list["results"][i]["status"],
                        list["results"][i]["qty"], prodNo, roomTypeNo, roomType);
                    sb.Append(sql);
                }
            }
            return sb.ToString();
        }


        /// <summary>
        /// HTTP POST方式请求数据
        /// </summary>
        /// <param name="url">URL.</param>
        /// <param name="param">POST的数据</param>
        /// <returns></returns>
        public string HttpPost(string url, string param)
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/json";
            request.Accept = "*/*";
            request.Headers.Add("apiSid", "1111");
            request.Headers.Add("apiKey", "JOIIKCKCOOLJIIBIBMIL");
            request.Timeout = 15000;
            request.AllowAutoRedirect = false;

            StreamWriter requestStream = null;
            WebResponse response = null;
            string responseStr = null;

            try
            {
                requestStream = new StreamWriter(request.GetRequestStream());
                requestStream.Write(param);
                requestStream.Close();

                response = request.GetResponse();
                if (response != null)
                {
                    StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                    responseStr = reader.ReadToEnd();
                    reader.Close();
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                request = null;
                requestStream = null;
                response = null;
            }

            return responseStr;
        }
    }
}