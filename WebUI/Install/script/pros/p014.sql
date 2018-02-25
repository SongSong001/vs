CREATE PROCEDURE [dbo].[WM_GetAllGroups]

AS
begin

	select u.[Key], u.Name, u.Nickname, u.EMail, u.RegisterTime, c.[Key] Creator
	from WM_Users u, WM_Users c, WM_UserRelationShip ur 
	where u.Type IN(1,2) and u.[Key] = ur.HostKey and c.[Key] = ur.GuestKey and ur.Relationship = 3
	order by u.RegisterTime desc

SET NOCOUNT ON;
end