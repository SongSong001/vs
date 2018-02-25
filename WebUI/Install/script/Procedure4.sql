CREATE PROCEDURE [dbo].[Gov_GetRecipientCount]
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@uid nvarchar(50)
AS
begin
set @pt1 = (select count(a.id) from Gov_Recipient as a,Gov as b where a.UserID=@uid and a.Flow_ID=b.id and b.Status=1 and a.sign=0);
set @pt2 = (select count(a.id) from Gov_Recipient as a,Gov as b where a.UserID=@uid and a.Flow_ID=b.id and b.Status=1 and a.sign=1);
set @pt3 = (select count(a.id) from Gov_Recipient as a,Gov as b where a.UserID=@uid and a.Flow_ID=b.id and b.Status=5);
update gov set status=5 where status=1 and IsValid=1 and datediff(d,ValidTime,getdate())>0;

SET NOCOUNT ON;
end