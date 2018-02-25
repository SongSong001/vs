using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NHibernate;
using WC.Common;

namespace WC.DBUtility
{    /// <summary>
    /// SQLServer���ݿ������
    /// </summary>
    public abstract class MsSqlOperate
    {
        //��ȡ�����ַ���
        //public static readonly string ConnString = ConfigurationManager.ConnectionStrings["MsSqlConnString"].ConnectionString;
        public static readonly string ConnString = "";

        public MsSqlOperate()
        {
        }

        /// <summary>
        /// ִ��SQL���
        /// </summary>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����Ӧ�Ĳ�������</param>
        /// <returns>int ��Ӧ������</returns>
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
                    session.Close(); session.Dispose();
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
        public static int ExecuteNonQuery(SqlTransaction trans, SqlConnection conn, CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, conn, trans, cmdType, cmdText, cmdParms);
                int var = cmd.ExecuteNonQuery();
                //�յ�Parameters����
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
        /// �Ӳ�ѯ����л�ȡ��һ�е�һ�У���������
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��ȡSqlDataReader����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��ȡDataSet����
        /// </summary>
        /// <param name="cmdType">cmd��������</param>
        /// <param name="cmdText">��ѯSql���</param>
        /// <param name="cmdParms">��������</param>
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
        /// ��SqlDataReader תΪ DataTable
        /// </summary>
        /// <param name="DataReader">DataReader</param>
        public static DataTable ConvertDataReaderToDataTable(SqlDataReader dataReader)
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
        /// ��װSqlCommand����
        /// </summary>
        /// <param name="cmd">SqlCommand���������</param>
        /// <param name="conn">�Ѿ�ʵ������SqlConnection����</param>
        /// <param name="trans">Ҫ���õ�����</param>
        /// <param name="cmdType">cmd�������ͣ������Ǵ洢����</param>
        /// <param name="cmdText">Sql���</param>
        /// <param name="cmdParms">Sql����ж�Ӧ�Ĳ�������</param>
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

