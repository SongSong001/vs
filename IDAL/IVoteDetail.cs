using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface IVoteDetail
    {
        void Add(VoteDetailInfo com);
        void Update(VoteDetailInfo com);
        void Delete(int id);
        VoteDetailInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}