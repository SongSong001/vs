using System;
using System.IO;
using System.Text;

namespace WC.Tool
{
    /// <summary>
    /// ������ д����־
    /// </summary>
    public class ErrorLog
    {
        public static void ToTxt(Exception exception, string path,string tmp)
        {
            //������Ϣ����
            StringBuilder sb = new StringBuilder(1024);
            sb.Append("============================================================================\n\n   ");
            sb.Append("\n\n�ͻ���IP/�����ַ��" + tmp + "\n\n");
            sb.Append("\n\n������ʱ�䣺   \n\n");
            sb.Append(DateTime.Now.ToString("yy-M-dd HH:mm:ss"));
            sb.Append("\n\n������Ϣ��\n\n   ");
            sb.Append(exception.ToString());
            sb.Append("\n\n\n");

            //����Ϣ����д���ļ�
            StreamWriter streamWriter = new StreamWriter(path, true, Encoding.Unicode);
            streamWriter.Write(sb);
            streamWriter.Close();
        }
    }
}