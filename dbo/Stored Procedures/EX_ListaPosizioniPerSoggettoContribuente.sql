


-- =============================================
-- Author:		Almaviva
-- Create date: 2018.11.12
-- Description:	Estrae dati delle posizioni contibutive che afferiscono ad un codice fiscale 
-- Se il cf non viene fornito ritorna -1
-- Se il cf non esiste ritorna -2
-- =============================================
CREATE PROCEDURE  [dbo].[EX_ListaPosizioniPerSoggettoContribuente]
	@cf varchar(16)	

AS

BEGIN
	SET NOCOUNT ON;

    if @cf is null
	   return -1 --il cf non è stato fornito

IF ( EXISTS
	 (Select ausca_codice_pk FROM  tb_ausca_sog_contr_az
	  where ausca_codice_fiscale = @cf) 
	 ) 
	 begin
		select	ausca_codice_fiscale as CodiceFiscale,
				aupoc_posizione as Posizione,
				aurea_descrizione as Provenienza
		from tb_ausca_sog_contr_az 
		inner join tb_aupoc_pos_contr on aupoc_ausca_codice_pk = ausca_codice_pk
		inner join tb_aurea_area_gestione on aupoc_aurea_codice_pk = aurea_codice_pk
		where ausca_codice_fiscale = @cf and substring(aupoc_posizione,1,1) <> 'Z'
		order by Provenienza, Posizione
	 end
	 else
		return -2 --il cf non esiste		
END

