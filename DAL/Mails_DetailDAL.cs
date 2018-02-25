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
    public class Mails_DetailDAL : IMails_Detail
    {
        private EntityControl control;

        public Mails_DetailDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Mails_DetailInfo Mails_Detail_)
        {
            control.AddEntity(Mails_Detail_);
        }

        public void Update(Mails_DetailInfo Mails_Detail_)
        {
            control.UpdateEntity(Mails_Detail_, Mails_Detail_.id);
        }

        public void Delete(int id)
        {
            Mails_DetailInfo Mails_Detail_ = new Mails_DetailInfo();
            Mails_Detail_.id = id;
            control.DeleteEntity(Mails_Detail_);
        }

        public Mails_DetailInfo GetById(int id)
        {
            return (Mails_DetailInfo)control.GetEntity("WC.Model.Mails_DetailInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Mails_DetailInfo", where, orderBy);
        }
        #endregion
    }
}
