CREATE function   [dbo].[f_GetPy](@str   nvarchar(4000))
returns   nvarchar(4000)
as
begin
declare   @strlen   int,@re   nvarchar(4000)
declare   @t   table(chr   nchar(1)   collate   Chinese_PRC_CI_AS,letter   nchar(1))
insert   into   @t(chr,letter)
    select   '吖 ', 'A '   union   all   select   '八 ', 'B '   union   all
    select   '嚓 ', 'C '   union   all   select   '咑 ', 'D '   union   all
    select   '妸 ', 'E '   union   all   select   '发 ', 'F '   union   all
    select   '旮 ', 'G '   union   all   select   '铪 ', 'H '   union   all
    select   '丌 ', 'J '   union   all   select   '咔 ', 'K '   union   all
    select   '垃 ', 'L '   union   all   select   '嘸 ', 'M '   union   all
    select   '拏 ', 'N '   union   all   select   '噢 ', 'O '   union   all
    select   '妑 ', 'P '   union   all   select   '七 ', 'Q '   union   all
    select   '呥 ', 'R '   union   all   select   '仨 ', 'S '   union   all
    select   '他 ', 'T '   union   all   select   '屲 ', 'W '   union   all
    select   '夕 ', 'X '   union   all   select   '丫 ', 'Y '   union   all
    select   '帀 ', 'Z '
    select   @strlen=len(@str),@re= ' '
    while   @strlen> 0
    begin
        select   top   1   @re=letter+@re,@strlen=@strlen-1
            from   @t   a   where   chr <=substring(@str,@strlen,1)
            order   by   chr   desc
        if   @@rowcount=0
            select   @re=substring(@str,@strlen,1)+@re,@strlen=@strlen-1
    end
    return(@re)
end 