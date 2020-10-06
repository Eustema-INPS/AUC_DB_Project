



CREATE PROCEDURE [dbo].[VA_VerificaAnagrafica]

@CF varchar (16),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[TB_AUVIN_VERIFICA_INDIRIZZO]
           ([AUVIN_CHIAVE_AUC]
           ,[AUVIN_PROVENIENZA]
           ,[AUVIN_CODICE_FISCALE]
           ,[AUVIN_I_DENOMINAZIONE]
           ,[AUVIN_I_COGNOME]
           ,[AUVIN_I_NOME]
           ,[AUVIN_I_TOPONIMO]
           ,[AUVIN_I_INDIRIZZO]
           ,[AUVIN_I_CIVICO]
           ,[AUVIN_I_CAP]
           ,[AUVIN_I_COMUNE]
           ,[AUVIN_I_PROVINCIA]
           ,[AUVIN_I_CODICE_COMUNE_BELFIORE]
           ,[AUVIN_RICHIEDENTE])
SELECT  ausca_codice_pk, 'AUSCA', ausca_codice_fiscale, ausca_denominazione, ausca_cognome, ausca_nome, 
	ausca_toponimo, ausca_indirizzo, ausca_civico, substring(ausca_cap,1,5), ausca_descr_comune, ausca_sigla_provincia, ausca_cod_com_Belfiore, rtrim(@utente)
	from tb_ausca_sog_contr_az
where	ausca_codice_fiscale = LTRIM(rtrim(@CF))
END

