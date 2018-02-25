CREATE PROCEDURE [dbo].[WM_DeleteFriend]

@user int, @friend int

AS
begin

	delete from WM_UserRelationship
	where (HostKey=@user and GuestKey=@friend) or (HostKey=@friend and GuestKey=@user)

SET NOCOUNT ON;
end