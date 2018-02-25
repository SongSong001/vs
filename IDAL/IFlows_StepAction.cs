using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IFlows_StepAction
    {
        void Add(Flows_StepActionInfo com);
        void Update(Flows_StepActionInfo com);
        void Delete(int id);
        Flows_StepActionInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}