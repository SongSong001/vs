using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

namespace WC.WebUI.Manage.Paper
{
    public partial class PaperManage : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<PaperTypeInfo> li = new List<PaperTypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            GetFirtNode();
            TypeID.DataSource = li;
            TypeID.DataTextField = "Sh";
            TypeID.DataValueField = "ID";
            TypeID.DataBind();

            if (!string.IsNullOrEmpty(Request.QueryString["pid"]))
            {
                PaperInfo na = WC.BLL.Paper.Init().GetById(Convert.ToInt32(Request.QueryString["pid"]));
                //ViewState["na"] = na;
                TypeID.SelectedValue = na.TypeID + "";

                PaperName.Value = na.PaperName;
                Notes.Value = na.Notes;
                //PaperNO.Value = na.PaperNO;
                SendDep.Value = na.SendDep;
                PaperSymbol.Value = na.PaperSymbol;
                //PaperKind.Value = na.PaperKind;
                PaperGrade.Value = na.PaperGrade;
                //PaperUrgency.Value = na.PaperUrgency;
                PaperDate.Value = na.PaperDate;

                if (na.ShareDeps != "")
                {
                    sel.SelectedIndex = 1;
                    tr.Attributes["style"] = "";
                    userlist_dep.Value = na.ShareDeps;
                    namelist_dep.Value = na.namelist;
                }
                TypeID.SelectedValue = na.TypeID + "";

                if (!string.IsNullOrEmpty(na.FilePath))
                {
                    if (na.FilePath.Contains("|"))
                    {
                        Attachword.Visible = true;
                        List<TmpInfo> list = new List<TmpInfo>();
                        string[] array = na.FilePath.Split('|');
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

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["pid"]))
            {
                PaperInfo na = WC.BLL.Paper.Init().GetById(Convert.ToInt32(Request.QueryString["pid"]));
                na.FilePath = UpdateFiles();

                na.PaperName = PaperName.Value;
                na.Notes = Notes.Value;
                //na.PaperNO = PaperNO.Value;
                na.SendDep = SendDep.Value;
                na.PaperSymbol = PaperSymbol.Value;
                //na.PaperKind = PaperKind.Value;
                na.PaperGrade = PaperGrade.Value;
                //na.PaperUrgency = PaperUrgency.Value;
                na.PaperDate = PaperDate.Value;

                na.ShareDeps = userlist_dep.Value.Trim();
                na.namelist = namelist_dep.Value;
                na.TypeID = Convert.ToInt32(Request.Form["TypeID"]);
                na.AddTime = DateTime.Now.ToString("yyyy-MM-dd");
                na.CreatorID = Convert.ToInt32(Uid);
                na.CreatorRealName = RealName;
                na.CreatorDepName = DepName;
                WC.BLL.Paper.Init().Update(na);
            }
            else
            {
                PaperInfo na = new PaperInfo();
                na.FilePath = UpdateFiles();

                na.PaperName = PaperName.Value;
                na.Notes = Notes.Value;
                //na.PaperNO = PaperNO.Value;
                na.SendDep = SendDep.Value;
                na.PaperSymbol = PaperSymbol.Value;
                //na.PaperKind = PaperKind.Value;
                na.PaperGrade = PaperGrade.Value;
                //na.PaperUrgency = PaperUrgency.Value;
                na.PaperDate = PaperDate.Value;

                na.ShareDeps = userlist_dep.Value.Trim();
                na.namelist = namelist_dep.Value;
                na.TypeID = Convert.ToInt32(Request.Form["TypeID"]);
                na.AddTime = DateTime.Now.ToString("yyyy-MM-dd");
                na.CreatorID = Convert.ToInt32(Uid);
                na.CreatorRealName = RealName;
                na.CreatorDepName = DepName;
                WC.BLL.Paper.Init().Add(na);

            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!电子档案已编辑成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);

        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/NewsFiles/");
            string tmp = "~/Files/NewsFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/NewsFiles"));
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
                            string rd = DateTime.Now.ToString("HHmmssfff") + WC.Tool.Utils.CreateRandomStr(5) + Uid + i;
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
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from PaperType", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    PaperTypeInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "";
                    cl.Sh = cl.TypeName; //第一行只显示FolderName
                    li.Add(cl); //头节点第一个入list

                    PopulateSubTree(dbRow, i); //从头节点开始递归查找子树
                }
            }
        }

        //递归遍历子树 排序并放入list
        private void PopulateSubTree(DataRow dbRow, int depth)
        {
            ++depth; //树深度
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
                PaperTypeInfo cl = SetPram(item);
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
                cl.Sh = cl.Ch + cl.TypeName;
                li.Add(cl); //子节点入list
                PopulateSubTree(item, depth); //递归操作子树
            }
        }

        private PaperTypeInfo SetPram(DataRow dbRow)
        {
            PaperTypeInfo biz = new PaperTypeInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.TypeName = Convert.ToString(dbRow["TypeName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);
            return biz;
        }

        #endregion

    }
}