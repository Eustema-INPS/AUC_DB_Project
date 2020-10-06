CREATE TABLE [dbo].[TB_AUDEN_DENUNCE_MATRICE] (
    [auden_codice_pk]              BIGINT          IDENTITY (1, 1) NOT NULL,
    [Lotto]                        BIGINT          NULL,
    [DataRicezione]                DATE            NULL,
    [TotaleAtterrateAccoglienza]   BIGINT          NULL,
    [TotaleAtterrateUniemensPosPA] BIGINT          NULL,
    [TotalePrelevateSIN]           BIGINT          NULL,
    [Diff_acc_Uniem]               BIGINT          NULL,
    [Diff_acc_Prelev]              BIGINT          NULL,
    [Media_acc_Uniem]              DECIMAL (10, 2) NULL,
    [Media_acc_Prelev]             DECIMAL (10, 2) NULL,
    [Errore_acc_Uniem]             DECIMAL (10, 6) NULL,
    [Errore_acc_Prelev]            DECIMAL (10, 6) NULL,
    [TotaleIscritti]               BIGINT          NULL,
    [TotalePrelevabili]            BIGINT          NULL,
    [NON_TotalePrelevabili]        BIGINT          NULL
);

