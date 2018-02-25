using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IFlows_ModelStep
    {
        void Add(Flows_ModelStepInfo com);
        void Update(Flows_ModelStepInfo com);
        void Delete(int id);
        Flows_ModelStepInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}