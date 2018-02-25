CREATE PROCEDURE [dbo].[WM_Validate]

@name nvarchar(256), @password nvarchar(256)

AS
begin

	select * from WM_Users where UpperName=upper(@name) and Password=@password AND [Type]=0

SET NOCOUNT ON;
end