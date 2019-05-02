/*
	NON-AGGREGATE SCENARIO 1
*/

-- The following is a single operation, and should ALL be run each time
-- The measurements (time, pages, etc.) for this operation includes the time it takes to create the temporary table!

declare @mindate date = '2008-01-01';
declare @maxdate date = '2009-01-01';

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache

-- Payee with a registered home in the greidandi table has precedence to the one in thjodskra.
SELECT
	k.id
	,ka.lysing as ástand
	,k.banki
	,k.hofudbok
	,k.numer
	,k.gjalddagi
	,k.eindagi
	,k.nidurfellingardagur
	,k.upphaed
	,k.tilvisun
	,k.sedilnumer
	,k.vidskiptanumer
	,vk.lysing as vanskilagjaldstegund
	,ds.lysing as dráttarvaxtastofnkóði
	,dr.lysing as dráttarvaxtaregla
	,k.mynt_id
	,m.gjaldmidill
	,gk.lysing as gengiskóði
	,grk.lysing as greiðslukóði
	,ak.lysing as afsláttarkóði
	,k.athugasemd_1
	,k.athugasemd_2
	,k.stada_tilkynningar_og_greidslugjald_1
	,k.stada_tilkynningar_og_greidslugjald_2
	,k.stada_fyrra_vanskilagjald
	,k.stada_seinna_vanskilagjald
	,k.stada_annar_kostnadur
	,k.stada_annar_vanskilakostnadur
	,k.stada_drattarvextir
	,k.stada_afslattur
	,k.upphaed_til_greidslu
	,s.visir
	,t.kennitala as kennitala_greiðanda
	,t.nafn as nafn_greiðanda
	,g.skilabod_a_greidslusedla
	,ISNULL(h.heimili_1, t.heimili) as heimili_greiðanda
	,ISNULL(h.postnumer, t.postnumer) as póstnúmer_greiðanda
	,ISNULL(h.stadur, t.stadur) as staður_greiðanda
FROM
	( SELECT * FROM krafa  WHERE gjalddagi between @mindate and @maxdate ) k
	INNER JOIN ( SELECT id, visir FROM samningur WHERE vidskiptamadur_id = '1' /*{1,10,40,200}*/) s ON( k.samningur_id = s.id )
	INNER JOIN ( SELECT id, lysing FROM krafa_astand WHERE lysing = 'Greidd' ) ka ON( k.astand_id = ka.id )
	INNER JOIN vanskilagjaldskodi vk ON( k.vanskilagjaldskodi_id = vk.id )
	INNER JOIN drattarvaxtastofnkodi ds ON( k.drattarvaxtastofnkodi_id = ds.id )
	INNER JOIN drattarvaxtaregla dr ON( k.drattarvaxtaregla_id = dr.id )
	INNER JOIN mynt m ON( k.mynt_id = m.id )
	INNER JOIN gengiskodi gk ON( k.gengiskodi_id = gk.id )
	INNER JOIN greidslukodi grk ON( k.greidslukodi_id = grk.id )
	INNER JOIN afslattarkodi ak ON( k.afslattarkodi_id = ak.id )
	INNER JOIN greidandi g ON ( g.id = k.greidandi_id )
	INNER JOIN ( SELECT id, kennitala FROM vidskiptamadur ) v ON ( v.id = g.vidskiptamadur_id )
	LEFT OUTER JOIN ( SELECT hf.id, hf.heimili_1, ph.postnumer, ph.stadur FROM heimilisfang hf LEFT OUTER JOIN postnumer ph ON ( hf.postnumer_id = ph.postnumer ) ) h ON ( g.heimilisfang_id = h.id )
	INNER JOIN ( SELECT * FROM thjodskra th LEFT OUTER JOIN postnumer pt ON ( th.postnumer_id = pt.postnumer ) ) t ON ( t.kennitala = v.kennitala )
;


/* 
	NON-AGGREGATE SCENARIO 2 
*/

-- The following is a single operation, and should ALL be run each time
-- The measurements (time, pages, etc.) for this operation includes the time it takes to create the temporary table!

declare @mindate date = '2010-01-01';
declare @maxdate date = '2013-01-01';

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache

