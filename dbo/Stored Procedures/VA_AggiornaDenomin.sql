


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  09/10/2017
-- Description:		Modifica Denominazione Soggetto Contribuente - Tabella "tb_ausca_sog_contr_az" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaDenomin]

@CF varchar (16),
@CodAz int,
@denom varchar (405),
@cognome varchar (255),
@nome varchar (150),
@PI varchar (11),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @codER int

UPDATE [dbo].[tb_ausca_sog_contr_az]
SET [ausca_denominazione ] = rtrim(@denom),
    [ausca_cognome] = rtrim(@cognome),
    [ausca_nome] = rtrim(@nome),
    [ausca_descr_utente] =  rtrim(@utente),
	[ausca_data_modifica] = Getdate() 
WHERE [ausca_codice_pk]= @CodAz
/*WHERE [ausca_codice_fiscale]  = rtrim(@CF) */


SET @codER = (SELECT auute_codice_pk from [tb_auute_ute_sistema]
WHERE auute_utenza = @utente)


EXEC AZ_1_Sincronizza @CodAz,1,@codER,null;


END

