using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Bas_ComInfo
    {
      #region 构造函数
      public Bas_ComInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private string _ComName;
      private DateTime _AddTime;
      private int _MsgState;
      private string _Notes;
      private int _IsLock;
      private DateTime _StartTime;
      private DateTime _EndTime;
      private string _WebUrl;
      private string _Logo;

      private int _BBSState;

      private int _ComTypeID;

      public int ComTypeID
      {
          get { return _ComTypeID; }
          set { _ComTypeID = value; }
      }

      public int BBSState
      {
          get { return _BBSState; }
          set { _BBSState = value; }
      }

      public string Logo
      {
          get { return _Logo; }
          set { _Logo = value; }
      }

      public string WebUrl
      {
          get { return _WebUrl; }
          set { _WebUrl = value; }
      }

      private int _et1;

      public int et1
      {
          get { return _et1; }
          set { _et1 = value; }
      }
      private int _et2;

      public int et2
      {
          get { return _et2; }
          set { _et2 = value; }
      }
      private int _et3;

      public int et3
      {
          get { return _et3; }
          set { _et3 = value; }
      }

      private string _et4;

      public string et4
      {
          get { return _et4; }
          set { _et4 = value; }
      }
      private string _et5;

      public string et5
      {
          get { return _et5; }
          set { _et5 = value; }
      }
      private string _et6;

      public string et6
      {
          get { return _et6; }
          set { _et6 = value; }
      }

      private int _TipsState;

      public int TipsState
      {
          get { return _TipsState; }
          set { _TipsState = value; }
      }

      private int _ValidCodeState;

      public int ValidCodeState
      {
          get { return _ValidCodeState; }
          set { _ValidCodeState = value; }
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

      public  string ComName
      {
         get {  return _ComName; }
         set {  _ComName = value; }
      }

      public  DateTime AddTime
      {
         get {  return _AddTime; }
         set {  _AddTime = value; }
      }

      public int MsgState
      {
          get { return _MsgState; }
          set { _MsgState = value; }
      }

      public  string Notes
      {
         get {  return _Notes; }
         set {  _Notes = value; }
      }

      public  int IsLock
      {
         get {  return _IsLock; }
         set {  _IsLock = value; }
      }

      public  DateTime StartTime
      {
         get {  return _StartTime; }
         set {  _StartTime = value; }
      }

      public  DateTime EndTime
      {
         get {  return _EndTime; }
         set {  _EndTime = value; }
      }

      #endregion
    }
}
