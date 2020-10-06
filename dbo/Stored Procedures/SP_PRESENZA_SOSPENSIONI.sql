


-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.10.19
-- Description:	AI 2066 Restituisce S o N in base alla presenza o meno delle sopsensioni nel periodo di riferimento
-- =============================================
CREATE PROCEDURE [dbo].[SP_PRESENZA_SOSPENSIONI]
	@aupoc_codice_pk varchar(50), 
	@data_dal datetime,
	@data_al datetime
AS
BEGIN

	  SELECT  	 Presenza_Sospensioni=dbo.fn_torna_PresenzaSosp(@data_dal,@data_al,@aupoc_codice_pk)
   	   
      
  END

