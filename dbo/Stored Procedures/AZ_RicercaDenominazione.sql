-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 23-06-2011
-- Description:	Stored per la ricerca SCA tramite denominazione
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 10-10-2012
-- Description:	Aggiunto criterio di ricerca sul codice sede
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 07-11-2012
-- Description:	Modifica sul criterio di ricerca  codice sede;aggiunta FK su aupoc
-- =============================================
CREATE PROCEDURE [dbo].[AZ_RicercaDenominazione]
	@denominazione	varchar(405),
	@criterio	varchar(1),    -- '0' = Inizia per / '1' = Contiene / '2' = Puntuale
	@codicesede varchar(10)
AS
BEGIN	
	SET NOCOUNT ON;
	
	if @criterio = '0'
		begin
			SET @denominazione = @denominazione + '%'
		end
	else if @criterio = '1'
		begin
			SET @denominazione = '%' + @denominazione + '%'
		end


 if @codicesede='' or @codicesede is null
 begin 

   SELECT top (501)
		ausca_codice_pk as DB_CodiceAzienda,
		ausca_denominazione as DB_Denominazione,
		ausca_codice_fiscale as DB_CodiceFiscale,
		ausca_cognome + ' ' + ausca_nome as DB_NomeCompleto,
		ausca_localita as DB_Localita,
		ausca_sigla_provincia as DB_SiglaProvincia,
		ausca_codice_toponimo as DB_CodiceToponimo,
		ausca_indirizzo as DB_Indirizzo,
		ausca_civico as DB_Civico,
		ausca_descr_comune as DB_Comune,
		ausca_regione as DB_Regione,
		ausca_cap as DB_Cap,
		ausca_soggetto_certificato as DB_SoggettoCertificato,
		ausca_auten_codice_pk as DB_CodiceTipoEntita,
		ausca_codice_entita_rif as DB_CodiceEntita
	FROM tb_ausca_sog_contr_az 
	WHERE 
		--ausca_denominazione like  '%' + @denominazione + '%'
		ausca_denominazione like @denominazione
	ORDER BY ausca_denominazione
 end
 ELSE
 begin
  
  --print @codicesede +'else'
  SELECT top (501)
		ausca_codice_pk as DB_CODICEAzienda,
		ausca_denominazione as DB_Denominazione,
		ausca_codice_fiscale as DB_CodiceFiscale,
	    ausca_cognome + ' ' + ausca_nome as DB_NomeCompleto,
		ausca_localita as DB_Localita,
		ausca_sigla_provincia as DB_SiglaProvincia,
		ausca_codice_toponimo as DB_CodiceToponimo,
		ausca_indirizzo as DB_Indirizzo,
		ausca_civico as DB_Civico,
		ausca_descr_comune as DB_Comune,
		ausca_regione as DB_Regione,
		ausca_cap as DB_Cap,
		ausca_soggetto_certificato as DB_SoggettoCertificato,
		ausca_auten_codice_pk as DB_CodiceTipoEntita,
		ausca_codice_entita_rif as DB_CodiceEntita
		
	FROM tb_ausca_sog_contr_az ausca
	where 
			--ausca_denominazione like  '%' + @denominazione + '%'
	ausca_denominazione like @denominazione
	and
	ausca_codice_pk =
	(select distinct (aupoc_ausca_codice_pk) from tb_aupoc_pos_contr aupoc
	 inner join tb_ausin_sedi_inps_ct ON
	 aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
	 where 	tb_ausin_sedi_inps_ct.ausin_codice_pk=CAST(@codicesede as Int)
	  and ausca.ausca_codice_pk=aupoc.aupoc_ausca_codice_pk)
			
	ORDER BY ausca_denominazione
	
 end
END

