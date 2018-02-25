using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.IO;

namespace WC.Tool
{
    /// <summary>
    /// ͼƬλ��
    /// </summary>
    public enum ImagePosition
    {
        LeftTop,        //����
        LeftBottom,    //����
        RightTop,       //����
        RigthBottom,  //����
        TopMiddle,     //��������
        BottomMiddle, //�ײ�����
        Center           //����
    }

    /// <summary>
    /// ˮӡͼƬ�Ĳ���������
    /// </summary>
    public class WaterImageManage
    {
        /// <summary>
        /// ����һ���µ�ˮӡͼƬ����ʵ��
        /// </summary>
        public WaterImageManage() { }

        #region ���ͼƬˮӡ
        /// <summary>
        /// ���ͼƬˮӡ
        /// </summary>
        /// <param name="sourcePicture">ԴͼƬ�ļ�path</param>
        /// <param name="waterImage">ˮӡͼƬ�ļ�path</param>
        /// <param name="alpha">͸����(0.1-1.0��ֵԽС͸����Խ��)</param>
        /// <param name="position">λ��</param>
        /// <param name="PicturePath" >����ͼƬ��fullName</param>
        /// <returns>����������ָ���ļ����µ�ˮӡ�ļ���</returns>
        public static void DrawImage(string sourcePicture,
                                          string waterImage,
                                          float alpha,
                                          ImagePosition position,
                                          string PicturePath)
        {
            // ԴͼƬ��ˮӡͼƬȫ·��
            string sourcePictureName = sourcePicture;
            string waterPictureName = waterImage;
            string fileSourceExtension = System.IO.Path.GetExtension(sourcePictureName).ToLower();
            string fileWaterExtension = System.IO.Path.GetExtension(waterPictureName).ToLower();

            // Ŀ��ͼƬ���Ƽ�ȫ·��
            string targetImage = PicturePath;

            // ����Ҫ����ˮӡ��ͼƬװ�ص�Image������
            Image imgPhoto = Image.FromFile(sourcePictureName);
            // ȷ���䳤��
            int phWidth = imgPhoto.Width;
            int phHeight = imgPhoto.Height;

            // ��װ GDI+ λͼ����λͼ��ͼ��ͼ�������Ե�����������ɡ�
            Bitmap bmPhoto = new Bitmap(phWidth, phHeight, PixelFormat.Format24bppRgb);

            // �趨�ֱ���

            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            // ����һ����ͼ��������װ��λͼ
            Graphics grPhoto = Graphics.FromImage(bmPhoto);

            //ͬ��������ˮӡ��ͼƬ������Ҳ��Ҫ����һ��Image��װ����
            Image imgWatermark = new Bitmap(waterPictureName);

            // ��ȡˮӡͼƬ�ĸ߶ȺͿ��
            int wmWidth = imgWatermark.Width;
            int wmHeight = imgWatermark.Height;

            //SmoothingMode��ָ���Ƿ�ƽ������������ݣ�Ӧ����ֱ�ߡ����ߺ����������ı�Ե��
            // ��Ա����   ˵�� 
            // AntiAlias      ָ��������ݵĳ��֡�  
            // Default        ָ����������ݡ�  
            // HighQuality  ָ�������������ٶȳ��֡�  
            // HighSpeed   ָ�����ٶȡ����������֡�  
            // Invalid        ָ��һ����Чģʽ��  
            // None          ָ����������ݡ� 
            grPhoto.SmoothingMode = SmoothingMode.AntiAlias;

            // ��һ����棬�����ǵĵ�ͼ����ڻ�ͼ������
            grPhoto.DrawImage(imgPhoto,
                                        new Rectangle(0, 0, phWidth, phHeight),
                                        0,
                                        0,
                                        phWidth,
                                        phHeight,
                                        GraphicsUnit.Pixel);

            // ���ͼһ����������Ҫһ��λͼ��װ��ˮӡͼƬ�����趨��ֱ���
            Bitmap bmWatermark = new Bitmap(bmPhoto);
            bmWatermark.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            // ��������ˮӡͼƬװ�ص�һ����ͼ����grWatermark
            Graphics grWatermark = Graphics.FromImage(bmWatermark);

            //ImageAttributes ��������й��ڳ���ʱ��β���λͼ��ͼԪ�ļ���ɫ����Ϣ��    
            ImageAttributes imageAttributes = new ImageAttributes();

            //Colormap: ����ת����ɫ��ӳ��
            ColorMap colorMap = new ColorMap();

            //�ҵ�ˮӡͼ�������ӵ����ɫ����ɫ��ͼƬ���滻��͸��
            colorMap.OldColor = Color.FromArgb(255, 0, 255, 0);
            colorMap.NewColor = Color.FromArgb(0, 0, 0, 0);

            ColorMap[] remapTable = { colorMap };

            imageAttributes.SetRemapTable(remapTable, ColorAdjustType.Bitmap);

            float[][] colorMatrixElements = { 
           new float[] {1.0f,  0.0f,  0.0f,  0.0f, 0.0f}, // red��ɫ
           new float[] {0.0f,  1.0f,  0.0f,  0.0f, 0.0f}, //green��ɫ
           new float[] {0.0f,  0.0f,  1.0f,  0.0f, 0.0f}, //blue��ɫ       
           new float[] {0.0f,  0.0f,  0.0f,  alpha, 0.0f}, //͸����     
           new float[] {0.0f,  0.0f,  0.0f,  0.0f, 1.0f}};//

            //  ColorMatrix:������� RGBA �ռ������ 5 x 5 ����
            //  ImageAttributes ������ɷ���ͨ��ʹ����ɫ�������ͼ����ɫ��
            ColorMatrix wmColorMatrix = new ColorMatrix(colorMatrixElements);


            imageAttributes.SetColorMatrix(wmColorMatrix, ColorMatrixFlag.Default,
             ColorAdjustType.Bitmap);

            //������������ɫ�����濪ʼ����λ��
            int xPosOfWm;
            int yPosOfWm;

            switch (position)
            {
                case ImagePosition.BottomMiddle:
                    xPosOfWm = (phWidth - wmWidth) / 2;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.Center:
                    xPosOfWm = (phWidth - wmWidth) / 2;
                    yPosOfWm = (phHeight - wmHeight) / 2;
                    break;
                case ImagePosition.LeftBottom:
                    xPosOfWm = 10;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.LeftTop:
                    xPosOfWm = 10;
                    yPosOfWm = 10;
                    break;
                case ImagePosition.RightTop:
                    xPosOfWm = phWidth - wmWidth - 10;
                    yPosOfWm = 10;
                    break;
                case ImagePosition.RigthBottom:
                    xPosOfWm = phWidth - wmWidth - 10;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.TopMiddle:
                    xPosOfWm = (phWidth - wmWidth) / 2;
                    yPosOfWm = 10;
                    break;
                default:
                    xPosOfWm = 10;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
            }

            // �ڶ��λ�ͼ����ˮӡӡ��ȥ
            grWatermark.DrawImage(imgWatermark,
             new Rectangle(xPosOfWm,
                                 yPosOfWm,
                                 wmWidth,
                                 wmHeight),
                                 0,
                                 0,
                                 wmWidth,
                                 wmHeight,
                                 GraphicsUnit.Pixel,
                                 imageAttributes);

            Image tmp = imgPhoto;
            imgPhoto = bmWatermark;
            grPhoto.Dispose();
            grWatermark.Dispose();

            // �����ļ������������ļ�������
            imgPhoto.Save(targetImage, ImageFormat.Jpeg);
            imgPhoto.Dispose();
            bmWatermark.Dispose();
            imgWatermark.Dispose();
            tmp.Dispose();
            //return targetImage.Replace(PicturePath, "");
        }
        #endregion

