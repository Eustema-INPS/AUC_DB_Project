


-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.05.18
-- Description:	AI
-- =============================================
CREATE PROCEDURE [dbo].[SP_SEL_REGISTRO_AIUTI]
	@codice_fiscale varchar(16)
AS
BEGIN
	
	SET NOCOUNT ON;

declare @chiave_ausca int

-- Se il cf esiste su AUSCA va avanti altrimenti termina
set @chiave_ausca = (select ausca_codice_pk from tb_ausca_sog_contr_az where ausca_codice_fiscale = @codice_fiscale) 
IF ( @chiave_ausca is not null and @chiave_ausca <> 0)
 BEGIN
	select	[ausca_RA_impresa_autonoma], 
			[ausca_RA_impresa_associata], 
			[ausca_RA_impresa_collegata],
			[ausca_RA_data_fine_esercizio],
			case when [ausca_RA_dimensione_aziendale] = '01' then 'MI'
				 when [ausca_RA_dimensione_aziendale] = '02' then 'PI'
				 when [ausca_RA_dimensione_aziendale] = '03' then 'ME'
				 when [ausca_RA_dimensione_aziendale] = '04' then 'GR'
			end as ausca_RA_dimensione_aziendale,
			[ausca_RA_codice_operatore], 
			[ausca_RA_codice_fiscale_delegato],
			[ausca_RA_data_modifica],
			aurac_codice_fiscale_impresa_collegata,
			aurac_codice_pk
	from tb_ausca_sog_contr_az
	left outer join tb_aurac_registro_aiuti_cf on ausca_codice_pk = aurac_ausca_codice_pk
	where ausca_codice_fiscale = @codice_fiscale
 END
 ELSE
-- non esiste cf su ausca  la stored ritorna False
RETURN 1

END

