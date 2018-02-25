namespace Core
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using WC.Common;
    using NHibernate;

    public class SqlServerAttachmentStorage : IAttachmentStorage
    {
        private string m_ConnectionString = "";

        public SqlServerAttachmentStorage()
        {
            this.m_ConnectionString = "";
        }

        void IAttachmentStorage.DeleteAttachment(long id)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = string.Format("DELET FROM WM_Attachment WHERE id={0}", id);
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        DataTable IAttachmentStorage.GetAttachmentById(long id)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                try
                {
                    try
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = string.Format("SELECT  id,uid,uplaodId,oldname,savename,savetime,size FROM WM_Attachment WHERE id={0}", id);
                        SqlDataAdapter ada = new SqlDataAdapter();
                        ada.SelectCommand = cmd;
                        ada.Fill(dt);
                        ada.Dispose();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    return dt;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
            return dt;
        }

        DataTable IAttachmentStorage.GetListByGroupId(long id)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                try
                {
                    try
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = string.Format("SELECT id,uid,uplaodId,oldname,savename,savetime,size FROM WM_Attachment WHERE uid={0}", id);
                        SqlDataAdapter ada = new SqlDataAdapter();
                        ada.SelectCommand = cmd;
                        ada.Fill(dt);
                        ada.Dispose();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    return dt;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
            return dt;
        }

        void IAttachmentStorage.InsertAttachment(long uid, long uplaodId, string oldName, string saveName, double size)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = "INSERT INTO WM_Attachment(uid,uplaodid,oldname,savename,savetime,size)values(@uid,@uplaodid,@oldname,@savename,getdate(),@size)";
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                cmd.Parameters.Add("uid", DbType.Int64).Value = uid;
                cmd.Parameters.Add("uplaodid", DbType.Int64).Value = uplaodId;
                cmd.Parameters.Add("oldname", DbType.String).Value = oldName;
                cmd.Parameters.Add("savename", DbType.String).Value = saveName;
                cmd.Parameters.Add("size", DbType.Double).Value = size;
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }
    }
}

