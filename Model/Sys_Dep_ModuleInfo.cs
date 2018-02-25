using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_Dep_ModuleInfo
    {
      #region 构造函数
      public Sys_Dep_ModuleInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      public Sys_Dep_ModuleInfo(int id,string guid,int ModuleID,string ModuleGUID,int DepID,string DepGUID,int ComID,string ComGUID)
      {
         this._id=id;
         this._guid = Guid.NewGuid().ToString("N");
         this._ModuleID=ModuleID;
         this._ModuleGUID=ModuleGUID;
         this._DepID=DepID;
         this._DepGUID=DepGUID;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private int _ModuleID;
      private string _ModuleGUID;
      private int _DepID;
      private string _DepGUID;
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

      public  int ModuleID
      {
         get {  return _ModuleID; }
         set {  _ModuleID = value; }
      }

      public  string ModuleGUID
      {
         get {  return _ModuleGUID; }
         set {  _ModuleGUID = value; }
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
