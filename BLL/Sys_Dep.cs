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
    public class Sys_Dep
    {
         //summary
         //在业务逻辑层中设置一个静态只读Sys_Dep操作类的对象
         //summary
        private static readonly ISys_Dep dal = WC.Factory.DALFactory.CreateSys_DepDAL();

         //summary
         //封装业务层中Sys_Dep操作类的构造方法
         //summary
        private Sys_Dep() { }

         //summary
         //业务逻辑层中Sys_Dep操作类对象的静态生成方法
         //summary
        public static Sys_Dep Init()
        {
            return new Sys_Dep();
        }

        #region NHibernate 方法

        public void Add(Sys_DepInfo com)
        {
            dal.Add(com);
        }

        public void Update(Sys_DepInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Sys_DepInfo GetById(int id)
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
