CREATE VIEW [dbo].[VW_AN_ENTINTGIURCAS_RAPPR] as
select   
Soc.Bdso_Codfisc_Vb, 
Soc.Bdso_Progress_Vb, 
Soc.Bdso_Denom_Vb,
soc.bdso_dataini_vb as data_inizio,
soc.bdso_datafin_vb as data_fine,
--IIF(SOC.BDSO_DATAFIN_VB is null,'SI','NO') as vigente,
nt.bdng_descriz_vb ,
cl.ancng_descr_classpg,
cs1.BDCS_DESCRIZ_VB,
mm.anmpg_mail_persgiu,
bdin.bdin_toponoma_vb+' '+bdin.bdin_descriz_vb+' '+bs.bdbs_ind_nciv_int_scala_vb as indirizzo,
provincia.BDLC_DESCRIZ_VB provincia,
provincia.BDLC_SIGLA_VB sigla,
comune.BDLC_DESCRIZ_VB comune ,
IIF( rap.bdrl_codfisc_pf  is null,' ',rap.bdrl_codfisc_pf ) as rappresentante

from  
 BDSO_SOCIETA_CL soc  LEFT OUTER JOIN  bdrl_rapleg_cl rap  ON rap.bdrl_codfisc_pg  = soc.BDSO_CODFISC_VB, 
 bdbs_indasede_sin  bs,  
 bdsd_sedesoc_cl  sd,
 bdng_natgiur_ct  nt,
  tb_ancng_classng_ct cl,
  BDZE_ISCRIZEN_CL cs,
  bdcs_cassa_cl cs1,
  tb_anmpg_mailpgiu_cl mm,
   bdin_indiriz_sin bdin,
  BDLC_LOCALITA_CL comune,  
   bdcp_cap_cl cap , 
   BDLC_LOCALITA_CL provincia   
WHERE   
 bs.bdbs_bdsd_edi_vr = sd.bdsd_id_va and  
 sd.BDSD_BDSO_EDI_VR = soc.BDSO_ID_VA and  
 sd.BDSD_BDSE_APP_VR= 1 and -- SEDE CENTRALE
SOC.BDSO_DENOM_VB not like '%CANCELLATA%' 
and SOC.BDSO_DENOM_VB not like '%CANCELLATO%' and
nt.BDNG_ID_VA = soc.BDSO_BDNG_EDI_VR and
nt.bdng_ancng_cod_class = cl.ancng_cod_class_pk and
bs.BDBS_DATAFIN_VB is null and
cs.BDZE_BDSO_EDI_VR = soc.BDSO_ID_VA and
cs.BDZE_DATAFINE_VB is null and
cs1.BDCS_ID_VA = cs.BDZE_BDCS_EDI_VR
and mm.ANMPG_BDSO_ID_VA_PK = soc.BDSO_ID_VA and
mm.anmpg_flag_pec = 'S' and
mm.anmpg_data_fine='9999-12-31' and --to_date('31129999','ddmmyyyy')  and
bdin.bdin_id_va = bs.bdbs_bdin_edi_vr and
bdin.Bdin_Bdlc_App_Vr = comune.BDLC_ID_VA AND   
bdin.BDIN_BDCP_ERI_VR = cap.BDCP_ID_VA and
provincia.Bdlc_Id_Va = comune.Bdlc_Bdlc_App_Vr --and
--soc.bdso_codfisc_vb = '00034670943'
 
union

select  
Soc.Bdso_Codfisc_Vb, 
Soc.Bdso_Progress_Vb, 
--soc.bdso_id_va,
Soc.Bdso_Denom_Vb,
soc.bdso_dataini_vb as data_inizio,
soc.bdso_datafin_vb as data_fine,
--IIF(SOC.BDSO_DATAFIN_VB is null,'SI','NO') as vigente,
nt.bdng_descriz_vb ,
cl.ancng_descr_classpg,
cs1.BDCS_DESCRIZ_VB,
null anmpg_mail_persgiu ,
 bdin.bdin_toponoma_vb+' '+bdin.bdin_descriz_vb+' '+bs.bdbs_ind_nciv_int_scala_vb as indirizzo,
 provincia.BDLC_DESCRIZ_VB provincia,
 provincia.BDLC_SIGLA_VB sigla,
 comune.BDLC_DESCRIZ_VB comune ,
IIF( rap.bdrl_codfisc_pf  is null,' ',rap.bdrl_codfisc_pf ) as rappresentante
from  
 BDSO_SOCIETA_CL soc  LEFT OUTER JOIN  bdrl_rapleg_cl rap  ON rap.bdrl_codfisc_pg  = soc.BDSO_CODFISC_VB,
 bdbs_indasede_sin  bs,  
 bdsd_sedesoc_cl  sd,
 bdng_natgiur_ct  nt,
 tb_ancng_classng_ct cl,
  BDZE_ISCRIZEN_CL cs,
  bdcs_cassa_cl cs1,
 bdin_indiriz_sin bdin,
 BDLC_LOCALITA_CL comune,  
 bdcp_cap_cl cap , 
 BDLC_LOCALITA_CL provincia    
WHERE   
 bs.bdbs_bdsd_edi_vr = sd.bdsd_id_va and  
 sd.BDSD_BDSO_EDI_VR = soc.BDSO_ID_VA and  
 sd.BDSD_BDSE_APP_VR= 1 and -- SEDE CENTRALE
SOC.BDSO_DENOM_VB not like '%CANCELLATA%' 
and SOC.BDSO_DENOM_VB not like '%CANCELLATO%' and
nt.BDNG_ID_VA = soc.BDSO_BDNG_EDI_VR and
nt.bdng_ancng_cod_class = cl.ancng_cod_class_pk and
bs.BDBS_DATAFIN_VB is null and
cs.BDZE_BDSO_EDI_VR = soc.BDSO_ID_VA and
cs.BDZE_DATAFINE_VB is null and
cs1.BDCS_ID_VA = cs.BDZE_BDCS_EDI_VR
 and not exists ( select 1 from tb_anmpg_mailpgiu_cl  mm where 
				 mm.anmpg_bdso_id_va_pk = soc.BDSO_ID_VA and
				 mm.anmpg_flag_pec = 'S' and
				 mm.anmpg_data_fine= '9999-12-31' )  and
 bdin.bdin_id_va = bs.bdbs_bdin_edi_vr and
 bdin.Bdin_Bdlc_App_Vr = comune.BDLC_ID_VA AND   
 bdin.BDIN_BDCP_ERI_VR = cap.BDCP_ID_VA and
 provincia.Bdlc_Id_Va = comune.Bdlc_Bdlc_App_Vr  ;
 --and
--soc.bdso_codfisc_vb = '00034670943'
-- order by 1,2;
