using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.users
{
    public partial class post_message_email : Web.UI.ManagePage
    {
        private string userids = "";
        private string emails = "";
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
                            if (item["email"].ToString() != "")
                            {
                                emails += item["email"] + ";";
                            }
                        }
                    }
                    txtAccepts.Text = emails;
                }
            }
        }
        #region 发送邮件=================================
        private bool SendEmail()
        {
            bool result = false;
            //替换标签
            string mailTitle = txtMailTitle.Text;
            string mailContent = txtContent.Value;
            try
            {
                //正则表达式字符串
                string emailStr = @"([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})+";
                string[] emailsArry = txtAccepts.Text.Split(';');
                foreach (string email in emailsArry)
                {
                    if (!string.IsNullOrEmpty(email))
                    {
                        //邮箱正则表达式对象
                        Regex emailReg = new Regex(emailStr);
                        if (emailReg.IsMatch(email.Trim()))
                        {
                            //发送邮件
                            HTMail.sendMail(siteConfig.emailsmtp, siteConfig.emailssl, siteConfig.emailusername, DESEncrypt.Decrypt(siteConfig.emailpassword, siteConfig.sysencryptstring), siteConfig.emailnickname, siteConfig.emailfrom, email, mailTitle, mailContent);
                            result = true;
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
            if (!SendEmail())
            {
                JscriptMsg("发送过程中发生错误！", "");
                return;
            }
            JscriptMsg("发送邮件内容", "user_list.aspx");
            return;
        }
    }
}