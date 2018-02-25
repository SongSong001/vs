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
    public class PaperTypeDAL : IPaperType
    {
        private EntityControl control;

        public PaperTypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(PaperTypeInfo PaperType_)
        {
            control.AddEntity(PaperType_);
        }

        public void Update(PaperTypeInfo PaperType_)
        {
            control.UpdateEntity(PaperType_, PaperType_.id);
        }

        public void Delete(int id)
        {
            PaperTypeInfo PaperType_ = new PaperTypeInfo();
            PaperType_.id = id;
            control.DeleteEntity(PaperType_);
        }

        public PaperTypeInfo GetById(int id)
        {
            return (PaperTypeInfo)control.GetEntity("WC.Model.PaperTypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.PaperTypeInfo", where, orderBy);
        }
        #endregion
    }
}