        #region ��ͼƬ�����ˮӡ����
        /// <summary>
        /// ��ͼƬ�����ˮӡ����
        /// </summary>
        /// <param name="sourcePicture">ԴͼƬ�ļ�path</param>
        /// <param name="waterWords">��Ҫ��ӵ�ͼƬ�ϵ�����</param>
        /// <param name="alpha">͸����</param>
        /// <param name="position">λ��</param>
        /// <param name="PicturePath">�����ļ�fullName</param>
        /// <returns></returns>
        public static void DrawWords(string sourcePicture,
                                          string waterWords,
                                          double alpha,
                                          ImagePosition position,
                                          string PicturePath)
        {

            // ԴͼƬȫ·��
            string sourcePictureName = sourcePicture;
            string fileExtension = System.IO.Path.GetExtension(sourcePictureName).ToLower();

            // Ŀ��ͼƬ���Ƽ�ȫ·��
            string targetImage = PicturePath;

            //����һ��ͼƬ��������װ��Ҫ�����ˮӡ��ͼƬ
            Image imgPhoto = Image.FromFile(sourcePictureName);

            //��ȡͼƬ�Ŀ�͸�
            int phWidth = imgPhoto.Width;
            int phHeight = imgPhoto.Height;

            //����һ��bitmap����������Ҫ��ˮӡ��ͼƬһ����С
            Bitmap bmPhoto = new Bitmap(phWidth, phHeight, PixelFormat.Format24bppRgb);

            //SetResolution�����ô� Bitmap �ķֱ���
            //����ֱ�ӽ�������Ҫ���ˮӡ��ͼƬ�ķֱ��ʸ�����bitmap
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            //Graphics����װһ�� GDI+ ��ͼͼ�档
            Graphics grPhoto = Graphics.FromImage(bmPhoto);

            //����ͼ�ε�Ʒ��
            grPhoto.SmoothingMode = SmoothingMode.AntiAlias;

            //������Ҫ���ˮӡ��ͼƬ����ԭʼ��С��棨���ƣ���ͼ����
            grPhoto.DrawImage(
             imgPhoto,                                           //   Ҫ���ˮӡ��ͼƬ
             new Rectangle(0, 0, phWidth, phHeight), //  ����Ҫ��ӵ�ˮӡͼƬ�Ŀ�͸�
             0,                                                     //  X�����0�㿪ʼ���
             0,                                                     // Y���� 
             phWidth,                                            //  X������泤��
             phHeight,                                           //  Y������泤��
             GraphicsUnit.Pixel);                              // ���ĵ�λ�������õ�������

            //����ͼƬ�Ĵ�С������ȷ�������ȥ�����ֵĴ�С
            //���������Ƕ���һ��������ȷ��
            int[] sizes = new int[] { 16, 14, 12, 10, 8, 6, 4 };

            //����
            Font crFont = null;
            //���εĿ�Ⱥ͸߶ȣ�SizeF���������ԣ��ֱ�ΪHeight�ߣ�width��IsEmpty�Ƿ�Ϊ��
            SizeF crSize = new SizeF();

            //����һ��ѭ�������ѡ������Ҫ������ֵ��ͺ�
            //ֱ�����ĳ��ȱ�ͼƬ�Ŀ��С
            for (int i = 0; i < 7; i++)
            {
                crFont = new Font("arial", sizes[i], FontStyle.Bold);

                //������ָ���� Font ������Ʋ���ָ���� StringFormat �����ʽ����ָ���ַ�����
                crSize = grPhoto.MeasureString(waterWords, crFont);

                // ushort �ؼ��ֱ�ʾһ��������������
                if ((ushort)crSize.Width < (ushort)phWidth)
                    break;
            }

            //�ر�5%�ľ��룬����������ʾ(���ڲ�ͬ��ͼƬ��ʾ�ĸߺͿ�ͬ�����԰��ٷֱȽ�ȡ)
            int yPixlesFromBottom = (int)(phHeight * .05);

            //������ͼƬ�����ֵ�λ��
            float wmHeight = crSize.Height;
            float wmWidth = crSize.Width;

            float xPosOfWm;
            float yPosOfWm;

            switch (position)
            {
                case ImagePosition.BottomMiddle:
                    xPosOfWm = phWidth / 2;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.Center:
                    xPosOfWm = phWidth / 2;
                    yPosOfWm = phHeight / 2;
                    break;
                case ImagePosition.LeftBottom:
                    xPosOfWm = wmWidth;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.LeftTop:
                    xPosOfWm = wmWidth / 2;
                    yPosOfWm = wmHeight / 2;
                    break;
                case ImagePosition.RightTop:
                    xPosOfWm = phWidth - wmWidth - 10;
                    yPosOfWm = wmHeight;
                    break;
                case ImagePosition.RigthBottom:
                    xPosOfWm = phWidth - wmWidth - 10;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
                case ImagePosition.TopMiddle:
                    xPosOfWm = phWidth / 2;
                    yPosOfWm = wmWidth;
                    break;
                default:
                    xPosOfWm = wmWidth;
                    yPosOfWm = phHeight - wmHeight - 10;
                    break;
            }

            //��װ�ı�������Ϣ������롢���ַ���� Tab ͣ��λ������ʾ��������ʡ�ԺŲ���͹��ұ�׼ (National) �����滻���� OpenType ���ܡ�
            StringFormat StrFormat = new StringFormat();

            //������Ҫӡ�����־��ж���
            StrFormat.Alignment = StringAlignment.Center;

            //SolidBrush:���嵥ɫ���ʡ������������ͼ����״������Ρ���Բ�����Ρ�����κͷ��·����
            //�������Ϊ�����Ӱ�Ļ��ʣ��ʻ�ɫ
            int m_alpha = Convert.ToInt32(256 * alpha);
            SolidBrush semiTransBrush2 = new SolidBrush(Color.FromArgb(m_alpha, 0, 0, 0));

            //���������Ϣ�����ͼ�����Һ�����ƫ��һ�����أ���ʾ��ӰЧ��
            //DrawString ��ָ�����β�����ָ���� Brush �� Font �������ָ�����ı��ַ�����
            grPhoto.DrawString(waterWords,                                    //string of text
                                       crFont,                                         //font
                                       semiTransBrush2,                            //Brush
                                       new PointF(xPosOfWm + 1, yPosOfWm + 1),  //Position
                                       StrFormat);

            //���ĸ� ARGB ������alpha����ɫ����ɫ����ɫ��ֵ���� Color �ṹ����������͸����Ϊ153
            //�������Ϊ�����ʽ���ֵı�ˢ���ʰ�ɫ
            SolidBrush semiTransBrush = new SolidBrush(Color.FromArgb(153, 255, 255, 255));

            //�ڶ��λ������ͼ�Σ������ڵ�һ�����Ļ�����
            grPhoto.DrawString(waterWords,                 //string of text
                                       crFont,                                   //font
                                       semiTransBrush,                           //Brush
                                       new PointF(xPosOfWm, yPosOfWm),  //Position
                                       StrFormat);

            //imgPhoto�����ǽ���������װ������ͼ�ε�Image����
            //bmPhoto��������������ͼ�ε�������ΪBitmap����
            imgPhoto = bmPhoto;
            //�ͷ���Դ���������Graphicsʵ��grPhoto�ͷţ�grPhoto����Բ��
            grPhoto.Dispose();

            //��grPhoto����
            imgPhoto.Save(targetImage, ImageFormat.Jpeg);
            imgPhoto.Dispose();

            //return targetImage.Replace(PicturePath, "");
        }
        #endregion

    }


