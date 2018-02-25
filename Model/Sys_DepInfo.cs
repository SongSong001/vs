using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_DepInfo
    {
      #region 构造函数
      public Sys_DepInfo()
      {
          this._guid = Guid.NewGuid().ToString();
      }

      public Sys_DepInfo(int id,string guid,string DepName,string Notes,int ParentID,string ParentGUID,int IsPosition,int ComID,string ComGUID)
      {
         this._id=id;
         this._guid = Guid.NewGuid().ToString();
         this._DepName=DepName;
         this._Notes=Notes;
         this._ParentID=ParentID;
         this._ParentGUID=ParentGUID;
         this._IsPosition=IsPosition;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private string _DepName;
      private string _Notes;
      private int _ParentID;
      private string _ParentGUID;
      private int _IsPosition;
      private int _ComID;
      private string _ComGUID;
      private int _Orders;
      private string _Phone;
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

      public  string DepName
      {
         get {  return _DepName; }
         set {  _DepName = value; }
      }

      public  string Notes
      {
         get {  return _Notes; }
         set {  _Notes = value; }
      }

      public  int ParentID
      {
         get {  return _ParentID; }
         set {  _ParentID = value; }
      }

      public  string ParentGUID
      {
         get {  return _ParentGUID; }
         set {  _ParentGUID = value; }
      }

      public  int IsPosition
      {
         get {  return _IsPosition; }
         set {  _IsPosition = value; }
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

      public int Orders
      {
          get { return _Orders; }
          set { _Orders = value; }
      }

      public string Phone
      {
          get { return _Phone; }
          set { _Phone = value; }
      }

      #endregion

      private string _ch; //页面栏目 显示分页符

      public string Ch
      {
          get { return _ch; }
          set { _ch = value; }
      }

      private string _sh; //为了显示下拉框树形菜单 存放制表符+目录名

      public string Sh
      {
          get { return _sh; }
          set { _sh = value; }
      }
    }
}
