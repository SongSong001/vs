using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IVote
    {
        void Add(VoteInfo com);
        void Update(VoteInfo com);
        void Delete(int id);
        VoteInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}