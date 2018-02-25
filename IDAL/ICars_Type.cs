using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ICars_Type
    {
        void Add(Cars_TypeInfo com);
        void Update(Cars_TypeInfo com);
        void Delete(int id);
        Cars_TypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}