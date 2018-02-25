/****** 脚本日期: 01/01/2010 14:33:04 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_GetUserFlowBoxCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Flows_GetUserFlowBoxCount]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Global_GetDesktopData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Global_GetDesktopData]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Global_Message]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Global_Message]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_GetRecipientCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Gov_GetRecipientCount]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_GetUserFlowBoxCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Gov_GetUserFlowBoxCount]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DXBBS_CommonProc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DXBBS_CommonProc]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Mails_GetAllMailBoxCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Mails_GetAllMailBoxCount]
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tasks_GetTaskCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Tasks_GetTaskCount]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SysHR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SysHR]
CREATE TABLE [dbo].[SysHR](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[RealName] [nvarchar](50) NULL,
[DepID] [int] NULL,
[MinZu] [nvarchar](50) NULL,
[HuKouXZ] [nvarchar](50) NULL,
[HuKouSZD] [nvarchar](100) NULL,
[WorkTime] [nvarchar](50) NULL,
[BiYeYX] [nvarchar](50) NULL,
[SchoolTime] [nvarchar](50) NULL,
[XueLi] [nvarchar](50) NULL,
[ZhuanYe] [nvarchar](50) NULL,
[SYQMonth] [int] NULL,
[ZhuanZhengRQ] [datetime] NULL,
[SFZNO] [nvarchar](50) NULL,
[SFZFilePath] [nvarchar](300) NULL,
[HTRQ] [nvarchar](50) NULL,
[HTNX] [nvarchar](50) NULL,
[HuoJiang] [nvarchar](4000) NULL,
[ChuFa] [nvarchar](4000) NULL,
CONSTRAINT [PK_SysHR] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WorkLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WorkLog]
CREATE TABLE [dbo].[WorkLog](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[LogTitle] [nvarchar](250) NOT NULL,
[FilePath] [nvarchar](4000) NULL,
[Notes] [ntext] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[ShareUsers] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[AddTime] [nvarchar](50) NULL,
[UpdateTime] [nvarchar](50) NULL,
CONSTRAINT [PK_WorkLog] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sms_Data]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sms_Data]
CREATE TABLE [dbo].[Sms_Data](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UserID] [int] NULL,
[RealName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[Subject] [nvarchar](2000) NULL,
[PhoneList] [nvarchar](3500) NULL,
[IsLongMessage] [int] NULL,
[AddTime] [nvarchar](50) NULL,
CONSTRAINT [PK_Sms_Data] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cars]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cars]
CREATE TABLE [dbo].[Cars](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[CarName] [nvarchar](100) NULL,
[TypeID] [int] NULL,
[TypeName] [nvarchar](200) NULL,
[CarNO] [nvarchar](100) NULL,
[CarModel] [nvarchar](100) NULL,
[EngineNO] [nvarchar](100) NULL,
[CarCost] [nvarchar](50) NULL,
[CarDate] [nvarchar](50) NULL,
[CarWeight] [nvarchar](50) NULL,
[CarFuel] [nvarchar](50) NULL,
[Notes] [ntext] NULL,
[AddTime] [nvarchar](50) NULL,
[AddPerson] [nvarchar](100) NULL,
CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cars_Action]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cars_Action]
CREATE TABLE [dbo].[Cars_Action](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[CarID] [int] NULL,
[CarName] [nvarchar](100) NULL,
[AimAddr] [nvarchar](100) NULL,
[ApplyUserList] [ntext] NULL,
[ApplyNameList] [ntext] NULL,
[ApproveUserList] [ntext] NULL,
[ApproveNameList] [ntext] NULL,
[BeginTime] [nvarchar](50) NULL,
[EndTime] [nvarchar](50) NULL,
[Reasons] [ntext] NULL,
[Notes] [ntext] NULL,
[IsValid] [int] NULL,
[ValidTime] [nvarchar](50) NULL,
[AddTime] [nvarchar](50) NULL,
[AddPerson] [nvarchar](100) NULL,
CONSTRAINT [PK_Cars_Action] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[C_Good]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[C_Good]
CREATE TABLE [dbo].[C_Good](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[GoodName] [nvarchar](100) NULL,
[TypeID] [int] NULL,
[TypeName] [nvarchar](200) NULL,
[Units] [nvarchar](50) NULL,
[Inventory] [int] NULL,
[UpLimit] [int] NULL,
[LowLimit] [int] NULL,
[AddTime] [nvarchar](50) NULL,
[AddPerson] [nvarchar](100) NULL,
[Notes] [ntext] NULL,
CONSTRAINT [PK_C_Good] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[C_GoodAction]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[C_GoodAction]
CREATE TABLE [dbo].[C_GoodAction](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[GoodID] [int] NULL,
[GoodName] [nvarchar](100) NULL,
[TypeID] [int] NULL,
[TypeName] [nvarchar](200) NULL,
[OpeUserList] [ntext] NULL,
[OpeNameList] [ntext] NULL,
[OpeAmount] [int] NULL,
[Ope] [nvarchar](50) NULL,
[OpeKind] [int] NULL,
[Notes] [ntext] NULL,
[AddTime] [nvarchar](50) NULL,
[AddPerson] [nvarchar](100) NULL,
CONSTRAINT [PK_C_GoodAction] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[C_GoodType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[C_GoodType]
CREATE TABLE [dbo].[C_GoodType](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_C_GoodType] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cars_Type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cars_Type]
CREATE TABLE [dbo].[Cars_Type](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_Cars_Type] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_Model_Type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_Model_Type]
CREATE TABLE [dbo].[Flows_Model_Type](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_Flows_Model_Type] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_Model_Type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_Model_Type]
CREATE TABLE [dbo].[Gov_Model_Type](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_Gov_Model_Type] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Paper]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Paper]
CREATE TABLE [dbo].[Paper](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[PaperName] [nvarchar](250) NULL,
[TypeID] [int] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[SendDep] [nvarchar](100) NULL,
[PaperKind] [nvarchar](100) NULL,
[PaperSymbol] [nvarchar](100) NULL,
[PaperGrade] [nvarchar](50) NULL,
[PaperUrgency] [nvarchar](50) NULL,
[PaperDate] [nvarchar](50) NULL,
[FilePath] [nvarchar](4000) NULL,
[PaperNO] [nvarchar](100) NULL,
[ShareDeps] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[Notes] [ntext] NULL,
[AddTime] [nvarchar](50) NULL,
CONSTRAINT [PK_Paper] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PaperDownload]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PaperDownload]
CREATE TABLE [dbo].[PaperDownload](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[PaperID] [int] NULL,
[DUserID] [int] NULL,
[DUserName] [nvarchar](50) NULL,
[DDepName] [nvarchar](50) NULL,
[DPaperName] [nvarchar](250) NULL,
[DPaperNo] [nvarchar](100) NULL,
[DPaperSymbol] [nvarchar](100) NULL,
[DSendDep] [nvarchar](100) NULL,
[AddTime] [nvarchar](50) NULL,
CONSTRAINT [PK_PaperDownload] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PaperType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PaperType]
CREATE TABLE [dbo].[PaperType](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_PaperType] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tasks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tasks]
CREATE TABLE [dbo].[Tasks](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TaskName] [nvarchar](200) NULL,
[TypeID] [int] NULL,
[TypeName] [nvarchar](200) NULL,
[Important] [nvarchar](30) NULL,
[Status] [int] NULL,
[IsOtherSee] [int] NULL,
[OnceSubmit] [int] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[ManageUserList] [nvarchar](4000) NULL,
[ManageNameList] [nvarchar](4000) NULL,
[ExecuteUserList] [nvarchar](4000) NULL,
[ExecuteNameList] [nvarchar](4000) NULL,
[AddTime] [nvarchar](50) NULL,
[UpdateTime] [nvarchar](50) NULL,
[ExpectTime] [nvarchar](50) NULL,
[Notes] [ntext] NULL,
[FilePath] [ntext] NULL,
[IsComplete] [int] NULL,
[Records] [ntext] NULL,
CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tasks_Type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tasks_Type]
CREATE TABLE [dbo].[Tasks_Type](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
[ParentID] [int] NULL,
CONSTRAINT [PK_Tasks_Type] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tasks_User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tasks_User]
CREATE TABLE [dbo].[Tasks_User](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TaskID] [int] NULL,
[UserID] [int] NULL,
[RealName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[WorkTag] [int] NULL,
[WorkTitle] [nvarchar](150) NULL,
[WorkNotes] [ntext] NULL,
[FilePath] [ntext] NULL,
[AddTime] [nvarchar](50) NULL,
[Instruction] [ntext] NULL,
CONSTRAINT [PK_Tasks_User] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_UserLogin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_UserLogin]
CREATE TABLE [dbo].[Sys_UserLogin](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UserName] [nvarchar](30) NULL,
[UserInfo] [nvarchar](100) NULL,
[LoginIP] [nvarchar](30) NULL,
[LoginTime] [nvarchar](30) NULL,
CONSTRAINT [PK_Sys_UserLogin] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Work_AttendSet]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Work_AttendSet]
CREATE TABLE [dbo].[Work_AttendSet](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[AttendTimes] [nvarchar](50) NULL,
[AttendNames] [nvarchar](50) NULL,
[Offset] [nvarchar](50) NULL,
[WorkKind] [int] NULL,
CONSTRAINT [PK_Work_AttendSet] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Work_Attend]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Work_Attend]
CREATE TABLE [dbo].[Work_Attend](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UID] [int] NULL,
[DepID] [int] NULL,
[RealName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[AttendType] [int] NULL,
[AttendTimeID] [int] NULL,
[StandardTimes] [nvarchar](50) NULL,
[StandardNames] [nvarchar](50) NULL,
[SignTimes] [nvarchar](50) NULL,
[SignDates] [nvarchar](50) NULL,
[SignJudge] [nvarchar](20) NULL,
[BeginTime] [datetime] NULL,
[B1] [nvarchar](20) NULL,
[B2] [nvarchar](20) NULL,
[EndTime] [datetime] NULL,
[E1] [nvarchar](20) NULL,
[E2] [nvarchar](20) NULL,
[TravelAddress] [nvarchar](50) NULL,
[Notes] [ntext] NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_Work_Attend] PRIMARY KEY CLUSTERED 
(
[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Attachment]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Attachment]

 CREATE TABLE [dbo].[WM_Attachment] (  [id] [int] IDENTITY (1, 1) NOT NULL ,  [uid] [int] NOT NULL ,  [uplaodId] [int] NOT NULL , [oldname] [nvarchar] (300) NOT NULL , [savename] [nvarchar] (300) NOT NULL , [savetime] [datetime]  NOT NULL , [size] [numeric] (18, 0) NOT NULL )
 ALTER TABLE [dbo].[WM_Attachment] WITH NOCHECK ADD CONSTRAINT [DF_WM_Attachment_savetime] DEFAULT (getdate()) FOR [savetime],CONSTRAINT [DF_WM_Attachment_size] DEFAULT ((0.0)) FOR [size],CONSTRAINT [PK_WM_Attachment] PRIMARY KEY  NONCLUSTERED ( [id] )


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Company]

 CREATE TABLE [dbo].[WM_Company] (  [ID] [int] IDENTITY (1, 1) NOT NULL , [Name] [nvarchar] (100) NOT NULL , [Tel] [nvarchar] (30) NOT NULL , [Logo] [nvarchar] (150) NOT NULL , [Address] [nvarchar] (100) NOT NULL )
 ALTER TABLE [dbo].[WM_Company] WITH NOCHECK ADD CONSTRAINT [DF_WM_Company_Name] DEFAULT ('') FOR [Name],CONSTRAINT [DF_WM_Company_Tel] DEFAULT ('') FOR [Tel],CONSTRAINT [DF_WM_Company_Logo] DEFAULT ('') FOR [Logo],CONSTRAINT [DF_WM_Company_Address] DEFAULT ('') FOR [Address],CONSTRAINT [PK_WM_Company] PRIMARY KEY  NONCLUSTERED ( [ID] )


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Control]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Control]

 CREATE TABLE [dbo].[WM_Control] (  [Id] [int] IDENTITY (1, 1) NOT NULL ,  [GId] [int] NULL , [Action] [nvarchar] (20) NULL )
 ALTER TABLE [dbo].[WM_Control] WITH NOCHECK ADD CONSTRAINT [PK_WM_Control] PRIMARY KEY  NONCLUSTERED ( [Id] )


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Message]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Message]

 CREATE TABLE [dbo].[WM_Message] (  [Key] [int] NOT NULL , [CreatedTime] [datetime]  NULL ,  [Receiver] [int] NULL ,  [Sender] [int] NULL ,  [Content] [text] NULL )
 ALTER TABLE [dbo].[WM_Message] WITH NOCHECK ADD CONSTRAINT [PK_WM_Message] PRIMARY KEY  NONCLUSTERED ( [Key] )


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Roles]

 CREATE TABLE [dbo].[WM_Roles] (  [Key] [int] NOT NULL , [Name] [nvarchar] (256) NOT NULL )
 ALTER TABLE [dbo].[WM_Roles] WITH NOCHECK ADD CONSTRAINT [PK_WM_Roles] PRIMARY KEY  NONCLUSTERED ( [Key] )
 CREATE UNIQUE INDEX [UQ__WM_Roles__7D78A4E7] ON [WM_Roles] ( Name ) 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_UDD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_UDD]

CREATE TABLE [dbo].[WM_UDD] (  [duid] [int] IDENTITY (1, 1) NOT NULL ,  [did] [int] NULL ,  [uid] [int] NULL ,  [tid] [int] NULL )

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_User_Role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_User_Role]

 CREATE TABLE [dbo].[WM_User_Role] (  [Key] [int] IDENTITY (1, 1) NOT NULL ,  [UserKey] [int] NOT NULL ,  [RoleKey] [int] NOT NULL )
 ALTER TABLE [dbo].[WM_User_Role] WITH NOCHECK ADD CONSTRAINT [PK_WM_User_Role] PRIMARY KEY  NONCLUSTERED ( [Key] )

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_UserRelationship]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_UserRelationship]

 CREATE TABLE [dbo].[WM_UserRelationship] (  [HostKey] [int] NOT NULL ,  [GuestKey] [int] NOT NULL ,  [Relationship] [int] NOT NULL , [RenewTime] [datetime]  NOT NULL ,  [Key] [int] IDENTITY (1, 1) NOT NULL )
 ALTER TABLE [dbo].[WM_UserRelationship] WITH NOCHECK ADD CONSTRAINT [PK_WM_UserRelationship] PRIMARY KEY  NONCLUSTERED ( [Key] )

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WM_Users]

 CREATE TABLE [dbo].[WM_Users] (  [Key] [int] IDENTITY (1, 1) NOT NULL , [Name] [nvarchar] (256) NOT NULL , [Nickname] [nvarchar] (256) NOT NULL ,  [Type] [int] NOT NULL , [Password] [nvarchar] (256) NOT NULL , [EMail] [nvarchar] (256) NOT NULL , [InviteCode] [nvarchar] (256) NULL , [UpperName] [nvarchar] (256) NOT NULL ,  [MsgFileLimit] [int] NULL ,  [MsgImageLimit] [int] NULL ,  [AcceptStrangerIM] [int] NULL ,  [IsTemp] [int] NULL ,  [DiskSize] [int] NULL , [RegisterTime] [datetime]  NOT NULL , [HomePage] [nvarchar] (256) NULL , [HeadIMG] [nvarchar] (512) NOT NULL , [Phone] [nvarchar] (512) NOT NULL , [TelPhone] [nvarchar] (512) NOT NULL , [MobilePhone] [nvarchar] (512) NOT NULL , [TempGroupCreateDept] [nvarchar] (32) NULL ,  [isExitGroup] [int] NOT NULL ,  [Remark] [text] NOT NULL )
 ALTER TABLE [dbo].[WM_Users] WITH NOCHECK ADD CONSTRAINT [DF_WM_Users_EMail] DEFAULT ('name@host.com') FOR [EMail],CONSTRAINT [DF_WM_Users_MsgFileLimit] DEFAULT ((2048)) FOR [MsgFileLimit],CONSTRAINT [DF_WM_Users_MsgImageLimit] DEFAULT ((200)) FOR [MsgImageLimit],CONSTRAINT [DF_WM_Users_AcceptStrangerIM] DEFAULT ((1)) FOR [AcceptStrangerIM],CONSTRAINT [DF_WM_Users_IsTemp] DEFAULT ((0)) FOR [IsTemp],CONSTRAINT [DF_WM_Users_DiskSize] DEFAULT ((200)) FOR [DiskSize],CONSTRAINT [DF_WM_Users_HomePage] DEFAULT ('') FOR [HomePage],CONSTRAINT [DF_WM_Users_HeadIMG] DEFAULT ('') FOR [HeadIMG],CONSTRAINT [DF_WM_Users_Phone] DEFAULT ('') FOR [Phone],CONSTRAINT [DF_WM_Users_TelPhone] DEFAULT ('') FOR [TelPhone],CONSTRAINT [DF_WM_Users_MobilePhone] DEFAULT ('') FOR [MobilePhone],CONSTRAINT [DF_WM_Users_isExitGroup] DEFAULT ((1)) FOR [isExitGroup],CONSTRAINT [DF_WM_Users_Remark] DEFAULT ('') FOR [Remark],CONSTRAINT [PK_WM_Users] PRIMARY KEY  NONCLUSTERED ( [Key] )
 CREATE UNIQUE INDEX [UQ__WM_Users__060DEAE8] ON [WM_Users] ( UpperName ) 
 CREATE UNIQUE INDEX [UQ__WM_Users__07020F21] ON [WM_Users] ( Name ) 




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_AddFriend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_AddFriend]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_AddUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_AddUser]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_CreateGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_CreateGroup]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_CreateTempGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_CreateTempGroup]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_CreateUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_CreateUser]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_DeleteFriend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_DeleteFriend]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_DeleteGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_DeleteGroup]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_DeleteUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_DeleteUser]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_FindHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_FindHistory]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_FindHistoryB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_FindHistoryB]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_FindMessages]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_FindMessages]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetAccountInfoByID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetAccountInfoByID]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetAccountInfoByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetAccountInfoByName]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetAllGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetAllGroups]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetAllUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetAllUsers]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetAllUsersByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetAllUsersByName]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetFriends]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetFriends]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetGroupManagers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetGroupManagers]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetRelationship]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetRelationship]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_GetUserRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_GetUserRoles]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WM_Validate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WM_Validate]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FUN_GetChildList]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
drop FUNCTION [dbo].[FUN_GetChildList]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_GetPy]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
drop FUNCTION [dbo].[f_GetPy]


/****** 对象:  Table [dbo].[Gov_Step]    脚本日期: 01/01/2010 14:33:04 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_Step]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_Step]

CREATE TABLE [dbo].[Gov_Step](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ID] [int] NULL,
[Step_Name] [nvarchar](250) NULL,
[Step_Remark] [ntext] NULL,
[Step_Orders] [int] NULL,
[RightToFinish] [int] NULL,
[MailAlert] [int] NULL,
[IsEnd] [int] NULL,
[IsHead] [int] NULL,
[IsUserEdit] [int] NULL,
[IsUserFile] [int] NULL,
[userlist] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[IsAct] [int] NULL,
[Acts] [nvarchar](150) NULL,
CONSTRAINT [PK_Gov_Step] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_Doc]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_Doc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_Doc]

CREATE TABLE [dbo].[Gov_Doc](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ID] [int] NULL,
[StepAction_ID] [int] NULL,
[UserID] [int] NULL,
[UserRealName] [nvarchar](50) NULL,
[UserDepName] [nvarchar](50) NULL,
[DocPath] [nvarchar](350) NULL,
[AddTime] [datetime] NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Gov_Doc] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Vote]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Vote]

CREATE TABLE [dbo].[Vote](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[VoteTitle] [nvarchar](500) NULL,
[VoteContent] [ntext] NULL,
[IsValide] [int] NULL,
[IsMultiple] [int] NULL,
[ShowUser] [int] NULL,
[CreateUserID] [int] NULL,
[CreateRealName] [nvarchar](50) NULL,
[CreateDepName] [nvarchar](50) NULL,
[userlist] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[VoteNotes] [ntext] NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_Vote] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VoteDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VoteDetail]

CREATE TABLE [dbo].[VoteDetail](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[VoteID] [int] NULL,
[ItemName] [nvarchar](1000) NULL,
[VoteUserID] [int] NULL,
[VoteRealName] [nvarchar](50) NULL,
[VoteDepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_VoteDetail] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_StepAction]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_StepAction]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_StepAction]

CREATE TABLE [dbo].[Gov_StepAction](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[UserID] [int] NULL,
[UserRealName] [nvarchar](50) NULL,
[UserDepName] [nvarchar](50) NULL,
[Operation] [int] NULL,
[OperationWord] [ntext] NULL,
[OperationStepID] [int] NULL,
[OperationStepName] [nvarchar](250) NULL,
[BackStepID] [int] NULL,
[FlowID] [int] NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_Gov_StepAction] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Mails_Detail]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Mails_Detail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Mails_Detail]

CREATE TABLE [dbo].[Mails_Detail](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[SendIDs] [nvarchar](4000) NULL,
[SendRealNames] [nvarchar](4000) NULL,
[CcIDs] [nvarchar](4000) NULL,
[CcRealNames] [nvarchar](4000) NULL,
[BccIDs] [nvarchar](4000) NULL,
[BccRealNames] [nvarchar](4000) NULL,
[Bodys] [ntext] NULL,
[Attachments] [nvarchar](4000) NULL,
CONSTRAINT [PK_Mails_Detail] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[News_Article]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[News_Article]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[News_Article]

CREATE TABLE [dbo].[News_Article](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[NewsTitle] [nvarchar](250) NOT NULL,
[FilePath] [ntext] NULL,
[Notes] [ntext] NULL,
[TypeID] [int] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[ShareUsers] [nvarchar](4000) NULL,
[ShareDeps] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
CONSTRAINT [PK_News_Article] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[News_Type]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[News_Type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[News_Type]

CREATE TABLE [dbo].[News_Type](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[TypeName] [nvarchar](200) NOT NULL,
[Notes] [ntext] NULL,
[Orders] [int] NULL,
CONSTRAINT [PK_News_Type] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[NoteBook]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NoteBook]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NoteBook]

CREATE TABLE [dbo].[NoteBook](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[UserID] [int] NULL,
[RealName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[Subject] [nvarchar](500) NULL,
[Bodys] [ntext] NULL,
CONSTRAINT [PK_NoteBook] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[PhoneBook]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PhoneBook]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PhoneBook]

CREATE TABLE [dbo].[PhoneBook](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[UserID] [int] NULL,
[RealName] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[Person] [nvarchar](150) NULL,
[Phone] [nvarchar](150) NULL,
[TagName] [nvarchar](150) NULL,
[Notes] [ntext] NULL,
CONSTRAINT [PK_PhoneBook] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Role_Module]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Role_Module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Role_Module]

CREATE TABLE [dbo].[Sys_Role_Module](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[RoleID] [int] NULL,
[ModuleID] [int] NULL,
[RoleGUID] [nvarchar](50) NULL,
[ModuleGUID] [nvarchar](50) NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
CONSTRAINT [PK_Sys_Role_Module] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Dep]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Dep]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Dep]

CREATE TABLE [dbo].[Sys_Dep](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[DepName] [nvarchar](50) NULL,
[Notes] [ntext] NULL,
[ParentID] [int] NULL,
[ParentGUID] [nvarchar](50) NULL,
[IsPosition] [int] NULL,
[Orders] [int] NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
[Phone] [nvarchar](150) NULL,
CONSTRAINT [PK_Sys_Dep] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_ModelFile]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_ModelFile]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_ModelFile]

CREATE TABLE [dbo].[Gov_ModelFile](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[FormTitle] [nvarchar](300) NULL,
[FilePath] [nvarchar](250) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Gov_ModelFile] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Dep_Module]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Dep_Module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Dep_Module]

CREATE TABLE [dbo].[Sys_Dep_Module](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ModuleID] [int] NULL,
[ModuleGUID] [nvarchar](50) NULL,
[DepID] [int] NULL,
[DepGUID] [nvarchar](50) NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
CONSTRAINT [PK_Sys_Dep_Module] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Module]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Module]

CREATE TABLE [dbo].[Sys_Module](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](150) NULL,
[ModuleName] [nvarchar](150) NULL,
[ModuleUrl] [nvarchar](150) NULL,
[Orders] [int] NULL,
[IsShow] [int] NULL,
[Notes] [ntext] NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
CONSTRAINT [PK_WD_Module] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Bas_Com]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Bas_Com]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Bas_Com]

CREATE TABLE [dbo].[Bas_Com](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComTypeID] [int] NULL,
[ComName] [nvarchar](150) NULL,
[AddTime] [datetime] NULL,
[MsgState] [int] NULL,
[Notes] [ntext] NULL,
[IsLock] [int] NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[Logo] [nvarchar](100) NULL,
[WebUrl] [nvarchar](100) NULL,
[BBSState] [int] NULL,
[ValidCodeState] [int] NULL,
[TipsState] [int] NULL,
[et1] [int] NULL,
[et2] [int] NULL,
[et3] [int] NULL,
[et4] [nvarchar](4000) NULL,
[et5] [nvarchar](4000) NULL,
[et6] [nvarchar](4000) NULL,
CONSTRAINT [PK_Bas_Com] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Role]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Role]

CREATE TABLE [dbo].[Sys_Role](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[RoleName] [nvarchar](150) NULL,
[Notes] [ntext] NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
CONSTRAINT [PK_WD_Role] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_Seal]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_Seal]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_Seal]

CREATE TABLE [dbo].[Sys_Seal](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[SealName] [nvarchar](100) NULL,
[FilePath] [nvarchar](100) NULL,
[TagName] [nvarchar](100) NULL,
[userlist] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[Notes] [ntext] NULL,
[AddTime] [datetime] NULL,
[Status] [int] NULL,
[PWD] [nvarchar](50) NULL,
[Uid] [int] NULL,
CONSTRAINT [PK_Sys_Seal] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Bas_ComType]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Bas_ComType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Bas_ComType]

CREATE TABLE [dbo].[Bas_ComType](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[TypeName] [nvarchar](50) NULL,
[VipTime] [int] NULL,
[UserLimit] [int] NULL,
[FileLimit] [int] NULL,
[AD_Lock] [int] NULL,
[Notes] [ntext] NULL,
CONSTRAINT [PK_Bas_ComType] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Tips]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tips]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tips]

CREATE TABLE [dbo].[Tips](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[Tips] [nvarchar](300) NULL,
[Orders] [int] NULL,
[ComID] [int] NULL,
CONSTRAINT [PK_Tips] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[CRM]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CRM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CRM]

CREATE TABLE [dbo].[CRM](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[CRM_Name] [nvarchar](200) NOT NULL,
[Tel] [nvarchar](200) NULL,
[Fax] [nvarchar](200) NULL,
[Zip] [nvarchar](150) NULL,
[QQ] [nvarchar](50) NULL,
[Site] [nvarchar](100) NULL,
[Email] [nvarchar](100) NULL,
[Address] [nvarchar](200) NULL,
[MainPeople] [nvarchar](200) NULL,
[Position] [nvarchar](100) NULL,
[Product] [nvarchar](200) NULL,
[Grade] [nvarchar](100) NULL,
[TypeName] [nvarchar](100) NULL,
[Notes] [ntext] NULL,
[FilePath] [ntext] NULL,
[IsShare] [int] NULL,
[ShareUsers] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[AddTime] [datetime] NULL,
[UpdateTime] [datetime] NULL,
CONSTRAINT [PK_CRM] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Sys_User]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sys_User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sys_User]

CREATE TABLE [dbo].[Sys_User](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UserName] [nvarchar](50) NULL,
[PassWord] [nvarchar](50) NULL,
[RealName] [nvarchar](50) NULL,
[Sex] [int] NULL,
[Birthday] [nvarchar](50) NULL,
[QQ] [nvarchar](50) NULL,
[Email] [nvarchar](100) NULL,
[Tel] [nvarchar](100) NULL,
[Phone] [nvarchar](100) NULL,
[RoleID] [int] NULL,
[RoleGUID] [nvarchar](50) NULL,
[DepID] [int] NULL,
[DepGUID] [nvarchar](50) NULL,
[DepName] [nvarchar](50) NULL,
[LastLoginIp] [nvarchar](50) NULL,
[LastLoginTime] [datetime] NULL,
[LoginQuantity] [int] NULL,
[Status] [int] NULL,
[IsLock] [int] NULL,
[RegFromIp] [nvarchar](50) NULL,
[RegTime] [datetime] NULL,
[ComID] [int] NULL,
[ComGUID] [nvarchar](50) NULL,
[Notes] [ntext] NULL,
[JoinTime] [nvarchar](50) NULL,
[DirectSupervisor] [int] NULL,
[PositionName] [nvarchar](100) NULL,
[HomeAddress] [nvarchar](100) NULL,
[MsgTime] [int] NULL,
[MemoShare] [int] NULL,
[Orders] [int] NULL,
[PerPic] [nvarchar](100) NULL,
[et1] [int] NULL,
[et2] [int] NULL,
[et3] [int] NULL,
[et4] [nvarchar](4000) NULL,
[et5] [nvarchar](4000) NULL,
[et6] [nvarchar](4000) NULL,	
CONSTRAINT [PK_Sys_User] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[CRM_Contact]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CRM_Contact]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CRM_Contact]

CREATE TABLE [dbo].[CRM_Contact](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[cid] [int] NOT NULL,
[CRM_Name] [nvarchar](200) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[ContactAim] [nvarchar](200) NULL,
[ContactPeople] [nvarchar](200) NULL,
[ContactCharge] [nvarchar](150) NULL,
[ContactChargeType] [nvarchar](150) NULL,
[ContactType] [nvarchar](150) NULL,
[ContactState] [nvarchar](150) NULL,
[ContactDetail] [ntext] NULL,
CONSTRAINT [PK_CRM_Contact_1] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[CRM_Sup]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CRM_Sup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CRM_Sup]

CREATE TABLE [dbo].[CRM_Sup](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[Sup_Name] [nvarchar](200) NULL,
[MainPeople] [nvarchar](100) NULL,
[Tel] [nvarchar](100) NULL,
[Addr] [nvarchar](200) NULL,
[Notes] [ntext] NULL,
CONSTRAINT [PK_CRM_Sup] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Docs_Doc]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Docs_Doc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Docs_Doc]

CREATE TABLE [dbo].[Docs_Doc](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[DocTitle] [nvarchar](250) NOT NULL,
[FilePath] [ntext] NULL,
[Notes] [ntext] NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[IsShare] [int] NULL,
[ShareUsers] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[AddTime] [datetime] NULL,
[DocTypeID] [int] NULL,
CONSTRAINT [PK_Docs_Doc] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Docs_DocType]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Docs_DocType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Docs_DocType]

CREATE TABLE [dbo].[Docs_DocType](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[TypeName] [nvarchar](100) NULL,
[Uid] [int] NULL,
[Notes] [ntext] NULL,
CONSTRAINT [PK_Docs_DocType] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows]

CREATE TABLE [dbo].[Flows](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_Name] [nvarchar](250) NULL,
[CurrentStepID] [int] NULL,
[CurrentStepName] [nvarchar](250) NULL,
[CurrentStepUserList] [nvarchar](4000) NULL,
[HasOperatedUserList] [nvarchar](4000) NULL,
[ViewUserList] [nvarchar](4000) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[Remark] [ntext] NULL,
[Status] [int] NULL,
[Flow_Files] [nvarchar](3000) NULL,
[AddTime] [datetime] NULL,
[ValidTime] [datetime] NULL,
[IsValid] [int] NULL,
[CurrentDocPath] [nvarchar](350) NULL,
[ModelName] [nvarchar](100) NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Flows] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_Model]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_Model]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_Model]

CREATE TABLE [dbo].[Flows_Model](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_Name] [nvarchar](250) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[Remark] [ntext] NULL,
[ModelFileID] [nvarchar](1000) NULL,
[AddTime] [datetime] NULL,
[IsComplete] [int] NULL,
[ShareDeps] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
CONSTRAINT [PK_Flows_Model] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_ModelStep]    脚本日期: 01/01/2010 14:33:04 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_ModelStep]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_ModelStep]

CREATE TABLE [dbo].[Flows_ModelStep](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ModelID] [int] NULL,
[Step_Name] [nvarchar](250) NULL,
[Step_Remark] [nvarchar](4000) NULL,
[Step_Orders] [int] NULL,
[RightToFinish] [int] NULL,
[MailAlert] [int] NULL,
[IsEnd] [int] NULL,
[IsHead] [int] NULL,
[IsUserEdit] [int] NULL,
[IsUserFile] [int] NULL,
[Step_Type] [int] NULL,
[UserList] [nvarchar](4000) NULL,
[NameList] [nvarchar](4000) NULL,
[UserList_dep] [nvarchar](4000) NULL,
[NameList_dep] [nvarchar](4000) NULL,
CONSTRAINT [PK_Flows_ModelStep] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Docs_Office]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Docs_Office]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Docs_Office]

CREATE TABLE [dbo].[Docs_Office](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[DocTitle] [nvarchar](250) NULL,
[FileName] [nvarchar](250) NULL,
[FileType] [int] NULL,
[CreatorID] [int] NULL,
[AddTime] [datetime] NULL,
[UpdateTime] [datetime] NULL,
[FileSize] [int] NULL,
CONSTRAINT [PK_Docs_Office] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_Step]    脚本日期: 01/01/2010 14:33:05 ******/



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_Step]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_Step]

