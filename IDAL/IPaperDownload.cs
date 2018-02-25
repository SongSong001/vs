﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IPaperDownload
    {
        void Add(PaperDownloadInfo com);
        void Update(PaperDownloadInfo com);
        void Delete(int id);
        PaperDownloadInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}