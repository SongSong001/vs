using System;
using System.IO;
using System.Text;

namespace WC.Tool
{
    /// <summary>
    /// 错误处理 写入日志
    /// </summary>
    public class ErrorLog
    {
        public static void ToTxt(Exception exception, string path,string tmp)
        {
            //整理信息内容
            StringBuilder sb = new StringBuilder(1024);
            sb.Append("============================================================================\n\n   ");
            sb.Append("\n\n客户机IP/错误地址：" + tmp + "\n\n");
            sb.Append("\n\n错误发生时间：   \n\n");
            sb.Append(DateTime.Now.ToString("yy-M-dd HH:mm:ss"));
            sb.Append("\n\n错误信息：\n\n   ");
            sb.Append(exception.ToString());
            sb.Append("\n\n\n");

            //将信息内容写入文件
            StreamWriter streamWriter = new StreamWriter(path, true, Encoding.Unicode);
            streamWriter.Write(sb);
            streamWriter.Close();
        }
    }
}