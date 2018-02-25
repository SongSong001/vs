CREATE PROCEDURE [dbo].[WM_GetFriends]

@name nvarchar(256)

AS
begin

	select 
		guest.Name as Name,
		guest.Nickname AS Nickname,
		guest.Type as Type,
		r.RenewTime as RenewTime,
		r.Relationship as Relationship
	from 
		WM_UserRelationship r,
	    WM_Users  host,
        WM_Users  guest
	where 
		r.HostKey=host.[Key] and
		r.GuestKey=guest.[Key] and
		host.UpperName=upper(@name) 

SET NOCOUNT ON;
end