using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISys_Seal
    {
        void Add(Sys_SealInfo com);
        void Update(Sys_SealInfo com);
        void Delete(int id);
        Sys_SealInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}