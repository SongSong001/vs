using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface INews_Type
    {
        void Add(News_TypeInfo com);
        void Update(News_TypeInfo com);
        void Delete(int id);
        News_TypeInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}