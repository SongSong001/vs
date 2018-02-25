CREATE PROCEDURE [dbo].[Global_Message]
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@pt4 int OUTPUT,
@pt5 int OUTPUT,
@uid nvarchar(50)
AS
begin
set @pt1 = (select count(id) from mails where foldertype=0 and IsRead=0 and ReceiverID=@uid);

set @pt2 = (select count(a.id) from gov as a where a.status=0 and a.CurrentStepUserList like '%#' + @uid + '#%' and a.CurrentStepID not in (select b.OperationStepID from gov_StepAction as b where b.UserID=@uid and b.FlowID=a.id ) );

set @pt3 = (select count(a.id) from Gov_Recipient as a,Gov as b where a.UserID=@uid and a.Flow_ID=b.id and b.Status=1 and a.sign=0);

set @pt4 = (select count(a.id) from flows as a where a.status=0 and a.CurrentStepUserList like '%#' 
+ @uid + '#%' and a.CurrentStepID not in 
(select b.OperationStepID from Flows_StepAction as b where b.UserID=@uid and b.FlowID=a.id ) );

set @pt5 = (select count(id) from Calendar where UID = @uid and substring(STime,1,8)=CONVERT(varchar(50), GETDATE(), 112));

SET NOCOUNT ON;
end