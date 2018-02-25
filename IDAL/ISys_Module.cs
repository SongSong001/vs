using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISys_Module
    {
        void Add(Sys_ModuleInfo com);
        void Update(Sys_ModuleInfo com);
        void Delete(int id);
        Sys_ModuleInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}