


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  10/10/2017
-- Description:		Modifica PEC Soggetto Contribuente - Tabella "tb_ausca_sog_contr_az" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_AggiornaPEC]

@CF varchar (16),
@CodAz int,
@mail varchar (162),
@PEC varchar (162),
@lmail varchar (162),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @codER int

UPDATE [dbo].[tb_ausca_sog_contr_az]
SET [ausca_email] = rtrim(@mail),
    [ausca_pec] = rtrim(@pec),
    [ausca_legalmail] = rtrim(@lmail),
    [ausca_descr_utente] =  rtrim(@utente),
    [ausca_data_modifica] = Getdate() 
WHERE [ausca_codice_pk]= @CodAz

DELETE FROM  [AUC].[dbo].[tb_audb2_verso_db2]
WHERE audb2_codice_fiscale = @CF AND audb2_stato_pec = 0 

INSERT INTO [AUC].[dbo].[tb_audb2_verso_db2]
           ([audb2_codice_fiscale]
           ,[audb2_sede_provinciale]
           ,[audb2_matricola_azienda]
           ,[audb2_controcod_matr_az]
           ,[audb2_pec])
(
SELECT ausca_codice_fiscale, -- (è il codice fiscale in esame)
           tb_aupoc_pos_contr.aupoc_sede_provinciale,
           tb_aupoc_pos_contr.aupoc_matricola_azienda,
           tb_aupoc_pos_contr.aupoc_controcod_matr_az,
           @PEC --(è la PEC modificata)
       FROM tb_aupoc_pos_contr INNER JOIN tb_ausca_sog_contr_az ON 
              tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
       WHERE
            (tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1) AND ausca_codice_fiscale = @CF 
)



SET @codER = (SELECT auute_codice_pk from [tb_auute_ute_sistema]
WHERE auute_utenza = @utente)


EXEC AZ_1_Sincronizza @CodAz,1,@codER,null;


END

