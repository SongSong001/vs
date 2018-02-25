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
    public class PhoneBookDAL : IPhoneBook
    {
        private EntityControl control;

        public PhoneBookDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(PhoneBookInfo PhoneBook_)
        {
            control.AddEntity(PhoneBook_);
        }

        public void Update(PhoneBookInfo PhoneBook_)
        {
            control.UpdateEntity(PhoneBook_, PhoneBook_.id);
        }

        public void Delete(int id)
        {
            PhoneBookInfo PhoneBook_ = new PhoneBookInfo();
            PhoneBook_.id = id;
            control.DeleteEntity(PhoneBook_);
        }

        public PhoneBookInfo GetById(int id)
        {
            return (PhoneBookInfo)control.GetEntity("WC.Model.PhoneBookInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.PhoneBookInfo", where, orderBy);
        }
        #endregion
    }
}
