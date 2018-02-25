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
    public class Gov_ModelFileDAL : IGov_ModelFile
    {
        private EntityControl control;

        public Gov_ModelFileDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_ModelFileInfo Gov_ModelFile_)
        {
            control.AddEntity(Gov_ModelFile_);
        }

        public void Update(Gov_ModelFileInfo Gov_ModelFile_)
        {
            control.UpdateEntity(Gov_ModelFile_, Gov_ModelFile_.id);
        }

        public void Delete(int id)
        {
            Gov_ModelFileInfo Gov_ModelFile_ = new Gov_ModelFileInfo();
            Gov_ModelFile_.id = id;
            control.DeleteEntity(Gov_ModelFile_);
        }

        public Gov_ModelFileInfo GetById(int id)
        {
            return (Gov_ModelFileInfo)control.GetEntity("WC.Model.Gov_ModelFileInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_ModelFileInfo", where, orderBy);
        }
        #endregion
    }
}
