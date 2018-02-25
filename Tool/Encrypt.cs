using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.Cryptography;

namespace WC.Tool
{
    /// <summary>
    /// 加密解密类
    /// </summary>
    public class Encrypt
    {
        //DES第一密钥 (key 1)(key 2作为函数参数自定义设置) 可作为较重要数据 如密码等 加密
        private static byte[] Keys = { 0x5F, 0x31, 0x26, 0xC8, 0x8C, 0xDB, 0xCA, 0xE7 };

        //DES 第一第二相等密钥(方便、轻量级加密)
        private static string _UrlKey = "c07j30bg"; //URL传输参数加密Key

        #region 简单字符串加密 (ASCII码增减)
        /// <summary>
        /// 简单字符串加密 ascii + 3
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string SimpEncrypt(string str)
        {
            StringBuilder asc = new StringBuilder();
            for (int i = 0; i < str.Length; i++)
            {
                char a = char.Parse(str.Substring(i, 1));
                int b = (int)a + 3;
                asc.Append((char)b);
            }
            return asc.ToString();
        }

        /// <summary>
        /// 简单字符串解密 ascii - 3
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string SimpUnEncrypt(string str)
        {
            StringBuilder asc = new StringBuilder();
            for (int i = 0; i < str.Length; i++)
            {
                char a = char.Parse(str.Substring(i, 1));
                int b = (int)a - 3;
                asc.Append((char)b);
            }
            return asc.ToString();
        }

        /// <summary>
        /// 倒序加1加密 (和上面ASCII一样 +1)
        /// </summary>
        /// <param name="rs"></param>
        /// <returns></returns>
        public static string EncryptStr(string rs)
        {
            byte[] by = new byte[rs.Length];
            for (int i = 0; i <= rs.Length - 1; i++)
            {
                by[i] = (byte)((byte)rs[i] + 1);
            }
            rs = "";
            for (int i = by.Length - 1; i >= 0; i--)
            {
                rs += ((char)by[i]).ToString();
            }
            return rs;
        }

        /// <summary>
        /// 顺序减1解码 (和上面ASCII一样 -1)
        /// </summary>
        /// <param name="rs"></param>
        /// <returns></returns>
        public static string DecryptStr(string rs)
        {
            byte[] by = new byte[rs.Length];
            for (int i = 0; i <= rs.Length - 1; i++)
            {
                by[i] = (byte)((byte)rs[i] - 1);
            }
            rs = "";
            for (int i = by.Length - 1; i >= 0; i--)
            {
                rs += ((char)by[i]).ToString();
            }
            return rs;
        }
        #endregion

        #region 哈希系列加密(MD5/SHA256)
        /// <summary>
        /// MD5加密 (16位)
        /// </summary>
        /// <param name="str">原始字符串</param>
        /// <returns>MD5结果</returns>
        public static string MD5(string str)
        {
            byte[] b = Encoding.Default.GetBytes(str);
            b = new MD5CryptoServiceProvider().ComputeHash(b);
            string ret = "";
            for (int i = 0; i < b.Length; i++)
                ret += b[i].ToString("x").PadLeft(2, '0');
            string rett = ret.Substring(8, 16);
            return rett;
        }

        /// <summary>
        /// MD5加密 (32位)
        /// </summary>
        /// <param name="str">原始字符串</param>
        /// <returns>MD5结果</returns>
        public static string MD5_32(string str)
        {
            byte[] b = Encoding.Default.GetBytes(str);
            b = new MD5CryptoServiceProvider().ComputeHash(b);
            string ret = "";
            for (int i = 0; i < b.Length; i++)
                ret += b[i].ToString("x").PadLeft(2, '0');
            return ret;
        }

