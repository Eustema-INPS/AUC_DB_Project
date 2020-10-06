﻿
CREATE FUNCTION [dbo].[fn_dataFineDma] (@idva int) 
RETURNS varchar(6)
AS

BEGIN
	DECLARE @DATA  VARCHAR(6)

	SET @DATA = NULL

	SELECT @DATA = SUBSTRING(REPLACE(CONVERT(CHAR, P.ANPID_DATA_FINE, 105),'-',''),3,6) 
      FROM TB_ANPID_PERINVIODMA_CL P WITH (NOLOCK) 
     WHERE P.ANPID_BDSO_ID_VA = @IDVA
       AND P.ANPID_FLAG_VALIDO = 'S'
       AND P.ANPID_DATA_INIZ IN (SELECT MAX(A.ANPID_DATA_INIZ) 
                                   FROM TB_ANPID_PERINVIODMA_CL A WITH (NOLOCK)
                                  WHERE A.ANPID_BDSO_ID_VA = P.ANPID_BDSO_ID_VA 
				   			        AND A.ANPID_FLAG_VALIDO = 'S')

    return @DATA

END


