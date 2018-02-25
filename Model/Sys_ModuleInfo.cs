using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_ModuleInfo
    {
      #region 构造函数
      public Sys_ModuleInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      public Sys_ModuleInfo(int id,string guid,string TypeName,string ModuleName,string ModuleUrl,int Orders,int IsShow,string Notes,int ComID,string ComGUID)
      {
         this._id=id;
         this._guid=guid;
         this._TypeName=TypeName;
         this._ModuleName=ModuleName;
         this._ModuleUrl=ModuleUrl;
         this._Orders=Orders;
         this._IsShow=IsShow;
         this._Notes=Notes;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private string _TypeName;
      private string _ModuleName;
      private string _ModuleUrl;
      private int _Orders;
      private int _IsShow;
      private string _Notes;
      private int _ComID;
      private string _ComGUID;
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

      public  string TypeName
      {
         get {  return _TypeName; }
         set {  _TypeName = value; }
      }

      public  string ModuleName
      {
         get {  return _ModuleName; }
         set {  _ModuleName = value; }
      }

      public  string ModuleUrl
      {
         get {  return _ModuleUrl; }
         set {  _ModuleUrl = value; }
      }

      public  int Orders
      {
         get {  return _Orders; }
         set {  _Orders = value; }
      }

      public  int IsShow
      {
         get {  return _IsShow; }
         set {  _IsShow = value; }
      }

      public  string Notes
      {
         get {  return _Notes; }
         set {  _Notes = value; }
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

      #endregion
    }
}
