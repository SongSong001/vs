using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_DocInfo
    {
      public Gov_DocInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }


      #region 成员
      private int _id;
      private string _guid;
      private int _Flow_ID;
      private int _StepAction_ID;
      private int _UserID;
      private string _UserRealName;
      private string _UserDepName;
      private string _DocPath;
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

      public  int Flow_ID
      {
         get {  return _Flow_ID; }
         set {  _Flow_ID = value; }
      }

      public  int StepAction_ID
      {
         get {  return _StepAction_ID; }
         set {  _StepAction_ID = value; }
      }

      public  int UserID
      {
         get {  return _UserID; }
         set {  _UserID = value; }
      }

      public  string UserRealName
      {
         get {  return _UserRealName; }
         set {  _UserRealName = value; }
      }

      public  string UserDepName
      {
         get {  return _UserDepName; }
         set {  _UserDepName = value; }
      }

      public  string DocPath
      {
         get {  return _DocPath; }
         set {  _DocPath = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      #endregion

    }
}
