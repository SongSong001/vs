using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov_StepAction
    {
        void Add(Gov_StepActionInfo com);
        void Update(Gov_StepActionInfo com);
        void Delete(int id);
        Gov_StepActionInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}