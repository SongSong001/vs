using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface ICRM_Contact
    {
        void Add(CRM_ContactInfo com);
        void Update(CRM_ContactInfo com);
        void Delete(int id);
        CRM_ContactInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}