using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

namespace WC.Tool
{
    /// <summary>
    /// �ж�IP��������
    /// </summary>
    public class IpSearch
    {
        private static object lockHelper = new object();

        static PHCZIP pcz = new PHCZIP();

        static string filePath = "";

        static bool fileIsExsit = true;

        static IpSearch()
        {
            filePath = HttpContext.Current.Server.MapPath("~/pic/ipdata.config");
            pcz.SetDbFilePath(filePath);
        }

        /// <summary>
        /// ����IP���ҽ��
        /// </summary>
        /// <param name="IPValue">Ҫ���ҵ�IP��ַ</param>
        /// <returns></returns>
        public static string GetAddressWithIP(string IPValue)
        {
            lock (lockHelper)
            {
                string result = pcz.GetAddressWithIP(IPValue.Trim());

                if (fileIsExsit)
                {
                    if (result.IndexOf("IANA") >= 0)
                    {
                        return "";
                    }
                    else
                    {
                        return result;
                    }
                }
                else
                {
                    return null;
                }
            }
        }

        /// <summary>
        /// �����࣬���ڱ���IP������Ϣ
        /// </summary>
        ///     
        public class CZ_INDEX_INFO
        {
            public UInt32 IpSet;
            public UInt32 IpEnd;
            public UInt32 Offset;

            public CZ_INDEX_INFO()
            {
                IpSet = 0;
                IpEnd = 0;
                Offset = 0;
            }
        }

        //��ȡ����IP���ݿ���
        public class PHCZIP
        {
            protected bool bFilePathInitialized;
            protected string FilePath;
            protected FileStream FileStrm;
            protected UInt32 Index_Set;
            protected UInt32 Index_End;
            protected UInt32 Index_Count;
            protected UInt32 Search_Index_Set;
            protected UInt32 Search_Index_End;
            protected CZ_INDEX_INFO Search_Set;
            protected CZ_INDEX_INFO Search_Mid;
            protected CZ_INDEX_INFO Search_End;

            public PHCZIP()
            {
                bFilePathInitialized = false;
            }

            public PHCZIP(string dbFilePath)
            {
                bFilePathInitialized = false;
                SetDbFilePath(dbFilePath);
            }

            //ʹ�ö��ַ���������������ʼ����������
            public void Initialize()
            {
                Search_Index_Set = 0;
                Search_Index_End = Index_Count - 1;
            }

            //�ر��ļ�
            public void Dispose()
            {
                if (bFilePathInitialized)
                {
                    bFilePathInitialized = false;
                    FileStrm.Close();
                    //FileStrm.Dispose();
                }

            }


