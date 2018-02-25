using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;

namespace WC.WebUI.Manage.Sys
{
    public partial class User_Manage : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<Sys_DepInfo> li = new List<Sys_DepInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));
                if (ui.RoleID == 4)
                {
                    RoleID.Visible = true;
                }
                else RoleID.Visible = false;

                InitData();
                if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
                {
                    Show(Request.QueryString["uid"]);
                }

            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                Sys_UserInfo sui = ViewState["su"] as Sys_UserInfo;
                if (PassWord.Value.Trim() != "")
                {
                    sui.PassWord = WC.Tool.Encrypt.MD5_32(PassWord.Value.Trim().ToLower());
                }
                sui.RealName = URealName.Value;
                sui.Sex = Convert.ToInt32(Sex1.SelectedValue);
                sui.Birthday = Birthday.Value;
                sui.Phone = Phone.Value;
                sui.RoleID = Convert.ToInt32(RoleID.SelectedValue);
                sui.DepID = Convert.ToInt32(parentID.SelectedValue);
                sui.DepName = ClearLeaf(parentID.Items[parentID.SelectedIndex].Text);
                sui.Status = Convert.ToInt32(Status1.SelectedValue);
                sui.IsLock = Convert.ToInt32(IsLock.Checked);
                sui.Notes = Notes.Value;
                sui.Tel = Tel.Value;
                sui.QQ = QQ.Value;
                sui.Email = Email.Value;

                //sui.DirectSupervisor = Convert.ToInt32(Request.Form["DirectSupervisor"]);
                sui.HomeAddress = HomeAddress.Value;
                sui.PositionName = PositionName.Value;
                sui.JoinTime = JoinTime.Value;

                sui.MsgTime = Convert.ToInt32(RoleGUID.SelectedValue);
                sui.MemoShare = Convert.ToInt32(MemoShare.Checked);
                sui.Orders = Convert.ToInt32(Orders.Value);
                sui.DepGUID = DepGuid.SelectedValue;

                if (Fup.HasFile)
                {
                    FileExtension[] fe = { FileExtension.GIF, FileExtension.JPG, FileExtension.PNG,FileExtension.BMP };
                    if (FileSystemManager.IsAllowedExtension(Fup, fe)) //头字节过滤非法图片 
                    {
                        string name = sui.UserName;
                        string doc = Server.MapPath("~/Files/common/");
                        string fileName = name + Path.GetExtension(Fup.FileName);
                        doc += fileName;
                        Fup.PostedFile.SaveAs(doc);
                        sui.PerPic = fileName;
                        Fup.Dispose();
                    }
                }

                sui.et4 = UpdateFiles();
                sui.et6 = userlist.Value;
                sui.et5 = namelist.Value;

                Sys_User.Init().Update(sui);

                //IM用户数据更新
                WC.WebUI.Dk.Help.UpdateIMUser(sui);

                string words = HttpContext.Current.Server.HtmlEncode("您好!员工已编辑成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                if (IsNewUsername(UUserName.Value.Trim().ToLower()))
                {
                    Sys_UserInfo sui = new Sys_UserInfo();
                    sui.UserName = UUserName.Value.ToLower();
                    sui.PassWord = WC.Tool.Encrypt.MD5_32(PassWord.Value.Trim().ToLower());
                    sui.RealName = URealName.Value;
                    sui.Sex = Convert.ToInt32(Sex1.SelectedValue);
                    sui.Birthday = Birthday.Value;
                    sui.Phone = Phone.Value;
                    sui.RoleID = Convert.ToInt32(RoleID.SelectedValue);
                    sui.DepID = Convert.ToInt32(parentID.SelectedValue);
                    sui.DepName = ClearLeaf(parentID.Items[parentID.SelectedIndex].Text);
                    sui.Status = Convert.ToInt32(Status1.SelectedValue);
                    sui.IsLock = Convert.ToInt32(IsLock.Checked);
                    sui.RegFromIp = RequestUtils.GetIP();
                    sui.Notes = Notes.Value;
                    sui.LastLoginTime = DateTime.Now;
                    sui.RegTime = DateTime.Now;
                    sui.Tel = Tel.Value;
                    sui.QQ = QQ.Value;
                    sui.Email = Email.Value;
                    sui.MsgTime = 10;

                    //sui.DirectSupervisor = Convert.ToInt32(Request.Form["DirectSupervisor"]);
                    sui.HomeAddress = HomeAddress.Value;
                    sui.PositionName = PositionName.Value;
                    sui.JoinTime = JoinTime.Value;

                    sui.MsgTime = Convert.ToInt32(RoleGUID.SelectedValue);
                    sui.MemoShare = Convert.ToInt32(MemoShare.Checked);
                    sui.Orders = Convert.ToInt32(Orders.Value);
                    sui.DepGUID = DepGuid.SelectedValue;

                    if (Fup.HasFile)
                    {
                        FileExtension[] fe = { FileExtension.GIF, FileExtension.JPG, FileExtension.PNG, FileExtension.BMP };
                        if (FileSystemManager.IsAllowedExtension(Fup, fe)) //头字节过滤非法图片 
                        {
                            string name = sui.UserName;
                            string doc = Server.MapPath("~/Files/common/");
                            string fileName = name + Path.GetExtension(Fup.FileName);
                            doc += fileName;
                            Fup.PostedFile.SaveAs(doc);
                            sui.ComGUID = fileName;
                            Fup.Dispose();
                        }
                    }

                    sui.et4 = UpdateFiles();
                    sui.et6 = userlist.Value;
                    sui.et5 = namelist.Value;

                    Sys_User.Init().Add(sui);

                    //IM用户数据更新
                    WC.WebUI.Dk.Help.UpdateIMUser(sui);

                    string title = "[系统通知] : " + sui.RealName + ", 您好! 您的系统账号已开通, 欢迎使用本系统!";
                    string content = "恭喜您! 您的系统账号已开通! <br><br>您的用户名：" + sui.UserName + " <br>您可以更改初始密码！如果您有其他疑问 请和系统管理员联系。<br>";
                    int rid = sui.id;
                    string ulist = sui.RealName + "#" + sui.id + "#" + sui.DepName + ",";
                    string nlist = sui.RealName + "(" + sui.DepName + "),";
                    WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, ulist, nlist);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!员工已添加成功!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
                else
                {
                    Response.Write("<script>alert('该用户名已被占用!请另外选择');window.location='User_Manage.aspx'</script>");
                }
            }
        }

        private void InitData()
        {
            IList list = Sys_Role.Init().GetAll(null, "order by id desc");
            RoleID.DataSource = list;
            RoleID.DataTextField = "RoleName";
            RoleID.DataValueField = "id";
            RoleID.DataBind();

            GetFirtNode();
            parentID.DataSource = li;
            parentID.DataTextField = "Sh";
            parentID.DataValueField = "ID";
            parentID.DataBind();

            //IList userlist = Sys_User.Init().GetAll(null, "order by depid asc,orders asc");
            //DirectSupervisor.Items.Add(new ListItem("请选择 上司领导", "0"));

            //for (int i = 0; i < userlist.Count; i++)
            //{
            //    Sys_UserInfo ui = userlist[i] as Sys_UserInfo;
            //    DirectSupervisor.Items.Add(new ListItem(ui.RealName + " (" + ui.DepName + ")", ui.id + ""));

            //}

        }



        private void Show(string uid)
        {
            UUserName.Attributes.Add("readonly", "readonly");

            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(uid));
            ViewState["su"] = su;
            UUserName.Value = su.UserName;
            PassWord.Value = su.PassWord;
            PassWord2.Value = su.PassWord;
            URealName.Value = su.RealName;
            Sex1.SelectedValue = su.Sex + "";
            Birthday.Value = su.Birthday;
            Phone.Value = su.Phone;
            RoleID.SelectedValue = su.RoleID + "";
            parentID.SelectedValue = su.DepID + "";
            Status1.SelectedValue = su.Status + "";
            IsLock.Checked = Convert.ToBoolean(su.IsLock);
            Notes.Value = su.Notes;
            Tel.Value = su.Tel;
            JoinTime.Value = su.JoinTime;
            HomeAddress.Value = su.HomeAddress;
            PositionName.Value = su.PositionName;
            Email.Value = su.Email;
            QQ.Value = su.QQ;
            Orders.Value = su.Orders + "";

            RoleGUID.SelectedValue = su.MsgTime + "";
            MemoShare.Checked = Convert.ToBoolean(su.MemoShare);

            //if (su.DirectSupervisor!=0)
            //{
            //    DirectSupervisor.SelectedValue = su.DirectSupervisor+"";
            //}

            userlist.Value = su.et6;
            namelist.Value = su.et5;

            if (su.DepGUID == "no")
                DepGuid.SelectedValue = "no";

            if (!string.IsNullOrEmpty(su.et4))
            {
                if (su.et4.Contains("|"))
                {
                    Attachword.Visible = true;
                    List<TmpInfo> list = new List<TmpInfo>();
                    string[] array = su.et4.Split('|');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Trim() != "")
                        {
                            TmpInfo ti = new TmpInfo();
                            int t = array[i].LastIndexOf('/') + 1;
                            string filename = array[i].Substring(t, array[i].Length - t);
                            string fileurl = array[i].ToString();
                            ti.Tmp1 = array[i];
                            ti.Tmp2 = filename;
                            ti.Tmp3 = fileurl;
                            list.Add(ti);
                        }
                    }
                    rpt.DataSource = list;
                    rpt.DataBind();
                }
            }

        }

        private bool IsNewUsername(string username)
        {
            IList list = Sys_User.Init().GetAll("UserName='" + username + "'", null);
            if (list.Count == 0)
                return true;
            else return false;
        }

        private string ClearLeaf(string text)
        {
            string[] array = { "　", "└", "├", "│", "└" };
            for (int i = 0; i < array.Length; i++)
            {
                if (text.Contains(array[i]))
                    text = text.Replace(array[i], "");
            }
            return text.Trim();
        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/DocsFiles/");
            string tmp = "~/Files/DocsFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/DocsFiles"));
            }

            try
            {
                string old = "";
                if (Attachword.Visible == true)
                {
                    foreach (RepeaterItem item in rpt.Items)
                    {
                        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                        if (hick.Checked)
                        {
                            old += hick.Value + "|";
                        }
                    }
                }

                for (int i = 0; i < files.Count; i++)
                {
                    System.Web.HttpPostedFile f = files[i];
                    if (WC.Tool.Config.IsValidFile(f))
                    {
                        string fileName = Path.GetFileName(f.FileName);
                        string name = tmp + fileName;
                        string doc = path + "\\" + fileName;
                        if (File.Exists(doc))
                        {
                            string rd = DateTime.Now.ToString("HHmmssfff") + WC.Tool.Utils.CreateRandomStr(3) + Uid + i;
                            doc = path + "\\" + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                            name = tmp + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                        }

                        f.SaveAs(doc);
                        fnames += name + "|";
                    }
                }
                fnames = old + fnames;

            }
            catch (IOException ex)
            {
                throw ex;
            }

            return fnames;
        }

        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Sys_Dep", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Sys_DepInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "";
                    cl.Sh = cl.DepName; //第一行只显示FolderName
                    li.Add(cl); //头节点第一个入list

                    PopulateSubTree(dbRow, i); //从头节点开始递归查找子树
                }
            }
        }

        //递归遍历子树 排序并放入list
        private void PopulateSubTree(DataRow dbRow, int depth)
        {
            ++depth; //树深度
            //foreach(DataRow ChildRow in dbRow.GetChildRows("sort"))
            //{     
            //}
            DataRow[] dr = dbRow.GetChildRows("sort"); //获取子树数组

            #region 选择排序 按照Px
            int k; // 存放最小FolderOrder的 下标
            int j; //遍历数组次数
            object tmp; //临时交换的DataRow
            for (int i = 0; i < dr.Length - 1; i++)
            {
                for (k = i, j = i + 1; j < dr.Length; j++) // 找出最小FolderOrder的 下标
                {
                    if (Convert.ToInt32(dr[k]["Orders"]) > Convert.ToInt32(dr[j]["Orders"]))
                    {
                        k = j;
                    }
                }
                if (k != i) //交换位置
                {
                    tmp = dr[i];
                    dr[i] = dr[k];
                    dr[k] = (DataRow)tmp;
                }
            }
            #endregion

            //对数组中已排序的 每一节点进行操作
            foreach (DataRow item in dr)
            {
                Sys_DepInfo cl = SetPram(item);
                if (depth == 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        cl.Ch = "　└ ";
                    }
                    else cl.Ch = "　├ ";
                }
                else if (depth > 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　└ ";
                    }
                    else
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　├ ";
                    }
                }
                cl.Sh = cl.Ch + cl.DepName;
                li.Add(cl); //子节点入list
                PopulateSubTree(item, depth); //递归操作子树
            }
        }

        private Sys_DepInfo SetPram(DataRow dbRow)
        {
            Sys_DepInfo biz = new Sys_DepInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.DepName = Convert.ToString(dbRow["DepName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);
            biz.IsPosition = Convert.ToInt32(dbRow["IsPosition"]);
            return biz;
        }

        #endregion
    }
}
