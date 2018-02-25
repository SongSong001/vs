CREATE PROCEDURE [dbo].[WM_FindHistoryB]

      @peerType INT ,
      @content NVARCHAR(400) ,
      @user NVARCHAR(100) ,
      @from NVARCHAR(30) ,
      @to NVARCHAR(30)

AS
begin

        DECLARE @strFilter NVARCHAR(2000)
        DECLARE @strSql VARCHAR(8000)
        SET @strFilter = ''
        IF @peerType = 0 
            BEGIN
                SET @strFilter = ' and m.CreatedTime >= ''' + @from
                    + ''' and m.CreatedTime <= ''' + @to
                    + ''' and m.Content like ''%' + @content + '%'' '
            END
        IF @peerType = 1 
            BEGIN
                SET @strFilter = ' and m.CreatedTime >= ''' + @from
                    + ''' and m.CreatedTime <= ''' + @to
                    + ''' and u.type=0 and u2.type=0  and m.Content like ''%'
                    + @content + '%'' '
            END
        IF @peerType = 2 
            BEGIN
                SET @strFilter = ' and m.CreatedTime >= ''' + @from
                    + ''' and m.CreatedTime <= ''' + @to
                    + ''' and u.type=0 and u2.type=0 and m.Receiver in	(select guest.key
	                from WM_UserRelationship r, WM_Users  host,WM_Users  guest where 
					r.HostKey=host.[Key] and r.GuestKey=guest.[Key] and
					host.UpperName=upper(''' + @user + ''') )  
					and m.Sender in	(select guest.key
	                from WM_UserRelationship r, WM_Users  host,WM_Users  guest where 
					r.HostKey=host.[Key] and r.GuestKey=guest.[Key] and
					host.UpperName=upper(''' + @user + ''') )  
					and m.Content like ''%'	 + @content + '%'''
            END
       IF @peerType = 3 
        BEGIN
            SET @strFilter = ' and m.CreatedTime >= ''' + @from
                + ''' and m.CreatedTime <= ''' + @to
                + ''' and u.type=1 and u2.type=1  and m.Content like ''%'
                + @content + '%'' '
        END 
       IF @peerType = 4 
        BEGIN
            SET @strFilter = ' and m.CreatedTime >= ''' + @from
                + ''' and m.CreatedTime <= ''' + @to
                + ''' and u.type=2 and u2.type=2  and m.Content like ''%'
                + @content + '%'' '
        END 
        SET @strSql='
        SELECT TOP 30
                temp.[Key] ,
                temp.Receiver ,
                temp.Sender ,
                temp.Content ,
                temp.CreatedTime
        FROM    ( SELECT    m.[Key] ,
                            m.Receiver ,
                            m.Sender ,
                            m.Content ,
                            m.CreatedTime
                  FROM      WM_Message m
                            LEFT JOIN WM_Users u ON m.Receiver = u.[Key]
                            LEFT JOIN dbo.WM_Users u2 ON m.Sender = u2.[Key]
                            where 1=1 
                            '+@strFilter+'
                ) temp
        ORDER BY CreatedTime DESC'
        PRINT @strSql
        EXEC(@strSql)

SET NOCOUNT ON;
end