CREATE TABLE [dbo].[Flows_Step](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ID] [int] NULL,
[Step_Name] [nvarchar](250) NULL,
[Step_Remark] [nvarchar](4000) NULL,
[Step_Orders] [int] NULL,
[RightToFinish] [int] NULL,
[MailAlert] [int] NULL,
[IsEnd] [int] NULL,
[IsHead] [int] NULL,
[IsUserEdit] [int] NULL,
[IsUserFile] [int] NULL,
[userlist] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
[IsAct] [int] NULL,
[Acts] [nvarchar](150) NULL,
CONSTRAINT [PK_Flows_Step] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_Doc]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_Doc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_Doc]

CREATE TABLE [dbo].[Flows_Doc](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ID] [int] NULL,
[StepAction_ID] [int] NULL,
[UserID] [int] NULL,
[UserRealName] [nvarchar](50) NULL,
[UserDepName] [nvarchar](50) NULL,
[DocPath] [ntext] NULL,
[AddTime] [datetime] NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Flows_Doc] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_StepAction]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_StepAction]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_StepAction]

CREATE TABLE [dbo].[Flows_StepAction](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[UserID] [int] NULL,
[UserRealName] [nvarchar](50) NULL,
[UserDepName] [nvarchar](50) NULL,
[Operation] [int] NULL,
[OperationWord] [ntext] NULL,
[OperationStepID] [int] NULL,
[OperationStepName] [nvarchar](250) NULL,
[BackStepID] [int] NULL,
[FlowID] [int] NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_Flows_MemberAction] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Mails]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Mails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Mails]

CREATE TABLE [dbo].[Mails](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[ReceiverID] [int] NULL,
[SenderID] [int] NULL,
[SenderGUID] [nvarchar](50) NULL,
[SenderRealName] [nvarchar](50) NULL,
[SenderDepName] [nvarchar](50) NULL,
[SendType] [int] NULL,
[Subject] [nvarchar](500) NULL,
[IsRead] [int] NULL,
[FolderType] [int] NULL,
[SendTime] [datetime] NULL,
[did] [int] NOT NULL,
CONSTRAINT [PK_Mails] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov]

CREATE TABLE [dbo].[Gov](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_Name] [nvarchar](250) NULL,
[CurrentStepID] [int] NULL,
[CurrentStepName] [nvarchar](250) NULL,
[CurrentStepUserList] [nvarchar](4000) NULL,
[HasOperatedUserList] [nvarchar](4000) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[Remark] [ntext] NULL,
[Status] [int] NULL,
[Flow_Files] [nvarchar](3000) NULL,
[AddTime] [datetime] NULL,
[ValidTime] [datetime] NULL,
[IsValid] [int] NULL,
[CurrentDocPath] [nvarchar](350) NULL,
[RecieveDep] [nvarchar](2000) NULL,
[DocNo] [nvarchar](350) NULL,
[Secret] [nvarchar](50) NULL,
[ModelName] [nvarchar](100) NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Gov] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_Model]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_Model]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_Model]

CREATE TABLE [dbo].[Gov_Model](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_Name] [nvarchar](250) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[Remark] [ntext] NULL,
[ModelFileID] [nvarchar](1000) NULL,
[AddTime] [datetime] NULL,
[IsComplete] [int] NULL,
[ShareDeps] [nvarchar](4000) NULL,
[namelist] [nvarchar](4000) NULL,
CONSTRAINT [PK_Gov_Model] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Bas_ComType_Module]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Bas_ComType_Module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Bas_ComType_Module]

