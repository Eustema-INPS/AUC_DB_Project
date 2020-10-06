-- ===================================================================
-- Author:		Maurizio Picone
-- Create date: 30 ottobre 2012
-- Description:	Accesso alla tabella tb_aupoc_pos_contr per RC
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_LISTA_AZIENDE_RC] 
	@codicesede varchar(4),              -- Codice Sede di Riferimento
    @codice_fiscale_azienda varchar(16), -- CF Azienda
	@csc varchar(5),                     -- Aupco, Codice Stat Contr
	@stato_pos_contr varchar(50)         -- Descrizione stato pos contr
AS
BEGIN
   SET NOCOUNT ON;
	  
   SELECT 	 
       aupoc_codice_pk
      ,aupoc_contro_codice 
      ,aupoc_posizione
      ,ausca_codice_fiscale
      -- AI 2009:
      ,ausca_piva
      -- AI 2009.
      ,ausca_denominazione
      
   FROM  [dbo].[tb_aupoc_pos_contr]
	    
	  inner join   [dbo].[tb_ausca_sog_contr_az]  -- AUSCA per Codice Fiscale Azienda
	  on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
	  	
      inner join   [dbo].[tb_auspc_stato_pos_contr_ct]  -- AUSPC per Stato Posizione Contr
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
  
	  inner join dbo.tb_aupco_periodo_contr   -- AUPCO per CSC
	  ON tb_aupco_periodo_contr.aupco_aupoc_codice_pk = aupoc_codice_pk
	  
   WHERE 	  
	  -- CODICE SEDE (obbligatorio)
	  SUBSTRING(tb_aupoc_pos_contr.aupoc_cod_sede_INPS,3,4) = @codicesede

	  -- Cod Fiscale Azienda (facoltativo)
	  AND (@codice_fiscale_azienda = '' OR ausca_codice_fiscale = @codice_fiscale_azienda) 

	  -- Stato pos contr (facoltativo)
	  AND (@stato_pos_contr = '' OR @stato_pos_contr is null or auspc_descr = @stato_pos_contr)
	  	  
	  -- CSC (facoltativo)
	  AND (@csc = '' OR @csc is null or aupco_cod_stat_contr = @csc) 
	  	  
	  AND aupoc_cida IS NULL -- Esclude dal risultato le aziende -NON- agricole (MODIFICA 19/11/2012)
	  	  
    GROUP BY 	   
       aupoc_codice_pk
      ,aupoc_contro_codice 
      ,aupoc_posizione
      ,ausca_codice_fiscale
      -- AI 2009:
      ,ausca_piva
      -- AI 2009.
      ,ausca_denominazione
 
END
