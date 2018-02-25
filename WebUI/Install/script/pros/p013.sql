CREATE PROCEDURE [dbo].[WM_GetAccountInfoByName]

@name nvarchar(256)

AS
begin

select * from WM_Users where UpperName = UPPER(@name)

SET NOCOUNT ON;
end