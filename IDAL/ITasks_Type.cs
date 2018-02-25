using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ITasks_Type
    {
        void Add(Tasks_TypeInfo com);
        void Update(Tasks_TypeInfo com);
        void Delete(int id);
        Tasks_TypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}