CREATE TABLE [dbo].[Bas_ComType_Module](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ModuleID] [int] NULL,
[ComTypeID] [int] NULL,
CONSTRAINT [PK_Bas_ComType_Module] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Meeting]    脚本日期: 01/01/2010 14:33:05 ******/


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Meeting]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Meeting]

CREATE TABLE [dbo].[Meeting](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[UserID] [int] NULL,
[Bodys] [ntext] NULL,
[CTime] [nvarchar](200) NULL,
[Address] [nvarchar](1000) NULL,
[Recorder] [nvarchar](1000) NULL,
[ListPerson] [nvarchar](4000) NULL,
[AbsencePerson] [nvarchar](4000) NULL,
[Chaired] [nvarchar](1000) NULL,
[MainTopics] [nvarchar](500) NULL,
[Remarks] [nvarchar](4000) NULL,
[FilePath] [nvarchar](4000) NULL,
CONSTRAINT [PK_Meeting] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_ModelStep]    脚本日期: 01/01/2010 14:33:05 ******/



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_ModelStep]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_ModelStep]

CREATE TABLE [dbo].[Gov_ModelStep](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ModelID] [int] NULL,
[Step_Name] [nvarchar](250) NULL,
[Step_Remark] [ntext] NULL,
[Step_Orders] [int] NULL,
[RightToFinish] [int] NULL,
[MailAlert] [int] NULL,
[IsEnd] [int] NULL,
[IsHead] [int] NULL,
[IsUserEdit] [int] NULL,
[IsUserFile] [int] NULL,
[Step_Type] [int] NULL,
[UserList] [nvarchar](4000) NULL,
[NameList] [nvarchar](4000) NULL,
[UserList_dep] [nvarchar](4000) NULL,
[NameList_dep] [nvarchar](4000) NULL,
CONSTRAINT [PK_Gov_ModelStep] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Gov_Recipient]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Gov_Recipient]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Gov_Recipient]

CREATE TABLE [dbo].[Gov_Recipient](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[Flow_ID] [int] NULL,
[UserID] [int] NULL,
[UserRealName] [nvarchar](50) NULL,
[UserDepName] [nvarchar](50) NULL,
[Sign] [int] NULL,
[FeedBack] [ntext] NULL,
[SignTime] [datetime] NULL,
CONSTRAINT [PK_Gov_Recipient] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


/****** 对象:  Table [dbo].[Flows_ModelFile]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Flows_ModelFile]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Flows_ModelFile]

CREATE TABLE [dbo].[Flows_ModelFile](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[ComID] [int] NULL,
[FormTitle] [nvarchar](300) NULL,
[FilePath] [nvarchar](250) NULL,
[CreatorID] [int] NULL,
[CreatorRealName] [nvarchar](50) NULL,
[CreatorDepName] [nvarchar](50) NULL,
[AddTime] [datetime] NULL,
[DocBody] [ntext] NULL,
CONSTRAINT [PK_Flows_ModelFile] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


/****** 对象:  Table [dbo].[Calendar]    脚本日期: 01/01/2010 14:33:05 ******/




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Calendar]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Calendar]

CREATE TABLE [dbo].[Calendar](
[ID] [int] IDENTITY(1,1) NOT NULL,
[UID] [varchar](100) NOT NULL,
[EID] [varchar](100) NOT NULL,
[EName] [varchar](100) NOT NULL,
[STime] [varchar](50) NOT NULL,
[ETime] [varchar](50) NOT NULL,
[CTime] [varchar](50) NOT NULL,
[MTime] [datetime] NOT NULL,
[LogicDelete] [int] NOT NULL,
[MEMO] [text] NOT NULL,
CONSTRAINT [PK_Calendar] PRIMARY KEY CLUSTERED 
(
[ID] ASC
)ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Advertisement]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Advertisement]
CREATE TABLE [dbo].[WC_Forum_Advertisement](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Title] [nchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[IsUsing] [int] NULL CONSTRAINT [DF_WC_Forum_Advertisement_IsUsing]  DEFAULT ((0)),
[Orders] [int] NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Advertisement_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Advertisement] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Board]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Board]
CREATE TABLE [dbo].[WC_Forum_Board](
[ID] [int] NOT NULL,
[FatherID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_FatherID]  DEFAULT ((0)),
[FatherPath] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Depth] [int] NULL CONSTRAINT [DF_WC_Forum_Board_Depth]  DEFAULT ((0)),
[RootID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_RootID]  DEFAULT ((0)),
[ChildNum] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ChildNum]  DEFAULT ((0)),
[Orders] [int] NULL,
[ChildOrderType] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ChildOrderType]  DEFAULT ((0)),
[ChildLineNum] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ChildLineNum]  DEFAULT ((0)),
[BoardName] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
[AllowTopic] [int] NULL CONSTRAINT [DF_WC_Forum_Board_AllowTopic]  DEFAULT ((0)),
[ShowType] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ShowType]  DEFAULT ((0)),
[NeedConfirm] [int] NULL CONSTRAINT [DF_WC_Forum_Board_NeedConfirm]  DEFAULT ((0)),
[Locked] [int] NULL,
[TitleColor] [nvarchar](10) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[BoardRule] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Master] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[MasterID] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[Photo] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[Logo] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TopicCount] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TopicCount]  DEFAULT ((0)),
[TotalTopic] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TotalTopic]  DEFAULT ((0)),
[TotalReply] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TotalReply]  DEFAULT ((0)),
[TodayTopic] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TodayTopic]  DEFAULT ((0)),
[TodayReply] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TodayReply]  DEFAULT ((0)),
[ActiveBoardID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ActiveBoardID]  DEFAULT ((0)),
[ActiveTopicID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ActiveTopicID]  DEFAULT ((0)),
[ActiveTopicTitle] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ActiveUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ActiveUserID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ActiveUserID]  DEFAULT ((0)),
[ActiveTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Board_ActiveTime]  DEFAULT (getdate()),
[LevelID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TeamID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[PowerType] [int] NULL CONSTRAINT [DF_WC_Forum_Board_PowerType]  DEFAULT ((0)),
[TopicOrderType] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TopicOrderType]  DEFAULT ((0)),
[TopicPerPage] [int] NULL,
[ReplyPerPage] [int] NULL CONSTRAINT [DF_WC_Forum_Board_ReplyPerPage]  DEFAULT ((0)),
[TemplateID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_TemplateID]  DEFAULT ((0)),
[SkinID] [int] NULL CONSTRAINT [DF_WC_Forum_Board_SkinID]  DEFAULT ((0)),
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Board_AddTime]  DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_BoardRecycle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_BoardRecycle]
CREATE TABLE [dbo].[WC_Forum_BoardRecycle](
[ID] [int] NOT NULL,
[FatherID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_FatherID]  DEFAULT ((0)),
[FatherPath] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Depth] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_Depth]  DEFAULT ((0)),
[RootID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_RootID]  DEFAULT ((0)),
[ChildNum] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ChildNum]  DEFAULT ((0)),
[Orders] [int] NULL,
[ChildOrderType] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ChildOrderType]  DEFAULT ((0)),
[ChildLineNum] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ChildLineNum]  DEFAULT ((0)),
[BoardName] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
[AllowTopic] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_AllowTopic]  DEFAULT ((0)),
[ShowType] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ShowType]  DEFAULT ((0)),
[NeedConfirm] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_NeedConfirm]  DEFAULT ((0)),
[Locked] [int] NULL,
[TitleColor] [nvarchar](10) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[BoardRule] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Master] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[MasterID] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[Photo] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[Logo] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TopicCount] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TopicCount]  DEFAULT ((0)),
[TotalTopic] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TotalTopic]  DEFAULT ((0)),
[TotalReply] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TotalReply]  DEFAULT ((0)),
[TodayTopic] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TodayTopic]  DEFAULT ((0)),
[TodayReply] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TodayReply]  DEFAULT ((0)),
[ActiveBoardID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ActiveBoardID]  DEFAULT ((0)),
[ActiveTopicID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ActiveTopicID]  DEFAULT ((0)),
[ActiveTopicTitle] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ActiveUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ActiveUserID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ActiveUserID]  DEFAULT ((0)),
[ActiveTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ActiveTime]  DEFAULT (getdate()),
[LevelID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TeamID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[PowerType] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_PowerType]  DEFAULT ((0)),
[TopicOrderType] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TopicOrderType]  DEFAULT ((0)),
[TopicPerPage] [int] NULL,
[ReplyPerPage] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_ReplyPerPage]  DEFAULT ((0)),
[TemplateID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_TemplateID]  DEFAULT ((0)),
[SkinID] [int] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_SkinID]  DEFAULT ((0)),
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_BoardRecycle_AddTime]  DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Emote]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Emote]
CREATE TABLE [dbo].[WC_Forum_Emote](
[ID] [int] IDENTITY(1,1) NOT NULL,
[EmoteName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FileName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Orders] [int] NULL,
CONSTRAINT [PK_WC_Forum_Emote] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Face]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Face]
CREATE TABLE [dbo].[WC_Forum_Face](
[ID] [int] IDENTITY(1,1) NOT NULL,
[FaceName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FileName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Orders] [int] NULL,
CONSTRAINT [PK_WC_Forum_Face] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Favorite]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Favorite]
CREATE TABLE [dbo].[WC_Forum_Favorite](
[UserID] [int] NULL,
[TopicID] [int] NULL
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Friend]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Friend]
CREATE TABLE [dbo].[WC_Forum_Friend](
[UserID] [int] NULL,
[FriendID] [int] NULL
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Group]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Group]
CREATE TABLE [dbo].[WC_Forum_Group](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL,
[GroupName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Orders] [int] NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Group_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Group] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_History]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_History]
CREATE TABLE [dbo].[WC_Forum_History](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TodayTopic] [int] NULL,
[TodayReply] [int] NULL,
[TodayRegister] [int] NULL,
[TodayOnline] [int] NULL,
[TodayLogin] [int] NULL,
[AddTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_History] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_IP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_IP]
CREATE TABLE [dbo].[WC_Forum_IP](
[ID] [int] IDENTITY(1,1) NOT NULL,
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Reason] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_IP_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_IP] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Level]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Level]
CREATE TABLE [dbo].[WC_Forum_Level](
[ID] [int] IDENTITY(1,1) NOT NULL,
[LevelName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Point] [int] NULL CONSTRAINT [DF_WC_Forum_Level_Point]  DEFAULT ((0)),
[Photo] [int] NULL CONSTRAINT [DF_WC_Forum_Level_Photo]  DEFAULT ((0)),
[Types] [int] NULL CONSTRAINT [DF_WC_Forum_Level_Types]  DEFAULT ((0)),
[Power] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[StringPower] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Level_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Level] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Link]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Link]
CREATE TABLE [dbo].[WC_Forum_Link](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Photo] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[URL] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[Types] [int] NULL,
[Orders] [int] NULL,
[Introduce] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Link_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Link] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Log]
CREATE TABLE [dbo].[WC_Forum_Log](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL CONSTRAINT [DF_WC_Forum_Log_BoardID]  DEFAULT ((0)),
[TopicID] [int] NULL CONSTRAINT [DF_WC_Forum_Log_TopicID]  DEFAULT ((0)),
[LogTitle] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Operator] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[OperatorID] [int] NULL,
[Loger] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[LogerID] [int] NULL,
[Reason] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Coin] [int] NULL CONSTRAINT [DF_WC_Forum_Log_Coin]  DEFAULT ((0)),
[Point] [int] NULL CONSTRAINT [DF_WC_Forum_Log_Point]  DEFAULT ((0)),
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Log_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Log] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Menu]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Menu]
CREATE TABLE [dbo].[WC_Forum_Menu](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[URL] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Target] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Color] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Strong] [int] NOT NULL CONSTRAINT [DF_WC_Forum_Menu_Strong]  DEFAULT ((0)),
[Disappear] [int] NULL CONSTRAINT [DF_WC_Forum_Menu_Disappear]  DEFAULT ((0)),
[Login] [int] NULL CONSTRAINT [DF_WC_Forum_Menu_Login]  DEFAULT ((0)),
[Orders] [int] NULL,
[Types] [int] NULL CONSTRAINT [DF_WC_Forum_Menu_Types]  DEFAULT ((0)),
CONSTRAINT [PK_WC_Forum_Menu] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Message]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Message]
CREATE TABLE [dbo].[WC_Forum_Message](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[FromID] [int] NULL,
[FromName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ToID] [int] NULL,
[ToName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FromDelete] [int] NULL CONSTRAINT [DF_WC_Forum_Message_FromDelete]  DEFAULT ((0)),
[ToDelete] [int] NULL CONSTRAINT [DF_WC_Forum_Message_ToDelete]  DEFAULT ((0)),
[Types] [int] NULL CONSTRAINT [DF_WC_Forum_Message_Types]  DEFAULT ((0)),
[IsRead] [int] NULL CONSTRAINT [DF_WC_Forum_Message_IsRead]  DEFAULT ((0)),
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Message_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Message] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_News]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_News]
CREATE TABLE [dbo].[WC_Forum_News](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL CONSTRAINT [DF_WC_Forum_News_BoardID]  DEFAULT ((0)),
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_News_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_News] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Permision]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Permision]
CREATE TABLE [dbo].[WC_Forum_Permision](
[Keys] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NOT NULL,
[BoardID] [int] NULL,
[ItemID] [int] NULL,
[Power] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[StringPower] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Types] [int] NULL,
[PowerType] [int] NULL,
[PermisionType] [int] NULL,
CONSTRAINT [PK_WC_Forum_Permision] PRIMARY KEY CLUSTERED 
(
[Keys] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Replace]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Replace]
CREATE TABLE [dbo].[WC_Forum_Replace](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Former] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Later] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Replace_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Replace] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Reply1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Reply1]
CREATE TABLE [dbo].[WC_Forum_Reply1](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL,
[TopicID] [int] NULL,
[IsTopic] [int] NULL,
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[TitleColor] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Length] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[EditUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[EditTime] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Floor] [int] NULL,
[UBB] [int] NULL,
[VoteID] [int] NULL,
[State] [int] NULL,
[TopicState] [int] NULL,
[LevelID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TeamID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Coin] [int] NULL,
[AskCoin] [int] NULL,
[GoodAnswer] [int] NULL,
[Hide] [int] NULL,
[BuyUserID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[ReplyUserID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[AnswerContent] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TableNumber] [int] NULL DEFAULT ((0)),
[DeleteType] [int] NULL DEFAULT ((0)),
[AddTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_Reply1] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Skin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Skin]
CREATE TABLE [dbo].[WC_Forum_Skin](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TemplateID] [int] NULL,
[SkinName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FilePath] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Skin_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Skin] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Status]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Status]
CREATE TABLE [dbo].[WC_Forum_Status](
[TotalTopic] [int] NULL,
[TotalReply] [int] NULL,
[TotalMale] [int] NULL,
[TotalFemale] [int] NULL,
[NewUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ActiveTime] [datetime] NULL
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Table]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Table]
CREATE TABLE [dbo].[WC_Forum_Table](
[ID] [int] IDENTITY(1,1) NOT NULL,
[Orders] [int] NULL,
[Counts] [int] NULL,
CONSTRAINT [PK_WC_Forum_Table] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Team]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Team]
CREATE TABLE [dbo].[WC_Forum_Team](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TeamName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Master] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[MasterID] [int] NULL CONSTRAINT [DF_WC_Forum_Team_MasterID]  DEFAULT ((0)),
[Members] [int] NULL CONSTRAINT [DF_WC_Forum_Team_Members]  DEFAULT ((0)),
[Photo] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[NeedConfirm] [int] NULL CONSTRAINT [DF_WC_Forum_Team_NeedConfirm]  DEFAULT ((0)),
[Confirmed] [int] NULL CONSTRAINT [DF_WC_Forum_Team_Confirmed]  DEFAULT ((1)),
[Introduce] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[IsPublic] [int] NULL CONSTRAINT [DF_WC_Forum_Team_IsPublic]  DEFAULT ((1)),
[Point] [int] NOT NULL CONSTRAINT [DF_WC_Forum_Team_Point]  DEFAULT ((0)),
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Team_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Team] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_TeamJoin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_TeamJoin]
CREATE TABLE [dbo].[WC_Forum_TeamJoin](
[UserID] [int] NULL,
[TeamID] [int] NULL
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_TeamMessage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_TeamMessage]
CREATE TABLE [dbo].[WC_Forum_TeamMessage](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TeamID] [int] NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_TeamMessage_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_TeamMessage] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_TeamNews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_TeamNews]
CREATE TABLE [dbo].[WC_Forum_TeamNews](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TeamID] [int] NULL,
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_TeamNews_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_TeamNews] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_TeamPhoto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_TeamPhoto]
CREATE TABLE [dbo].[WC_Forum_TeamPhoto](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TeamID] [int] NULL,
[Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[Photo] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_TeamPhoto_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_TeamPhoto] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Template]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Template]
CREATE TABLE [dbo].[WC_Forum_Template](
[ID] [int] IDENTITY(1,1) NOT NULL,
[TemplateName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FilePath] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Template_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Template] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Topic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Topic]
CREATE TABLE [dbo].[WC_Forum_Topic](
[ID] [int] IDENTITY(1,1) NOT NULL,
[RootID] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_RootID]  DEFAULT ((0)),
[BoardID] [int] NULL,
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[TitleColor] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[Click] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_Click]  DEFAULT ((0)),
[Reply] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_Reply]  DEFAULT ((0)),
[LastReplyUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[LastReplyUserID] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_LastReplyUserID]  DEFAULT ((0)),
[LastReplyTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Topic_LastReplyTime]  DEFAULT (getdate()),
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[IsTop] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_IsTop]  DEFAULT ((0)),
[IsGood] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_IsGood]  DEFAULT ((0)),
[IsLock] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_IsLock]  DEFAULT ((0)),
[State] [int] NULL,
[TableNumber] [int] NULL,
[GroupID] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_GroupID]  DEFAULT ((0)),
[Confirmed] [int] NULL CONSTRAINT [DF_WC_Forum_Topic_Confirmed]  DEFAULT ((1)),
[DeleteType] [int] NULL DEFAULT ((0)),
[AddTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_Topic] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
CREATE INDEX [IX_WC_Forum_Topic] ON [dbo].[WC_Forum_Topic](LastReplyTime DESC)
CREATE INDEX [IX_WC_Forum_Topic1] ON [dbo].[WC_Forum_Topic](AddTime DESC)

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_TopicRecycle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_TopicRecycle]
CREATE TABLE [dbo].[WC_Forum_TopicRecycle](
[ID] [int] NOT NULL,
[RootID] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_RootID]  DEFAULT ((0)),
[BoardID] [int] NULL,
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[TitleColor] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[Click] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_Click]  DEFAULT ((0)),
[Reply] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_Reply]  DEFAULT ((0)),
[LastReplyUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[LastReplyUserID] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_LastReplyUserID]  DEFAULT ((0)),
[LastReplyTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_LastReplyTime]  DEFAULT (getdate()),
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[IsTop] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_IsTop]  DEFAULT ((0)),
[IsGood] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_IsGood]  DEFAULT ((0)),
[IsLock] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_IsLock]  DEFAULT ((0)),
[State] [int] NULL,
[TableNumber] [int] NULL,
[GroupID] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_GroupID]  DEFAULT ((0)),
[Confirmed] [int] NULL CONSTRAINT [DF_WC_Forum_TopicRecycle_Confirmed]  DEFAULT ((1)),
[DeleteType] [int] NULL DEFAULT ((0)),
[AddTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_TopicRecycle] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_ReplyRecycle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_ReplyRecycle]
CREATE TABLE [dbo].[WC_Forum_ReplyRecycle](
[ID] [int] NOT NULL,
[BoardID] [int] NULL,
[TopicID] [int] NULL,
[IsTopic] [int] NULL,
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[TitleColor] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Length] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[EditUser] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[EditTime] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Floor] [int] NULL,
[UBB] [int] NULL,
[VoteID] [int] NULL,
[State] [int] NULL,
[TopicState] [int] NULL,
[LevelID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TeamID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Coin] [int] NULL,
[AskCoin] [int] NULL,
[GoodAnswer] [int] NULL,
[Hide] [int] NULL,
[BuyUserID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[ReplyUserID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[AnswerContent] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[TableNumber] [int] NULL DEFAULT ((0)),
[DeleteType] [int] NULL DEFAULT ((0)),
[AddTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_ReplyRecycle] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_UploadFace]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_UploadFace]
CREATE TABLE [dbo].[WC_Forum_UploadFace](
[ID] [int] IDENTITY(1,1) NOT NULL,
[FileName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[FileSize] [int] NULL,
[FileType] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_UploadFace_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_UploadFace] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_UploadFile]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_UploadFile]
CREATE TABLE [dbo].[WC_Forum_UploadFile](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL CONSTRAINT [DF_WC_Forum_UploadFile_BoardID]  DEFAULT ((0)),
[TopicID] [int] NULL CONSTRAINT [DF_WC_Forum_UploadFile_TopicID]  DEFAULT ((0)),
[ReplyID] [int] NULL CONSTRAINT [DF_WC_Forum_UploadFile_ReplyID]  DEFAULT ((0)),
[FileName] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
[FileSize] [int] NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Types] [int] NULL,
[FileType] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_UploadFile_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_UploadFile] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_User]
CREATE TABLE [dbo].[WC_Forum_User](
[ID] [int] IDENTITY(1,1) NOT NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserPass] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[PasswordType] [int] NULL  DEFAULT ((0)),
[Question] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Answer] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Email] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Sex] [int] NULL,
[Photo] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
[PhotoWidth] [int] NULL,
[PhotoHeight] [int] NULL,
[NickName] [nvarchar](20) COLLATE Chinese_PRC_CI_AS NULL,
[Sign] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[LevelID] [int] NULL,
[LevelType] [int] NULL,
[TeamID] [int] NULL CONSTRAINT [DF_WC_Forum_User_TeamID]  DEFAULT ((0)),
[Coin] [int] NULL CONSTRAINT [DF_WC_Forum_User_Coin]  DEFAULT ((0)),
[Point] [int] NULL CONSTRAINT [DF_WC_Forum_User_Point]  DEFAULT ((0)),
[Topic] [int] NULL CONSTRAINT [DF_WC_Forum_User_Topic]  DEFAULT ((0)),
[Reply] [int] NULL CONSTRAINT [DF_WC_Forum_User_Reply]  DEFAULT ((0)),
[TopicDel] [int] NULL CONSTRAINT [DF_WC_Forum_User_TopicDel]  DEFAULT ((0)),
[ReplyDel] [int] NULL CONSTRAINT [DF_WC_Forum_User_ReplyDel]  DEFAULT ((0)),
[GoodTopic] [int] NULL CONSTRAINT [DF_WC_Forum_User_GoodTopic]  DEFAULT ((0)),
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UploadNum] [int] NULL CONSTRAINT [DF_WC_Forum_User_UploadNum]  DEFAULT ((0)),
[UploadTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_User_UploadTime]  DEFAULT (getdate()),
[LoginTime] [datetime] NULL,
[LoginIP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Message] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[State] [int] NULL CONSTRAINT [DF_WC_Forum_User_State]  DEFAULT ((0)),
[RegTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_User] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_UserRecycle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_UserRecycle]
CREATE TABLE [dbo].[WC_Forum_UserRecycle](
[ID] [int] NOT NULL,
[UserName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UserPass] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[PasswordType] [int] NULL  DEFAULT ((0)),
[Question] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Answer] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Email] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Sex] [int] NULL,
[Photo] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
[PhotoWidth] [int] NULL,
[PhotoHeight] [int] NULL,
[NickName] [nvarchar](20) COLLATE Chinese_PRC_CI_AS NULL,
[Sign] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[LevelID] [int] NULL,
[LevelType] [int] NULL,
[TeamID] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_TeamID]  DEFAULT ((0)),
[Coin] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_Coin]  DEFAULT ((0)),
[Point] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_Point]  DEFAULT ((0)),
[Topic] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_Topic]  DEFAULT ((0)),
[Reply] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_Reply]  DEFAULT ((0)),
[TopicDel] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_TopicDel]  DEFAULT ((0)),
[ReplyDel] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_ReplyDel]  DEFAULT ((0)),
[GoodTopic] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_GoodTopic]  DEFAULT ((0)),
[IP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[UploadNum] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_UploadNum]  DEFAULT ((0)),
[UploadTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_UploadTime]  DEFAULT (getdate()),
[LoginTime] [datetime] NULL,
[LoginIP] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Message] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[State] [int] NULL CONSTRAINT [DF_WC_Forum_UserRecycle_State]  DEFAULT ((0)),
[RegTime] [datetime] NULL,
CONSTRAINT [PK_WC_Forum_UserRecycle] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_UserDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_UserDetail]
CREATE TABLE [dbo].[WC_Forum_UserDetail](
[ID] [int] IDENTITY(1,1) NOT NULL,
[UserID] [int] NULL,
[RealName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[QQ] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[ICQ] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[MSN] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Address] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Mobile] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Phone] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Birthday] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Country] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Province] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[City] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Star] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Blood] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Marry] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Study] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[School] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
[Introduce] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
CONSTRAINT [PK_WC_Forum_UserDetail] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WC_Forum_Vote]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WC_Forum_Vote]
CREATE TABLE [dbo].[WC_Forum_Vote](
[ID] [int] IDENTITY(1,1) NOT NULL,
[BoardID] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_BoardID]  DEFAULT ((0)),
[TopicID] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_TopicID]  DEFAULT ((0)),
[ReplyID] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_ReplyID]  DEFAULT ((0)),
[Title] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
[Content] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Result] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[Click] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_Click]  DEFAULT ((0)),
[Types] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_Types]  DEFAULT ((0)),
[Days] [int] NULL CONSTRAINT [DF_WC_Forum_Vote_Days]  DEFAULT ((0)),
[VoteSelect] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[VoteUserID] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[VoteUserName] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
[UserID] [int] NULL,
[UserName] [nvarchar](255) COLLATE Chinese_PRC_CI_AS NULL,
[AddTime] [datetime] NULL CONSTRAINT [DF_WC_Forum_Vote_AddTime]  DEFAULT (getdate()),
CONSTRAINT [PK_WC_Forum_Vote] PRIMARY KEY CLUSTERED 
(
[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ZEX1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ZEX1]

CREATE TABLE [dbo].[ZEX1](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[e1] [int] NULL,
[e2] [int] NULL,
[e3] [int] NULL,
[e4] [int] NULL,
[e5] [nvarchar](4000) NULL,
[e6] [nvarchar](4000) NULL,
[e7] [nvarchar](4000) NULL,
[e8] [nvarchar](4000) NULL,
[e9] [nvarchar](4000) NULL,
[e10] [datetime] NULL,
CONSTRAINT [PK_ZEX1] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ZEX2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ZEX2]

CREATE TABLE [dbo].[ZEX2](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[e1] [int] NULL,
[e2] [int] NULL,
[e3] [int] NULL,
[e4] [int] NULL,
[e5] [nvarchar](4000) NULL,
[e6] [nvarchar](4000) NULL,
[e7] [nvarchar](4000) NULL,
[e8] [nvarchar](4000) NULL,
[e9] [nvarchar](4000) NULL,
[e10] [datetime] NULL,
CONSTRAINT [PK_ZEX2] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ZEX3]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ZEX3]

