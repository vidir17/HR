CREATE TABLE dbo.hreyfingMain
(
	id int not null,
	krafa_id int not null,
	tegund_hreyfingar_id tinyint not null,
	bokunardagur date null,
	innborgunardagur date null

	constraint PK_hreyfingMain
	primary key nonclustered(id)
)
go

CREATE TABLE dbo.hreyfingDetails
(
	id int not null,
	hreyfingardagur date not null,
	eindagi date not null,
	innlausnarbanki smallint null,
	nidurfellingardagur date not null,
	upphaed numeric(9,2) not null,
	tilvisun char(16) not null,
	sedilnumer varchar(7) null,
	vidskiptanumer varchar(16) null,
	tilkynningar_og_greidslugjald_1 smallint null,
	tilkynningar_og_greidslugjald_2 smallint null,
	vanskilagjaldskodi_id tinyint null,
	fyrra_vanskilagjald_dagafjoldi tinyint null,
	fyrra_vanskilagjald numeric(9,2) null,
	seinna_vanskilagjald_dagafjoldi tinyint null,
	seinna_vanskilagjald numeric(9,2) null,
	annar_kostnadur smallint null,
	annar_vanskilakostnadur smallint null,
	drattarvaxtastofnkodi_id char(1) null,
	drattarvaxtaregla_id char(1) null,
	drattarvaxtaprosenta tinyint null,
	mynt_id char(3) null,
	gengiskodi_id char(1) null,
	greidslukodi_id char(1) null,
	afslattarkodi_id tinyint null,
	fyrri_afslattur_dagafjoldi tinyint null,
	fyrri_afslattur numeric(9,2) null,
	seinni_afslattur_dagafjoldi tinyint null,
	seinni_afslattur numeric(9,2) null,
	url varchar(60) null,
	nafn nvarchar(32) null,
	berist_til nvarchar(32) null,
	heimilisfang varchar(32) null,
	sveitarfelag smallint null,
	nafn_krofuhafa varchar(32) null,
	heimilisfang_krofuhafa varchar(32) null,
	sveitarfelag_krofuhafa smallint null,
	simanumer_krofuhafa char(7) null,
	athugasemd_1 char(40) null,
	athugasemd_2 char(60) null,
	vaxtadagsetning date null,
	innborgunarupphaed numeric(9,2) null,
	greiddir_drattarvextir numeric(9,2) null,
	greidd_upphaed numeric(9,2) null,
	greiddur_fjarmagnstekjuskattur numeric(9,2) null,
	veittur_afslattur numeric(9,2) null,
	greitt_tilkynningargjald numeric(9,2) null,
	greitt_vanskilagjald numeric(9,2) null,
	greiddur_annar_vanskilakostnadur numeric(9,2) null,
	greiddur_annar_kostnadur numeric(9,2) null,
	ogreitt_tilkynningargjald numeric(9,2) null,
	greidslugengi numeric(9,6) null

	constraint PK_hreyfingDetails
	primary key clustered(id),

	constraint FK_hreyfingDetails_hreyfingMain
	foreign key(id)
	references dbo.hreyfingMain(id)
	on update cascade
	on delete cascade
)
go

begin tran
	insert into dbo.hreyfingMain(id, krafa_id, tegund_hreyfingar_id, bokunardagur, innborgunardagur)
		select id, krafa_id, tegund_hreyfingar_id, bokunardagur, innborgunardagur
		from dbo.hreyfing

	insert into dbo.hreyfingDetails(id,
			hreyfingardagur, eindagi, innlausnarbanki, nidurfellingardagur, upphaed, tilvisun, sedilnumer,
			vidskiptanumer, tilkynningar_og_greidslugjald_1, tilkynningar_og_greidslugjald_2, vanskilagjaldskodi_id,
			fyrra_vanskilagjald_dagafjoldi, fyrra_vanskilagjald, seinna_vanskilagjald_dagafjoldi, seinna_vanskilagjald,
			annar_kostnadur, annar_vanskilakostnadur, drattarvaxtastofnkodi_id, drattarvaxtaregla_id, drattarvaxtaprosenta,
			mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id, fyrri_afslattur_dagafjoldi, fyrri_afslattur,
			seinni_afslattur_dagafjoldi, seinni_afslattur, url, nafn, berist_til, heimilisfang, sveitarfelag, nafn_krofuhafa,
			heimilisfang_krofuhafa, sveitarfelag_krofuhafa, simanumer_krofuhafa, athugasemd_1, athugasemd_2,
			vaxtadagsetning, innborgunarupphaed, greiddir_drattarvextir, greidd_upphaed,
			greiddur_fjarmagnstekjuskattur, veittur_afslattur, greitt_tilkynningargjald, greitt_vanskilagjald,
			greiddur_annar_vanskilakostnadur, greiddur_annar_kostnadur, ogreitt_tilkynningargjald, greidslugengi)
		select id, hreyfingardagur, eindagi, innlausnarbanki, nidurfellingardagur, upphaed, tilvisun, sedilnumer,
			vidskiptanumer, tilkynningar_og_greidslugjald_1, tilkynningar_og_greidslugjald_2, vanskilagjaldskodi_id,
			fyrra_vanskilagjald_dagafjoldi, fyrra_vanskilagjald, seinna_vanskilagjald_dagafjoldi, seinna_vanskilagjald,
			annar_kostnadur, annar_vanskilakostnadur, drattarvaxtastofnkodi_id, drattarvaxtaregla_id, drattarvaxtaprosenta,
			mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id, fyrri_afslattur_dagafjoldi, fyrri_afslattur,
			seinni_afslattur_dagafjoldi, seinni_afslattur, url, nafn, berist_til, heimilisfang, sveitarfelag, nafn_krofuhafa,
			heimilisfang_krofuhafa, sveitarfelag_krofuhafa, simanumer_krofuhafa, athugasemd_1, athugasemd_2,
			vaxtadagsetning, innborgunarupphaed, greiddir_drattarvextir, greidd_upphaed,
			greiddur_fjarmagnstekjuskattur, veittur_afslattur, greitt_tilkynningargjald, greitt_vanskilagjald,
			greiddur_annar_vanskilakostnadur, greiddur_annar_kostnadur, ogreitt_tilkynningjargjald, greidslugengi
		from dbo.hreyfing
commit

CREATE CLUSTERED INDEX ClusteredIndexHreyfingMain 
    ON hreyfingMain (krafa_id);