CREATE PROCEDURE [dbo].[DXBBS_CommonProc]
@TableName varchar(50),
@Condition nvarchar(500),
@Fields varchar(500),
@CurrentPage int,
@PageSize int,
@OrderField varchar(100),
@OrderType varchar(4)
AS
 set nocount on
 declare @SQL nvarchar(2000)
 if @OrderType = 'Desc'
 begin
	if @Condition = 'None'
	begin
		if @CurrentPage = 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' order by ' + @OrderField + ' desc'
		end
		if @CurrentPage > 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' where ' + @OrderField + '<(select min(' + @OrderField + ') from (select top ' + Cast(@PageSize*(@CurrentPage-1) as varchar) + ' ' + @OrderField + ' from ' + @TableName + ' order by ' + @OrderField + ' desc) temp) order by ' + @OrderField + ' desc'
		end
	end
	else
	begin
		if @CurrentPage = 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' ' + @Condition + ' order by ' + @OrderField + ' desc'
		end
		if @CurrentPage > 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' ' + @Condition + ' and ' + @OrderField + '<(select min(' + @OrderField + ') from (select top ' + Cast(@PageSize*(@CurrentPage-1) as varchar) + ' ' + @OrderField + ' from ' + @TableName + ' ' + @Condition + ' order by ' + @OrderField + ' desc) temp) order by ' + @OrderField + ' desc'
		end
	end
 end
 else
 begin
	if @Condition = 'None'
	begin
		if @CurrentPage = 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' order by ' + @OrderField  + ' asc'
		end
		if @CurrentPage > 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' where ' + @OrderField + ' > (select max(' + @OrderField + ') from (select top ' + Cast(@PageSize*(@CurrentPage-1) as varchar) + ' ' + @OrderField + ' from ' + @TableName + ' order by ' + @OrderField + ' asc) temp) order by ' + @OrderField + ' asc'
		end
	end
  	else
	begin
		if @CurrentPage = 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' ' + @Condition + ' order by ' + @OrderField + ' asc'
		end
		if @CurrentPage > 1
		begin
			set @SQL = 'select top ' + Cast(@PageSize as varchar) + ' ' + @Fields + ' from ' + @TableName + ' ' + @Condition + ' and ' + @OrderField + ' > (select max(' + @OrderField + ') from (select top ' + Cast(@PageSize*(@CurrentPage-1) as varchar) + ' ' + @OrderField + ' from ' + @TableName + ' ' + @Condition + ' order by ' + @OrderField + ' asc] temp) order by ' + @OrderField + ' asc'
		end
	end
end
exec sp_executesql @SQL