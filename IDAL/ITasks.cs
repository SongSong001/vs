using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ITasks
    {
        void Add(TasksInfo com);
        void Update(TasksInfo com);
        void Delete(int id);
        TasksInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}