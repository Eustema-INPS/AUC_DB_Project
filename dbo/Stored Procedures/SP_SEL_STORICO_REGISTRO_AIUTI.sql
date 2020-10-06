


-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.05.18
-- Description:	AI
-- =============================================
CREATE PROCEDURE [dbo].[SP_SEL_STORICO_REGISTRO_AIUTI]
	@codice_fiscale varchar(16)
AS
BEGIN
	
	SET NOCOUNT ON;

declare @chiave_ausca int

-- Se il cf esiste su AUSCA va avanti altrimenti termina
set @chiave_ausca = (select ausca_codice_pk from tb_ausca_sog_contr_az where ausca_codice_fiscale = @codice_fiscale) 
IF ( @chiave_ausca is not null and @chiave_ausca <> 0)
 BEGIN
	--select	0, [ausca_RA_impresa_autonoma], 
	--		[ausca_RA_impresa_associata], 
	--		[ausca_RA_impresa_collegata],
	--		[ausca_RA_data_fine_esercizio],
	--		[ausca_RA_dimensione_aziendale],
	--		[ausca_RA_codice_operatore], 
	--		[ausca_RA_codice_fiscale_delegato],
	--		[ausca_RA_data_modifica],
	--		aurac_codice_fiscale_impresa_collegata
	--from tb_ausca_sog_contr_az
	--left outer join tb_aurac_registro_aiuti_cf on ausca_codice_pk = aurac_ausca_codice_pk
	--where ausca_codice_fiscale = @codice_fiscale
	--UNION ALL
	select ausra_codice_pk, [ausra_RA_impresa_autonoma]
      ,[ausra_RA_impresa_associata]
      ,[ausra_RA_impresa_collegata]
      ,[ausra_RA_data_fine_esercizio]
--	  ,ausra_RA_dimensione_aziendale
	  ,case		 when [ausra_RA_dimensione_aziendale] = '01' then 'MI'
				 when [ausra_RA_dimensione_aziendale] = '02' then 'PI'
				 when [ausra_RA_dimensione_aziendale] = '03' then 'ME'
				 when [ausra_RA_dimensione_aziendale] = '04' then 'GR'
		end as ausra_RA_dimensione_aziendale
      ,[ausra_codice_operatore]
      ,[ausra_codice_fiscale_delegato]
      ,[ausra_data_modifica]
	  ,STUFF( (SELECT '|' + ausrc_codice_fiscale_impresa_collegata FROM dbo.tb_ausrc_storico_registro_aiuti_cf B WHERE A.ausra_codice_pk = B.ausrc_ausra_codice_pk ORDER BY ausrc_codice_fiscale_impresa_collegata FOR XML PATH('')), 1, 1, '') as ausrc_codice_fiscale_impresa_collegata
	  --,'DMPPTR61H18H501L' + ' <br/> ' + '00000000026' + ' <br/> ' + 'PROVAPROVA' as ausrc_codice_fiscale_impresa_collegata
	  from [dbo].[tb_ausra_storico_registro_aiuti] A
	  -- left outer join [dbo].[tb_ausrc_storico_registro_aiuti_cf]
	  --on ausra_codice_pk = ausrc_ausra_codice_pk 
	  where ausra_ausca_codice_pk = @chiave_ausca
	  order by ausra_codice_pk desc

	--select ausra_codice_pk, [ausra_RA_impresa_autonoma]
 --     ,[ausra_RA_impresa_associata]
 --     ,[ausra_RA_impresa_collegata]
 --     ,[ausra_RA_data_fine_esercizio]
 --     ,[ausra_RA_dimensione_aziendale]
 --     ,[ausra_codice_operatore]
 --     ,[ausra_codice_fiscale_delegato]
 --     ,[ausra_data_modifica]
	--  ,[ausrc_codice_fiscale_impresa_collegata]
	--  from [dbo].[tb_ausra_storico_registro_aiuti] left outer join [dbo].[tb_ausrc_storico_registro_aiuti_cf]
	--  on ausra_codice_pk = ausrc_ausra_codice_pk 
	--  where ausra_ausca_codice_pk = @chiave_ausca
	--  order by ausra_codice_pk desc
 END
 ELSE
-- non esiste cf su ausca  la stored ritorna False
RETURN 1

END

