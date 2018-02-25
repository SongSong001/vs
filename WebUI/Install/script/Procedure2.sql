CREATE PROCEDURE [dbo].[Global_GetDesktopData]
@pt1 int OUTPUT,
@pt2 int OUTPUT,
@pt3 int OUTPUT,
@pt4 int OUTPUT,
@pt5 int OUTPUT,
@pt6 int OUTPUT,
@pt7 int OUTPUT,
@pt8 int OUTPUT,
@pt10 int OUTPUT,
@pt11 int OUTPUT,
@pt12 int OUTPUT,
@pt13 int OUTPUT,
@uid nvarchar(50),
@depid nvarchar(50)
AS
begin
set @pt1 = (select count(id) from News_Article where (ShareDeps='' or ShareDeps like '%#' + @depid + '#%') and + datediff(day,addtime,getdate())<90 );

set @pt2 = (select count(id) from mails where foldertype=0 and IsRead=0 and ReceiverID=@uid);

set @pt3 = (select count(id) from mails where foldertype=0 and ReceiverID=@uid);

set @pt4 = (select count(a.id) from flows as a where a.status=0 and a.CurrentStepUserList like '%#' 
+ @uid + '#%' and a.CurrentStepID not in 
(select b.OperationStepID from Flows_StepAction as b where b.UserID=@uid and b.FlowID=a.id ) );

set @pt5 = (select count(id) from flows where CreatorID=@uid);

set @pt6 = (select count(id) from Calendar where UID = @uid 
and ( substring(STime,1,8)=CONVERT(varchar(50), GETDATE(), 112) 
or substring(ETime,1,8)=CONVERT(varchar(50), GETDATE(), 112) ) );

set @pt7 = (select count(id) from crm where CreatorID = @uid );

set @pt8 = (select count(id) from Docs_Doc where CreatorID=@uid );

set @pt10 = (select count(a.id) from gov as a where a.status=0 and a.CurrentStepUserList like '%#' + @uid + '#%' and a.CurrentStepID not in (select b.OperationStepID from gov_StepAction as b where b.UserID=@uid and b.FlowID=a.id ) );

set @pt11 = (select count(a.id) from Gov_Recipient as a,Gov as b where a.UserID=@uid and a.Flow_ID=b.id and b.Status=1 and a.sign=0);

set @pt12 = (select count(id) from tasks where Status=1 and ExecuteUserList like '%#'+ @uid +'#%');

set @pt13 = (select count(id) from tasks where Status=1 and ManageUserList like '%#'+ @uid +'#%');

select top 7 id,NewsTitle,addtime from News_Article where ComID=0 and (ShareDeps='' or ShareDeps like '%#' + @depid + '#%') order by addtime desc;

select top 7 id,isread,Subject,SendTime,SenderRealName from mails where foldertype=0 and ReceiverID=@uid order by isread asc,id desc;

select top 7 d.id,d.CreatorRealName,d.Flow_Name from ( select a.* from flows a where a.status=0 and a.CurrentStepUserList like '%#' + @uid +
'#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID=
@uid  and b.FlowID=a.id ) union all 
select c.* from flows c where c.CreatorID=@uid  union all 
select k.* from flows k where k.ViewUserList like '%#' + @uid + '#%' 
 ) as d order by d.id desc; 

select tips from tips order by orders asc;

SET NOCOUNT ON;
end