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
    public class Sms_DataDAL : ISms_Data
    {
        private EntityControl control;

        public Sms_DataDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sms_DataInfo Sms_Data_)
        {
            control.AddEntity(Sms_Data_);
        }

        public void Update(Sms_DataInfo Sms_Data_)
        {
            control.UpdateEntity(Sms_Data_, Sms_Data_.id);
        }

        public void Delete(int id)
        {
            Sms_DataInfo Sms_Data_ = new Sms_DataInfo();
            Sms_Data_.id = id;
            control.DeleteEntity(Sms_Data_);
        }

        public Sms_DataInfo GetById(int id)
        {
            return (Sms_DataInfo)control.GetEntity("WC.Model.Sms_DataInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sms_DataInfo", where, orderBy);
        }
        #endregion
    }
}
