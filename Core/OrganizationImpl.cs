namespace Core
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Reflection;

    public class OrganizationImpl
    {
        private static OrganizationImpl m_Instance = new OrganizationImpl();
        private IOrganizationStorage m_IOrganizationStorage = null;

        private OrganizationImpl()
        {
            this.Init();
        }

        public void AddDept(string name, long pdid, long cindex)
        {
            this.m_IOrganizationStorage.AddDept(name, pdid, cindex);
        }

        public void DeleteDept(long did)
        {
            this.m_IOrganizationStorage.DeleteDept(did);
        }

        public string GetAllDepts()
        {
            DataTable dt = this.m_IOrganizationStorage.GetAllDepts();
            if (dt.Rows.Count > 0)
            {
                return Utility.DataTableToJSON(dt, "Depts");
            }
            return Utility.RenderHashJson(new object[] { "Depts", "" });
        }

        public DataTable GetCompanyInfo()
        {
            return this.m_IOrganizationStorage.GetCompanyInfo();
        }

        public DataRowCollection GetDeptAllUser(string deptId)
        {
            return this.m_IOrganizationStorage.GetDeptAllUser(deptId);
        }

        public DataTable GetDeptById(long did)
        {
            return this.m_IOrganizationStorage.GetDeptById(did);
        }

        public DataTable GetDeptList(string filter)
        {
            return this.m_IOrganizationStorage.GetDeptList(filter);
        }

        public List<AccountInfo.Details> GetDeptsFirends()
        {
            List<AccountInfo.Details> list = new List<AccountInfo.Details>();
            foreach (DataRow userInfo in this.m_IOrganizationStorage.GetDepts())
            {
                AccountInfo info = new AccountInfo(userInfo["Name"] as string, userInfo["NickName"] as string, Convert.ToInt64(userInfo["uid"]), Convert.ToInt64(userInfo["Type"]), null, null, null, null, userInfo["EMail"] as string, userInfo["InviteCode"] as string, Convert.ToInt64(userInfo["AcceptStrangerIM"]) != 0, Convert.ToInt64(userInfo["MsgFileLimit"]), Convert.ToInt64(userInfo["MsgImageLimit"]), Convert.ToInt64(userInfo["DiskSize"]), Convert.ToInt64(userInfo["IsTemp"]), (DateTime) userInfo["RegisterTime"], userInfo["HomePage"] as string, userInfo["Password"] as string, userInfo);
                list.Add(info.DetailsJson);
            }
            return list;
        }

        public DataTable GetUsersByDeptId(long did)
        {
            return this.m_IOrganizationStorage.GetUsersByDeptId(did);
        }

        public DataTable GetUsersByNoExistsDept(long did)
        {
            return this.m_IOrganizationStorage.GetUsersByNoExistsDept(did);
        }

        public void Init()
        {
            string[] accStorageInfo = Utility.GetConfig().AppSettings.Settings["OrganizationStorageImpl"].Value.Split(new char[] { ' ' });
            ConstructorInfo ctor = Assembly.Load(accStorageInfo[0]).GetType(accStorageInfo[1]).GetConstructor(new Type[0]);
            this.m_IOrganizationStorage = ctor.Invoke(new object[0]) as IOrganizationStorage;
        }

        public void UpdateCompanyInfo(string id, string name, string tel, string address, string logo)
        {
            this.m_IOrganizationStorage.UpdateCompanyInfo(id, name, tel, address, logo);
        }

        public void UpdateDept(long did, string name, long pdid, long cindex)
        {
            this.m_IOrganizationStorage.UpdateDept(did, name, pdid, cindex);
        }

        public void UpdateDeptMember(string ids, long did)
        {
            this.m_IOrganizationStorage.UpdateDeptMember(ids, did);
        }

        public static OrganizationImpl Instance
        {
            get
            {
                return m_Instance;
            }
        }
    }
}

