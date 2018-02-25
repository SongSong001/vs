namespace Core
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using System.Text;
    using WC.Common;
    using NHibernate;

    internal class SqlServerOrganizationStorage : IOrganizationStorage
    {
        private string m_ConnectionString = "";

        public SqlServerOrganizationStorage()
        {
            this.m_ConnectionString = "";
        }

        void IOrganizationStorage.AddDept(string name, long pdid, long cindex)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = "INSERT INTO WM_DEPT(dname,pdid,cindex)values(@dname,@pdid,@cindex)";
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                cmd.Parameters.Add("dname", DbType.String).Value = name;
                cmd.Parameters.Add("pdid", DbType.Int64).Value = pdid;
                cmd.Parameters.Add("cindex", DbType.Int64).Value = cindex;
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

        void IOrganizationStorage.DeleteDept(long did)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = "DELETE WM_DEPT WHERE did=@did ;  DELETE WM_UDD WHERE did=@did ";
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                cmd.Parameters.Add("did", DbType.Int64).Value = did;
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

        DataTable IOrganizationStorage.GetAllDepts()
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
                        cmd.CommandText = "SELECT CAST(id AS NVARCHAR) as ID,ParentID,DepName FROM Sys_Dep order by Orders asc ;";
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

        DataTable IOrganizationStorage.GetCompanyInfo()
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
                        cmd.CommandText = "SELECT Id,Name,Tel,Address,Logo FROM WM_Company ;";
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

        DataRowCollection IOrganizationStorage.GetDeptAllUser(string deptId)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                try
                {
                    cmd.Connection = conn;
                    string sql = string.Format("SELECT [Key],Name FROM dbo.WM_Users WHERE [KEY] IN (SELECT uid FROM dbo.WM_UDD WHERE did IN( SELECT * FROM dbo.FUN_GetChildList('Sys_Dep','{0}')))", deptId);
                    cmd.CommandText = sql;
                    SqlDataAdapter ada = new SqlDataAdapter();
                    ada.SelectCommand = cmd;
                    ada.Fill(dt);
                    ada.Dispose();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
            return dt.Rows;
        }

        DataTable IOrganizationStorage.GetDeptById(long did)
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
                        cmd.CommandText = string.Format("SELECT id,depname,orders,parentid FROM sys_dep WHERE id={0}", did);
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

        DataTable IOrganizationStorage.GetDeptList(string filter)
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
                        cmd.CommandText = string.Format("SELECT a.id,a.depname,a.orders,a.depname,a.parentid,ISNULL(b.depname,'') AS parentname                       FROM sys_dep a LEFT JOIN sys_dep b ON a.id=b.parentid WHERE 1=1 {0} ORDER BY a.orders;", filter);
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

        DataRowCollection IOrganizationStorage.GetDepts()
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                try
                {
                    cmd.Connection = conn;
                    cmd.CommandText = "SELECT a.uid,a.did AS parentid,b.Name,'1' AS dtype,b.EMail,b.AcceptStrangerIM,b.DiskSize,b.HeadIMG,b.HomePage,b.InviteCode,b.IsTemp,b.MsgFileLimit,b.MsgImageLimit,b.Nickname,b.RegisterTime,b.Remark,b.Type,b.UpperName,b.password,b.phone,b.telphone,b.mobilephone,-1 AS orders  FROM WM_UDD a   LEFT JOIN WM_Users b ON a.uid=b.[key]  UNION ALL SELECT CAST(id AS NVARCHAR) AS id,parentid,DepName as name,'0' AS dtype,'' as EMail,'' as AcceptStrangerIM ,'0' as DiskSize,'' as HeadIMG,'' as HomePage,'' as InviteCode,'' as IsTemp,'0' as MsgFileLimit,'0' as MsgImageLimit, DepName as Nickname,GETDATE() as RegisterTime,'' as Remark,'0' as Type,'' as UpperName,''as password,'' as phone,'' as telphone,'' as mobilephone,Orders  FROM Sys_Dep order by Orders asc ;";
                    SqlDataAdapter ada = new SqlDataAdapter();
                    ada.SelectCommand = cmd;
                    ada.Fill(dt);
                    ada.Dispose();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
            return dt.Rows;
        }

        DataTable IOrganizationStorage.GetUsersByDeptId(long did)
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
                        cmd.CommandText = string.Format("SELECT [Key],Name,Nickname FROM WM_Users WHERE  [type]=0 AND  [Key] IN(SELECT uid FROM dbo.WM_UDD WHERE did={0})", did);
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

        DataTable IOrganizationStorage.GetUsersByNoExistsDept(long did)
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
                        cmd.CommandText = string.Format("SELECT [Key],Name,Nickname FROM WM_Users WHERE  [type]=0 AND [Key] NOT IN(SELECT uid FROM dbo.WM_UDD WHERE did={0}) ", did);
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

        void IOrganizationStorage.UpdateCompanyInfo(string id, string name, string tel, string address, string logo)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = "";
            if (id == "")
            {
                sql = "INSERT INTO WM_Company(name,tel,address,logo)VALUES(@name,@tel,@address,@logo)";
            }
            else
            {
                sql = "UPDATE WM_Company SET name=@name,tel=@tel,address=@address,logo=@logo where id=@id";
            }
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                if (id != "")
                {
                    cmd.Parameters.Add("id", DbType.String).Value = id;
                }
                cmd.Parameters.Add("name", DbType.String).Value = name;
                cmd.Parameters.Add("tel", DbType.String).Value = tel;
                cmd.Parameters.Add("address", DbType.String).Value = address;
                cmd.Parameters.Add("logo", DbType.String).Value = logo;
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

        void IOrganizationStorage.UpdateDept(long did, string name, long pdid, long cindex)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            string sql = "UPDATE WM_DEPT SET dname=@dname,pdid=@pdid,cindex=@cindex WHERE did=@did";
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = sql;
                cmd.Parameters.Add("dname", DbType.String).Value = name;
                cmd.Parameters.Add("did", DbType.Int64).Value = did;
                cmd.Parameters.Add("pdid", DbType.Int64).Value = pdid;
                cmd.Parameters.Add("cindex", DbType.Int64).Value = cindex;
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

        void IOrganizationStorage.UpdateDeptMember(string ids, long did)
        {
            StringBuilder sql = new StringBuilder();
            foreach (string id in ids.Split(new char[] { ',' }))
            {
                if (id != "")
                {
                    sql.AppendFormat("DELETE FROM WM_UDD WHERE did={0} AND uid={1} ; INSERT INTO WM_UDD(did,uid,tid)VALUES({0},{1},0) ", did, id);
                }
            }
            if (sql.Length > 0)
            {
                ISession session = SessionFactory.OpenSession("WC.Model");
                using (SqlConnection conn = (SqlConnection)session.Connection)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = sql.ToString();
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
}

