

-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.05.17
-- Description:	AI
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_REGISTRO_AIUTI]
	@azione varchar(8),
	@codice_fiscale varchar(16),
	@impresa_autonoma varchar(1),
	@impresa_associata varchar(1),
	@impresa_collegata varchar(1),
	@data_fine_esercizio date,
	@dimensione_aziendale varchar(2),
	@codice_operatore varchar(20),
	@codice_fiscale_delegato varchar(16),
	@codici_fiscali_collegati as dbo.RA_codici_fiscali_collegati READONLY
AS
BEGIN
	
	SET NOCOUNT ON;
declare @chiave_ausca int
declare @id_ausra int

declare @cod_dimensione varchar(2)

-- Se il cf esiste su AUSCA va avanti altrimenti termina
set @chiave_ausca = (select ausca_codice_pk from tb_ausca_sog_contr_az where ausca_codice_fiscale = @codice_fiscale) 

IF ( @chiave_ausca is not null and @chiave_ausca <> 0)
 BEGIN
--- Storicizza i dati di AUSCA preesistenti su AUSRA

if @dimensione_aziendale = 'MI' 
begin
	set @cod_dimensione = '01'
end
else if @dimensione_aziendale = 'PI' 
begin
	set @cod_dimensione = '02'
end
else if @dimensione_aziendale = 'ME' 
begin
	set @cod_dimensione = '03'
end
else if @dimensione_aziendale = 'GR' 
begin
	set @cod_dimensione = '04'
end
else
	set @cod_dimensione = '00'

	 insert into tb_ausra_storico_registro_aiuti 
           ([ausra_ausca_codice_pk]
           ,[ausra_RA_impresa_autonoma]
           ,[ausra_RA_impresa_associata]
           ,[ausra_RA_impresa_collegata]
           ,[ausra_RA_data_fine_esercizio]
           ,[ausra_RA_dimensione_aziendale]
           ,[ausra_codice_operatore]
           ,[ausra_codice_fiscale_delegato]
           ,[ausra_data_modifica])
     select ausca_codice_pk,
			ausca_RA_impresa_autonoma,
			ausca_RA_impresa_associata,
			ausca_RA_impresa_collegata,
			ausca_RA_data_fine_esercizio,
			ausca_RA_dimensione_aziendale,
			ausca_RA_codice_operatore,
			ausca_RA_codice_fiscale_delegato,
			getdate() from tb_ausca_sog_contr_az
		where ausca_codice_fiscale = @codice_fiscale

-- Memorizza id ultimo record

set @id_ausra= (SELECT isnull(SCOPE_IDENTITY(),0))

--Storicizza i cf collegati di AURAC su AUSRC
	insert into tb_ausrc_storico_registro_aiuti_cf
		([ausrc_ausra_codice_pk],
		 [ausrc_codice_fiscale_impresa_collegata],
		 [ausrc_data_modifica])
	select @id_ausra, aurac_codice_fiscale_impresa_collegata, getdate() from tb_aurac_registro_aiuti_cf
		where aurac_ausca_codice_pk=@chiave_ausca

--Aggiorna i dati di AUSCA
	if (@azione <> 'CANCELLA') 
	BEGIN
		update tb_ausca_sog_contr_az
		set ausca_RA_impresa_autonoma = @impresa_autonoma,
			ausca_RA_impresa_associata = @impresa_associata,
			ausca_RA_impresa_collegata = @impresa_collegata,
			ausca_RA_data_fine_esercizio = @data_fine_esercizio,
			--ausca_RA_dimensione_aziendale = @dimensione_aziendale,
			ausca_RA_dimensione_aziendale = @cod_dimensione,
			ausca_RA_codice_operatore = @codice_operatore,
			ausca_RA_codice_fiscale_delegato = @codice_fiscale_delegato,
			ausca_RA_data_modifica = getdate(),
			ausca_data_modifica = getdate()
			where ausca_codice_fiscale = @codice_fiscale
	END
	ELSE
-- Cancellazione AUSCA
	BEGIN
		update tb_ausca_sog_contr_az
		set ausca_RA_impresa_autonoma = 'N',
			ausca_RA_impresa_associata = 'N',
			ausca_RA_impresa_collegata = 'N',
			ausca_RA_data_fine_esercizio = NULL,
			ausca_RA_dimensione_aziendale = NULL,
			ausca_RA_codice_operatore = @codice_operatore,
			ausca_RA_codice_fiscale_delegato = NULL,
			ausca_RA_data_modifica = getdate(),
			ausca_data_modifica = getdate()
			where ausca_codice_fiscale = @codice_fiscale
	END

--Cancella i dati su AURAC
	delete from tb_aurac_registro_aiuti_cf
		where aurac_ausca_codice_pk=@chiave_ausca

--Inserisce i record su AURAC
	if (@azione <> 'CANCELLA') 
	BEGIN
		INSERT INTO [dbo].[tb_aurac_registro_aiuti_cf]
           ([aurac_ausca_codice_pk]
           ,[aurac_codice_fiscale_impresa_collegata]
           ,[aurac_data_modifica])
		select @chiave_ausca, aurac.[codice_fiscale_collegato], getdate() from @codici_fiscali_collegati as aurac
	END
 END
		
 ELSE
-- non esiste cf su ausca  la stored ritorna False
RETURN 1

END
