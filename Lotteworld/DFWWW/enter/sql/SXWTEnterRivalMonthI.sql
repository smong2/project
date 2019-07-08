SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTEnterRivalMonthI
	업  무  명 : 수요예측
	프로그램명 : 입장객 경쟁사- 등록 -월입력
	최초작성일 : 2002/11/14
	최종작성일 : 2002/11/14
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE PROCEDURE dbo.SXWTEnterRivalMonthI
	@vcInput_year varchar(12)
	,@vcInput_month varchar(5)
	,@intIndivadultever int
	,@intIndivadultseoul int
	,@intGroupadultever int
	,@intGroupadultseoul int
	,@intIndivschoolever int
	,@intIndivschoolseoul int
	,@intGroupschoolever int
	,@intGroupschoolseoul int
	,@intIndivchildever int
	,@intIndivchildseoul int
	,@intGroupchildever int
	,@intGroupchildseoul int

AS
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnteRivalMonthI:'	-- 오류 내용 초기화

BEGIN

DELETE FROM dbo.txtrivalenter 
WHERE year=@vcInput_year and month=@vcInput_month   --삭제한다
 
--입력 들어감
INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'A',@intIndivadultever,@intGroupadultever,@intIndivadultseoul,@intGroupadultseoul)  --어른 입력

INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'C',@intIndivchildever,@intGroupchildever,@intIndivchildseoul,@intGroupchildseoul)  --어린이 입력

INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'S',@intIndivschoolever,@intGroupschoolever,@intIndivschoolseoul,@intGroupschoolseoul)  --중고생 입력

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

