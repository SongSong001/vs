using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class GovInfo
    {

      public GovInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }



      #region 成员
      private int _id;
      private string _guid;
      private string _Flow_Name;
      private int _CurrentStepID;
      private string _CurrentStepName;
      private string _CurrentStepUserList;
      private string _HasOperatedUserList;
      private int _CreatorID;
      private string _CreatorRealName;
      private string _CreatorDepName;
      private string _Remark;
      private int _Status;
      private string _Flow_Files;
      private DateTime _AddTime;
      private DateTime _ValidTime;
      private int _IsValid;
      private string _CurrentDocPath;
      private string _RecieveDep;
      private string _DocNo;
      private string _Secret;
      private string _ModelName;

      public string ModelName
      {
          get { return _ModelName; }
          set { _ModelName = value; }
      }

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

      public  string Flow_Name
      {
         get {  return _Flow_Name; }
         set {  _Flow_Name = value; }
      }

      public  int CurrentStepID
      {
         get {  return _CurrentStepID; }
         set {  _CurrentStepID = value; }
      }

      public  string CurrentStepName
      {
         get {  return _CurrentStepName; }
         set {  _CurrentStepName = value; }
      }

      public  string CurrentStepUserList
      {
         get {  return _CurrentStepUserList; }
         set {  _CurrentStepUserList = value; }
      }

      public  string HasOperatedUserList
      {
         get {  return _HasOperatedUserList; }
         set {  _HasOperatedUserList = value; }
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

      public  int Status
      {
         get {  return _Status; }
         set {  _Status = value; }
      }

      public  string Flow_Files
      {
         get {  return _Flow_Files; }
         set {  _Flow_Files = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      public  DateTime ValidTime
      {
         get {  return _ValidTime; }
         set {  _ValidTime = value; }
      }

      public  int IsValid
      {
         get {  return _IsValid; }
         set {  _IsValid = value; }
      }

      public  string CurrentDocPath
      {
         get {  return _CurrentDocPath; }
         set {  _CurrentDocPath = value; }
      }

      public  string RecieveDep
      {
         get {  return _RecieveDep; }
         set {  _RecieveDep = value; }
      }

      public string DocNo
      {
          get { return _DocNo; }
          set { _DocNo = value; }
      }

      public string Secret
      {
          get { return _Secret; }
          set { _Secret = value; }
      }

      #endregion

    }
}
