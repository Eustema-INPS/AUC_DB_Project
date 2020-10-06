





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  08/10/2018
-- Description:		Elenco dati Tabella TB_AUPOE_POSIZIONIERRATE
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAupoeRic]
@codiceTab as int,
@codice varchar(50)

AS
BEGIN


	SET NOCOUNT ON;
	
	
		select * from TB_AUPOE_POSIZIONIERRATE 
		where aupoe_posizione = @codice

END






