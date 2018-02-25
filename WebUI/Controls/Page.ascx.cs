using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace WC.WebUI.Controls
{
    public partial class Page : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void css()
        {
            HtmlGenericControl objLink = new HtmlGenericControl("LINK");
            objLink.ID = ID;
            objLink.Attributes["rel"] = "stylesheet";
            objLink.Attributes["type"] = "text/css";
            //objLink.Attributes["href"] = ResolveUrl("page_img/page_css.css");
            objLink.Attributes["href"] = ResolveUrl("/DK_Css/page_css.css");
            this.Controls.Add(objLink);
        }


        /// <summary>
        /// 分页
        /// </summary>
        /// <param name="sty">分页样式：digg,yahoo,yahoo2,meneame,flickr,sabrosus,scott,quotes,black,black2, black-red,grayr,yellow,jogger,starcraft2,tres,megas512,technorati,youtube,msdn,badoo,manu,green-black,viciao</param>
        /// <param name="page">当前页</param>
        /// <param name="pageCount">总页数</param>
        /// <param name="src">链接地址</param>
        /// <returns></returns>
        public void sty(string sty, int page, int pageCount, string src)
        {
            css();
            if (pageCount > 1)
            {
                string page_html = "<div class='" + sty + "'>";

                if (page == 1)//如果当前页为第一页
                {
                    page_html = page_html + "<span class='disabled'>< </span>";
                }
                else
                {
                    page_html = page_html + "<a href='" + src + "1'>< </a>";
                }

                if (pageCount <= 9)// 如果总页数小于9
                {
                    for (int i = 1; i <= pageCount; i++)
                    {
                        if (i != page)
                            page_html = page_html + "<a href='" + src + i.ToString() + "'>" + i + "</a>";
                        else
                            page_html = page_html + "<span class='current'>" + i + "</span>";

                    }
                }
                else
                {
                    if (page <= 4)//如果当前页小于4
                    {
                        for (int i = 1; i < 9; i++)
                        {
                            if (i != page)
                                page_html = page_html + "<a href='" + src + i.ToString() + "'>" + i + "</a>";
                            else
                                page_html = page_html + "<span class='current'>" + i + "</span>";
                        }
                        page_html = page_html + "...<a href='" + src + pageCount.ToString() + "'>" + pageCount + "</a>";
                    }
                    else if (pageCount - page <= 4)//如果当前页是最后5页
                    {
                        page_html = page_html + "<a href='" + src + "1'>1</a>...";
                        for (int i = pageCount - 8; i <= pageCount; i++)
                        {
                            if (i != page)
                                page_html = page_html + "<a href='" + src + i.ToString() + "'>" + i + "</a>";
                            else
                                page_html = page_html + "<span class='current'>" + i + "</span>";
                        }
                    }
                    else
                    {
                        page_html = page_html + "<a href='" + src + "1'>1</a>...";
                        for (int i = page - 3; i <= page + 3; i++)
                        {
                            if (i != page)
                                page_html = page_html + "<a href='" + src + i.ToString() + "'>" + i + "</a>";
                            else
                                page_html = page_html + "<span class='current'>" + i + "</span>";
                        }
                        page_html = page_html + "...<a href='" + src + pageCount.ToString() + "'>" + pageCount + "</a>";
                    }

                }

                if (page == pageCount)//如果是最后一页
                {
                    page_html = page_html + "<span class='disabled'> > </span>";
                }
                else
                {
                    page_html = page_html + "<a href='" + src + pageCount + "'> > </a>";
                }
                page_html = page_html + "</div>";
                this.Parent.Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language=javascript>document.getElementById(\"page_\").innerHTML =\"" + page_html + "\"</script>");
            }
        }

        /// <summary>
        /// 分页重载
        /// </summary>
        /// <param name="sty">分页样式：1,2</param>
        /// <param name="page">当前页</param>
        /// <param name="pageCount">总页数</param>
        /// <param name="src">链接地址</param>
        /// <returns></returns>
        public void sty(int sty, int page, int pageCount, string src)
        {
            css();
            string page_html;
            if (pageCount > 1)
            {
                if (sty == 1)
                {
                    page_html = "<div class='magics'>";
                    if (page == 1)
                    {
                        page_html = page_html + "<span class='disabled'>9</span><span class='current'>3</span>";
                    }
                    else
                    {
                        page_html = page_html + "<a href='" + src + "1'>9</a><a href='" + src + (page - 1) + "'>3</a>";
                    }
                    if (page == pageCount)
                    {
                        page_html = page_html + "<span class='current'>4</span><span class='disabled'>:</span>";
                    }
                    else
                    {
                        page_html = page_html + "<a href='" + src + (page + 1) + "'>4</a><a href='" + src + pageCount.ToString() + "'>:</a>";
                    }
                }
                else
                {
                    page_html = "<div class='magics1'>";
                    if (page == 1)
                    {
                        page_html = page_html + "<span class='disabled'>首&nbsp;&nbsp;页</span><span class='current'>上一页</span>";
                    }
                    else
                    {
                        page_html = page_html + "<a href='" + src + "1'>首&nbsp;&nbsp;页</a><a href='#?page=" + (page - 1) + "'>上一页</a>";
                    }
                    if (page == pageCount)
                    {
                        page_html = page_html + "<span class='current'>下一页</span><span class='disabled'>末&nbsp;&nbsp;页</span>";
                    }
                    else
                    {
                        page_html = page_html + "<a href='" + src + (page + 1) + "'>下一页</a><a href='" + src + pageCount.ToString() + "'>末&nbsp;&nbsp;页</a>";
                    }

                }
                page_html = page_html + "<select name='topage' onchange=javascript:window.location='" + src + "'+this.options[this.selectedIndex].value; class='dropdown' id='topage'>";
                for (int i = 1; i <= pageCount; i++)
                {
                    if (i != page)
                        page_html = page_html + "<option value='" + i + "'>" + i + "</option>";
                    else
                        page_html = page_html + "<option value='" + i + "' selected>" + i + "</option>";
                }
                page_html = page_html + "</select></div>";
                this.Parent.Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language=javascript>document.getElementById(\"page_\").innerHTML =\"" + page_html + "\"</script>");
            }
        }

    }
}