﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IZEX1
    {
        void Add(ZEX1Info com);
        void Update(ZEX1Info com);
        void Delete(int id);
        ZEX1Info GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}