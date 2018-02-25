using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_ModelFileInfo
    {
      public Gov_ModelFileInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }


      #region 成员
      private int _id;
      private string _guid;
      private string _FormTitle;
      private string _FilePath = "";
      private int _CreatorID;
      private string _CreatorRealName;
      private string _CreatorDepName;
      private DateTime _AddTime;

      private int _ComID;

      public int ComID
      {
          get { return _ComID; }
          set { _ComID = value; }
      }

      private string _DocBody;

      public string DocBody
      {
          get { return _DocBody; }
          set { _DocBody = value; }
      }
      #endregion


      #region 属性
      public  int id
      {
         get {  return _id; }
         set {  _id = value; }
      }

      public  string guid
      {
         get {  return _guid; }
         set {  _guid = value; }
      }

      public  string FormTitle
      {
         get {  return _FormTitle; }
         set {  _FormTitle = value; }
      }

      public  string FilePath
      {
         get {  return _FilePath; }
         set {  _FilePath = value; }
      }

      public  int CreatorID
      {
         get {  return _CreatorID; }
         set {  _CreatorID = value; }
      }

      public  string CreatorRealName
      {
         get {  return _CreatorRealName; }
         set {  _CreatorRealName = value; }
      }

      public  string CreatorDepName
      {
         get {  return _CreatorDepName; }
         set {  _CreatorDepName = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      #endregion

    }
}
