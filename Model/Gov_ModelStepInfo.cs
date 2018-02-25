using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_ModelStepInfo
    {

      public Gov_ModelStepInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }


      #region 成员
      private int _id;
      private string _guid;
      private int _Flow_ModelID;
      private string _Step_Name;
      private string _Step_Remark;
      private int _Step_Orders;
      private int _RightToFinish;
      private int _MailAlert;
      private int _IsEnd;
      private int _IsHead;
      private int _IsUserEdit;
      private int _IsUserFile;
      private int _Step_Type;
      private string _UserList;
      private string _NameList;
      private string _UserList_dep;
      private string _NameList_dep;

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

      public  int Flow_ModelID
      {
         get {  return _Flow_ModelID; }
         set {  _Flow_ModelID = value; }
      }

      public  string Step_Name
      {
         get {  return _Step_Name; }
         set {  _Step_Name = value; }
      }

      public  string Step_Remark
      {
         get {  return _Step_Remark; }
         set {  _Step_Remark = value; }
      }

      public  int Step_Orders
      {
         get {  return _Step_Orders; }
         set {  _Step_Orders = value; }
      }

      public  int RightToFinish
      {
         get {  return _RightToFinish; }
         set {  _RightToFinish = value; }
      }

      public  int MailAlert
      {
         get {  return _MailAlert; }
         set {  _MailAlert = value; }
      }

      public  int IsEnd
      {
         get {  return _IsEnd; }
         set {  _IsEnd = value; }
      }

      public  int IsHead
      {
         get {  return _IsHead; }
         set {  _IsHead = value; }
      }

      public  int IsUserEdit
      {
         get {  return _IsUserEdit; }
         set {  _IsUserEdit = value; }
      }

      public  int IsUserFile
      {
         get {  return _IsUserFile; }
         set {  _IsUserFile = value; }
      }

      public  int Step_Type
      {
         get {  return _Step_Type; }
         set {  _Step_Type = value; }
      }

      public  string UserList
      {
         get {  return _UserList; }
         set {  _UserList = value; }
      }

      public  string NameList
      {
         get {  return _NameList; }
         set {  _NameList = value; }
      }

      public  string UserList_dep
      {
         get {  return _UserList_dep; }
         set {  _UserList_dep = value; }
      }

      public  string NameList_dep
      {
         get {  return _NameList_dep; }
         set {  _NameList_dep = value; }
      }

      #endregion

    }
}
