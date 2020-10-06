-- =============================================
-- Author:		Letizia bellantoni
-- Data: 20142908
-- Desc: Creata nuova funzionalità per associare tutte le funzioni di lettura alla app contemporanamente.
-- =============================================
CREATE PROCEDURE [dbo].[AP_AssociaFunzLettura]
	@id_applicazione int,
	@utente varchar(50)
AS

begin
	
             DELETE [tb_auref_rel_entita_funz] 
			 FROM  [tb_auref_rel_entita_funz]  INNER JOIN tb_aufun_funz_sistema ON
		     tb_aufun_funz_sistema.aufun_codice_pk = tb_auref_rel_entita_funz.auref_aufun_codice_pk
			 WHERE 
			 tb_auref_rel_entita_funz.auref_codice_entita_rif = @id_applicazione
			 and tb_auref_rel_entita_funz.auref_auten_codice_pk = 3 
			 and Upper(tb_aufun_funz_sistema.[aufun_raggruppamento])='LETTURA'
			 and tb_aufun_funz_sistema.aufun_tipo_funzione = 'W'
			

			
			
			 INSERT INTO  [dbo].[tb_auref_rel_entita_funz]
			   ([auref_aufun_codice_pk]
			   ,[auref_auten_codice_pk]
			   ,[auref_codice_entita_rif]
			   ,[auref_data_inizio_validita]
			   ,[auref_data_fine_validita]
			   ,[auref_data_modifica]
			   ,[auref_descr_utente])
		   
		    Select

			   aufun_codice_pk
			   ,3 
			   ,@id_applicazione
			   ,GETDATE()
			   ,convert (datetime,convert(varchar(4),year(getdate())+3) +'12'+'31',112)
			   ,GETDATE()
			   ,@utente

			   FROM  tb_aufun_funz_sistema 
			   WHERE 
				 tb_aufun_funz_sistema.[aufun_raggruppamento]='Lettura'
				 and tb_aufun_funz_sistema.aufun_tipo_funzione = 'W'


			   if @@ERROR > 0 return 300
			   else return 0


end