    /// <summary>
    /// װ��ˮӡͼƬ�������Ϣ
    /// </summary>
    public class WaterImage
    {
        public WaterImage()
        {

        }

        private string m_sourcePicture;
        /// <summary>
        /// ԴͼƬ��ַ����(����׺)
        /// </summary>
        public string SourcePicture
        {
            get { return m_sourcePicture; }
            set { m_sourcePicture = value; }
        }

        private string m_waterImager;
        /// <summary>
        /// ˮӡͼƬ����(����׺)
        /// </summary>
        public string WaterPicture
        {
            get { return m_waterImager; }
            set { m_waterImager = value; }
        }

        private float m_alpha;
        /// <summary>
        /// ˮӡͼƬ���ֵ�͸����
        /// </summary>
        public float Alpha
        {
            get { return m_alpha; }
            set { m_alpha = value; }
        }

        private ImagePosition m_postition;
        /// <summary>
        /// ˮӡͼƬ��������ͼƬ�е�λ��
        /// </summary>
        public ImagePosition Position
        {
            get { return m_postition; }
            set { m_postition = value; }
        }

        private string m_words;
        /// <summary>
        /// ˮӡ���ֵ�����
        /// </summary>
        public string Words
        {
            get { return m_words; }
            set { m_words = value; }
        }

    }
}