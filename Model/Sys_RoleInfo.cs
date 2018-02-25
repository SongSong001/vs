using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_RoleInfo
    {
      #region 构造函数
      public Sys_RoleInfo()
      {
          this._guid = Guid.NewGuid().ToString("N");
      }

      public Sys_RoleInfo(int id,string guid,string RoleName,int ComID,string ComGUID)
      {
         this._id=id;
         this._guid=guid;
         this._RoleName=RoleName;
         this._ComID=ComID;
         this._ComGUID=ComGUID;
      }
      #endregion

      #region 成员
      private int _id;
      private string _guid;
      private string _RoleName;
      private int _ComID;
      private string _ComGUID;
      private string _Notes;
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

      public  string RoleName
      {
         get {  return _RoleName; }
         set {  _RoleName = value; }
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

      public string Notes
      {
          get { return _Notes; }
          set { _Notes = value; }
      }
      #endregion
    }
}
