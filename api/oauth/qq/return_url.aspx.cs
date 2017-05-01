using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.API.OAuth;
using HT.Common;

namespace HT.Web.api.oauth.qq
{
    public partial class return_url : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //取得返回参数
            string state = HTRequest.GetQueryString("state");
            string code = HTRequest.GetQueryString("code");

            string access_token = string.Empty;
            string expires_in = string.Empty;
            string client_id = string.Empty;
            string openid = string.Empty;

            if (Session["oauth_state"] == null || Session["oauth_state"].ToString() == "" || state != Session["oauth_state"].ToString())
            {
                Response.Write("出错啦，state未初始化！");
                return;
            }
            
            //第一步：获取Access Token
            Dictionary<string, object> dic1 = qq_helper.get_access_token(code, state);
            if (dic1 == null || !dic1.ContainsKey("access_token"))
            {
                Response.Write("错误代码：，无法获取Access Token，请检查App Key是否正确！");
                return;
            }
            access_token = dic1["access_token"].ToString();
            expires_in = dic1["expires_in"].ToString();

            //第二步：通过Access Token来获取用户的OpenID
            Dictionary<string, object> dic2 = qq_helper.get_open_id(access_token);
            if (dic2 == null || !dic2.ContainsKey("openid"))
            {
                if (dic2.ContainsKey("error"))
                {
                    Response.Write("error：" + dic2["error"] + ",error_description：" + dic2["error_description"]);
                }
                else
                {
                    Response.Write("出错啦，无法获取用户授权Openid！");
                }
                return;
            }
            client_id = dic2["client_id"].ToString();
            openid = dic2["openid"].ToString();
            //储存获取数据用到的信息
            Session["oauth_name"] = "qq";
            Session["oauth_access_token"] = access_token;
            Session["oauth_openid"] = openid;

            //第三步：跳转到指定页面
            //Response.Redirect("/oauth_login.aspx");
            //Response.Write("\access_token:" + access_token + ",openid:" + openid);
            //return;

            Dictionary<string, object> resultJson = JsonHelper.JSONToObject<Dictionary<string, object>>(QQResultJson());

            if (resultJson.ContainsKey("ret") && resultJson["ret"].ToString() == "1")
            {
                Response.Write(resultJson["msg"].ToString());
                return;
            }
            if (resultJson.ContainsKey("openid") && resultJson["openid"].ToString() == "0")
            {
                Response.Write(resultJson["msg"].ToString());
                return;
            }

            BLL.users bllUser = new BLL.users();
            HT.Model.user_oauth modelOauth = new HT.BLL.user_oauth().GetModel("qq", resultJson["oauth_openid"].ToString());
            if (modelOauth != null)
            {
                Model.users modelUser = bllUser.GetModel(modelOauth.user_id);
                try
                {
                    if (modelUser == null)
                    {
                        Response.Write("错误：登陆失败！");
                        return;
                    }
                    Session[HTKeys.SESSION_USER_INFO] = modelUser;
                    Session.Timeout = 45;
                    //防止Session提前过期
                    Utils.WriteCookie(HTKeys.COOKIE_USER_NAME_REMEMBER, "HT", modelUser.user_name);
                    Utils.WriteCookie(HTKeys.COOKIE_USER_PWD_REMEMBER, "HT", modelUser.password);
                }
                catch (Exception ex)
                {
                    Response.Write("错误：登陆异常！");
                    return;
                }
            }
            else
            {
                Model.users model = new Model.users();
                model.reg_time = DateTime.Now;
                model.group_id = 1;
                model.avatar = resultJson["avatar"].ToString();
                model.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                model.password = DESEncrypt.Encrypt("123456", model.salt);
                model.reg_ip = HTRequest.GetIP();
                model.nick_name = resultJson["nick"].ToString();
                model.user_name = "qq_" + Utils.GetCheckCode(8);
                model.sex = resultJson["sex"].ToString();
                model.mobile = "";
                model.point = 10;
                int resultId = bllUser.Add(model);
                if (resultId > 0)
                {
                    model.id = resultId;
                    //绑定到对应的授权类型
                    HT.Model.user_oauth oauthModel = new HT.Model.user_oauth();
                    oauthModel.oauth_name = "qq";
                    oauthModel.user_id = resultId;
                    oauthModel.user_name = model.user_name;
                    oauthModel.oauth_access_token = resultJson["oauth_access_token"].ToString();
                    oauthModel.oauth_openid = resultJson["oauth_openid"].ToString();
                    new HT.BLL.user_oauth().Add(oauthModel);

                    Session[HTKeys.SESSION_USER_INFO] = model;
                    Session.Timeout = 45;
                    //防止Session提前过期
                    Utils.WriteCookie(HTKeys.COOKIE_USER_NAME_REMEMBER, "HT", model.user_name);
                    Utils.WriteCookie(HTKeys.COOKIE_USER_PWD_REMEMBER, "HT", model.password);
                }
                else
                {
                    Response.Write("错误：登陆失败！");
                    return;
                }
            }

            Response.Redirect("/index.aspx");
            return;

        }


        /// <summary>
        /// QQ登录返回action, 处理用户信息
        /// </summary>
        public string QQResultJson()
        {
            string oauth_access_token = string.Empty;
            string oauth_openid = string.Empty;
            string oauth_name = string.Empty;

            if (Session["oauth_name"] == null || Session["oauth_access_token"] == null || Session["oauth_openid"] == null)
            {
                return "{\"ret\":\"1\", \"msg\":\"出错啦，Access Token已过期或不存在！\"}";
            }
            oauth_name = Session["oauth_name"].ToString();
            oauth_access_token = Session["oauth_access_token"].ToString();
            oauth_openid = Session["oauth_openid"].ToString();
            Dictionary<string, object> dic = qq_helper.get_user_info(oauth_access_token, oauth_openid);
            if (dic == null)
            {
                return "{\"ret\":\"1\", \"msg\":\"出错啦，无法获取授权用户信息！\"}";
            }
            try
            {
                if (dic["ret"].ToString() != "0")
                {
                    return "{\"ret\":\"" + dic["ret"].ToString() + "\", \"msg\":\"出错信息:" + dic["msg"].ToString() + "！\"}";
                }
                StringBuilder str = new StringBuilder();
                str.Append("{");
                str.Append("\"ret\": \"" + dic["ret"].ToString() + "\", ");
                str.Append("\"msg\": \"" + dic["msg"].ToString() + "\", ");
                str.Append("\"oauth_name\": \"" + oauth_name + "\", ");
                str.Append("\"oauth_access_token\": \"" + oauth_access_token + "\", ");
                str.Append("\"oauth_openid\": \"" + oauth_openid + "\", ");
                str.Append("\"nick\": \"" + dic["nickname"].ToString() + "\", ");
                str.Append("\"avatar\": \"" + dic["figureurl_qq_2"].ToString() + "\", ");
                str.Append("\"sex\": \"" + dic["gender"].ToString() + "\", ");
                str.Append("\"birthday\": \"\"");
                str.Append("}");
                return str.ToString();
            }
            catch
            {
                return "{\"ret\":\"1\", \"msg\":\"出错啦，无法获取授权用户信息！\"}";
            }
        }
    }
}