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
    public class Cars_ActionDAL : ICars_Action
    {
        private EntityControl control;

        public Cars_ActionDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Cars_ActionInfo Cars_Action_)
        {
            control.AddEntity(Cars_Action_);
        }

        public void Update(Cars_ActionInfo Cars_Action_)
        {
            control.UpdateEntity(Cars_Action_, Cars_Action_.id);
        }

        public void Delete(int id)
        {
            Cars_ActionInfo Cars_Action_ = new Cars_ActionInfo();
            Cars_Action_.id = id;
            control.DeleteEntity(Cars_Action_);
        }

        public Cars_ActionInfo GetById(int id)
        {
            return (Cars_ActionInfo)control.GetEntity("WC.Model.Cars_ActionInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Cars_ActionInfo", where, orderBy);
        }
        #endregion
    }
}
