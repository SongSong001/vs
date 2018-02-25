CREATE PROCEDURE [dbo].[WM_FindHistory]

@user int, @peer int, @from datetime, @to datetime

AS
begin

	SELECT  top 30  temp.[Key], temp.Receiver, temp.Sender, temp.Content, temp.CreatedTime 
	from (
		select [Key], Receiver, Sender, Content, CreatedTime 
		from WM_Message 
		where Receiver = @user and Sender = @peer and CreatedTime >= @from and CreatedTime <= @to

		union all

		select [Key], Receiver, Sender, Content, CreatedTime 
		from WM_Message 
		where Receiver = @peer and Sender = @user and CreatedTime >= @from and CreatedTime <= @to

		union all

		select 
			m.[Key], m.Receiver, m.Sender, m.Content, m.CreatedTime 
		from 
			WM_Message m, WM_UserRelationShip ur, WM_Users u, WM_Users s
		where 
			ur.HostKey = @user and m.Receiver = @peer 
			and ur.GuestKey = u.[Key] and u.Type IN(1,2) and ur.GuestKey = m.Receiver 
			and CreatedTime >= @from and CreatedTime <= @to
			and m.Sender = s.[Key] and s.UpperName <> 'ADMINISTRATOR' and m.CreatedTime > ur.RenewTime
			AND m.[Key] NOT IN(select [Key] from WM_Message 
		                   where Receiver = @peer and Sender = @user 
		                   and CreatedTime >= @from and CreatedTime <= @to)
	) temp
	order by CreatedTime desc

SET NOCOUNT ON;
end