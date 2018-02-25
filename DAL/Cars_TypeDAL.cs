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
    public class Cars_TypeDAL : ICars_Type
    {
        private EntityControl control;

        public Cars_TypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Cars_TypeInfo Cars_Type_)
        {
            control.AddEntity(Cars_Type_);
        }

        public void Update(Cars_TypeInfo Cars_Type_)
        {
            control.UpdateEntity(Cars_Type_, Cars_Type_.id);
        }

        public void Delete(int id)
        {
            Cars_TypeInfo Cars_Type_ = new Cars_TypeInfo();
            Cars_Type_.id = id;
            control.DeleteEntity(Cars_Type_);
        }

        public Cars_TypeInfo GetById(int id)
        {
            return (Cars_TypeInfo)control.GetEntity("WC.Model.Cars_TypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Cars_TypeInfo", where, orderBy);
        }
        #endregion
    }
}
