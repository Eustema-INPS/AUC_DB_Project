-- =============================================
-- Author:		Maurizio Picone
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Data:        2013-08-06
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoUnitaLocali]
	@auulo_ausca_codice_pk int
AS
BEGIN
   SET NOCOUNT ON;

   SELECT 
       [auulo_codice_pk], 
       
        CASE
        WHEN (auulo_sigla_prov IS NULL  or auulo_sigla_prov='') and  Auulo_nrea_ul IS not NULL THEN Auulo_nrea_ul
        when (Auulo_nrea_ul IS NULL  or Auulo_nrea_ul='') and  auulo_sigla_prov is not null then auulo_sigla_prov
        ELSE auulo_sigla_prov + ' - ' + Auulo_nrea_ul
        END AS DB_pr_rea,
        
       auulo_sigla_prov,
       Auulo_nrea_ul,
       convert(varchar(10),auulo_data_apertura,103) as auulo_data_apertura ,
       auulo_flag_cessazione,
       [auulo_ausca_codice_pk]
      ,[auulo_Progressivo_localizz]
      ,[auulo_Tipo_localizz]
      ,[auulo_descr_tipo_localizz]  
      ,[auulo_denominazione]
      ,[auulo_comune]
        
  FROM [dbo].[tb_auulo_unita_locale]
  
  WHERE [tb_auulo_unita_locale].auulo_ausca_codice_pk = @auulo_ausca_codice_pk
  --order by [auulo_comune],[auulo_Progressivo_localizz]
  order by auulo_sigla_prov,convert(int,[auulo_Progressivo_localizz])

  IF @@ERROR > 0 RETURN 100
  ELSE RETURN 0
END

