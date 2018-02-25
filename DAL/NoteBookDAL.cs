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
    public class NoteBookDAL : INoteBook
    {
        private EntityControl control;

        public NoteBookDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(NoteBookInfo NoteBook_)
        {
            control.AddEntity(NoteBook_);
        }

        public void Update(NoteBookInfo NoteBook_)
        {
            control.UpdateEntity(NoteBook_, NoteBook_.id);
        }

        public void Delete(int id)
        {
            NoteBookInfo NoteBook_ = new NoteBookInfo();
            NoteBook_.id = id;
            control.DeleteEntity(NoteBook_);
        }

        public NoteBookInfo GetById(int id)
        {
            return (NoteBookInfo)control.GetEntity("WC.Model.NoteBookInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.NoteBookInfo", where, orderBy);
        }
        #endregion
    }
}
