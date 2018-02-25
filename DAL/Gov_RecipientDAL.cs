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
    public class Gov_RecipientDAL : IGov_Recipient
    {
        private EntityControl control;

        public Gov_RecipientDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_RecipientInfo Gov_Recipient_)
        {
            control.AddEntity(Gov_Recipient_);
        }

        public void Update(Gov_RecipientInfo Gov_Recipient_)
        {
            control.UpdateEntity(Gov_Recipient_, Gov_Recipient_.id);
        }

        public void Delete(int id)
        {
            Gov_RecipientInfo Gov_Recipient_ = new Gov_RecipientInfo();
            Gov_Recipient_.id = id;
            control.DeleteEntity(Gov_Recipient_);
        }

        public Gov_RecipientInfo GetById(int id)
        {
            return (Gov_RecipientInfo)control.GetEntity("WC.Model.Gov_RecipientInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_RecipientInfo", where, orderBy);
        }
        #endregion
    }
}
