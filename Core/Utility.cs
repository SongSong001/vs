namespace Core
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Configuration;
    using System.Data;
    using System.Drawing;
    using System.Drawing.Imaging;
    using System.Globalization;
    using System.Net.Json;
    using System.Text;
    using System.Text.RegularExpressions;
    using System.Web;
    using System.Web.Configuration;

    public class Utility
    {
        private static DateTime BaseDateTime = new DateTime(0x7b2, 1, 1, 0, 0, 0);

        public static string DataTableToJSON(DataTable dt, string Name)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            if (dt.Rows.Count > 0)
            {
                sb.AppendFormat("\"{0}\":", Name);
                sb.Append("[");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i > 0)
                    {
                        sb.Append(",");
                    }
                    RenderJson(sb, dt.Rows[i]);
                }
                sb.Append("]");
            }
            sb.Append("}");
            return sb.ToString();
        }

        public static string Decode(string s)
        {
            Regex r = new Regex(@"\\u[0-9a-fA-F]{4}|\\x[0-9a-fA-F]{2}");
            MatchEvaluator eval = new MatchEvaluator(Utility.ReplaceChar);
            return r.Replace(s, eval);
        }

        public static System.Configuration.Configuration GetConfig()
        {
            return WebConfigurationManager.OpenWebConfiguration((HttpContext.Current.Request.ApplicationPath == "/") ? "/Lesktop" : (HttpContext.Current.Request.ApplicationPath + "/Lesktop"));
        }

        public static string MD5(string str)
        {
            return WC.Tool.Encrypt.MD5_32(str);
        }

        private static object ParseJson(JsonObject jsonObject)
        {
            Type type = jsonObject.GetType();
            if (type == typeof(JsonObjectCollection))
            {
                Hashtable val = new Hashtable();
                foreach (JsonObject subObj in jsonObject as JsonObjectCollection)
                {
                    val.Add(subObj.Name, ParseJson(subObj));
                }
                if (val.ContainsKey("__DataType"))
                {
                    if ((val["__DataType"] as string) == "Date")
                    {
                        return BaseDateTime.AddMilliseconds((double) val["__Value"]);
                    }
                    if ((val["__DataType"] as string) == "Exception")
                    {
                        return new Exception((val["__Value"] as Hashtable)["Message"] as string);
                    }
                }
                return val;
            }
            if (type == typeof(JsonArrayCollection))
            {
                List<object> val = new List<object>();
                foreach (JsonObject subObj in jsonObject as JsonArrayCollection)
                {
                    val.Add(ParseJson(subObj));
                }
                return val.ToArray();
            }
            if (type == typeof(JsonBooleanValue))
            {
                return jsonObject.GetValue();
            }
            if (type == typeof(JsonStringValue))
            {
                return jsonObject.GetValue();
            }
            if (type == typeof(JsonNumericValue))
            {
                return jsonObject.GetValue();
            }
            return null;
        }

        public static object ParseJson(string jsonText)
        {
            if (jsonText == "{}")
            {
                return new Hashtable();
            }
            if (!string.IsNullOrEmpty(jsonText))
            {
                JsonTextParser parser = new JsonTextParser();
                return ParseJson(parser.Parse(jsonText));
            }
            return null;
        }

        public static string RenderHashJson(params object[] ps)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("{");
            for (int i = 0; i < ps.Length; i += 2)
            {
                if (i > 0)
                {
                    builder.Append(",");
                }
                builder.AppendFormat("\"{0}\":", ps[i].ToString());
                RenderJson(builder, ps[i + 1]);
            }
            builder.Append("}");
            return builder.ToString();
        }

        public static void RenderHashJson(StringBuilder builder, params object[] ps)
        {
            builder.Append("{");
            for (int i = 0; i < ps.Length; i += 2)
            {
                if (i > 0)
                {
                    builder.Append(",");
                }
                builder.AppendFormat("\"{0}\":", ps[i].ToString());
                RenderJson(builder, ps[i + 1]);
            }
            builder.Append("}");
        }

        public static string RenderJson(object obj)
        {
            StringBuilder builder = new StringBuilder();
            RenderJson(builder, obj);
            return builder.ToString();
        }

        public static void RenderJson(StringBuilder builder, object obj)
        {
            if (obj == null)
            {
                builder.Append("null");
            }
            else if (obj is IRenderJson)
            {
                (obj as IRenderJson).RenderJson(builder);
            }
            else if (obj is Exception)
            {
                builder.AppendFormat("{{\"__DataType\":\"Exception\",\"__Value\":{{\"Name\":\"{0}\",\"Message\":\"{1}\"}}}}", obj.GetType().Name, TransferCharJavascript((obj as Exception).Message));
            }
            else if (obj.GetType() == typeof(DateTime))
            {
                DateTime val = (DateTime) obj;
                object[] CS_0_0001 = new object[4];
                CS_0_0001[0] = "__DataType";
                CS_0_0001[1] = "Date";
                CS_0_0001[2] = "__Value";
                TimeSpan CS_0_0002 = (TimeSpan) (val - BaseDateTime);
                CS_0_0001[3] = CS_0_0002.TotalMilliseconds;
                RenderHashJson(builder, CS_0_0001);
            }
            else
            {
                int count;
                if (obj is IDictionary)
                {
                    count = 0;
                    builder.Append("{");
                    foreach (DictionaryEntry ent in obj as IDictionary)
                    {
                        if (count > 0)
                        {
                            builder.Append(",");
                        }
                        builder.AppendFormat("\"{0}\":", TransferCharJavascript(ent.Key.ToString()));
                        RenderJson(builder, ent.Value);
                        count++;
                    }
                    builder.Append("}");
                }
                else if (obj is IList)
                {
                    IList list = obj as IList;
                    builder.Append("[");
                    for (int i = 0; i < list.Count; i++)
                    {
                        if (i > 0)
                        {
                            builder.Append(",");
                        }
                        RenderJson(builder, list[i]);
                    }
                    builder.Append("]");
                }
                else if (obj is ICollection)
                {
                    ICollection list = obj as ICollection;
                    builder.Append("[");
                    count = 0;
                    foreach (object val in list)
                    {
                        if (count > 0)
                        {
                            builder.Append(",");
                        }
                        RenderJson(builder, val);
                        count++;
                    }
                    builder.Append("]");
                }
                else if (obj is DataRow)
                {
                    DataRow row = obj as DataRow;
                    builder.Append("{");
                    count = 0;
                    foreach (DataColumn column in row.Table.Columns)
                    {
                        if (count > 0)
                        {
                            builder.Append(",");
                        }
                        builder.AppendFormat("\"{0}\":", column.ColumnName);
                        RenderJson(builder, row[column.ColumnName]);
                        count++;
                    }
                    builder.Append("}");
                }
                else if (obj is Rectangle)
                {
                    Rectangle rect = (Rectangle) obj;
                    RenderHashJson(builder, new object[] { "Left", rect.Left, "Top", rect.Top, "Width", rect.Width, "Height", rect.Height });
                }
                else if (((((obj is ushort) || (obj is uint)) || ((obj is ulong) || (obj is short))) || (((obj is int) || (obj is long)) || ((obj is double) || (obj is decimal)))) || (obj is long))
                {
                    builder.Append(obj.ToString());
                }
                else if (obj is bool)
                {
                    builder.Append(((bool) obj) ? "true" : "false");
                }
                else
                {
                    builder.Append("\"");
                    builder.Append(TransferCharJavascript(obj.ToString()));
                    builder.Append("\"");
                }
            }
        }

        public static string ReplaceChar(Match match)
        {
            ushort ascii;
            if (match.Length == 4)
            {
                ascii = ushort.Parse(match.Value.Substring(2, 2), NumberStyles.HexNumber);
            }
            else
            {
                ascii = ushort.Parse(match.Value.Substring(2, 4), NumberStyles.HexNumber);
            }
            return Convert.ToChar(ascii).ToString();
        }

        public static unsafe Bitmap ToGray(Bitmap bmp, int mode)
        {
            if (bmp == null)
            {
                return null;
            }
            int w = bmp.Width;
            int h = bmp.Height;
            try
            {
                byte newColor = 0;
                BitmapData srcData = bmp.LockBits(new Rectangle(0, 0, w, h), ImageLockMode.ReadWrite, PixelFormat.Format24bppRgb);
                byte* p = (byte*) srcData.Scan0.ToPointer();
                for (int y = 0; y < h; y++)
                {
                    for (int x = 0; x < w; x++)
                    {
                        if (mode == 0)
                        {
                            newColor = (byte) (((p[0] * 0.114f) + (p[1] * 0.587f)) + (p[2] * 0.299f));
                        }
                        else
                        {
                            newColor = (byte) (((float) ((p[0] + p[1]) + p[2])) / 3f);
                        }
                        p[0] = newColor;
                        p[1] = newColor;
                        p[2] = newColor;
                        p += 3;
                    }
                    p += srcData.Stride - (w * 3);
                }
                bmp.UnlockBits(srcData);
                return bmp;
            }
            catch
            {
                return null;
            }
        }

        public static string TransferCharForXML(string s)
        {
            StringBuilder ret = new StringBuilder();
            foreach (char c in s)
            {
                switch (c)
                {
                    case '<':
                    case '>':
                    case '\\':
                    case '\'':
                    case '\t':
                    case '\n':
                    case '\v':
                    case '\f':
                    case '\r':
                    case '"':
                        ret.AppendFormat("&#{0};", (int) c);
                        break;

                    default:
                        ret.Append(c);
                        break;
                }
            }
            return ret.ToString();
        }

        public static string TransferCharJavascript(string s)
        {
            StringBuilder ret = new StringBuilder();
            foreach (char c in s)
            {
                switch (c)
                {
                    case '<':
                    case '>':
                    case '\\':
                    case '\'':
                    case '\t':
                    case '\n':
                    case '\v':
                    case '\f':
                    case '\r':
                    case '"':
                    case '\0':
                        ret.AppendFormat(@"\u{0:X4}", (int) c);
                        break;

                    default:
                        ret.Append(c);
                        break;
                }
            }
            return ret.ToString();
        }
    }
}

