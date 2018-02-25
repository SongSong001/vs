using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IBas_ComType_Module
    {
        void Add(Bas_ComType_ModuleInfo com);
        void Update(Bas_ComType_ModuleInfo com);
        void Delete(int id);
        Bas_ComType_ModuleInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}