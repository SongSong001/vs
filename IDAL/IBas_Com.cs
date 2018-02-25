using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IBas_Com
    {
        void Add(Bas_ComInfo com);
        void Update(Bas_ComInfo com);
        void Delete(int id);
        Bas_ComInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}