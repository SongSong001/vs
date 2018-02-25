using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IDocs_DocType
    {
        void Add(Docs_DocTypeInfo com);
        void Update(Docs_DocTypeInfo com);
        void Delete(int id);
        Docs_DocTypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}