CREATE TABLE [dbo].[ZEX3](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[e1] [int] NULL,
[e2] [int] NULL,
[e3] [int] NULL,
[e4] [int] NULL,
[e5] [nvarchar](4000) NULL,
[e6] [nvarchar](4000) NULL,
[e7] [nvarchar](4000) NULL,
[e8] [nvarchar](4000) NULL,
[e9] [nvarchar](4000) NULL,
[e10] [datetime] NULL,
CONSTRAINT [PK_ZEX3] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ZEX4]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ZEX4]

CREATE TABLE [dbo].[ZEX4](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[e1] [int] NULL,
[e2] [int] NULL,
[e3] [int] NULL,
[e4] [int] NULL,
[e5] [nvarchar](4000) NULL,
[e6] [nvarchar](4000) NULL,
[e7] [nvarchar](4000) NULL,
[e8] [nvarchar](4000) NULL,
[e9] [nvarchar](4000) NULL,
[e10] [datetime] NULL,
CONSTRAINT [PK_ZEX4] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ZEX5]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ZEX5]

CREATE TABLE [dbo].[ZEX5](
[id] [int] IDENTITY(1,1) NOT NULL,
[guid] [nvarchar](50) NOT NULL,
[e1] [int] NULL,
[e2] [int] NULL,
[e3] [int] NULL,
[e4] [int] NULL,
[e5] [nvarchar](4000) NULL,
[e6] [nvarchar](4000) NULL,
[e7] [nvarchar](4000) NULL,
[e8] [nvarchar](4000) NULL,
[e9] [nvarchar](4000) NULL,
[e10] [datetime] NULL,
CONSTRAINT [PK_ZEX5] PRIMARY KEY CLUSTERED 
(
[id] ASC
)ON [PRIMARY]
) ON [PRIMARY]


SET IDENTITY_INSERT [Bas_Com] ON
INSERT [Bas_Com] ( [id] , [guid] , [ComTypeID] , [ComName] , [AddTime] , [MsgState] , [Notes] , [IsLock] , [StartTime] , [EndTime] , [Logo] , [WebUrl] , [BBSState], [ValidCodeState], [TipsState], [et1], [et2], [et3], [et4], [et5], [et6] ) VALUES ( 11 , '851e58844d85495c86739841fad988a9' , 0 , '某单位' , '2010-04-29 15:17:48.000' , 1 , '某单位' , 0 , '2010-04-29 00:00:00.000' , '2018-06-26 00:00:00.000' , '/logo.jpg' , 'http://www.job18.net' , 1 , 0 , 1 , 0 , 0 , 0 , '0730-8810280' , '' , '' )
SET IDENTITY_INSERT [Bas_Com] OFF

SET IDENTITY_INSERT [Calendar] ON
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 1 , '21' , '3xhN95pAHkSgnQh' , '每周例会' , '20110112T100000' , '20110112T110000' , '1295856209125' , '2011-01-24 16:04:23.500' , 0 , '大家踊跃发言。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 2 , '21' , 'ckMTpEdVI7l78Iu' , '公司周庆活动' , '20110113' , '20110114' , '1295856209126' , '2011-01-24 16:04:42.093' , 0 , '活动！' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 3 , '21' , 'LcjQhKFccxqNuJJ' , '伙伴公司前来参观考察' , '20110114T150000' , '20110114T173000' , '1295856209127' , '2011-01-24 16:05:34.780' , 0 , '做好相关准备' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 4 , '21' , 'FrO9EAjHwF6r42f' , '放假' , '20110115' , '20110116' , '1295856209128' , '2011-01-24 16:05:41.390' , 0 , '' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 5 , '21' , 'RWJrmFe0M4DTClO' , '工作日志記錄' , '20110112T133000' , '20110112T143000' , '1295856375375' , '2011-01-24 16:08:46.437' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查；' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 6 , '21' , 'EMoF0EgLTAaxCPT' , '工作汇报' , '20110124T180000' , '20110124T190000' , '1295856375376' , '2011-01-24 16:09:58.750' , 0 , '每一個部門負責人在每月30日前都要將本部門的工作情況寫成報告。該報告應將本部門的人員情況、工作情況、思想動態、業績、問題等一一寫實。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 7 , '21' , 'r348YRIzx2xEEAi' , '工作汇报' , '20110113T100000' , '20110113T110000' , '1295856375377' , '2011-01-24 16:07:23.827' , 0 , '工作汇报工作汇报' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 8 , '21' , 'aGJ8bnXCLLPF2zB' , '电话回访' , '20110113' , '20110114' , '1295856375378' , '2011-01-24 16:07:37.377' , 0 , '电话回访' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 9 , '21' , 'E9koV5Ds1amid4U' , '工作情況' , '20110124' , '20110125' , '1295856580296' , '2011-01-24 16:10:31.483' , 0 , '每年度結束後的新年元月五日前，員工須將一年的工作情況、任務完成情況、業績、問題、心得體會、對公司的認識、對主管領導的意見看法、對公司經營管理的建議等一一寫清楚' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 10 , '21' , 'A5eNBwbXOIN8FtK' , '工作日志' , '20110115T100000' , '20110115T110000' , '1295856580297' , '2011-01-24 16:10:58.797' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 11 , '31' , '3xhN95pAHkSgnQh' , '每周例会' , '20110112T100000' , '20110112T110000' , '1295856209125' , '2011-01-24 16:04:23.000' , 0 , '大家踊跃发言。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 12 , '31' , 'ckMTpEdVI7l78Iu' , '公司周庆活动' , '20110113' , '20110114' , '1295856209126' , '2011-01-24 16:04:42.000' , 0 , '活动！' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 13 , '31' , 'LcjQhKFccxqNuJJ' , '伙伴公司前来参观考察' , '20110114T150000' , '20110114T173000' , '1295856209127' , '2011-01-24 16:05:34.000' , 0 , '做好相关准备' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 14 , '31' , 'FrO9EAjHwF6r42f' , '放假' , '20110115' , '20110116' , '1295856209128' , '2011-01-24 16:05:41.000' , 0 , '' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 15 , '31' , 'RWJrmFe0M4DTClO' , '工作日志記錄' , '20110112T133000' , '20110112T143000' , '1295856375375' , '2011-01-24 16:08:46.000' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查；' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 16 , '31' , 'EMoF0EgLTAaxCPT' , '工作汇报' , '20110124T180000' , '20110124T190000' , '1295856375376' , '2011-01-24 16:09:58.000' , 0 , '每一個部門負責人在每月30日前都要將本部門的工作情況寫成報告。該報告應將本部門的人員情況、工作情況、思想動態、業績、問題等一一寫實。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 17 , '31' , 'r348YRIzx2xEEAi' , '工作汇报' , '20110113T100000' , '20110113T110000' , '1295856375377' , '2011-01-24 16:07:23.000' , 0 , '工作汇报工作汇报' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 18 , '31' , 'aGJ8bnXCLLPF2zB' , '电话回访' , '20110113' , '20110114' , '1295856375378' , '2011-01-24 16:07:37.000' , 0 , '电话回访' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 19 , '31' , 'E9koV5Ds1amid4U' , '工作情況' , '20110124' , '20110125' , '1295856580296' , '2011-01-24 16:10:31.000' , 0 , '每年度結束後的新年元月五日前，員工須將一年的工作情況、任務完成情況、業績、問題、心得體會、對公司的認識、對主管領導的意見看法、對公司經營管理的建議等一一寫清楚' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 20 , '31' , 'A5eNBwbXOIN8FtK' , '工作日志' , '20110115T100000' , '20110115T110000' , '1295856580297' , '2011-01-24 16:10:58.000' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 21 , '22' , '3xhN95pAHkSgnQh' , '每周例会' , '20110112T100000' , '20110112T110000' , '1295856209125' , '2011-01-24 16:04:23.000' , 0 , '大家踊跃发言。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 22 , '22' , 'ckMTpEdVI7l78Iu' , '公司周庆活动' , '20110113' , '20110114' , '1295856209126' , '2011-01-24 16:04:42.000' , 0 , '活动！' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 23 , '22' , 'LcjQhKFccxqNuJJ' , '伙伴公司前来参观考察' , '20110114T150000' , '20110114T173000' , '1295856209127' , '2011-01-24 16:05:34.000' , 0 , '做好相关准备' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 24 , '22' , 'FrO9EAjHwF6r42f' , '放假' , '20110115' , '20110116' , '1295856209128' , '2011-01-24 16:05:41.000' , 0 , '' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 25 , '22' , 'RWJrmFe0M4DTClO' , '工作日志記錄' , '20110112T133000' , '20110112T143000' , '1295856375375' , '2011-01-24 16:08:46.000' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查；' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 26 , '22' , 'EMoF0EgLTAaxCPT' , '工作汇报' , '20110124T180000' , '20110124T190000' , '1295856375376' , '2011-01-24 16:09:58.000' , 0 , '每一個部門負責人在每月30日前都要將本部門的工作情況寫成報告。該報告應將本部門的人員情況、工作情況、思想動態、業績、問題等一一寫實。' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 27 , '22' , 'r348YRIzx2xEEAi' , '工作汇报' , '20110113T100000' , '20110113T110000' , '1295856375377' , '2011-01-24 16:07:23.000' , 0 , '工作汇报工作汇报' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 28 , '22' , 'aGJ8bnXCLLPF2zB' , '电话回访' , '20110113' , '20110114' , '1295856375378' , '2011-01-24 16:07:37.000' , 0 , '电话回访' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 29 , '22' , 'E9koV5Ds1amid4U' , '工作情況' , '20110124' , '20110125' , '1295856580296' , '2011-01-24 16:10:31.000' , 0 , '每年度結束後的新年元月五日前，員工須將一年的工作情況、任務完成情況、業績、問題、心得體會、對公司的認識、對主管領導的意見看法、對公司經營管理的建議等一一寫清楚' )
INSERT [Calendar] ( [ID] , [UID] , [EID] , [EName] , [STime] , [ETime] , [CTime] , [MTime] , [LogicDelete] , [MEMO] ) VALUES ( 30 , '22' , 'A5eNBwbXOIN8FtK' , '工作日志' , '20110115T100000' , '20110115T110000' , '1295856580297' , '2011-01-24 16:10:58.000' , 0 , '每一位員工都應該有工作日志記錄，以備公司檢查' )
SET IDENTITY_INSERT [Calendar] OFF

