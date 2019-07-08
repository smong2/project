SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	프로그램ID : SXWTEnterMonthExcelQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 월 예측 - 엑셀 표출
	최초작성일 : 2002/11/12
	최종작성일 : 2002/11/12
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterMonthExcelQ
@vcModelType varchar(10)
,@vcEnterType varchar(10)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterMonthExcelQ:'	-- 오류 내용 초기화


IF @vcModelType='vxt' and @vcEnterType='group' --매표, 단체
BEGIN
	SELECT year,   --예측치 가져오기
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --과거치 가져오기
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxthistorymonth 
	WHERE 	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))
END

IF @vcModelType='vxt' and @vcEnterType='indiv' --매표, 개인
BEGIN

	SELECT year,   --예측치 가져오기
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --과거치 가져오기
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxthistorymonth 
	WHERE(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))
END

IF @vcModelType='vxt' and @vcEnterType='total' --매표, 개인
BEGIN
	SELECT year,  --예측치 가져오기
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year,  --과거치 가져오기
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))
END

IF @vcModelType='vxte' and @vcEnterType='group' --매표, 단체
BEGIN

	SELECT year,   --예측치 가져오기
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --과거치 가져오기
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))

END
IF @vcModelType='vxte' and @vcEnterType='indiv' --매표, 개인
BEGIN
	SELECT year,   --예측치 가져오기
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --과거치 가져오기
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))

END
IF @vcModelType='vxte' and @vcEnterType='total' --매표, 개인
BEGIN

	SELECT year,  --예측치 가져오기
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm,  -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year,  --과거치 가져오기
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or
	(year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate())))
END

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패'
--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

