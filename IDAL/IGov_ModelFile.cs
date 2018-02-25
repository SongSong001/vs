using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov_ModelFile
    {
        void Add(Gov_ModelFileInfo com);
        void Update(Gov_ModelFileInfo com);
        void Delete(int id);
        Gov_ModelFileInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}