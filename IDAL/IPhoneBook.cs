﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IPhoneBook
    {
        void Add(PhoneBookInfo com);
        void Update(PhoneBookInfo com);
        void Delete(int id);
        PhoneBookInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}