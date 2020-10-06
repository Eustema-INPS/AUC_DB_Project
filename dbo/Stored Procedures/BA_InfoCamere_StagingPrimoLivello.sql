-- =============================================
-- Author:		Italo Paioletti
-- Create date: 07/09/2012
-- Popolamento e valorizzazione delle Staging di PRIMO LIVELLO
-- Description:	Aggiorna il campo St_TabName_PRESENTE  qualora il record fosse già presente sul DB Target 
-- =============================================
CREATE PROCEDURE [dbo].[BA_InfoCamere_StagingPrimoLivello]
	
AS
BEGIN
	-------------
	-- Passo 1 --
	-- AUSCA   --
	-- Target: Import_ausca_sog_contr_azienda
	-------------
	-- Vengono IDENTIFICATE tutte le righe GIA PRESENTI 
	-- Quindi 
	--		Tutti i record con St_ausca_PRESENTE = 'S' interesseranno l'AGGIORNAMENTO
	--		Tutti i record con St_ausca_PRESENTE = NULL interesseranno l'INSERIMENTO
	
	-- 1.1  -- FK Verso AUSCA in join con AUCFI
		UPDATE Import_ausca_sog_contr_azienda
		SET	St_ausca_PRESENTE = 'S'
		  , St_ausca_codice_pk = tb_aucfi_cod_fiscale.aucfi_ausca_codice_pk
		FROM Import_ausca_sog_contr_azienda INNER JOIN tb_aucfi_cod_fiscale ON 
		Import_ausca_sog_contr_azienda.St_ausca_codice_fiscale = tb_aucfi_cod_fiscale.aucfi_codice_fiscale
		WHERE (tb_aucfi_cod_fiscale.aucfi_data_inizio_validita <= GETDATE()) 
		AND   (tb_aucfi_cod_fiscale.aucfi_data_fine_validita IS NULL);
		
	-- 1.2  -- FK verso AUNGI  	     
		UPDATE dbo.Import_ausca_sog_contr_azienda
			SET St_ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk,
			St_ausca_auten_codice_pk = 2,
			St_ausca_codice_entita_riferimento = 1
		FROM dbo.Import_ausca_sog_contr_azienda INNER JOIN
			 dbo.tb_aungi_nat_giur_ct ON 
			 Import_ausca_sog_contr_azienda.St_ausca_CodiceFormaGiuridica = tb_aungi_nat_giur_ct.aungi_codice_forma;

	-- 1.3  -- Valorizzazioni FK 
	
			-- 1.3.1  -- FK verso AUATE 
			UPDATE Import_ausca_sog_contr_azienda
			SET St_ausca_auate_codice_pk = auate_codice_pk
			FROM Import_ausca_sog_contr_azienda INNER JOIN tb_auate_cod_ateco_ct ON 
				 Import_ausca_sog_contr_azienda.St_ausca_ATECO_2007 = tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo;
		
			-- 1.3.2  -- FK verso Ateco 2002	 
			UPDATE dbo.Import_ausca_sog_contr_azienda
			SET   St_ausca_auate2002_codice_pk = dbo.tb_auate_cod_ateco_ct.auate_codice_pk
			FROM dbo.Import_ausca_sog_contr_azienda INNER JOIN dbo.tb_auate_cod_ateco_ct ON 
				 dbo.Import_ausca_sog_contr_azienda.St_ausca_ATECO_2002 = dbo.tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo
			WHERE     (dbo.tb_auate_cod_ateco_ct.auate_anno_riferimento = 2002);

			-- 1.3.3  -- FK verso  Ateco 2007
			UPDATE dbo.Import_ausca_sog_contr_azienda
			SET  St_ausca_auate2007_codice_pk = dbo.tb_auate_cod_ateco_ct.auate_codice_pk
			FROM dbo.Import_ausca_sog_contr_azienda INNER JOIN dbo.tb_auate_cod_ateco_ct ON 
				 dbo.Import_ausca_sog_contr_azienda.St_ausca_ATECO_2007 = dbo.tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo
			WHERE     (dbo.tb_auate_cod_ateco_ct.auate_anno_riferimento = 2007);
	     
	     
	-------------     
	-- Passo 2 --
	-------------
	-- SOGGETTI COLLEGATI
	-- 1.1 : Vengono IDENTIFICATE (FLAG = 1) tutte le righe con il CF vuoto 
	-- 1.2	Tutti i record VALIDI con St_ausco_PRESENTE = 'S' interesseranno l'AGGIORNAMENTO
	--		Tutti i record VALIDIcon St_ausco_PRESENTE = NULL interesseranno l'INSERIMENTO

	UPDATE Import_ausco_sog_contr_collegato 
	SET St_Ausco_FLAG = 1
	WHERE rtrim(ltrim(St_ausco_codice_fiscale)) = '';
	
	UPDATE dbo.Import_ausco_sog_contr_collegato
    SET St_ausco_PRESENTE = 'S'
    FROM dbo.Import_ausco_sog_contr_collegato INNER JOIN dbo.tb_ausco_sog_contr_col ON 
         dbo.Import_ausco_sog_contr_collegato.St_ausco_codice_fiscale = dbo.tb_ausco_sog_contr_col.ausco_codice_fiscale
    WHERE (dbo.Import_ausco_sog_contr_collegato.St_ausco_FLAG IS NULL);
	
END
