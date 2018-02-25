using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace WC.DBUtility
{
    public abstract class AccessOperate
    {
        //读取链接字符串
        public static readonly string ConnString = ConfigurationManager.AppSettings["OLEDBCONNECTIONSTRING"].ToString() + System.Web.HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["newsPath"]);

        public AccessOperate() { }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句对应的参数集合</param>
        /// <returns>int 响应的行数</returns>
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            using (OleDbConnection conn = new OleDbConnection(ConnString))
            {
                try
                {
                    OleDbCommand cmd = new OleDbCommand();
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
                    conn.Close();
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
        public static int ExecuteNonQuery(OleDbTransaction trans, OleDbConnection conn, CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            try
            {
                OleDbCommand cmd = new OleDbCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //日掉Parameters对象
                cmd.Parameters.Clear();

                return var;
            }
            catch (OleDbException e)
            {
                throw e;
            }
        }

        /// <summary>
        /// 从查询结果中获取第一行第一列，忽略其他
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>object</returns>
        public static object ExecuteScalar(CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            OleDbConnection conn = new OleDbConnection(ConnString);
            try
            {

                OleDbCommand cmd = new OleDbCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                object obj = cmd.ExecuteScalar();
                cmd.Parameters.Clear();
                return obj;
            }
            catch (OleDbException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 获取OleDbDataReader对象
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>OleDbDataReader</returns>
        public static OleDbDataReader ExecuteReader(CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            OleDbConnection conn = new OleDbConnection(ConnString);
            try
            {
                OleDbCommand cmd = new OleDbCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                OleDbDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return sdr;
            }
            catch (OleDbException ex)
            {
                conn.Close();
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
        public static DataSet ExecuteDataset(CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            OleDbConnection conn = new OleDbConnection(ConnString);
            try
            {
                OleDbCommand cmd = new OleDbCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    cmd.Parameters.Clear();
                    return ds;
                }
            }
            catch (OleDbException ex)
            {
                conn.Close();
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 将OleDbDataReader 转为 DataTable
        /// </summary>
        /// <param name="DataReader">OleDbDataReader</param>
        public static DataTable ConvertDataReaderToDataTable(OleDbDataReader dataReader)
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
        /// 组装OleDbCommand对象
        /// </summary>
        /// <param name="cmd">OleDbCommand对象的引用</param>
        /// <param name="conn">已经实例化的OleDbConnection对象</param>
        /// <param name="trans">要启用的事务</param>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句中对应的参数集合</param>
        private static void PrepareCommand(OleDbCommand cmd, OleDbConnection conn, OleDbTransaction trans, CommandType cmdType, string cmdText, OleDbParameter[] cmdParms)
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
                foreach (OleDbParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
        }

    }
}
