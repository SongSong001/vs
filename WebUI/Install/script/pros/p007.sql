CREATE PROCEDURE [dbo].[WM_DeleteGroup]

@id int

AS
begin

	delete from WM_User_Role where UserKey=@id
	delete from WM_UserRelationship where HostKey=@id or GuestKey=@id
	delete from WM_Users where [Key]=@id

SET NOCOUNT ON;
end