-- Payee with a registered home in the greidandi table has precedence to the one in thjodskra.  
SELECT
	k.id
	,ka.lysing as astand
	,k.banki
	,k.hofudbok
	,k.numer
	,k.gjalddagi
	,k.eindagi
	,k.nidurfellingardagur
	,k.upphaed
	,k.tilvisun
	,k.sedilnumer
	,k.vidskiptanumer
	,vk.lysing as vanskilagjaldstegund
	,ds.lysing as drattarvaxtastofnkodi
	,dr.lysing as drattarvaxtaregla
	,k.mynt_id
	,m.gjaldmidill
	,gk.lysing as gengiskodi
	,grk.lysing as greidslukodi
	,ak.lysing as afslattarkodi
	,k.athugasemd_1
	,k.athugasemd_2
	,k.stada_tilkynningar_og_greidslugjald_1
	,k.stada_tilkynningar_og_greidslugjald_2
	,k.stada_fyrra_vanskilagjald
	,k.stada_seinna_vanskilagjald
	,k.stada_annar_kostnadur
	,k.stada_annar_vanskilakostnadur
	,k.stada_drattarvextir
	,k.stada_afslattur
	,k.upphaed_til_greidslu
	,s.visir
	,t.kennitala as kennitala_greidanda
	,t.nafn as nafn_greidanda
	,g.skilabod_a_greidslusedla
	,ISNULL(h.heimili_1, t.heimili) as heimili_greidanda
	,ISNULL(h.postnumer, t.postnumer) as postnumer_greidanda
	,ISNULL(h.stadur, t.stadur) as stadur_greidanda
FROM
	( SELECT * FROM krafa WHERE gjalddagi between @mindate and @maxdate AND tilvisun IS NOT NULL ) k
	INNER JOIN ( SELECT top 1 id, visir FROM samningur WHERE vidskiptamadur_id = '1' /*{1,10,40,200}*/ order by id) s ON( k.samningur_id = s.id )
	INNER JOIN krafa_astand ka ON( k.astand_id = ka.id )
	INNER JOIN vanskilagjaldskodi vk ON( k.vanskilagjaldskodi_id = vk.id )
	INNER JOIN drattarvaxtastofnkodi ds ON( k.drattarvaxtastofnkodi_id = ds.id )
	INNER JOIN drattarvaxtaregla dr ON( k.drattarvaxtaregla_id = dr.id )
	INNER JOIN mynt m ON( k.mynt_id = m.id )
	INNER JOIN gengiskodi gk ON( k.gengiskodi_id = gk.id )
	INNER JOIN greidslukodi grk ON( k.greidslukodi_id = grk.id )
	INNER JOIN afslattarkodi ak ON( k.afslattarkodi_id = ak.id )
	INNER JOIN greidandi g ON ( g.id = k.greidandi_id )
	INNER JOIN ( SELECT id, kennitala FROM vidskiptamadur ) v ON ( v.id = g.vidskiptamadur_id )
	LEFT OUTER JOIN ( SELECT hf.id, hf.heimili_1, ph.postnumer, ph.stadur FROM heimilisfang hf LEFT OUTER JOIN postnumer ph ON ( hf.postnumer_id = ph.postnumer ) ) h ON ( g.heimilisfang_id = h.id )
	INNER JOIN ( SELECT * FROM thjodskra th LEFT OUTER JOIN postnumer pt ON ( th.postnumer_id = pt.postnumer ) ) t ON ( t.kennitala = v.kennitala )
;


/*
	NON-AGGREGATE SCENARIO 3
*/

-- The following is a single operation, and should ALL be run each time
-- The measurements (time, pages, etc.) for this operation includes the time it takes to create the temporary table!

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache

-- Payee with a registered home in the greidandi table has precedence to the one in thjodskra.
SELECT
	k.id
	,ka.lysing as ástand
	,k.banki
	,k.hofudbok
	,k.numer
	,k.gjalddagi
	,k.eindagi
	,k.nidurfellingardagur
	,k.upphaed
	,k.tilvisun
	,k.sedilnumer
	,k.vidskiptanumer
	,vk.lysing as vanskilagjaldstegund
	,ds.lysing as dráttarvaxtastofnkóði
	,dr.lysing as dráttarvaxtaregla
	,k.mynt_id
	,m.gjaldmidill
	,gk.lysing as gengiskóði
	,grk.lysing as greiðslukóði
	,ak.lysing as afsláttarkóði
	,k.athugasemd_1
	,k.athugasemd_2
	,k.stada_tilkynningar_og_greidslugjald_1
	,k.stada_tilkynningar_og_greidslugjald_2
	,k.stada_fyrra_vanskilagjald
	,k.stada_seinna_vanskilagjald
	,k.stada_annar_kostnadur
	,k.stada_annar_vanskilakostnadur
	,k.stada_drattarvextir
	,k.stada_afslattur
	,k.upphaed_til_greidslu
	,s.visir
	,t.kennitala as kennitala_greiðanda
	,t.nafn as nafn_greiðanda
	,g.skilabod_a_greidslusedla
	,ISNULL(h.heimili_1, t.heimili) as heimili_greiðanda
	,ISNULL(h.postnumer, t.postnumer) as póstnúmer_greiðanda
	,ISNULL(h.stadur, t.stadur) as staður_greiðanda
