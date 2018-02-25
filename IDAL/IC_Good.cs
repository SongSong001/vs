using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IC_Good
    {
        void Add(C_GoodInfo com);
        void Update(C_GoodInfo com);
        void Delete(int id);
        C_GoodInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}