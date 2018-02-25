using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov
    {
        void Add(GovInfo com);
        void Update(GovInfo com);
        void Delete(int id);
        GovInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}