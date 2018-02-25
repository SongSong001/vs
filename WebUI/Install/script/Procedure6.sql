CREATE PROCEDURE [dbo].[Mails_GetAllMailBoxCount]
@pt0 int OUTPUT,
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@pt4 int OUTPUT,
@uid int
AS
begin
set @pt0 = (select count(id) from mails where foldertype=0 and IsRead=0 and ReceiverID=@uid);
set @pt1 = (select count(id) from mails where foldertype=1 and ReceiverID=@uid);
set @pt2 = (select count(id) from mails where foldertype=2 and ReceiverID=@uid);
set @pt3 = (select count(id) from mails where foldertype=3 and ReceiverID=@uid);
set @pt4 = (select count(id) from mails where foldertype=0 and ReceiverID=@uid);

SET NOCOUNT ON;
end