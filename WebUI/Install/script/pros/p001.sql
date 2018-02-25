CREATE PROCEDURE [dbo].[WM_AddFriend]

@user nvarchar(256), @friend nvarchar(256)

AS
begin

	insert into WM_UserRelationship (HostKey,GuestKey,Relationship,RenewTime)
	select host.[Key] as HostKey,guest.[Key] as GuestKey,0,getdate()
	from WM_Users host,WM_Users guest
	where 
		(host.UpperName=upper(@user) or host.UpperName=upper(@friend)) and 
		(guest.UpperName=upper(@friend) or guest.UpperName=upper(@user)) and 
		host.[Key]<>guest.[Key]

SET NOCOUNT ON;
end