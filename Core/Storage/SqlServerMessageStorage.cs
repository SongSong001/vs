namespace Core
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using WC.Common;
    using NHibernate;

    public class SqlServerMessageStorage : IMessageStorage
    {
        private string m_ConnectionString = "";
        private DateTime m_MaxCreatedTime = DateTime.Now;
        private long m_MaxKey = 1;

        public SqlServerMessageStorage()
        {
            this.m_ConnectionString = "";
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            if(conn.State != ConnectionState.Open) conn.Open();
            try
            {
                SqlDataReader reader = new SqlCommand("select max([Key]) as MaxKey, max(CreatedTime) as MaxCreatedTime from WM_Message", conn).ExecuteReader();
                if (reader.Read())
                {
                    this.m_MaxKey = (reader[0] == DBNull.Value) ? 1 : Convert.ToInt64(reader[0]);
                    this.m_MaxCreatedTime = (reader[1] == DBNull.Value) ? DateTime.Now : Convert.ToDateTime(reader[1]);
                }
            }
            finally
            {
                session.Close(); session.Dispose();
            }
        }

        List<Message> IMessageStorage.Find(long receiver, long sender, DateTime? from)
        {
            List<Message> CS_1_0000;
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            if(conn.State != ConnectionState.Open) conn.Open();
            try
            {
                if (!from.HasValue)
                {
                    from = new DateTime(0x7d0, 1, 1);
                }
                SqlCommand cmd = new SqlCommand("WM_FindMessages", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("user", DbType.Int32).Value = receiver;
                cmd.Parameters.Add("peer", DbType.Int32).Value = sender;
                cmd.Parameters.Add("from", DbType.DateTime).Value = from.Value;
                List<Message> messages = new List<Message>();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleResult);
                try
                {
                    while (reader.Read())
                    {
                        Message msg = new Message(AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[2])), AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[1])), reader.GetString(3), Convert.ToDateTime(reader[4]), Convert.ToInt64(reader[0]));
                        messages.Add(msg);
                    }
                }
                finally
                {
                    reader.Close();
                }
                CS_1_0000 = messages;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
            return CS_1_0000;
        }

        List<Message> IMessageStorage.FindHistory(long user, long peer, DateTime from, DateTime to)
        {
            List<Message> CS_1_0000;
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            if(conn.State != ConnectionState.Open) conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("WM_FindHistory", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("user", DbType.Int64).Value = user;
                cmd.Parameters.Add("peer", DbType.Int64).Value = peer;
                cmd.Parameters.Add("from", DbType.DateTime).Value = from;
                cmd.Parameters.Add("to", DbType.DateTime).Value = to;
                List<Message> messages = new List<Message>();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleResult);
                try
                {
                    while (reader.Read())
                    {
                        Message msg = new Message(AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[2])), AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[1])), reader.GetString(3), Convert.ToDateTime(reader[4]), Convert.ToInt64(reader[0]));
                        messages.Add(msg);
                    }
                }
                finally
                {
                    reader.Close();
                }
                CS_1_0000 = messages;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
            return CS_1_0000;
        }

        DateTime IMessageStorage.GetCreatedTime()
        {
            return this.m_MaxCreatedTime;
        }

        long IMessageStorage.GetMaxKey()
        {
            return this.m_MaxKey;
        }

        void IMessageStorage.Write(List<Message> messages)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            if(conn.State != ConnectionState.Open) conn.Open();
            DataTable messageDataTable = this.GetDataTable();
            foreach (Message msg in messages)
            {
                DataRow row = messageDataTable.NewRow();
                row["Receiver"] = msg.Receiver.ID;
                row["Sender"] = msg.Sender.ID;
                row["Content"] = msg.Content;
                row["CreatedTime"] = msg.CreatedTime;
                row["Key"] = msg.Key;
                messageDataTable.Rows.Add(row);
            }
            try
            {
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn, SqlBulkCopyOptions.Default, trans))
                    {
                        for (int i = 0; i < messageDataTable.Columns.Count; i++)
                        {
                            sqlBulkCopy.ColumnMappings.Add(messageDataTable.Columns[i].ColumnName, messageDataTable.Columns[i].ColumnName);
                        }
                        sqlBulkCopy.DestinationTableName = "WM_Message";
                        sqlBulkCopy.WriteToServer(messageDataTable);
                    }
                    trans.Commit();
                }
                catch
                {
                    trans.Rollback();
                }
            }
            finally
            {
                session.Close(); session.Dispose();
            }
        }

        public List<Message> FindHistory(string peerType, string content, DateTime from, DateTime to, string user)
        {
            List<Message> CS_1_0000;
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            if(conn.State != ConnectionState.Open) conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("WM_FindHistoryB", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("peerType", DbType.Int64).Value = peerType;
                cmd.Parameters.Add("content", DbType.String).Value = content;
                cmd.Parameters.Add("user", DbType.String).Value = user;
                cmd.Parameters.Add("from", DbType.DateTime).Value = from;
                cmd.Parameters.Add("to", DbType.DateTime).Value = to;
                List<Message> messages = new List<Message>();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleResult);
                try
                {
                    while (reader.Read())
                    {
                        Message msg = new Message(AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[2])), AccountImpl.Instance.GetUserInfo(Convert.ToInt64(reader[1])), reader.GetString(3), Convert.ToDateTime(reader[4]), Convert.ToInt64(reader[0]));
                        messages.Add(msg);
                    }
                }
                finally
                {
                    reader.Close();
                }
                CS_1_0000 = messages;
            }
            finally
            {
                session.Close(); session.Dispose();
            }
            return CS_1_0000;
        }

        private DataTable GetDataTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Receiver");
            dt.Columns.Add("Sender");
            dt.Columns.Add("Content");
            dt.Columns.Add("CreatedTime");
            dt.Columns.Add("Key");
            return dt;
        }

        private string ConnectionString
        {
            get
            {
                return this.m_ConnectionString;
            }
        }
    }
}

