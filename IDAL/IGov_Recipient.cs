using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov_Recipient
    {
        void Add(Gov_RecipientInfo com);
        void Update(Gov_RecipientInfo com);
        void Delete(int id);
        Gov_RecipientInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}