CREATE PROCEDURE [dbo].[WM_GetRelationship]

@account1 nvarchar(256), @account2 nvarchar(256)

AS
begin

	select *
	from WM_Users host,WM_Users guest,WM_UserRelationship r
	where host.UpperName=upper(@account1) and guest.UpperName=upper(@account2) and r.HostKey=host.[Key] and r.GuestKey=guest.[Key]

SET NOCOUNT ON;
end