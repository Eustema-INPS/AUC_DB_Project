
-- =============================================
-- Autore:		Stefano Chiovelli
-- Data:		04/10/2019
-- La stored effettua l'esecuzione delle stored che calcolano i dati per i modelli AZST.
-- Se il parametro in input @riduzione vale 1 esegue la sola stored per il modello 046010, altrimenti li calcola tutti
-- Se i parametri relativi alle date sono null imposta le date in base al mese precedente l'esecuzione. 
-- =============================================

CREATE PROCEDURE [dbo].[SP_GESTIONE_MODELLI_AZST] @riduzione int, @data_inizio date, @data_fine date
AS
	SET NOCOUNT ON;
begin
	DECLARE @date DATETIME = GETDATE();  

	declare @primo datetime = DATEADD(DAY, 1, EOMONTH(@Date, -2))
	declare @ultimo datetime = EOMONTH ( @date, -1 )

	if @data_inizio is null
		set @data_inizio = @primo

	if @data_fine is null
		set @data_fine = @ultimo

	EXEC	[dbo].[SP_MOD_046010_IN_AURAZ] @data_inizio, @data_fine

	if @riduzione <> 1
	begin
		EXEC	[dbo].[SP_MOD_046020_IN_AURAZ] @data_inizio, @data_fine
		EXEC	[dbo].[SP_MOD_046032_IN_AURAZ] @data_inizio, @data_fine
		EXEC	[dbo].[SP_MOD_046034_IN_AURAZ] @data_inizio, @data_fine
		EXEC	[dbo].[SP_MOD_046036_IN_AURAZ] @data_inizio, @data_fine
		EXEC	[dbo].[SP_MOD_046038_IN_AURAZ] @data_inizio, @data_fine
		EXEC	[dbo].[SP_MOD_046040_IN_AURAZ] @data_inizio, @data_fine
	end

end



