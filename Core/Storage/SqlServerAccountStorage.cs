namespace Core
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Text;
    using WC.Common;
    using NHibernate;

    internal class SqlServerAccountStorage : IAccountStorage
    {
        private string m_ConnectionString = "";

        public SqlServerAccountStorage()
        {
            this.m_ConnectionString = "";
        }

        private void AddMemberToGroup(SqlConnection conn, SqlTransaction tran, string user, string friend)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "WM_AddFriend";
            cmd.Transaction = tran;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("user", DbType.String).Value = user;
            cmd.Parameters.Add("friend", DbType.String).Value = friend;
            cmd.ExecuteNonQuery();
        }

        void IAccountStorage.AddFriend(string user, string friend)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "WM_AddFriend";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("user", DbType.String).Value = user;
                cmd.Parameters.Add("friend", DbType.String).Value = friend;
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.AddUser(string name, string nickname, string password, string email, string phone, string telphone)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    SqlCommand insertUser = new SqlCommand("WM_AddUser", conn);
                    insertUser.CommandType = CommandType.StoredProcedure;
                    insertUser.Parameters.Add("name", DbType.String).Value = name;
                    insertUser.Parameters.Add("password", DbType.String).Value = password;
                    insertUser.Parameters.Add("nickname", DbType.String).Value = nickname;
                    insertUser.Parameters.Add("email", DbType.String).Value = email;
                    insertUser.Parameters.Add("inviteCode", DbType.String).Value = Guid.NewGuid().ToString().ToUpper().Replace("-", "");
                    insertUser.Parameters.Add("phone", DbType.String).Value = phone;
                    insertUser.Parameters.Add("telphone", DbType.String).Value = telphone;
                    insertUser.ExecuteNonQuery();
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

        void IAccountStorage.CreateGroup(string creator, string name, string nickname, long isExitGroup)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("WM_CreateGroup", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("creator", DbType.String).Value = creator;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
                    cmd.Parameters.Add("nickname", DbType.String).Value = nickname;
                    cmd.Parameters.Add("isExitGroup", DbType.Int64).Value = isExitGroup;
                    cmd.Parameters.Add("inviteCode", DbType.String).Value = Guid.NewGuid().ToString().ToUpper().Replace("-", "");
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.CreateTempGroup(string creator, string name, string nickname, string deptId, string userlist)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlTransaction tran = null;
                try
                {
                    if(conn.State != ConnectionState.Open) conn.Open();
                    tran = conn.BeginTransaction();
                    SqlCommand cmd = new SqlCommand("WM_CreateTempGroup", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Transaction = tran;
                    cmd.Parameters.Add("creator", DbType.String).Value = creator;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
                    cmd.Parameters.Add("nickname", DbType.String).Value = nickname;
                    cmd.Parameters.Add("TempGroupCreateDept", DbType.String).Value = deptId;
                    cmd.Parameters.Add("inviteCode", DbType.String).Value = Guid.NewGuid().ToString().ToUpper().Replace("-", "");
                    cmd.ExecuteNonQuery();
                    string[] users = userlist.Split(new char[] { ',' });
                    foreach (string user in users)
                    {
                        if (user.ToUpper() != creator.ToUpper())
                        {
                            this.AddMemberToGroup(conn, tran, user, name);
                        }
                    }
                    tran.Commit();
                }
                catch (Exception)
                {
                    tran.Rollback();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.CreateUser(string name, string nickname, string password, string email)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    SqlCommand insertUser = new SqlCommand("WM_CreateUser", conn);
                    insertUser.CommandType = CommandType.StoredProcedure;
                    insertUser.Parameters.Add("name", DbType.String).Value = name;
                    insertUser.Parameters.Add("password", DbType.String).Value = password;
                    insertUser.Parameters.Add("nickname", DbType.String).Value = nickname;
                    insertUser.Parameters.Add("email", DbType.String).Value = email;
                    insertUser.Parameters.Add("inviteCode", DbType.String).Value = Guid.NewGuid().ToString().ToUpper().Replace("-", "");
                    insertUser.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.DeleteFriend(long userId, long friendId)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "WM_DeleteFriend";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("user", DbType.Int64).Value = userId;
                cmd.Parameters.Add("friend", DbType.Int64).Value = friendId;
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.DeleteGroup(long id)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("WM_DeleteGroup");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("id", DbType.Int64).Value = id;
                    cmd.Connection = conn;
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        void IAccountStorage.DeleteUser(long id)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("WM_DeleteUser");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("id", DbType.Int64).Value = id;
                    cmd.Connection = conn;
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        DataRow IAccountStorage.GetAccountInfo(long key)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetAccountInfoByID";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("id", DbType.Int64).Value = key;
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
            return ((dt.Rows.Count > 0) ? dt.Rows[0] : null);
        }

        DataRow IAccountStorage.GetAccountInfo(string name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "WM_GetAccountInfoByName";
                    cmd.Parameters.Add("name", DbType.String).Value = name;
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
            return ((dt.Rows.Count > 0) ? dt.Rows[0] : null);
        }

        DataRowCollection IAccountStorage.GetAllGroups()
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetAllGroups";
                    cmd.CommandType = CommandType.StoredProcedure;
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

        DataTable IAccountStorage.GetAllUserByName(string Name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = conn;
                        cmd.CommandText = "WM_GetAllUsersByName";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Name", DbType.String).Value = Name;
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

        DataRowCollection IAccountStorage.GetAllUsers()
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetAllUsers";
                    cmd.CommandType = CommandType.StoredProcedure;
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

        DataRowCollection IAccountStorage.GetFriends(string name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable result = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetFriends";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
                    SqlDataAdapter ada = new SqlDataAdapter();
                    ada.SelectCommand = cmd;
                    ada.Fill(result);
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
            return result.Rows;
        }

        string[] IAccountStorage.GetGroupManagers(string name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable result = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetGroupManagers";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
                    SqlDataAdapter ada = new SqlDataAdapter();
                    ada.SelectCommand = cmd;
                    ada.Fill(result);
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
            List<string> names = new List<string>();
            foreach (DataRow row in result.Rows)
            {
                names.Add(row["Name"] as string);
            }
            return names.ToArray();
        }

        string IAccountStorage.GetGroupTempNameByDeptId(string deptId)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = (SqlConnection)session.Connection)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = string.Format("SELECT Name FROM dbo.WM_Users WHERE TempGroupCreateDept='{0}'", deptId);
                SqlCommand command = cmd;
                SqlDataAdapter ada = new SqlDataAdapter();
                ada.SelectCommand = command;
                SqlDataAdapter adapter = ada;
                try
                {
                    adapter.Fill(dataTable);
                    adapter.Dispose();
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
            return ((dataTable.Rows.Count > 0) ? dataTable.Rows[0][0].ToString() : "");
        }

        List<string> IAccountStorage.GetIMWindowRoles(string name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dataTable = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = string.Format("SELECT DISTINCT Action FROM WM_Control WHERE GId IN( SELECT gid FROM DUG WHERE uid=(SELECT uid FROM DUSER WHERE uname='{0}'))", name);
                SqlCommand command = cmd;
                SqlDataAdapter ada = new SqlDataAdapter();
                ada.SelectCommand = command;
                SqlDataAdapter adapter = ada;
                try
                {
                    adapter.Fill(dataTable);
                    adapter.Dispose();
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
            List<string> list = new List<string>();
            foreach (DataRow row in dataTable.Rows)
            {
                list.Add(row["Action"] as string);
            }
            return list;
        }

        long IAccountStorage.GetRelationship(string account1, string account2)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable result = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetRelationship";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("account1", DbType.String).Value = account1;
                    cmd.Parameters.Add("account2", DbType.String).Value = account2;
                    SqlDataAdapter ada = new SqlDataAdapter();
                    ada.SelectCommand = cmd;
                    ada.Fill(result);
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
            return ((result.Rows.Count > 0) ? Convert.ToInt64(result.Rows[0]["Relationship"]) : -1);
        }

        string[] IAccountStorage.GetUserRoles(string name)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_GetUserRoles";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
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
            List<string> names = new List<string>();
            foreach (DataRow row in dt.Rows)
            {
                names.Add(row["RoleName"] as string);
            }
            return names.ToArray();
        }

        void IAccountStorage.UpdateUserInfo(string name, Hashtable values)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                if(conn.State != ConnectionState.Open) conn.Open();
                try
                {
                    if (values.ContainsKey("Password"))
                    {
                        if (!values.ContainsKey("PreviousPassword"))
                        {
                            throw new Exception("原密码错误！");
                        }
                        SqlCommand checkPwdCmd = new SqlCommand();
                        checkPwdCmd.Connection = conn;
                        checkPwdCmd.CommandText = "select [Key] from WM_Users where UpperName = @Name and Password = @Password";
                        checkPwdCmd.Parameters.Add("Name", DbType.String).Value = name.ToUpper();
                        checkPwdCmd.Parameters.Add("Password", DbType.String).Value = Utility.MD5(values["PreviousPassword"].ToString());
                        if (checkPwdCmd.ExecuteScalar() == null)
                        {
                            throw new Exception("原密码错误！");
                        }
                    }
                    StringBuilder cmdText = new StringBuilder();
                    cmdText.Append("update WM_Users set Name = Name");
                    if (values.ContainsKey("Nickname"))
                    {
                        cmdText.Append(",Nickname = @Nickname");
                    }
                    if (values.ContainsKey("Password"))
                    {
                        cmdText.Append(",Password = @Password");
                    }
                    if (values.ContainsKey("EMail"))
                    {
                        cmdText.Append(",EMail = @EMail");
                    }
                    if (values.ContainsKey("InviteCode"))
                    {
                        cmdText.Append(",InviteCode = @InviteCode");
                    }
                    if (values.ContainsKey("AcceptStrangerIM"))
                    {
                        cmdText.Append(",AcceptStrangerIM = @AcceptStrangerIM");
                    }
                    if (values.ContainsKey("MsgFileLimit"))
                    {
                        cmdText.Append(",MsgFileLimit = @MsgFileLimit");
                    }
                    if (values.ContainsKey("MsgImageLimit"))
                    {
                        cmdText.Append(",MsgImageLimit = @MsgImageLimit");
                    }
                    if (values.ContainsKey("HomePage"))
                    {
                        cmdText.Append(",HomePage = @HomePage");
                    }
                    if (values.ContainsKey("HeadIMG"))
                    {
                        cmdText.Append(",HeadIMG = @HeadIMG");
                    }
                    if (values.ContainsKey("Remark"))
                    {
                        cmdText.Append(",Remark = @Remark");
                    }
                    if (values.ContainsKey("Phone"))
                    {
                        cmdText.Append(",Phone = @Phone");
                    }
                    if (values.ContainsKey("TelPhone"))
                    {
                        cmdText.Append(",TelPhone = @TelPhone");
                    }
                    if (values.ContainsKey("MobilePhone"))
                    {
                        cmdText.Append(",MobilePhone = @MobilePhone");
                    }
                    if (values.ContainsKey("IsExitGroup"))
                    {
                        cmdText.Append(",IsExitGroup = @IsExitGroup");
                    }
                    cmdText.Append(" where UpperName=@UpperName");
                    if (values.ContainsKey("PreviousPassword"))
                    {
                        cmdText.Append(" and Password = @PreviousPassword");
                    }
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = cmdText.ToString();
                    if (values.ContainsKey("Nickname"))
                    {
                        cmd.Parameters.Add("Nickname", DbType.String).Value = values["Nickname"];
                    }
                    if (values.ContainsKey("Password"))
                    {
                        cmd.Parameters.Add("Password", DbType.String).Value = Utility.MD5(values["Password"] as string);
                    }
                    if (values.ContainsKey("EMail"))
                    {
                        cmd.Parameters.Add("EMail", DbType.String).Value = values["EMail"];
                    }
                    if (values.ContainsKey("InviteCode"))
                    {
                        cmd.Parameters.Add("InviteCode", DbType.String).Value = values["InviteCode"];
                    }
                    if (values.ContainsKey("AcceptStrangerIM"))
                    {
                        cmd.Parameters.Add("AcceptStrangerIM", DbType.Int64).Value = ((bool) values["AcceptStrangerIM"]) ? 1 : 0;
                    }
                    if (values.ContainsKey("MsgFileLimit"))
                    {
                        cmd.Parameters.Add("MsgFileLimit", DbType.Int64).Value = Convert.ToInt64((double) values["MsgFileLimit"]);
                    }
                    if (values.ContainsKey("MsgImageLimit"))
                    {
                        cmd.Parameters.Add("MsgImageLimit", DbType.Int64).Value = Convert.ToInt64((double) values["MsgImageLimit"]);
                    }
                    if (values.ContainsKey("HomePage"))
                    {
                        cmd.Parameters.Add("HomePage", DbType.String).Value = values["HomePage"];
                    }
                    if (values.ContainsKey("HeadIMG"))
                    {
                        cmd.Parameters.Add("HeadIMG", DbType.String).Value = values["HeadIMG"];
                    }
                    if (values.ContainsKey("Remark"))
                    {
                        cmd.Parameters.Add("Remark", DbType.String).Value = values["Remark"];
                    }
                    if (values.ContainsKey("Phone"))
                    {
                        cmd.Parameters.Add("Phone", DbType.String).Value = values["Phone"];
                    }
                    if (values.ContainsKey("TelPhone"))
                    {
                        cmd.Parameters.Add("TelPhone", DbType.String).Value = values["TelPhone"];
                    }
                    if (values.ContainsKey("MobilePhone"))
                    {
                        cmd.Parameters.Add("MobilePhone", DbType.String).Value = values["MobilePhone"];
                    }
                    if (values.ContainsKey("IsExitGroup"))
                    {
                        cmd.Parameters.Add("IsExitGroup", DbType.Int64).Value = ((bool) values["IsExitGroup"]) ? 1 : 0;
                    }
                    cmd.Parameters.Add("UpperName", DbType.String).Value = name.ToUpper();
                    if (values.ContainsKey("PreviousPassword"))
                    {
                        cmd.Parameters.Add("PreviousPassword", DbType.String).Value = Utility.MD5(values["PreviousPassword"] as string);
                    }
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        bool IAccountStorage.Validate(string name, string password)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            DataTable dt = new DataTable();
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "WM_Validate";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("name", DbType.String).Value = name;
                    cmd.Parameters.Add("password", DbType.String).Value = password;
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
            return (dt.Rows.Count > 0);
        }
    }
}

