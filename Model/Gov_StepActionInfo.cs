using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Gov_StepActionInfo
    {

      public Gov_StepActionInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }


      #region 成员
      private int _id;
      private string _guid;
      private int _UserID;
      private string _UserRealName;
      private string _UserDepName;
      private int _Operation;
      private string _OperationWord;
      private int _OperationStepID;
      private string _OperationStepName;
      private int _BackStepID;
      private int _FlowID;
      private DateTime _AddTime;

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

      public  int Operation
      {
         get {  return _Operation; }
         set {  _Operation = value; }
      }

      public  string OperationWord
      {
         get {  return _OperationWord; }
         set {  _OperationWord = value; }
      }

      public  int OperationStepID
      {
         get {  return _OperationStepID; }
         set {  _OperationStepID = value; }
      }

      public  string OperationStepName
      {
         get {  return _OperationStepName; }
         set {  _OperationStepName = value; }
      }

      public  int BackStepID
      {
         get {  return _BackStepID; }
         set {  _BackStepID = value; }
      }

      public  int FlowID
      {
         get {  return _FlowID; }
         set {  _FlowID = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      #endregion

    }
}
