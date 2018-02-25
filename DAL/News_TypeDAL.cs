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
    public class News_TypeDAL : INews_Type
    {
        private EntityControl control;

        public News_TypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(News_TypeInfo News_Type_)
        {
            control.AddEntity(News_Type_);
        }

        public void Update(News_TypeInfo News_Type_)
        {
            control.UpdateEntity(News_Type_, News_Type_.id);
        }

        public void Delete(int id)
        {
            News_TypeInfo News_Type_ = new News_TypeInfo();
            News_Type_.id = id;
            control.DeleteEntity(News_Type_);
        }

        public News_TypeInfo GetById(int id)
        {
            return (News_TypeInfo)control.GetEntity("WC.Model.News_TypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.News_TypeInfo", where, orderBy);
        }
        #endregion
    }
}
