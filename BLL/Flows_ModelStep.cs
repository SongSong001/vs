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
    public class Flows_ModelStep
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Flows_ModelStep操作类的对象
        /// </summary>
        private static readonly IFlows_ModelStep dal = WC.Factory.DALFactory.CreateFlows_ModelStepDAL();

        /// <summary>
        /// 封装业务层中Flows_ModelStep操作类的构造方法
        /// </summary>
        private Flows_ModelStep() { }

        /// <summary>
        /// 业务逻辑层中Flows_ModelStep操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Flows_ModelStep Init()
        {
            return new Flows_ModelStep();
        }

        #region NHibernate 方法

        public void Add(Flows_ModelStepInfo com)
        {
            dal.Add(com);
        }

        public void Update(Flows_ModelStepInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Flows_ModelStepInfo GetById(int id)
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
