using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Serialization;
using HT.Common;
using System.Net;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using HT.DBUtility;
namespace HT.Web
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetHotelList();
        }

        //获取酒店数据
        protected void GetHotelList()
        {
            DbHelperSQL.ExecuteSql("delete LR_RoomList; delete LR_Hotel;");


            string resultStr = HttpGet("http://xmlfeed.laterooms.com/index.aspx?aid=16484&rtype=4&kword=taiwan");

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(resultStr);
            string JsonData = JsonConvert.SerializeXmlNode(xmlDoc);
            dynamic ObjData = JsonHelper.JSONToObject<dynamic>(JsonData);
            StringBuilder sb = new StringBuilder();
            try
            {
                foreach (var item in ObjData["root"]["hotel"])
                {
                    string hotel_name = item["hotel_name"];
                    hotel_name = hotel_name.Replace("'", "''");
                    string hotel_address = item["hotel_address"];
                    hotel_address = hotel_address.Replace("'", "''");
                    string hotel_description = item["hotel_description"];
                    hotel_description = hotel_description.Replace("'", "''");
                    string hotel_directions = item["hotel_directions"];
                    hotel_directions = hotel_directions.Replace("'", "''");
                    string sql = "insert into LR_Hotel values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}',{9},'{10}','{11}','{12}','{13}','{14}');";
                    sql = string.Format(sql, item["hotel_ref"], hotel_name, item["hotel_star"], hotel_address, item["hotel_city"], hotel_description, hotel_directions, item["hotel_link"], item["hotel_no_of_rooms"], item["rack_rate"], item["images"], item["geo_code"]["long"], item["geo_code"]["lat"], DateTime.Now, DateTime.Now);
                    sb.Append(sql);
                }
                DbHelperSQL.ExecuteSql(sb.ToString());
                sb.Clear();
                for (int i = 0; i < ObjData["root"]["hotel"].Length; i++)
                {
                    sb.Append(GetRoomList(ObjData["root"]["hotel"][i]["hotel_ref"]));
                }
                DbHelperSQL.ExecuteSql(sb.ToString());
                sb.Clear();
            }
            catch { }
        }
        //获取房型数据
        protected string GetRoomList(string prodNo)
        {
            try
            {
                float Currency = CurrencyHelper.Convert(CurrencyHelper.CurrencyType.EUR, CurrencyHelper.CurrencyType.CNY);

                string url = "http://xmlfeed.laterooms.com/index.aspx?aid=16484&rtype=3&hids=" + prodNo + "&sdate=" + DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");

                StringBuilder sb = new StringBuilder();
                string resultStr = HttpGet(url);
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(resultStr);
                string JsonData = JsonConvert.SerializeXmlNode(xmlDoc);
                dynamic ObjData = JsonHelper.JSONToObject<dynamic>(JsonData);
                if (ObjData["hotel_search"]["response"]["@status"] == "1")
                {
                    if (ObjData["hotel_search"]["hotel"]["lr_rates"]["hotel_rooms"].ToString() != "")
                    {
                        for (int i = 0; i < ObjData["hotel_search"]["hotel"]["lr_rates"]["hotel_rooms"]["room"].Length; i++)
                        {
                            dynamic obj = ObjData["hotel_search"]["hotel"]["lr_rates"]["hotel_rooms"]["room"][i];
                            int price = (int)(Currency * HT.Common.Utils.StrToFloat(obj["rack_rate"], 0));
                            string sql = "insert into LR_RoomList values('{0}','{1}','{2}','{3}','{4}','{5}','{6}');";
                            sql = string.Format(sql, prodNo, obj["ref"], obj["typedescription"], price, 0, DateTime.Now, DateTime.Now);
                            sb.Append(sql);
                        }
                    }
                }
                 return sb.ToString();
            }
            catch(Exception e){
                return "";
            }
           
        }


        /// <summary>
        /// HTTP GET方式请求数据.
        /// </summary>
        /// <param name="url">URL.</param>
        /// <returns></returns>
        public  string HttpGet(string url)
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Method = "GET";
            request.ContentType = "application/xml";
            request.Accept = "*/*";
            request.Timeout = 15000;
            request.AllowAutoRedirect = false;

            WebResponse response = null;
            string responseStr = null;

            try
            {
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
                response = null;
            }

            return responseStr;
        }
    }
}