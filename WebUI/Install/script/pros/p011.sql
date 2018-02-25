CREATE PROCEDURE [dbo].[WM_FindMessages]

@user int, @peer int, @from datetime

AS
begin

	if(@peer > 0)
	begin
		select top 100 [Key],Receiver,Sender,Content,CreatedTime
		from WM_Message 
		where Receiver = @user and Sender = @peer and CreatedTime > @from
		order by CreatedTime desc
	end
	else
	begin
		select top 100 temp.[Key], temp.Receiver, temp.Sender, temp.Content, temp.CreatedTime 
		from (
			select [Key], Receiver, Sender, Content, CreatedTime 
			from WM_Message 
			where Receiver = @user and CreatedTime > @from
			union all
			select m.[Key], m.Receiver, m.Sender, m.Content, m.CreatedTime 
			from WM_Message m, WM_UserRelationShip ur, WM_Users u
			where ur.HostKey = @user and ur.GuestKey = u.[Key] and u.Type IN(1,2) and ur.GuestKey = m.Receiver and m.CreatedTime > @from and m.CreatedTime > ur.RenewTime
		) temp
		order by CreatedTime desc
	end

SET NOCOUNT ON;
end