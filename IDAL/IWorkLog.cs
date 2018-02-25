using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IWorkLog
    {
        void Add(WorkLogInfo com);
        void Update(WorkLogInfo com);
        void Delete(int id);
        WorkLogInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}