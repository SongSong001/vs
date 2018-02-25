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
    public class Flows_ModelFileDAL : IFlows_ModelFile
    {
        private EntityControl control;

        public Flows_ModelFileDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_ModelFileInfo Flows_ModelFile_)
        {
            control.AddEntity(Flows_ModelFile_);
        }

        public void Update(Flows_ModelFileInfo Flows_ModelFile_)
        {
            control.UpdateEntity(Flows_ModelFile_, Flows_ModelFile_.id);
        }

        public void Delete(int id)
        {
            Flows_ModelFileInfo Flows_ModelFile_ = new Flows_ModelFileInfo();
            Flows_ModelFile_.id = id;
            control.DeleteEntity(Flows_ModelFile_);
        }

        public Flows_ModelFileInfo GetById(int id)
        {
            return (Flows_ModelFileInfo)control.GetEntity("WC.Model.Flows_ModelFileInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_ModelFileInfo", where, orderBy);
        }
        #endregion
    }
}
