namespace Core.Text
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;
    using System.Text.RegularExpressions;

    public class TextTemplate
    {
        private string[] _contentParts;
        private int _tagCount;
        private TextTemplateTag[] _tags;

        private TextTemplate()
        {
            this._tagCount = 0;
            this._tags = null;
            this._contentParts = null;
        }

        public TextTemplate(string content)
        {
            this.FromString(content);
        }

        public TextTemplate(string file, Encoding encoding)
        {
            StreamReader sr = new StreamReader(file, encoding);
            try
            {
                string content = sr.ReadToEnd();
                this.FromString(content);
            }
            catch (Exception)
            {
                sr.Close();
                throw;
            }
            sr.Close();
        }

        private void FromString(string content)
        {
            MatchCollection mc = Regex.Matches(content, @"{\w+}");
            this._tagCount = mc.Count;
            this._tags = new TextTemplateTag[mc.Count];
            this._contentParts = new string[mc.Count + 1];
            int index = 0;
            foreach (Match m in mc)
            {
                this._tags[index++] = new TextTemplateTag(m.Value.Substring(1, m.Value.Length - 2), m.Index, m.Length);
            }
            int start = 0;
            index = 0;
            foreach (TextTemplateTag con in this._tags)
            {
                this._contentParts[index] = content.Substring(start, con.Position - start);
                start = con.Position + con.Length;
                index++;
            }
            if (start < content.Length)
            {
                this._contentParts[index] = content.Substring(start);
            }
        }

        public string Render(Hashtable values)
        {
            StringBuilder result = new StringBuilder(0x2000);
            int i = 0;
            i = 0;
            while (i < this._tagCount)
            {
                result.Append(this._contentParts[i]);
                if (values[this._tags[i].Name] != null)
                {
                    result.Append(values[this._tags[i].Name]);
                }
                else
                {
                    result.Append("{" + this._tags[i].Name + "}");
                }
                i++;
            }
            result.Append(this._contentParts[i]);
            return result.ToString();
        }

        public string Render(params object[] args)
        {
            StringBuilder result = new StringBuilder(0x800);
            int i = 0;
            i = 0;
            while (i < this._tagCount)
            {
                result.Append(this._contentParts[i]);
                result.Append(args[i].ToString());
                i++;
            }
            result.Append(this._contentParts[i]);
            return result.ToString();
        }

        public void SaveAs(string file, Encoding encoding, Hashtable values)
        {
            StreamWriter sw = new StreamWriter(file, false, encoding);
            try
            {
                string content = this.Render(values);
                sw.Write(content);
            }
            catch (Exception)
            {
                sw.Close();
                throw;
            }
            sw.Close();
        }

        public void SaveAs(string file, Encoding encoding, params object[] args)
        {
            StreamWriter sw = new StreamWriter(file, false, encoding);
            try
            {
                string content = this.Render(args);
                sw.Write(content);
            }
            catch (Exception)
            {
                sw.Close();
                throw;
            }
            sw.Close();
        }

        public TextTemplate[] Split(string splitTag)
        {
            List<TextTemplate> temps = new List<TextTemplate>();
            List<string> contentParts = new List<string>();
            List<TextTemplateTag> tags = new List<TextTemplateTag>();
            int i = 0;
            foreach (string content in this._contentParts)
            {
                contentParts.Add(content);
                if ((i >= this._tags.Length) || (this._tags[i].Name == splitTag))
                {
                    TextTemplate newTemp = new TextTemplate();
                    newTemp._contentParts = contentParts.ToArray();
                    newTemp._tags = tags.ToArray();
                    newTemp._tagCount = tags.Count;
                    temps.Add(newTemp);
                    contentParts.Clear();
                    tags.Clear();
                }
                else
                {
                    tags.Add(new TextTemplateTag(this._tags[i].Name, this._tags[i].Position, this._tags[i].Length));
                }
                i++;
            }
            return temps.ToArray();
        }
    }
}