FROM
	krafa k
	INNER JOIN ( SELECT id, visir FROM samningur WHERE vidskiptamadur_id = '1' /*{1,10,40,200}*/) s ON( k.samningur_id = s.id )
	INNER JOIN ( SELECT id, lysing FROM krafa_astand WHERE lysing = 'Ógreidd' ) ka ON( k.astand_id = ka.id )
	INNER JOIN vanskilagjaldskodi vk ON( k.vanskilagjaldskodi_id = vk.id )
	INNER JOIN drattarvaxtastofnkodi ds ON( k.drattarvaxtastofnkodi_id = ds.id )
	INNER JOIN drattarvaxtaregla dr ON( k.drattarvaxtaregla_id = dr.id )
	INNER JOIN mynt m ON( k.mynt_id = m.id )
	INNER JOIN gengiskodi gk ON( k.gengiskodi_id = gk.id )
	INNER JOIN greidslukodi grk ON( k.greidslukodi_id = grk.id )
	INNER JOIN afslattarkodi ak ON( k.afslattarkodi_id = ak.id )
	INNER JOIN greidandi g ON ( g.id = k.greidandi_id )
	INNER JOIN ( SELECT id, kennitala FROM vidskiptamadur ) v ON ( v.id = g.vidskiptamadur_id )
	LEFT OUTER JOIN ( SELECT hf.id, hf.heimili_1, ph.postnumer, ph.stadur FROM heimilisfang hf LEFT OUTER JOIN postnumer ph ON ( hf.postnumer_id = ph.postnumer ) ) h ON ( g.heimilisfang_id = h.id )
	INNER JOIN ( SELECT * FROM thjodskra th LEFT OUTER JOIN postnumer pt ON ( th.postnumer_id = pt.postnumer ) ) t ON ( t.kennitala = v.kennitala )
	INNER JOIN hreyfingMain hr ON hr.krafa_id = k.id AND hr.innborgunardagur IS NOT NULL
	INNER JOIN tegund_hreyfingar th ON th.id = hr.tegund_hreyfingar_id AND th.lysing = 'Innborgun'
;

/*
	AGGREGATE
*/

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache

declare @mindate date = '2008-01-01';

-- Summa greiddra krafna einstaklinga, per útibú, eftir póstnúmeri kröfuhafa (skráning í heimilisfang hefur forgang umfram þjóðskrá) og greiðslutímabili. Fyrir svæði utan 1xx póstnúmeraseríunnar.
SELECT
 k.banki, isnull( ph.postnumer, pt.postnumer ) as Póstnúmer, YEAR( h.bokunardagur ) as Ár, sum( CONVERT( NUMERIC(30,0), k.upphaed_til_greidslu ) ) as Heildarupphæð
FROM
    ( SELECT kennitala, postnumer_id
      FROM thjodskra
      WHERE tegund_logadila_id IN ( SELECT id FROM tegund_logadila WHERE lysing = 'Einstaklingur' )
    ) t
    LEFT OUTER JOIN postnumer pt ON ( t.postnumer_id = pt.postnumer ),
    ( SELECT id, banki, upphaed_til_greidslu, samningur_id
      FROM krafa
      WHERE astand_id in ( SELECT id FROM krafa_astand WHERE lysing = 'Greidd' )
      AND annar_kostnadur is null
      AND annar_vanskilakostnadur is null
      AND fyrri_afslattur is null
      AND seinni_afslattur is null
    ) k
    JOIN
    ( SELECT tegund_hreyfingar_id, krafa_id, bokunardagur
      FROM hreyfingMain
      WHERE tegund_hreyfingar_id in ( SELECT id FROM tegund_hreyfingar WHERE lysing = 'Greiðsla' )
      AND bokunardagur >= @mindate
    ) h ON ( k.id = h.krafa_id )
    JOIN samningur s ON ( s.id = k.samningur_id ),
    vidskiptamadur v
    LEFT OUTER JOIN heimilisfang hf ON ( v.heimilisfang_id = hf.id )
    LEFT OUTER JOIN postnumer ph ON ( hf.postnumer_id = ph.postnumer )
