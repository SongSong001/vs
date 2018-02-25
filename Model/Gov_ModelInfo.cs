using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_ModelInfo
    {

      public Gov_ModelInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      #region 成员
      private int _id;
      private string _guid;
      private string _Flow_Name;
      private int _CreatorID;
      private string _CreatorRealName;
      private string _CreatorDepName;
      private string _Remark;
      private string _ModelFileID;
      private DateTime _AddTime;
      private int _IsComplete;

      private int _ComID;

      public int ComID
      {
          get { return _ComID; }
          set { _ComID = value; }
      }

      private string _ShareDeps;

      public string ShareDeps
      {
          get { return _ShareDeps; }
          set { _ShareDeps = value; }
      }

      private string _namelist;

      public string namelist
      {
          get { return _namelist; }
          set { _namelist = value; }
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

      public  string Flow_Name
      {
         get {  return _Flow_Name; }
         set {  _Flow_Name = value; }
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

      public  string Remark
      {
         get {  return _Remark; }
         set {  _Remark = value; }
      }

      public  string ModelFileID
      {
         get {  return _ModelFileID; }
         set {  _ModelFileID = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      public  int IsComplete
      {
         get {  return _IsComplete; }
         set {  _IsComplete = value; }
      }

      #endregion


    }
}
