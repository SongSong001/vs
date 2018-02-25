using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ICars_Action
    {
        void Add(Cars_ActionInfo com);
        void Update(Cars_ActionInfo com);
        void Delete(int id);
        Cars_ActionInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}