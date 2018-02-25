using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IFlows_ModelFile
    {
        void Add(Flows_ModelFileInfo com);
        void Update(Flows_ModelFileInfo com);
        void Delete(int id);
        Flows_ModelFileInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}