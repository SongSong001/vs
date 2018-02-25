using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov_Doc
    {
        void Add(Gov_DocInfo com);
        void Update(Gov_DocInfo com);
        void Delete(int id);
        Gov_DocInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}