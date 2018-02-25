CREATE PROCEDURE [dbo].[WM_CreateUser]

@name nvarchar(256), @nickname nvarchar(256), @password nvarchar(256), @email nvarchar(256), @inviteCode nvarchar(256)

AS
begin

	select [Key] from WM_Users where UpperName=UPPER(@name)
	if(@@rowcount>0)
	begin
		raiserror(N'用户"%s"已存在', 16 ,1, @name)
		return
	end

	insert into WM_Users (Name,UpperName,Password,Nickname,Type,EMail,InviteCode,IsTemp,RegisterTime) 
	values (@name,UPPER(@name),@password,@nickname,0,@email,@inviteCode,0,getdate())

	declare @id int
	set @id = @@identity

	insert into WM_User_Role (UserKey,RoleKey)
	select [Key] as UserKey,2 as RoleKey from WM_Users where [Key]=@id

	insert into WM_UserRelationShip(HostKey, GuestKey,RelationShip,RenewTime)
	select u1.[Key], u2.[Key], 0, getdate() as RenewTime
	from WM_Users u1, WM_Users u2 
	where u1.UpperName='PUBLIC' and u2.[Key]=@id

	insert into WM_UserRelationShip(HostKey, GuestKey,RelationShip,RenewTime)
	select u2.[Key], u1.[Key], 0, getdate() as RenewTime
	from WM_Users u1, WM_Users u2 
	where u1.UpperName='PUBLIC' and u2.[Key]=@id

	insert into WM_UserRelationShip(HostKey, GuestKey,RelationShip,RenewTime)
	select u1.[Key], u2.[Key], 0, getdate() as RenewTime
	from WM_Users u1, WM_Users u2 
	where u1.UpperName='manager' and u2.[Key]=@id

	insert into WM_UserRelationShip(HostKey, GuestKey,RelationShip,RenewTime)
	select u2.[Key], u1.[Key], 0, getdate() as RenewTime
	from WM_Users u1, WM_Users u2 
	where u1.UpperName='manager' and u2.[Key]=@id

SET NOCOUNT ON;
end