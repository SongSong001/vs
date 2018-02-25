using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ICars
    {
        void Add(CarsInfo com);
        void Update(CarsInfo com);
        void Delete(int id);
        CarsInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}