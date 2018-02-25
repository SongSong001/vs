using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ISms_Data
    {
        void Add(Sms_DataInfo com);
        void Update(Sms_DataInfo com);
        void Delete(int id);
        Sms_DataInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}