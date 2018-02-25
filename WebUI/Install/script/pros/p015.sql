CREATE PROCEDURE [dbo].[WM_GetAllUsers]

AS
begin

	select u.[Key], u.Name, u.Nickname, u.EMail, u.RegisterTime,u.Phone,u.TelPhone 
	from WM_Users u 
	where u.Type = 0
	order by u.RegisterTime desc

SET NOCOUNT ON;
end