SET IDENTITY_INSERT [Flows_Model] ON
INSERT [Flows_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 2 , 'a95e496e086b4f05b7c7e139067ef6cd' , 0 , '【示例】员工加班申请流程(公用流程)' , 31 , '管理员' , '某单位' , '这个流程用于员工加班申请的审批流转。' , '3' , '2011-01-24 15:10:43.000' , 1 , '' , '' )
INSERT [Flows_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 3 , '300f2e6ad7ac43f48ef9ae74e0f47a14' , 0 , '【示例】员工请假申请流程(公用流程)' , 31 , '管理员' , '某单位' , '员工请假申请流程' , '2' , '2011-01-24 15:16:10.000' , 1 , '' , '' )
INSERT [Flows_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 4 , '82ba5e0113714c59a21af1101b65f463' , 0 , '【示例】用车申请流程(研发部用车)' , 31 , '管理员' , '某单位' , '软件研发部 用车申请流程' , '4' , '2011-01-24 15:21:25.000' , 1 , '软件研发部#16#1,某单位#1#0,' , '软件研发部,某单位,' )
INSERT [Flows_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 5 , '55feaad85810463988ad15bb6c85a18e' , 0 , '【示例】办公用品采购申请流程(研发部采购)' , 31 , '管理员' , '某单位' , '软件研发部办公用品采购流程' , '5' , '2011-01-24 15:24:42.000' , 1 , '软件研发部#16#1,某单位#1#0,' , '软件研发部,某单位,' )
SET IDENTITY_INSERT [Flows_Model] OFF

SET IDENTITY_INSERT [Flows_ModelStep] ON
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 1 , 'b6303701eb3544219a0caeeff83a5270' , 0 , 2 , '上级主管审批' , '上级主管是否审批(这里是2人会签)' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 2 , '4f721c6504124040aa21ea791c732359' , 0 , 2 , '部门经理审批' , '部门经理是否同意。' , 2 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 3 , '12d5f717d6c04bfe87d8f22e98bf5b13' , 0 , 3 , '上级主管审批' , '上级主管是否同意' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 4 , 'cdda36e9142c45df946862e39ed97f4e' , 0 , 3 , '相关领导审批' , '领导审批(2人会签)' , 2 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 5 , '4506acb68c584333842e234d1736e5bb' , 0 , 4 , '上级主管审批(会签)' , '上级主管是否同意' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 7 , '3590f0b9cd6f461a9bf1a605264a3bbb' , 0 , 4 , '车辆主管领导审批' , '车辆主管领导是否同意' , 2 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 8 , 'dc0e8008b60e4f8cb9a624a83bf61ee0' , 0 , 5 , '专员审核' , '专员审核' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 9 , 'a17cabe68e1147f68780ffce05d50943' , 0 , 5 , '上级主管审核' , '上级主管是否同意' , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Flows_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 10 , '0fb878b533614f18adb97769b7af4369' , 0 , 5 , '相关领导审核' , '相关领导是否同意' , 3 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
SET IDENTITY_INSERT [Flows_ModelStep] OFF

SET IDENTITY_INSERT [Flows_ModelFile] ON
INSERT [Flows_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime], [DocBody] ) VALUES ( 1 , '9552e493429443929d162c3706af00a6' , 0 , '【示例】标准版工作流表单' , '~/Files/FlowModelFiles/110124/标准版工作流表单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:25:31.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><b><u><span style=font-family:宋体; lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></u></b><b><span style=font-family:宋体;>申请报告<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></b></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>编号：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=mso-spacerun:yes;>&nbsp;</span></span>申请人：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>部门：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><b><o:p></o:p></b></span></span></span></p><table style="border-bottom:medium none;border-left:medium none;border-collapse:collapse;border-top:medium none;border-right:medium none;mso-border-alt:double windowtext 1.5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:1.5pt double windowtext;" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0><tbody><tr style=mso-yfti-irow:0;mso-yfti-firstrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:double windowtext 1.5pt;mso-border-bottom-alt:solid windowtext .5pt;" valign=top width=633 colspan=2><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>报告标题：</span></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;><span lang=EN-US><o:p></o:p></span></span></span>&nbsp;</p></td></tr><tr style=mso-yfti-irow:1;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=633 colspan=2><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>内容摘要：</span></span></p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;><span lang=EN-US><o:p></o:p></span></span></span>&nbsp;</p></td></tr><tr style=page-break-inside:avoid;height:16pt;mso-yfti-irow:2;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;height:16pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=633 colspan=2><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>其他说明：</span></span></p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="text-justify:inter-ideograph;text-align:justify;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;><span lang=EN-US><o:p></o:p></span></span></span>&nbsp;</p></td></tr><tr style=page-break-inside:avoid;height:38.5pt;mso-yfti-irow:3;mso-yfti-lastrow:yes;><td style="border-bottom:windowtext 1.5pt double;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:75.75pt;padding-right:5.4pt;height:38.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:double 1.5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=101><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>审批意见<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1.5pt double;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:398.65pt;padding-right:5.4pt;height:38.5pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=532><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p>&nbsp;<p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（签字）：</span></span></p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：</span></span></p></span></span></span></o:p></span></o:p></span></td></tr></tbody></table>' )
INSERT [Flows_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime], [DocBody] ) VALUES ( 2 , 'c68907d0a3ac495b9e2cf39614ac5617' , 0 , '【示例】员工请假表单' , '~/Files/FlowModelFiles/110124/员工请假单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:26:01.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;><span style=font-size:small;>员工请假单<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>&nbsp;&nbsp; 编号：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=mso-spacerun:yes;>&nbsp;</span></span>申请人：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;</span></span>部门：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><b><o:p></o:p></b></span></span></span></p><table style="border-bottom:medium none;border-left:medium none;border-collapse:collapse;border-top:medium none;border-right:medium none;mso-border-alt:double windowtext 1.5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:1.5pt double windowtext;" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0><tbody><tr style=mso-yfti-irow:0;mso-yfti-firstrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:double windowtext 1.5pt;mso-border-bottom-alt:solid windowtext .5pt;" valign=top width=633 colspan=3><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>请假事由</span></span><span style=font-family:宋体;><span style=font-size:small;>：</span></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p></td></tr><tr style=mso-yfti-irow:1;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=633 colspan=3><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>请假时间：<span lang=EN-US><o:p></o:p></span></span></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>自<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>年<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 至<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>年<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>时</span></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;><span lang=EN-US><o:p></o:p></span></span></span>&nbsp;</p><p style="text-align:right;line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal align=right><span style=font-family:宋体;><span style=font-size:small;>总共请假<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>天<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>小时<span lang=EN-US><o:p></o:p></span></span></span></p></td></tr><tr style=mso-yfti-irow:2;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:474.4pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=633 colspan=3><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>病假医生证明：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;</span></span></span></span><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;height:16pt;mso-yfti-irow:3;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:158.4pt;padding-right:5.4pt;height:16pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:double windowtext 1.5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=211 colspan=2><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>联系电话：<span lang=EN-US><o:p></o:p></span></span></span></p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:316pt;padding-right:5.4pt;height:16pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-right-alt:double windowtext 1.5pt;" valign=top width=421><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>联系地址：<span lang=EN-US><o:p></o:p></span></span></span></p></td></tr><tr style=page-break-inside:avoid;height:38.5pt;mso-yfti-irow:4;mso-yfti-lastrow:yes;><td style="border-bottom:windowtext 1.5pt double;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:75.75pt;padding-right:5.4pt;height:38.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:double 1.5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=101><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal>&nbsp;</p><p style="line-height:125%;margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>审批意见<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1.5pt double;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:398.65pt;padding-right:5.4pt;height:38.5pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=532 colspan=2><p>&nbsp;</p><p>&nbsp;</p><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（签字）：</span></span></p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：</span></span></p></span></span></td></tr></tbody></table>' )
INSERT [Flows_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime], [DocBody] ) VALUES ( 3 , '03ed896357e54caca4cd12d76c2d848b' , 0 , '【示例】加班申请表单' , '~/Files/FlowModelFiles/110124/加班申请单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:26:26.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;><span style=font-size:small;>加班申请单<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 编号：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>申请人：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>部门：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></span></span></p><table style="border-bottom:medium none;border-left:medium none;margin:auto auto auto 40.7pt;border-collapse:collapse;border-top:medium none;border-right:medium none;mso-border-alt:double windowtext 1.5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext;" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0><tbody><tr style=page-break-inside:avoid;mso-yfti-irow:0;mso-yfti-firstrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:double 1.5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">加班内容</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:solid .5pt;mso-border-top-alt:double 1.5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=469><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:1;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:double windowtext 1.5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoIndex1 align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">加班时间</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-right-alt:double windowtext 1.5pt;" valign=top width=469><p style="margin:0cm 0cm 0pt;" class=MsoIndex1><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><span style=font-size:small;><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><o:p></o:p></span></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:2;mso-yfti-lastrow:yes;><td style="border-bottom:windowtext 1.5pt double;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:double 1.5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">审批意见</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1.5pt double;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=469><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（签字）：</span></span></p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：</span></span></p></span></span></span></o:p></span></td></tr></tbody></table>' )
INSERT [Flows_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime], [DocBody] ) VALUES ( 4 , '4a6f338d0f97424d8e795a78fb894d9b' , 0 , '【示例】用车申请表单' , '~/Files/FlowModelFiles/110124/用车申请单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:27:08.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><b><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">用车申请单</span></b><b><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></b></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><span style=font-size:small;><span style=mso-spacerun:yes;>&nbsp;</span><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style=font-family:宋体;>编号：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>申请人：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>部门：</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体;> <span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></span><span style=font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><table style="border-bottom:medium none;border-left:medium none;margin:auto auto auto 40.7pt;border-collapse:collapse;border-top:medium none;border-right:medium none;mso-border-alt:double windowtext 1.5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext;" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0><tbody><tr style=page-break-inside:avoid;mso-yfti-irow:0;mso-yfti-firstrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:double 1.5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">用车部门</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:windowtext 1.5pt double;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-bottom-alt:solid .5pt;mso-border-left-alt:solid .5pt;mso-border-top-alt:double 1.5pt;mso-border-right-alt:double 1.5pt;mso-border-color-alt:windowtext;" valign=top width=469><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:1;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:double windowtext 1.5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoIndex1 align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">用车原因</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-right-alt:double windowtext 1.5pt;" valign=top width=469><p style="margin:0cm 0cm 0pt;" class=MsoIndex1><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><span style=font-size:small;><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><o:p></o:p></span></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:2;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:double windowtext 1.5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">目的地</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-right-alt:double windowtext 1.5pt;" valign=top width=469><p style="text-indent:12pt;margin:0cm 0cm 0pt;mso-char-indent-count:1.0;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-indent:12pt;margin:0cm 0cm 0pt;mso-char-indent-count:1.0;" class=MsoNormal><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">从</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">至</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:3;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:double windowtext 1.5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">用车时间</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;mso-border-right-alt:double windowtext 1.5pt;" valign=top width=469><p style="text-indent:12pt;margin:0cm 0cm 0pt;mso-char-indent-count:1.0;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-indent:12pt;margin:0cm 0cm 0pt;mso-char-indent-count:1.0;" class=MsoNormal><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">从</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">至</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:4;mso-yfti-lastrow:yes;><td style="border-bottom:windowtext 1.5pt double;border-left:windowtext 1.5pt double;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:81.95pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-bottom-alt:double 1.5pt;mso-border-left-alt:double 1.5pt;mso-border-top-alt:solid .5pt;mso-border-right-alt:solid .5pt;mso-border-color-alt:windowtext;" valign=top width=109><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-size:small;><span style="font-family:宋体;mso-ascii-font-family:楷体_GB2312;mso-hansi-font-family:''Times New Roman'';">审批意见</span><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1.5pt double;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:351.75pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1.5pt double;padding-top:0cm;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=469><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（签字）：</span></span></p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：</span></span></p></span></span></span></o:p></span></o:p></span></td></tr></tbody></table>' )
INSERT [Flows_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime], [DocBody] ) VALUES ( 5 , '3f2d52444f964b659abf0898a2ab7dec' , 0 , '【示例】办公用品采购申请表单' , '~/Files/FlowModelFiles/110124/办公用品采购申请单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:27:44.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;><span style=font-size:small;>办公用品采购申请单<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>编号：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;</span><b><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b></span>申请人：<span lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=mso-spacerun:yes;>&nbsp;</span><span style=mso-spacerun:yes;>&nbsp;</span></span>部门：<b> <span style=mso-spacerun:yes;>&nbsp;</span><span lang=EN-US><o:p></o:p></span></b></span></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><table style="border-bottom:medium none;border-left:medium none;width:453.2pt;border-collapse:collapse;border-top:medium none;border-right:medium none;mso-border-alt:solid windowtext .5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext;" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=604><tbody><tr style=page-break-inside:avoid;mso-yfti-irow:0;mso-yfti-firstrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:52.4pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;" valign=top width=70><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>日期<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:176.25pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;" valign=top width=235><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>物品名称<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:58.15pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;" valign=top width=78><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>规格<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:70.35pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;" valign=top width=94><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体;><span style=font-size:small;>数量<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;" valign=top width=64><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>金额<span lang=EN-US><o:p></o:p></span></span></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48.05pt;padding-right:5.4pt;border-top:windowtext 1pt solid;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>备注<span lang=EN-US><o:p></o:p></span></span></span></p></td></tr><tr style=page-break-inside:avoid;height:24.7pt;mso-yfti-irow:1;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:52.4pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=70><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:176.25pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=235><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:58.15pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=78><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:70.35pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=94><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48.05pt;padding-right:5.4pt;height:24.7pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;height:27.1pt;mso-yfti-irow:2;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:52.4pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=70><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:176.25pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=235><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:58.15pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=78><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:70.35pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=94><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48.05pt;padding-right:5.4pt;height:27.1pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;height:26.5pt;mso-yfti-irow:3;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:52.4pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=70><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:176.25pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=235><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:58.15pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=78><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:70.35pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=94><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48.05pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=page-break-inside:avoid;height:26.5pt;mso-yfti-irow:4;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:52.4pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=70><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:176.25pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=235><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:58.15pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=78><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:70.35pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=94><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td><td style="border-bottom:windowtext 1pt solid;border-left:#d4d0c8;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:48.05pt;padding-right:5.4pt;height:26.5pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=64><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=height:56pt;mso-yfti-irow:5;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:453.2pt;padding-right:5.4pt;height:56pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=604 colspan=6><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>申请理由：<span lang=EN-US><o:p></o:p></span></span></span></p></td></tr><tr style=page-break-inside:avoid;mso-yfti-irow:6;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:453.2pt;padding-right:5.4pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=604 colspan=6><p style="margin:0cm 0cm 0pt;tab-stops:282.0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p><p style="margin:0cm 0cm 0pt;tab-stops:282.0pt;" class=MsoNormal><span style=font-family:宋体;><span style=font-size:small;>预计使用日期：<span lang=EN-US><o:p></o:p></span></span></span></p><p style="margin:0cm 0cm 0pt;tab-stops:282.0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>&nbsp;</span></o:p></span></p></td></tr><tr style=height:84.25pt;mso-yfti-irow:7;mso-yfti-lastrow:yes;><td style="border-bottom:windowtext 1pt solid;border-left:windowtext 1pt solid;padding-bottom:0cm;background-color:transparent;padding-left:5.4pt;width:453.2pt;padding-right:5.4pt;height:84.25pt;border-top:#d4d0c8;border-right:windowtext 1pt solid;padding-top:0cm;mso-border-alt:solid windowtext .5pt;mso-border-top-alt:solid windowtext .5pt;" valign=top width=604 colspan=6><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;>审批意见：</span></o:p></span></p><span style=font-family:宋体; lang=EN-US><o:p><span style=font-size:small;><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><p style="margin:0cm 0cm 0pt;" class=MsoNormal><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p></o:p></span>&nbsp;</p><span style=font-family:楷体_GB2312;mso-fareast-font-family:宋体; lang=EN-US><o:p><span style=font-size:small;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; （签字）：</span></span></p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;><p><span style="font-family:''Times New Roman'';font-size:12pt;mso-fareast-font-family:宋体;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;" lang=EN-US><span style=mso-spacerun:yes;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日期：</span></span></p></span></span></span></o:p></span></span></o:p></span></td></tr></tbody></table>' )
SET IDENTITY_INSERT [Flows_ModelFile] OFF

SET IDENTITY_INSERT [Gov_Model] ON
INSERT [Gov_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 1 , '204962d009fd40529b83b6613be75242' , 0 , '【示例】会议纪要' , 31 , '管理员' , '某单位' , '会议纪要' , '1' , '2011-01-24 15:31:05.000' , 1 , '' , '' )
INSERT [Gov_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 2 , '6bf41913af154dbe954713567537e273' , 0 , '【示例】秘书处发文通知' , 31 , '管理员' , '某单位' , '秘书处发文通知' , '0' , '2011-01-24 15:34:21.000' , 1 , '' , '' )
INSERT [Gov_Model] ( [id] , [guid] , [ComID] , [Flow_Name] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [Remark] , [ModelFileID] , [AddTime] , [IsComplete] , [ShareDeps] , [namelist] ) VALUES ( 3 , 'c90381dcefa74171b6dd917d8d5293b2' , 0 , '【示例】红头文件公文流转' , 31 , '管理员' , '某单位' , '红头文件公文流转' , '3' , '2011-01-24 15:42:13.000' , 1 , '' , '' )
SET IDENTITY_INSERT [Gov_Model] OFF

