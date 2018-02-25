CREATE PROCEDURE [dbo].[WM_GetAllUsersByName]

@Name NVARCHAR(200)

AS
begin

   DECLARE @Sql NVARCHAR(4000)
   DECLARE @Filter NVARCHAR(2000)
   SET @Filter=''
   IF @Name<>''
   BEGIN
      SET @Filter=' AND (u.Name LIKE ''%'+@Name+'%'' OR  u.Nickname LIKE ''%'+@Name+'%'' OR   dbo.f_GetPy(u.Nickname) LIKE ''%'+@Name+'%'')'
   END
   SET @Sql='  
	select u.[Key], u.Name, u.Nickname, u.EMail, u.RegisterTime 
	from WM_Users u 
	where u.Type = 0
	'+@Filter+'
	order by u.RegisterTime desc'
	EXEC(@Sql)

SET NOCOUNT ON;
end