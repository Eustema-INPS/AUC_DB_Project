-- =======================================================
-- Author:		Letizia
-- Create date: 2013.07.24
-- Description:	Inserimento un record di AUFOR (forza lavoro)
-- =======================================================
CREATE PROCEDURE [dbo].[SP_INS_UPD_FORZALAVORO]
	@aufor_posizione varchar(50), 
    @aufor_annomese int,
    @aufor_num_dip_cert int,
    @aufor_utente_cert_mod varchar(50),
    @appName varchar(50),
    @aufor_codice_pk int output
AS
BEGIN

  --Codice di ritorno=1 -->Campi obbligatori non presenti (aufor_posizione e annomese)
  --Codice di ritorno=2 -->Posizione non presente
 
  declare @aufor_aupoc_codice_pk int;
 
  
  IF (@aufor_posizione is not null and dbo.fn_convert_int_date(@aufor_annomese)= 0)
					BEGIN
					IF ( EXISTS
					(SELECT aupoc_codice_pk  FROM  tb_aupoc_pos_contr 
					  WHERE  aupoc_posizione= @aufor_posizione and aupoc_aurea_codice_pk = 1) 
					 ) 
			   
			  
		         				BEGIN
								  --declare @aufor_codice_pk int;
								  SET @aufor_aupoc_codice_pk = (SELECT aupoc_codice_pk  FROM  tb_aupoc_pos_contr 
										  WHERE  aupoc_posizione= @aufor_posizione and aupoc_aurea_codice_pk = 1) 
								          
								  IF (NOT EXISTS
										(SELECT * FROM    [tb_aufor_forze_lavoro]
										  WHERE aufor_posizione = @aufor_posizione AND aufor_annomese = @aufor_annomese) )
													BEGIN

												   INSERT INTO  [tb_aufor_forze_lavoro] 
												   
												   (
														aufor_posizione,
														aufor_annomese,
														aufor_aupoc_codice_pk,
														[aufor_num_dip_dic] ,
														[aufor_stato_certificazione],
														[aufor_data_dic]       ,    
														[aufor_data_dic_mod]  ,     
														[aufor_utente_dic]       ,  
														[aufor_utente_dic_mod]     ,
														[aufor_data_modifica]     ,  
														[aufor_descr_utente]   
													)    
												   --OUTPUT inserted.aufor_codice_pk  
												   VALUES
												  
														(
														@aufor_posizione,
														@aufor_annomese,
														@aufor_aupoc_codice_pk,
														@aufor_num_dip_cert, 
														0, 
														GETDATE(), 
														GETDATE(), 
														@aufor_utente_cert_mod, 		
														@aufor_utente_cert_mod, 
														GETDATE(), 
														@appName 
														 ) 
													 SET @aufor_codice_pk = SCOPE_IDENTITY()
													 return 0
													 END
													
								   ELSE 
												  BEGIN
													  UPDATE [tb_aufor_forze_lavoro] 
													 
													   SET  [aufor_num_dip_dic] = @aufor_num_dip_cert, 
															[aufor_stato_certificazione] = 0, 
															[aufor_data_dic]            = GETDATE(), 
															[aufor_data_dic_mod]        = GETDATE(), 
															[aufor_utente_dic]          = @aufor_utente_cert_mod, 		
															[aufor_utente_dic_mod]      = @aufor_utente_cert_mod, 
															[aufor_data_modifica]        = GETDATE(), 
															[aufor_descr_utente]         = @appName, 
															 @aufor_codice_pk=aufor_codice_pk
													   WHERE aufor_posizione = @aufor_posizione AND aufor_annomese = @aufor_annomese and aufor_aupoc_codice_pk=@aufor_aupoc_codice_pk
													  	 return 0
												  END
					 
				 END
					 ELSE
						   return 2 --posizione non presente
					 END
		
  ELSE
			   return 1 --campi non validi
			
END


