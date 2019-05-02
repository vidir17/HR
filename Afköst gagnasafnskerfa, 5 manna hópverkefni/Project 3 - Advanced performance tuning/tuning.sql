-- Create indices:

SET ANSI_PADDING ON

CREATE CLUSTERED COLUMNSTORE INDEX hreyfingMainColumnstore ON hreyfingMain;  

CREATE CLUSTERED COLUMNSTORE INDEX vidskiptamadurColumnstore ON vidskiptamadur; 

CREATE CLUSTERED COLUMNSTORE INDEX krafaColumnstore ON krafa; 

CREATE NONCLUSTERED INDEX [_dta_index_hreyfingMain] ON [dbo].[hreyfingMain]
(
	[tegund_hreyfingar_id] ASC,
	[bokunardagur] ASC,
	[krafa_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [_dta_index_vidskiptamadur] ON [dbo].[vidskiptamadur]
(
	[heimilisfang_id] ASC,
	[id] ASC,
	[kennitala] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [_dta_index_heimilisfang] ON [dbo].[heimilisfang]
(
	[id] ASC,
	[postnumer_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]


--Create statistics:

CREATE STATISTICS [krafa_samningur_id_statistics] ON [dbo].[krafa]([samningur_id])
GO

CREATE STATISTICS [krafa_banki_statistics] ON [dbo].[krafa]([banki])
GO

CREATE STATISTICS [krafa_astand_id_statistics] ON [dbo].[krafa]([astand_id])
GO

CREATE STATISTICS [hreyfingMain_krafa_id_statistics] ON [dbo].[hreyfingMain]([krafa_id])
GO

CREATE STATISTICS [hreyfingMain_bokunardagur_statistics] ON [dbo].[hreyfingMain]([bokunardagur])
GO

CREATE STATISTICS [vidskiptamadur_kennitala_statistics] ON [dbo].[vidskiptamadur]([kennitala])
GO