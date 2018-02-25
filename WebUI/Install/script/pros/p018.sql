CREATE PROCEDURE [dbo].[WM_GetGroupManagers]

@name nvarchar(256)

AS
begin

	select 
		guest.Name as Name
	from 
		WM_UserRelationship r,
		WM_Users host,
		WM_Users guest
	where 
		r.Relationship=2 and
		r.HostKey=host.[Key] and
		r.GuestKey=guest.[Key] and
		host.UpperName=UPPER(@name)

SET NOCOUNT ON;
end