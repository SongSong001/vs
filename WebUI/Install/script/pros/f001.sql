CREATE FUNCTION [dbo].[FUN_GetChildList] (
  @Table Nvarchar(100),
  @Value Nvarchar(100)
) 

 RETURNS @tResult TABLE (
  -- 定义结果表
  RESULT Nvarchar(100) 
)

AS
BEGIN
  -- 子类型表、父类型表、子类型数
  DECLARE @tChild TABLE(RESULT Nvarchar(100))
  DECLARE @tFather TABLE(RESULT Nvarchar(100))
  DECLARE @Count SmallInt
 
  --  预先置传入的值到@tFather中
  INSERT INTO @tFather
  VALUES (@Value)
  
  WHILE 1 = 1
  BEGIN
--  循环中，先将@tFather中内容放到@tResult中；
    INSERT INTO @tResult SELECT RESULT FROM @tFather
  
--   将@tChild清空，再取@tFather的所有子类型到@tChild中；
    DELETE FROM @tChild 

--   根据不同的表追加写到IF内部的语句 
--------------------------------------------------------------------------------------- 
    IF @Table ='Sys_Dep'
    BEGIN
      INSERT INTO @tChild
      SELECT RESULT = id  
      FROM Sys_Dep
      WHERE ParentID IN (SELECT RESULT FROM @tFather)
    END
---------------------------------------------------------------------------------------
--   当@tChild空时，退出；
      SELECT @Count = COUNT(*) FROM @tChild
      IF @Count = 0
      BREAK
  
--   将@tFather清空，并将@tChild中内容给@tFather。
      DELETE FROM @tFather 
      INSERT INTO @tFather SELECT RESULT FROM @tChild       
  END
  RETURN 
END