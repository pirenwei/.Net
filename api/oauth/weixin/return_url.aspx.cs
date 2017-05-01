using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.API.OAuth;
using HT.Common;

namespace HT.Web.api.oauth.weixin
{
    public partial class return_url : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //取得返回参数
            string state = HTRequest.GetQueryString("state");
            string code = HTRequest.GetQueryString("code");

            //取得返回参数
            string access_token = string.Empty;
            string expires_in = string.Empty;
            string client_id = string.Empty;
            string openid = string.Empty;
            string refresh_token = string.Empty;

            if (Session["oauth_state"] == null || Session["oauth_state"].ToString() == "" || state != Session["oauth_state"].ToString())
            {
                Response.Write("出错啦，state未初始化！");
                return;
            }
            //第一步：通过code来获取Access Token以及openid
            Dictionary<string, object> dic1 = weixin_helper.get_access_token(code, state);
            if (dic1 == null || !dic1.ContainsKey("access_token"))
            {
                Response.Write("错误代码：，无法获取Access Token，请检查App Key是否正确！");
                return;
            }
            if (dic1 == null || !dic1.ContainsKey("openid"))
            {
                if (dic1.ContainsKey("errmsg"))
                {
                    Response.Write("errcode：" + dic1["errcode"] + ",errmsg：" + dic1["errmsg"]);
                    return;
                }
                else
                {
                    Response.Write("出错啦，无法获取用户授权Openid！");
                    return;
                }
            }
            access_token = dic1["access_token"].ToString();//获取access_token
            expires_in = dic1["expires_in"].ToString();//获取过期时间
            refresh_token = dic1["refresh_token"].ToString();//获取用于重新刷新access_token的凭证
            openid = dic1["openid"].ToString();//用户唯一标示openid

            //储存获取数据用到的信息
            Session["oauth_name"] = "weixin";
            Session["oauth_access_token"] = access_token;
            Session["oauth_openid"] = openid;
            Session["oauth_refresh_token"] = refresh_token;
            //第三步：跳转到指定页面

            Dictionary<string, object> resultJson = JsonHelper.JSONToObject<Dictionary<string, object>>(WeChatResultJson());

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
            HT.Model.user_oauth modelOauth = new HT.BLL.user_oauth().GetModel("weixin", resultJson["oauth_openid"].ToString());
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
                model.avatar = resultJson["headimgurl"].ToString();
                model.salt = Utils.GetCheckCode(6); //获得6位的salt加密字符串
                model.password = DESEncrypt.Encrypt("123456", model.salt);
                model.reg_ip = HTRequest.GetIP();
                model.nick_name = resultJson["nickname"].ToString();
                model.user_name = "weixin_" + Utils.GetCheckCode(8); 
                model.mobile = "";
                model.point = 10;
                int resultId = bllUser.Add(model);
                if (resultId > 0)
                {
                    model.id = resultId;
                    //绑定到对应的授权类型
                    HT.Model.user_oauth oauthModel = new HT.Model.user_oauth();
                    oauthModel.oauth_name = "weixin";
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
        /// 微信登录返回action, 处理用户信息
        /// </summary>
        public string WeChatResultJson()
        {
            string oauth_access_token = string.Empty;
            string oauth_openid = string.Empty;
            string oauth_name = string.Empty;
            string oauth_refresh_token = string.Empty;

            if (Session["oauth_name"] == null || Session["oauth_access_token"] == null ||
                Session["oauth_openid"] == null)
            {
                return "{\"ret\":\"1\", \"msg\":\"出错啦，Access Token已过期或不存在！\"}";
            }
            oauth_name = Session["oauth_name"].ToString();
            oauth_access_token = Session["oauth_access_token"].ToString();
            oauth_openid = Session["oauth_openid"].ToString();
            oauth_refresh_token = Session["oauth_refresh_token"].ToString();

            if (!weixin_helper.check_access_token(oauth_access_token)) //调用access_token前需判断是否过期
            {
                Dictionary<string, object> dic1 = weixin_helper.get_refresh_token(oauth_refresh_token);//如果已过期则重新换取新的access_token
                if (dic1 == null || !dic1.ContainsKey("access_token"))
                {
                    return "{\"openid\":\"0\", \"msg\":\"出错啦，无法获取access_token！\"}";
                }
                oauth_access_token = dic1["access_token"].ToString();
            }

            Dictionary<string, object> dic = weixin_helper.get_user_info(oauth_access_token, oauth_openid);
            if (dic == null)
            {
                return "{\"openid\":\"0\", \"msg\":\"出错啦，无法获取授权用户信息！\"}";
            }
            try
            {
                StringBuilder str = new StringBuilder();
                str.Append("{");
                str.Append("\"openid\": \"" + dic["openid"].ToString() + "\", ");
                str.Append("\"nickname\": \"" + dic["nickname"].ToString() + "\", ");
                str.Append("\"sex\": \"" + dic["sex"].ToString() + "\", ");
                str.Append("\"province\": \"" + dic["province"].ToString() + "\", ");
                str.Append("\"city\": \"" + dic["city"].ToString() + "\", ");
                str.Append("\"country\": \"" + dic["country"].ToString() + "\", ");
                str.Append("\"headimgurl\": \"" + dic["headimgurl"].ToString() + "\", ");
                str.Append("\"privilege\": \"" + dic["privilege"].ToString() + "\", ");
                str.Append("\"unionid\": \"" + dic["unionid"].ToString() + "\",");
                str.Append("\"oauth_name\": \"" + oauth_name + "\",");
                str.Append("\"oauth_access_token\": \"" + oauth_access_token + "\",");
                str.Append("\"oauth_openid\": \"" + oauth_openid + "\"");
                str.Append("}");
                return str.ToString();
            }
            catch
            {
                return "{\"ret\":\"0\", \"msg\":\"出错啦，无法获取授权用户信息！\"}";
            }

        }
    }
}