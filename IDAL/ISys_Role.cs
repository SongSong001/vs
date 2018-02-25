using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISys_Role
    {
        void Add(Sys_RoleInfo com);
        void Update(Sys_RoleInfo com);
        void Delete(int id);
        Sys_RoleInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}