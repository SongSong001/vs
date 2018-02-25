using Core;
using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public class Management_DeptEdit : Page
{
    private CommandCtrl _cmdCtrl;

    private void BindData()
    {
        long did = Convert.ToInt64(base.Request.QueryString["did"]);
        DataTable dt = OrganizationImpl.Instance.GetDeptById(did);
        if ((dt != null) && (dt.Rows.Count > 0))
        {
            DataRow row = dt.Rows[0];
            ((TextBox) this.FindControl("txtName")).Text = row["depname"].ToString();
            ((TextBox) this.FindControl("txtId")).Text = row["id"].ToString();
            ((DropDownList)this.FindControl("drpParentDept")).SelectedValue = row["parentid"].ToString();
            ((TextBox) this.FindControl("txtCIndex")).Text = row["orders"].ToString();
        }
    }

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            if (command == "Update")
            {
                Hashtable info = data as Hashtable;
                string dname = info["Name"] as string;
                long pdid = Convert.ToInt64(info["Pdid"]);
                long did = Convert.ToInt64(info["Did"]);
                long cindex = Convert.ToInt64(info["CIndex"]);
                OrganizationImpl.Instance.UpdateDept(did, dname, pdid, cindex);
                this._cmdCtrl.State["Action"] = "Close";
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
            DataTable dt = OrganizationImpl.Instance.GetDeptList(" and a.id<>" + base.Request.QueryString["did"]);
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
        this.BindData();
    }
}