            public bool SetDbFilePath(string dbFilePath)
            {
                if (dbFilePath == "")
                {
                    return false;
                }

                try
                {
                    FileStrm = new FileStream(dbFilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                }
                catch
                {
                    return false;
                }
                //����ļ�����
                if (FileStrm.Length < 8)
                {
                    FileStrm.Close();
                    //FileStrm.Dispose();
                    return false;
                }
                //�õ���һ�������ľ���ƫ�ƺ����һ�������ľ���ƫ��
                FileStrm.Seek(0, SeekOrigin.Begin);
                Index_Set = GetUInt32();
                Index_End = GetUInt32();

                //�õ�����������
                Index_Count = (Index_End - Index_Set) / 7 + 1;
                bFilePathInitialized = true;

                return true;

            }

            public string GetAddressWithIP(string IPValue)
            {
                if (!bFilePathInitialized)
                {
                    return "";
                }

                Initialize();

                UInt32 ip = IPToUInt32(IPValue);

                while (true)
                {

                    //���ȳ�ʼ�����ֲ��ҵ�����

                    //����ͷ
                    Search_Set = IndexInfoAtPos(Search_Index_Set);
                    //����β
                    Search_End = IndexInfoAtPos(Search_Index_End);

                    //�ж�IP�Ƿ�������ͷ��
                    if (ip >= Search_Set.IpSet && ip <= Search_Set.IpEnd)
                        return ReadAddressInfoAtOffset(Search_Set.Offset);


                    //�ж�IP�Ƿ�������β��
                    if (ip >= Search_End.IpSet && ip <= Search_End.IpEnd)
                        return ReadAddressInfoAtOffset(Search_End.Offset);

                    //����������е�
                    Search_Mid = IndexInfoAtPos((Search_Index_End + Search_Index_Set) / 2);

                    //�ж�IP�Ƿ����е�
                    if (ip >= Search_Mid.IpSet && ip <= Search_Mid.IpEnd)
                        return ReadAddressInfoAtOffset(Search_Mid.Offset);

                    //����û���ҵ���׼����һ��
                    if (ip < Search_Mid.IpSet)
                        //IP�������е�ҪС��������β��Ϊ���ڵ��е㣬��������С1����
                        Search_Index_End = (Search_Index_End + Search_Index_Set) / 2;
                    else
                        //IP�������е�Ҫ�󣬽�����ͷ��Ϊ���ڵ��е㣬��������С1����
                        Search_Index_Set = (Search_Index_End + Search_Index_Set) / 2;
                }

                //return "";

            }


            private string ReadAddressInfoAtOffset(UInt32 Offset)
            {
                string country = "";
                string area = "";
                UInt32 country_Offset = 0;
                byte Tag = 0;
                //����4�ֽڣ�����4���ֽ��Ǹ�������IP�������ޡ�
                FileStrm.Seek(Offset + 4, SeekOrigin.Begin);

                //��ȡһ���ֽڣ��õ�����������Ϣ�ġ�Ѱַ��ʽ��
                Tag = GetTag();

                if (Tag == 0x01)
                {

                    //ģʽ0x01����ʾ��������3���ֽ��Ǳ�ʾƫ��λ��
                    FileStrm.Seek(GetOffset(), SeekOrigin.Begin);

                    //������顰Ѱַ��ʽ��
                    Tag = GetTag();
                    if (Tag == 0x02)
                    {
                        //ģʽ0x02����ʾ��������3���ֽڴ���������Ϣ��ƫ��λ��
                        //�Ƚ����ƫ��λ�ñ�����������Ϊ����Ҫ��ȡ������ĵ�����Ϣ��
                        country_Offset = GetOffset();
                        //��ȡ������Ϣ��ע������Luma��˵��������û����ô���ֿ����ԣ����ڲ��Թ����к�����Щ���û�п��ǵ���
                        //����д�˸�ReadArea()����ȡ��
                        area = ReadArea();
                        //��ȡ������Ϣ
                        FileStrm.Seek(country_Offset, SeekOrigin.Begin);
                        country = ReadString();
                    }
                    else
                    {
                        //����ģʽ˵�����������Ǳ���Ĺ��Һ͵�����Ϣ�ˣ���'\0'����������
                        FileStrm.Seek(-1, SeekOrigin.Current);
                        country = ReadString();
                        area = ReadArea();

                    }
                }
                else if (Tag == 0x02)
                {
                    //ģʽ0x02��˵��������Ϣ��һ��ƫ��λ��
                    country_Offset = GetOffset();
                    //�ȶ�ȡ������Ϣ
                    area = ReadArea();
                    //��ȡ������Ϣ
                    FileStrm.Seek(country_Offset, SeekOrigin.Begin);
                    country = ReadString();
                }
                else
                {
                    //����ģʽ����ˣ�ֱ�Ӷ�ȡ���Һ͵�����OK��
                    FileStrm.Seek(-1, SeekOrigin.Current);
                    country = ReadString();
                    area = ReadArea();

                }
                string Address = country + " " + area;
                return Address;

            }

            private UInt32 GetOffset()
            {
                byte[] TempByte4 = new byte[4];
                TempByte4[0] = (byte)FileStrm.ReadByte();
                TempByte4[1] = (byte)FileStrm.ReadByte();
                TempByte4[2] = (byte)FileStrm.ReadByte();
                TempByte4[3] = 0;
                return BitConverter.ToUInt32(TempByte4, 0);
            }

            protected string ReadArea()
            {
                byte Tag = GetTag();

                if (Tag == 0x01 || Tag == 0x02)
                {
                    FileStrm.Seek(GetOffset(), SeekOrigin.Begin);
                    return ReadString();
                }
                else
                {
                    FileStrm.Seek(-1, SeekOrigin.Current);
                    return ReadString();
                }
            }

            protected string ReadString()
            {
                UInt32 Offset = 0;
                byte[] TempByteArray = new byte[256];
                TempByteArray[Offset] = (byte)FileStrm.ReadByte();
                while (TempByteArray[Offset] != 0x00)
                {
                    Offset += 1;
                    TempByteArray[Offset] = (byte)FileStrm.ReadByte();
                }
                return System.Text.Encoding.Default.GetString(TempByteArray).TrimEnd('\0');
            }

            protected byte GetTag()
            {
                return (byte)FileStrm.ReadByte();
            }

            protected CZ_INDEX_INFO IndexInfoAtPos(UInt32 Index_Pos)
            {
                CZ_INDEX_INFO Index_Info = new CZ_INDEX_INFO();
                //����������ż�������ļ�����ƫ��λ��
                FileStrm.Seek(Index_Set + 7 * Index_Pos, SeekOrigin.Begin);
                Index_Info.IpSet = GetUInt32();
                Index_Info.Offset = GetOffset();
                FileStrm.Seek(Index_Info.Offset, SeekOrigin.Begin);
                Index_Info.IpEnd = GetUInt32();

                return Index_Info;
            }

            /// <summary>
            /// ��IPת��ΪInt32
            /// </summary>
            /// <param name="IpValue"></param>
            /// <returns></returns>
            public UInt32 IPToUInt32(string IpValue)
            {
                string[] IpByte = IpValue.Split('.');
                Int32 nUpperBound = IpByte.GetUpperBound(0);
                if (nUpperBound != 3)
                {
                    IpByte = new string[4];
                    for (Int32 i = 1; i <= 3 - nUpperBound; i++)
                        IpByte[nUpperBound + i] = "0";
                }

                byte[] TempByte4 = new byte[4];
                for (Int32 i = 0; i <= 3; i++)
                {
                    //'�����.Net 2.0����֧��TryParse��
                    //'If Not (Byte.TryParse(IpByte(i), TempByte4(3 - i))) Then
                    //'    TempByte4(3 - i) = &H0
                    //'End If
                    if (IsNumeric(IpByte[i]))
                        TempByte4[3 - i] = (byte)(Convert.ToInt32(IpByte[i]) & 0xff);
                }

                return BitConverter.ToUInt32(TempByte4, 0);
            }

            /// <summary>
            /// �ж��Ƿ�Ϊ����
            /// </summary>
            /// <param name="str">���ж��ַ���</param>
            /// <returns></returns>
            protected bool IsNumeric(string str)
            {
                if (str != null && System.Text.RegularExpressions.Regex.IsMatch(str, @"^-?\d+$"))
                    return true;
                else
                    return false;
            }

            protected UInt32 GetUInt32()
            {
                byte[] TempByte4 = new byte[4];
                FileStrm.Read(TempByte4, 0, 4);
                return BitConverter.ToUInt32(TempByte4, 0);
            }
        }

    }

}