WHERE
	v.id = s.vidskiptamadur_id
	AND v.kennitala = t.kennitala
	AND pt.postnumer not like '1%'
	AND ph.postnumer not like '1%'
GROUP BY
	k.banki, isnull( ph.postnumer, pt.postnumer ), YEAR( h.bokunardagur )
ORDER BY
	k.banki, isnull( ph.postnumer, pt.postnumer ), YEAR( h.bokunardagur )


/*
	INSERT
*/

-- The following is a single operation, and should ALL be run each time
-- The measurements (time, pages, etc.) for this operation includes the time it takes to create the temporary table!

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache

set nocount on;

declare @vskm_id int = 1;

declare @samningur_id int = ( select MIN(id) from samningur where vidskiptamadur_id = @vskm_id );
declare @astand_id tinyint = 1
declare @greidandi_id int = ( select MIN(id) from greidandi where samningur_id = @samningur_id);
declare @banki tinyint = 101;
declare @hofudbok tinyint = 66;
declare @numer smallint = 1;
declare @gjalddagi date = '2013-01-01';
declare @eindagi date = '2013-01-15';
declare @nidurfellingardagur date = '2017-01-01';
declare @upphaed smallint = 1001;
declare @tilvisun char(11) = 'PRÓFUN_EYÐA';
declare @vanskilagjaldskodi_id char(1) = (select MIN(id) from vanskilagjaldskodi ) ;
declare @drattarvaxtastofnkodi char(1) = ( select MIN(id) from drattarvaxtastofnkodi );  
declare @drattarvaxtaregla_id char(1) = ( select MIN(id) from drattarvaxtaregla );
declare @mynt char(3) = 'CHF';
declare @gengiskodi_id char(1) = 'G';
declare @greidslukodi_id char(1) = ( select MIN(id) from greidslukodi );
declare @afslattarkodi char(1) = ( select MIN(id) from afslattarkodi );

declare @index int = 0;
declare @timeTotal bigint = 0;
declare @iterations int = 1000;

while( @index < @iterations )
begin
	insert into krafa ( samningur_id, astand_id, greidandi_id, banki, hofudbok, numer, gjalddagi, eindagi, nidurfellingardagur, upphaed, tilvisun, vanskilagjaldskodi_id
	,drattarvaxtastofnkodi_id, drattarvaxtaregla_id, mynt_id, gengiskodi_id, greidslukodi_id, afslattarkodi_id
	,stada_tilkynningar_og_greidslugjald_1, stada_tilkynningar_og_greidslugjald_2, stada_fyrra_vanskilagjald, stada_seinna_vanskilagjald, stada_annar_kostnadur
	,stada_annar_vanskilakostnadur, stada_drattarvextir, stada_afslattur, upphaed_til_greidslu )
	values
	(
		@samningur_id, @astand_id, @greidandi_id, @banki, @hofudbok, @numer, @gjalddagi, @eindagi, @nidurfellingardagur, @upphaed, @tilvisun, @vanskilagjaldskodi_id
		,@drattarvaxtastofnkodi, @drattarvaxtaregla_id, @mynt, @gengiskodi_id, @greidslukodi_id, @afslattarkodi
		,0, 0, 0, 0, 0, 0, 0, 0, @upphaed
	);
	set @index += 1;
	set @numer += 1;
end;
PRINT 'Iterations: ' + convert( nvarchar, @iterations );


set nocount off;
delete krafa where tilvisun = 'PRÓFUN_EYÐA'; -- You should perform this cleanup in order for all other measurements to remain unchanged.


/*
	UPDATE
*/

dbcc freeproccache; -- Throw away execution plans, among other things
dbcc dropcleanbuffers; -- Empty the (block) buffer cache


update 
	k
set
	k.tilvisun = 'UPPFÆRÐ_TILVÍSUN'
	,k.sedilnumer = '1234567'
	,k.athugasemd_1 = 'Athugið að hægt er að greiða inn á kröfuna í netbönkum sem styðja við þá virkni.'
	,k.athugasemd_2 = 'Krafan verður send í milliinnheimtu sé hún ekki að fullu greidd á eindaga!'
	,k.mynt_id = 'EUR'
from krafa as k
inner join dbo.samningur as s
			on k.samningur_id = s.id
WHERE
	s.vidskiptamadur_id = 281
	AND annar_kostnadur IS NULL
	AND upphaed > 1
