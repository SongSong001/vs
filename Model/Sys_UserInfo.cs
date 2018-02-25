using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_UserInfo
    {
      #region 构造函数
      public Sys_UserInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      public Sys_UserInfo(int id,string guid,string UserName,string PassWord,string RealName,int Sex,string Birthday,string Phone,int RoleID,string RoleGUID,int DepID,string DepGUID,string DepName,string LastLoginIp,DateTime LastLoginTime,int LoginQuantity,int Status,int IsLock,string RegFromIp,DateTime RegTime,int ComID,string ComGUID,string Notes)
      {
         this._id=id;
         this._guid=guid;
         this._UserName=UserName;
         this._PassWord=PassWord;
         this._RealName=RealName;
         this._Sex=Sex;
         this._Birthday=Birthday;
         this._Phone=Phone;
         this._RoleID=RoleID;
         this._RoleGUID=RoleGUID;
         this._DepID=DepID;
         this._DepGUID=DepGUID;
         this._DepName=DepName;
         this._LastLoginIp=LastLoginIp;
         this._LastLoginTime=LastLoginTime;
         this._LoginQuantity=LoginQuantity;
         this._Status=Status;
         this._IsLock=IsLock;
         this._RegFromIp=RegFromIp;
         this._RegTime=RegTime;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
         this._Notes=Notes;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private string _UserName;
      private string _PassWord;
      private string _RealName;
      private int _Sex;
      private string _Birthday;
      private string _QQ;
      private string _Email;
      private string _Tel;
      private string _Phone;
      private int _RoleID;
      private string _RoleGUID;
      private int _DepID;
      private string _DepGUID;
      private string _DepName;
      private string _LastLoginIp;
      private DateTime _LastLoginTime;
      private int _LoginQuantity;
      private int _Status;
      private int _IsLock;
      private string _RegFromIp;
      private DateTime _RegTime;
      private int _ComID;
      private string _ComGUID;
      private string _Notes;

      private string _JoinTime;

      public string JoinTime
      {
          get { return _JoinTime; }
          set { _JoinTime = value; }
      }
      private int _DirectSupervisor;

      public int DirectSupervisor
      {
          get { return _DirectSupervisor; }
          set { _DirectSupervisor = value; }
      }

      private string _PositionName;

      public string PositionName
      {
          get { return _PositionName; }
          set { _PositionName = value; }
      }
      private string _HomeAddress;

      public string HomeAddress
      {
          get { return _HomeAddress; }
          set { _HomeAddress = value; }
      }

      private int _IsOnline = 0;

      public int IsOnline
      {
          get { return _IsOnline; }
          set { _IsOnline = value; }
      }

      private string _CurrentLoginTime = "";

      public string CurrentLoginTime
      {
          get { return _CurrentLoginTime; }
          set { _CurrentLoginTime = value; }
      }
      public string QQ
      {
          get { return _QQ; }
          set { _QQ = value; }
      }
      public string Email
      {
          get { return _Email; }
          set { _Email = value; }
      }

      private int _MsgTime;

      public int MsgTime
      {
          get { return _MsgTime; }
          set { _MsgTime = value; }
      }

      private int _MemoShare;

      public int MemoShare
      {
          get { return _MemoShare; }
          set { _MemoShare = value; }
      }
      private string _PerPic;

      public string PerPic
      {
          get { return _PerPic; }
          set { _PerPic = value; }
      }

      private int _Orders;

      public int Orders
      {
          get { return _Orders; }
          set { _Orders = value; }
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

      public  string UserName
      {
         get {  return _UserName; }
         set {  _UserName = value; }
      }

      public  string PassWord
      {
         get {  return _PassWord; }
         set {  _PassWord = value; }
      }

      public  string RealName
      {
         get {  return _RealName; }
         set {  _RealName = value; }
      }

      public  int Sex
      {
         get {  return _Sex; }
         set {  _Sex = value; }
      }

      public  string Birthday
      {
         get {  return _Birthday; }
         set {  _Birthday = value; }
      }

      public  string Phone
      {
         get {  return _Phone; }
         set {  _Phone = value; }
      }

      public string Tel
      {
          get { return _Tel; }
          set { _Tel = value; }
      }

      public  int RoleID
      {
         get {  return _RoleID; }
         set {  _RoleID = value; }
      }

      public  string RoleGUID
      {
         get {  return _RoleGUID; }
         set {  _RoleGUID = value; }
      }

      public  int DepID
      {
         get {  return _DepID; }
         set {  _DepID = value; }
      }

      public  string DepGUID
      {
         get {  return _DepGUID; }
         set {  _DepGUID = value; }
      }

      public  string DepName
      {
         get {  return _DepName; }
         set {  _DepName = value; }
      }

      public  string LastLoginIp
      {
         get {  return _LastLoginIp; }
         set {  _LastLoginIp = value; }
      }

      public  DateTime LastLoginTime
      {
         get {  return _LastLoginTime; }
         set {  _LastLoginTime = value; }
      }

      public  int LoginQuantity
      {
         get {  return _LoginQuantity; }
         set {  _LoginQuantity = value; }
      }

      public  int Status
      {
         get {  return _Status; }
         set {  _Status = value; }
      }

      public  int IsLock
      {
         get {  return _IsLock; }
         set {  _IsLock = value; }
      }

      public  string RegFromIp
      {
         get {  return _RegFromIp; }
         set {  _RegFromIp = value; }
      }

      public  DateTime RegTime
      {
         get {  return _RegTime; }
         set {  _RegTime = value; }
      }

      public  int ComID
      {
         get {  return _ComID; }
         set {  _ComID = value; }
      }

      public  string ComGUID
      {
         get {  return _ComGUID; }
         set {  _ComGUID = value; }
      }

      public  string Notes
      {
         get {  return _Notes; }
         set {  _Notes = value; }
      }

      #endregion

    }
}
