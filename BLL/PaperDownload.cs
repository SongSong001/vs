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
    public class PaperDownload
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读PaperDownload操作类的对象
        /// </summary>
        private static readonly IPaperDownload dal = WC.Factory.DALFactory.CreatePaperDownloadDAL();

        /// <summary>
        /// 封装业务层中PaperDownload操作类的构造方法
        /// </summary>
        private PaperDownload() { }

        /// <summary>
        /// 业务逻辑层中PaperDownload操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static PaperDownload Init()
        {
            return new PaperDownload();
        }

        #region NHibernate 方法

        public void Add(PaperDownloadInfo com)
        {
            dal.Add(com);
        }

        public void Update(PaperDownloadInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public PaperDownloadInfo GetById(int id)
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
