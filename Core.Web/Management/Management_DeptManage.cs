using Core;
using System;
using System.Collections;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public class Management_DeptManage : Page
{
    private CommandCtrl _cmdCtrl;
    private string filter = "";
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='name'>{0}</td>\r\n\t\t<td class='nickname'>{1}</td>\r\n        <td class='index'>{2}</td>\r\n\t\t<td class='operation'>{3}  {4}  {5}</td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            if (command == "NewDept")
            {
                Hashtable info = data as Hashtable;
                string dname = info["Name"] as string;
                long pdid = Convert.ToInt64(info["Pdid"]);
                long cindex = Convert.ToInt64(info["CIndex"]);
                OrganizationImpl.Instance.AddDept(dname, pdid, cindex);
            }
            else if (command == "Delete")
            {
                long did = Convert.ToInt64(data);
                OrganizationImpl.Instance.DeleteDept(did);
            }
            else if (command == "Search")
            {
                this.filter = data.ToString();
            }
        }
        catch (Exception ex)
        {
            this._cmdCtrl.State["Action"] = "Error";
            this._cmdCtrl.State["Exception"] = ex;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this._cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this._cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        if (!base.IsPostBack)
        {
            DropDownList drpParent = this.FindControl("drpParentDept") as DropDownList;
            drpParent.Items.Clear();
            DataTable dt = OrganizationImpl.Instance.GetDeptList("");
            DataRow nrow = dt.NewRow();
            nrow["id"] = "0";
            nrow["depname"] = "";
            dt.Rows.InsertAt(nrow, 0);
            dt.AcceptChanges();
            drpParent.DataSource = dt;
            drpParent.DataTextField = "depname";
            drpParent.DataValueField = "id";
            drpParent.DataBind();
        }
    }

    protected string RenderDeptList()
    {
        StringBuilder builder = new StringBuilder();
        foreach (DataRow row in OrganizationImpl.Instance.GetDeptList("").Rows)
        {
            if (row != null)
            {
                builder.AppendFormat(RowFormat, new object[] { HtmlUtil.ReplaceHtml(row["depname"].ToString()), HtmlUtil.ReplaceHtml(row["parentid"].ToString()), HtmlUtil.ReplaceHtml(row["orders"].ToString()), string.Format("<a href='javascript:Update(\"{0}\")'>修改</a>", row["id"]), string.Format("<a href='javascript:ManageDeptMember(\"{0}\")'>管理成员</a>", row["id"]), string.Format("<a href='javascript:Delete(\"{0}\",\"{0}\")'>删除</a>", row["id"], row["depname"]) });
            }
        }
        return builder.ToString();
    }
}

