using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.Cryptography;

namespace WC.Tool
{
    /// <summary>
    /// ���ܽ�����
    /// </summary>
    public class Encrypt
    {
        //DES��һ��Կ (key 1)(key 2��Ϊ���������Զ�������) ����Ϊ����Ҫ���� ������� ����
        private static byte[] Keys = { 0x5F, 0x31, 0x26, 0xC8, 0x8C, 0xDB, 0xCA, 0xE7 };

        //DES ��һ�ڶ������Կ(���㡢����������)
        private static string _UrlKey = "c07j30bg"; //URL�����������Key

        #region ���ַ������� (ASCII������)
        /// <summary>
        /// ���ַ������� ascii + 3
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
        /// ���ַ������� ascii - 3
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
        /// �����1���� (������ASCIIһ�� +1)
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
        /// ˳���1���� (������ASCIIһ�� -1)
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

        #region ��ϣϵ�м���(MD5/SHA256)
        /// <summary>
        /// MD5���� (16λ)
        /// </summary>
        /// <param name="str">ԭʼ�ַ���</param>
        /// <returns>MD5���</returns>
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
        /// MD5���� (32λ)
        /// </summary>
        /// <param name="str">ԭʼ�ַ���</param>
        /// <returns>MD5���</returns>
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
        /// SHA256����
        /// </summary>
        /// /// <param name="str">ԭʼ�ַ���</param>
        /// <returns>SHA256���</returns>
        public static string SHA256(string str)
        {
            byte[] SHA256Data = Encoding.UTF8.GetBytes(str);
            SHA256Managed Sha256 = new SHA256Managed();
            byte[] Result = Sha256.ComputeHash(SHA256Data);
            return Convert.ToBase64String(Result);  //���س���Ϊ44�ֽڵ��ַ���
            //return System.BitConverter.ToString(Result).Replace("-", "");  
            //StringBuilder sb = new StringBuilder();
            //for (int i = 0; i < Result.Length; i++)
            //{
            //    sb.AppendFormat("{0:X2}", Result[i]);
            //}
            //return sb.ToString(); //����64�ֽڵ��ַ���
        }
        #endregion

        #region DES(����Կ Base64����)����

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

        #region DES(����Կ)����

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
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();  //���ַ����ŵ�byte������   

            byte[] inputByteArray = Encoding.Default.GetBytes(pToEncrypt);
            //byte[]  inputByteArray=Encoding.Unicode.GetBytes(pToEncrypt);   

            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //�������ܶ������Կ��ƫ���� 
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);   //ԭ��ʹ��ASCIIEncoding.ASCII������GetBytes����  
            MemoryStream ms = new MemoryStream();     //ʹ�����������������Ӣ���ı� 
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

            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //�������ܶ������Կ��ƫ��������ֵ��Ҫ�������޸�   
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);

            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            StringBuilder ret = new StringBuilder();  //����StringBuild����CreateDecryptʹ�õ��������󣬱���ѽ��ܺ���ı����������   

            return System.Text.Encoding.Default.GetString(ms.ToArray());
        }
        #endregion

    }
}
