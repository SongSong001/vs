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
    public class MailsDAL : IMails
    {
        private EntityControl control;

        public MailsDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(MailsInfo Mails_)
        {
            control.AddEntity(Mails_);
        }

        public void Update(MailsInfo Mails_)
        {
            control.UpdateEntity(Mails_, Mails_.id);
        }

        public void Delete(int id)
        {
            MailsInfo Mails_ = new MailsInfo();
            Mails_.id = id;
            control.DeleteEntity(Mails_);
        }

        public MailsInfo GetById(int id)
        {
            return (MailsInfo)control.GetEntity("WC.Model.MailsInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.MailsInfo", where, orderBy);
        }
        #endregion
    }
}
