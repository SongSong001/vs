using System;
using System.Collections;
using NHibernate;

namespace WC.Common
{
    public class EntityControl
    {
        private static EntityControl entity;
        private string _AssemblyName;
        static readonly object padlock = new object();

        public static EntityControl CreateEntityControl(string AssemblyName)
        {
            if (entity == null)
            {
                lock (padlock)
                {
                    if (entity == null)
                    {
                        entity = new EntityControl();
                        entity._AssemblyName = AssemblyName;
                    }
                }
            }
            return entity;
        }

        public void AddEntity(Object entity)
        {
            ISession session = SessionFactory.OpenSession(_AssemblyName);
            ITransaction transaction = session.BeginTransaction();
            try
            {
                session.Save(entity);
                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
        }

        public void UpdateEntity(Object entity, Object key)
        {
            ISession session = SessionFactory.OpenSession(_AssemblyName);
            ITransaction transaction = session.BeginTransaction();
            try
            {
                session.Update(entity, key);
                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
        }

        public void DeleteEntity(object entity)
        {
            ISession session = SessionFactory.OpenSession(_AssemblyName);
            ITransaction transaction = session.BeginTransaction();

            try
            {
                session.Delete(entity);
                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
        }

        public Object GetEntity(string table, string idFieldName, string id)
        {
            Object obj;
            string query = "From " + table + " Where " + idFieldName + " = '" + id + "'";
            ISession session = SessionFactory.OpenSession(_AssemblyName);

            obj = session.CreateQuery(query).UniqueResult();

            session.Close(); session.Dispose();

            return obj;
        }

        public IList GetEntitesPage(int pageIndex, int pageSize, string table, string where, string orderBy)
        {
            string query = "From " + table;
            if (!String.IsNullOrEmpty(where) && where != "")
            {
                query += " Where " + where;
            }
            if (!String.IsNullOrEmpty(orderBy) && orderBy != "")
            {
                query += " Order By " + orderBy;
            }

            if (pageIndex < 1)
            {
                pageIndex = 1;
            }
            if (pageSize < 1)
            {
                pageSize = 1;
            }

            IList lst;

            ISession session = SessionFactory.OpenSession(_AssemblyName);

            lst = session.CreateQuery(query).SetFirstResult(pageSize * (pageIndex - 1)).SetMaxResults(pageSize).List();

            session.Close(); session.Dispose();

            return lst;
        }

        public string GetPageSet(int pageIndex, int pageSize, string tableName, string where, string urlFormat, int mode)
        {
            ISession session = SessionFactory.OpenSession(_AssemblyName);
            int recordCount = DirectRun.GetRecordCount(session, tableName, where);
            session.Close(); session.Dispose();
            return SplitPage.GetPageSet(pageIndex, pageSize, recordCount, urlFormat, mode);
        }

        public IList GetEntities(string table, string where, string orderBy)
        {
            string query = "From " + table;
            if (!String.IsNullOrEmpty(where) && where != "")
            {
                query += " Where " + where;
            }
            if (!String.IsNullOrEmpty(orderBy) && orderBy != "")
            {
                query += " Order By " + orderBy;
            }

            IList lst;
            ISession session = SessionFactory.OpenSession(_AssemblyName);

            lst = session.CreateQuery(query).List();
            
            session.Close(); session.Dispose();
            return lst;
        }

        public int ExecuteNonQuery(string sqlString)
        {
            ISession session = SessionFactory.OpenSession(_AssemblyName);
            int num = DirectRun.ExecuteNonQuery(session, sqlString);
            session.Close(); session.Dispose();
            return num;
        }
    }
}
