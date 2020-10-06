




-- ===================================================================
-- Author:		Dimpflmeier & Palmieri 
-- Create date: 01/07/2016
-- Description:	Estrazione dati di una posizione contributiva IVA
-- Modificata:  Palmieri
-- Data:	    2016-11-02
-- Descrizione: Inserito il filtro che scarta le unità operative non produttive
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_MLPS_LISTA_UNITA_OP] 

	@posizione varchar(50),
	@data_Inizio_riferimento date = null,
	@data_Fine_riferimento date = null
	
AS
BEGIN
	SET NOCOUNT ON;
(   SELECT 	 [aupoc_posizione],
			 '0' as id,
			 auind_toponimo,
			 auind_indirizzo,
			 auind_civico,
			 auind_cap,
			 auind_sigla_provincia,
			 auind_descr_comune,
			 aupoc_data_inizio_attivita as data_inizio,
			 '2999-12-31' as data_fine
   FROM  [dbo].[tb_aupoc_pos_contr] 
   inner join tb_auind_indirizzi WITH (READUNCOMMITTED) on aupoc_codice_pk = auind_tabella_codice_pk and auind_tabella = 'AUPOC'
   WHERE 
	  aupoc_posizione = @posizione 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z' -- non cancellata logicamente
	  and aupoc_auspc_codice_pk IN (1, 4, 5) -- attiva o riattiva o sospesa
)
union 
(   SELECT 	 [aupoc_posizione],
			 auuop_identificativo as id,
			 auind_toponimo,
			 auind_indirizzo,
			 auind_civico,
			 auind_cap,
			 auind_sigla_provincia,
			 auind_descr_comune,
			 auuop_data_inizio_accentr as data_inizio,
			 auuop_data_fine_accentr as data_fine
   FROM  [dbo].[tb_aupoc_pos_contr] 
   WITH (READUNCOMMITTED) Inner join tb_auuop_unita_operativa on aupoc_codice_pk = auuop_aupoc_codice_pk
   left outer join tb_auind_indirizzi WITH (READUNCOMMITTED) on auuop_codice_pk = auind_tabella_codice_pk and auind_tabella = 'AUUOP'
   WHERE 
	  aupoc_posizione = @posizione 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z' -- non cancellata logicamente
	  AND (@data_Fine_riferimento is null or auuop_data_inizio_accentr <= @data_Fine_riferimento)
	  AND (@data_Inizio_riferimento is null or @data_Inizio_riferimento <= auuop_data_fine_accentr)
	  and aupoc_auspc_codice_pk IN (1, 4, 5) -- attiva o riattiva o sospesa
	  and auuop_unita_produttiva = 'S' -- unità operativa produttiva
)
END

