SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	프로그램ID : SXWTEnterDayQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 예측- 표출 (일예측 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterDayQ
    @vcModelType varchar(10)  	 --매표 입장 / 실입장 구분
    ,@vcEnterType varchar(10)	 --개인,단체,전체 구분
    ,@vcLastdate datetime
    ,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterDayQ:'	-- 오류 내용 초기화

IF @vcModelType='vxt' and @vcEnterType='group' --매표, 단체
BEGIN
	SELECT orgadult+orgschool+orgchild as orgtotal   --예측치 가져오기
	,orgadult
	,orgschool
	,orgchild
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT grouptotal,   -- 과거치 전년 동일 가져오기 3일
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2 

	SELECT grouptotal,  --과거치 전년 동요일 가져오기 3일
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate and xdate<=@vcLastweekdate+2

	SELECT sum(orgadult+orgschool+orgchild) as orgtotal,  --예측치 합계
	sum(orgadult) as orgadult,  
	sum(orgschool) as orgschool,
	sum(orgchild) as orgchild  
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(grouptotal) as grouptotal,  --과거치 전년 동일 합계
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate
	
	SELECT sum(grouptotal) as grouptotal,  --과거치 전년 동요일 합계
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
END
IF @vcModelType='vxt' and  @vcEnterType='indiv'  --매표, 개인
 BEGIN
	SELECT indivadult
	,indivschool
	,indivchild
	,indivadult+indivschool+indivchild as indivtotal   --예측치 가져오기
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal,   -- 과거치 전년 동일 가져오기 3일치
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal,  --과거치 전년 동요일 가져오기 3일치
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild) as indivtotal,
	sum(indivadult) as indivadult,  --예측치 합계
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal) as total, --과거치 전년 동일 합계
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal) as total,  -- 과거치 전년 동요일 합계
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --매표, 전체
 BEGIN 
	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --예측치 가져오기 
	indivadult+isnull(orgadult,0) as adult, 
	indivschool+isnull(orgschool,0) as school, 
	indivchild+isnull(orgchild,0) as child    
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal+grouptotal as total,  --과거치 전년 동일 가져오기 3일치
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal+grouptotal as total,  --과거치 전년 동요일 가져오기 3일치
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0)) as total, --예측치 합계 가져오기 
	sum(indivadult+isnull(orgadult,0)) as adult, 
	sum(indivschool+isnull(orgschool,0)) as school, 
	sum(indivchild+isnull(orgchild,0)) as child    
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 전년 동일 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 전년 동요일 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --실, 단체
 BEGIN
	SELECT orgadult+orgschool+orgchild as orgtotal   --예측치 가져오기
	,orgadult
	,orgschool
	,orgchild
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT grouptotal,   -- 과거치 전년 동일 가져오기 3일
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2 

	SELECT grouptotal,  --과거치 전년 동요일 가져오기 3일
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate and xdate<=@vcLastweekdate+2

	SELECT sum(orgadult+orgschool+orgchild) as orgtotal,
	sum(orgadult) as orgadult,  --예측치 합계
	sum(orgschool) as orgschool,
	sum(orgchild) as orgchild  
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(grouptotal) as grouptotal,  --과거치 전년 동일 합계
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate
	
	SELECT sum(grouptotal) as grouptotal,  --과거치 전년 동요일 합계
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate 
END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --실,개인
 BEGIN
	SELECT indivadult+indivschool+indivchild as indivtotal  --예측치 가져오기
	,indivadult
	,indivschool
	,indivchild
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal,   -- 과거치 전년 동일 가져오기 3일치
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal,  --과거치 전년 동요일 가져오기 3일치
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild) as indivtotal,
	sum(indivadult) as indivadult,  --예측치 합계
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal) as total, --과거치 전년 동일 합계
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal) as total,  -- 과거치 전년 동요일 합계
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate 
END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --실,전체
 BEGIN 
	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --예측치 가져오기 
	indivadult+isnull(orgadult,0) as adult, 
	indivschool+isnull(orgschool,0) as school, 
	indivchild+isnull(orgchild,0) as child    
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal+grouptotal as total,  --과거치 전년 동일 가져오기 3일치
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal+grouptotal as total,  --과거치 전년 동요일 가져오기 3일치
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0)) as total, --예측치 합계 가져오기 
	sum(indivadult+isnull(orgadult,0)) as adult, 
	sum(indivschool+isnull(orgschool,0)) as school, 
	sum(indivchild+isnull(orgchild,0)) as child    
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 전년 동일 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 전년 동요일 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxethistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
 END


	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패' + '모델명 : ' + @vcModelType + '구분명:' + @vcEnterType
--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  

END 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