SET IDENTITY_INSERT [Gov_ModelStep] ON
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 1 , 'c8ba2f0c9b404c6f859a064559632164' , 0 , 1 , '发文拟稿确认' , '拟稿审批流程的确认' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 2 , '69913297a7d541a48567958c24dc734c' , 0 , 1 , '办公室审核' , '办公室审核' , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 3 , '340a76178a2f418fbaaf415f534cc61f' , 0 , 1 , '相关领导审批' , '相关领导审批(会签)' , 3 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 4 , 'fdfa3f1d32f34a118a50538e1eb1984c' , 0 , 1 , '办公室正式签发' , '办公室正式签发' , 4 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 5 , 'd0935ec6fdca4f48b4d42ba09cdff1e1' , 0 , 2 , '发文拟稿确认' , '发文拟稿确认' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 6 , '1cd01081af294aac968ae2cccfda61ad' , 0 , 2 , '办公室审核' , '办公室审核' , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 7 , 'eb198d9829d84e31b0915a2745a9c13a' , 0 , 2 , '各科室审批(会签)' , '各科室审批' , 3 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 8 , 'c80aa490eb62459592f7981a7c704c3c' , 0 , 2 , '相关领导审批，公文正式签发' , '相关领导审批，公文正式签发' , 4 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 9 , '8de56094ac72471fbd92f5f14993a465' , 0 , 3 , '发文拟稿确认' , '发文拟稿确认' , 1 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 10 , '7b54d086dcdc4029ad14d72a13d19405' , 0 , 3 , '办公室审核' , '办公室审核' , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 11 , 'b7d482fb9f364faeae71eae549ebe1a6' , 0 , 3 , '相关领导审批(会签)' , '相关领导审批' , 3 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
INSERT [Gov_ModelStep] ( [id] , [guid] , [ComID] , [Flow_ModelID] , [Step_Name] , [Step_Remark] , [Step_Orders] , [RightToFinish] , [MailAlert] , [IsEnd] , [IsHead] , [IsUserEdit] , [IsUserFile] , [Step_Type] , [UserList] , [NameList] , [UserList_dep] , [NameList_dep] ) VALUES ( 12 , 'de3c4087e46e408488213a567b02966e' , 0 , 3 , '秘书办正式签发' , '正式签发' , 4 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , '' , '' , '' , '' )
SET IDENTITY_INSERT [Gov_ModelStep] OFF

SET IDENTITY_INSERT [Gov_ModelFile] ON
INSERT [Gov_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime] , [DocBody]) VALUES ( 1 , '9e2c6a1d636f473fa15c49e5bdc61f6d' , 0 , '【示例】会议纪要表单' , '~/Files/GovModelFiles/110124/会议纪要表单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:33:56.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:16pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>会议纪要：关于《<span lang=EN-US>XXX</span>会议》的纪要<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:9pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>公文类型：<span lang=EN-US>[</span>会议纪要<span lang=EN-US>]&nbsp;&nbsp;&nbsp;</span>发文单位：分局<span lang=EN-US>&nbsp;&nbsp;&nbsp;</span>发文日期<span lang=EN-US>/</span>时间：<?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><st1:chsdate year=2010 month=12 day=5 islunardate=False isrocdate=False w:st=on><span lang=EN-US>2010-12-05</span></st1:chsdate><span lang=EN-US>&nbsp;10:20:08</span></span></b><b><span style=font-family:宋体;color:red;font-size:15pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;mso-bidi-font-size:12.0pt; lang=EN-US><o:p></o:p></span></b></p><hr /><p align=center>&nbsp;</p><p>&nbsp;<p>内容</p>' )
INSERT [Gov_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime] , [DocBody]) VALUES ( 2 , 'efd14f8959ee412f87c19f34518f9643' , 0 , '【示例】发文通知表单' , '~/Files/GovModelFiles/110124/发文通知表单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:34:03.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:16pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>发文：这里是发文通知的标题 <span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:9pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>公文类型：<span lang=EN-US>[</span>正式发文<span lang=EN-US>]&nbsp;&nbsp;&nbsp;</span>发文单位：分局<span lang=EN-US>&nbsp;&nbsp;&nbsp;</span>发文日期<span lang=EN-US>/</span>时间：<span lang=EN-US>2010-11-05&nbsp;10:20:08</span></span></b><b><span style=font-family:宋体;color:red;font-size:15pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;mso-bidi-font-size:12.0pt; lang=EN-US><o:p></o:p></span></b></p><hr /><p align=center>&nbsp;</p><p>&nbsp;</p><p>内容</p>' )
INSERT [Gov_ModelFile] ( [id] , [guid] , [ComID] , [FormTitle] , [FilePath] , [CreatorID] , [CreatorRealName] , [CreatorDepName] , [AddTime] , [DocBody]) VALUES ( 3 , '1078997753734d4a85368fee4626a919' , 0 , '【示例】红头文件表单' , '~/Files/GovModelFiles/110124/红头文件表单.doc|' , 31 , '管理员' , '某单位' , '2011-01-24 13:34:09.000', '<p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:16pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>红头文件：这里是红头文件标题<span lang=EN-US><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></span></span></b></p><p style="text-align:center;margin:0cm 0cm 0pt;" class=MsoNormal align=center><b><span style=font-family:宋体;color:red;font-size:9pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;>公文类型：<span lang=EN-US>[</span>政府文件<span lang=EN-US>]&nbsp;&nbsp;&nbsp;</span>发文单位：分局<span lang=EN-US>&nbsp;&nbsp;&nbsp;</span>发文日期<span lang=EN-US>/</span>时间：<?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><st1:chsdate year=2010 month=10 day=5 islunardate=False isrocdate=False w:st=on><span lang=EN-US>2010-10-05</span></st1:chsdate><span lang=EN-US>&nbsp;10:20:08</span></span></b><b><span style=font-family:宋体;color:red;font-size:15pt;mso-font-kerning:0pt;mso-bidi-font-family:宋体;mso-bidi-font-size:12.0pt; lang=EN-US><o:p></o:p></span></b></p><p><hr /><p></p><p>&nbsp;</p><p>&nbsp;</p><p>内容</p>' )
SET IDENTITY_INSERT [Gov_ModelFile] OFF

SET IDENTITY_INSERT [News_Type] ON
INSERT [News_Type] ( [id] , [guid] , [ComID] , [TypeName] , [Notes] , [Orders] ) VALUES ( 3 , '54e4d92a6e51422d8e9a68a58df01b24' , 11 , '通知公告' , '通知公告' , 0 )
INSERT [News_Type] ( [id] , [guid] , [ComID] , [TypeName] , [Notes] , [Orders] ) VALUES ( 4 , '7348448cf01f4a87aad805fb6ded6659' , 11 , '规章制度' , '规章制度' , 1 )
INSERT [News_Type] ( [id] , [guid] , [ComID] , [TypeName] , [Notes] , [Orders] ) VALUES ( 5 , '9a47b23a9c724bfbb4a0a9ca938138a9' , 11 , '公共资源' , '公共资源' , 2 )
INSERT [News_Type] ( [id] , [guid] , [ComID] , [TypeName] , [Notes] , [Orders] ) VALUES ( 6 , '688e525129a44fbea93ced5d982870ac' , 11 , '企业新闻' , '企业新闻' , 0 )
SET IDENTITY_INSERT [News_Type] OFF

SET IDENTITY_INSERT [Sys_Dep] ON
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [ComGUID] , [Phone] ) VALUES ( 1 , 'b88b2a80-170a-4579-a337-075b3f395841' , '某单位' , '某单位' , 0 , 0 , 0 , 11 , '851e58844d85495c86739841fad988a9' , '8810280' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 16 , '087b2f4f-c196-467d-b232-66281edc89e5' , '软件研发部' , '123' , 227 , 1 , 98 , 11 , '8810280' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 23 , 'd89450be-657e-407e-a41d-ccc8afe11273' , '综合管理部' , '123' , 1 , 1 , 1 , 11 , '' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 24 , '3318f643-369d-46ce-a461-fd4a2876cb94' , '市场企划' , '123' , 23 , 1 , 2 , 11 , '' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 25 , '0363f36e-02c7-4ac2-a5a0-8fdf9b8e3097' , '财务部' , '123' , 23 , 1 , 2 , 11 , '' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 26 , 'ae50ac1e-b210-49c7-becc-fad32a797f21' , '行政部' , '123' , 23 , 1 , 2 , 11 , '' )
INSERT [Sys_Dep] ( [id] , [guid] , [DepName] , [Notes] , [ParentID] , [IsPosition] , [Orders] , [ComID] , [Phone] ) VALUES ( 227 , 'c92d5abf-afd3-42da-9418-c75f712790a1' , '技术部门' , '用于初期测试使用' , 1 , 1 , 101 , 11 , '' )
SET IDENTITY_INSERT [Sys_Dep] OFF

SET IDENTITY_INSERT [Sys_Module] ON
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 14 , 'a683ca162874444c874f953df1cfea66' , '系统设置' , '系统基本设置' , '/Manage/sys/Com_Basic.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 15 , '56acd22779754117b035068df78e3fcc' , '系统设置' , '系统模块添加与编辑' , '/Manage/sys/Module_Manage.aspx' , 2 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 16 , 'c3467318f3724455af480596d9128194' , '系统设置' , '系统模块管理列表' , '/Manage/sys/Module_List.aspx' , 3 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 17 , 'ac992417100d4d1cbcd71cb2e6592c64' , '系统设置' , '角色添加与编辑' , '/Manage/sys/Role_Manage.aspx' , 4 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 18 , '4ebdb50b35c94fa784484a09813e3a3f' , '系统设置' , '角色管理列表' , '/Manage/sys/Role_List.aspx' , 5 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 19 , '186d9626f81c4062851ab1181f00bfa2' , '人事用户管理' , '用户添加与编辑' , '/Manage/sys/User_Manage.aspx' , 6 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 20 , '7e97921220ac4dea9e2cb5abb58bf0d5' , '人事用户管理' , '用户列表' , '/Manage/sys/User_List.aspx' , 7 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 21 , '6fcaa7b7ca1e442a86957bed5f761592' , '系统设置' , '组织机构添加与编辑' , '/Manage/sys/Dep_Manage.aspx' , 8 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 22 , 'f5c5c4bb0287440094dad9805b67f488' , '系统设置' , '组织机构列表' , '/Manage/sys/Dep_List.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 24 , '009f1e113b7b4ffb88fbdff007e9c0c7' , '工作流程管理' , '流程模型列表' , '/Manage/Flow/Flow_ModelList.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 25 , 'a611e85d8885407eac744c5db86cc958' , '工作流程管理 ' , '流程模型添加与编辑' , '/Manage/Flow/Flow_ModelManage.aspx' , 2 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 26 , '02d3e0b565ff492cadd29c208a9de9e0' , '工作流程管理 ' , '流程表单列表' , '/Manage/Flow/Flow_ModelFileList.aspx' , 3 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 27 , '10aed139f3c84220b5e2b79a9ba66cc2' , '工作流程管理 ' , '流程表单添加与编辑' , '/Manage/Flow/Flow_ModelFileManage.aspx' , 4 , 1 , '' , 11 )

INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 28 , '08bc5d98c8d14ea1889d14288b7c58c1' , '工作流程管理' , '所有流程列表管理' , '/Manage/flow/Flow_ListAll.aspx' , 5 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 29 , '64056c43dad6431dab454dc26da1eefd' , '资讯管理' , '资讯列表' , '/manage/news/News_AllList.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 30 , 'cf4599af5c044873938614e4856cecbc' , '资讯管理' , '资讯添加与编辑' , '/manage/news/News_Manage.aspx' , 2 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 31 , '9a09033a22ac4140beecae871edff8df' , '资讯管理' , '资讯分类列表' , '/manage/news/NewsType_List.aspx' , 3 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 32 , '1d21cd988c894c36ae53cae2cb28c700' , '资讯管理' , '资讯分类添加与编辑' , '/manage/news/NewsType_Manage.aspx' , 4 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 33 , 'ad11cce826554896ba4550b4071c5451' , '文档管理' , '用户文档管理' , '/manage/doc/Doc_AllList.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 34 , '0e16d2d8727041eab803456ab8194f20' , '公文系统管理' , '公文模型列表' , '/manage/gov/gov_ModelList.aspx' , 5 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 35 , 'a7fcd73ebe5945a3bebc222b7efd445d' , '公文系统管理' , '公文模型添加与编辑' , '/manage/gov/gov_ModelManage.aspx' , 6 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 36 , 'e8af5f2a85064df78b8b7283cea5f9dd' , '公文系统管理' , '公文表单列表' , '/manage/gov/gov_ModelFileList.aspx' , 7 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 37 , '4439049af07646f69e4211ecc1e883b3' , '公文系统管理' , '公文表单添加与编辑' , '/manage/gov/gov_ModelFileManage.aspx' , 8 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 38 , '2cb4ca0a505a4ffea56bbd2352955f36' , '公文系统管理' , '所有公文监控' , '/manage/gov/gov_ListAll.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 39 , '668ab1c010e14e4aab4061b85c9c921f' , '印章/签名管理' , '印章/签名列表' , '/Manage/Sys/Seal_List.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 40 , 'feecb9b9c94d4692a527de8782db3bcc' , '印章/签名管理' , '印章/签名编辑' , '/manage/sys/Seal_Manage.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 41 , 'a282c364ac754da0a1049854cefd91ea' , '资讯管理' , '滚动公告编辑' , '/manage/news/Tips_Manage.aspx' , 5 , 1 , '' , 0 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 42 , 'cb38bc4534804263a7d0e3c057502bf7' , '资讯管理' , '滚动公告管理列表' , '/manage/news/Tips_List.aspx' , 6 , 1 , '' , 0 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 43 , 'f0d89a066ef54b7ea4ad256f4b430051' , '系统设置' , '系统数据库备份' , '/Manage/sys/DbBackup.aspx' , 9 , 1 , '' , 0 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 44 , 'acd4ca0a505d4fcea51bbd2352151f3a' , '公文系统管理' , '公文拟稿' , '/manage/gov/Gov_Manage.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 45 , 'baa46a0a405a4dfea56bbd2352955f36' , '投票管理' , '投票管理' , '/Manage/Common/Vote_AllList.aspx' , 5 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 46 , '79a1d23279a56117b095061df18e3fc1' , '人事考勤管理' , '设置考勤时间' , '/Manage/Attend/WorkSet.aspx' , 6 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 47 , '185d5a26f13c4c62852ab1541f01bfa3' , '人事考勤管理' , '考勤统计' , '/Manage/Attend/WorkList.aspx' , 7 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 48 , '2a6d2625681c4d61151dc3182fa0b5a1' , '系统设置' , '系统登录记录' , '/Manage/sys/User_LoginList.aspx' , 9 , 1 , '' , 11 )

INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 49 , 'a1c5c1bd02874100945ad9805267f481' , '工作任务' , '任务分类列表' , '/Manage/Tasks/TaskType_List.aspx' , 1 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 50 , 'c2c5ccba028244009adad9804b67f482' , '工作任务' , '新增任务分类' , '/Manage/Tasks/TaskType_Manage.aspx' , 2 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 51 , 'b3c5c4b4024744009cdad9807b67f483' , '工作任务' , '所有任务列表' , '/Manage/Tasks/Task_AllList.aspx' , 3 , 1 , '' , 11 )

INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 52 , '140a6c43dad1431dab454dc26da1eefa' , '电子档案' , '电子档案编辑' , '/manage/Paper/PaperManage.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 53 , '2f4c99af5c044873238614e4856cecbb' , '电子档案' , '电子档案管理' , '/manage/Paper/PaperAllList.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 54 , '3a0c033a22ac4140be3cae871edff8dc' , '电子档案' , '档案分类编辑' , '/manage/Paper/PaperType_Manage.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 55 , '4d2dcd988c894c36ae534ae2cb28c70d' , '电子档案' , '档案分类列表' , '/manage/Paper/PaperType_List.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 56 , '5d213d985c894c36ae53cae2cb28c70e' , '电子档案' , '档案下载记录' , '/manage/Paper/DownLoadList.aspx' , 9 , 1 , '' , 11 )

INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 57 , '119f1e313b7b4ffb84fbdaf007e9cacb' , '工作流程管理' , '模型分类编辑' , '/Manage/Flow/FlowType_Manage.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 58 , '2213e85d8885407eac754c5ab861dd5c' , '工作流程管理' , '模型分类列表' , '/Manage/Flow/FlowType_List.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 59 , '44af5f2a8506cdf78b8b7183cea2f92d' , '公文系统管理' , '模型分类编辑' , '/Manage/Gov/GovType_Manage.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 60 , '3339a49af07d46f69e42a1e9c1e88371' , '公文系统管理' , '模型分类列表' , '/Manage/Gov/GovType_List.aspx' , 9 , 1 , '' , 11 )

INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 63 , '5325c625c81c4d62151a13132faab15a' , '手机短信' , '短信发送记录' , '/Manage/sms/SMS_AllList.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 64 , '6235c62ab81c4a61151c14132f25b11a' , '手机短信' , '短信设置' , '/Manage/sms/SMS_SetUp.aspx' , 9 , 1 , '' , 11 )
INSERT [Sys_Module] ( [id] , [guid] , [TypeName] , [ModuleName] , [ModuleUrl] , [Orders] , [IsShow] , [Notes] , [ComID] ) VALUES ( 65 , '714a262aa81c4a61532a14132f25b32b' , '手机短信' , '发送手机短信' , '/Manage/sms/SMS_Send.aspx' , 9 , 1 , '' , 11 )
SET IDENTITY_INSERT [Sys_Module] OFF

SET IDENTITY_INSERT [Sys_Role] ON
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 4 , '2690b999e7d44cc9a63c6ec133a3de4d' , '系统超级管理员' , '系统管理员，默认拥有所有权限。' , 11 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 10 , '8e24035e6e4748258033c84aede025fc' , '资讯与公告管理角色' , '资讯及滚动公告的管理' , 11 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 13 , 'f9383644fada4c808b010e3fcced1078' , '人事管理角色' , '所有用户和考勤的管理' , 0 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 14 , '23c9363b9f4f4fe1b3551b9aa3ec228b' , '工作流程管理角色' , '制定流程模型，管理所有流程。' , 0 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 15 , '4f9f1578f0b547f68a7c3a0758b94d04' , '公文系统管理角色' , '制定公文审批流程模型，管理所有公文' , 0 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 16 , '0d8f4a32db164a749fcde44d39a799d7' , '公文拟稿人' , '拥有公文拟稿权限' , 0 )
INSERT [Sys_Role] ( [id] , [guid] , [RoleName] , [Notes] , [ComID] ) VALUES ( 17 , 'a1814a31db1c4a149fbde12d39a5a21a' , '普通用户' , '不具备模块管理权限,适合一般使用人员' , 0 )
SET IDENTITY_INSERT [Sys_Role] OFF

