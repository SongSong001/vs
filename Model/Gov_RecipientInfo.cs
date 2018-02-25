using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_RecipientInfo
    {

      public Gov_RecipientInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }



      #region 成员
      private int _id;
      private string _guid;
      private int _Flow_ID;
      private int _UserID;
      private string _UserRealName;
      private string _UserDepName;
      private int _Sign;
      private string _FeedBack;
      private DateTime _SignTime;

      private int _ComID;

      public int ComID
      {
          get { return _ComID; }
          set { _ComID = value; }
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

      public  int Sign
      {
         get {  return _Sign; }
         set {  _Sign = value; }
      }

      public  string FeedBack
      {
         get {  return _FeedBack; }
         set {  _FeedBack = value; }
      }

      public  DateTime SignTime
      {
         get {  return _SignTime; }
         set {  _SignTime = value; }
      }

      #endregion

    }
}
