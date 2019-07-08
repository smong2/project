<%
Dim intCurPage  '현재 페이지
Dim intPage   '임시 저장 페이지
Dim intLastPage '지난 페이지
Dim intLimit '페이지 수 제한
Dim IntStartPage '시작 페이지
Dim dtToday '오늘날짜
Dim intPos '페이지 위치
Dim intTotalPage '총 페이지

function FnDateFormat(df) '행사기간 날짜 표시 형식 (00/00/00)
df=cstr(df)
df=replace(df,"-","/")
df=right(df,8)
FnDateFormat=df
end function

dtToday=date()
function FnDateInter(di,di2)  'today, month 결정함수
IF dtToday >= di and dtToday <= di2 THEN '행사 기간에 오늘이 포함될 경우
 FnDateInter =1
ELSEIF not(dtToday>= di and dtToday<=di2) THEN '포함되지는 않지만 이번 월에 포함될 경우
 IF year(dtToday)=year(di) and month(dtToday)=month(di) or year(dtToday)=year(di2) and month(dtToday)=month(di2) THEN
  FnDateInter= 2
 END IF
ELSE
FnDateInter=3
END IF
end function

IF intPAGE="" THEN '페이지 목록 (게시판 형식) 을 위한 코딩
intCurPAGE=1
ELSE
intCurPAGE=intPAGE
END IF
rs.PAGESize = 5 '한 페이지에 뿌려줄 목록 수
intTotalPage=rs.PAGESize 
intLastPage=rs.PAGEcount
IF not rs.EOF THEN
rs.AbsolutePage = intCurPage
END IF

intLimit=10 ' 이전 - 다음 사이에 들어갈 페이지 수
intPos=(intCurPage-1) mod intLimit
intStartPage=intCurPage-intPos 
%>