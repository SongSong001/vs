﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IGov_ModelStep
    {
        void Add(Gov_ModelStepInfo com);
        void Update(Gov_ModelStepInfo com);
        void Delete(int id);
        Gov_ModelStepInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}