SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	프로그램ID : SXWTEnterDayInputI
	업  무  명 : 수요예측
	프로그램명 : 입장객 매표 - 등록 -일입력
	최초작성일 : 2002/11/14
	최종작성일 : 2002/11/14
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterDayInputI
	@vcModelType varchar(10)
	,@dtXdate datetime 
	,@intTotal_a int
	,@intIndiv_a int
	,@intGroup_a int
	,@intSpecial_a int
	,@intFree_a int
	,@intEducinst_a int
	,@intDutyfree_a int
	,@intCompany_a int
	,@intMycustomer_a int
	,@intEtc_a int

	,@intTotal_s int=0
	,@intIndiv_s int=0
	,@intGroup_s int=0
	,@intSpecial_s int=0
	,@intFree_s int=0
	,@intEducinst_s int=0
	,@intDutyfree_s int=0
	,@intCompany_s int=0
	,@intMycustomer_s int=0
	,@intEtc_s int=0

	,@intTotal_c int=0
	,@intIndiv_c int=0
	,@intGroup_c int=0
	,@intSpecial_c int=0
	,@intFree_c int=0
	,@intEducinst_c int=0
	,@intDutyfree_c int=0
	,@intCompany_c int=0
	,@intMycustomer_c int=0
	,@intEtc_c int=0
AS
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnteDayInputI:'	-- 오류 내용 초기화

BEGIN

IF @vcModelType='vxt' -- 매표입장일 경우
	BEGIN

		DELETE FROM dbo.txtenter  --삭제한다
		WHERE xdate=@dtXdate

		--입력 들어감
		INSERT INTO dbo.txtenter   --어른 입력
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'A',@intTotal_a,@intIndiv_a,@intGroup_a,@intSpecial_a,@intFree_a,@intEducinst_a,@intDutyfree_a,@intCompany_a,@intMycustomer_a,@intEtc_a)

		INSERT INTO dbo.txtenter   --학생 입력
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'S',@intTotal_s,@intIndiv_s,@intGroup_s,@intSpecial_s,@intFree_s,@intEducinst_s,@intDutyfree_s,@intCompany_s,@intMycustomer_s,@intEtc_s)

		INSERT INTO dbo.txtenter   --어린이 입력
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'C',@intTotal_c,@intIndiv_c,@intGroup_c,@intSpecial_c,@intFree_c,@intEducinst_c,@intDutyfree_c,@intCompany_c,@intMycustomer_c,@intEtc_c)
	END
IF @vcModelType='vxte' --실입장일경우
	BEGIN

		DELETE FROM dbo.txteenter  --삭제한다
		WHERE xdate=@dtXdate

		--입력 들어감
		INSERT INTO dbo.txteenter   --어른 입력
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'T',@intTotal_a,@intIndiv_a,@intGroup_a,@intSpecial_a,@intFree_a,@intEducinst_a,@intDutyfree_a,@intCompany_a,@intMycustomer_a,@intEtc_a)
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

