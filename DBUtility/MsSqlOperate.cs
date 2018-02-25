using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NHibernate;
using WC.Common;

namespace WC.DBUtility
{    /// <summary>
    /// SQLServer数据库操作类
    /// </summary>
    public abstract class MsSqlOperate
    {
        //读取链接字符串
        //public static readonly string ConnString = ConfigurationManager.ConnectionStrings["MsSqlConnString"].ConnectionString;
        public static readonly string ConnString = "";

        public MsSqlOperate()
        {
        }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句对应的参数集合</param>
        /// <returns>int 响应的行数</returns>
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {

            ISession session = SessionFactory.OpenSession("WC.Model");

            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                    int var = cmd.ExecuteNonQuery();
                    //日掉Parameters对象
                    cmd.Parameters.Clear();
                    return var;
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
        }

        /// <summary>
        /// 带事务的SQL语句执行
        /// </summary>
        /// <param name="trans">事务引用</param>
        /// <param name="conn">数据库连接</param>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句对应的参数集合</param>
        /// <returns>int 响应的行数</returns>
        public static int ExecuteNonQuery(SqlTransaction trans, SqlConnection conn, CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //日掉Parameters对象
                cmd.Parameters.Clear();

                return var;
            }
            catch (SqlException e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 从查询结果中获取第一行第一列，忽略其他
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>object</returns>
        public static object ExecuteScalar(CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {

                    SqlCommand cmd = new SqlCommand();
                    PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                    object obj = cmd.ExecuteScalar();
                    cmd.Parameters.Clear();
                    return obj;
                }
                catch (SqlException ex)
                {
                    throw ex;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        /// <summary>
        /// 获取SqlDataReader对象
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            SqlConnection conn = (SqlConnection)session.Connection;
            try
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return sdr;
            }
            catch (SqlException ex)
            {
                session.Close(); session.Dispose();
                throw ex;
            }
        }

        /// <summary>
        /// 获取DataSet对象
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>DataSet</returns>
        public static DataSet ExecuteDataset(CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {
            ISession session = SessionFactory.OpenSession("WC.Model");
            using (SqlConnection conn = (SqlConnection)session.Connection)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        cmd.Parameters.Clear();
                        return ds;
                    }
                }
                catch (SqlException ex)
                {
                    throw ex;
                }
                finally
                {
                    session.Close(); session.Dispose();
                }
            }
        }

        /// <summary>
        /// 将SqlDataReader 转为 DataTable
        /// </summary>
        /// <param name="DataReader">DataReader</param>
        public static DataTable ConvertDataReaderToDataTable(SqlDataReader dataReader)
        {
            DataTable datatable = new DataTable();
            DataTable schemaTable = dataReader.GetSchemaTable();
            //动态添加列
            try
            {

                foreach (DataRow myRow in schemaTable.Rows)
                {
                    DataColumn myDataColumn = new DataColumn();
                    myDataColumn.DataType = System.Type.GetType("System.String");
                    myDataColumn.ColumnName = myRow[0].ToString();
                    datatable.Columns.Add(myDataColumn);
                }
                //添加数据
                while (dataReader.Read())
                {
                    DataRow myDataRow = datatable.NewRow();
                    for (int i = 0; i < schemaTable.Rows.Count; i++)
                    {
                        myDataRow[i] = dataReader[i].ToString();
                    }
                    datatable.Rows.Add(myDataRow);
                    myDataRow = null;
                }
                schemaTable = null;
                dataReader.Close();
                return datatable;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        /// <summary>
        /// 组装SqlCommand对象
        /// </summary>
        /// <param name="cmd">SqlCommand对象的引用</param>
        /// <param name="conn">已经实例化的SqlConnection对象</param>
        /// <param name="trans">要启用的事务</param>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句中对应的参数集合</param>
        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, CommandType cmdType, string cmdText, SqlParameter[] cmdParms)
        {

            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
            }

            cmd.Connection = conn;
            cmd.CommandText = cmdText;

            if (trans != null)
                cmd.Transaction = trans;

            cmd.CommandType = cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
        }
    }
}

