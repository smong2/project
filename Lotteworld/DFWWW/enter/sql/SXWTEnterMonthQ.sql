SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	프로그램ID : SXWTEnterMonthQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 예측- 표출 (월예측 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterMonthQ
    @vcModelType varchar(10)  	 --매표 입장 / 실입장 구분
    ,@vcEnterType varchar(10)	 --개인,단체,전체 구분
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterMonthQ:'	-- 오류 내용 초기화

IF @vcModelType='vxt' and @vcEnterType='group' --매표, 단체
BEGIN
	SELECT  year, -- 예측치 가져오기 3달
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxtmonth 
              WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT grouptotal, -- 과거치 가져오기 3달
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(grouptotal) as grouptotal,  --예측치 합계
              sum(groupadult) as groupadult, 
              sum(groupschool) as groupschool,
	sum(groupchild) as groupchild  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(grouptotal) as grouptotal,  --과거치 합계
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild  
	FROM vxthistorymonth 
	WHERE year=year(getdate())-1
END

IF @vcModelType='vxt' and  @vcEnterType='indiv'  --매표, 개인
 BEGIN
	SELECT year,  --예측치 가져오기 3달
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild  
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal,  --과거치 가져오기 3달
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal) as indivtotal,  --예측치 합계
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal) as indivtotal,  --과거치 합계
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild   
	FROM dbo.vxthistorymonth 
	WHERE year=year(getdate())-1
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --매표, 전체
 BEGIN 
	SELECT year, --예측치 가져오기 3달
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal+grouptotal as total,  --과거치 가져오기 3달
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --예측치 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child   
	FROM dbo.vxthistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --실, 단체
 BEGIN

	SELECT year, --예측치 가져오기 3달
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT grouptotal,  --과거치 가져오기 3달
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(grouptotal) as grouptotal,  -- 예측치 합계
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(grouptotal) as grouptotal,  --과거치 합계
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild 
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --실,개인
 BEGIN
	SELECT year,   --예측치 가져오기 3달
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal,  --과거치 가져오기 3달
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal) as indivtotal,  --예측치 합계
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal) as indivtotal,  --과거치 합계
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --실,전체
 BEGIN 
	SELECT year,  --예측치 가져오기 3달
	month,
	indivtotal+grouptotal as total,
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtemonth 	
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal+grouptotal as total, --과거치 가져오기 3달
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --예측치 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total,  --과거치 합계
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child   
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
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

