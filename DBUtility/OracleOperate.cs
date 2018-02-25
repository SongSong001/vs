using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Collections;

namespace WC.DBUtility
{
    /// <summary>
    /// Oracle数据库操作类
    /// </summary>
    public class OracleOperate
    {
        //读取链接字符串
        public static readonly string ConnString = ConfigurationManager.ConnectionStrings["OracleConnString"].ConnectionString;

        public OracleOperate() { }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句对应的参数集合</param>
        /// <returns>int 响应的行数</returns>
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            using (OracleConnection conn = new OracleConnection(ConnString))
            {
                try
                {
                    OracleCommand cmd = new OracleCommand();
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
        public static int ExecuteNonQuery(OracleTransaction trans, OracleConnection conn, CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            try
            {
                OracleCommand cmd = new OracleCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //日掉Parameters对象
                cmd.Parameters.Clear();

                return var;
            }
            catch (OracleException e)
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
        public static object ExecuteScalar(CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            OracleConnection conn = new OracleConnection(ConnString);
            try
            {

                OracleCommand cmd = new OracleCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                object obj = cmd.ExecuteScalar();
                cmd.Parameters.Clear();
                return obj;
            }
            catch (OracleException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 获取OracleDataReader对象
        /// </summary>
        /// <param name="cmdType">cmd操作类型</param>
        /// <param name="cmdText">查询Sql语句</param>
        /// <param name="cmdParms">参数集合</param>
        /// <returns>OracleDataReader</returns>
        public static OracleDataReader ExecuteReader(CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            OracleConnection conn = new OracleConnection(ConnString);
            try
            {
                OracleCommand cmd = new OracleCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                OracleDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return sdr;
            }
            catch (OracleException ex)
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
        public static DataSet ExecuteDataset(CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            OracleConnection conn = new OracleConnection(ConnString);
            try
            {
                OracleCommand cmd = new OracleCommand();
                PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    cmd.Parameters.Clear();
                    return ds;
                }
            }
            catch (OracleException ex)
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
        /// 将OracleDataReader 转为 DataTable
        /// </summary>
        /// <param name="DataReader">OracleDataReader</param>
        public static DataTable ConvertDataReaderToDataTable(OracleDataReader dataReader)
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
        /// 组装OracleCommand对象
        /// </summary>
        /// <param name="cmd">OracleCommand对象的引用</param>
        /// <param name="conn">已经实例化的OracleConnection对象</param>
        /// <param name="trans">要启用的事务</param>
        /// <param name="cmdType">cmd操作类型，可以是存储过程</param>
        /// <param name="cmdText">Sql语句</param>
        /// <param name="cmdParms">Sql语句中对应的参数集合</param>
        private static void PrepareCommand(OracleCommand cmd, OracleConnection conn, OracleTransaction trans, CommandType cmdType, string cmdText, OracleParameter[] cmdParms)
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
                foreach (OracleParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
        }


    }
}

