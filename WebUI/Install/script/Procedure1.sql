CREATE PROCEDURE [dbo].[Flows_GetUserFlowBoxCount]
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@pt4 int OUTPUT,
@uid nvarchar(50)
AS
begin

set @pt1 = (select count(a.id) from flows as a where a.status=0 and a.CurrentStepUserList like '%#' + @uid + '#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction as b where b.UserID=@uid and b.FlowID=a.id ) );
set @pt2 = (select count(id) from flows where HasOperatedUserList like '%#' + @uid + '#%');
set @pt3 = (select count(id) from flows where CreatorID=@uid);
set @pt4 = (select count(id) from flows where ViewUserList like '%#' + @uid + '#%');
update Flows set status=2 where status<>1 and IsValid=1 and datediff(d,ValidTime,getdate())>0;

SET NOCOUNT ON;
end