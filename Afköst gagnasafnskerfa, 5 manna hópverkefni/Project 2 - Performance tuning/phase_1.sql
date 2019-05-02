--Change data types

/*
   25 February 201912:04:56
   User: 
   Server: LAPTOP-3CR7UF11
   Database: innheimta_modified
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_greidandi
	(
	id int NOT NULL,
	vidskiptamadur_id int NOT NULL,
	heimilisfang_id int NULL,
	samningur_id int NOT NULL,
	skilabod_a_greidslusedla varchar(500) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_greidandi SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.greidandi)
	 EXEC('INSERT INTO dbo.Tmp_greidandi (id, vidskiptamadur_id, heimilisfang_id, samningur_id, skilabod_a_greidslusedla)
		SELECT CONVERT(int, id), CONVERT(int, vidskiptamadur_id), CONVERT(int, heimilisfang_id), samningur_id, CONVERT(varchar(500), skilabod_a_greidslusedla) FROM dbo.greidandi WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.greidandi
GO
EXECUTE sp_rename N'dbo.Tmp_greidandi', N'greidandi', 'OBJECT' 
GO
ALTER TABLE dbo.greidandi ADD CONSTRAINT
	PK__greidand__3213E83E79CBBBA3 PRIMARY KEY NONCLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20130218-133615] ON dbo.greidandi
	(
	vidskiptamadur_id,
	samningur_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
COMMIT
select Has_Perms_By_Name(N'dbo.greidandi', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.greidandi', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.greidandi', 'Object', 'CONTROL') as Contr_Per 

/*
   25 February 201910:59:41
   User: 
   Server: LAPTOP-3CR7UF11
   Database: innheimta_modified
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_hreyfing
	(
	id int NOT NULL IDENTITY (1, 1),
	krafa_id int NOT NULL,
	tegund_hreyfingar_id tinyint NOT NULL,
	hreyfingardagur date NOT NULL,
	eindagi date NOT NULL,
	innlausnarbanki smallint NULL,
	nidurfellingardagur date NOT NULL,
	upphaed numeric(9, 2) NOT NULL,
	tilvisun char(16) NOT NULL,
	sedilnumer varchar(7) NULL,
	vidskiptanumer varchar(16) NULL,
	tilkynningar_og_greidslugjald_1 smallint NULL,
	tilkynningar_og_greidslugjald_2 smallint NULL,
	vanskilagjaldskodi_id tinyint NULL,
	fyrra_vanskilagjald_dagafjoldi tinyint NULL,
	fyrra_vanskilagjald numeric(9, 2) NULL,
	seinna_vanskilagjald_dagafjoldi tinyint NULL,
	seinna_vanskilagjald numeric(9, 2) NULL,
	annar_kostnadur smallint NULL,
	annar_vanskilakostnadur smallint NULL,
	drattarvaxtastofnkodi_id char(1) NULL,
	drattarvaxtaregla_id char(1) NULL,
	drattarvaxtaprosenta tinyint NULL,
	mynt_id char(3) NULL,
	gengiskodi_id char(1) NULL,
	greidslukodi_id char(1) NULL,
	afslattarkodi_id tinyint NULL,
	fyrri_afslattur_dagafjoldi tinyint NULL,
	fyrri_afslattur numeric(9, 2) NULL,
	seinni_afslattur_dagafjoldi tinyint NULL,
	seinni_afslattur numeric(9, 2) NULL,
	url varchar(60) NULL,
	nafn nvarchar(32) NULL,
	berist_til nvarchar(32) NULL,
	heimilisfang varchar(32) NULL,
	sveitarfelag smallint NULL,
	nafn_krofuhafa varchar(32) NULL,
	heimilisfang_krofuhafa varchar(32) NULL,
	sveitarfelag_krofuhafa smallint NULL,
	simanumer_krofuhafa char(7) NULL,
	athugasemd_1 char(40) NULL,
	athugasemd_2 char(60) NULL,
	vaxtadagsetning date NULL,
	innborgunardagur date NULL,
	innborgunarupphaed numeric(9, 2) NULL,
	greiddir_drattarvextir numeric(9, 2) NULL,
	greidd_upphaed numeric(9, 2) NULL,
	greiddur_fjarmagnstekjuskattur numeric(9, 2) NULL,
	veittur_afslattur numeric(9, 2) NULL,
	greitt_tilkynningargjald numeric(9, 2) NULL,
	greitt_vanskilagjald numeric(9, 2) NULL,
	greiddur_annar_vanskilakostnadur numeric(9, 2) NULL,
	greiddur_annar_kostnadur numeric(9, 2) NULL,
	ogreitt_tilkynningjargjald numeric(9, 2) NULL,
	bokunardagur date NULL,
	greidslugengi numeric(9, 6) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_hreyfing SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_hreyfing ON
GO
IF EXISTS(SELECT * FROM dbo.hreyfing)
	 EXEC('INSERT INTO dbo.Tmp_hreyfing (id, krafa_id, tegund_hreyfingar_id, hreyfingardagur, eindagi, innlausnarbanki, nidurfellingardagur, upphaed, tilvisun, sedilnumer, vidskiptanumer, tilkynningar_og_greidslugjald_1, tilkynningar_og_greidslugjald_2, vanskilagjaldskodi_id, fyrra_vanskilagjald_dagafjoldi, fyrra_vanskilagjald, seinna_vanskilagjald_dagafjoldi, seinna_vanskilagjald, annar_kostnadur, annar_vanskilakostnadur, drattarvaxtastofnkodi_id, drattarvaxtaregla_id, drattarvaxtaprosenta, mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id, fyrri_afslattur_dagafjoldi, fyrri_afslattur, seinni_afslattur_dagafjoldi, seinni_afslattur, url, nafn, berist_til, heimilisfang, sveitarfelag, nafn_krofuhafa, heimilisfang_krofuhafa, sveitarfelag_krofuhafa, simanumer_krofuhafa, athugasemd_1, athugasemd_2, vaxtadagsetning, innborgunardagur, innborgunarupphaed, greiddir_drattarvextir, greidd_upphaed, greiddur_fjarmagnstekjuskattur, veittur_afslattur, greitt_tilkynningargjald, greitt_vanskilagjald, greiddur_annar_vanskilakostnadur, greiddur_annar_kostnadur, ogreitt_tilkynningjargjald, bokunardagur, greidslugengi)
		SELECT CONVERT(int, id), CONVERT(int, krafa_id), CONVERT(tinyint, tegund_hreyfingar_id), hreyfingardagur, eindagi, CONVERT(smallint, innlausnarbanki), nidurfellingardagur, CONVERT(numeric(9, 2), upphaed), CONVERT(char(16), tilvisun), CONVERT(varchar(7), sedilnumer), CONVERT(varchar(16), vidskiptanumer), CONVERT(smallint, tilkynningar_og_greidslugjald_1), CONVERT(smallint, tilkynningar_og_greidslugjald_2), CONVERT(tinyint, vanskilagjaldskodi_id), CONVERT(tinyint, fyrra_vanskilagjald_dagafjoldi), CONVERT(numeric(9, 2), fyrra_vanskilagjald), CONVERT(tinyint, seinna_vanskilagjald_dagafjoldi), CONVERT(numeric(9, 2), seinna_vanskilagjald), CONVERT(smallint, annar_kostnadur), CONVERT(smallint, annar_vanskilakostnadur), CONVERT(char(1), drattarvaxtastofnkodi_id), CONVERT(char(1), drattarvaxtaregla_id), CONVERT(tinyint, drattarvaxtaprosenta), CONVERT(char(3), mynt_id), CONVERT(char(1), gengiskodi_id), CONVERT(char(1), greidslukodi_id), CONVERT(tinyint, afslattarkodi_id), CONVERT(tinyint, fyrri_afslattur_dagafjoldi), CONVERT(numeric(9, 2), fyrri_afslattur), CONVERT(tinyint, seinni_afslattur_dagafjoldi), CONVERT(numeric(9, 2), seinni_afslattur), CONVERT(varchar(60), url), CONVERT(nvarchar(32), nafn), CONVERT(nvarchar(32), berist_til), CONVERT(varchar(32), heimilisfang), CONVERT(smallint, sveitarfelag), CONVERT(varchar(32), nafn_krofuhafa), CONVERT(varchar(32), heimilisfang_krofuhafa), CONVERT(smallint, sveitarfelag_krofuhafa), CONVERT(char(7), simanumer_krofuhafa), CONVERT(char(40), athugasemd_1), CONVERT(char(60), athugasemd_2), vaxtadagsetning, innborgunardagur, CONVERT(numeric(9, 2), innborgunarupphaed), CONVERT(numeric(9, 2), greiddir_drattarvextir), CONVERT(numeric(9, 2), greidd_upphaed), CONVERT(numeric(9, 2), greiddur_fjarmagnstekjuskattur), CONVERT(numeric(9, 2), veittur_afslattur), CONVERT(numeric(9, 2), greitt_tilkynningargjald), CONVERT(numeric(9, 2), greitt_vanskilagjald), CONVERT(numeric(9, 2), greiddur_annar_vanskilakostnadur), CONVERT(numeric(9, 2), greiddur_annar_kostnadur), CONVERT(numeric(9, 2), ogreitt_tilkynningjargjald), bokunardagur, CONVERT(numeric(9, 6), greidslugengi) FROM dbo.hreyfing WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_hreyfing OFF
GO
DROP TABLE dbo.hreyfing
GO
EXECUTE sp_rename N'dbo.Tmp_hreyfing', N'hreyfing', 'OBJECT' 
GO
ALTER TABLE dbo.hreyfing ADD CONSTRAINT
	hreyfing_pk PRIMARY KEY NONCLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.hreyfing', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.hreyfing', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.hreyfing', 'Object', 'CONTROL') as Contr_Per 

/*
   26 February 201910:40:56
   User: 
   Server: LAPTOP-3CR7UF11
   Database: innheimta_modified
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_krafa
	(
	id int NOT NULL IDENTITY (1, 1),
	samningur_id int NOT NULL,
	astand_id tinyint NOT NULL,
	greidandi_id int NOT NULL,
	banki smallint NOT NULL,
	hofudbok tinyint NOT NULL,
	numer int NOT NULL,
	gjalddagi date NOT NULL,
	eindagi date NOT NULL,
	nidurfellingardagur date NOT NULL,
	upphaed numeric(18, 2) NOT NULL,
	tilvisun char(16) NOT NULL,
	sedilnumer varchar(7) NULL,
	vidskiptanumer nvarchar(16) NULL,
	tilkynningar_og_greidslugjald_1 smallint NULL,
	tilkynningar_og_greidslugjald_2 smallint NULL,
	vanskilagjaldskodi_id tinyint NULL,
	fyrra_vanskilagjald_dagafjoldi tinyint NULL,
	fyrra_vanskilagjald numeric(9, 2) NULL,
	seinna_vanskilagjald_dagafjoldi tinyint NULL,
	seinna_vanskilagjald numeric(9, 2) NULL,
	annar_kostnadur smallint NULL,
	annar_vanskilakostnadur smallint NULL,
	drattarvaxtastofnkodi_id tinyint NULL,
	drattarvaxtaregla_id char(1) NULL,
	drattarvaxtaprosenta tinyint NULL,
	mynt_id char(3) NULL,
	gengiskodi_id char(1) NULL,
	greidslukodi_id tinyint NULL,
	afslattarkodi_id tinyint NULL,
	fyrri_afslattur_dagafjoldi tinyint NULL,
	fyrri_afslattur numeric(9, 2) NULL,
	seinni_afslattur_dagafjoldi tinyint NULL,
	seinni_afslattur numeric(9, 2) NULL,
	url varchar(200) NULL,
	nafn varchar(32) NULL,
	berist_til varchar(32) NULL,
	heimilisfang varchar(32) NULL,
	sveitarfelag smallint NULL,
	nafn_krofuhafa varchar(32) NULL,
	heimilisfang_krofuhafa varchar(32) NULL,
	sveitarfelag_krofuhafa smallint NULL,
	simanumer_krofuhafa char(7) NULL,
	athugasemd_1 varchar(80) NULL,
	athugasemd_2 char(80) NULL,
	stada_tilkynningar_og_greidslugjald_1 smallint NOT NULL,
	stada_tilkynningar_og_greidslugjald_2 smallint NOT NULL,
	stada_fyrra_vanskilagjald smallint NOT NULL,
	stada_seinna_vanskilagjald smallint NOT NULL,
	stada_annar_kostnadur smallint NOT NULL,
	stada_annar_vanskilakostnadur smallint NOT NULL,
	stada_drattarvextir int NOT NULL,
	stada_afslattur smallint NOT NULL,
	upphaed_til_greidslu int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_krafa SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_krafa ON
GO
IF EXISTS(SELECT * FROM dbo.krafa)
	 EXEC('INSERT INTO dbo.Tmp_krafa (id, samningur_id, astand_id, greidandi_id, banki, hofudbok, numer, gjalddagi, eindagi, nidurfellingardagur, upphaed, tilvisun, sedilnumer, vidskiptanumer, tilkynningar_og_greidslugjald_1, tilkynningar_og_greidslugjald_2, vanskilagjaldskodi_id, fyrra_vanskilagjald_dagafjoldi, fyrra_vanskilagjald, seinna_vanskilagjald_dagafjoldi, seinna_vanskilagjald, annar_kostnadur, annar_vanskilakostnadur, drattarvaxtastofnkodi_id, drattarvaxtaregla_id, drattarvaxtaprosenta, mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id, fyrri_afslattur_dagafjoldi, fyrri_afslattur, seinni_afslattur_dagafjoldi, seinni_afslattur, url, nafn, berist_til, heimilisfang, sveitarfelag, nafn_krofuhafa, heimilisfang_krofuhafa, sveitarfelag_krofuhafa, simanumer_krofuhafa, athugasemd_1, athugasemd_2, stada_tilkynningar_og_greidslugjald_1, stada_tilkynningar_og_greidslugjald_2, stada_fyrra_vanskilagjald, stada_seinna_vanskilagjald, stada_annar_kostnadur, stada_annar_vanskilakostnadur, stada_drattarvextir, stada_afslattur, upphaed_til_greidslu)
		SELECT id, samningur_id, astand_id, greidandi_id, banki, hofudbok, numer, gjalddagi, eindagi, nidurfellingardagur, upphaed, tilvisun, sedilnumer, vidskiptanumer, tilkynningar_og_greidslugjald_1, tilkynningar_og_greidslugjald_2, vanskilagjaldskodi_id, fyrra_vanskilagjald_dagafjoldi, fyrra_vanskilagjald, seinna_vanskilagjald_dagafjoldi, seinna_vanskilagjald, annar_kostnadur, annar_vanskilakostnadur, drattarvaxtastofnkodi_id, drattarvaxtaregla_id, drattarvaxtaprosenta, mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id, fyrri_afslattur_dagafjoldi, fyrri_afslattur, seinni_afslattur_dagafjoldi, seinni_afslattur, url, nafn, berist_til, heimilisfang, sveitarfelag, nafn_krofuhafa, heimilisfang_krofuhafa, sveitarfelag_krofuhafa, simanumer_krofuhafa, CONVERT(varchar(80), athugasemd_1), athugasemd_2, stada_tilkynningar_og_greidslugjald_1, stada_tilkynningar_og_greidslugjald_2, stada_fyrra_vanskilagjald, stada_seinna_vanskilagjald, stada_annar_kostnadur, stada_annar_vanskilakostnadur, stada_drattarvextir, stada_afslattur, upphaed_til_greidslu FROM dbo.krafa WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_krafa OFF
GO
DROP TABLE dbo.krafa
GO
EXECUTE sp_rename N'dbo.Tmp_krafa', N'krafa', 'OBJECT' 
GO
ALTER TABLE dbo.krafa ADD CONSTRAINT
	PK_Krafa PRIMARY KEY NONCLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.krafa', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.krafa', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.krafa', 'Object', 'CONTROL') as Contr_Per 



--Create indices

CREATE CLUSTERED INDEX ClusteredIndexHreyfing 
    ON hreyfing (krafa_id);

CREATE NONCLUSTERED INDEX [_dta_index_krafa] ON [dbo].[krafa]
(
	[astand_id] ASC,
	[annar_vanskilakostnadur] ASC,
	[fyrri_afslattur] ASC,
	[seinni_afslattur] ASC,
	[annar_kostnadur] ASC,
	[id] ASC,
	[samningur_id] ASC,
	[banki] ASC
)
INCLUDE ( [upphaed_til_greidslu]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY] 

CREATE NONCLUSTERED INDEX [_dta_index_hreyfing] ON [dbo].[hreyfing]
(
	[tegund_hreyfingar_id] ASC,
	[bokunardagur] ASC,
	[krafa_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

CREATE CLUSTERED INDEX krafa_clustered 
	ON krafa (gjalddagi);

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20190319-141518] ON [dbo].[vidskiptamadur]
(
	[id] ASC,
	[kennitala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20190319-142245] ON [dbo].[greidandi]
(
	[id] ASC,
	[vidskiptamadur_id] ASC,
	[skilabod_a_greidslusedla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
