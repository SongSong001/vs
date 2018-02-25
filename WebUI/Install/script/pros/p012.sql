CREATE PROCEDURE [dbo].[WM_GetAccountInfoByID]

@id int

AS
begin

	select * from WM_Users where [Key] = @id

SET NOCOUNT ON;
end