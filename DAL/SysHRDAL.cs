using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using WC.Common;
using WC.Model;
using WC.DBUtility;
using WC.IDAL;
using WC.Tool;

namespace WC.DAL
{
    public class SysHRDAL : ISysHR
    {
        private EntityControl control;

        public SysHRDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(SysHRInfo SysHR_)
        {
            control.AddEntity(SysHR_);
        }

        public void Update(SysHRInfo SysHR_)
        {
            control.UpdateEntity(SysHR_, SysHR_.id);
        }

        public void Delete(int id)
        {
            SysHRInfo SysHR_ = new SysHRInfo();
            SysHR_.id = id;
            control.DeleteEntity(SysHR_);
        }

        public SysHRInfo GetById(int id)
        {
            return (SysHRInfo)control.GetEntity("WC.Model.SysHRInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.SysHRInfo", where, orderBy);
        }
        #endregion
    }
}
