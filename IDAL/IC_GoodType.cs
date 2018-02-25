using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IC_GoodType
    {
        void Add(C_GoodTypeInfo com);
        void Update(C_GoodTypeInfo com);
        void Delete(int id);
        C_GoodTypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}