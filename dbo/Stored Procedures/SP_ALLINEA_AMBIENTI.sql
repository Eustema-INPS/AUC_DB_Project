


--select count(*) from tb_aulin_allineamento
--  where aulin_label = '2017 08 08 - Estrazione RASI'


CREATE PROCEDURE [dbo].[SP_ALLINEA_AMBIENTI]
       @cod_operazione int,
       @tipo_operazione varchar(3), -- SCA o POC
       @utente varchar(50)
AS
BEGIN
       SET NOCOUNT ON;     

---------------------------------------------------
-- Accodamento tb_ausru_Storico_Richieste_Utente --
---------------------------------------------------
-- print @tipo_operazione     
       IF @tipo_operazione = 'POC' 
       begin

             INSERT INTO [dbo].[tb_ausru_Storico_Richieste_Utente] 
                    (ausru_codice_fiscale,
                    ausru_posizione,
                    ausru_utente_richiesta,
                    ausru_data_richiesta,
                    ausru_tipo_richiesta,
                    ausru_descr_utente)
                    SELECT 
                           tb_ausca_sog_contr_az.ausca_codice_fiscale, 
                           tb_aupoc_pos_contr.aupoc_posizione, 
                           @utente,
                           Getdate(),
                           'POC',
                           'AZ124' 
                    FROM  tb_aupoc_pos_contr INNER JOIN tb_ausca_sog_contr_az ON 
                           tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
                           inner join tb_audop_dettaglio_operazioni on AUDOP_dato = aupoc_posizione
                    WHERE (AUOPE_CODICE_PK = @cod_operazione)             
       end
       else if @tipo_operazione = 'SCA' begin
             INSERT INTO [dbo].[tb_ausru_Storico_Richieste_Utente] 
                    (ausru_codice_fiscale,
                    ausru_utente_richiesta,
                    ausru_data_richiesta,
                    ausru_tipo_richiesta,
                    ausru_descr_utente)
                    SELECT 
                           tb_ausca_sog_contr_az.ausca_codice_fiscale, 
                           @utente,
                           Getdate(),
                           'SCA',
                           'AZ124' 
                    FROM  tb_ausca_sog_contr_az 
                           inner join tb_audop_dettaglio_operazioni on AUDOP_dato = ausca_codice_fiscale
                    WHERE (AUOPE_CODICE_PK = @cod_operazione)                          
       end

END

