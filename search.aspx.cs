using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;
using HT.EF;

namespace HT.Web
{
    public partial class search : System.Web.UI.Page
    {
        protected decimal totalTime;
        protected int totalCount;
        protected int page;
        protected int pageSize = 10;

        public string keywords;
        public string type;
        EF.HT_DB db = new EF.HT_DB();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.type = HTRequest.GetQueryString("type");
            this.keywords = HTRequest.GetQueryString("keyword");
            if (!IsPostBack)
            {
                BindDataType();
                BindList();
            }
        }
        protected string Replaces(string str)
        {
            for (int i = 0; i < 10; i++) {
                str = str.Replace("  ", "");
            }
            return str;
        }

        protected void BindList()
        {
            DateTime time1 = DateTime.Now;
            this.page = HTRequest.GetQueryInt("page", 1);
            if (!string.IsNullOrEmpty(this.keywords))
            {
                string[] keywordArr = Replaces(this.keywords.Trim()).Split(' ');
                keywordArr=LanguageHelper.ToSimplifiedChinese(keywordArr);
                List<EF.proc_Search_Result> list = new List<proc_Search_Result>();
                if (keywordArr.Length == 3)
                {
                    list = db.proc_Search(keywordArr[0], keywordArr[1], keywordArr[2]).ToList();
                }
                if (keywordArr.Length == 2)
                {
                    list = db.proc_Search(keywordArr[0], keywordArr[1], "").ToList();
                }
                if (keywordArr.Length == 1)
                {
                    list = db.proc_Search(keywordArr[0], "", "").ToList();
                }
                List<EF.proc_Search_Result> listN = new List<proc_Search_Result>();
                if (!string.IsNullOrEmpty(this.type))
                {
                    foreach (var item in list)
                    {
                        string[] strArr = DESEncrypt.Decrypt(this.type).Split('-');
                        if (item.fk_type == Utils.ObjToInt(strArr[0]))
                        {
                            if (item.channel_id == Utils.ObjToInt(strArr[1]))
                            {
                                listN.Add(item);
                            }
                        }
                    }
                }
                else
                {
                    listN = list;
                }
                totalCount = listN.Count;
                var pagelist = listN.Skip(pageSize * (page - 1)).Take(pageSize).OrderBy(s => s.id);

                rptList.DataSource = pagelist;
                rptList.DataBind();
                string pageUrl = Utils.CombUrlTxt("search.aspx", "page={0}&keyword={1}&type={2}", "__id__", this.keywords,this.type);
                PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
            }
            DateTime time2 = DateTime.Now;

            TimeSpan ts1 = new TimeSpan(time1.Ticks);
            TimeSpan ts2 = new TimeSpan(time2.Ticks);
            TimeSpan ts = ts1.Subtract(ts2).Duration();
            string dateDiff = ts.Minutes * 60 + ts.Seconds + "." + ts.Milliseconds;
            totalTime = Utils.ObjToDecimal(dateDiff,0);
        }

        protected void BindDataType()
        {
            DataTable tblDatas = new DataTable();
            DataColumn dtc1 = new DataColumn("title", typeof(string));
            DataColumn dtc2 = new DataColumn("type", typeof(string));
            tblDatas.Columns.Add(dtc1);
            tblDatas.Columns.Add(dtc2);
            tblDatas.Rows.Add(new object[] { "台湾伴手礼" , DESEncrypt.Encrypt("1-0")});
            tblDatas.Rows.Add(new object[] { "包车服务", DESEncrypt.Encrypt("2-0") });
            tblDatas.Rows.Add(new object[] { "行前须知", DESEncrypt.Encrypt("3-1") });
            tblDatas.Rows.Add(new object[] { "最新消息", DESEncrypt.Encrypt("3-2") });
            tblDatas.Rows.Add(new object[] { "影音专区", DESEncrypt.Encrypt("3-3") });
            tblDatas.Rows.Add(new object[] { "旅游攻略", DESEncrypt.Encrypt("3-4") });
            tblDatas.Rows.Add(new object[] { "主题旅游", DESEncrypt.Encrypt("3-5") });
            tblDatas.Rows.Add(new object[] { "景点推荐", DESEncrypt.Encrypt("4-0") });
            tblDatas.Rows.Add(new object[] { "吃在台湾", DESEncrypt.Encrypt("5-0") });
            tblDatas.Rows.Add(new object[] { "住在台湾", DESEncrypt.Encrypt("6-0") });
            tblDatas.Rows.Add(new object[] { "旅游行程", DESEncrypt.Encrypt("7-0") });
            tblDatas.Rows.Add(new object[] { "达人精选", DESEncrypt.Encrypt("8-0") });
            tblDatas.Rows.Add(new object[] { "讨论区", DESEncrypt.Encrypt("9-0") });
            rptListDataType.DataSource = tblDatas;
            rptListDataType.DataBind();
        }
    }
}