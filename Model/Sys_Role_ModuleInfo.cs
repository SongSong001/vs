using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_Role_ModuleInfo
    {
      #region 构造函数
      public Sys_Role_ModuleInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      public Sys_Role_ModuleInfo(int id,string guid,int RoleID,int ModuleID,string RoleGUID,string ModuleGUID,int ComID,string ComGUID)
      {
         this._id=id;
         this._guid=guid;
         this._RoleID=RoleID;
         this._ModuleID=ModuleID;
         this._RoleGUID=RoleGUID;
         this._ModuleGUID=ModuleGUID;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private int _RoleID;
      private int _ModuleID;
      private string _RoleGUID;
      private string _ModuleGUID;
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

      public  int RoleID
      {
         get {  return _RoleID; }
         set {  _RoleID = value; }
      }

      public  int ModuleID
      {
         get {  return _ModuleID; }
         set {  _ModuleID = value; }
      }

      public  string RoleGUID
      {
         get {  return _RoleGUID; }
         set {  _RoleGUID = value; }
      }

      public  string ModuleGUID
      {
         get {  return _ModuleGUID; }
         set {  _ModuleGUID = value; }
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
