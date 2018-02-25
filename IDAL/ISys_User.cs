using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISys_User
    {
        void Add(Sys_UserInfo com);
        void Update(Sys_UserInfo com);
        void Delete(int id);
        Sys_UserInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}