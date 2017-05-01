using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.users
{
    public partial class post_message_sms : Web.UI.ManagePage
    {
        private string userids = "";
        private string mobiles = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.userids = HTRequest.GetQueryString("userids");
                if (!string.IsNullOrEmpty(userids))
                {
                    DataTable dt = new BLL.users().GetList(0, "id IN(" + this.userids + ")", "id desc").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow item in dt.Rows)
                        {
                            if (item["mobile"].ToString() != "")
                            {
                                mobiles += item["mobile"] + ";";
                            }
                        }
                    }
                    txtAccepts.Text = mobiles;
                }
            }
        }
        #region 发送短信=================================
        private bool SendSMS()
        {
            bool result = false;
            //发送短信
            string tipMsg = string.Empty;
            string smsContent = txtContent.Text;
            try
            {
                string[] mobileArry = txtAccepts.Text.Split(';');
                foreach (string mobile in mobileArry)
                {
                    if (!string.IsNullOrEmpty(mobile))
                    {
                        if (mobile.Length == 11)
                        {
                            result = new BLL.sms_message().Send(mobile, smsContent, 1, out tipMsg);
                        }
                        else if (mobile.Length == 9)
                        {
                            result = new BLL.sms_message().Send(mobile, smsContent, out tipMsg);
                        }
                        else
                        {
                            tipMsg = "手机格式不正确！";
                        }
                    }
                }
            }
            catch { }
            return result;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!SendSMS())
            {
                JscriptMsg("发送过程中发生错误！", "");
                return;
            }
            JscriptMsg("发送短信内容", "user_list.aspx");
            return;
        }
    }
}