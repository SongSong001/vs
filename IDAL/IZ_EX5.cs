using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IZEX5
    {
        void Add(ZEX5Info com);
        void Update(ZEX5Info com);
        void Delete(int id);
        ZEX5Info GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}