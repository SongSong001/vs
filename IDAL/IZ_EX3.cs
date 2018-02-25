using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IZEX3
    {
        void Add(ZEX3Info com);
        void Update(ZEX3Info com);
        void Delete(int id);
        ZEX3Info GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}