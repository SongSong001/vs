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
    public class PaperDAL : IPaper
    {
        private EntityControl control;

        public PaperDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(PaperInfo Paper_)
        {
            control.AddEntity(Paper_);
        }

        public void Update(PaperInfo Paper_)
        {
            control.UpdateEntity(Paper_, Paper_.id);
        }

        public void Delete(int id)
        {
            PaperInfo Paper_ = new PaperInfo();
            Paper_.id = id;
            control.DeleteEntity(Paper_);
        }

        public PaperInfo GetById(int id)
        {
            return (PaperInfo)control.GetEntity("WC.Model.PaperInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.PaperInfo", where, orderBy);
        }
        #endregion
    }
}