        /// <summary>
        /// SHA256加密
        /// </summary>
        /// /// <param name="str">原始字符串</param>
        /// <returns>SHA256结果</returns>
        public static string SHA256(string str)
        {
            byte[] SHA256Data = Encoding.UTF8.GetBytes(str);
            SHA256Managed Sha256 = new SHA256Managed();
            byte[] Result = Sha256.ComputeHash(SHA256Data);
            return Convert.ToBase64String(Result);  //返回长度为44字节的字符串
            //return System.BitConverter.ToString(Result).Replace("-", "");  
            //StringBuilder sb = new StringBuilder();
            //for (int i = 0; i < Result.Length; i++)
            //{
            //    sb.AppendFormat("{0:X2}", Result[i]);
            //}
            //return sb.ToString(); //返回64字节的字符串
        }
        #endregion

        #region DES(二密钥 Base64编码)加密

        public static string RC4_Encode(string encryptString, string encryptKey)
        {
            encryptKey = Utils.GetSubString(encryptKey, 8, "");
            encryptKey = encryptKey.PadRight(8, ' ');
            byte[] rgbKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
            byte[] rgbIV = Keys;
            byte[] inputByteArray = Encoding.UTF8.GetBytes(encryptString);
            DESCryptoServiceProvider dCSP = new DESCryptoServiceProvider();
            MemoryStream mStream = new MemoryStream();
            CryptoStream cStream = new CryptoStream(mStream, dCSP.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
            cStream.Write(inputByteArray, 0, inputByteArray.Length);
            cStream.FlushFinalBlock();
            return Convert.ToBase64String(mStream.ToArray());
        }

        public static string RC4_Decode(string decryptString, string decryptKey)
        {
            try
            {
                decryptKey = Utils.GetSubString(decryptKey, 8, "");
                decryptKey = decryptKey.PadRight(8, ' ');
                byte[] rgbKey = Encoding.UTF8.GetBytes(decryptKey);
                byte[] rgbIV = Keys;
                byte[] inputByteArray = Convert.FromBase64String(decryptString);
                DESCryptoServiceProvider DCSP = new DESCryptoServiceProvider();

                MemoryStream mStream = new MemoryStream();
                CryptoStream cStream = new CryptoStream(mStream, DCSP.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
                cStream.Write(inputByteArray, 0, inputByteArray.Length);
                cStream.FlushFinalBlock();
                return Encoding.UTF8.GetString(mStream.ToArray());
            }
            catch
            {
                return "";
            }
        }
        #endregion

        #region DES(单密钥)加密

        public static string DES_EnUrl(string UrlKey)
        {
            return DES_EncryptUrl(UrlKey, _UrlKey);
        }


        public static string DES_DeUrl(string UrlKey)
        {
            return DES_DecryptUrl(UrlKey, _UrlKey);
        }

        private static string DES_EncryptUrl(string pToEncrypt, string sKey)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();  //把字符串放到byte数组中   

            byte[] inputByteArray = Encoding.Default.GetBytes(pToEncrypt);
            //byte[]  inputByteArray=Encoding.Unicode.GetBytes(pToEncrypt);   

            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //建立加密对象的密钥和偏移量 
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);   //原文使用ASCIIEncoding.ASCII方法的GetBytes方法  
            MemoryStream ms = new MemoryStream();     //使得输入密码必须输入英文文本 
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);

            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            StringBuilder ret = new StringBuilder();
            foreach (byte b in ms.ToArray())
            {
                ret.AppendFormat("{0:X2}", b);
            }
            ret.ToString();
            return ret.ToString();
        }

        private static string DES_DecryptUrl(string pToDecrypt, string sKey)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();

            byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
            for (int x = 0; x < pToDecrypt.Length / 2; x++)
            {
                int i = (Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
                inputByteArray[x] = (byte)i;
            }

            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //建立加密对象的密钥和偏移量，此值重要，不能修改   
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);

            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            StringBuilder ret = new StringBuilder();  //建立StringBuild对象，CreateDecrypt使用的是流对象，必须把解密后的文本变成流对象   

            return System.Text.Encoding.Default.GetString(ms.ToArray());
        }
        #endregion

    }
}
