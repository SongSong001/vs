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
    public class PaperDownloadDAL : IPaperDownload
    {
        private EntityControl control;

        public PaperDownloadDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(PaperDownloadInfo PaperDownload_)
        {
            control.AddEntity(PaperDownload_);
        }

        public void Update(PaperDownloadInfo PaperDownload_)
        {
            control.UpdateEntity(PaperDownload_, PaperDownload_.id);
        }

        public void Delete(int id)
        {
            PaperDownloadInfo PaperDownload_ = new PaperDownloadInfo();
            PaperDownload_.id = id;
            control.DeleteEntity(PaperDownload_);
        }

        public PaperDownloadInfo GetById(int id)
        {
            return (PaperDownloadInfo)control.GetEntity("WC.Model.PaperDownloadInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.PaperDownloadInfo", where, orderBy);
        }
        #endregion
    }
}
