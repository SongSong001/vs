using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IZEX4
    {
        void Add(ZEX4Info com);
        void Update(ZEX4Info com);
        void Delete(int id);
        ZEX4Info GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}