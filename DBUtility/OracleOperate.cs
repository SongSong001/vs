using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Collections;

namespace WC.DBUtility
{
    /// <summary>
    /// Oracle���ݿ������
    /// </summary>
    public class OracleOperate
    {
        //��ȡ�����ַ���
        public static readonly string ConnString = ConfigurationManager.ConnectionStrings["OracleConnString"].ConnectionString;

        public OracleOperate() { }

        /// <summary>
        /// ִ��SQL���
        /// </summary>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����Ӧ�Ĳ�������</param>
        /// <returns>int ��Ӧ������</returns>
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            using (OracleConnection conn = new OracleConnection(ConnString))
            {
                try
                {
                    OracleCommand cmd = new OracleCommand();
                    PrepareCommand(cmd, conn, null, cmdType, cmdText, cmdParms);
                    int var = cmd.ExecuteNonQuery();
                    //�յ�Parameters����
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
        /// �������SQL���ִ��
        /// </summary>
        /// <param name="trans">��������</param>
        /// <param name="conn">���ݿ�����</param>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����Ӧ�Ĳ�������</param>
        /// <returns>int ��Ӧ������</returns>
        public static int ExecuteNonQuery(OracleTransaction trans, OracleConnection conn, CommandType cmdType, string cmdText, params OracleParameter[] cmdParms)
        {
            try
            {
                OracleCommand cmd = new OracleCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //�յ�Parameters����
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
        /// �Ӳ�ѯ����л�ȡ��һ�е�һ�У���������
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��ȡOracleDataReader����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��ȡDataSet����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��OracleDataReader תΪ DataTable
        /// </summary>
        /// <param name="DataReader">OracleDataReader</param>
        public static DataTable ConvertDataReaderToDataTable(OracleDataReader dataReader)
        {
            DataTable datatable = new DataTable();
            DataTable schemaTable = dataReader.GetSchemaTable();
            //��̬�����
            try
            {

                foreach (DataRow myRow in schemaTable.Rows)
                {
                    DataColumn myDataColumn = new DataColumn();
                    myDataColumn.DataType = System.Type.GetType("System.String");
                    myDataColumn.ColumnName = myRow[0].ToString();
                    datatable.Columns.Add(myDataColumn);
                }
                //�������
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
        /// ��װOracleCommand����
        /// </summary>
        /// <param name="cmd">OracleCommand���������</param>
        /// <param name="conn">�Ѿ�ʵ������OracleConnection����</param>
        /// <param name="trans">Ҫ���õ�����</param>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����ж�Ӧ�Ĳ�������</param>
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

