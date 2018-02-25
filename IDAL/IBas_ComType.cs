using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IBas_ComType
    {
        void Add(Bas_ComTypeInfo com);
        void Update(Bas_ComTypeInfo com);
        void Delete(int id);
        Bas_ComTypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}