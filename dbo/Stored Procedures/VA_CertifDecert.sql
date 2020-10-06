


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  10/10/2017
-- Description:		certifica/Decertifica Soggetto Contribuente - Tabella "tb_ausca_sog_contr_az" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CertifDecert]

@CodAz int,
@SC varchar (1),
/*@tipoE int,
@nomeE int,*/
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @codER int

	If @SC  = 'N' 
		BEGIN
			UPDATE [dbo].[tb_ausca_sog_contr_az]
				SET [ausca_soggetto_certificato] = rtrim(@SC),
					[ausca_cert_auten_cod_pk] = NULL, 
					[ausca_cert_cod_entita_rif] = NULL,
					[ausca_cert_data_modifica] = NULL,	 
					[ausca_data_modifica] = Getdate() 
				WHERE [ausca_codice_pk]= @CodAz
		END
		Else If @SC  = 'S'
		BEGIN
		   UPDATE [dbo].[tb_ausca_sog_contr_az]
				SET [ausca_soggetto_certificato] = rtrim(@SC),
					[ausca_cert_auten_cod_pk] = 2,
					[ausca_cert_cod_entita_rif] = 3,
					[ausca_cert_data_modifica] = Getdate(),	 
					[ausca_data_modifica] = Getdate() 
				WHERE [ausca_codice_pk]= @CodAz
		END



SET @codER = (SELECT auute_codice_pk from [tb_auute_ute_sistema]
WHERE auute_utenza = @utente)


EXEC AZ_1_Sincronizza @CodAz,1,@codER,null;


END

