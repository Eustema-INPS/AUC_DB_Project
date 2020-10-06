



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  20/09/2019
-- Description:		Modifica Denominazione Soggetto Contribuente - Tabella "tb_aupoc" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaDenomAUPOC]

@codaupoc varchar (50),
@denomin varchar (405),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


UPDATE [dbo].[tb_aupoc_pos_contr]
SET [aupoc_denom_posiz_contr] = rtrim(@denomin),
    [aupoc_descr_utente] =  rtrim(@utente),
	[aupoc_data_modifica] = Getdate() 
WHERE [aupoc_posizione]= @codaupoc



END




