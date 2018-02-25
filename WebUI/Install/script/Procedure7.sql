CREATE PROCEDURE [dbo].[Tasks_GetTaskCount]
@pt0 int OUTPUT,
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@uid nvarchar(50)
AS
begin
set @pt0 = (select count(id) from tasks where Status=1 and (ManageUserList like '%#'+@uid+'#%' or ExecuteUserList like '%#'+@uid+'#%'));
set @pt1 = (select count(id) from tasks where Status=1 and ExecuteUserList like '%#'+@uid+'#%');
set @pt2 = (select count(id) from tasks where Status=1 and ManageUserList like '%#'+@uid+'#%');
set @pt3 = (select count(id) from tasks where CreatorID=@uid);

SET NOCOUNT ON;
end