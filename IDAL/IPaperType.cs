using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IPaperType
    {
        void Add(PaperTypeInfo com);
        void Update(PaperTypeInfo com);
        void Delete(int id);
        PaperTypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}