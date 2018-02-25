using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ITips
    {
        void Add(TipsInfo com);
        void Update(TipsInfo com);
        void Delete(int id);
        TipsInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}