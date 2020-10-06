


-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2019.06.12
-- Description:	Fornisce l'indicazione se lo stato del Soggetto Contribuente sia certificato da Infocamere
-- Se il cf non viene fornito ritorna -1
-- Se il cf non esiste ritorna -2
-- Se il cf è certificato da Infocamere ritorna 1
-- Se il cf non è certificato da Infocamere ritorna 2
-- =============================================
CREATE PROCEDURE  [dbo].[EX_CertificatoInfocamere]
	@cf varchar(16)	

AS

BEGIN
	SET NOCOUNT ON;

	declare @cert char

    if @cf is null
	   return -1 --il cf non è stato fornito

IF ( EXISTS
	 (Select ausca_codice_pk FROM  tb_ausca_sog_contr_az
	  where ausca_codice_fiscale = @cf) 
	 ) 
	 begin
		set @cert = (Select ausca_soggetto_certificato from tb_ausca_sog_contr_az 
					where ausca_codice_fiscale = @cf and ausca_cert_cod_entita_rif = 1 and ausca_cert_auten_cod_pk = 2)
		if @cert = 'S' 
			return 1
		else
			return 2
	 end
	 else
		return -2 --il cf non esiste		
END

