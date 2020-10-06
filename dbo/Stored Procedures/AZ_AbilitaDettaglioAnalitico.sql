
-- =============================================
-- Creata da: Letizia
-- Data:		04.04.2013
-- Descrizione:	Abilita il pulsante Dettaglio Anagrafica nella scheda azienda
-- Autore:		Raffaele
-- Data:		23 maggio 2014
-- Modifica:    Nell'ultima condizione è stato sostituito AND con OR
-- =============================================
CREATE PROCEDURE [dbo].[AZ_AbilitaDettaglioAnalitico] 
	@codiceAzienda int
AS
BEGIN

	SET NOCOUNT ON;

SELECT     ausca_codice_pk, ausca_soggetto_certificato,tb_autis_tipo_sog_col_ct.autis_codice_carica,
tb_ausca_sog_contr_az.ausca_aungi_codice_pk,tb_autis_tipo_sog_col_ct.autis_codice_carica,
tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk,
tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk
FROM         tb_ausca_sog_contr_az left  join 
tb_aurss_rel_sog_sog
on tb_aurss_rel_sog_sog.aurss_ausca_codice_pk=tb_ausca_sog_contr_az.ausca_codice_pk
left join tb_autis_tipo_sog_col_ct
on tb_autis_tipo_sog_col_ct.autis_codice_pk=tb_aurss_rel_sog_sog.aurss_autis_codice_pk
where  ausca_codice_pk = @codiceAzienda and
(
ausca_soggetto_certificato='S'
or
(ausca_soggetto_certificato='N'  and 
(tb_ausca_sog_contr_az.ausca_aungi_codice_pk=58 or tb_ausca_sog_contr_az.ausca_aungi_codice_pk=10 
or tb_ausca_sog_contr_az.ausca_aungi_codice_pk=57 or tb_ausca_sog_contr_az.ausca_aungi_codice_pk=27))
or
--(ausca_soggetto_certificato='N' and 
--tb_ausca_sog_contr_az.ausca_aungi_codice_pk is null 
--and tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk is not null 
--and tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk is not null)
--)
(ausca_soggetto_certificato='N' and 
tb_ausca_sog_contr_az.ausca_aungi_codice_pk is null 
and (tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk is not null 
or tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk is not null))
)
END






