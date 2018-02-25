using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISys_Dep_Module
    {
        void Add(Sys_Dep_ModuleInfo com);
        void Update(Sys_Dep_ModuleInfo com);
        void Delete(int id);
        Sys_Dep_ModuleInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}