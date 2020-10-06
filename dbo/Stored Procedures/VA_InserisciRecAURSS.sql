





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_aurss_rel_sog_sog"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAURSS]

@codausca int,
@codausco int,
@codautis int,
@dataini varchar(10),
@datafine varchar(10),
@rl varchar(1),
@utente varchar (50),
@codrif int


AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_aurss_rel_sog_sog](
	[aurss_ausca_codice_pk]
	,[aurss_ausco_codice_pk]     	
	,[aurss_aussu_codice_pk]
	,[aurss_autis_codice_pk]
	,[aurss_data_inizio_validita]
	,[aurss_data_di_fine_validita]
	,[aurss_rappresentante_legale]
	,[aurss_data_modifica]
	,[aurss_descr_utente]
	,[aurss_auten_codice_pk]
	,[aurss_codice_entita_rif])
VALUES(
	rtrim(@codausca),
	rtrim(@codausco),
	1,
	rtrim(@codautis),
	Convert(DateTime,@dataini + ' 00:00',103),
	Convert(DateTime,@datafine + ' 00:00',103),
	rtrim(@rl),
    Getdate(),	
	rtrim(@utente),
	1,
	rtrim(@codrif))    

END


