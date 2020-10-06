-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della tabella tb_aungi_nat_giur_ct   qualificando:
--				aungi_descr_breve = natura_giuridica 
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDNATGIUR] 
	@natura_giuridica varchar(100)
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
  
  WHERE	ltrim(rtrim(isnull(aungi_descr_lunga,''))) = ltrim(rtrim(@natura_giuridica))
END
