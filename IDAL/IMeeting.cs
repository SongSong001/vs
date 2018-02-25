using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IMeeting
    {
        void Add(MeetingInfo com);
        void Update(MeetingInfo com);
        void Delete(int id);
        MeetingInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}