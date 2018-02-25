using Core;
using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public class Management_DeptEmpManage : Page
{
    private CommandCtrl cmdCtrl;

    private void BindListLeft(long did)
    {
        ListBox lbLeft = this.FindControl("lbLeft") as ListBox;
        lbLeft.Items.Clear();
        DataTable dt = OrganizationImpl.Instance.GetUsersByNoExistsDept(did);
        foreach (DataRow row in dt.Rows)
        {
            if (row["Name"].ToString().ToUpper() != "MANAGER")
            {
                lbLeft.Items.Add(new ListItem(row["nickname"].ToString() + "(" + row["name"].ToString() + ")", row["key"].ToString()));
            }
        }
    }

    private void BindListRight(long did)
    {
        ListBox lbRight = this.FindControl("lbRight") as ListBox;
        lbRight.Items.Clear();
        DataTable dt = OrganizationImpl.Instance.GetUsersByDeptId(did);
        foreach (DataRow row in dt.Rows)
        {
            if (row["Name"].ToString().ToUpper() != "MANAGER")
            {
                lbRight.Items.Add(new ListItem(row["nickname"].ToString() + "(" + row["name"].ToString() + ")", row["key"].ToString()));
            }
        }
    }

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            long did = Convert.ToInt64(base.Request.QueryString["did"]);
            if (command == "AddMemberToDept")
            {
                string member = "";
                Hashtable haperr = (Hashtable) Utility.ParseJson(data.ToString());
                if (haperr != null)
                {
                    foreach (Hashtable peer in (object[]) haperr["Members"])
                    {
                        member = member + ((member == "") ? "" : ",") + peer["Id"].ToString();
                    }
                }
                if (member != "")
                {
                    OrganizationImpl.Instance.UpdateDeptMember(member, did);
                }
                this.cmdCtrl.State["Action"] = "Close";
            }
            if (command == "RefreshMember")
            {
                this.cmdCtrl.State["Action"] = "RefreshFriendsList";
            }
        }
        catch (Exception ex)
        {
            this.cmdCtrl.State["Action"] = "Error";
            this.cmdCtrl.State["Exception"] = ex;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this.cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        long did = Convert.ToInt64(base.Request.QueryString["did"]);
        this.cmdCtrl.State["Action"] = null;
        ListBox lbLeft = this.FindControl("lbLeft") as ListBox;
        ListBox lbRight = this.FindControl("lbRight") as ListBox;
        lbLeft.Attributes.Add("ondblclick", "AddItem()");
        lbRight.Attributes.Add("ondblclick", "DelItem()");
        lbLeft.Items.Clear();
        lbRight.Items.Clear();
        this.BindListLeft(did);
        this.BindListRight(did);
    }
}

