




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  23/09/2019
-- Description:		Modifica Indirizzo Soggetto Contribuente - Tabella "tb_auind" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaIndAUPOC]

@codaupoc int,
@topon varchar (50),
@indir varchar (255),
@civic varchar (50),
@cap varchar (10),
@comun varchar (50),
@prov varchar (2),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_auind_indirizzi]
SET [auind_toponimo] = rtrim(@topon),
	[auind_indirizzo] = rtrim(@indir),
	[auind_civico] = rtrim(@civic),
	[auind_descr_comune] = rtrim(@comun),
	[auind_sigla_provincia] = rtrim(@prov),
	[auind_cap] = rtrim(@cap),
    [auind_descr_utente] =  rtrim(@utente),
	[auind_data_modifica] = Getdate() 
FROM     [tb_auind_indirizzi] inner JOIN
         tb_aupoc_pos_contr ON UPPER(tb_auind_indirizzi.auind_tabella) = 'AUPOC' AND tb_auind_indirizzi.auind_tabella_codice_pk = @codaupoc

--select top (19) *
--FROM     [tb_auind_indirizzi] inner JOIN
--         tb_aupoc_pos_contr ON UPPER(tb_auind_indirizzi.auind_tabella) = 'AUPOC' AND tb_auind_indirizzi.auind_tabella_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk

END





