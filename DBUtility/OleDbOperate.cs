using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
namespace WC.DBUtility
{
    /// <summary>
    /// OleDb���ݿ������(Access���ݿ�)
    /// </summary>
    public abstract class OleDbOperate
    {
        //��ȡ�����ַ���
        public static readonly string ConnString = ConfigurationManager.AppSettings["OLEDBCONNECTIONSTRING"].ToString() + System.Web.HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["dbPath"]);

        public OleDbOperate() { }

        /// <summary>
        /// ִ��SQL���
        /// </summary>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����Ӧ�Ĳ�������</param>
        /// <returns>int ��Ӧ������</returns>
        public static int ExecuteNonQuery(CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            using (OleDbConnection conn = new OleDbConnection(ConnString))
            {
                try
                {
                    OleDbCommand cmd = new OleDbCommand();
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
        public static int ExecuteNonQuery(OleDbTransaction trans, OleDbConnection conn, CommandType cmdType, string cmdText, params OleDbParameter[] cmdParms)
        {
            try
            {
                OleDbCommand cmd = new OleDbCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //�յ�Parameters����
                cmd.Parameters.Clear();

                return var;
            }
            catch (OleDbException e)
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
        /// ��ȡOleDbDataReader����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��ȡDataSet����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��OleDbDataReader תΪ DataTable
        /// </summary>
        /// <param name="DataReader">OleDbDataReader</param>
        public static DataTable ConvertDataReaderToDataTable(OleDbDataReader dataReader)
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
        /// ��װOleDbCommand����
        /// </summary>
        /// <param name="cmd">OleDbCommand���������</param>
        /// <param name="conn">�Ѿ�ʵ������OleDbConnection����</param>
        /// <param name="trans">Ҫ���õ�����</param>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����ж�Ӧ�Ĳ�������</param>
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

