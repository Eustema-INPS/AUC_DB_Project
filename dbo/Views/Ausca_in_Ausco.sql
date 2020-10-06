CREATE view [dbo].[Ausca_in_Ausco] as 
( SELECT  ausca_codice_pk ,ausco_codice_pk,tb_ausca_sog_contr_az.ausca_codice_fiscale,tb_ausco_sog_contr_col.ausco_codice_fiscale
  FROM tb_ausca_sog_contr_az INNER JOIN tb_ausco_sog_contr_col ON 
       tb_ausca_sog_contr_az.ausca_codice_fiscale = tb_ausco_sog_contr_col.ausco_codice_fiscale
  WHERE (LEN(LTRIM(RTRIM(tb_ausca_sog_contr_az.ausca_codice_fiscale))) = 16))
