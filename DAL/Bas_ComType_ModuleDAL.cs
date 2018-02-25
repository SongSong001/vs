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
    public class Bas_ComType_ModuleDAL : IBas_ComType_Module
    {
        private EntityControl control;

        public Bas_ComType_ModuleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Bas_ComType_ModuleInfo Bas_ComType_Module_)
        {
            control.AddEntity(Bas_ComType_Module_);
        }

        public void Update(Bas_ComType_ModuleInfo Bas_ComType_Module_)
        {
            control.UpdateEntity(Bas_ComType_Module_, Bas_ComType_Module_.id);
        }

        public void Delete(int id)
        {
            Bas_ComType_ModuleInfo Bas_ComType_Module_ = new Bas_ComType_ModuleInfo();
            Bas_ComType_Module_.id = id;
            control.DeleteEntity(Bas_ComType_Module_);
        }

        public Bas_ComType_ModuleInfo GetById(int id)
        {
            return (Bas_ComType_ModuleInfo)control.GetEntity("WC.Model.Bas_ComType_ModuleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Bas_ComType_ModuleInfo", where, orderBy);
        }
        #endregion
    }
}
