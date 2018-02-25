using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IPaper
    {
        void Add(PaperInfo com);
        void Update(PaperInfo com);
        void Delete(int id);
        PaperInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}