SET IDENTITY_INSERT [Sys_Role_Module] ON
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 50 , '58543b985c7442a48de6acbb32d4216b' , 4 , 15 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 51 , '1ad91696017546498360f5d53947ab42' , 4 , 16 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 52 , '62e5c2a61e4748dda973cd9a4510a51a' , 4 , 17 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 53 , '8cc3782d0c7d49b398724f03e80305de' , 4 , 18 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 54 , '0adf0a88eab94945823a75aceb621b72' , 4 , 19 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 55 , 'e4d12531ff2b4cffa25fe221f55a89e7' , 4 , 20 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 56 , 'd29e8927646e42058c24a478d76e784a' , 4 , 21 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 57 , 'b73bcc2b73bd4044ad06a08154b2e9fd' , 4 , 22 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 58 , '34830dfb3d3241899e1f4b4a72effe04' , 4 , 14 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 70 , '3a16d064f7774e88ab51693314e5ade7' , 4 , 24 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 71 , 'c86e5a7fe0a04c54a271b1517549fb82' , 4 , 25 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 72 , '5c81033c8d304afdade9d65a4195cdfe' , 4 , 26 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 73 , 'e59802cf8d9b485c97428bbcf3e1fb32' , 4 , 27 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 74 , '4fbbd866a82044b8b5f60f37761295a9' , 4 , 28 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 75 , '8c798320681142ac9147e74d36df6338' , 4 , 29 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 76 , 'f1f28f0b0c5e4a29ad3a94b71222e535' , 4 , 30 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 77 , 'd1b5dbdf41364d3989ecd5bea4e4152f' , 4 , 31 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 78 , '1f7f66f481984e029e00fca600081ea3' , 4 , 32 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 79 , 'b308cc58eca44930aa15199aa1b31800' , 4 , 33 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 80 , '8a7ddfd6de204f6e8694768e332f3de9' , 4 , 34 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 81 , '2dcc0ab5ad98408485fc01a5535c12a4' , 4 , 35 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 82 , 'c945c3c27ed143f583a5c96a5a645f74' , 4 , 36 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 83 , '2d55e1f1527b460b86019b69b17e14de' , 4 , 37 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 84 , '0216f5d3cb304a4abdd364e1dca2e27c' , 4 , 38 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 85 , 'f1da3625a0604ecdb9ed90fef6587a44' , 10 , 29 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 86 , 'b47370aa218b44a5a3617e8b25c3a3b4' , 10 , 30 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 87 , 'cef075cdc4cb47b5b0ecbcb436fc638c' , 4 , 39 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 88 , '09bbd528ca4e47cbaa70e005a738a174' , 4 , 40 , 11 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 92 , '0ad9612d63c64cb391adc58566a27f69' , 4 , 41 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 93 , '67d3b805b64d430e8437d1f24c407f60' , 4 , 42 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 94 , '020145f0acd348b59f46cb1cb4b662e0' , 10 , 41 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 95 , '28698577994046f0bd5c185649403bdb' , 10 , 42 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 96 , '9cd9d25ba373473ca5d005343067a45a' , 4 , 43 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 97 , '5a90fe9ef82044fe9de48c7c72e9a21c' , 10 , 31 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 98 , 'fedb53f551cd4357a16ab7ef5cdc8720' , 10 , 32 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 99 , 'f59bb8098ab847f1a6c048896d8ade47' , 13 , 19 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 100 , 'cdf3ca62b8e1479ba010849ba4ed1b86' , 13 , 20 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 101 , '101dbdd2ecb54b56ac439a8a95c7288f' , 14 , 24 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 102 , '83c40fd8e1e9462186ec8267b1ed5739' , 14 , 25 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 103 , 'e61209d501df46708456f18f9448284b' , 14 , 26 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 104 , '3db76e53975f4dadbb45e3b694718a1b' , 14 , 27 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 105 , '52566d4116b7438b93c28096122237dc' , 14 , 28 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 106 , 'd3e63587ce6c4b768764bf1ea3f0d13a' , 15 , 34 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 107 , '0342e157241f47e588760f085ca7179c' , 15 , 35 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 108 , '455e397ead2d426fb218af99e593c90a' , 15 , 36 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 109 , '56cbeb2f7c1c44a09458007e9442b228' , 15 , 37 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 110 , 'faf713bfb0d2435ca35536e561e28535' , 15 , 38 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 111 , '1adca15ba31347aca5d0a1341017a45d' , 4 , 44 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 112 , '2ca9d2a1a373413ca5da0a313061a45c' , 17 , 44 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 113 , '3da13ac1a173113ca1da0a313061a1ac' , 16 , 44 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 114 , '5ad12ac1a1d31a1ca1aa0a3130a1a1aa' , 15 , 44 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 115 , 'a3a40fd5e3e1462186ec8267b1ed5739' , 4 , 45 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 116 , '14c4afd8e1e9462181ec8241b1ed5731' , 4 , 46 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 117 , '46d9d2cba373473ca5d105343067a453' , 4 , 47 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 118 , '35c4afd8e1e146a181ec8224b1ed5713' , 13 , 46 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 119 , '53d1d2cba373413ca5d105313a67a421' , 13 , 47 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 120 , '1ca135d0acd348b5bf4d3b1c24b312e3' , 4 , 48 , 0 )

INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 121 , 'a9b1de23ca5d47cb3a70ea25a718a17c' , 4 , 49 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 122 , '19b16e23ca1d47cb3a70ea25a718a1ec' , 4 , 50 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 123 , '59b2de23ca2d47cb3a70ea75a718a1a2' , 4 , 51 , 0 )

INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 124 , '3aa1a5a1dcd3151abf4dca112ac312e7' , 4 , 52 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 125 , '4cc1a5b1dcd3151abf4dc2a12ac312e6' , 4 , 53 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 126 , '5aa1a5c1dcd3151abf4d3aa12ac312e9' , 4 , 54 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 127 , '6cc1a5e1dcd3151abf5dcaa12ac312e1' , 4 , 55 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 128 , '71a1a521dcd3151abfadcaa12ac312e2' , 4 , 56 , 0 )

INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 129 , '96c3782d0c7d49b391724f03e80315da' , 4 , 57 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 130 , '87df0a88eab94945843a75aceb622b7b' , 4 , 58 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 131 , '78d12531ff2b4cffa35fe221f55a39ec' , 4 , 59 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 132 , '699e8927646e42058224a478d76e484d' , 4 , 60 , 0 )

INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 133 , '12340a88eab12145843a75aceb622123' , 4 , 63 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 134 , '56782531ff2b333fa35fe221f55a3432' , 4 , 64 , 0 )
INSERT [Sys_Role_Module] ( [id] , [guid] , [RoleID] , [ModuleID] , [ComID] ) VALUES ( 135 , '98768927646e45678224a478d76e4321' , 4 , 65 , 0 )
SET IDENTITY_INSERT [Sys_Role_Module] OFF

SET IDENTITY_INSERT [Sys_User] ON
INSERT [Sys_User] ( [id] , [guid] , [UserName] , [PassWord] , [RealName] , [Sex] , [Birthday] , [QQ] , [Email] , [Tel] , [Phone] , [RoleID] , [DepID] , [DepName] , [LastLoginIp] , [LastLoginTime] , [LoginQuantity] , [Status] , [IsLock] , [RegFromIp] , [RegTime] , [ComID] , [ComGUID] , [Notes] , [JoinTime] , [DirectSupervisor] , [PositionName] , [HomeAddress] , [MsgTime] , [MemoShare] , [Orders] , [PerPic] , [et1] , [et2] , [et3] , [et4] , [et5] , [et6] ) VALUES ( 21 , '8ad241e2c8914203a778aba65a083acf' , 'lilin' , 'cfcd208495d565ef66e7dff9f98764da' , '李林' , 0 , '' , '' , '' , '' , '' , 17 , 16 , '软件研发部' , '127.0.0.1' , '2010-11-05 16:32:52.000' , 147 , 0 , 0 , '192.168.1.111' , '2010-05-11 09:53:09.000' , 11 , '' , '' , '' , 0 , 'ddd' , '' , 30 , 1 , 0 , '' , 0 , 0 , 0 , '' , '管理员(某单位),' , '管理员#31#某单位,' )
INSERT [Sys_User] ( [id] , [guid] , [UserName] , [PassWord] , [RealName] , [Sex] , [Birthday] , [QQ] , [Email] , [Tel] , [Phone] , [RoleID] , [DepID] , [DepName] , [LastLoginIp] , [LastLoginTime] , [LoginQuantity] , [Status] , [IsLock] , [RegFromIp] , [RegTime] , [ComID] , [Notes] , [JoinTime] , [DirectSupervisor] , [PositionName] , [HomeAddress] , [MsgTime] , [MemoShare] , [Orders] , [PerPic] , [et1] , [et2] , [et3] , [et4] , [et5] , [et6] ) VALUES ( 22 , '51945f0a277944dabaea427ff15136d8' , 'yanglei' , 'cfcd208495d565ef66e7dff9f98764da' , '杨磊' , 0 , '' , '' , '' , '' , '' , 17 , 16 , '软件研发部' , '127.0.0.1' , '2010-12-26 23:51:11.000' , 118 , 0 , 0 , '192.168.1.111' , '2010-05-11 09:53:32.000' , 11 , '' , '' , 0 , '软件工程师' , '' , 30 , 1 , 0 , '' , 0 , 0 , 0 , '' , '管理员(某单位),' , '管理员#31#某单位,' )
INSERT [Sys_User] ( [id] , [guid] , [UserName] , [PassWord] , [RealName] , [Sex] , [Birthday] , [QQ] , [Email] , [Tel] , [Phone] , [RoleID] , [DepID] , [DepName] , [LastLoginIp] , [LastLoginTime] , [LoginQuantity] , [Status] , [IsLock] , [RegFromIp] , [RegTime] , [ComID] , [Notes] , [JoinTime] , [DirectSupervisor] , [PositionName] , [HomeAddress] , [MsgTime] , [MemoShare] , [Orders] , [PerPic] , [et1] , [et2] , [et3] , [et4] , [et5] , [et6] ) VALUES ( 23 , 'f763877b08234f49be1cc2e708231223' , 'maojie' , 'cfcd208495d565ef66e7dff9f98764da' , '毛杰' , 1 , '' , '' , '' , '' , '' , 17 , 25 , '财务部' , '127.0.0.1' , '2010-12-26 23:51:57.000' , 83 , 0 , 0 , '192.168.1.111' , '2010-05-11 09:53:58.000' , 11 , '一二三' , '' , 0 , '技术主管' , '' , 30 , 0 , 0 , '' , 0 , 0 , 0 , '' , '管理员(某单位),' , '管理员#31#某单位,' )
INSERT [Sys_User] ( [id] , [guid] , [UserName] , [PassWord] , [RealName] , [Sex] , [Birthday] , [QQ] , [Email] , [Tel] , [Phone] , [RoleID] , [DepID] , [DepName] , [LastLoginIp] , [LastLoginTime] , [LoginQuantity] , [Status] , [IsLock] , [RegFromIp] , [RegTime] , [ComID] , [Notes] , [JoinTime] , [DirectSupervisor] , [PositionName] , [HomeAddress] , [MsgTime] , [MemoShare] , [Orders] , [PerPic] , [et1] , [et2] , [et3] , [et4] , [et5] , [et6] ) VALUES ( 24 , '8c989785efc14463a921502642655911' , 'zhoutao' , 'cfcd208495d565ef66e7dff9f98764da' , '周涛' , 0 , '' , '' , '' , '' , '' , 17 , 16 , '软件研发部' , '192.168.1.100' , '2010-12-19 15:47:57.000' , 53 , 0 , 0 , '192.168.1.111' , '2010-05-11 09:54:21.000' , 11 , '' , '' , 0 , '工程师' , '' , 30 , 0 , 0 , '' , 0 , 0 , 0 , '' , '管理员(某单位),' , '管理员#31#某单位,' )
INSERT [Sys_User] ( [id] , [guid] , [UserName] , [PassWord] , [RealName] , [Sex] , [Birthday] , [QQ] , [Email] , [Tel] , [Phone] , [RoleID] , [RoleGUID] , [DepID] , [DepName] , [LastLoginIp] , [LastLoginTime] , [LoginQuantity] , [Status] , [IsLock] , [RegFromIp] , [RegTime] , [ComID] , [ComGUID] , [Notes] , [JoinTime] , [DirectSupervisor] , [PositionName] , [HomeAddress] , [MsgTime] , [MemoShare] , [Orders] , [PerPic] , [et1] , [et2] , [et3] , [et4] , [et5] , [et6] ) VALUES ( 31 , 'b53a3b603842412ba2ce0563bad5274f' , 'manager' , 'e10adc3949ba59abbe56e057f20f883e' , '管理员' , 0 , '1981-05-12' , '' , '' , '' , '' , 4 , '20' , 1 , '某单位' , '127.0.0.1' , '2010-12-23 20:49:53.000' , 1003 , 0 , 0 , '127.0.0.1' , '2010-05-12 17:14:23.000' , 11 , '' , '' , '2010-07-14' , 0 , '网络系统管理员' , '12243' , 30 , 1 , 0 , '' , 0 , 0 , 0 , '' , '' , '' )
SET IDENTITY_INSERT [Sys_User] OFF

SET IDENTITY_INSERT [Sys_Seal] ON
INSERT [Sys_Seal] ( [id] , [guid] , [ComID] , [SealName] , [FilePath] , [TagName] , [Notes] , [AddTime] , [Status] , [PWD] , [Uid] ) VALUES ( 1 , '87219ec6105d4b35a8ffa06669e10981' , 0 , '【示例】电子公章01' , '~/Files/SealFiles/11123113457142.jpg' , '电子印章' , '初始设置密码admin' , '2011-01-23 23:38:46.000' , 1 , 'admin' , 31 )
INSERT [Sys_Seal] ( [id] , [guid] , [ComID] , [SealName] , [FilePath] , [TagName] , [Notes] , [AddTime] , [Status] , [PWD] , [Uid] ) VALUES ( 2 , '853cadead5b045eba33e5027950b887b' , 0 , '【示例】电子公章02' , '~/Files/SealFiles/11123113626079.jpg' , '电子印章' , '初始设置密码admin' , '2011-01-23 23:38:41.000' , 1 , 'admin' , 31 )
INSERT [Sys_Seal] ( [id] , [guid] , [ComID] , [SealName] , [FilePath] , [TagName] , [Notes] , [AddTime] , [Status] , [PWD] , [Uid] ) VALUES ( 3 , '72950f471ce14e77b44a2fcd4b664a0a' , 0 , '【示例】电子公章03' , '~/Files/SealFiles/11123113652938.jpg' , '电子印章' , '初始设置密码admin' , '2011-01-23 23:38:36.000' , 1 , 'admin' , 31 )
INSERT [Sys_Seal] ( [id] , [guid] , [ComID] , [SealName] , [FilePath] , [TagName] , [Notes] , [AddTime] , [Status] , [PWD] , [Uid] ) VALUES ( 4 , 'fba193fc5cd64f30b2dba13c7a7ffeb7' , 0 , '【示例】电子签名01' , '~/Files/SealFiles/11123113745329.jpg' , '电子签名' , '初始设置密码admin' , '2011-01-23 23:38:30.000' , 1 , 'admin' , 31 )
INSERT [Sys_Seal] ( [id] , [guid] , [ComID] , [SealName] , [FilePath] , [TagName] , [Notes] , [AddTime] , [Status] , [PWD] , [Uid] ) VALUES ( 5 , 'b17bb55353914098a72d2ca7e7c43c51' , 0 , '【示例】电子签名02' , '~/Files/SealFiles/11123113823626.jpg' , '电子签名' , '初始设置密码admin' , '2011-01-23 23:38:23.000' , 1 , 'admin' , 31 )
SET IDENTITY_INSERT [Sys_Seal] OFF

INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveTopicTitle] , [ActiveUser] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 1 , 0 , '|' , 0 , 1 , 3 , 1 , 0 , 5 , '内部版块' , 0 , 0 , 0 , 0 , '#000000' , '' , '' , '' , '' , '' , '' , 0 , 1 , 1 , 0 , 0 , 2 , 1 , 'test' , 'admin' , 1 , '2010-11-09 16:15:30.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2007-10-24 21:59:56.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveTopicTitle] , [ActiveUser] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 2 , 1 , '|1|' , 1 , 1 , 0 , 2 , 0 , 5 , '制度培训' , 1 , 0 , 0 , 0 , '#000000' , '' , '版规' , '' , '' , '' , '' , 1 , 1 , 1 , 0 , 0 , 2 , 0 , '' , '' , 0 , '2010-11-09 16:15:48.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2007-10-24 22:00:13.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveTopicTitle] , [ActiveUser] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 3 , 1 , '|1|' , 1 , 1 , 0 , 3 , 0 , 5 , '单位专刊' , 1 , 0 , 0 , 0 , '#000000' , '' , '版规' , '' , '' , '' , '' , 0 , 0 , 0 , 0 , 0 , 3 , 0 , '' , '' , 0 , '2010-10-25 09:52:24.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2007-10-24 22:00:25.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 4 , 1 , '|1|' , 1 , 1 , 0 , 4 , 0 , 5 , '意见箱' , 1 , 0 , 0 , 0 , '#000000' , '' , '' , '' , '' , '' , '' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '2010-10-25 13:22:08.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2010-10-25 13:22:08.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 5 , 0 , '|' , 0 , 5 , 2 , 5 , 0 , 5 , '自由版块' , 1 , 0 , 0 , 0 , '#000000' , '' , '' , '' , '' , '' , '' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '2010-10-25 13:22:25.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2010-10-25 13:22:25.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 6 , 5 , '|5|' , 1 , 5 , 0 , 6 , 0 , 5 , '快乐驿站' , 1 , 0 , 0 , 0 , '#000000' , '' , '' , '' , '' , '' , '' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '2010-10-25 13:22:50.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2010-10-25 13:22:50.000' )
INSERT [WC_Forum_Board] ( [ID] , [FatherID] , [FatherPath] , [Depth] , [RootID] , [ChildNum] , [Orders] , [ChildOrderType] , [ChildLineNum] , [BoardName] , [AllowTopic] , [ShowType] , [NeedConfirm] , [Locked] , [TitleColor] , [Content] , [BoardRule] , [Master] , [MasterID] , [Photo] , [Logo] , [TopicCount] , [TotalTopic] , [TotalReply] , [TodayTopic] , [TodayReply] , [ActiveBoardID] , [ActiveTopicID] , [ActiveUserID] , [ActiveTime] , [LevelID] , [TeamID] , [PowerType] , [TopicOrderType] , [TopicPerPage] , [ReplyPerPage] , [TemplateID] , [SkinID] , [AddTime] ) VALUES ( 7 , 5 , '|5|' , 1 , 5 , 0 , 7 , 0 , 5 , '品位人生' , 1 , 0 , 0 , 0 , '#000000' , '' , '' , '' , '' , '' , '' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '2010-10-25 13:23:10.000' , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|' , '' , 2 , 0 , 20 , 10 , 0 , 0 , '2010-10-25 13:23:10.000' )

SET IDENTITY_INSERT [WC_Forum_Emote] ON
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 1 , 'emote/em1.gif' , 1 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 2 , 'emote/em2.gif' , 2 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 3 , 'emote/em3.gif' , 3 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 4 , 'emote/em4.gif' , 4 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 5 , 'emote/em5.gif' , 5 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 6 , 'emote/em6.gif' , 6 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 7 , 'emote/em7.gif' , 7 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 8 , 'emote/em8.gif' , 8 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 9 , 'emote/em9.gif' , 9 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 10 , 'emote/em10.gif' , 10 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 11 , 'emote/em11.gif' , 11 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 12 , 'emote/em12.gif' , 12 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 13 , 'emote/em13.gif' , 13 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 14 , 'emote/em14.gif' , 14 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 15 , 'emote/em15.gif' , 15 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 16 , 'emote/em16.gif' , 16 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 17 , 'emote/em17.gif' , 17 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 18 , 'emote/em18.gif' , 18 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 19 , 'emote/em19.gif' , 19 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 20 , 'emote/em20.gif' , 20 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 21 , 'emote/em21.gif' , 21 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 22 , 'emote/em22.gif' , 22 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 23 , 'emote/em23.gif' , 23 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 24 , 'emote/em24.gif' , 24 )
INSERT [WC_Forum_Emote] ( [ID] , [FileName] , [Orders] ) VALUES ( 25 , 'emote/em25.gif' , 25 )
SET IDENTITY_INSERT [WC_Forum_Emote] OFF

