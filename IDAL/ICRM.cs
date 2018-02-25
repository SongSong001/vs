using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ICRM
    {
        void Add(CRMInfo com);
        void Update(CRMInfo com);
        void Delete(int id);
        CRMInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}