-- =============================================
-- Author:		Peter
-- Action Item: 2046
-- Create date: 
-- Description:	lettura della tabella tb_aungi_nat_giur_ct   qualificando:
--				aungi_codice_forma = codice_natura_giuridica 
-- =============================================
create PROCEDURE [dbo].[SP_FINDNATGIUR_PER_CODICE] 
	@codice_natura_giuridica varchar(2)
AS
BEGIN
	SET NOCOUNT ON;
   
	SELECT 
	   [aungi_codice_pk]
      ,[aungi_codice_forma]
      ,[aungi_descr_lunga]
      ,[aungi_data_modifica]
      ,[aungi_descr_utente]
      
  FROM  [dbo].[tb_aungi_nat_giur_ct]
  
  WHERE	ltrim(rtrim(isnull(aungi_codice_forma,''))) = ltrim(rtrim(@codice_natura_giuridica))
END
