using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using WC.Model;
using WC.DAL;
using WC.IDAL;
using WC.Factory;

namespace WC.BLL
{
    public class NoteBook
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读NoteBook操作类的对象
        /// </summary>
        private static readonly INoteBook dal = WC.Factory.DALFactory.CreateNoteBookDAL();

        /// <summary>
        /// 封装业务层中NoteBook操作类的构造方法
        /// </summary>
        private NoteBook() { }

        /// <summary>
        /// 业务逻辑层中NoteBook操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static NoteBook Init()
        {
            return new NoteBook();
        }

        #region NHibernate 方法

        public void Add(NoteBookInfo com)
        {
            dal.Add(com);
        }

        public void Update(NoteBookInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public NoteBookInfo GetById(int id)
        {
            return dal.GetById(id);
        }

        public IList GetAll(string where, string orderBy)
        {
            return dal.GetAll(where, orderBy);
        }

        #endregion
    }
}