SET IDENTITY_INSERT [WC_Forum_Face] ON
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 1 , 'userface/1.jpg' , 1 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 2 , 'userface/2.jpg' , 2 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 3 , 'userface/3.jpg' , 3 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 4 , 'userface/4.jpg' , 4 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 5 , 'userface/5.jpg' , 5 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 6 , 'userface/6.jpg' , 6 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 7 , 'userface/7.jpg' , 7 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 8 , 'userface/8.jpg' , 8 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 9 , 'userface/9.jpg' , 9 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 10 , 'userface/10.jpg' , 10 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 11 , 'userface/11.jpg' , 11 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 12 , 'userface/12.jpg' , 12 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 13 , 'userface/13.jpg' , 13 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 14 , 'userface/14.jpg' , 14 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 15 , 'userface/15.jpg' , 15 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 16 , 'userface/16.jpg' , 16 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 17 , 'userface/17.jpg' , 17 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 18 , 'userface/18.jpg' , 18 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 19 , 'userface/boy.jpg' , 19 )
INSERT [WC_Forum_Face] ( [ID] , [FileName] , [Orders] ) VALUES ( 20 , 'userface/girl.jpg' , 20 )
SET IDENTITY_INSERT [WC_Forum_Face] OFF

SET IDENTITY_INSERT [WC_Forum_Level] ON
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 1 , '管理员' , 0 , 80 , 1 , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|' , '|2|1|2|1|500|50000|200|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 2 , '超级版主' , 0 , 48 , 1 , '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 3 , '版主' , 0 , 32 , 2 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 4 , '实习版主' , 0 , 16 , 2 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|40|42|47|48|49|50|51|52|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 5 , '贵宾' , 0 , 16 , 3 , '|1|2|3|4|5|6|7|9|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|5|5|5|5|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 6 , '访客' , 0 , 0 , 4 , '' , '|0|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 7 , '贫穷农民' , 50 , 1 , 5 , '|1|2|3|4|5|6|7|9|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 8 , '普通工人' , 200 , 2 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 9 , '蓝领一族' , 800 , 3 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 10 , '白领阶层' , 1500 , 4 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 11 , '金领贵族' , 3000 , 5 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 12 , '企业老板' , 5000 , 9 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 13 , '资本家' , 10000 , 21 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
INSERT [WC_Forum_Level] ( [ID] , [LevelName] , [Point] , [Photo] , [Types] , [Power] , [StringPower] , [AddTime] ) VALUES ( 14 , '大资本家' , 20000 , 44 , 5 , '|1|2|3|4|5|6|7|9|14|16|17|18|19|20|21|22|23|24|25|26|27|28|29|33|34|35|36|37|38|39|' , '|2|1|2|1|500|20000|50|' , '2010-11-09 15:57:54.483' )
SET IDENTITY_INSERT [WC_Forum_Level] OFF

SET IDENTITY_INSERT [WC_Forum_Menu] ON
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [Content] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 1 , '登录' , '' , 'Login.aspx' , '_self' , '#000000' , 0 , 1 , 0 , 1 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 2 , '退出' , 'Logout.aspx' , '_self' , '#000000' , 0 , 0 , 1 , 13 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 7 , '用户中心' , 'ControlPanel.aspx' , '_self' , '#000000' , 0 , 0 , 1 , 6 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 9 , '在线' , 'UserOnline.aspx' , '_self' , '#000000' , 0 , 0 , 0 , 9 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 10 , '搜索' , 'Search.aspx' , '_self' , '#000000' , 0 , 0 , 0 , 10 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [Content] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 15 , '后台管理' , '' , 'Admin_Index.aspx' , '_self' , '#000000' , 0 , 0 , 0 , 12 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 16 , '圈子' , 'Team.aspx' , '_self' , '#000000' , 0 , 0 , 0 , 11 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [Content] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 19 , '返回桌面' , '' , '/manage/DeskTop.aspx' , '_self' , '#000000' , 1 , 0 , 0 , 5 , 1 )
INSERT [WC_Forum_Menu] ( [ID] , [Title] , [Content] , [URL] , [Target] , [Color] , [Strong] , [Disappear] , [Login] , [Orders] , [Types] ) VALUES ( 20 , '论坛首页' , '' , 'index.aspx' , '_self' , '#ff0000' , 1 , 0 , 0 , 4 , 1 )
SET IDENTITY_INSERT [WC_Forum_Menu] OFF

INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010001' , 1 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000100010' , 1 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000100011' , 1 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000100012' , 1 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000100013' , 1 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000100014' , 1 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010002' , 1 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010003' , 1 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010004' , 1 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010005' , 1 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010006' , 1 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010007' , 1 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010008' , 1 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100010009' , 1 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020001' , 2 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000200010' , 2 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000200011' , 2 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000200012' , 2 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000200013' , 2 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000200014' , 2 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020002' , 2 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020003' , 2 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020004' , 2 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020005' , 2 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020006' , 2 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020007' , 2 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020008' , 2 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100020009' , 2 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030001' , 3 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000300010' , 3 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000300011' , 3 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000300012' , 3 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000300013' , 3 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000300014' , 3 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030002' , 3 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030003' , 3 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030004' , 3 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030005' , 3 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030006' , 3 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030007' , 3 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030008' , 3 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100030009' , 3 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040001' , 4 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000400010' , 4 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000400011' , 4 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000400012' , 4 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000400013' , 4 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000400014' , 4 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040002' , 4 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040003' , 4 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040004' , 4 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040005' , 4 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040006' , 4 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040007' , 4 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040008' , 4 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100040009' , 4 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050001' , 5 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000500010' , 5 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000500011' , 5 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000500012' , 5 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000500013' , 5 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000500014' , 5 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050002' , 5 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050003' , 5 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050004' , 5 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050005' , 5 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050006' , 5 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050007' , 5 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050008' , 5 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100050009' , 5 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060001' , 6 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000600010' , 6 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000600011' , 6 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000600012' , 6 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000600013' , 6 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000600014' , 6 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060002' , 6 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060003' , 6 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060004' , 6 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060005' , 6 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060006' , 6 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060007' , 6 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060008' , 6 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100060009' , 6 , 9 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070001' , 7 , 1 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000700010' , 7 , 10 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000700011' , 7 , 11 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000700012' , 7 , 12 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000700013' , 7 , 13 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '1000700014' , 7 , 14 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070002' , 7 , 2 , 1 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070003' , 7 , 3 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070004' , 7 , 4 , 2 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070005' , 7 , 5 , 3 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070006' , 7 , 6 , 4 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070007' , 7 , 7 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070008' , 7 , 8 , 5 , 0 , 1 )
INSERT [WC_Forum_Permision] ( [Keys] , [BoardID] , [ItemID] , [Types] , [PowerType] , [PermisionType] ) VALUES ( '100070009' , 7 , 9 , 5 , 0 , 1 )

SET IDENTITY_INSERT [WC_Forum_Skin] ON
INSERT [WC_Forum_Skin] ( [ID] , [TemplateID] , [SkinName] , [FilePath] , [AddTime] ) VALUES ( 1 , 1 , '默认皮肤' , 'template/default/skins/default' , '2010-11-09 15:57:54.500' )
SET IDENTITY_INSERT [WC_Forum_Skin] OFF

INSERT [WC_Forum_Status] ( [TotalTopic] , [TotalReply] , [TotalMale] , [TotalFemale] , [NewUser] , [ActiveTime] ) VALUES ( 0 , 0 , 1 , 0 , 'admin' , '2011-01-04 20:45:29.000' )

SET IDENTITY_INSERT [WC_Forum_Table] ON
INSERT [WC_Forum_Table] ( [ID] , [Orders] , [Counts] ) VALUES ( 1 , 1 , 2 )
SET IDENTITY_INSERT [WC_Forum_Table] OFF

SET IDENTITY_INSERT [WC_Forum_Template] ON
INSERT [WC_Forum_Template] ( [ID] , [TemplateName] , [FilePath] , [AddTime] ) VALUES ( 1 , '默认模板' , 'template/default' , '2010-11-09 15:57:54.500' )
SET IDENTITY_INSERT [WC_Forum_Template] OFF

SET IDENTITY_INSERT [WC_Forum_User] ON
INSERT [WC_Forum_User] ( [ID] , [UserName] , [UserPass] , [PasswordType] , [Question] , [Answer] , [Email] , [Sex] , [Photo] , [PhotoWidth] , [PhotoHeight] , [NickName] , [Sign] , [LevelID] , [LevelType] , [TeamID] , [Coin] , [Point] , [Topic] , [Reply] , [TopicDel] , [ReplyDel] , [GoodTopic] , [IP] , [UploadNum] , [UploadTime] , [LoginTime] , [LoginIP] , [Message] , [State] , [RegTime] ) VALUES ( 1 , 'manager' , '7a57a5a743894a0e' , 1 , '我是谁' , '8f2dbcd159ec7202' , '' , 1 , 'userface/11.jpg' , 88 , 110 , '管理员' , '' , 1 , 1 , 0 , 1 , 3 , 1 , 1 , 1 , 1 , 0 , '127.0.0.1' , 0 , '2011-01-06 11:53:16.000' , '2011-01-06 11:55:45.000' , '192.168.1.100' , '' , 0 , '2010-11-09 15:57:54.513' )
SET IDENTITY_INSERT [WC_Forum_User] OFF

SET IDENTITY_INSERT [WC_Forum_UserDetail] ON
INSERT [WC_Forum_UserDetail] ( [ID] , [UserID] , [RealName] , [QQ] , [ICQ] , [MSN] , [Address] , [Mobile] , [Phone] , [Birthday] , [Star] , [Blood] , [Marry] , [Study] , [School] , [Introduce] ) VALUES ( 1 , 1 , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' )
SET IDENTITY_INSERT [WC_Forum_UserDetail] OFF


 INSERT [WM_Roles] ( [Key] , [Name] ) VALUES ( 1 , '管理员' )
 INSERT [WM_Roles] ( [Key] , [Name] ) VALUES ( 2 , '普通用户' )


 SET IDENTITY_INSERT [WM_UDD] ON

 INSERT [WM_UDD] ( [duid] , [did] , [uid] , [tid] ) VALUES ( 1 , 16 , 4 , 0 )
 INSERT [WM_UDD] ( [duid] , [did] , [uid] , [tid] ) VALUES ( 2 , 16 , 5 , 0 )
 INSERT [WM_UDD] ( [duid] , [did] , [uid] , [tid] ) VALUES ( 3 , 25 , 6 , 0 )
 INSERT [WM_UDD] ( [duid] , [did] , [uid] , [tid] ) VALUES ( 4 , 16 , 7 , 0 )
 INSERT [WM_UDD] ( [duid] , [did] , [uid] , [tid] ) VALUES ( 5 , 1 , 3 , 0 )

 SET IDENTITY_INSERT [WM_UDD] OFF


 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 1 , 1 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 1 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 2 , 1 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 2 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 3 , 1 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 3 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 4 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 5 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 6 , 2 )
 INSERT [WM_User_Role] ([UserKey] , [RoleKey] ) VALUES ( 7 , 2 )


 SET IDENTITY_INSERT [WM_UserRelationship] ON

 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 3 , 4 , 0 , '2010-04-05 13:27:34.857' , 1 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 4 , 3 , 0 , '2010-04-05 13:27:34.857' , 2 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 3 , 5 , 0 , '2010-04-05 13:27:35.060' , 3 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 5 , 3 , 0 , '2010-04-05 13:27:35.060' , 4 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 3 , 6 , 0 , '2010-04-05 13:27:35.077' , 5 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 6 , 3 , 0 , '2010-04-05 13:27:35.077' , 6 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 3 , 7 , 0 , '2010-04-05 13:27:35.093' , 7 )
 INSERT [WM_UserRelationship] ( [HostKey] , [GuestKey] , [Relationship] , [RenewTime] , [Key] ) VALUES ( 7 , 3 , 0 , '2010-04-05 13:27:35.093' , 8 )

 SET IDENTITY_INSERT [WM_UserRelationship] OFF


 SET IDENTITY_INSERT [WM_Users] ON

 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 1 , 'sa' , 'IM系统调度1' , 0 , '123' , 'name@host.com' , 'SA' , 2048 , 200 , 1 , 0 , 200 , '2010-01-31 11:05:30.950' , '' , '' , '' , '' , '' , 1 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 2 , 'administrator' , 'IM系统调度2' , 0 , '' , 'name@host.com' , 'ADMINISTRATOR' , 2048 , 200 , 1 , 0 , 200 , '2010-01-31 11:05:30.950' , '' , '' , '' , '' , '' , 1 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 3 , 'manager' , '管理员' , 0 , 'e10adc3949ba59abbe56e057f20f883e' , 'name@host.com' , 'MANAGER' , 2048 , 200 , 1 , 0 , 200 , '2010-03-17 17:11:01.310' , '' , '' , '' , '' , '' , 1 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [InviteCode] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 4 , 'lilin' , '李林' , 0 , 'cfcd208495d565ef66e7dff9f98764da' , '' , 'EE1B4A9D2975472F85C2E0379B6D2427' , 'LILIN' , 2048 , 200 , 1 , 0 , 200 , '2010-04-05 13:27:34.857' , '' , '' , '' , '' , '' , 0 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [InviteCode] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 5 , 'yanglei' , '杨磊' , 0 , 'cfcd208495d565ef66e7dff9f98764da' , '' , '9BCF20C9A9C842ADA6D24B8E47B427BD' , 'YANGLEI' , 2048 , 200 , 1 , 0 , 200 , '2010-04-05 13:27:35.060' , '' , '' , '' , '' , '' , 0 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [InviteCode] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 6 , 'maojie' , '毛杰' , 0 , 'cfcd208495d565ef66e7dff9f98764da' , '' , '1DB199B1A02340F2A93BFD3035072FAD' , 'MAOJIE' , 2048 , 200 , 1 , 0 , 200 , '2010-04-05 13:27:35.077' , '' , '' , '' , '' , '' , 0 , '' )
 INSERT [WM_Users] ( [Key] , [Name] , [Nickname] , [Type] , [Password] , [EMail] , [InviteCode] , [UpperName] , [MsgFileLimit] , [MsgImageLimit] , [AcceptStrangerIM] , [IsTemp] , [DiskSize] , [RegisterTime] , [HomePage] , [HeadIMG] , [Phone] , [TelPhone] , [MobilePhone] , [isExitGroup] , [Remark] ) VALUES ( 7 , 'zhoutao' , '周涛' , 0 , 'cfcd208495d565ef66e7dff9f98764da' , '' , '6C19996B2F8949A5A666549BDF67C28D' , 'ZHOUTAO' , 2048 , 200 , 1 , 0 , 200 , '2010-04-05 13:27:35.093' , '' , '' , '' , '' , '' , 0 , '' )

 SET IDENTITY_INSERT [WM_Users] OFF


 SET IDENTITY_INSERT [Work_AttendSet] ON

 INSERT [Work_AttendSet] ( [id] , [guid] , [AttendTimes] , [AttendNames] , [WorkKind] ) VALUES ( 1 , '6247ba83094e459d895d57b65571e840' , '8:05' , '上班登记' , 0 )
 INSERT [Work_AttendSet] ( [id] , [guid] , [AttendTimes] , [AttendNames] , [WorkKind] ) VALUES ( 2 , 'aaa32f64ffa34ebab6a13f626265fea0' , '12:00' , '下班登记' , 0 )
 INSERT [Work_AttendSet] ( [id] , [guid] , [AttendTimes] , [AttendNames] , [WorkKind] ) VALUES ( 3 , 'f565aa5c5566409397f28e17711845e4' , '14:00' , '上班登记' , 0 )
 INSERT [Work_AttendSet] ( [id] , [guid] , [AttendTimes] , [AttendNames] , [WorkKind] ) VALUES ( 4 , '9aca4f9869e74d179b2025cb9e23f596' , '18:00' , '下班登记' , 0 )

 SET IDENTITY_INSERT [Work_AttendSet] OFF

  SET IDENTITY_INSERT [Tasks_Type] ON
  INSERT [Tasks_Type] ( [id] , [guid] , [TypeName] , [Notes] , [Orders] , [ParentID] ) VALUES ( 1 , '12bade23cade47cb2a70e3c5a715a234' , '默认分类' , '' , 0 , 0 )
 SET IDENTITY_INSERT [Tasks_Type] OFF

  SET IDENTITY_INSERT [PaperType] ON
INSERT [PaperType] ( [id] , [guid] , [TypeName] , [Notes] , [Orders] , [ParentID] ) VALUES ( 1 , 'a0b077b7cc7543a09f59c68a919c00af' , '默认类别' , '' , 0 , 0 )
SET IDENTITY_INSERT [PaperType] OFF

