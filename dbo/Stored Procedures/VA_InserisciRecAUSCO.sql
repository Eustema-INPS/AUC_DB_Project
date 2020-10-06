



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_ausco_sog_contr_col"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUSCO]


@cf varchar(16),
@denom varchar(405),
@nome varchar(150),
@cognome varchar(255),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_ausco_sog_contr_col](
      	 [ausco_codice_fiscale]
     	 ,[ausco_denominazione]
      	,[ausco_cognome]
      	,[ausco_nome]
      	,[ausco_tipo_persona]
	,[ausco_telefono]
	,[ausco_telefono2]
	,[ausco_fax]
	,[ausco_note]
	,[ausco_data_modifica]
	,[ausco_aurea_codice_pk]
	,[ausco_descr_utente])
VALUES(
	rtrim(@cf),
	rtrim(@denom),
	rtrim(@cognome),
	rtrim(@nome),
	'F',
	'000000',
	'000000',
	'000000',
	'Anagrafica inserita da applicazione',
     Getdate(),
	'12',
	rtrim(@utente))    

END





