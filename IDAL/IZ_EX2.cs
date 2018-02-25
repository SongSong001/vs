using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IZEX2
    {
        void Add(ZEX2Info com);
        void Update(ZEX2Info com);
        void Delete(int id);
        ZEX2Info GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}