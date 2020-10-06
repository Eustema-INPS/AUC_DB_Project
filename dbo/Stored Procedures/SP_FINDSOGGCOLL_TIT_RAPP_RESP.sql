-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2013.11.21
-- Description:	Estrae dati anagrafica del sogg. collegato  TIT, Rapp. Legale o Altro Resp.
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- =============================================
CREATE PROCEDURE  [dbo].[SP_FINDSOGGCOLL_TIT_RAPP_RESP]
	@codice_fiscale varchar(16)	

	
AS

declare @ausco_codice_pk integer;
SET NOCOUNT ON;
BEGIN
--verifico se esiste record su AUSCO
IF ( EXISTS
	 (Select tb_ausco_sog_contr_col.ausco_codice_pk FROM  tb_ausco_sog_contr_col
	  where tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale) 
	 ) 
		BEGIN
			
			--verifico se esiste relazione su aurss
				
					set @ausco_codice_pk=
					(
					SELECT  distinct   tb_ausco_sog_contr_col.ausco_codice_pk
					FROM       tb_ausco_sog_contr_col INNER JOIN
							   tb_aurss_rel_sog_sog ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN
							   tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
					WHERE     tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale
						  AND 
						  (tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 OR tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90
						   or aurss_rappresentante_legale='S')
						 	AND
						   (
						    (convert(date,GETDATE(),103) BETWEEN aurss_data_inizio_validita AND aurss_data_di_fine_validita)
--							((tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
--							(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )
						    or 
							(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita is null)
							or (tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null)	
							) 
					)
			    	
			    	if @ausco_codice_pk is  null
			    	--se @ausco_codice_pk è null cerco relazione su AURSP
							
						set @ausco_codice_pk=
						(
						SELECT distinct tb_ausco_sog_contr_col.ausco_codice_pk
								FROM         tb_ausco_sog_contr_col INNER JOIN
								tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk 
								INNER JOIN
								tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
								WHERE     (tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale)
								AND 
								tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97
								AND
								(
						        (convert(date,GETDATE(),103) BETWEEN aursp_data_inizio_validita AND aursp_data_di_fine_validita)
--								((tb_aursp_rel_sog_pos.aursp_data_di_fine_validita >= GETDATE() )  and
--								(tb_aursp_rel_sog_pos.aursp_data_inizio_validita <= GETDATE() )
								 or 
								(tb_aursp_rel_sog_pos.aursp_data_di_fine_validita is null)
								or (tb_aursp_rel_sog_pos.aursp_data_inizio_validita is null)	
								) 
						)
			
			
			if @ausco_codice_pk is not null
					SELECT     [ausco_codice_pk]
							  ,[ausco_codice_fiscale]
							  ,[ausco_cognome]
							  ,[ausco_nome]
							  ,[ausco_sesso]
							  ,[ausco_cittadinanza]
							  ,[ausco_comune_nascita]
							  ,[ausco_data_nascita]
							  ,[ausco_prov_nascita]
							  ,[ausco_stato_estero_nascita]
							  ,[ausco_tipo_persona]
							  ,[ausco_codice_toponimo]
							  ,[ausco_toponimo]
							  ,[ausco_indirizzo]
							  ,[ausco_civico]
							  ,[ausco_cap]
							  ,[ausco_codice_comune]
							  ,[ausco_localita]
							  ,[ausco_provincia]
							  ,[ausco_sigla_nazione]
							  ,[ausco_codice_stato_estero]
							  ,[ausco_telefono]
							  ,[ausco_fax]
							  ,[ausco_email]
							  ,[ausco_pec]
							  ,[ausco_legalmail]
							  ,[ausco_note]
							  ,[ausco_data_modifica]
							  ,[ausco_descr_utente]
							  ,[ausco_denominazione]
					FROM       tb_ausco_sog_contr_col 
					WHERE     (tb_ausco_sog_contr_col.ausco_codice_pk  = @ausco_codice_pk)
						
		
		     	
		    	ELSE
				 
				--se non esiste relazione su AURSP la stored ritorna False
			
				return 1
				
END
		
ELSE
--non esiste riga su ausco  la stored ritorna False
RETURN 1
END
