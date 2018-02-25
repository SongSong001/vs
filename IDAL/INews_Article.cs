using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WC.Model;
using System.Data;
using System.Data.SqlClient;

namespace WC.IDAL
{
    public interface INews_Article
    {
        void Add(News_ArticleInfo com);
        void Update(News_ArticleInfo com);
        void Delete(int id);
        News_ArticleInfo GetById(int id);
        IList GetAll(string where, string orderBy);
    }
}