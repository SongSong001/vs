CREATE PROCEDURE [dbo].[WM_CreateGroup]

@creator nvarchar(256), @name nvarchar(256), @nickname nvarchar(256), @inviteCode nvarchar(256) , @isExitGroup int

AS
begin

	select [Key] from WM_Users where UpperName=UPPER(@name)
	if(@@rowcount>0)
	begin
		raiserror(N'群"%s"已存在', 16, 1, @name)
		return
	END
	
	select [Key] from WM_Users where Nickname=UPPER(@nickname)
	if(@@rowcount>0)
	begin
		raiserror(N'群"%s"已存在', 16, 1, @nickname)
		return
	END
	
	insert into WM_Users (Name,UpperName,Password,Nickname,Type,EMail,InviteCode,IsTemp,RegisterTime,IsExitGroup) 
	values (@name,UPPER(@name),'',@nickname,1,'',@inviteCode,0,getdate(),@isExitGroup)

	declare @id int
	set @id = @@identity

	insert into WM_User_Role (UserKey,RoleKey)
	select [Key] as UserKey,2 as RoleKey from WM_Users where [Key]=@id
					
	insert into WM_UserRelationship (RenewTime,HostKey,GuestKey,Relationship)
	select getdate() as RenewTime,(select [Key] from dbo.WM_Users where UpperName=UPPER(@creator)) as HostKey,(select [Key] from WM_Users where [Key]=@id) as GuestKey,3 as Relationship
					
	insert into WM_UserRelationship (RenewTime,HostKey,GuestKey,Relationship)
	select getdate() as RenewTime,(select [Key] from WM_Users where [Key]=@id) as GuestKey,(select [Key] from WM_Users where UpperName=UPPER(@creator)) as HostKey,3 as Relationship


SET NOCOUNT ON;
end