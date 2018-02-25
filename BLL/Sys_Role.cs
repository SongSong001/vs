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
    public class Sys_Role
    {
         //summary
         //在业务逻辑层中设置一个静态只读Sys_Role操作类的对象
         //summary
        private static readonly ISys_Role dal = WC.Factory.DALFactory.CreateSys_RoleDAL();

         //summary
         //封装业务层中Sys_Role操作类的构造方法
         //summary
        private Sys_Role() { }

         //summary
         //业务逻辑层中Sys_Role操作类对象的静态生成方法
         //summary
        public static Sys_Role Init()
        {
            return new Sys_Role();
        }

        #region NHibernate 方法

        public void Add(Sys_RoleInfo com)
        {
            dal.Add(com);
        }

        public void Update(Sys_RoleInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            if (id != 4)
                dal.Delete(id);
        }

        public Sys_RoleInfo GetById(int id)
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
