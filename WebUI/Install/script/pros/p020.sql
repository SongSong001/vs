CREATE PROCEDURE [dbo].[WM_GetUserRoles]

@name nvarchar(256)

AS
begin

	select r.Name as RoleName 
	from WM_Users u,WM_User_Role ur,WM_Roles r 
	where u.UpperName=upper(@name) and u.[Key]=ur.UserKey and ur.RoleKey=r.[Key]

SET NOCOUNT ON;
end