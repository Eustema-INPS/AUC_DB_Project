


-- =============================================
-- Author:		    Raffaele 
-- Modified date:   03 marzo 2015
-- Description:	    
-- =============================================

CREATE PROCEDURE [dbo].[temp_ins_aufor_under50] 
	@aufor_aupoc_codice_pk int ,      --codice_aupoc
	@aufor_posizione varchar(50)      --posizione
AS
BEGIN
	SET NOCOUNT ON;
INSERT INTO [dbo].[tb_aufor_forze_lavoro]
           ([aufor_aupoc_codice_pk]
           ,[aufor_posizione]
           ,[aufor_annomese]
           ,[aufor_num_dip_dic]
           ,[aufor_utente_dic]


           ,[aufor_stato_certificazione]
           ,[aufor_data_modifica]
           ,[aufor_descr_utente])
     VALUES
           (@aufor_aupoc_codice_pk, @aufor_posizione, '201401',10,'RAF',0,getdate(),'Manuale Raf'),
		   (@aufor_aupoc_codice_pk, @aufor_posizione, '201402',11,'RAF',0,getdate(),'Manuale Raf'),
		   (@aufor_aupoc_codice_pk, @aufor_posizione, '201403',12,'RAF',0,getdate(),'Manuale Raf'),
		   (@aufor_aupoc_codice_pk, @aufor_posizione, '201404',13,'RAF',0,getdate(),'Manuale Raf'),
		   (@aufor_aupoc_codice_pk, @aufor_posizione, '201405',14,'RAF',0,getdate(),'Manuale Raf'),
		   (@aufor_aupoc_codice_pk, @aufor_posizione, '201406',15,'RAF',0,getdate(),'Manuale Raf')
END







