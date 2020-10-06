
-- =============================================
-- Autore:	Raffaele Palmieri
-- Data:	15/3/2016
-- Per la posizione fornita ritorna un insieme di dati relativi ai soggetti aziendali ad essa collegati 
-- ed alle forze lavoro degli ultimi 6 mesi solari
-- Viene richiamata da Simula
-- =============================================
CREATE PROCEDURE [dbo].[EX_ListaSoggetti_ForzaLavoro] @aupoc_posizione varchar(50), @data_inizio date, @data_fine date
AS
-- declare @aupoc_codice_pk integer;
SET NOCOUNT ON;

BEGIN
	DECLARE @annomese_inizio INT
	DECLARE @annomese_fine INT

	-- verifico se esiste record su AUPOC
	IF ( EXISTS
		( SELECT tb_aupoc_pos_contr.aupoc_codice_pk FROM  tb_aupoc_pos_contr
		  WHERE @AUPOC_POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione )--and aupoc_aurea_codice_pk = 1) 
		) 
		BEGIN
			set @annomese_inizio = 	convert(int,substring(convert(varchar(10),CONVERT (date, @data_inizio)),1,4))*100
								   +convert(int,substring(convert(varchar(10),CONVERT (date, @data_inizio)),6,2))
			set @annomese_fine = 	convert(int,substring(convert(varchar(10),CONVERT (date, @data_fine)),1,4))*100
								   +convert(int,substring(convert(varchar(10),CONVERT (date, @data_fine)),6,2))

			SELECT	ausca_codice_fiscale as CodiceFiscaleAzienda,
					aupoc_posizione as Posizione,
					aufor_annomese as periodo,
					aufor_num_dip_dic as Forza_Lavoro
			FROM tb_ausca_sog_contr_az WITH (READUNCOMMITTED) 
			INNER JOIN tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk
			INNER JOIN tb_aufor_forze_lavoro on aufor_posizione = @AUPOC_POSIZIONE
			WHERE 1=1
			AND @AUPOC_POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione 
			AND aufor_annomese >= @annomese_inizio and aufor_annomese <= @annomese_fine
			ORDER BY periodo ASC
		END
								   
	ELSE -- non esiste riga su aupoc  la stored ritorna False
		RETURN 1

END

