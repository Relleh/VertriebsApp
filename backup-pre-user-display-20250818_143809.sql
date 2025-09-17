--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: vertrieb
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    customer_no character varying NOT NULL,
    customer_name character varying NOT NULL,
    contact_person character varying,
    place character varying
);


ALTER TABLE public.customers OWNER TO vertrieb;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: vertrieb
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO vertrieb;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vertrieb
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: vertrieb
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    owner_oid character varying NOT NULL,
    owner_email character varying,
    owner_name character varying,
    customer_no character varying NOT NULL,
    customer_name character varying NOT NULL,
    contact_person character varying,
    place character varying,
    date date NOT NULL,
    short_report text,
    next_steps text,
    classification character varying,
    order_value_eur numeric(12,2),
    offer_value_eur numeric(12,2),
    next_visit_weeks integer,
    is_new_account boolean,
    overnight boolean,
    day_status character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_classification CHECK (((classification)::text = ANY ((ARRAY['A'::character varying, 'B'::character varying, 'C'::character varying])::text[]))),
    CONSTRAINT check_day_status CHECK (((day_status)::text = ANY ((ARRAY['OFFICE'::character varying, 'VACATION'::character varying, 'ILLNESS'::character varying])::text[])))
);


ALTER TABLE public.reports OWNER TO vertrieb;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: vertrieb
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_id_seq OWNER TO vertrieb;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vertrieb
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: vertrieb
--

COPY public.customers (id, customer_no, customer_name, contact_person, place) FROM stdin;
6808	100391	Gebr. Honnens GmbH		Tarp
6905	100488	Konzept B Service GmbH		Wien
6906	100489	SAMEDIA GmbH		Denzlingen
8504	102390	SAS OUTIWEST		Bonchamp
12846	151872	E.W. Neu GmbH		Speyer
6424	100000	Ambiance sols & Murs SAS		Clermont
6425	100001	Powerplus Fixings Ltd	Unit K5	Warrington, Chesire
6426	100002	EUMACOP für Buchhaltung	BITTE NICHT LÖSCHEN	Dinklage
6427	100003	EDE Wuppertal Verbandskunde	nicht löschen	Wuppertal
6428	100004	Wiha Werkzeuge GmbH		Schonach
6429	100005	ALLTOOLS BVBA		LONDERZEEL
6430	100006	DE BRUYNE NV		HARELBEKE (HULSTE)
6431	100007	ISERO Ijzerhandel B.V.	Pijnenburg Bouw & Industrie	Tilburg
6432	100008	Nordwest		Dinklage
6433	100009	EIS Kunden für Buchhaltung nicht	löschen	Dinklage
6434	100010	Frankreich Preisliste F2		Dinklage
6435	100011	SOSACA GEDIMAT SA		La Seyne Sur Mer
6436	100012	SOSACA GEDIMAT		Toulon
6437	100013	Hornung Baushop GmbH & Co. KG		Blankenloch
6438	100014	Quincaillerie CAP AGRI SAS		Saulzet
6439	100015	WORKFORCE (UK) Ltd.	t/a Diamond Direct Supplies	Gravesend
6440	100016	Schönreiter Baustoffe GmbH		Essenbach b. Landshut
6441	100017	KINGFISHER SALES & MARKETING LLP		Bridgend
6442	100018	Raiffeisen Waren GmbH		Leinefelde-Worbis
6443	100019	BMJ 42 SAS		Feurs
6444	100020	Otto Röhrs GmbH		Hambergen
6445	100021	Neukunde_GB	KOPIERVORLAGE nicht überschreiben!	Muster Ort
6446	100022	Baustoff Renger GmbH		Zittau
6447	100023	Ruhland Kallenborn Ensdorf		Ensdorf
6448	100024	LAYER-Grosshandel GmbH & Co.KG		Tettnang
6449	100025	M&M Fixings		Cardiff
6450	100026	Kipp & Grünhoff GmbH & Co. KG		Köln
6451	100027	MERIT TOOL HIRE	AND SALES LTD	Carlton, Nottingham
6452	100028	STEYRO NV		Aalter
6453	100029	In de Boerenhandel bv		Boechout/Antwerpen
6454	100030	Voskamp Bouw en Industrie B.V.		Groningen
6455	100031	Heinrich August Mönkemöller	GmbH & Co KG	Herford
6456	100032	Dachdecker-Einkauf Ost eG	Zweigniederlassung Finowfurt	Schorfheide / OT Finowfurt
6457	100033	Dennis Wendt	Service & Vertrieb	Bremen
6458	100034	The Tools & Fixings Company		Chiselhurst, Kent
6459	100035	RapiTrade UK	Essex House	Great Bromley, Essex
6460	100036	Dachdecker-Einkauf Ost eG	Zweigniederlassung Hidesheim	Hildesheim
6461	100037	FNW Fixings North West	Unit 2 Gleblands Court	Sale, Chesire
6462	100038	Raiffeisen-Waren GmbH		Wetter
6463	100039	Peter Lafrentz GmbH & Co. KG	Stahlhandel	Brunsbüttel
6464	100040	CEULEMANS BVBA		Boechout
6465	100041	MAXIMA SpA		Poviglio (RE)
6466	100042	Dachdecker Einkauf Ost eG	Zweigniederlassung Goslar	Goslar
6467	100043	ABC Industriebedarf	Walter Zettler GmbH	Bremerhaven
6468	100044	GANNAZ MATÉRIAUX SAS		Sallanches
6469	100045	BAUKING Ostfalen GmbH	(Ndl. Garbsen)	Garbsen
6470	100046	Dachdecker-Einkauf Ost eG	Zweig-NL Fürstenwalde	Fürstenwalde
6471	100047	Athena EPI		Martigny Le Comte
6472	100048	Kean Tools		Danbury, Essex
6473	100049	Schmidt Maschinenhandel		Riedstadt-Goddelau
6474	100050	TEAM PRO INTERNATIONAL FZCO		Dubai, Jebel Ali Free Zone
6475	100051	Fastco Ltd	Unit 3a, Crewe Trade Park	Crewe
6476	100053	Knurbein Arbeitsschutz KG		Lindern - Garen
6477	100054	Union Bauzentrum Hornbach GmbH		Ettlingen
6478	100055	Caribbean Solutions	Hacienda San Jose	Caguas P.R. 00726
6479	100056	Diamond Hire & Sales LLP	Elles House	Hampshire
6480	100058	Theo Förch GmbH & Co.KG	Verkaufsniederlassung Magdeburg	Magdeburg
6481	100059	Paulo Santos		Ipswich, Suffolk
6482	100060	Will Eisen- und Sanitär	Großhandelsgesellschaft mbH	Mainz-Kastel
6483	100061	Toolstation Toussieu SAS		Toussieu
6484	100062	Neukunde_FR	KOPIERVORLAGE nicht überschreiben!	Muster Ort
6485	100064	Wiedemann GmbH		Burg
6486	100065	Dachdecker-Einkauf Ost eG	NL Berlin-Biesdorf	Berlin-Biesdorf
6487	100066	Neukunde_Export	KOPIERVORLAGE nicht überschreiben!	Muster Ort
6488	100067	East Coast Sales Ltd.	Unit 1a	Goole, East Yorkshire
6489	100068	Kopiervorlage		Stadt
6490	100069	Maran Atha Fasteners Ltd.		St. Helens, Merseyside
6491	100070	Heller Tools GmbH		Dinklage
6492	100071	Wiedemann GmbH & Co.KG		Bielefeld
6493	100072	deeg GmbH		Stuttgart-Wangen
6494	100073	FGR GmbH		Hagen
6495	100074	Wiedemann GmbH & Co.KG		Höxter
6496	100075	Wandrus Hardware Ltd.		Rochdale
6497	100076	FrimTec GmbH		Oberostendorf
6498	100077	Rimbaud Location		MONTPELLIER
6499	100078	Wiedemann GmbH & Co.KG		Barsinghausen
6500	100079	Raiffeisen Waren GmbH		Gotha
6501	100080	SA Echamat Kernst		Saint Pierre
6502	100081	PT Bahana Andalan Pasti	NPWP: 81.257.966.2-022.000	Jakarta Pusat DKI Jakarta
6503	100082	Zhen Jiang HTT Tool Co., Ltd.		Danyang City, Jiangsu Province
6504	100083	WP GmbH	Diamanttechnik Maschinen Zubehör	Celle
6505	100085	Normstark	Partner für Industrie und Handwerk	Lengerich
6506	100086	C.Adolph	Inh. Veronika Savary e.K.	Berlin
6507	100087	Wiedemann GmbH & Co.KG		Celle
6508	100088	Wiedemann GmbH & Co.KG		Göttingen
6509	100089	PENNY PLUS D.O.O. SARAJEVO		Vogosca
6510	100090	Wiedemann GmbH	NL Landsberg	Landsberg
6511	100091	Hammer-Baubedarf AG		Winterthur
6512	100092	Wiedemann GmbH	NL Tempelhof	Berlin-Tempelhof
6513	100093	Wiedemann Industie und Haustechnik	GmbH	Potsdam
6514	100094	GES	Handwerks- und Industriebedarf GmbH	Duisburg
6515	100095	COOPROVENCE	SA	Entraigues-sur-la-Sorgue
6516	100096	Wiedemann Industie- und Haustechnik	GmbH	Dessau-Roßlau
6517	100097	Union Bauzentrum Hornbach GmbH		Großeicholzheim
6518	100098	SARL Forestier Delchet		Le Mayet de Montagne
6519	100099	Friedrich Niemann GmbH & Co. KG	Niederlassung Hamburg	Hamburg
6520	100100	Wiedemann GmbH & Co.KG		Goslar
6521	100101	UBT (EU) Ltd	nur Einkaufsguppe für Rabatte	Warwick
6522	100102	edm GmbH & Co. KG		Fuldabrück
6523	100103	Wiedemann GmbH & Co.KG		Herzberg
6524	100106	Vlanip Design SRL		Chisinau Moldova
6525	100107	Wiedemann GmbH		Thyrow
6526	100108	Wiedemann GmbH		Brandenburg
6527	100109	Wiedemann GmbH		Berlin
6528	100110	Wiedemann GmbH		Nordhausen
6529	100111	Tool Co.	Irrgang, Marquardt oHG	Berlin
6530	100112	RJ Fixings Newcastle Ltd.	Unit C1 Bergen Close	North Shields
6531	100113	Dachdecker-Einkauf Ost eG	NL Dessau	Dessau
6532	100114	Waidzeit	Baumaschinen Vermietung	Lage
6533	100115	LuDz Mitte GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Barsinghausen
6534	100116	Gerhard Borchert	Baustoff - Fachhandel GmbH	Berlin
6535	100117	Siebert Oetzel OHG	Baustoffhandel	Berlin
6536	100118	Montageservice	Mario Alsleben	Oberhausen
6537	100119	EJOT SISTEMAS DE CONSTRUCCION	S.DE R.L. DE C.V	San Luis Potosi SLP Mexico
6538	100120	Gulf Diameter Est. for Trading		Dammam
6539	100121	Jomi - Profixings	Hautekeete Joachim	Deinze
6540	100122	Druse GmbH	Werkzeuge und Industriebedarf	Buchholz
6541	100123	Rotink Ijzerwaren	ZHA Heer Han ter Woorst	Hengevelde
6542	100124	SAS GTC RESEAUX		MARSEILLE
6543	100125	Wilhelm Lingsch GmbH	Inh. Christian Martin	Berlin
6544	100126	Der Baustoff-Mann Schneider KG		Bottrop
6545	100127	Outils Nord Sàrl	Tools	Derenbach
6546	100128	FE ZEVIJ BV, COOP GRHANDVER ZEVIJ		Oosterhout
6547	100129	KLAXON S.A.		Athen Greece
6548	100130	bauSpezi E. Marks GmbH		Jütrichau
6549	100131	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Bergen
6550	100132	SARL FIX'ON		SIX FOURS LES PLAGES
6551	100133	Hermann Bach GmbH & Co.KG		Salzkotten
6552	100134	Robert Neudorf	Inh. Christian Kruschel e.K.	Berlin (Spandau)
6553	100135	Philipp Einzel- u. Großhandels GmbH		Berlin-Wittenau
6554	100136	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Seebad Bansin
6555	100137	inha GmbH	Maschinen Werkzeuge Kugellager	Berlin
6556	100138	Walter Wesemeyer GmbH		Waren/Müritz
6557	100139	Walter Wesemeyer GmbH		Kiel
6558	100140	Walter Wesemeyer GmbH		Lübeck
6559	100141	Walter Wesemeyer GmbH		Bad Doberan
6560	100142	Vollmer Baustoffhandel		Bellheim
6561	100143	Walter Wesemeyer GmbH		Hamburg Altona
6562	100144	Walter Wesemeyer GmbH		Hamburg Osdorf
6563	100145	Walter Wesemeyer GmbH		Schwerin
6564	100146	Baku Engineering Supplies Ltd LLC		Baku
6565	100147	Walter Wesemeyer GmbH		Kaltenkirchen
6566	100148	Technische Werkstätten	Langengrassau GmbH	Heideblick
6567	100149	BTL Beton Transformation	Luxembourg S.A.	Horhausen
6568	100150	Walter Wesemeyer GmbH		Wismar
6569	100151	UIP Verbindungstechnik GmbH		Kriftel
6570	100152	Adolf Neuendorf GmbH		Berlin
6571	100153	M. u. F. Valentin Tischler-	bedarf GmbH & Co.KG	Berlin
6572	100154	Walter Wesemeyer GmbH		Pinneberg
6573	100155	Walter Wesemeyer GmbH		Schwarzenbek
6574	100156	Claus Hedemann GmbH & Co. KG		Bad Zwischenahn
6575	100157	Mastermate Zwager	van Ree Beverwijk	Beverwijk
6576	100158	Walter Wesemeyer GmbH		Buchholz i. d. Nordheide
6577	100159	Elektro Großhandel Union Neuss GmbH		Neuss
6578	100160	Mobau PRO GmbH & Co. KG		Bergheim
6579	100161	Wolfram Lochert	Maschinen-Werkzeuge	Wermsdorf/OT Liptitz
6580	100162	A&B Services (Liverpool) Ltd	Handyman's Corner	Liverpool
6581	100163	SASU Boute Yves SAS		Saint Juste Malmont
6582	100164	De Boer & Van Hout		Veldhoven
6583	100165	BMN IJzerwaren Tilburg		Tilburg
6584	100166	Eisen-Sommer e.K.	Inhaber Manfred Sommer	Berlin
6585	100167	Amlex GmbH & Co. KG		Essen
6586	100168	AB Matériel		VEDENE
6587	100169	Delmes Heitmann GmbH & Co. KG	(Ndl. Hummelsbüttel)	Hamburg
6588	100170	Follmann Baustoffe GmbH		Wittlich
6589	100171	Al-Majdud Company for General	Trading Ltd.	Al Salihiya Baghdad
6590	100172	Mrose GmbH	Technischer Handel-Indsutriebedarf	Forst
6591	100173	Kluwe Baufachhandelsges. mbH		Berlin
6592	100174	KÖSTER BAUCHEMIE AG		Aurich
6593	100175	Jacob Sönnichsen AG	Jacob Cement	Rostock
6594	100176	Ralf Koss	Industriebedarf	Berlin
6595	100177	BAUKING Südwestfalen GmbH	(Niederlassung Menden)	Menden
6596	100178	US Service GmbH		Lehmrade / Mölln
6597	100179	SAS AUVERGNE SERAMIK		CLERMONT FERRAND
6598	100180	AGWIS	Thomas Becker	Osterode am Harz
6599	100181	DGL Workshop Supplies LTD	Unit 2A (Lower Ground Floor)	Hertford, Herts
6600	100182	Power Tool Supplies (Cork) Ltd		Pouladuff, Cork
6601	100183	Dachdecker Einkauf Wesendorf		Wesendorf
6602	100184	Beyen	für´s Handwerk	Dinklage
6603	100185	Stang GmbH & Co. KG	NL München	München
6604	100186	Otto Jörgensen + Sohn GmbH	Industrietechnik	Flensburg
6605	100187	Albert Leymann GmbH & Co.KG	NL Bruchhausen-Vilsen	Bruchhausen-Vilsen
6606	100188	hagebaucentrum Bolay GmbH & Co. KG	(hagebaumarkt Rutesheim)	Rutesheim
6607	100189	EXTER DIFFUSION	SARL	ANTIBES
6608	100190	DFS Fixings Ltd.	Foundry Square	Leicester
6609	100191	Hoffmann GmbH		Achim
6610	100192	Friedrich Rohwedder GmbH		Berlin
6611	100193	VOIRON MATÉRIAUX SARL		MORZINE
6612	100194	Zeppelin Rental GmbH & Co.KG	Mietstation Wiesbaden	Wiesbaden
6613	100195	Kipp & Grünhoff GmbH & Co. KG		Köln - Eigelsteinviertel
6614	100196	DIGILEC	SARL	CHARLIEU
6615	100197	CARRELAGE DU SALEVE	SAS	Chênex
6616	100198	automac-zieher GmbH		Biberach
6617	100199	Richter Baustoffe GmbH	(Ndl. Roggentin)	Roggentin
6618	100200	SchraubenExpress.de	Inh. Stephan Lauterbach	Brieselang
6619	100201	Paul Swertz GmbH		Emmerich
6620	100202	Eisen Döring Charlottenburg	An der Kaiserdamm Brücke	Berlin-Charlottenburg
6621	100203	Fischer-J.W.Zander GmbH&Co.KG		Erlenbach
6622	100204	Vochtstore.be	Hans Peter Sulman	Antwerpen
6623	100205	Hamann Kaisersesch GmbH		Kaisersesch
6624	100206	Stow Agricultural Ltd		Longborough, Gloucestershire
6625	100207	DEG Dach-Fassade-Holz eG		Wuppertal
6626	100208	Max Schierer GmbH	Ndl. Bad Kötzting	Bad Kötzting
6627	100209	Max Schierer GmbH	Ndl. Regen	Regen
6628	100210	Max Schierer GmbH	Ndl. Niettenau	Nittenau
6629	100211	Max Schierer GmbH	Ndl. Viechtach	Viechtach
6630	100212	OX Group U.K.	Unit 2, Riverside	London
6631	100213	Pinsel-Wurm Malerwerkzeuge	GmbH & Co. KG	Mutterstadt
6632	100214	Profast Ltd	Unit 11, Western Ind. Estate	Dublin
6633	100215	ibg Technischer Handel GmbH		Hilden
6634	100216	Tools GmbH	Agentur für Qualitätswerkzeug	Neukirchen-Vluyn
6635	100217	Hans Sauer GmbH	Elektrowerkzeuge	Hamburg 63
6636	100218	Paul Swertz GmbH		Geldern-Veert
6637	100219	W. Hauck GmbH	Werkzeuge Maschinen Industriebed.	Schwegenheim
6638	100220	Paul Swertz GmbH		Viersen
6639	100221	Hermann Bach GmbH & Co. KG	(Ndl. Göttingen)	Göttingen
6640	100222	GmbH HartGruppService		Bolschewik, Minsk
6641	100223	Welch & Tidy Ltd	Wholesale Cash & Carry	Perivale, Middlesex
6642	100224	BAUKING GmbH		Dortmund
6643	100225	Schroers GmbH	Holzbearbeitungsmaschinen	Mönchengladbach
6644	100226	KORTEK	Lars Hoffmann	Arnsdorf
6645	100227	J.W. Zander GmbH & Co. KG		Recklinghausen
6646	100228	Bauwelt Plambeck	Delmes Heitmann GmbH & Co. KG	Kaltenkirchen
6647	100229	Voskamp Bouw en Industrie B.V.		Oud Gastel
6648	100230	Stadur Produktions GmbH & Co.KG		Hammah
6649	100231	BMN IJzerwaren DC Best		BEST
6650	100232	Raiffeisen Waren GmbH	Ndl. Nordhausen	Nordhausen-Nord
6651	100233	Dachdecker- und Baustoff-Einkauf	Zweigniederlassung Wittichenau	Wittichenau
6652	100234	BMN Ijzerwaren Arnhem		Arnhem
6653	100235	Blaricumsche IJzerhandel		Blaricum
6654	100236	Kilman	Osman Mora Retamal	Conceptión VIII  CHILE
6655	100237	DEG Dach-Fassade-Holz eG	ZNL Bottrop	Bottrop
6656	100238	M Maschinen	Inhaber Dieter Liemen	Gotha
6657	100239	ITW Construction Products Oy		VANTAA
6658	100240	Hippotools		Houthalen - Belgium
6659	100241	Elektrowerkzeuge GmbH Eibenstock		Eibenstock
6660	100242	Dachdecker-Einkauf Ost eG	Massen/Finsterwalde	Massen
6661	100243	OOO PROFITOOL (PROFITOOL LTD)		Kievskaya oblast, Boyarka
6662	100244	Dachdecker-Einkauf Ost eG	Zweigniederlassung Schaumburg	Lauenau
6663	100245	Veneberg BV		Hardenberg
6664	100246	Fleischhut GmbH		Cuxhaven
6665	100247	Ömer's Profi - Baumarkt		Herne
6666	100248	Schnittger Baustoffe GmbH & Co. KG		Lübbecke
6667	100249	G.W.J. van Lochem B.V.		Aalten
6668	100250	Schütte Baumarkt GmbH & Roggan KG		Lüchow
6669	100251	Dominik Menke	Restpostendomi	Langen
6670	100252	DD PRO	SAS	NICE
6671	100253	Bücheler & Martin	Fachhandel für Baustoffe	Stockach
6672	100254	Kurt Neidull e.K.		Kirchenthumbach
6673	100255	J. H. Niebuhr jr. Handelsges. mbH		Elmshorn
6674	100256	Schnittger Baustoffe GmbH & Co. KG		Lübbecke
6675	100257	Delmes Heitmann GmbH & Co. KG	(Niederlassung Glinde)	Glinde
6676	100258	BAUKING Ostfalen GmbH		Goslar
6677	100259	Guido Hinken		Nordhorn
6678	100260	Techprof Amsterdam BV		Amsterdam
6679	100261	Burkard Giegerich GmbH & Co KG		Großwallstadt
6680	100262	Belziger Baustoffhandel GmbH		Bad Belzig
6681	100263	Etges & Dächert Baustoffe	GmbH & Co. KG	Trier
6682	100264	Beckmann Haustechnik	eine Zweigniederlassung der	Flensburg
6683	100265	SIGF Manchester	Textilose Road	Manchester
6684	100266	Eisenwaren Diefenbach	Inh. Werner Diefenbach	Wiesbaden
6685	100267	Reisser Schraubentechnik GmbH		Ingelfingen-Criesbach
6686	100268	HEGO-Montagetechnik		Krautheim-Gommersdorf
6687	100269	Baustoffzentrum Wilhelm Harbecke Gm		Mülheim - Broich
6688	100270	Bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Winsen/Luhe
6689	100271	Rudolf Peters Landhandel	GmbH & Co. KG	Büchen
6690	100272	Adde Cassens KG		Esens
6691	100273	Ferroflex AG	c/o Ferroflex Group AG	Schaffhausen
6692	100274	Beacon Trade and Tool Ltd	Computer House	West Midlands, Oldbury
6693	100275	albin motzer	Inh. Albin Motzer	Eichberg
6694	100276	Müller & Janßen	Holz und Baustoffe	Hesel
6695	100277	LHG-Markt GmbH	Schneider Baucentrum	Bruckmühl
6696	100278	Seidler + Hentschel OHG	Bauzubehör	Bernburg
6697	100279	INTEC Industrie-	und Werkstattbedarf GmbH	Quedlinburg
6698	100280	GUHDO GmbH		Wermelskirchen
6699	100281	Pauly Elektrotechnik GmbH	Inh. Michael Pauly	Morbach
6700	100282	TFS Direct	Unit 11/12, Millbuck Way	Sandbach, Cheshire
6701	100283	BauKing Engelskirchen		Engelskirchen
6702	100284	BRANDT-Shop	Inh. E. Brandt	Eckental
6703	100285	Dominik Menke	Werkzeughandel	Langen
6704	100286	A Solutions UK Ltd		Ashford
6705	100287	Georg GmbH		Erfurt
6706	100289	Hermann Bach GmbH & Co. KG		Bernburg
6707	100290	Union Bauzentrum Hornbach GmbH		Wöllstein
6708	100291	Conrad Electronic	Filiale Essen	Essen OT. Weststadt
6709	100292	BMN Wijcks RDC Nijmegen		Nijmegen
6710	100293	Hass+Hatje GmbH		Neumünster
6711	100294	Hass + Hatje		Hitzhusen
6712	100295	Conrad Electronic SE	Cross-Docking	Hirschau
6713	100296	Hass + Hatje GmbH		Bordesholm
6714	100297	Werner K. Mayer GmbH	Baumaschinen - Baugeräte	Schwäbisch Gmünd
6715	100298	Laarmann u.Peez GmbH		Hamburg
6716	100299	Zeeman IJzerhandel		Schiedam
6717	100300	Stender Bautechnik	Vertrieb + Service	Ventschow
6718	100301	Conrad Electronic SE	Filiale Dortmund	Dortmund
6719	100302	Lars Heller		Sankt Augustin
6720	100303	Kunath Gewinde- und	Befestigungstechnik	Schwerin/Görries
6721	100304	EGG Elektrogroßhandel GmbH	Inh. Christoph Gemmecke	Arnsberg
6722	100305	OnSite Support		Crawley, West Sussex
6723	100306	Hoppe GmbH & Co. KG		Brilon
6724	100307	Theile & Wagner GmbH & Co. KG	Industriebedarf	Zittau
6725	100308	Conrad Electronic SE		Bonn - Weststadt
6726	100309	EH Hasselbring	Baustoffe & Holz	Bremervörde
6727	100310	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Crimmitschau
6728	100311	Coopérative Artisanale du Sanitaire	de l’Électricité et du Chauffage	FENAY
6729	100312	Der Neue Eisenhenkel GmbH		Kiel
6730	100313	PROFIX AG		Lausen
6731	100314	The Toolbox Supply Company		Hartlepool
6732	100315	R.P.A.Steenbakkers		Boxtel
6733	100316	Shopcore.nl		Doetinchem
6734	100317	HO Voets		Schijndel
6735	100318	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Lübeck
6736	100319	Johann Eberhard Ges.m.b.H		St. Josef
6737	100320	Friedrich Niemann GmbH & Co.KG	Werkzeughandel	Kronshagen
6738	100321	T. Bulten Bouwmaterieel		Zelhem
6739	100322	Conrad Electronic Stores	GmbH & Co.KG	Hamburg
6740	100323	Borchers & Speer	Handelsgesellschaft mbH	Kiel
6741	100324	BODIAM Diamantwerkzeuge		Plattenburg
6742	100325	Swiftfix Distributors Ltd		Sholing, Southampton
6743	100326	Josef Klinke Baustoffe	Inh. Anne Klinke e.K.	Wittmund / OT Ardorf
6744	100327	Wimberger Fachmarkt	Stefan Wimberger	Frontenhausen
6745	100328	Pioneer Agri		Lincoln
6746	100329	Pflüger Baustoffe GmbH		Marktbergel
6747	100330	Conax UG	Werkzeuge	Leipzig
6748	100331	Integra GmbH	Fachgroßhandel	Jahnsdorf
6749	100332	Trent Fasteners & Fixings Ltd.	Unit 5A Tern Valley Business Park	Shropshire
6750	100333	SORMAT OY	attn. Simo Lieskivi	RUSKO (FINNLAND)
6751	100334	B. Schlichter GmbH & Co.KG	Abt. Alu Bautechnik	Lathen
6752	100335	Optimum Trade Supplies Ltd.		Fenstanton Cambridgeshire
6753	100336	Bach & WESCO KG		Bergisch Gladbach
6754	100337	Beck Elektrogroßhandel e.K.		Bad Salzungen
6755	100338	Pantaleo Stomeo		Engelskirchen
6756	100339	Drögemüller Handels mbH	Maschinen-Werkzeuge	Lübeck
6757	100340	BMN Ijzerwaren		Amsterdam
6758	100341	KUROGA GmbH & Co.		Hamburg 76
6759	100342	Total Diamond Products	Husqvarna Construction UK Ltd	Basildon, Essex
6760	100343	BMN Ijzerwaren		Rotterdam
6761	100344	Dachdecker- und Baustoff-Eink.	Zweigniederl. Dresden/Moritzburg	Moritzburg/OT Boxdorf
6762	100345	Max Hufnagel GmbH		Dachau
6763	100346	Dachdecker- und Baustoff-Einkauf eG	Zweigniederlassung Dresden	Dresden
6764	100347	Union Bauzentrum Hornbach GmbH		Pirmasens
6765	100348	Kamoro GmbH		Roetgen
6766	100349	Josef Schwarz & Sohn GmbH & Co. KG		Dingolfing
6767	100350	Bauexpert GmbH & Co KG		Ottobeuren
6768	100351	Ercalux SA		Fischbach/Clervaux
6769	100352	Josef Schwarz & Sohn GmbH & Co. KG		Mainburg
6770	100353	Josef Schwarz & Sohn GmbH & Co. KG		Moosburg
6771	100354	Wilfried Uwe Koch	Industriebedarf	Bönningstedt
6772	100355	Dachdecker-Einkauf Ost eG	Niederlassung Hannover	Hannover
6773	100356	Aktiv	Baumaschinen & Industriebedarf GmbH	Linden
6774	100357	Josef Schwarz & Sohn GmbH & Co. KG		Traunstein
6775	100358	Josef Schwarz & Sohn GmbH		Edling
6776	100359	Leigh tools and accessories ltd		Leigh, Lancashire
6777	100360	Max Schön  GmbH		Lübeck
6778	100361	Hammer Markt Krahm GmbH		Müschenbach
6779	100362	UAB MEDVALDA	Mr. Vaidas Trinkunas	Utena
6780	100363	Peter Kasberger GmbH		Vilshofen-Pleinting
6781	100364	Raiffeisen Waren GmbH		Weimar
6782	100365	BOUWFIX NOORD HOOGEVEEN B.V.		Hoogeveen
6783	100366	Venanz Fischer	Baustoffzentrum	Ebersdorf
6784	100367	Joachim Meißner	Bohr- und Diamantwerkzeuge	Amelinghausen
6785	100368	Fr. Dähmlow GmbH & Co. KG	L80804	Neumünster
6786	100369	Neukunde_NL	KOPIERVORLAGE nicht überschreiben!	Ort
6787	100370	Hammer Markt Krahm GmbH		Waldbröl
6788	100371	NOLIEM SAS	Batiment Firm	SAINT FONS
6789	100372	Stieper GmbH & Co KG		Nortorf
6790	100373	Hermann Bach GmbH & Co. KG		Soest
6791	100374	Metall Markert GmbH		Crottendorf
6792	100375	Van Eyck BVBA		Kampenhout
6793	100376	Ernst Sander e.K.		Ratzeburg
6794	100377	Thiele Industriebedarf	Inh. Max Thiele	Zittau
6795	100378	Clever Diamond GmbH		Remscheid
6796	100379	Fist Baugeräte GmbH		Gau Algesheim
6797	100380	Richard Petersen	Inh. Stefan Jähde e.K.	Schleswig
6798	100381	Gebr. Hatebur Bau-Fachmarkt		Olfen
6799	100382	Eduard Roeseler	Ihn. Gerd Roeseler	Stade / Elbe
6800	100383	UAB "Bio raukstuva"	Company code: 302677908	Utena
6801	100384	Kemmler Baustoffe GmbH		Balingen
6802	100385	Dachdecker Einkauf West eG	Zweigniederlassung Dortmund	Dortmund
6803	100386	Hans Treiber	Werkzeuge-Maschinen GmbH	Henstedt-Ulzburg
6804	100387	Walter Prause	Inh. Ing. Arno Jeskulke	Luebeck
6805	100388	MADATEX s.r.o.		Púchov
6806	100389	Hermann Bach GmbH & Co. KG		Worbis
6807	100390	Matthias Lerche	Lerche Schweißtechnik	Mockrehna
6809	100392	Jennings Engineering Supplies Ltd	Crosby Croft	Maldon, Essex
6810	100393	Dexis Belgium NV		Hasselt
6811	100394	Dachdecker Einkauf Ost eG	Zweigniederlassung Magdeburg	Magdeburg
6812	100395	Peter Hellmich KG		Berlin
6813	100396	Luhmann Holzhandel GmbH		Celle
6814	100397	Baustoffcenter Oschersleben	GmbH & Co. KG	Oschersleben
6815	100398	Mapeco Vilvoorde		Vilvoorde
6816	100399	TRENOIS DECAMPS		Wasquehal
6817	100400	Michael Bubolz	Zerspannungstechnik GmbH	Stuhr
6818	100401	SEDISA SAC		Surco - Lima
6819	100402	S & S Montagesysteme		Delmenhorst
6820	100403	Baucentrum Stewes GmbH & Co. KG		Gladbeck
6821	100404	W + B Wehling + Busert GmbH		Südlohn
6822	100405	Toolexpert Benelux BV	Toolstation Europe Ltd.	Bleiswijk
6823	100406	Bor Sag og Meiselteknikk AS		Lakseväg
6824	100407	MILO-Tec Vertriebs GmbH		Beringen
6825	100408	LAMET s.n.c.		Torino
6826	100409	Schröder Bauzentrum		Borstel-Hohenrade
6827	100410	Dachdecker-Einkauf Ost eG	Zweigniederlassung Berlin-	Berlin
6828	100411	Heinz Sanders GmbH		Meppen
6829	100412	JK Supplies Ltd	4 Hillside Cottages	Hemel Hempstead, Hertfordshire
6830	100413	Raiffeisen Waren GmbH		Kassel
6831	100414	Sleiderink Bouwmaterialen		Oldenzaal
6832	100415	Walter Wesemeyer GmbH		Bad Oldesloe
6833	100416	Brumberg	Werkstatt-Garten-Freizeit	Wehr
6834	100417	Müller & Schnigge		Herzberg
6835	100418	Hass+Hatje GmbH		Bornhöved
6836	100419	Bauwaren Mahler GmbH & Co. KG		Unterdießen
6837	100420	Bauwaren Mahler GmbH & Co. KG	Hagebaumarkt	Augsburg
6838	100421	August Landahl & Carl Mohns	Werkzeug Großhandels Ges. mbH	Hamburg
6839	100422	Kroon B.V.		Hoogezand
6840	100423	Emil Lüdemann GmbH & Co KG	Eisenwaren-Werkzeuge	Hamburg - Stellingen
6841	100424	Hillari Fliesen Center GmbH		Burgau
6842	100425	SVH Handels-GmbH		Dortmund
6843	100426	Würth Industrie Service		Bad Mergentheim
6844	100427	BMN Ijzerwaren		Katwijk
6845	100428	Raiffeisen Waren GmbH		Eschwege
6846	100429	BAUIGEMA-Siegfried GmbH		Geraberg
6847	100430	Trading House Trade Tools Ltd.		Moscow
6848	100431	Werkzeug- und Baugerätehandel	Bernd Evermann	Wittenburg
6849	100432	KMG Ltd.	Ivy House	Salford
6850	100433	Team Thaler GmbH	Diamantwerkzeuge	Oberau
6851	100434	SIGCA Ruislip		South Ruislip
6852	100435	Target Tools Supply Ltd		Hartlepool
6853	100436	Schäfer Baustoffe Vertriebs GmbH		Wartenberg-Rohrbach
6854	100437	Baustoff Netzband GmbH		Elbe-Parey OT Derben
6855	100438	Herm. Stocks & Co. (GmbH & Co.)		Hamburg
6856	100439	Ardling Asesoria Integral Eirl	AV. Parque De las Leyendas	Lima Peru
6857	100440	BT Brammer Distributiecentrum Venlo		Venlo
6858	100441	Otto Nilsson GmbH & Co. KG	Nilsson Meldorf	Meldorf
6859	100442	Huber & Riedel GmbH		Gunzenhausen
6860	100443	Zitzmann Baustoffe-Betonwerk		Schwarzenfeld
6861	100444	Raiffeisen Bezugs- u. Handels-	gesellschafft	Grünhainichen
6862	100445	hawo GmbH		Heppenheim
6863	100446	Heinz Schäfer GmbH	Schäfer Leverkusen	Leverkusen
6864	100447	Baustoffzentrum Tepker	Tepker Osterrönfeld	Osterrönfeld
6865	100448	Dachdecker-Einkauf Ost eG	Zweigniederlassung Spandau	Spandau
6866	100449	Kölner Bauzentrum	MOBAU Linden	Köln
6867	100450	SIGF Cambridge	Unit 1	Cambridge
6868	100451	Otto Röhrs GmbH	Röhrs Onlineshop Ruh	Scheeßel
6869	100452	Auer Landshut		Landshut
6870	100453	C. Wölfling KG	Beschlag Befestigung Elemente	Pirmasens
6871	100454	BAUKING Südwestfalen GmbH	FH Siegen-Geisweid	Siegen-Geisweid
6872	100455	Quadriga Gerüstbau GmbH	Quadriga Fachhandel für Gerüstbau	Berlin
6873	100456	FALANO GmbH	Warenvertriebsgesellschaft mbH	Vechta Langförden
6874	100457	Dobermann Baustoffhandelsges.		Münster
6875	100458	Leitermann GmbH & Co.	Fachmarkt KG	Lödla
6876	100459	Theodor Erich	Großhandels GmbH	Hamburg
6877	100460	Foxtool	Inh. Mirko Schweidler	Königsbrück
6878	100461	CEF Elektrofachgroßhandlung	Südwest GmbH	Möhringen
6879	100462	Eisen-Wolff GmbH		Hamburg
6880	100463	RIS Consulting- und Industrie-	service GmbH	Steinen
6881	100464	Gerhard Borchert		Velten
6882	100465	Handelshof Riesa GmbH	Niederlassung Glauchau	Glauchau
6883	100466	H.J. Bünder GmbH		Euskirchen
6884	100467	Henrich Baustoffzentrum	Siegburg	Siegburg
6885	100468	CEF Elektrogrosshandlung		Möhringen
6886	100469	Friedrich Lange GmbH		Hamburg
6887	100470	Friedrich Kabrinke	Raumausstatter- und Polstereibedarf	Altenholz
6888	100471	Elektromaschinen Wölke		Recklinghausen
6889	100472	Sleiderink Hout	& Bouwmaterialien B.V.	Denekamp
6890	100473	Beckmann Bauzentrum GmbH & Co. KG		Norderstedt
6891	100474	Borgers Baustoffe		Hamminkeln
6892	100475	I+M Bauzentrum Retagne GmbH		Dornburg
6893	100476	DEG Alles für das Dach eG		Koblenz
6894	100477	Theissen Bauzentrale KG		Rath-Anhoven
6895	100478	Quantum Group		Eglinton
6896	100479	PROFI Bedachungsmarkt Großenhain	Niederl. der ELG Bau Meissen eG	Großenhain
6897	100480	Holzkontor GmbH		Gardelegen
6898	100481	Orchard Fasteners Ltd.	Unit 38	Co Armagh
6899	100482	Baucenter Hans Widmann		Schwäbisch Gmünd
6900	100483	Tech-Mont	Spólka Jawna Z.Klimek	Krakow
6901	100484	SIG Tech Ins Portsmouth		Portsmouth
6902	100485	Baubedarf Berg und Mark eG		Solingen
6903	100486	Ute Orth GmbH & Co.KG	Bekleidung & Technik	Geesthacht
6904	100487	Giebels & Strack	Baumaschinen GmbH	Viersen
6907	100490	Mobau Erft Frechen	Bauzentrum GmbH & Co. KG	Frechen
6908	100491	Kuhl & Jungbluth OHG		Wuppertal
6909	100492	Sanet J.A. Szostak Sp.J.		Gdánsk
6910	100493	ETM Elektrotechnik GmbH		Ludwigslust
6911	100494	Koehler Fachhandel e.K.	Inh. Nadine Koehler	Bärenstein
6912	100495	August Krämer GmbH		Kiel
6913	100496	Mobau Baustoff-Union GmbH		Aachen
6914	100497	HIW  Handwerker- u. Industrie	Werkzeuge Handelsgesellschaft mbH	Hamburg
6915	100498	A.Karstensen GmbH & Co.		Sylt / OT Keitum
6916	100499	Vosmerik Ltd.		Saint-Petersburg, Stepana
6917	100500	SAS LM Aciers Outillages F-I		Alixan
6918	100501	Secure Systems International (SSI)	Pte ltd.	Singapore
6919	100502	Werkzeug Hettich		Achstetten
6920	100503	PVR Direct Ltd	Olympia house	Brislington, Bristol
6921	100504	Werkzeugstore24 GmbH		Flörsheim
6922	100505	RAMO Handels GmbH		Zug
6923	100506	HKL Baumaschinen GmbH	Buchhaltung	Hamburg-Hummelsbüttel
6924	100507	Stammelbach Karl Krüger	GmbH & Co. KG	Hildesheim
6925	100508	MAKRO	Handels-GmbH u. Co. KG	Itzehoe
6926	100509	Iccons Pty Ltd		Dandenong South VIC 3175
6927	100510	TEAM PRO SAL	EDWAN BULDING	BEIRUT
6928	100511	AccurA Diamond Tools Ltd.	Unit 69, Accura House	Parkwest, Dublin 12
6929	100512	Northern Diamond Sales Ltd.	Unit 1A	Kendal
6930	100513	DrillBitsUK Ltd	Number One Industrial Estate	County Durham?????
6931	100514	ROMI-Technik GmbH		Lustadt
6932	100515	Baufuchs GmbH		Osterburken
6933	100516	Werkzeug Lorenz - Werlo24		Gerabronn
6934	100517	Rudolf Sievers GmbH	Partner für Technik	Seevetal-Hittfeld
6935	100518	Richter KG		Schleswig
6936	100519	SIGF London	Unit 6	London
6937	100520	SIG Insulation	Unit 4	Ruislip
6938	100521	Ernst Hasselbring GmbH & Co.KG		Cuxhaven
6939	100522	interNeo Technologie & Service GmbH		Berlin
6940	100523	Nadine Bartylla	Heller Tools GmbH	Dinklage
6941	100524	De Stalen Greep nv	tav. Dave	Tielt
6942	100525	Federn Oßwald	Fahrzeugteile	Zella Mehlis
6943	100526	Gebr. Dapprich GmbH		Wuppertal
6944	100527	Zweygart Fachhandelsgruppe GmbH	& Co. KG	Ehningen
6945	100528	Technische Bouwservice BV		IJsselstein
6946	100529	Plankunde Australien, Asien		Plankunde
6947	100530	UAB KESKO SENUKAI LITHUANIA		Kauno
6948	100531	Plankunde Ost-Europa		Plankunde
6949	100532	Plankunde ehem. Soviet Staaten		Plankunde
6950	100533	EURL Felix Materiaux		Vernoux En Vivarais
6951	100534	Plankunde Russland		Plankunde
6952	100535	Rohwein Export / Import		Dortmund
6953	100536	Mingau Baumaschinen GmbH		Senftenberg / Kleinkoschen
6954	100537	Schurmann Industriebedarf-	Handelsgesellschaft mbH	Reinbeck
6955	100538	Gedimat Montagnat	SA	Saint Jean De Bournay
6956	100539	Plankunde Mittlerer Osten, Afrika &	Indien	Plankunde
6957	100540	Plankunde Nord-Amerika		Plankunde
6958	100541	Dübel & Bohrer GmbH	Technische Beratung - Lager	Hamburg
6959	100542	Plankunde Iberia		Plankunde
6960	100543	Plankunde Nordic		Plankunde
6961	100544	Sermatec sàrl		Ehlerange
6962	100545	HG Bau- und Hobbymarkt GmbH		Rüsselsheim
6963	100546	Franz Schoppe GmbH & Co. KG	Industrie- u. Schiffsbedarf	Kiel
6964	100547	Plankunde Süd-Europa		Plankunde
6965	100548	Plankunde DACHL TCG		Plankunde
6966	100549	Plankunde Nordic TCG		Plankunde
6967	100550	Metzger Baustoffshop GmbH & Co. KG		Schwerte
6968	100551	AGEFA Werkzeug- und Maschinen-	Handelsges. mbH	Balingen
6969	100552	Ennens GmbH & Co.KG	Bau- und Industriebedarf	Heede
6970	100553	Handelsonderneming DIRKS B.V.		Beek
6971	100554	Gedimat Michel		St Pierre Du Regard
6972	100555	Eisen Trabandt GmbH		Stade
6973	100556	HSB Handels- u. Servicegesellschaft	für Baumaschinen mbH	Ensdorf
6974	100557	Jacobs-Handelsges. mbH		Hemmingstedt
6975	100558	Salchow & Berger Baubedarf GmbH		Essenbach-Altheim
6976	100559	Baumaschinen Hartmann		Holthusen
6977	100560	OT Facilities Ltd		West Sussex
6978	100561	Köhler GmbH Baumaschinen		Achern
6979	100562	Bauking Südwestfalen GmbH		Waldbröl
6980	100563	ESD Bricotech Bricopro		Beaurepaire
6981	100564	FPC Diffusion		Mommenheim
6982	100565	SAS Francois Perrin		Morestel
6983	100566	CMT Equipment Ltd	Dartford Works	Dartford
6984	100567	Raiffeisen Waren GmbH	NL Halle/Saale	Halle/Saale
6985	100569	Trade Fast Distribution	(Midlands) Ltd	Uttoxeter, Staffordshire
6986	100570	W. Renner GmbH		Weilheim
6987	100571	Röco GmbH		Dortmund
6988	100572	Union Bauzentrum Hornbach GmbH		Dahn
6989	100573	LOESCH shop GmbH		Quickborn
6990	100574	Baucentrum Stewes GmbH & Co. KG		Duisburg
6991	100575	Tout Faire Euromat	Zac Du Breuil	Messein
6992	100576	FIX2PRO		Charenton-le-Pont
6993	100577	Krapp Eisen GmbH & Co.KG		Schneverdingen
6994	100578	Würth HandelsgesmbH		Böheimkirchen
6995	100579	MOBAU Müller Baustoff-Kontor GmbH		Hänichen
6996	100580	MARWITZ Baumaschinenhandel	GmbH & Co.KG	Hamburg 20
6997	100581	WACK Builers Wholesale Ltd	Unit 1 Hawkshaw Farm Business Park	BLACKBURN
6998	100582	Gerätebau Wiedtal - Schützeichel	GmbH & Co. KG	Neustadt/Wied
6999	100583	Plankunde Holland & Belgien		Plankunde
7000	100584	Plankunde DACHL		Plankunde
7001	100585	Walter Gronemeyer KG		Norderstedt
7002	100586	Kinex Oy		Kuopie
7003	100587	J. Materiaux	Tout faire	Vigneulles Les Hattoncha
7004	100588	Tout Faire Sezanne Materiaux		Sezanne
7005	100589	Plankunde Frankreich		Plankunde
7006	100590	SARL Rigaud Materiaux	et Combustibles	Villeneuve De Berg
7007	100591	Tout Faire Mat Bois		Grandpre
7008	100592	Plankunde England		Plankunde
7009	100593	Plankunde England TCG		Plankunde
7010	100594	DEG Dach-Fassade-Holz eG		Rosdorf
7011	100595	BMN Wijcks Den Bosch		Hertogenbosch
7012	100596	Putzier GmbH	Werkzeuge und Eisenwaren	Lünen
7013	100597	UNITED EQUIPMENT & CONSTRUCTION CO	Mr. Usama Ibrahim A. Muathy	Heliopolis
7014	100598	CSH Industries (S) PTE LTD		Singapore
7015	100599	Baustoffe May GmbH		Bamberg
7016	100600	KSA Toolsystems GmbH		Bühl
7017	100601	Yenne Materiaux	Et Combustibles	Yenne
7018	100602	CMPM Folschviller	TMC	Folschviller
7019	100603	Werkzeug-Doering GmbH		Wuppertal
7020	100604	Support System (Nottm) Ltd	Fixings & Fabr.Building Services	Attenborough, Nottingham
7021	100605	Plumbers Choice DIY		Bradford
7022	100606	Teow Herramientas S.R.L.	Playa negra entrada pan dulce,	Puerto Viejo de Talamanca
7023	100607	Neukunden-Angebot DE		Dinklage
7024	100608	Neukunden-Angebot GB		Dinklage
7025	100609	Neukunden-Angebot ENG €		Dinklage
7026	100610	J.A. Sonntag	Inh. Horst Sonntag	Bonn
7027	100611	ElecMec Wholesale Ltd		Middlesex
7028	100612	Neukunden-Angebot NL		Dinklage
7029	100613	Neukunden-Angebot ES		Dinklage
7030	100614	Neukunden-Angebot FR		Dinklage
7031	100615	Midifix SAS		Avignon
7032	100616	HVS Scherer	Inh. Robeer Scherer	Frankfurt
7033	100617	W. Hartmann & Co. (GmbH & Co.KG)		Oststeinbek
7034	100618	Peter Mueller GmbH		Gummersbach
7035	100619	Dach-Fassade-Holz Mittelweser GmbH		Drakenburg
7036	100620	i&M-Bauzentrum Mobau Wechmar	Karl Gerlach & Sohn GmbH & Co.KG	Drei Gleichen
7037	100621	Brand - Cuse	Tout Faire Matériaux	Cuse Et Adrisans
7038	100622	Heinrich Becker Söhne GmbH & Co. KG		Bonn
7039	100623	Karl Birlenbach GmbH & Co.		Limburg
7040	100624	Manfred Klemm		Frechen
7041	100625	SAS Trieves Materiaux - Mens		Mens
7042	100626	Schweizer & Vom Hofe		Wuppertal
7043	100627	Bautreff Pawella GmbH		Bottrop
7044	100628	Tout Faire Girard - Sederon	Girard Bernard Eurl	Sederon
7045	100629	BUCH	Präzisionswerkzeuge GmbH	Hohen Neuendorf
7046	100630	Dieker & Voss GmbH		Gescher
7047	100631	Geveler GmbH & Co. KG		Gronau
7048	100632	Baustoff-Hoffmann GmbH		Kreuztal
7049	100633	Rudolf Graf GmbH & Co. KG		Nagold
7050	100634	Baustoffhandel Remde GmbH		Eisenberg
7051	100635	Qwikfast Trade + DIY Supplies Ltd.		Dorset
7052	100636	KRESS-elektrik GmbH & Co. KG	z.Hd. Frau Kathrin Fischer	Bisingen
7053	100637	Tout Faire Proximat	CAM 53 Pré en Pail	Pre en Pail
7054	100638	Bauzentrum Sandhack GmbH		Schenefeld
7055	100639	Bozel Materiaux		Bozel
7056	100640	T & D Supplies Ltd.	(TD Cladding)	Hull
7057	100641	GIOKAS MPETHANIS S.A		Athen
7058	100642	Meier-Baustoffe		Lauterhofen
7059	100643	Contact Industrial Supplies		Brynmenyn, Bridgend
7060	100644	Roof Business	Torsten Miege	Wutha-Farnroda
7061	100645	Vos Tools		BOOM
7062	100646	Bauzentrum Tönnes	GmbH & Co.KG	Wermelskirchen
7063	100647	Hagema AG		Bäriswil
7064	100648	Wentowsee Handelshaus GmbH	Baustoffhandel und Baumarkt	Gransee
7065	100649	SAS ASTU'PIEUX		Dingsheim
7066	100650	PT AKG Indonesia	Ariobimo Sentral Building 4th floor	Jakarta
7067	100651	Prodhomme - Athis	Prod' Homme B.T.P. S.A.R.L.	Athis De L'Orne
7068	100652	hagebau Profi Fachmarkt	Handelsg. f. Baustoffe mbH & Co.KG	Soltau
7069	100653	Walter Felden		Niederzissen
7070	100654	Achim Schomberg		Bad Wünnenberg
7071	100655	Lenpart Ltd.		London
7072	100656	Bygg Engros AS		Nestun
7073	100657	B. F. Weber	Verpackungs GmbH	Saarbrücken
7074	100658	SAS Comptoir de Materiaux du Port	de Met	Ennery
7075	100659	CMPM Boulay		Boulay
7076	100660	CMPM CREUTZWALD		Creutzwald
7077	100661	CMPM Metz		Metz
7078	100662	CMPM YUTZ		YUTZ
7079	100663	CMPM BETTING LES ST AVOLD		BETTING LES ST AVOLD
7080	100664	ACU Klebeband Rößler GmbH & Co.KG		Wermelskirchen
7081	100665	ENGA Schweißtechnik	Inh. Heinz Arntzen e.K	Salzbergen
7082	100666	Carl Claßen	Eisengrosshandlung	Eschweiler
7083	100667	Service Stock Van Iseghem BVBA		Ingelmunster
7084	100668	Robin Klautzsch	Eisenwaren	Derschen
7085	100669	ILL & CO UG		Wegberg
7086	100670	hagebau centrum	B. Frieling GmbH & Co.KG	Gronau-Epe
7087	100671	Schröder Bauzentrum GmbH Heide	& Co.KG	Heide
7088	100672	SAS Bonnet Matériaux		Chatillon-Saint-Jean
7089	100673	A. Karstensen GmbH & Co.KG		Niebüll
7090	100674	Danetre Workshop Supplies Limited	3 Baird Close	Daventry, Northamptonshire
7091	100675	Raab Karcher Breda		Breda
7092	100676	Hermann Bach GmbH & Co. KG		Paderborn
7093	100677	Schubert Tacke GmbH & Co.KG		Velbert
7094	100678	Kock Sägewerkstechnik OHG		Moorrege
7095	100679	Walter Nilsson GmbH & Co. KG	Baufachzentrum OS-Haste	Osnabrück
7096	100680	Heinrich Küpper e.K.		Gummersbach
7097	100681	Grenzland Baugeräte	Handels GmbH & Co.KG	Hückelhoven
7098	100682	Edmundson Electrical Ltd	Calder House	Blackpool
7099	100683	GAUDELAS		Chailles
7100	100684	NEGOFIX	NEUVIL DISTRIBUTION	Laval
7101	100685	E. Volz Werkzeughandels GmbH		Mayen
7102	100686	Runge-TSN	Technischer Service Nord GmbH	Kisdorf
7103	100687	Taktfest srl		Sat Rosu / Comuna chiajna
7104	100688	SB Tools ltd	Unit 8 Granby Court	Weymouth
7105	100689	Klaus Delvos GmbH		Düsseldorf
7106	100690	Bayrische Bohrerwerke GmbH		Buchlberg, Passau
7107	100691	UHUD TEKN?K HIRDVAT	SAN.VE T?C.LTD.?T?.	Kayseri
7108	100692	Mayrose Lingen GmbH & Co. KG		Lingen
7109	100693	SOSACA Draguignan		Draguignan
7110	100694	Segl Bauzentrum GmbH -	Hagebaumarkt Waldkirchen	Waldkirchen
7111	100695	MIGACUT		Moosburg/Isar
7112	100696	Mobau Dörr & Reiff GmbH		Schleiden
7113	100697	Technolit	Der Werkstattexperte	Großenlüder
7114	100698	Plankunde DACHL HB Gebiet 1		Plankunde
7115	100699	Plankunde DACHL HB Gebiet 9		Plankunde
7116	100700	Vakuum Technik GmbH Eibenstock		Eibenstock
7117	100701	Plankunde DACHL HB Gebiet 7		Plankunde
7118	100702	Plankunde DACHL HB Gebiet 5		Plankunde
7119	100703	Toolfast		Co Wicklow
7120	100704	SAS LAMBERT ET FILS		Marigny ST MARCEL
7121	100705	Plankunde DACHL HB Gebiet 3		Plankunde
7122	100706	Plankunde DACHL HB Gebiet 2		Plankunde
7123	100707	BMN Vlaardingen		Vlaardingen
7124	100708	Richter Baustoffe GmbH	(hagebau kompakt Heiligenhafen)	Heiligenhafen
7125	100709	Gebrüder Löffler GmbH - Baustoffe		Gera
7126	100710	HiKOKI Power Tools	Deutschland GmbH	Willich
7127	100711	BBK Baubedarf Konz GmbH & Co.KG		Wasserliesch
7128	100712	Karl Rother GmbH		Köln
7129	100713	Danhauser GmbH & Co KG		AMBERG
7130	100714	SING KEE METALWARE CO LTD		Tsuen Wan, N.T, Hong Kong
7131	100715	SAS DIAGER		Poligny
7132	100716	Seipel Industriebedarf KG		Hanau
7133	100717	FixMek Oy		Kerava
7134	100718	Wise Ltd		Redditch
7135	100719	A.S.F. Fischer BV		AN Lelystad
7136	100720	EURL VISSERIE ET TECHNOLOGIE	D'ASSEMBLAGE	Yutz
7137	100721	Würth Norge AS		Hagan
7138	100723	Gebrüder Löffler GmbH Baustoffe		Plauen
7139	100724	Raiffeisen Waren GmbH		Neustadt/Orla
7140	100725	BLASTRAC BV		Nieuwegein
7141	100726	Bauking Südwestfalen	FH Attendorn	Attendorn
7142	100727	Jiangsu Sanyeung Tools Co., Ltd.		Danyang City,Jiangsu Province
7143	100728	BMN Nelemans Breda		Breda
7144	100729	BRICOFER		Richwiller
7145	100730	??? "Benzinger Avto"		Tver
7146	100731	Lüttmann Werkzeugmaschinenv. GmbH		Rheine
7147	100732	BWI-Wahl GmbH	Inh. Lothar Wahl	Bonn
7148	100733	Raiffeisen Waren GmbH	Niederlassung DHT Stockstadt	Stockstadt am Rhein
7149	100734	Wocken Industriepartner	GmbH & Co.KG	Meppen-Ems/Nödike
7150	100735	Kull, Ritzert & Hofstetter GmbH		Bingen am Rhein
7151	100736	Hermann Bach GmbH & Co. KG		Nordhausen
7152	100737	Techro GmbH Industrietechnik	Maschinen-Werkzeuge	Roesrath
7153	100738	Arns + Römer  KG		Iserlohn
7154	100739	??? ”??????”	“TIREX” Ltd.	Moskau
7155	100740	Wocken Industriepartner	GmbH & Co. KG	Quakenbrück
7156	100741	Ströbl e.k. Landmaschinen	Fachmarkt	Beilngries
7157	100742	Pegasus Kitchens and Bathrooms		Harrow, Middlesex
7158	100743	Knorpp Baustoffe GmbH		Fellbach
7159	100744	Heribert Sohlmann GmbH	Industriebedarf	Emsdetten
7160	100745	H.-P. Krämer GmbH & Co. KG		Reich
7161	100746	Heykes GmbH	Diamantwerkzeuge	Wiesmoor
7162	100747	BMN Middelburg		Middelburg
7163	100748	hw Hortmann + Wolf GmbH		Siegen-Weidenau
7164	100749	BMN Oldenzaal		Oldenzaal
7165	100750	BMN Rijssen		Rijssen
7166	100751	VR PLUS Altmark Wendland eG		Osterburg
7167	100752	NL Raab Karcher Winnenden	STARK Deutschland GmbH	Winnenden
7168	100753	SAS AIR OUTIL ELECTRIC SERVICE	Z.I les Grandes Raies	Ludres
7169	100754	EURL DONAS PHILIPPE OUTILLAGE		CHATENOIS LES FORGES
7170	100755	Schönamsgruber	Ersatzteile GmbH	Burgbernheim
7171	100756	Gottfried Wiedmann GmbH		Alfdorf
7172	100757	FB Handel und Industrieservice		Torgelow
7173	100758	Express Electrical Distributors	Limited	Wigan
7174	100759	A+B Werkzeuge Maschinen Handels Gmb		Ahaus
7175	100760	Bauking Ostfalen GmbH		Leipzig
7176	100761	LEIGH TIMBER MERCHANTS	UNIT 14	Leigh
7177	100762	PROBEMAT	BigMat	Ste Reine de Bretagne
7178	100763	SOSACA		SAINT MAXIMIN
7179	100764	Kipp & Grünhoff GmbH & Co. KG		Monheim
7180	100766	Neukunde DE		Dinklage
7181	100767	BERGIN Werkzeugmärkte GmbH		Biedermannsdorf
7182	100768	Otto Frackenpohl GmbH & Co.KG		Gummersbach
7183	100769	Su-Re SAS		Pouilly-sur-Loire
7184	100770	Nordwest Handel AG Lager Heller		Dortmund
7185	100771	Nordwest Handel AG		Dortmund
7186	100772	AU FAITE 90 SA		Grandvillars
7187	100773	BVG Cementmüller Baustoffvertrieb	GmbH - hagebaumarkt Soltau	Soltau
7188	100774	MAAS Bauzentrum GmbH		Ilshofen
7189	100775	Baugeräte-Kreis	Nordwest Handel AG	Dortmund
7190	100776	Carl Hossfeld e. Kf.		Hagen
7191	100777	DELVA SHOPPING NV		VEURNE
7192	100778	Bausando GmbH		Bohmte
7193	100779	Nordwest Handel AG	Werkzeug-Kreis	Dortmund
7194	100780	Gebr.Herlitzius	Werkzeuge - Maschinen	Wadersloh
7195	100781	Heller Produktmanagement	Felix Penkhues	Dinklage
7196	100782	Thorsten Draeger Intern		Dinklage
7197	100783	Hubert Blechmann GmbH & Co. KG		Wipperfürth
7198	100784	Lanvers Materiaux	S.A.S.	Nernier
7199	100785	SIG Int Edmonton		Edmonton, London
7200	100786	W & M Urban	Werkzeuge, Maschinen, Eisenwaren	Korntal Münchingen
7201	100787	Toolstation (Daventry) Ltd	Unit 3, Parsons Road	Daventry
7202	100788	hagebaucentrum Bolay GmbH & Co. KG	(Baustoffhandel)	Rutesheim
7203	100789	TCG Allgemein		Dinklage
7204	100790	Mungo Italia S.r.l.		Padova (PD)
7205	100791	SIG Int Leeds Elland Road		Leeds
7206	100792	SIG Ins Witney		Witney
7207	100793	SIG Fixings	Intermezzo Drive	Leeds
7208	100794	Hommel Hercules	Werkzeughandel GmbH & Co. KG	Koeln/Ossendorf
7209	100795	Götz + Moriz GmbH	(Baustoffe)	Freiburg
7210	100796	SIG Int Glasgow Govan		Glasgow
7211	100797	Sievers GmbH		Rheda-Wiedenbrück
7212	100798	Röggi ehf	Mr. Arnar Hrólfsson	Reykjavik
7213	100799	DGS Supplies LTD.	Unit 1&3 Building 38	Dudley
7214	100800	Fortress Fasteners Ltd.	Unit 10, Twin Brook Business Park	Clitheroe
7215	100801	Rutenbeck GmbH & Co. KG		Kerpen-Türnich
7216	100802	One Stop Hire Ltd.		Wrightington
7217	100803	Steinrück GmbH & Co. KG		Wuppertal
7218	100804	Bauking Südwestfalen	Hagebau centrum Meschede	Meschede
7219	100805	Blumenbecker Industriebedarf GmbH		Soest
7220	100806	Heinrich Rießelmann GmbH		Dinklage
7221	100807	Thies & Co GmbH	Fachmarkt	Verden
7222	100808	hagebaucentrum Salzwedel GmbH	(Baustoffe)	Salzwedel
7223	100809	Gebrüder Löffler GmbH -Baustoffe	(Ndl. Weida)	Weida
7224	100810	SIG Int Twickenham		London
7225	100811	SIG Tech Ins Leicester		Leicester
7226	100812	Mölders Baucentrum GmbH	(Niederlassung Adendorf)	Adendorf
7227	100813	Hans Schuy Baustoffgesellschaft	mbH	Langenfeld
7228	100814	E. Wertheimer GmbH	(Baustoffe)	Baden-Baden
7229	100815	E. Wertheimer GmbH	(Baustoffe)	Karlsruhe
7230	100816	Rudolf Sievers GmbH	Partner für Technik	Geesthacht
7231	100817	SIG Ins Bristol Filton		Bristol
7232	100818	Pollin Electronic GmbH		Pförring
7233	100819	Karl Koerschulte GmbH		Lüdenscheid
7234	100820	SIG Ins Cardiff		Cardiff
7235	100821	SIGCA Tyneside		Dunston
7236	100822	Richard Schultheis	Werkzeuge-und Maschinen OHG	Menden
7237	100823	SIG Int Manchester KP		Manchester
7238	100824	Wilhelm Felden & Kaiser & Roth KG	Handels-GmbH & Co.	Marburg
7239	100825	Konrad Schmidt Diamanttechnik		Bensheim-Auerbach
7240	100826	FKR Baucentrum GmbH & Co. KG		Schwalmstadt
7241	100827	Rüschenschmidt & Tüllmann	GmbH & Co. KG	Münster
7242	100828	Consumables Solutions Limited	Unit 4 - Ignition Park	Swindon
7243	100829	Plankunde DACHL HB Gebiet 6		Plankunde
7244	100830	SEEFELDER GmbH	Niederlassung Hamburg	Hamburg
7245	100831	Plankunde Süd-Amerika		Plankunde
7246	100832	Anne-Laure Benveniste Gousis		Agia Paraskevi Athen
7247	100833	Mann Hire Ltd	Plot 4, Rural Industries Estate	Braddan
7248	100834	Giotopoulou Victoria Tools & Safety		Thessaloniki
7249	100835	Profi-Service OHG		Recklinghausen
7250	100836	BMN Den Haag - Zuid		Den Haag
7251	100837	Geco Verhuur en Verkoop		Wijk bij Duurstede
7252	100838	Central Fasteners (Staffs) Ltd		Stafford
7253	100839	NV J. TRENTELS-STEVENS		Mechelen
7254	100840	Denken Peru		Lima
7255	100841	Heller Innendienst		Dinklage
7256	100842	Andreas Seufert		Waldkirchen
7257	100843	KALOUMENOS I. GEORGE & SIA OE	Industrial & Electrical Supplies	Tauros
7258	100844	Muster Neukunden INT		Dinklage
7259	100845	Industrieservice Bauch GmbH		Alsdorf
7260	100846	MABI SARL		Botans
7261	100847	Ulf Neuhaus Industrieservice		Unna
7262	100848	Plankunde Frankreich TCG		Plankunde
7263	100849	Plankunde Holland & Belgien TCG		Plankunde
7264	100850	Ability Supplies UK Limited	5 Frontier Court	Sunderland
7265	100851	Plankunde Iberia TCG		Plankunde
7266	100852	ECONOMOTECHNIKI S.A.		Athens
7267	100853	FIC - Chalon Sur Saone	Fournitures Industr. Chalonnaises	Chalon Sur Saone
7268	100854	Plankunde Süd-Europa TCG		Plankunde
7269	100855	ARVALISCOM SRL		Chisinau Rep.of Moldova
7270	100856	Plankunde Russland TCG		Plankunde
7271	100857	IOANNIS K. DORZIS LTD		Limassol Cyprus
7272	100858	Becker-Jostes GmbH & Co KG		Sundern
7273	100859	Infinite Bargains	Unit 4A	County Durham
7274	100860	Plankunde Ost-Europa TCG		Plankunde
7275	100861	SARL SOC PABION		SOYONS
7276	100862	Plankunde ehem. Soviet Staaten TCG		Plankunde
7277	100863	Plankunde Australien, Asien TCG		Plankunde
7278	100864	August Ring GmbH	Beschläge & Werkzeuge	Velbert
7279	100865	Handelshof Bitterfeld GmbH	Partner für Technik	Bitterfeld-Wolfen
7280	100866	Plankunde Mittlerer Osten,  Afrika	& Indien TCG	Plankunde
7281	100867	OSC Sales Ltd.		Linton, Kent
7282	100868	SL Schraub- und Verbindungstechnik		Düren
7283	100869	SARL SYSCO-SARL		DINGSHEIM
7284	100870	Geert Grüppen GmbH & Co. KG	Baustoffhandel	Emlichheim
7285	100871	BIV Bau- und Industriegeräte	Vertriebs GmbH	Treuen
7286	100872	Plankunde North America TCG		Plankunde
7287	100873	Fra-Tools	J.P. Fracheboud AG	CH-Orpund
7288	100874	Scheins Eurofer Baubeschlag-	handel GmbH	Aachen
7289	100875	Plankunde South America TCG		Plankunde
7290	100876	Ahlborn & Co GmbH	Serienfertigung	Binau
7291	100877	VIOPER		Tavros
7292	100878	Ferd. Beleke	Eisenwaren Werkzeuge	Arnsberg
7293	100879	Orim Middle East FZC	Al Muhanad Tower - App 2704	Sharjah
7294	100880	IB-Norm GmbH		Seligenstadt
7295	100882	AS Jürgen Schnetter e. K.		Schöllkrippen
7296	100884	bewako		Herborn
7297	100885	SASU DACAU INDUSTRIES		Decines Charpieu
7298	100886	Ulrich Bunse		Remscheid
7299	100887	Tacke + Lindemann	Baubeschlag- u. Metallh. GmbH+Co KG	Dortmund
7300	100888	Aerotech Abrasives Group Ltd.	Unit 710, Street 3	Wetherby
7301	100889	Alexander Erasmus GmbH & Co	Eisenwaren-Werkzeuge	Düren
7302	100890	RMB Jäger + Höser GmbH		Neu-Anspach
7303	100891	RMB Jäger + Höser GmbH		Löhnberg
7304	100892	Würth AG		Arlesheim
7305	100893	Bau- und Heimwerkermarkt Müllenhoff	GmbH	Medebach
7306	100895	Franko	Werkstattechnik GmbH	Himmelkron
7307	100896	EURL ATOUTBAT		Angoisse
7308	100897	Profi Partner Sp. z o.o.	i Wspólnicy Sp.k.	Warszawa
7309	100898	Fröschke Spezialbaustoffe	Alexander Fröschke	Sonnewalde OT Münchhausen
7310	100899	Gustav Kampmann GmbH	Baumasch.-Baugeraete	Neuss 1
7311	100900	Watermann & Co	Eisenwaren - Werkzeuge	Hagen
7312	100901	Steinrück GmbH & Co. KG		Düsseldorf
7313	100902	RG5 SAS- ROUSSEAU QUINCAILLERIE		Albi
7314	100903	PROXIMAT	TOUT FAIRE VARADES	Varades
7315	100904	Erich Winkler GmbH		Luedenscheid
7316	100905	Blumenbecker Industriebedarf GmbH	Niederlassung Voss Hagen	Hagen
7317	100906	Alexandria Progress Trading Co.	Import license no 5052	Cairo
7318	100907	Van Wijngaarden Groothandel B.V.		Sliedrecht
7319	100908	SAS LORCAMAT		LEMUD
7320	100909	Hoffnung Korea		Haenameup, Haenamgun, Jeonnam
7321	100910	SARL P.S.D.		NORROY LE VENEUR
7322	100911	Neuberger GmbH - Werkzeugservice	CNC-Schleif-Service-Center	Villingen-Schwenningen
7323	100912	Wember GmbH		Hattingen
7324	100913	SA Sablemat		Montois La Montagne
7325	100914	D Macfarlane & Son Ltd		Gateshead, Tyne & Wear
7326	100915	Berndt Deubner GmbH & Co	Baumaschinen und Baugeräte	Aachen
7327	100916	BWM (Baugeräte Werkzeughandel	Minden) GmbH	Minden
7328	100917	Berkenhoff & Thiel GmbH & Co. KG		Hemer
7329	100918	Kleinlein Bauzentrum GmbH		Waltenhofen
7330	100919	BMN Apeldoorn - Zuid		Apeldoorn
7331	100920	BMN Arnhem - Oost		Arnhem
7332	100921	Einkaufsbüro Deutscher      FORMAT	Eisenhändler GmbH	Wuppertal
7333	100922	Universal Tool Hire & Supplies	Patrick William Cuss Christopher	Westbury, Wilts
7334	100923	BMN Assen - Noord		Assen
7335	100924	CMEM		CMEM
7336	100925	Einkaufsbüro Deutscher     HELLER	Eisenhändler GmbH	Wuppertal
7337	100926	BMN Ede		Ede
7338	100927	Dönges GmbH & Co KG		Wermelskirchen
7339	100928	BMN Emmeloord		Emmeloord
7340	100929	POMPAC	ehem. COMAFRANC	POMPAC
7341	100930	BMN Goor		Goor
7342	100931	E/D/E GmbH	Fachkreis Premium	Wuppertal
7343	100932	Nettelbeck GmbH		Wuppertal
7344	100933	Einkaufsbüro Deutscher	Eisenhändler GmbH	Wuppertal
7345	100934	ESPACE EMERAUDE		ESPACE EMERAUDE
7346	100935	BMN Groningen - Oost		Groningen
7347	100936	E/D/E GmbH	Fachkreis Union Werkzeug Handel	Wuppertal
7348	100937	E/D/E GmbH	Fachkreis Werkz./Masch.	Wuppertal
7349	100938	E/D/E GmbH	Fachkreis Handwerkstadt	Wuppertal
7350	100939	BMN Hengelo - Oost		Hengelo
7351	100940	GEDIMAT		GEDIMAT
7352	100941	SA SO SA CA		La Motte
7353	100942	Höynck&Spengler GmbH		Iserlohn
7354	100943	AUBERN		AUBERN
7355	100944	BMN Hillegom		Hillegom
7356	100945	Franzen Schweissbedarf GmbH		Düren
7357	100946	CMPM		CMPM
7358	100947	France Materiaux	SAS	Chambéry
7359	100948	Groupamat		Groupamat
7360	100949	EIS Kooperationszentrale GmbH		Köln
7361	100950	STARMAT		STARMAT
7362	100951	TOUT FAIRE		TOUT FAIRE
7363	100952	BIGMAT		BIGMAT
7364	100953	BMN Hilversum		Hilversum
7365	100954	BMN Kampen		Kampen
7366	100955	Hohoff GmbH	Fachh. f. Werkzeuge & Maschinen	Unna
7367	100956	E.D.E. GmbH Fachkreis Maschinen	für Holz- u. Kunststoffbearbeitung	Wuppertal
7368	100957	BMN Leeuwarden - Oost		Leeuwarden
7369	100958	E.D.E. GmbH	Fachkreis 6 Plus""	Wuppertal
7370	100959	BMN Nieuwleusen		Nieuwleusen
7371	100960	BMN Nijmegen		Nijmegen
7372	100961	Rommelmann GmbH		Münster
7373	100962	E.D.E. GmbH	Fachgruppe IMATEC""	Wuppertal
7374	100963	NOBEX s.r.l.		Siziano (PV)
7375	100964	BMN Raalte		Raalte
7376	100965	AC EMERAUDE SARL	ESPACE EMERAUDE - JETTIGEN	JETTINGEN
7377	100966	BMN Tiel		Tiel
7378	100967	die beschaffer ag	z.Hd. Herrn Martin Krebs	Zürich
7379	100968	BMN Vriezenveen		Vriezenveen
7380	100969	ABT - Allgemeine Befestigungs-	technik	Marl
7381	100970	SAP-Matériaux	SAS TRANSPORT ET MATERIAUX	ARDENTES
7382	100971	E/D/E GmbH	Fachkreis Plus 1	Wuppertal
7383	100972	BMN Waddinxveen		Waddinxveen
7384	100973	SOSACA HELLER - MONTAUROUX	SOSACA	MONTAUROUX
7385	100974	BMN Wolvega		Wolvega
7386	100975	BMN Zutphen		Zutphen
7387	100976	SARL DIAMPRO		WITTELSHEIM
7388	100977	LA CAISSE A OUTILS		EPINAL
7389	100978	BMN Zwolle - Zuid		Zwolle
7390	100979	ETAG Fixings UK	Unit 14E Thames Gateway Park	Dagenham, Essex
7391	100980	ZEUX GmbH & Co. KG		Eschelbronn
7392	100982	LANDMAXX BHG GmbH		Coswig
7393	100983	SOSACA - LES ARCS		LES ARCS
7394	100984	Quincaillerie Corrihons EURL		Saint Pierre du Mont
7395	100985	Roland Lünnemann GmbH		Leverkusen
7396	100987	Baustoffe Geulen GmbH & Co. KG	(Ndl. Würselen)	Würselen
7397	100988	SARL Anderson		ST FIEL
7398	100989	CMPM SARREGUEMINES		SARREGUEMINES
7399	100990	BAUKING Südwestfalen GmbH	(Ndl. Eslohe)	Eslohe
7400	100991	Allo Sales	C/O Kerry Plant & Toolhire Ltd.	Co Kerry
7401	100992	Gebhardt Bauzentrum GmbH		Erlangen
7402	100993	BHG Handelszentren GmbH	(Ndl. Leuthen Baustoffe)	Drebkau / OT Leuthen
7403	100994	Geveshausen - Technischer Handel		Hude-Altmoorhausen
7404	100995	PERRIN MATERIAUX - BOURGOIN	SAS PERRIN MATERIAUX	BOURGOIN JALLIEU
7405	100996	H. Schönenbröcher GmbH		Bergisch-Gladbach
7406	100997	FRANCOIS PERRIN - PORCIEU	MATERIAUX de CONSTRUCTION	PORCIEU-MONTALIEU
7407	100998	RFM Construction Products(M)Sdn.Bhd	No. 37 Jalan Serendah 26/41	Shah Alam - Selangor Darul Ehs
7408	100999	B. Friebertshäuser		Gladenbach
7409	101000	AMW Store		Bad Zwischenahn - Petersfehn
7410	101001	Gebhardt Bauzentrum GmbH	(Ndl. Karlstadt)	Karlstadt
7411	101002	Westfalia	Werkzeugcompany GmbH & Co.KG	Hagen
7412	101003	Gebhardt Bauzentrum GmbH	(Ndl. Fürth)	Fürth
7413	101004	Gebhardt Bauzentrum GmbH	(Ndl. Hammelburg)	Hammelburg
7414	101005	Ferney Group BV	BONUSABRECHNUNG	Heerhugowaard
7415	101006	Gebhardt Bauzentrum GmbH	(Ndl. Höchberg)	Höchberg
7416	101007	J. + F. Sorg GmbH		Düsseldorf
7417	101008	Guillaume Dufour	Tabac Presse Franck Saniard	Le Puy En Velay
7418	101009	Vantaan Kiinnike ja Rak Oy		Helsinki
7419	101010	Lentz & Schmahl GmbH & Co.KG		Koeln
7420	101011	EURL Mecahydrau		Sarralbe
7421	101012	PETITJEAN EIRL	Stéphane	RUESLISHEIM
7422	101013	Gödde GmbH		Köln
7423	101014	SAS ETABLISSEMENTS BONNEPART		Savigny
7424	101015	BVG Cementmüller Baustoffvertrieb	GmbH & Co. KG	Munster
7425	101016	GRUPO RECSA		Guatemala City
7426	101018	SARL Outils Nancy		Nancy
7427	101019	SAS SGE Energie		Saint-Paul-de-Varces
7428	101020	Delmes Heitmann GmbH & Co. KG	(Niederlassung Kirchwerder)	Hamburg
7429	101021	Schrauben Schmid GmbH		Dresden
7430	101022	Flynn Hardware Supplies Ltd.		Co Mayo
7431	101023	Carbide UK Limited	Rotary House, Bontoft Avenue	Hull, East Yorkshire
7432	101024	Biesheuvel Group BV		Eindhoven
7433	101025	Keilbach Befestigunssysteme		Mühlhausen
7434	101026	IZOSERVICE sp.z.o.o.		Marki Polen
7435	101027	Befestigungs-Technik-Reim	Inh. Sylvia Huber	Heichelheim
7436	101028	Kipp & Grünhoff GmbH & Co. KG	(Ndl. Sinzig)	Sinzig
7437	101029	S-IB Schütz Industriebedarf GmbH		Düsseldorf
7438	101030	Christian Steinbach	Werkzeug-Maschinen Eisenwaren	Köln-Nippes
7439	101031	Baucentrum Stewes GmbH & Co. KG	(Baustoffe)	Gladbeck
7440	101032	Van Buuren B.V.	Centraal Magazijn Rijssen	Rijssen
7441	101033	AMS SARL	Affutage Muhlousien & Sundgauvien	LUTTERBACH
7442	101034	NIKAMALI TRADE DOO		IN?IJA
7443	101035	Becker-Werkzeuge	Bernd Becker	Alsdorf
7444	101036	Au Faite 25		Mamirolle
7445	101037	Gerke & Grüger GmbH		Arnsberg
7446	101038	Zweck GmbH	Autoteile & Werkzeuge	Neuruppin
7447	101039	SAS OUTILLAGE 57		Saint Avold
7448	101040	Heinz Schieber Werkzeuge OHG		Weissach im Tal
7449	101041	Metallbau Franz-Peter Mülfarth e.K.		Brühl
7450	101042	B.K. Components		Omagh, Co. Tyrone
7451	101043	UBB S.R.L.		Cormano
7452	101044	Profdewalt		Minsk
7453	101045	JFJ MATERIEL - VERTOU SARL		VERTOU
7454	101046	Lingemann GmbH		Brühl
7455	101047	Krüger Hannover GmbH & Co. KG		Ronnenberg
7456	101048	Bohle AG		Haan
7457	101049	CREUZE MATERIAUX	TOUT FAIRE BESANCON	BESANCON
7458	101050	Dresen e. K.		Duesseldorf
7459	101051	Aug. Hülden GmbH & Co.KG	Groß- und Einzelhandel	Düren
7460	101052	OKOV d.o.o.		Podgorica Montenegro
7461	101053	Jacob GmbH		Uffenheim
7462	101054	MK TRADE FZE		Ras Al Khaimah
7463	101055	Marsilio Group Srl		Padova
7464	101056	Karl Westhelle + Sohn	Werkzeuge	Olsberg
7465	101057	Geißler & Kuper GmbH		Celle
7466	101058	Mobau Wirtz & Classen GmbH & Co. KG		Ratingen
7467	101059	Distrimat SARL		Pulnoy
7468	101060	Mobau Dörr & Reiff GmbH		Mechernich-Kommern
7469	101061	FIXECO - BAUDRICOURT	Tout Faire	BAUDRICOURT
7470	101062	Eisen-Busch GmbH		Rheine
7471	101063	Michael Feld Sales		Ennepetal
7472	101064	Delmes Heitmann GmbH & Co. KG	(Ndl. Schwarzenbek)	Schwarzenbek
7473	101065	MUL10 Metal A/S		Juelsminde
7474	101066	KENETA		Ferizai
7475	101067	Wocken Industriebedarf	GmbH & Co. KG	Salzbergen
7476	101068	AFG Technische Lagerhaltungs-	und Vertriebs GmbH	Wilhelmshaven
7477	101069	Heller UK Maximum Discounts		Test
7478	101070	BHG Handelszentren GmbH	(Ndl. Finowfurt Baustoffe)	Schorfheide / OT Finowfurt
7479	101071	Bauvista GmbH & Co. KG	Großhandel	Neuss
7480	101072	Bauking Ostfalen GmbH	(Ndl. Gardelegen)	Gardelegen
7481	101073	BAUKING Südwestfalen GmbH	(Bauzentrum Olpe)	Olpe
7482	101074	Schikorra GmbH		Dresden
7483	101075	EURL MCC PERNEY		Lure
7484	101076	Kutzner Befestigungssysteme		Demitz-Thumitz / OT Stacha
7485	101077	SIVA Baustoffhandel GmbH		Berlin
7486	101078	SARL JIM BRET		Plateau D'Hauteville
7487	101079	Eisen Ruland	Inh. Volker Nastaly e.K.	Bedburg/Erft
7488	101080	BMN Amsterdam - Zuidoost		Amsterdam
7489	101081	K. H. Flossbach GmbH		Wipperfuerth
7490	101082	N A Stenteknik AB		Åtorp
7491	101083	Dapetz Ltd.		London
7492	101084	Beck & Co.	Industriebedarf GmbH & Co.KG	Dortmund
7493	101085	Aufdemkamp GmbH	Elektrogrosshandel	Lippstadt
7494	101086	SIG Int Maidstone	Unit 5, Larkfield Mill	Maidstone, Kent
7495	101087	CVS TEKNIK YAPI LTD. STI		Istanbul
7496	101088	August Hülden GmbH & Co KG		Köln
7497	101089	Proximat		Laval Cedex 9
7498	101090	EURL QUINCAILLERIE FRANCOMTOISE		Vauvillers
7499	101091	I&M Bauzentrum Joachimmeyer	GmbH & Co. KG	Bohmte-Hunteburg
7500	101092	Hans Einhell	Vertriebsgesellschaft mbH	Landau-Isar
7501	101093	Matthias Bäßler	Befestigungssysteme	Geithain
7502	101094	Imperial House		Mamer
7503	101095	PRODEX- NELS NV		Hasselt
7504	101096	HBH GmbH & Co. KG		Lauda Königshofen
7505	101097	BMN IJzerwaren Eindhoven		Son en Breugel
7506	101098	Heuer GmbH & Co. KG		Timmendorfer Strand
7507	101099	Durand	Tout faire Materiaux	FOUG
7508	101100	Detlef Paulsen Betriebsbedarf	GmbH & Co. KG	Flensburg
7509	101101	Wilhelm Marx + Co. KG		Frankfurt am Main
7510	101102	Eisen-Schmidt GmbH & Co.	Eisenwaren	Amberg
7511	101103	Perrin Materiaux SAS		Rochetoirin
7512	101104	EJOT Schweiz AG	Baubefestigung	Dozwil
7513	101105	SAS RAO RHONE ALPES OUTILLAGE		Seyssins
7514	101106	BMN Eindhoven - West		Eindhoven
7515	101107	Horst Jourdan	Jourdan Hartwaren Handels GmbH	Mörfelden-Walldorf
7516	101108	IMA Industriemaschinen und	Geräte GmbH	Rednitzhembach
7517	101109	Maschinen & Werkzeuge Maik Schulz		Berlin
7518	101110	Linzmeier Baustoffe GmbH & Co. KG		Laichingen
7519	101111	ANJOU MAINE COUVERTURE SARL		SABLE SUR SARTHE
7520	101113	Danhauser GmbH & Co. KG Baustoffe	(Ndl. Regensburg)	Regensburg
7521	101114	Zapf GmbH	Baustoffe & Sanitär	Lichtenfels
7522	101115	Powertech Industrial LTD	Norwood Ind Estate	Sheffield
7523	101116	One Stop Hire Ltd.		Widnes
7524	101117	East Cornwall Trading	Unit 1 Enterprise Park	Saltash,Cornwall
7525	101118	SAS LANGON DISTRIBUTION	BATI LECLERC	Mazeres
7526	101119	GWS- Werkzeug	Peter Kratschmer	Badbergen
7527	101120	SA S A I P A SOCO		Serres-Castet
7528	101121	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
7529	101122	S&R Industriewerkzeuge GmbH		Gundelfingen
7530	101123	Süddeutsche Baumaschinen	Handels GmbH	Kempten
7531	101124	Conrad Electronic SE		Hirschau
7532	101125	Konak Handels &	Dienstleistungs GmbH	Berlin
7533	101126	Chaco GmbH		Dernbach
7534	101127	Michael Engelhardt	Handelsvertretung	Föritztal OT Neuhaus-Schiersch
7535	101128	Drill One Trading and Contracting	AL MUNTAZAH , AL ANDALUS PETROL	Doha
7536	101129	Lorraine Fixation		Sainte Marie aux Chenes
7537	101130	TRAVES MATERIAUX		Traves
7538	101131	Werkzeug Roloff GmbH	Werkzeug	Magdeburg
7539	101132	Mölders & Scharff	Bauzentrum GmbH & Co. KG	Hamburg
7540	101133	Eisen Würz GmbH		Furth im Wald
7541	101134	Werkzeug Pohl		Magdeburg
7542	101135	Gillet Baustoffe GmbH		Landau/Pfalz
7543	101136	TRUCHON S.A.		CHAPAREILLAN
7544	101137	SARL FI-LOG	VAL EUROMOSELLE SUD	Feves
7545	101138	Lormatem Big Mat		Velaines
7546	101139	SASU LIMABAT	ZONE INDUSTRIELLE	Hesingue
7547	101140	Insite Systems Inc.		Mentor
7548	101141	SAS APPROVISIONNEMENTS OUTILS	DIAMANTS	Barberaz
7549	101142	ASD		Illange
7550	101143	SPIELMAT BIG MAT	A l'attention de Christophe Delion	Colmar
7551	101144	HV-Michel techn. Großhandel		Rodalben
7552	101145	REVENDEUR SPÉCIALISÉ		REVENDEUR SPÉCIALISÉ
7553	101146	JF Equipment et Distribution		MONSWILLER
7554	101147	K&N Accesories LTD		Leigh
7555	101148	Van der Winkel Den Bosch		Den Bosch
7556	101149	SAS AXIMAT		Saint Genest Lerpt
7557	101150	H.D. Hunger GmbH		Kirchlengern
7558	101151	Vimafer LTDA		Bogota
7559	101152	BBH BauBedarf Hagedorn GmbH		Greußen
7560	101153	Superba S.A		San Jose
7561	101154	KVADRAT SYSTEMS LLC - Office 2002	Silver Towers, Business Bay	Dubai
7562	101155	TDH - GmbH	Technischer Dämmstoffhandel	Hamburg
7563	101156	Wolf Drucklufttechnik GmbH		Triptis
7564	101157	Paul Wünn GmbH & Co.KG		Coburg
7565	101158	1ASchrauben.de	kroboth & scharf GbR	Utzberg
7566	101159	DTS Baumanagement	Anton Sommer	Mainhausen
7567	101160	Gedimat Pochon		Montrevel-en-Bresse
7568	101161	Materiaux de l'Isac	BIGMAT	Blain
7569	101162	HAUT DOUBS BOIS	GEDIBOIS	COLLONGES LES PREMIERES
7570	101163	E&S Industriebedarf GmbH		Bruck/Opf.
7571	101164	Fa. Horst Häusler	Gewerbepark Mariatal	Ravensburg
7572	101165	Beal PH (BEAL)	Zone Industrielle	Cournon
7573	101166	BAUSTOFF UNION GmbH	(Ndl. Langenzenn)	Langenzenn
7574	101167	BMN IJzerwaren Rotterdam	Spaanse Polder	Rotterdam
7575	101168	Gohire Group Ltd		Hull
7576	101169	Bouwmarkt Groenen B.V.		Veldhoven
7577	101170	John Gibson Hire and Sales		Middlesbrough
7578	101171	A&G Stahlverarbeitungs- und	Vertriebs GmbH	Saalfeld
7579	101172	SAS AD HOC'LOC		St Etienne
7580	101173	BAUKING Südwestfalen GmbH	(Ndl. Neunkirchen)	Neunkirchen
7581	101174	J.N. Köbig GmbH	(Ndl. Friedberg-Ockstadt)	Friedberg-Ockstadt
7582	101175	COBA-Baustoffgesellschaft	für Dach + Wand GmbH & Co. KG	Osnabrück
7583	101176	Michael Aschenbrenner		Abensberg
7584	101177	MARKANT Handels und Industriewaren	Vermittlungs AG	Pfaeffikon / SZ
7585	101178	Lasaulec B.V.	001 Centraal Heerenveen	Heerenveen
7586	101179	PRECHTEL GmbH	c/o Richard Köstner AG	Forchheim
7587	101180	Die Werkzeugprofis	Werkzeughandels-GmbH	Regensburg
7588	101181	Gebr. Mayer GmbH & Co.KG		Fürth
7589	101182	Schwemmer & Dorn+ Co. GmbH	Qualitätswerkzeuge	Fürth
7590	101183	Höck-Jansen GmbH		Overath
7591	101184	Handelsunternehmen Dineiger GmbH		Berching OT Pollanten
7592	101185	Pro-Coop	-Rabattring-	Grobbendonk
7593	101186	Gerhard Hof GmbH		Mühlheim/Main
7594	101187	EGENITRO LTD. STI.		Izmir
7595	101188	SARL MTT		Soultz-Sous-Forets
7596	101189	Runser Matériaux		MICHELBACH-LE-HAUT
7597	101190	GHANCHI IBRAHIM NOORMOHD Y BROS	Fatemabai smailji Alibhoy	Karachi
7598	101191	Fikstek Baglanti Teknolojileri San.	ve Tic. LTD. STI.	Ümraniye / Istanbul
7599	101192	Lamberts Tools & Welding Supplies		Essex
7600	101193	StahlPartner Mitte GmbH		Weilburg
7601	101194	Fidel Schub GmbH & Co. KG	Filiale Sax	Schwandorf
7602	101196	Arthur Friedrichs Industriebedarf	GmbH	Bremerhaven
7603	101197	ECEF Srl		Peschiera Borromeo (MI)
7604	101198	Baustoffe Geulen GmbH & Co. KG		Aachen
7605	101199	Profi Geuder GmbH		Uffenheim
7606	101200	Schiffauer GmbH & Co. KG		Kronach/Bay.
7607	101201	Mobau Profi Zentrum	Wirtz & Classen GmbH & Co. KG	Mönchengladbach
7608	101202	Michel's Schraubenquelle	Technischer Groß- und Einzelhandel	Ladeburg
7609	101203	Impulse 24 Vertriebs GmbH		Plaidt
7610	101204	SAS ISOMAT		RICHWILLER
7611	101205	BAUKING Südwestfalen GmbH	(Ndl. Betzdorf)	Betzdorf
7612	101206	PROMAT	Société	Corbeil-Essonnes
7613	101207	BAUKING Ostfalen GmbH	(Ndl. TBZ Braunschweig)	Braunschweig
7614	101208	IK-Trading		Bochum
7615	101209	UNION Bauzentrum HORNBACH GmbH		Neuhofen
7616	101210	SOSACA Grimaud		Grimaud
7617	101211	Robert Dehnel	Inh. T. Helmholz	Krefeld
7618	101212	CRAMAT	France Matériaux	St. Denis les Bourgs
7619	101213	SASU Pro Appro		TOUL
7620	101214	A.J. Freialdenhoven GmbH & Co. KG		Inden
7621	101215	SAS MADIMAT		Marcillac St Quentin
7622	101216	Innotec Construction Supplies		Carlisle
7623	101217	G.F. Lotter GmbH	Werkzeuge Maschinen	Neutraubling
7624	101218	Floor and Wall Tiles Ltd.		Northampton
7625	101219	Holz Michelsen		Lübeck
7626	101220	ESD Bricotech Bricopro		Ruy
7627	101221	Segl Bauzentrum GmbH		Pfarrkirchen
7628	101222	NL Raab Karcher Rostock	STARK Deutschland GmbH	Rostock
7629	101223	Mayrose-Weener GmbH & Co. KG		Weener
7630	101224	COFAQ		COFAQ
7631	101225	BRICOPRO		BRIC0PRO
7632	101226	One Stop Hire		Chorley
7633	101227	SARL VIMES CELHAY		Preignac
7634	101228	Mark Smethurst		Blackrod, Bolton
7635	101229	Dachdecker-Einkauf Ost eG	Zweigniederlassung Leipzig	Leipzig
7636	101230	Chr. Forkel	Inh. Erich Forkel	Rödental
7637	101231	RAO - SPIT KUNDE	Rhone Alpes Outillage	Seyssins
7638	101232	SOCADA		SOCADA
7639	101233	Quincaillerie Bourbonnaise		Cusset
7640	101234	O.K. Werkzeugservice	Olaf Jentzsch	Langenweißbach
7641	101235	Eisen - Keitel		Rothenburg o.d.T.
7642	101236	Baustoff Netzband GmbH	Niederlassung Ziesar	Ziesar
7643	101237	Mapeco Turnhout N.V.		Turnhout
7644	101238	EURL ATELIER TP 47		Fauillet
7645	101239	bernaTech GmbH		Bern
7646	101240	Sollenberg S.	VERKTYGSAKTIEBOLAG	Hässleholm
7647	101241	Eisenhandel Prell GmbH + Co.KG		Schwabach
7648	101242	SASU CG2BCOM		La Rajasse
7649	101243	Sax GmbH	Werkzeuge-Autoteile	Schwandorf
7650	101244	EFCO Befestigungstechnik AG		Nänikon
7651	101245	Julius Friedr. Krönlein	Fachgroßhandel f. Baubedarf	Schweinfurt
7652	101246	P.S. Building Supplies Ltd.		Essex
7653	101247	DTH Diamant und Kernbohrtechnik	Reinhard Nelius	Lahnstein
7654	101248	OOO AstErabel		Grodno-Weisrussland
7655	101249	DRIFFIELD ELECTRICAL SUPPLIES LTD		Driffield
7656	101250	ELG Baustoffhandel Calau eG		Calau
7657	101251	LUSARO,s.r.o.		Košice
7658	101252	Obernberger Baumaschinen		Mannswörth
7659	101253	Eisen Knorr GmbH		Weiden
7660	101254	Mathias Jörling		Frankfurt am Main
7661	101255	Rogger Fasteners AG		Grossaffoltern
7662	101256	Profnorm Kampen B.V.		Kampen
7663	101257	Hanseatic Trade Company e.K.		Stuhr - Brinkum
7664	101258	Alubogencenter.de	Inh. Rolf Brendemühl	Buchholz
7665	101259	S Fixations system		Kingersheim
7666	101260	Ideas Civiles S. A.		Medellin
7667	101261	Gebr. Reinhard GmbH & Co.KG	Stahlhandel	Würzburg
7668	101262	SAS Foussier		Allonnes
7669	101263	Handelshof Stendal GmbH	Filiale Nowaweser	Brandenburg an der Havel
7670	101264	Fischer Austria G.m.B.H.		Möllersdorf / Traiskirchen
7671	101265	A SILVA FERRAGENS LTDA		Cricuima
7672	101266	Kurt König Baumaschinen GmbH		Sangerhausen
7673	101267	Schwing Fachgroßhandel GmbH		Röllbach
7674	101268	MAWETEC	Inh. Mirko Neundorf	Lauchhammer - West
7675	101269	M.I.T GmbH		Mühlheim/Main
7676	101270	Krüger & Scharnberg GmbH	(Standort Wentorf)	Wentorf
7677	101271	Aryan Enterprises Ltd.		Middlesex
7678	101272	Deqob		Cluses
7679	101273	Kanne Werkzeugtechnik GmbH		Northeim
7680	101274	Keizer & Cuvelier B.V.		Nieuw-Vennep
7681	101275	DOMPRO		DomPro
7682	101276	Amazon EU Sarl	Niederlassung Deutschland	München
7683	101277	AWIK International e.K.	Inh. Martin Moldenhauer	Celle
7684	101278	Amazon EU Sàrl / Amazon Media EU	Sàrl	Luxemburg
7685	101279	Engweld-A brand name of Energas Ltd		Birmingham, West Midlands
7686	101280	Raiffeisen Waren GmbH	(Ndl. Eichenzell-Welkers)	Eichenzell-Welkers
7687	101281	Ludwig International GmbH		Köln
7688	101282	Salzbrunn Werkzeuge		Langenfeld
7689	101283	Amazon Fulfillment Poland sp.z o.o.		Bielany Wroclawskie
7690	101284	Eisen - Jacob e.K.	Groß- und Einzelhandel	Aschaffenburg
7691	101285	Amazon EU SARL	Niederlassung Tschechien	Dobroviz
7692	101286	Raiffeisen Waren GmbH	(Ndl. Wolfhagen)	Wolfhagen
7693	101287	THS Tools Group	Salisbury House	Templeborough, Rotherham
7694	101288	Franz Jos. Then	Eisenhandlung	Dettelbach
7695	101289	Günther Fachhandel GmbH & Co.KG		Bad Neustadt/Saale
7696	101290	DMG Gustke GmbH		Leverkusen
7697	101291	Kurt Greiner GmbH	Neues & Bewährtes	Erlangen
7698	101292	SMB	Monsieur Jérémie	Beaurepaire
7699	101293	Quincaillerie Roy		Rives sur Fure
7700	101294	Davidi-Werkzeugtechnik	Handels GmbH	Erkrath
7701	101295	White Drive Motors and Steering	sp. z o.o	Kobierzyce
7702	101296	Raiffeisen Waren GmbH	(Ndl. Braunschweig)	Braunschweig
7703	101297	Dagar Tools Ltd.		Shropshire
7704	101298	Raiffeisen Waren GmbH	(Ndl. Keil Heuchelheim)	Heuchelheim
7705	101299	DIMU Dieter Muthmann GmbH		Berlin
7706	101300	Gannaz Matériaux		Sallanches
7707	101301	B+BTec	Boor- + Bevestigingstechniek BV	Zevenbergen
7708	101302	CQFB	Comptoir de Quincaillerie &	MARANGE SILVANGE
7709	101303	Otto Röhrs GmbH	NL Quelkhorn	Ottersberg
7710	101304	EURL EURL STDI		MARANGE SILVANGE
7711	101305	Technischer Handel Nienhagen		Nienhagen
7712	101306	Workshop Nagel e.K.	Christian Nagel	Berlin
7713	101307	Seifi David	Machine Engineering, Maschinenbau	Teheran Iran
7714	101308	Raiffeisen Waren GmbH	(Ndl. Keil Reiskirchen)	Reiskirchen
7715	101309	SAS QUEGUINER MATERIAUX		Landivisiau  cedex
7716	101310	SAS SCHARRENBERGER		Soultz sous forêts
7717	101311	Georg Altenburg GmbH & Co. KG		Bückeburg
7718	101312	JS Fournitures Sarl		Soultz sous Forets
7719	101313	MCD		MCD
7720	101314	SARL Outil-Loc		Hochfelden
7721	101315	Wittmann-Komet	Metal Cutting Saws GmbH & Co. KG	Weil am Rhein
7722	101316	Rudolf Martin	Handelsvertretung	Schnaittenbach
7723	101317	M. Lautwein	Haushaltswaren - Werkzeug	Bitburg
7724	101318	Rhino Plant Hire		Doddinghurst, Essex
7725	101319	Elite Fasteners Ltd.		West Midlands
7726	101320	Handelshof Stendal GmbH	Partner für Technik	Osterburg
7727	101321	Werkzeug Vertrieb GmbH		Aschaffenburg
7728	101322	Possling GmbH & Co.KG		Berlin
7729	101323	Possling GmbH & Co.KG		Berlin
7730	101324	SAN KEOKO TRADING CO., LTD		New Taipei City R.O.C
7731	101325	Andreas Dierken	Heller Tools GmbH	Dinklage
7732	101326	Batimance	Colorance	Vienne
7733	101327	SAS MAC HOM TER	Brico Pro	Chemillé
7734	101328	Quincaillerie DOUESSINE		Doue la Fontaine
7735	101329	Agimus KG		Mellingen
7736	101330	SARL Paris Nord Matériaux		St. Maur de Fosses
7737	101331	Ferrodo-Poznan Sp. zo.o.		Poznan
7738	101332	St.-Vitus-Werk Gesellschaft für	heilpädagogische Hilfe mbH	Meppen
7739	101333	Brielmaier Baumaschinen GmbH		Ravensburg
7740	101334	Fassadengrün e.K.	Inh. Sven Taraba	Leipzig
7741	101335	BONEKO LTD	Mr. Vladimir Nedelchev	Petrich Bulgaria
7742	101336	Viktor Maurer ViMa-Tech		Cloppenburg
7743	101337	Nikolaj Ljabach		Hildesheim
7744	101338	MAVIZ s.r.o.		Vrable
7745	101339	Oechsner GmbH & Co KG	Bauzentrum - Fliesen - Bauelemente	Freilassing
7746	101340	BAUKING Weser-Ems GmbH	Niederlassung Lohne	Lohne
7747	101341	CMPM HUNDLING		Hundling
7748	101342	Bauzentrum Rüppel GmbH		Florstadt
7749	101343	Zeppelin Rental GmbH & Co.KG	Zentrale - Profi Baushop	Freiburg
7750	101344	Tackit GmbH		Nürnberg
7751	101345	Tashev - Galving Ltd.	Marina Staykova	Sofia Bulgaria
7752	101346	Reiner Auge Bauwerkzeuge		Hennef-Söven
7753	101347	Baustoff Union GmbH		Nürnberg
7754	101348	Cofermeta Sa		Belo Horizonte
7755	101349	Ludwig International GmbH		Köln
7756	101350	FSS-FULL-SERVICE GESMBH		Wiener Neudorf
7757	101351	Isero - Regts Joure		Joure
7758	101352	SORETI COMERCIAL LTDA		BELO HORIZONTE
7759	101353	Bennewitzer Raiffeisen Handels GmbH	(Baustoffhandel)	Bennewitz
7760	101354	Thor Helical Deutschland	Heuer GmbH & Co. KG	Timmendorfer Strand
7761	101355	IP Berlov E.S.		Moskau
7762	101356	VC Materials Limited		London
7763	101357	EURL MFCS		Irigny
7764	101358	CRETEC CO. LTD		DAEGU
7765	101359	Geurts Machines BV		America
7766	101360	MAES EN ZONEN NV		Kasterlee
7767	101361	UPR Unter Profis GmbH		Hohen Neuendorf
7768	101362	Heinrich Meier GmbH		Mühlacker
7769	101363	Beton Kemmler GmbH		Tuebingen
7770	101364	Heller Tools Inc.		Chicago
7771	101365	Fetter Baumarkt GmbH	(Baustoffe)	Korneuburg
7772	101366	AE Handels GmbH		Bochum
7773	101367	EURL JOHAN LEDENT		CHATEAUNEUF DE GALAURE
7774	101368	Baucentrum Stewes GmbH & Co.KG		Duisburg
7775	101369	J K Supplies Ltd.	4 Hillside Cottages	Hertfordshire
7776	101370	FKR Baucentrum GmbH & Co. KG		Wabern
7777	101371	KARDE?LER GÜMRÜK MÜ?AV?RL???	LOJ?ST?K VE ULUS. TA?. LTD. ?T?.	FERHATPA?A-ATA?EH?R, Istanbul
7778	101372	albw Handels GmbH		Waghäusel-Kirrlach
7779	101373	Mayrose-Uelsen GmbH & Co. KG		Uelsen
7780	101374	SAS PROBALI		LABASTIDE MONREJEAU
7781	101375	PM Hardware Ltd.		Bury, Lancashire
7782	101376	Raiffeisen Waren GmbH	(Ndl. Strauch)	Limeshain-Rommelhausen
7783	101377	THEMIS GIANNAKIS S.A.		Athen
7784	101378	Baumaschinen Schmittinger GmbH		Köngen
7785	101379	VEHNS GROUP GmbH		München
7786	101380	Soroush / Mr. Abdulla Mohamad	Abdolmohamad Mob: +9647701531996	Sulaimanya Kurdistan Iraq
7787	101381	Villacross Corp.		Obarrio Urb of the City of Pan
7788	101382	Mastermate VBT Groep	Technische Groothandel	Vlaardingen
7789	101383	Cofaq		Poitiers
7790	101385	Friedrich Kicherer GmbH & Co. KG		Ellwangen/Jagst
7791	101386	Deeg GmbH	Werkzeuge	Crailsheim
7792	101387	Local Industrial Supplies	THS Tools Group	Rotherham
7793	101388	Werkzeug Jäger GmbH		Karlsruhe
7794	101389	HELLER TOOLS DO BRASIL COMÉRCIO	DE FERRAMENTAS LTDA	Cidade de Sao José dos Pinhais
7795	101390	Heinz Lindner GmbH		Fellbach
7796	101391	R2M		Vouille
7797	101392	HERI SARL		Vernoux-en-Vivarais
7798	101393	Keil Fördertechnik GmbH		Ruppach-Goldhausen
7799	101394	LOCATION		LOCATION
7800	101395	Baugeräte 24		Baden-Baden
7801	101396	Hoofdvestiging DESTIL BV		Tilburg
7802	101397	Horst Klever	Werkzeuge-Maschinen	Rastatt
7803	101398	Baumarkt Allianz West	hagebau	Herten
7804	101399	EDIPESA S.A.		Lima
7805	101400	Baumarkt-Allianz Nord	hagebau Fachhandel GmbH & Co. KG	Rellingen
7806	101401	SAS Perronet et Paillasson		Pannissieres
7807	101402	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
7808	101403	SARL BODIN		Langon
7809	101404	Plumbworkz Ltd		Rhuddlan
7810	101405	BMN Roosendaal - West		Roosendaal
7811	101406	Avantifix (Fixing Solutions) Ltd.	Heller Tools Logistics UK	Rothwell, Leeds
7812	101407	DANYANG ZHAONAN TOOLS CO., LTD		Danyang City, Jiangsu
7813	101408	Otto Wagner GmbH & Co KG	Stahllager-Fachmarkt	Freudenstadt
7814	101409	Spreyer Werkzeug Technik GmbH		Limburg/Lahn
7815	101410	Rettig & Köhler GmbH & Co KG	Eisenhandlung	Ettlingen
7816	101411	Karrer Werkstatt Technik Vertriebs	GmbH	Memmingen
7817	101412	RB Tools GmbH	Generalvertretung	Au-Wädenswil
7818	101413	fischerwerke GmbH & Co. KG		Waldachtal
7819	101414	Josef Stümper GmbH		Neunkirchen-Seelscheid
7820	101415	Gunters en Meuser Noord B.V.	Izerwaren - Gereedschappen	Amsterdam
7821	101416	Samples AMNORT		Washington
7822	101417	Zweygart GmbH & Co. KG	Fachhandelsgruppe	Gärtringen
7823	101418	Philipsen GmbH	Werkzeuge	Weingarten
7824	101419	Samples AMSOUT		Brasilia
7825	101420	Samples AUAS		Danyang City
7826	101421	Gienger Regensburg KG	Fachgroßhandel für Haustechnik	Regenstauf
7827	101422	Samples BENE		Amsterdam
7828	101423	Muster DACHL		Berlin
7829	101424	Samples BENE TCG		Amsterdam
7830	101425	Dibosa GmbH		Großefehn
7831	101426	Muster DACHL TCG		Berlin
7832	101427	Eisen-Bärle GmbH & Co.KG		Bruchsal
7833	101428	Van Eijk	Machines & Gereedschappen B.V.	Reusel
7834	101429	Samples EUEAST		Warschau
7835	101430	Otten GmbH & Co KG	Geb. 6352A	Mainz
7836	101431	Samples EUNORT		Kopenhagen
7837	101432	Samples EUSOUT		Rom
7838	101433	FLORIVAL MATERIAUX		Issenheim
7839	101434	Samples FRANCE		Paris
7840	101435	Samples IBERIA		Madrid
7841	101436	TECHNIMAT		Allevard-les-Bains
7842	101437	Samples MEAI		Cairo
7843	101438	ZEG - Zentraleinkauf	Holz + Kunststoff eG	Mannheim
7844	101439	Teknofix		Exeter, Devon
7845	101440	Samples UKIRL		London
7846	101441	Reca Norm GmbH		Kupferzell
7847	101442	BVBA IJZERWAREN NELIS	Vakhandel en Installatiebedrijf	Glabbeek
7848	101443	Bruno Cavalheiro		Curitiba
7849	101444	Didden NV		Dilsen-Stokkem
7850	101445	SAS LOCATION CAEN MATERIEL		Colombelles
7851	101446	Roth Baustoffe GmbH & Co. KG		Neckargemünd
7852	101447	Andreas Stockbauer		Waldkirchen
7853	101448	CCU Tool and Plant Hire LTD		Rochester, Kent
7854	101449	Zandvoort Draadindustrie BV		Doetinchem
7855	101450	Warnhill tool & fasteners ltd	Until 17A, Road One	Winsford, Cheshire
7856	101451	SARL MUTEC France		Lautenbach
7857	101452	SASU CASTE		Auch
7858	101453	Serafin Unternehmensgruppe GmbH		München
7859	101454	CMS-Dienstleistungs-GmbH		Ober-Ramstadt
7860	101455	GROUP2 MasterPro		GROUP2 MasterPro
7861	101456	Revert S.A.S		Versailles
7862	101457	SBN GmbH & Co. KG		Neuenkirchen
7863	101458	Proventure Solutions Ltd.	Lakeside Barn	Lathom, Ormskirk
7864	101459	Walth Hardware		Monterrey
7865	101460	REAL Matériaux	OPUS PLATEFORME	Trappes
7866	101461	INDEPENDANT		INDEPENDANT 3
7867	101462	ADA Fastfix	Unit 10 Merlin Centre	High Wycombe
7868	101463	KOVA TOOLS NV		GRÂCE-HOLLOGNE
7869	101464	MATERIEL ET MATERIAUX		Mornant
7870	101465	TD Projects		Pelt
7871	101466	FISCHER ARGENTINA SA		Buenos Aires
7872	101467	Contract Company Services	GmbH & Co. KG	Eckernförde
7873	101468	HOMBERGER S.P.A.		Buccinasco
7874	101469	J. Weber	Eisenwaren e.K.	Heidelberg
7875	101470	Walter + Schier GmbH	Werkzeug - Maschinen	Waiblingen
7876	101471	Martin Meier GmbH	Das Bauzentrum Gaimersheim	Gaimersheim
7877	101472	SARL ELMAT		Plérin
7878	101473	Stolle Tortechnik GmbH		Emstek
7879	101474	UNION Bauzentrum HORNBACH GmbH		Bobenheim-Roxheim
7880	101475	Albrecht-Werkzeuge + Maschinen	Handels GmbH	Freiburg
7881	101476	Karrer + Barth GmbH & Co		Karlsruhe
7882	101477	UNION Bauzentrum HORNBACH GmbH		Groß-Rohrheim
7883	101478	Utilisateur		Utilisateur
7884	101479	UNION Bauzentrum HORNBACH GmbH		Kaiserslautern
7885	101480	UNION Bauzentrum HORNBACH GmbH		Kirn
7886	101481	Indépendant		Indépendant
7887	101482	UNION Bauzentrum HORNBACH GmbH	Baustoffe	Saarbrücken-Gersweiler
7888	101483	Gerhard Sprügel GmbH	Befestigungstechnik	Ingelfingen
7889	101484	Baumarkt Lohhof GmbH		Unterschleißheim
7890	101485	UNION Bauzentrum HORNBACH GmbH	Ausbau / Fassade	Saarbrücken-Gersweiler
7891	101486	Waagen Wulff GmbH		Flensburg
7892	101487	Nagel Baumaschinen	Magdeburg GmbH	Glauchau
7893	101488	UNION Bauzentrum HORNBACH GmbH		Saarlouis
7894	101489	UNION Bauzentrum HORNBACH GmbH		Sinsheim
7895	101490	UNION Bauzentrum HORNBACH GmbH		Stuttgart-Weilimdorf
7896	101491	UNION Bauzentrum HORNBACH GmbH		Ulm
7897	101492	UNION Bauzentrum HORNBACH GmbH		Viernheim
7898	101493	UNION Bauzentrum HORNBACH GmbH		Wadern
7899	101494	UNION Bauzentrum HORNBACH GmbH		Worms
7900	101495	Robert Röhlinger GmbH		Neunkirchen
7901	101496	K. E. Karcher GmbH & Co.KG	Werkzeuge	Rheinau
7902	101497	BV STOCK VAN DE WALLE		Assenede
7903	101498	TIB Technischer Industriebedarf	GmbH Bernsbach	Lauter-Bernsbach
7904	101499	ESD Bricotech Bricopro		Chatte
7905	101500	FRÖWIS AG		Schaanwald / Lichtenstein
7906	101501	SAS ETCHALUS MATERIAUX		SAINT MARTIN DE SEIGNANX
7907	101502	Peter Trepke	Vertrieb von Verbindungselementen	Romrod/Ober-Breidenbach
7908	101503	Gerhard Scheifele GmbH	Befestigungstechnik	Pfedelbach
7909	101504	Otto Roller e.K.	Inh. Kersten Roller	Pirmasens
7910	101505	Gerd Kottmeier	Werkzeughandel + Reparatur	Vlotho
7911	101506	Haberstumpf und Winkler		Kulmbach
7912	101507	Dibotec Befestigungssysteme		Baindt
7913	101508	Segupro SAC		Lima - Lurigancho
7914	101509	Sonelec S.A.R.L		Sprinkange
7915	101510	HBH-Priotek GmbH		Grevenbroich
7916	101511	Zweygart GmbH & Co. KG	Fachmarkt	Hanau
7917	101512	DomPro		Dingsheim
7918	101513	DomPro (2,5)		Dingsheim
7919	101514	Werkzeughandel Möller	Inh.Thomas Möller	Königsee
7920	101515	Al Nahda Company		Misurata
7921	101516	LTD Energy		Tbilisi
7922	101517	K² GmbH & Co. KG		Pößneck
7923	101518	Erich Carlé GmbH & Co. KG	Bedachungsfachhandel	Gießen
7924	101519	Hermann Fatum GmbH & Co. KG	Bedachungsfachhandel	Hungen
7925	101520	Heitkamm GmbH	Dachbaustoffe	Ahlen
7926	101521	Rieber Werkzeugtechnik		Merzhausen / Frbg.
7927	101522	BHT GmbH	Bedachungshandel Tritschler	Sexau
7928	101523	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Eifel
7929	101524	TECTO Dachbaustoffe GmbH		Stolpen
7930	101525	Richter Baustoffe GmbH	(Baustoffe Burg)	Burg / Fehmarn
7931	101526	SAS MURESOL		LE PETIT QUEVILLY
7932	101527	SAS MURESOL		Gainneville
7933	101528	NBT Group Ltd.		Newcastle upon Tyne
7934	101529	Agir		Agir
7935	101530	Hagmeyer Handwerker- und	Industriebedarf GmbH	Geislingen/Steige
7936	101531	SARL CODINA QUINCAILLERIE		Soual
7937	101532	Depot Express SARL		Meyzieu
7938	101533	WOLDS ENGINEERING SERVICES LTD		Pocklington
7939	101534	Vélar & Verkfaeri ehf		REYKJAVIK
7940	101535	PAWLICZEK SARL		MERIGNAC
7941	101536	CENTRAL FASTENERS (STAFFS) LIMITED		HIXON, STAFFS
7942	101537	Heinrich Lütticken GmbH	Stahlhandel	Wittlich
7943	101538	Hamelin		Querétaro
7944	101539	DURI FAGPROFIL AS		Oslo
7945	101540	Felix Knümann	Inh. Christian Reuter e.K.	Selm
7946	101541	S.A. Quincaillerie Lallemand		Vielsalm
7947	101542	Phoenix Hire & Sales Ltd.		Cwmbran, Gwent
7948	101543	SAS LOPEZ FI		Portes les Valences
7949	101544	Slobel fixing BV		Haaltert
7950	101545	Handelsunternehmen Frank Niebergall		Weissenborn
7951	101546	FRANTOS GmbH & Co KG		Feldkirchen bei München
7952	101547	LAURENT  MATERIAUX		Port sur Soane
7953	101548	A. Papantonopoulos & SIA EE	tel. 2310-722425	THESSALONIKI
7954	101549	VMA		Baie-Mahault
7955	101550	“KURAL-ASTANA” LLC		Astana
7956	101551	Theo Förch GmbH & Co. KG		Neuenstadt
7957	101552	SARL MS FOURNITURES INDUSTRIELLES		Romaneches - Thorins
7958	101553	BAUKING Berlin-Brandenburg GmbH	FH Eichwalde	Eichwalde
7959	101554	HACKER GmbH	Holzbearbeitungsmaschinen	Rosenheim
7960	101555	Makita Corporation		Anjo, Aichi 8502 JAPAN
7961	101556	Stock & Trade		Helmond
7962	101557	SAS EUTALYA		Montmorency
7963	101558	Contorion GmbH		Berlin
7964	101559	Fastline Services Ltd		Doncaster
7965	101560	GB INGENIERIA EN FIJACIONES S.A.		SANTIAGO
7966	101561	Industrial Lifting Ltd		Stoke-on-Trent
7967	101562	Optimera Latvia SIA		Riga
7968	101563	NV O.M.C.T.		Averbode
7969	101564	LSK SUPPLIES LIMITED		Glasgow
7970	101565	Contorion GmbH		Berlin
7971	101566	J. König GmbH & Co	Werkzeugfabrik	Karlsruhe
7972	101567	Materiaux		Materiaux
7973	101568	Implementos y Herramientas, S.A.	(IHERSA)	Panama
7974	101569	Frankreich Preisliste F1		Dinklage
7975	101570	BRAUN GmbH		Geretsried
7976	101571	Diamanttechnik Wilsdruff	Inh. Robby Heimrich	Wilsdruff
7977	101572	SARL PERIGORD QUINCAILLERIE		Champcevinel
7978	101573	L'Etoile		Bruges
7979	101574	ADEO		ADEO
7980	101575	Maurer GmbH		Bad Saulgau
7981	101576	SAS DOMPRO		Roissy-en-France
7982	101577	MBA	Matériaux Bois Aquitaine	Mérignac
7983	101578	NEBOPAN		NEBOPAN
7984	101579	NBB Technischer Großhandel		Nordenham
7985	101580	Preisliste Tout Faire		Dinklage
7986	101581	Frankreich Preisliste F3		Dinklage
7987	101582	TDC	Toulouse Diffusion Coffrages	Grisolles
7988	101583	SARL GINESTET MATERIAUX		Mirandol
7989	101584	BAUEN+LEBEN Service GmbH & Co. KG		Krefeld
7990	101585	Hommel Hercules	Werkzeughandel GmbH & Co. KG	Viernheim
7991	101586	Brütsch-Rüegger Tools GmbH	Deutschland	Mannheim
7992	101587	SFS Group Schweiz AG		Heerbrugg
7993	101588	SAS XPERT		Avignon
7994	101589	Friedrich Kraft GmbH		Rendsburg
7995	101590	Hayley GROUP LIMITED		Redruth
7996	101591	Heller Tools RUS, Ltd.		Moscow
7997	101592	Häfele SE & Co KG	Beschlagtechnik	Nagold
7998	101593	C. Schrade GmbH		Neckarsulm
7999	101594	Thomas Rosenkranz	Werkzeuge, Maschinen, Handwerk-	Neunkhausen
8000	101595	Blacks Fasteners Limited		Christchurch
8001	101596	Hermann Asal GmbH	Eisenwaren	Offenburg
8002	101597	ASK Kloska GmbH		Leer
8003	101598	Eisen Jourdan	Eisenwarenhandels GmbH	Pforzheim
8004	101599	N.G. ELEKTRO TRADE, a.s.		Ostrov
8005	101600	Baillargeat	SA Quincaillerie	La Teste de Buch
8006	101601	SARL Pro Fourniture		Gueret
8007	101602	SARL Garonne Bricolage		La Réole
8008	101603	Quincaillerie		Quincaillerie
8009	101604	Paul Sommer Steinindustriebedarf	Inh. Tino Schönfeld	Löbau
8010	101605	Franz Heydt Fachhandels-GmbH		Rastatt
8011	101606	Thommel I&H GmbH		Ravensburg
8012	101607	Nortech Services Ltd		Hull
8013	101608	SAS EDTO		SAINT HERBLAIN
8014	101609	CFK - International e. K.		Gangelt
8015	101610	Köhle Kimyevi Maddeler	Hirdavat ve Tic. Ltd.Sti.	Istanbul-Cihangir
8016	101611	AK Industrie	Fournitures industrielles	Seingbouse
8017	101612	Wilhelm Linnenbecker GmbH & Co.		Berlin
8018	101613	Raiffeisen Waren GmbH	(Ndl. Korbach)	Korbach
8019	101614	Otto Röhrs GmbH	Baustoffe	Weyhe-Dreye
8020	101615	Ronix GmbH		Frankfurt am Main
8021	101616	Probeg B.V.		Haaksbergen
8022	101617	CENTRAL MANAGEMENT CATALOGUE	AGENCY (UK) LTD	Worcester
8023	101618	JFH Fixings Ltd.	C/O John F Hunt	Essex
8024	101619	Mega-Mat NV		Heusden- Zolder
8025	101620	“DIA–ELIT” Ltd.		Belgrade
8026	101621	WIMA Dröghoff-Boudon GmbH		Arnsberg
8027	101622	Nordic Tools AS		Hagan
8028	101623	Carl Pfeiffer GmbH & Co.KG		Stockach
8029	101624	Schade + Sohn GmbH		Wuppertal
8030	101625	Ferdinand Gross GmbH & Co		Leinfelden-Echterdingen
8031	101626	HAHN & KOLB	Werkzeuge GmbH	Ludwigsburg
8032	101627	BUSTECHNIC HAVACILIK OTOMOT?V VE	TA?IMACILIK SAN. T?C. LTD. ?T?.	ISTANBUL
8033	101628	Baustoff Verbund Süd GbR		Urbach
8034	101629	BME Group Sourcing BV		Schiphol
8035	101630	Baufachmarkt Schulz GmbH		Möckmühl
8036	101631	SMART TRADE ECUADOR		Zaruma
8037	101632	Georg Schmieder GmbH & Co	Handwerkerbedarf	Stuttgart (Degerloch)
8038	101633	NMBS Limited		Leicestershire
8039	101634	Sanitaire		Sanitaire
8040	101635	Rudolf Hug GmbH		Waldshut-Schmittenau
8041	101636	Point.P		PointP
8042	101637	KAISER Nachfolger Montagetechnik	und Industriebedarf GmbH	Blomberg
8043	101638	Electricité		Electricité
8044	101639	Lapeyre		Lapeyre
8045	101640	Nagel Werkzeug-Maschinen GmbH		Ulm
8046	101641	Baucenter Bermes GmbH		Bitburg
8047	101642	Raiffeisen Waren GmbH	Bayerischer Wald	Perlesreut
8048	101643	MAISON COURTOIS BV		VAUX-SUR-SÛRE
8049	101644	Saint Gobain		Saint Gobain
8050	101645	KWG Schwegler Elektrowerkzeuge	Inh. Hansjörg Schwegler e.K.	Fellbach
8051	101646	Paul Kuhn GmbH		Verl
8052	101647	Pold-Plast Systemy Dachowe Sp. z o.		Wo?owice
8053	101648	POWER TOOLS PERU SAC		Lima
8054	101649	Dell Baugroup		Soest
8055	101650	SARL Durousseau Outils Coupants		Cenon
8056	101651	SAS AGRI-BESSIN		ST MARTIN DES ENTREES
8057	101653	Algorel		Groupe Algorel
8058	101654	Betz & Co. GmbH	Eisenwaren Beschläge	Stuttgart
8059	101655	Gedex		Groupe Gedex
8060	101656	YESS		Groupe YESS
8061	101662	I&M Bauzentrum Lieder		Halver
8062	101664	Eisen-Schmid GmbH & Co.KG		Hausach
8063	101665	Märklen GmbH & Co. KG	Werkzeuge - Maschinen	Neckarsulm
8064	101666	AFAP	Aquitaine Fixation et Accastillage	La Teste-de-Buch
8065	101668	Beschläge Koch GmbH		Freiburg
8066	101669	Edelmann Fachmarkt GmbH		Bad Mergentheim
8067	101670	Hagebaumarkt Segl		Vilshofen
8068	101671	Eduard Lutz Schrauben-Werkz. GmbH		Weilheim
8069	101672	Eberle-Hald Handel- und Dienst-	leistungen Metzingen GmbH	Stuttgart
8070	101673	Vydra & Herr GmbH	Werkzeuge-Maschinen-Betriebseinr.	Leinfelden-Echterdingen/Stette
8071	101675	Iris		Iris
8072	101678	Eisen Auer GmbH		Singen
8073	101679	Willi Stober GmbH & Co KG		Karlsruhe-Neureut
8074	101680	Bleu Rouge		Bleu Rouge
8075	101686	VEESER Bauzentrum Freiburg	GmbH & Co. KG	Freiburg
8076	101687	J. Kessel GmbH & Co KG		Kehl-Kork
8077	101688	Careso		Careso
8078	101689	Doras		Doras
8079	101694	Samse		Samse
8080	101696	LPDB		LPBD
8081	101699	Brossette		Brossette
8082	101701	Cedeo		Cedeo
8083	101704	SFIC		SFIC
8084	101707	Accueil Négoce Bois Materiau		AccueilNegoceBoisMateriaux
8085	101711	Augier		Augier
8086	101712	VM Materiaux		VM Materiaux
8087	101713	MR SWISS AG		Wettingen
8088	101719	BATILAND		BATILAND
8089	101723	Stabilo Landtechnik GmbH	Werkzeuggrosshandel	Kupferzell-Mangoldsall
8090	101727	Bonifay		Bonifay
8091	101734	Noba Normteile	Handelsgesellschaft mbH	Bad Mergentheim
8092	101737	BVP		BVP
8093	101738	CARMAT		CARMAT
8094	101744	Reisser GmbH	Sanitaer + Heizung	Boeblingen
8095	101746	Eisenhandlung Butsch GmbH		Weinheim
8096	101747	CDE		CDE
8097	101748	Club Bois		Club Bois
8098	101749	DENIS MATERIAUX		DENIS MATERIAUX
8099	101753	Gabriel		Gabriel
8100	101755	Nibler GmbH & Co.KG		Walldorf
8101	101760	Guibout Matériaux		Guibout Matériaux
8102	101762	Lignac		Lignac
8103	101764	Lotz Frères		Lotz Frères
8104	101766	Ziegler Bad Friedrichshall GmbH		Leingarten
8105	101767	Mat +		Mat +
8106	101768	Matnor		Matnor
8107	101769	Pigeon Materiaux		Pigeon Materiaux
8108	101770	Provence Matériaux		Provence Matériaux
8109	101776	SFM		SFM
8110	101778	Sylvalliance		Sylvalliance
8111	101781	Valdeyron		Valdeyron
8112	101783	Moessner GmbH	Elektrogroßhandel	Schorndorf
8113	101786	Boie GmbH	Fachgrosshandel	Heilbronn
8114	101787	Walter Diebold GmbH		Ludwigsburg
8115	101788	SONEPAR		SONEPAR
8116	101789	CGE		CGE
8117	101792	AGIDIS		AGIDIS
8118	101793	Götz + Moriz GmbH	Baustoffe	Freiburg
8119	101800	REXEL		REXEL
8120	101804	GEDIBOIS		GEDIBOIS
8121	101805	Leroy Merlin		Leroy Merlin
8122	101810	Bricoman		Bricoman
8123	101813	Weldom		Weldom
8124	101815	KINGFISCHER		KINGFISCHER
8125	101818	Dr. Keller Maschinen GmbH		Freiburg
8126	101819	Dr. Keller Maschinen GmbH		Mannheim-Käfertal-Süd
8127	101822	CASTORAMA		CASTORAMA
8128	101823	Brico Dépot		Brico Dépot
8129	101824	Outillage		Outillage
8130	101826	Sécurité		Sécurité
8131	101827	Agricole		Agricole
8132	101830	Metabo-Werke GmbH & Co	z.Hd. Marcus Dengler	Nürtingen
8133	101831	Internet		Internet
8134	101832	MG TECHNOPLAN LTD	Limassol 1st Industrial Area	Limassol
8135	101833	Ernst Triebel Eisenwaren	Inh. D. Tägtmeyer	Achim
8136	101834	Alfa doo		Travnik
8137	101842	Block & Job		Block & Job
8138	101843	Siehr		Siehr
8139	101844	Pagot & Savoie		Pagot & Savoie
8140	101845	Comptoir des Fers		Comptoir des Fers
8141	101847	Andrez Brajon		Andrez Brajon
8142	101848	Malrieu		Malrieu
8143	101850	Rouenel		Rouenel
8144	101851	Moy		Moy
8145	101853	Maillard		Maillard
8146	101854	Herbert Pansch KG	Eisenwaren & Baubedarf	Bremen
8147	101855	Mestre		Mestre
8148	101856	Pompac		Pompac
8149	101857	Gommichon		Gommichon
8150	101858	Comet		Comet
8151	101862	Dupont Est		Dupont Est
8152	101863	Somatem		Somatem
8153	101864	Lüssumer Eisenwaren	Arnold Ficke e.K.	Schwanewede
8154	101865	Seca		Seca
8155	101866	Méquisa		Méquisa
8156	101871	Fritz Gabriel GmbH & Co. KG		Bielefeld
8157	101873	Sanisit		Sanisit
8158	101874	Groupe Région 1		Région 1
8159	101876	Oltrogge & Co.KG		Bielefeld
8160	101878	Henze + Bleck GmbH		Ronnenberg
8161	101879	Groupe Région 2		Région 2
8162	101880	Groupe Région 3		Région 3
8163	101881	Groupe Région 4		Région 4
8164	101882	Groupe Région 5		Région 5
8165	101883	Groupe Région 6		Région 6
8166	101884	SARL NEW TOOLS BEY	NIF: 000516097070617	EL-HAMIZ ALGER
8167	101888	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Amsterdam
8168	101889	Au Comptoir Graylois		ARC LES GRAY
8169	101890	OUTIFRAIX		Bordeaux
8170	101895	Heinrich Grotemeier GmbH & Co.KG		Buende
8171	101896	Peter Cibulka Werkzeugtechnik	Schleifservice und Werkzeughandel	Merzen
8172	101897	Dachdecker - Einkauf	Soltau EG	Soltau
8173	101898	A. Köhler Werkzeugtechnik		Leipzig
8174	101899	SARL Dimabois		Cernay
8175	101900	ALG Outillage Pro	Le Gousse André	Poullaouen
8176	101901	EURL Chabirand		Verrieres en Anjou
8177	101904	PARIS SAS		Luxeuil-Les-Bains
8178	101905	Brico Privé		L'union-Toulouse
8179	101906	P.H.M. Plant Services Ltd.		Gloucestershire
8180	101907	SWC	Unit 2 Clifford Park	Biddeford, North Devon
8181	101908	The General Tool Store Ltd.		Whitchurch
8182	101909	Travaux Publics		Travaux Publics
8183	101910	GEADIS		GEADIS
8184	101911	Union Bauzentrum Hornbach GmbH	Lager Börrstadt	Börrstadt
8185	101914	Abbot Fixings		Milton Keynes
8186	101915	Vidal Masterpro	ACT Fournitures industrielles	Ambarès
8187	101916	TIVOLY SA		Tours-En-Savoie
8188	101917	Bufab (UK) Ltd.	Unit F, Centurion Ind. Park	Southampton
8189	101919	Groupe MASTERPRO		GROUPE MASTERPRO
8190	101920	BK Fixings Ltd.		Gwent
8191	101921	Elektro Werk Inc.		Quezon City, Philippines
8192	101924	SARL ECOFIX		Villiers Le Bacle
8193	101925	Meerkötter GmbH		Borken
8194	101928	BNR Ltd.	Unit 516D	Rathcoole, Co. Dublin
8195	101930	Grainger Tubolt Ltd.	Units A&B Meyrick Owen Way	Pembrokeshire
8196	101931	WOCKEN Industriepartner	GmbH & Co.KG	Cloppenburg
8197	101933	Eduard Lutz Schrauben-Werkz. GmbH		Gersthofen
8198	101935	Rawlplug S.A.		Wroclaw
8199	101938	J.H. Jaeger & Eggers	Handelsges. mbH	Bremen
8200	101939	BHB pro Handwerk & Industrie	Inhaber: Armin Berwanger e.K.	Schmelz
8201	101944	Choices		London
8202	101945	Metro Fixings Ltd.	Unit 3 Tewin Court	Hertfordshire
8203	101946	Gedimat Charroin		Brignais
8204	101947	BVM GmbH	Kleinlein Vertriebsbüro Aschau	Aschau
8205	101949	Voskamp Bouw en Industrie B.V.		Assen
8206	101952	GR Fasteners & Engineering Supplies	Units A&B Brunel Court	Gloucestershire
8207	101953	ToolTeam August GmbH		Köln
8208	101954	FAIE Handelsgesellschaft mbH		Regau
8209	101956	SDM Toulouse Matériel		Portet sur Garonne
8210	101958	Bernhard Strunz GmbH		Delbrück
8211	101959	Layer Grosshandel GmbH & Co.KG	Fil. Liebenwalde	Liebenwalde
8212	101961	Peter Belousow GmbH	Elektromaschinenbau	Schrobenhausen
8213	101962	SAS AU FAITE 68		RICHWILLER
8214	101963	Isero IJzerwarengroep B.V.	Breur Ceintuurbaan	Rotterdam
8215	101965	EUROMA	s.a.s.	Bousse
8216	101967	S&P Baushop		Stolberg
8217	101972	Alfred Blöss	Baubeschlag-Bauelemente GmbH	Hannover
8218	101974	F30 Building Products		Clevedon
8219	101975	Betec GmbH	Werkzeuge	Chemnitz
8220	101976	Feldmann & Grever GmbH	Baumaschinen u. Baugeräte	Cloppenburg
8221	101977	P.H. Brauns GmbH & Co.KG	Partner für Technik	Hannover-Ricklingen
8222	101979	Trowbridge Power Tools Ltd.		Wiltshire
8223	101981	Benzi France		Vesoul
8224	101984	Wolfgang Haberzettl GmbH		Uttenreuth
8225	101986	PRETOT	Etablisements	Larians et Munans
8226	101987	HANDLOWA ERBO		Pruszkow
8227	101990	BayWa AG	Zentraler Rechnungseingang	München
8228	101992	BayWa AG Rain A.  Lech	Vertrieb Baustoffe	Rain
8229	101993	Novalution (N. Ireland)		Belfast
8230	101994	Marion	Aldo	Chimilin
8231	101996	Aux Docks de Clamart SA		Clamart
8232	101997	Boulonnerie Visserie Fixation Sàrl	BVF	Bègles
8233	101999	SARL Perfo Plus		Castres
8234	102000	DPR Retail Ltd.		Preston
8235	102002	P.V. Betonfertigteilwerke GmbH		Gersdorf
8236	102006	Centre D'Occasion de l'Est	CODE	Amoncourt
8237	102007	Gantois	Quincaillerie	Jussey
8238	102008	Wocken Industriebedarf	GmbH & Co.KG	Hildesheim - Bavenstedt
8239	102009	Unimet Zentrallager	Hildesheim GmbH&Co.KG	Hildesheim
8240	102011	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Zoetermeer
8241	102012	Vendée Fournitures Industrielles	VFI SARL	Talmont-St-Hilaire
8242	102013	Thies & Co GmbH	Fachhandel	Hoya/Weser
8243	102014	SEBA		SEBA
8244	102015	Comptoir Bordelais d'Exportation	CBE	Le Bouscat
8245	102016	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Haarlem
8246	102017	IBACOM PACA	Georges Albert	Aubagne
8247	102018	Portalet		Portalet
8248	102021	SAS Quincaillerie Portalet		Mont de Marsan
8249	102023	Wilhelm Cordes		Nienburg
8250	102026	C. E. Popken	Inh. Dirk Bünting e.K.	Norden
8251	102028	Wilhelm Linnenbecker GmbH & Co. KG		Bad Salzuflen
8252	102029	thiele & fendel	Oldenburg GmbH & Co.KG	Oldenburg
8253	102031	BMN Bouwmaterialen BV Zuid	Adresse für Rechnungsversand	Veghel
8254	102032	Meesenburg Großhandel KG	NL Oldenburg	Oldenburg
8255	102034	Erwin Beate GmbH & Co. KG	Dachbaustoffe	Solingen
8256	102036	Kötter + Siefker GmbH & Co KG	Fachgrosshandel	Lotte - Büren
8257	102037	MATECOLO		Tartas
8258	102038	Schürmann + Holtorf GmbH		Osnabrück
8259	102040	Ratering Bouw & Industrie B.V.		Ulft
8260	102042	John F Hunt Ltd.		Grays, Essex
8261	102043	Ullner u. Ullner GmbH	Werkzeuge / Maschine	Paderborn
8262	102048	Auer Baustoffe GmbH & Co. KG		Erding
8263	102050	EMA Spezialbaustoffe GmbH		Parsdorf
8264	102051	Baustoffhandel Landsberg Rieth		Landsberg am Lech
8265	102052	IHT Timme GmbH & Co KG		Stadthagen
8266	102053	Wassermann & Co GmbH		Memmingen
8267	102054	Otto Baubedarf		Wörblitz
8268	102055	Isero IJzerwarengroep B.V.	Breur Ceintuurbaan	Rotterdam
8269	102056	MRL Münchner Runde Leistungsverbund	Beteiligungs- Besitz- und	Olching
8270	102058	Dreps GmbH	Christian Dreps	Altshausen
8271	102060	Johannes Ohlendorf GmbH	Stahlgroßhandel-Schrauben-Werkzeuge	Gütersloh
8272	102063	Carrelage		Carrelage
8273	102066	Xibero matériaux		Tardets
8274	102068	Kurt Koenig	Baumaschinen GmbH	Einbeck
8275	102069	OPHIT'CARRELAGES	Centre URBEGI	Anglet
8276	102071	Peak Tools	Willow Brook	Derbyshire
8277	102072	SISCA		SISCA
8278	102073	SISCA	Centre d'achats	Semeac
8279	102074	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Wateringen
8280	102075	Bauzentrum Mayer GmbH & Co.KG		Neuburg
8281	102076	Baustoff Union GmbH & Co.KG		München
8282	102077	Baustoff Union GmbH & Co.KG		Hohenbrunn
8283	102078	Artinger + Ohneis GmbH & Co. KG		Neufahrn
8284	102081	Buchenrieder-Mühlhäusser	Baustoff- Fachhandel	Abensberg
8285	102082	Steinke KG		Perleberg
8286	102083	LANGE GMBH & CO. KG		Kassel
8287	102084	Langenbach GmbH		Siegen
8288	102086	Eisen-Hartmann GmbH		Bad Münder
8289	102087	Leipziger Handelsgesellschaft mbH		Leipzig
8290	102088	Plus 6		Köln
8291	102089	Hancock & Brown		Swansea
8292	102090	Kuhlmann GmbH & Co. KG		Lage-Lippe
8293	102091	Heinrich Dittmar GmbH & Co KG	Stahlhandel	Osterode/Harz
8294	102092	Hans Kiesling GmbH & Co.KG		Bremerhaven-Lehe
8295	102093	Langguth GmbH		Coburg
8296	102094	Jolf Bielefeld		Nordenham
8297	102095	ERPATECH BEATA PRAGA SP. Z O.O.		Mosciska (Warsawa)
8298	102096	MISAR TRADING CO. L.L.C.	Taher Barbhaya	DUBAI
8299	102097	Styl'outillage		Roye
8300	102099	Penlaw Fixings Ltd.	Unit 6, City Cross Business Park	Greenwich
8301	102101	Repmann Technischer Fachgroßhandel	GmbH	Rödelsee
8302	102102	Dieter Schmid	Werkzeuge GmbH	Berlin
8303	102106	Coutaud Manutention		Brem sur Mer
8304	102108	Nüßing GmbH		Verl
8305	102109	Bernd Robben		Meppen
8306	102110	H.H. Rohdenburg GmbH		Lilienthal
8307	102111	Eisen Vetter GmbH		Urbach
8308	102112	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Gorinchem
8309	102114	Druckluft Krapf GmbH & Co. KG		Weiden
8310	102117	Heinrich Holthausen		Bremen-Hemelingen
8311	102118	THS GmbH		Lünen
8312	102120	APIMAB		APIMAB
8313	102121	MAZEAU		MAZEAU
8314	102125	BHB Baubeschlag-	Handelsgesellschaft mbH	Bremerhaven-Lehe
8315	102126	OCLID		OCLID
8316	102127	Neumann-Handels GmbH		Dessau-Rosslau
8317	102128	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Mijdrecht
8318	102129	Werner Ditzinger GmbH		Braunschweig
8319	102130	Maag Technic GmbH		Göppingen
8320	102132	Rubix GmbH		Siegen-Weidenau
8321	102133	Motion Plus Ltd.	Unit 5	Milton Keynes
8322	102134	Böwe GmbH		Aurich
8323	102135	Niehaus GmbH		Melle
8324	102136	Power Tool Supplies		Newark
8325	102137	Friedrich Detering GmbH	Fachgrossh. Sanitär-Heizung	Emden
8326	102139	Isero IJzerwarengroep B.V.	Van der Winkel	Eindhoven
8327	102140	INOVMATERIAUX		Draveil
8328	102141	Industrial Gas & Welding Tools		Temse
8329	102142	Technische Handelsonderneming B.V.		Tynaarlo
8330	102143	Miter Industrial Supplies Ltd.	Unit 11	Newport, Gwent
8331	102146	BMN Bouwmaterialen BV West	Adresse für Rechnungsversand	Veghel
8332	102147	BMN Bouwmaterialen BV Noord	Adresse für Rechnungsversand	Veghel
8333	102148	Auer Baustoffe GmbH & Co. KG		Dorfen
8334	102149	Auer Baustoffe GmbH & Co. KG		Mintraching
8335	102150	Wolfgang Nieweg GmbH	Maschinen-Werkzeuge	Osnabrueck
8336	102151	Wocken Industriebedarf	GmbH & Co.KG	Papenburg 1
8337	102152	Unimet Zentrallager Nord	GmbH & Co Handels KG	Oyten
8338	102153	Auer Baustoffe GmbH & Co. KG		Wartenberg
8339	102155	Auer Baustoffe GmbH & Co. KG		Parsdorf
8340	102156	Baustoff- Zentrum Olching GmbH		Olching
8341	102157	Peter Kasberger Baustoff GmbH		Vilshofen/ Pleinting
8342	102158	Kraft Baustoffe GmbH	Der Dachspezialist	Mönchengladbach
8343	102159	Kraft Baustoffe GmbH	Der Dachspezialist	München
8344	102160	Kraft Baustoffe GmbH	Fassade	Höhenkirchen-Siegertsbrunn
8345	102161	Kraft Baustoffe GmbH		Höhenkirchen-Siegertsbrunn
8346	102163	Kraft Baustoffe GmbH		München
8347	102164	Kraft Baustoffe GmbH		Höhenkirchenen
8348	102165	A. Brickwedde GmbH & Co.KG	Technischer Handel	Osnabrück
8349	102166	Kraft Dienstleistungs GmbH		Heimstetten
8350	102169	Kreklau & Hagedorn	GmbH & Co KG	Seelze 1
8351	102170	Moser Agrar & Baufachzentrum	GmbH & Co.KG	Reichertshausen
8352	102171	Do it! Bau-Heimwerker-Garten-Center	Landsberg GmbH	Landsberg/Lech
8353	102172	Do it! BGM Bau-und Gartenmarkt	Bayreuth GmbH	Bayreuth
8354	102173	August Müller OHG	Schweißtechnik-Werkzeuge	Minden/Westf. 1
8355	102174	Aufträge über 9442 erfassen!	Stang GmbH & Co.KG	Miesbach
8356	102179	Stang GmbH & Co.KG		Rosenheim
8357	102180	Arthur Burkowski KG	Bau-u. Industriebed.	Georgsmarienhütte
8358	102181	Himper & Dreher GmbH		Weißenhorn
8359	102183	Isero IJzerwarengroep B.V.	Van der Winkel	Helmond
8360	102184	LuxTeam Eurasia GmbH		Lübeck
8361	102185	SARL MATERIAUX BRINGEL		Guewenheim
8362	102190	Viet Gia Investment Construction	Company Limited	TP.HCM (Ho Chi Minh)
8363	102193	Schreiber Baumaschinen	GmbH & Co. KG	Bremen
8364	102194	Nagel Baumaschinen	Erfurt GmbH	Erfurt
8365	102195	LLC LID MECH		Yerevan
8366	102196	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Woerden
8367	102198	Holz Herbst GmbH	Ndl. Lüneburg	Lüneburg
8368	102199	Werner Pigorsch GmbH		Bremerhaven
8369	102200	Honig Baustoffe e.Kfm	PFM/ Sanitär	Hameln
8370	102201	Krapp Eisen GmbH & Co.KG		Lohne
8371	102202	Krüger & Scharnberg GmbH	(Standort Eimsbüttel)	Hamburg
8372	102203	Mölders & Scharff Baucentrum	GmbH & Co. KG	Lüneburg-Rettmer
8373	102204	Seeger Baustoffe GmbH		Aichhalden
8374	102206	Hans Schug GmbH		Schuld
8375	102207	Heinz Sanders GmbH		Papenburg
8376	102208	Streich Schneider GmbH		Stein an der Traun
8377	102209	Jevith A/S		Roskilde
8378	102210	SARL Forestier Delchet		Le Mayet de Montagne
8379	102211	Hofmann Elektrotechnik		Schwabach
8380	102213	Isero IJzerwarengroep B.V.	Van der Winkel	S-Hertogenbosch
8381	102214	Kolster Nachf.	Inh. Bastian Grimm e.K.	Osterholz-Scharmbeck
8382	102215	BAUSTOFF UNION GmbH		Weißenburg
8383	102218	CHEMOFAST Anchoring GmbH		Willich
8384	102219	AVRIL		AVRIL
8385	102220	Meesenburg GmbH & Co.KG	Niederlassung Gütersloh	Guetersloh
8386	102223	KIRIEL		KIRIEL
8387	102224	Deluxe Diamond Products Ltd.	Unit 9, Barnfield House	Blackburn, Lancs
8388	102225	Johannes Lefeld	GmbH & Co. KG	Rietberg 1
8389	102227	Prewi Schneidwerkzeuge GmbH		Herford
8390	102228	Rentamin Werkzeugvermietung +	Service UG	Bruckmühl
8391	102229	B.W.L. Handels GmbH		Osnabrueck
8392	102230	WM- Befestigungstechnik	Inh. Tim Wochnik	Kaufbeuren
8393	102231	Karl Dengler GmbH		Frankfurt
8394	102233	My Lemon	Lemon Technologies GmbH	Feldbach
8395	102236	H.W.D -Autoteile		Hildesheim
8396	102237	kwb tools GmbH		Stuhr
8397	102238	Carl Westerhoff GmbH & Co.KG	Technischer Handel	Quakenbrück
8398	102239	Lonecke GmbH & Co. KG		Zetel
8399	102241	Disprotech SAS		Metz
8400	102244	Gebben & Heidemann UG	(haftungsbeschränkt) & Co. KG	Haren-Wesuwermoor
8401	102245	pgb-Europe nv	Logistic Centre	Melle
8402	102247	Baumaschinen Grünhage		Braunschweig
8403	102249	UAB Technosta		Kaunas
8404	102250	Paul Himmelmann GmbH		Großenlüder
8405	102251	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leiden
8406	102252	DALMEX AB		Fagelmara
8407	102253	ITM	International Tool Manufacturing	Plainview, NY 11803
8408	102254	Toolbozz Diamondtools		Soest
8409	102258	KEW Kunststofferzeugnisse	GmbH Wilthen	Wilthen
8410	102259	Gerhardt Bauzentrum GmbH & Co. KG		Butzbach
8411	102260	SOSACA Le Luc		Le Luc
8412	102261	Portafix Ltd.	16/17 Stephenson Close	Andover, Hampshire
8413	102262	Isopro Distribution		Saulxures les Nancy
8414	102263	STC-Trading Oy		Vantaa
8415	102265	BMN Bouwmaterialen BV Oost	Adresse für Rechnungsversand	Nijverdal
8416	102266	SMBL	Société de Matériaux et Bois Leman	Crozet
8417	102267	NV Kestens HFK		Tienen
8418	102268	SARL Serge Marchal Outillage	Marchal Bodin-Agence de Bordeaux	Bordeaux
8419	102269	Stefan Muth Werkzeuge	Handelsvertretung	Lüchow
8420	102271	H. J. Bergmann	Handelsges. mbH & Co.KG	Bremen
8421	102272	Wijck's Afbouwmaterialen BV	Adresse für Rechnungsversand	Veghel
8422	102274	Fricke GmbH & Co KG	Werkzeughandel	Flechtorf
8423	102276	Hans Humpenöder GmbH	Baustofffachhandel	Roth
8424	102279	Aug. Heseding GmbH	Maschinen - Werkzeuge	Lohne
8425	102280	Chiptuning & Teilehandel	Diana Uhrmann	Rinchnach
8426	102281	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ridderkerk
8427	102282	Roman Ridge Roofing & Building Ltd.		Wincobank, Sheffield
8428	102283	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Bodegraven
8429	102285	Isero IJzerwaren B.V.	Gerritse IJzerwaren	Alphen A/D Rijn
8430	102288	Groenhart Group B.V.		Grootebroek
8431	102289	Groenhart Group B.V.		Heemskerk
8432	102290	Groenhart Group B.V.		Heerhugowaard
8433	102291	Groenhart Group B.V.		Schagen
8434	102292	Groenhart Group B.V.		Volendam
8435	102295	Groenhart Group B.V.		Westzaan
8436	102296	Groenhart Group B.V.		Wormerveer
8437	102297	Industriebedarf Niemann-Laes GmbH		Lüneburg
8438	102298	Handelsagentur Thomas Rinke		Duesseldorf
8439	102300	Nuts Bolts Ltd.		Chorley, Lancashire
8440	102303	Hellweg Centrum Bremen GmbH		Bremen
8441	102304	Rüstwerk GmbH & Co. KG		Hamburg
8442	102306	De Bry SA		Ciney
8443	102309	H. Perschmann GmbH	Werkzeug-Grosshandlung	Braunschweig-Wenden
8444	102310	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ede
8445	102311	Carl Arnold Brill GmbH		Nordhorn
8446	102313	ETS DAUSSION		Cazeres
8447	102314	BMN Bouwmaterialen BV	Delft	Delft
8448	102318	BMN Bouwmaterialen BV	Emmen	Emmen
8449	102319	BMN Bouwmaterialen BV	Nijverdal	Nijverdal
8450	102321	AWEMA Ochs KG		Alsfeld
8451	102322	BMN Bouwmaterialen BV	Numansdorp	Numansdorp
8452	102323	BMN Bouwmaterialen BV	Hoorn	Hoorn
8453	102325	BMN Bouwmaterialen BV	Apeldoorn	Apeldoorn
8454	102326	BMN Bouwmaterialen BV	Barneveld	Barneveld
8455	102327	BMN Bouwmaterialen BV	Coevorden	Coevorden
8456	102328	BMN Bouwmaterialen BV		Appingedam
8457	102329	BMN Bouwmaterialen BV	Franeker	Franeker
8458	102331	BMN Bouwmaterialen BV	Groningen	Groningen
8459	102332	BMN Bouwmaterialen BV	Leeuwaren	Leeuwarden
8460	102334	BMN Bouwmaterialen BV	Muntendam	Muntendam
8461	102335	Fritz Weg GmbH & Co.KG	Werkzeuge-Maschinen	Eschenburg-Wissenbach
8462	102336	BMN Bouwmaterialen BV	Sneek	Sneek
8463	102337	BMN Bouwmaterialen BV	Winschoten	Winschoten
8464	102339	BMN Bouwmaterialen BV	Amersfoort	Amersfoort
8465	102340	BMN Bouwmaterialen BV	Den Bosch	Den Bosch
8466	102341	BMN Bouwmaterialen BV	Nieuwegein	Nieuwegein
8467	102342	Troglauer GmbH	Baumaschinen - Baugeräte	Bingen-Dietersheim
8468	102343	BMN Bouwmaterialen BV	Tilburg	Tilburg
8469	102344	BMN Bouwmaterialen BV	Veghel	Veghel
8470	102345	BMN Bouwmaterialen BV	Zaltbommel	Zaltbommel
8471	102346	BMN Bouwmaterialen BV	Cruquius	Cruquius
8472	102347	BMN Bouwmaterialen BV	Den Haag	Den Haag
8473	102348	A. L. Wehr	Inh. Jochen Jung	Haiger
8474	102349	BMN Bouwmaterialen BV	Den Helder	Den Helder
8475	102350	BMN Bouwmaterialen BV	Katwijk	Katwijk (ZH)
8476	102351	BMN Bouwmaterialen BV	Leiden	Leiden
8477	102353	Beli Beyer & Liessmann GmbH&Co.KG	Maschinen + Werkzeuge	Kriftel
8478	102354	BMN Bouwmaterialen BV	Purmerend	Purmerend
8479	102355	BMN Bouwmaterialen BV	Zwaag	Zwaag
8480	102356	BMN Bouwmaterialen BV	Deventer	Deventer
8481	102357	BMN Bouwmaterialen BV	Haaksbergen	Haaksbergen
8482	102358	Wijck's Afbouwmaterialen BV	Ede	Ede
8483	102360	BMN Bouwmaterialen BV	Leens	Leens
8484	102361	Theodor Wölpert GmbH & Co.		Blaichach-Bihlerdorf
8485	102362	Gebr. Ott GmbH	Werkzeuge	Hanau/Main
8486	102364	Lena Seelhorst		Dinklage
8487	102366	Christin Berding		Dinklage
8488	102367	Marcel Schlarmann	Heller Tools GmbH	Dinklage
8489	102368	Heller Tools GmbH		Dinklage
8490	102369	Heller Tools GmbH	Nicole Rottinghaus-Fiswick	Dinklage
8491	102372	MARKETING ABTEILUNG		Dinklage
8492	102373	Sandra Holzenkamp		Lohne
8493	102375	Aquaflo Ltd.	Unit 4 Palmerston Centre	Middlesex
8494	102377	BMN Bouwmaterialen BV	Medemblik	Medemblik
8495	102378	BMN Bouwmaterialen BV		Eindhoven
8496	102379	Hans- Peter Hecker	Elektromeister	Malgersdorf
8497	102380	Mr. Marc Jones		Mid Glamorgan
8498	102381	Mr. Cliff Staines		Blackhall, Co. Durham
8499	102382	Mr. Stephen Bell		West Yorkshire
8500	102384	BMN Bouwmaterialen BV		Oldekerk
8501	102385	BMN Bouwmaterialen BV		Hardenberg
8502	102386	bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Hollenstedt
8503	102388	Selkent Fastenings - SELKENT BRAND	Riverside House	London
8505	102391	SARL KRENOBAT Distribution		Corre
8506	102393	Theodor Wölpert GmbH & Co.		Kuchen
8507	102394	Agent		Agent
8508	102396	Matériaux		Matériaux 3
8509	102397	Quincaillerie		Quincaillerie 3
8510	102398	GSB		GSB 3
8511	102400	Holz-Richter GmbH		Lindlar
8512	102401	Lippetaler Baucenter GmbH	Claudia Mester- Jungeilges	Lippetal-Herzfeld
8513	102403	BMN Bouwmaterialen BV		Arnhem
8514	102404	BMN Bouwmaterialen BV		Winterswijk
8515	102405	BMN Bouwmaterialen BV		Assen
8516	102406	Raiffeisen Waren GmbH		Eisenach-Stregda
8517	102408	Werkzeug-Vogel	Inh. Kamila Vogel	Fronhausen/Lahn
8518	102409	BAUKING Weser-Ems GmbH	(Ndl. Sulingen)	Sulingen
8519	102410	Bauking GmbH Rabattring		.
8520	102412	PWK Knöbber GmbH & Co	Handels KG	Kassel
8521	102415	Wessmann Bauzentrum GmbH & Co. KG		Lingen (Ems)
8522	102418	Wessmann Bauzentrum GmbH & Co. KG	NL Bad Bentheim	Bad Bentheim
8523	102419	Wessmann Bauzentrum GmbH & Co. KG	NL Salzbergen	Salzbergen
8524	102422	Bauzentrum VIERCK GmbH & Co.KG		Sörup
8525	102424	Bauzentrum Seelmeyer		Neunkirchen
8526	102425	Baustoffe Landwehr GmbH		Friesoythe
8527	102426	KremerGlismann GmbH & Co.KG		Elmshorn
8528	102428	Gebhard Landhandel GmbH		Wilstedt
8529	102429	Gebhard Bauzentrum GmbH & Co.		Hagen
8530	102430	Lothar Herrmann	Baumaschinen GmbH	Hanau/Main
8531	102431	BBM Baustoffhandel GmbH & Co.KG		Barsinghausen
8532	102432	bauXpert Christiansen GmbH & Co KG		Wyk/Föhr
8533	102433	bauXpert Christiansen GmbH & Co KG		Achtrup
8534	102437	Voskamp Bouw en Industrie B.V.		Rotterdam
8535	102442	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Culemborg
8536	102444	BMN Bouwmaterialen BV		Woerden
8537	102445	BMN Bouwmaterialen BV		Hoogeveen
8538	102447	Götte GmbH	Baumaschinen - Baugeräte	Kassel
8539	102448	Miller GmbH & Co.KG		Aichstetten
8540	102449	Odörfer Seefelder GmbH		Graz
8541	102450	Zöscher & Söhne	Elektro-,HiFi-,TV- und Beleuch-	Graz
8542	102453	D-TACK Prdodukte für's Handwerk		Hüttlingen
8543	102455	BMN Bouwmaterialen BV		Heerenveen
8544	102456	Martin Freimuth	Inh. Gerd Schellhaas	Oestrich - Winkel
8545	102457	BMN Bouwmaterialen BV		Nunspeet
8546	102458	SP Suisse Profit GmbH		Bülach
8547	102459	BMN Bouwmaterialen BV		Ter Apel
8548	102461	SAS Acbat		Sarreguemines
8549	102462	i&m Bauzentrum Rykena	Berumfehner Holz- und	Großheide
8550	102463	Willi Kasper GmbH		Hilden
8551	102464	Alzmetall Werkzeugmaschinenfabrik	und Gießerei Friedrich GmbH & Co.KG	Altenmarkt
8552	102465	BMN Bouwmaterialen BV		Lelystad
8553	102466	LOCA FRANCE	SARL	Marbache
8554	102467	BMN Bouwmaterialen BV		Deurne
8555	102468	Baubeschlaghandel Schlesinger		Dahme/ Mark
8556	102469	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Gouda
8557	102470	Karl Illas GmbH		Bad Arolsen
8558	102471	Premier Render Supplies Ltd.	Unit 3 & 4	Leeds
8559	102472	Stelter GmbH	Niederlassung Bremen	Bremen
8560	102473	BMN Bouwmaterialen BV		Schagen
8561	102474	WEMAG GmbH & Co. KG		Fulda
8562	102475	Heinrich Meier GmbH		Ainet
8563	102476	BMN Bouwmaterialen BV		Hengelo
8564	102477	BMN Bouwmaterialen BV		Amsterdam
8565	102478	BMN Bouwmaterialen BV		Harderwijk
8566	102479	LandMAXX BHG GmbH	Filiale Radeburg	Radeburg
8567	102482	Construction Site Supplies Ltd.		Slough
8568	102483	Edgar Borrmann GmbH & Co KG		Fernwald
8569	102484	P.H. Brauns GmbH & Co.KG		Braunschweig
8570	102485	BMN Bouwmaterialen BV		Drachten
8571	102486	Eisen-Fischer GmbH & Co.KG		Limburg / Lahn
8572	102488	Atko Group Limited	Unit 29, Rathenraw Ind. Est.	County Antrim
8573	102491	South West Fasteners Ltd.	Unit 7-8 306 Industrial Estate	Brislington Bristol
8574	102492	BOHRER	Mr. Dmitriy Kalinin	Smolensk
8575	102493	Baustoffmarkt Gersthofen		Gersthofen
8576	102494	Joseph Dresselhaus GmbH & Co. KG		Maisach
8577	102497	MH-Vertrieb		Detmold
8578	102498	CENTAR ALATA OSIJEK	Visokokv Alitetni Alati 1 Oprema	Osijek
8579	102499	Rubix GmbH		Mainz
8580	102501	Mölders Baucentrum GmbH		Uelzen
8581	102502	Konrad GmbH		Euskirchen
8582	102503	BMN Zaandam		Westzaan
8583	102504	KOCSIK-TOOLS Werkz. u. Dienstl.	ZNL: Heinrich Meier GmbH	Dieburg
8584	102505	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Amersfoort
8585	102506	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Den Haag
8586	102507	bauzentrum Segl		Hauzenberg
8587	102510	AST Sommer	Akustik-,Stuck- und Trockenbau GmbH	Kirchdorf am Inn
8588	102511	Carter Engineering Supplies Ltd.	5-6 Woodston Business Centre	Peterborough
8589	102514	Denk GmbH & Co.KG	Werkzeuge + Maschinen	Calden
8590	102515	EJOT Baubefestigungen GmbH		Bad Laasphe
8591	102517	Baillet		Bailllet
8592	102518	Calipro		Calipro
8593	102519	BMN Bouwmaterialen BV		Alkmaar
8594	102520	HUF Der Mainzer Fachmarkt		Mainz
8595	102521	GTH GmbH		Fribourg
8596	102522	BMN Bouwmaterialen BV		Doetinchem
8597	102523	BMN Bouwmaterialen BV		Zeist
8598	102525	Eisen Kübel Höfels GmbH		Oberhausen
8599	102526	Carl Beutlhauser	Baumaschinen GmbH	Passau
8600	102527	BMN Bouwmaterialen BV		Ootmarsum
8601	102528	Haberkorn GmbH		Wolfurt
8602	102529	CMPM PONT A MOUSSON		PONT A MOUSSON
8603	102530	BMN Bouwmaterialen BV		Maastricht
8604	102531	BMN Bouwmaterialen BV		Rotterdam
8605	102532	LSDM Limited T/A Leyland		Wembley
8606	102535	Fa. Alexander Ziegler		Villingendorf
8607	102536	Fixfast Ltd.	Merlin House	Sevenoaks, Kent
8608	102537	BMN Bouwmaterialen BV		Dokkum
8609	102538	BMN Bouwmaterialen BV		Best
8610	102540	Schraubenmax		Quickborn
8611	102541	Conecto Ltd.	Alan 086 0217737	Co Meath
8612	102542	BMN Bouwmaterialen BV		Dordrecht
8613	102543	Prager GmbH		Tönisvorst
8614	102544	BMN Bouwmaterialen BV		Stadskanaal
8615	102545	M&H Diatools		Den Haag
8616	102546	Pomex GmbH		Spangenberg
8617	102547	Baustoffmarkt Uhingen		Uhingen
8618	102548	Bankers Gereedschappen BV		Deurne
8619	102549	Khusheim Company For Industrial	Equipments	Dammam  Kingdom of Saudi Arabi
8620	102550	Raiffeisen Waren GmbH		Kassel
8621	102551	BMN Bouwmaterialen BV		Culemborg
8622	102552	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Neukloster
8623	102553	BOIS		Bois
8624	102554	CONSTRUCTION		CONSTRUCTION
8625	102556	ORCAB		ORCAB
8626	102557	Wilh. Holland Letz GmbH & Co.KG		Bebra
8627	102558	Bossong S.p.A		Grassobbio BG
8628	102561	ScrewQuick Ltd.		Salford, Manchester
8629	102562	Bricowelt Quincaillerie Sàrl		Oberpallen
8630	102563	SWD A. Hock GmbH		Darmstadt
8631	102564	BMN Bouwmaterialen BV		Rhenen
8632	102565	BMN Bouwmaterialen BV		Zwolle
8633	102566	Danhauser GmbH & Co KG	Baustoffe	Schwandorf
8634	102569	Franz Schneider GmbH & Co.KG	Technischer Grosshandel	Offenbach am Main
8635	102570	SG-Toolbox GmbH		Linz
8636	102571	Isero IJzerwarengroep B.V.	Gerritse Wijchen	Wijchen
8637	102572	FILO	Filo Baumaterial-Support GmbH	Döttingen
8638	102573	tools & more Simon	Inhaber: Frank Simon	Halle/Saale
8639	102575	Johannes Karl Ritt	Technischer Industriebedarf	Zelking-Matzleinsdorf
8640	102577	BMN Bouwmaterialen BV		Weert
8641	102578	Christian Wittmann	Werkstattbedarf GmbH	Günding
8642	102579	Blasy GmbH		Insbruck/ Neu-Rum
8643	102580	Franz Heydt Fachhandels-GmbH		Rastatt
8644	102582	REDKO GmbH & Co.KG		Leverkusen
8645	102583	Rüger GmbH		Rüsselsheim
8646	102585	Quincaillerie Lapeyre	Denis	St. Girons
8647	102586	A. Sommer GmbH	Werkzeuge-Maschinen	Seligenstadt/Hessen
8648	102587	InDia - Thiemt		Bad Salzdetfurth
8649	102588	AMAZON mit BEILAGE		Vechta
8650	102589	Hermann Kastner GmbH		Zwettl
8651	102590	Kindlinger GmbH		Linz
8652	102591	Ploberger GmbH		Retz
8653	102592	Schmidt's Handelsges.m.b.H.		Bürs
8654	102598	Steyr-Werner	Technischer Handel GmbH	Pasching
8655	102599	Weyland Steiner	Handwerks- und Industriebedarf GmbH	Bergheim
8656	102601	Stahl & Krähe GmbH	Werkzeuge- u. Maschinenhandel	Zweibrücken
8657	102602	Theodor Wölpert GmbH & Co.KG	Baumarkt Murrhardt	Murrhardt
8658	102604	Theodor Wölpert GmbH & Co.KG	Niederlassung Mössingen	Mössingen
8659	102606	Theodor Wölpert GmbH & Co.KG	Niederlassung Bad Urach	Bad Urach
8660	102609	Theodor Wölpert GmbH & Co.KG		Engstingen-Kohlstetten
8661	102611	Köhnen handwerk-& industriebedarf		Polch
8662	102612	Theodor Wölpert GmbH & Co.KG	Niederlassung Göppingen	Göppingen
8663	102613	Theodor Wölpert GmbH & Co.KG	Niederlassung Ellwangen	Ellwangen
8664	102614	Theodor Wölpert GmbH & Co.KG	Niederlassung Kempten	Kempten
8665	102615	Theodor Wölpert GmbH & Co.KG	Niederlassung Meckenbeuren	Meckenbeuren
8666	102616	Theodor Wölpert GmbH & Co.KG	Niederlassung Bad Waldsee	Bad Waldsee
8667	102617	Theodor Wölpert GmbH & Co.KG	Niederlassung Warthausen	Warthausen
8668	102618	Theodor Wölpert GmbH & Co.KG	Niederlassung Ertingen	Ertingen
8669	102619	Theodor Wölpert GmbH & Co.KG	Niederlassung Illertissen	Illertissen
8670	102621	BMN Bouwmaterialen BV		Venray
8671	102622	BMN Bouwmaterialen BV		Enschede
8672	102623	BMN Bouwmaterialen BV		Lemmer
8673	102624	BMN Bouwmaterialen BV		Asten
8674	102625	BMN Bouwmaterialen BV		Haastrecht
8675	102627	BMN Bouwmaterialen BV		Nijmegen
8676	102628	BMN Bouwmaterialen BV		Soest
8677	102629	BMN Bouwmaterialen BV		Enkhuizen
8678	102630	BMN Bouwmaterialen BV Oost	Adresse für Rechnungsversand	Nijverdal
8679	102631	SC OMP SRL		Bacau
8680	102632	Manfred Raskob GmbH	Werkzeuge u. Maschinen	Wittlich
8681	102633	Werkstatt	Heller Tools GmbH	Dinklage
8682	102634	Fixings and Tools Ltd.	T/A Mr. Fixings	Salford, Manchester
8683	102635	C-Serve GmbH		Köln
8684	102636	PT ZI-TECHASIA	22nd Floor Menara Jamsostek Bld.	South Jakarta
8685	102637	Müthing GmbH & Co.KG	Langensteinach	Uffenheim-Langensteinach
8686	102638	Werkzeug Polster		Thallwitz OT Böhlitz
8687	102641	EDER WERKZEUGHANDEL	Christian Eder Walter	Zillingdorf-Bergwerk
8688	102642	E.W. Neu GmbH		Speyer
8689	102643	CD JUWEL GmbH	Andreas Hühn	Thyrnau / Passau
8690	102644	Homberg Eisenhandel GmbH	Josef Ruhland	Dingolfing
8691	102645	Festool GmbH		Wendlingen
8692	102646	Georg Pirrung GmbH		Bexbach
8693	102647	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Nieuw Vennep
8694	102649	Toolstation SAS		Saint Priest
8695	102650	Toolstation		Toolstation
8696	102651	Sealants and Tools Direct		Newton Abbot,Devon
8697	102653	Craven Eye PBG / HTG Suppliers Ltd.		Middlesex
8698	102654	Corefix Ltd	The Innovation Centre	Newport, Isle of Wight
8699	102657	Kruyt	Bouw en Industrie	Leiderdorp
8700	102659	Mölders Baucentrum GmbH		Tangermünde
8701	102660	Good Traders UG(Haftungsbeschränkt)		Bremen
8702	102663	Ladwein GmbH & Co. KG		Dierdorf
8703	102667	Schnellversand-Miller		Dinklage
8704	102671	Baillargeat	SA Quincaillerie	Andernos Les Bains
8705	102672	Piel GmbH		Eisenhüttenstadt
8706	102674	ZITEC Industrietechnik GmbH		Plattling
8707	102676	TP Location		Hoerdt
8708	102677	EJOT TEZMAK Baglanti Elem.Tekn.	San ve Tic. A.S.	Istanbul 34250
8709	102678	Waltraud Rothamel	Handelsvertretung für Werkzeuge	Barchfeld-Immelborn
8710	102680	LINK CZ, s.r.o.		Paskov
8711	102683	Eisenhof Liezen		Liezen
8712	102685	Felix Trautmann		Sulzbach am Main
8713	102687	DBZ Dinkelsbühler Baustoffzentrum	GmbH	Dinkelsbühl
8714	102688	Tecnaria S.p.A.		Bassano del Grappa (VI)
8715	102689	ParkerSteel Ltd		Kent
8716	102690	SIGD Manchester		Manchester, Lancashire
8717	102693	Huber GmbH		Tiefenbach
8718	102695	UNION Bauzentrum HORNBACH GMBH	Fil. Buchen	Buchen
8719	102696	Milwaukee		Brookfield WI 53005 USA
8720	102699	REVENDEUR SPECIALISE 3		REVENDEUR SPÉCIAL 3
8721	102700	E.W. Neu GmbH	Werkzeuge + Maschinen	Worms
8722	102701	Atala GmbH & Co.	Fliesen- und Sanitärhandel KG	Berlin
8723	102702	Smit Maassluis BV		Maassluis
8724	102705	GSB	Grande surface bricolage	GSB
8725	102706	LOCATION		LOCATION 3
8726	102707	Internet		WEB 3
8727	102708	Gillet Baustoffe GmbH		Neustadt
8728	102709	Fabricant		Fabricant
8729	102710	Würth Belux N.V.		Turnhout
8730	102711	Reitex GmbH		Ruderting
8731	102712	Chr. Ufer GmbH	Stahl- und Sanitärgroßhandel	Landau/Pfalz
8732	102713	Dinger & Voigt Werkz. GH und	Werkstattausr. Inh. T. Dinger e.K.	Plauen
8733	102714	Metallit GmbH	Thomas Kraemer	Bielefeld
8734	102715	Jardin		Jardin
8735	102716	ENTUZIAST		Belgrad
8736	102717	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren (Beukers)	Hilversum
8737	102718	STAMAG Ersatzteil- und	Industrievertrieb GmbH	Landsberg OT Queis
8738	102720	Lievertz Fachgroßhandel Haust.	Zweigniederl.J.W.Zander GmbH &Co.KG	Kleve
8739	102721	F. Schünke GmbH		Engen
8740	102722	Industrieterrein Remmerden		Rhenen
8741	102723	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Veenendaal
8742	102725	Macsalvors Ltd.		Redruth
8743	102726	TERWECO C.V.		OLDENZAAL
8744	102727	SSW Bedachungs- und Holzfachhandel		Heinsberg
8745	102728	Werkzeugtechnik Günter	Inh. Frank Günter	Castrop Rauxel
8746	102729	Hans Schmidt GmbH	Werkz.Masch.Industriebed.	Kaiserslautern
8747	102731	R. Holzschuh Baugeräte		Sulzbach
8748	102733	EDIL2000 SRL		Altamura BA
8749	102734	Scheiber GmbH	Befestigungselemente	Weilerbach
8750	102736	Robert Schlott Werkzeuge und	Maschinen	Geretsried
8751	102737	RM Diffusion	Mr. Mohammed Regui	Casablanca Marokko
8752	102738	Mobau Wirtz & Classen		Kempen
8753	102740	TECNOSERVICE DI MARTIN RENATO		Lugugnana Di Portogruaro
8754	102742	Leinad GmbH		Fernitz bei Graz
8755	102744	blizz-z Handwerk Direkt GmbH		Feuchtwangen
8756	102745	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ijsselstein
8757	102746	Isero IJzerwarengroep B.V.	Van der Winkel	Venray
8758	102747	Markus Meisnitzer	MM industrie	Salzburg
8759	102748	G.Elsinghorst	Stahl und Technik GmbH	Bocholt
8760	102749	Andresen & Jochimsen GmbH& Co. KG		Hamburg
8761	102750	Marcel Bornemann		Hamburg
8762	102753	Pietsch Haustechnik GmbH		Leipzig
8763	102754	Uhlendorff GmbH & Co KG		Mönchengladbach
8764	102755	Grill Großhandels GmbH		Kapfenberg
8765	102756	helbig & bertholdt oHG	Werkzeug und Industriebedarf	Mönchengladbach
8766	102757	HYDROTECNO SRL		Ponte nelle Alpi
8767	102759	Werkzeuge & Maschinen	Neuber Präzisionswerkzeuge	Freilassing
8768	102760	Diamond Tool Supplies Ltd.		Shrewsbury
8769	102761	REMI- Baumaterialien GmbH		Wettingen AG
8770	102762	Zingen Fachmarkt	Inh. Martin Mertes	Speicher
8771	102763	B+M Baustoff+Metall Handels-GmbH		Heilbad Heiligenstadt
8772	102764	STI BV		Hengelo
8773	102765	Strobel Elektrotechnik		Rheinfelden
8774	102766	B. Schlichter GmbH & Co. KG	Ndl. Süd	Heppenheim
8775	102770	WS Weinmann & Schanz GmbH		Balingen
8776	102771	Bartsch & Feikes	Werkzeuge & Maschinen GmbH	Brüggen
8777	102772	Walter Nilsson GmbH & Co.KG		Osnabrück
8778	102773	B & S Werkstattbedarf e.K.		Mömlingen
8779	102774	Johann van Beusekom e.K.	Werkzeuge + Maschinen	Kleve
8780	102776	BAUKING Westfalen GmbH	FH Essen Ges.-Nr.144107	Essen
8781	102777	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
8782	102778	BEVER GmbH		Kirchhundem-Würdinghausen
8783	102779	Fournitures Industrielles Billet	SAS	Valserhone
8784	102780	Billet Fournier	SAS	Meythet
8785	102782	EDE FRANCE		EDE FR
8786	102783	BILLET FOURNIER		BILLET FOURNIER
8787	102784	BILLET FOURNIER 3		BILLET FOURNIER 3
8788	102785	schraubenkontor24	Inh. Steffen Kopke	Malschwitz
8789	102786	De Lentdecker Luc NV		Demdermonde
8790	102787	Christian Werzner	Baumaschinen	Olbernhau
8791	102788	GRAMA TRADE GmbH		Graz-Neuhart
8792	102789	Innovative Tools GmbH + Co. KG		Haan-Gruiten
8793	102790	Ballas GmbH		Aichach
8794	102791	BDW & Sauna	Matthias Rother	Suhl
8795	102792	HBiW Bernd Joest	Gewerbepark	Bad Berka
8796	102793	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Houten
8797	102794	C&J Direct GmbH & Co.KG		Verl
8798	102795	Comptoir d'Importation Bordelaise	CASAL SAS	Artigues-Près -Bordeaux
8799	102796	Industrie-Service-GmbH		Althengstett
8800	102797	Linzing & Dörr Heiz.-und	Sanitärgroßhdl. GmbH	Biebesheim
8801	102798	Lochter Industriebedarf	und Service GmbH	Oberhausen
8802	102799	HAKI Befestigungstechnik	Technischer Großhandel	Untersteinach
8803	102800	White Hinge Ltd.	C/O Dee Set Distribution Centre	Fenton, Stoke on Trent
8804	102801	Newton Hale & Sons Limited	Independence House, Cathcart Quay	Birkenhead, Merseyside
8805	102802	Heller Tools RUS, LTD		Moscow
8806	102803	GFB Handelsgesellschaft	Bef. Technik GmbH	Oberhausen
8807	102804	Bussemas & Pollmeier GmbH & Co.KG		Harsewinkel
8808	102805	Bussemas & Pollmeier GmbH & Co.KG		Gütersloh
8809	102806	Planet Plus Ltd.		Hampshire
8810	102808	Cornelisse	Hecht-Techniek B.V.	Woerden
8811	102809	Power Tools Plus Ltd.		Colwick, Nottingham
8812	102810	bau Spezi Handels GmbH Lauter		Lauter-Bernsbach
8813	102811	Peter Kasberger Baustoff GmbH		St. Florian am Inn
8814	102813	Eisen Schütz  Nachf. GmbH		Duisburg 12
8815	102814	Handelshof Vorpommern	Neubrandenburg	Neubrandenburg
8816	102819	BV C-Supply		Temse
8817	102820	Hansen Seest ApS	Herr Per Hansen	Kolding
8818	102822	Kadach & Rick GmbH		Sankt Augustin
8819	102824	NB Nürnberger Bund PVH  GmbH	Herr Verbiest	Hagen
8820	102825	NB Nürnberger Bund PVH GmbH	Fachgruppe Werkzeuge	Hagen
8821	102826	Karl Kemper GmbH & Co. KG		Gelsenkrichen
8822	102827	NV Hout-& Bouwcenter Van den Nest		Aalst
8823	102828	Wilhelm Fülling GmbH		Mülheim
8824	102829	Raiffeisen Waren GmbH		Erfurt
8825	102830	Reply d.o.o.		Podstrana
8826	102832	Fernholz & Gördes GmbH		Hagen
8827	102833	Rudolf Krämer	Eisenwaren GmbH	Duisburg 14/Rheinhausen
8828	102835	Baupart GmbH		Bottrop
8829	102836	Richter Baustoffe GmbH	(Baustoffe Hagenow)	Hagenow
8830	102837	Baustoff Union GmbH		Nürnberg
8831	102839	Mister Fasteners Ltd.		Bideford, Devon
8832	102840	Baumaschinen Grünhage GmbH		Hohe Börde OT Irxleben
8833	102842	H. Wollschläger GmbH & Co.KG		Bochum
8834	102843	East Engineering Components Ltd.	Unit 9	Milton Keynes
8835	102845	EURAFCO GmbH		Rellingen
8836	102846	Makita nv		Kortenberg
8837	102847	Wilhelm Linnenbecker GmbH & Co.KG		Hannover
8838	102848	JACOB CEMENT FLIESEN	Jacob Sönnichsen AG	Kritzmow OT Klein-Schwaß
8839	102849	TIB Technischer Industrie-Bedarf	Lackmann GmbH	Essen
8840	102850	J.W. Zander GmbH & Co.	PRIVATE LABEL ZA-TEC	Essen
8841	102851	F. LLI PUPPA SRL		LU
8842	102852	J.W. Zander GmbH & Co		Essen
8843	102853	Rudi Droxner	Baubeschläge und Eisenwaren	Bad Saulgau
8844	102854	GoldmannLindenberger GmbH & Co. KG		Pforzheim
8845	102855	Jens-Günther Hagelstein	WERKZEUGE HAMBURG	Hamburg
8846	102856	Bauzentrum Schulte GmbH & Co.KG	KG  NL BauXpert Brak	Rhede (Ems)
8847	102857	Van de Velde - Wilems NV		Eeklo
8848	102859	UK Building Products Ltd.	GripIt Fixings	Melksham, Wiltshire
8849	102860	Peter von Ohle GmbH		Essen
8850	102861	DER BAUSTOFF-MANN	Schneider KG	Oberhausen
8851	102862	Kipp & Grünhoff GmbH & Co. KG		Leverkusen
8852	102863	Kipp & Grünhoff GmbH & Co. KG		Ratingen
8853	102865	Kipp & Grünhoff GmbH & Co. KG		Bergisch Gladbach
8854	102868	Baustoff-Allianz Süd GmbH		Ingolstadt
8855	102870	Mahler Bayerische Bauwaren GmbH		Feldkirchen
8856	102871	Bauwaren Mahler GmbH		Augsburg
8857	102872	Isero IJzerwarengroep B.V.	Gerritse Amsterdam Noord	Amsterdam
8858	102873	Friedrich Delker GmbH & Co KG	Werkzeuge-Maschinen	Essen
8859	102874	Ahlsell Sverige AB		Hallsberg
8860	102877	Beratung Handel Werkzeuge	Inh. D.Kawka	Markersdorf
8861	102878	Richter Baustoffe GmbH	(Baustoffhandel)	Lübeck
8862	102879	Richter Baustoffe GmbH & Co. KGaA		Talkau
8863	102880	Richter Baustoffe GmbH		Barsbüttel
8864	102881	Bauzentrum Zerssen GmbH & Co. KG		Rendsburg
8865	102882	Hoofdzetel Central Auto		Antwerpen
8866	102883	IHS-Hofbauer GmbH		Cham-Chammünster
8867	102884	Baufachzentrum Falkenhagen GmbH		Holthusen
8868	102885	Richter Baustoffe GmbH & Co. KGaA		Bad Schwartau
8869	102886	WERKTOY GbR	Werkezeug & Mehr	Wildeshausen
8870	102887	Breur IJzerhandel		Den Haag
8871	102888	Troy (UK) Ltd. t/a THS Tools	Salisbury House	Templeborough, Rotherham
8872	102889	Baufachzentrum Falkenhagen GmbH	Niederlassung Wittenberge	Wittenberge
8873	102890	OOO ENERGOUSKUNATAMINOT		Taschkent
8874	102891	EisenRon.de	Inh. Ronny Sorgenfrei	Delitzsch
8875	102892	Toolendo GmbH & Co.KG		Erbendorf
8876	102893	Baufachzentrum Falkenhagen GmbH		Neuruppin
8877	102894	Nybra Maskin as		Oslo
8878	102895	Baufachzentrum Falkenhagen GmbH		Pritzwalk
8879	102899	SAS ARKEDIA		Turckheim
8880	102900	ADSOLS	Sarl	ANTIBES
8881	102901	HFM-Nordholz Handelsges. mbH		Luckenwalde
8882	102902	HFM-Nordholz Handelsges. mbH		Berlin
8883	102903	Richter Baustoffe GmbH	(Ndl. Wismar Baustoffe)	Dorf Mecklenburg OT Steffin
8884	102904	HIKOKI POWER TOOLS Netherlands B.V		Nieuwegein
8885	102905	Max Schierer GmbH		Cham
8886	102906	Ludwig Schierer GmbH		Cham
8887	102907	HFM-Nordholz Handelsges. mbH		Berlin
8888	102908	Mapeco Kalmthout-Nieuwmoer NV		Kalmthout-Nieuwmoer
8889	102909	Richter Baustoffe GmbH	(Ndl. Kiel)	Kiel
8890	102910	Berliner Schrauben GmbH & Co KG	Logistikzentrum	Dahlwitz-Hoppegarten
8891	102911	Mobau: Pegels Viersen		Viersen
8892	102912	Schrauben Jansen GmbH		Neuss
8893	102913	Chopshoptools Ltd.		Bridgend, Mid Glamorgan
8894	102914	EXPERTbeslag A/S		Glostrup
8895	102915	Toolstation (Middleton) Ltd.		Middleton, Manchester
8896	102916	ROTH ESPACE GRANIT	Sarl	NEUF BRISACH
8897	102917	Baucentrum Stewes GmbH & Co.KG		Dinslaken
8898	102918	ARTISANS		Artisans
8899	102919	MTB Marienthaler Baustoffhandel	GmbH	Zwickau
8900	102920	Raiffeisen-Waren GmbH		Gera
8901	102922	GLOBAL SOURCE MIDDLE EAST GENERAL	TRADING LLC	DEIRA DUBAI, UAE
8902	102923	Richter Baustoffe GmbH		Behl
8903	102924	BAUKING Südwestfalen GmbH		Finnentrop
8904	102925	Karl Gollinger	Werkzeuge + Maschinen	Augsburg
8905	102927	Hass + Hatje GmbH	Bauzentrum Uetersen	Uetersen
8906	102928	Alois Herrmann GmbH		Merchweiler
8907	102930	M & M Industrietechnik GmbH		Harrislee
8908	102931	Reisinger GmbH		Burghausen
8909	102932	Dachbaustoffe Rath GmbH & Co. KG	(Ndl. Schwerin)	Schwerin
8910	102933	Alexander Keller		Albstadt
8911	102934	APM Plumbing Ltd.		London
8912	102936	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren (Savannah)	Utrecht
8913	102938	Fischer-J.W. Zander GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Erlenbach
8914	102939	Wilhelm Rink GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Wetzlar
8915	102940	J.W. Zander GmbH & Co. KG		Freiburg
8916	102941	LuDz Mitte GmbH & Co. KG	Hermann Albert Bumke GmbH & Co. KG	Hannover
8917	102942	Leib Industrieausrüstungen GmbH		Wettenberg-Launsbach
8918	102943	Cl. Bergmann GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Kassel
8919	102944	Heix GmbH & Co. KG		Geldern
8920	102945	UK-European Farm Supplies Ltd.		Montrose
8921	102946	BPG De Hillegomse	Hout & Bouwmaterialen	Hillegom
8922	102948	Penlaw Fixings North Ltd.		Warrington
8923	102950	ADSOLS	Sarl	ANTIBES
8924	102951	Baucentrum Stewes GmbH & Co.KG	(hagebaumarkt Wesel)	Wesel
8925	102953	Max Schierer GmbH		Straubing
8926	102954	Dachbaustoffe Rath GmbH & Co. KG		Rostock
8927	102955	DHZ joye - den baes BVBA		Lichtervelde
8928	102956	Dachbaustoffe Rath GmbH & Co. KG		Barsbüttel
8929	102958	Berger Bau- u. Industriebedarf GmbH		Traunstein
8930	102959	Werkzeug-Kontor Lübeck		Lübeck
8931	102961	BauKing GmbH	(Ndl. Iserlohn)	Iserlohn
8932	102963	Hotze Baucentrum GmbH & Co.KG		Köthen
8933	102964	Hotze Baucentrum GmbH & Co.KG		Staßfurt
8934	102965	Christian Knieß GmbH	Friedberger Eisenhandlung	Friedberg
8935	102966	Ludwig Falk	Inh. Clemens Drexlmeier	Frontenhausen
8936	102968	Godevaart Eyckermann BVBA		Brasschaat
8937	102970	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
8938	102971	GEDIMAT CORTELLONI	Sàrl	TOULON
8939	102973	BWM Baugeräte Werkzeughandel	Minden GmbH	Minden
8940	102974	BMN Wijcks Afbouwmaterialen Kampen		Kampen
8941	102977	Beuter Handelsvertretung		Lohmar
8942	102978	BHG Raiffeisen-Warengenossenschaft	Wittstock eG	Wittstock
8943	102979	Richter Baustoffe GmbH		Schneverdingen
8944	102980	STAHLGRUBER GmbH		Poing bei München
8945	102982	Keller & Kalmbach GmbH		Unterschleißheim
8946	102985	GEDIMAT CORTELLONI	Sàrl	La Seyne sur Mer
8947	102986	GEDIMAT CORTELLONI	Sàrl	Le Pradet
8948	102987	Klokow Industrietechnik GmbH		Lübeck
8949	102988	Deubler GmbH		Wertingen
8950	102989	Rudolf Sievers GmbH	Partner für Technik	Glinde
8951	102991	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Den Haag
8952	102992	Bandock	Alexis	Champillon
8953	102993	Lösch Schrauben GmbH		Nürnberg
8954	102994	Eisen Fischer GmbH		Nördlingen
8955	102995	Schurrer GmbH & Co.KG		Nördlingen
8956	102997	SOGEA EST BTP SASU	Etablissement MULLER THA	Pont-a-Mousson Cedex
8957	102998	IHL Industriebedarf Hoyer		Leipzig
8958	102999	Gassmann Industriebedarf GmbH		Heilbad Heiligenstadt
8959	103000	Baustoff Union GmbH		Forchheim
8960	103001	Danhauser GmbH & Co KG	Baustoffe	Weiden
8961	103002	Expo Drill & Tools		Tenby
8962	103003	Rompel Baustoffe GmbH	(Ndl. Biedenkopf)	Biedenkopf-Breidenstein
8963	103005	OOO AstErabel		Grodno-Weisrussland
8964	103006	Dilworth & Morris Engineers Ltd.		High Peak, Derbyshire
8965	103007	CEG-Central European Group s.r.o.		Zlaté Moravce
8966	103008	3D Tooling Limited		Bolton, Lancashire
8967	103009	Krüger & Scharnberg G.m.b.H.	(Standort Wandsbek)	Hamburg
8968	103010	J.N.Kreiller KG		Traunstein
8969	103011	Tim Service GmbH		Bad Saulgau
8970	103013	Rompel Baustoffe GmbH		Bad Berleburg
8971	103014	Flintnine Fasteners Limited		Manchester
8972	103015	Jacob Boer B.V.		Goes
8973	103016	DESBOIS	Claude	Plelan le Grand
8974	103017	BayWa AG Marktredwitz	Vertrieb Baustoffe	Marktredwitz
8975	103018	Mercer & Sons Ltd.		Blackburn
8976	103019	Sylvia Schwesig Werkzeuge	Eisenwaren	Crivitz
8977	103020	Krüger & Scharnberg GmbH	(Standort Winterhude)	Hamburg
8978	103021	Mosswood Industrial Supplies Ltd.		Cwmbran, Torfaen
8979	103023	Baucentrum Stewes GmbH & Co.KG	(Baustoffhandel Wesel)	Wesel
8980	103024	Follmann Baustoffe GmbH		Binsfeld
8981	103026	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Almere
8982	103027	TROY (UK) Ltd.	Roundswell Business Park	Barnstaple, Devon
8983	103028	Hüllinghorst Maschinenhandel		Bielefeld
8984	103029	Wensley Mini Market	t/a Premier Plumbing and DIY	Blackburn
8985	103030	T-Tec UG		Hildburghausen
8986	103031	Logistik- und Dienstleistungs-	zentrum	Bochum
8987	103032	BM Sondermaschinen	Werkzeuge und Montage	Nürnberg
8988	103033	HBV Holz-& Baustoff-Vertriebs GmbH	& Co.KG	Wilhelmshaven
8989	103034	Josef Thelen GmbH & Co.KG	Fachmarkt	Simmerath
8990	103035	Fritz Krieger GmbH & Co. KG		Longuich
8991	103037	eberle-hald Handel und Dienst-	leistungen Bühl GmbH	Bühl
8992	103038	W+R INDUSTRY GmbH		Metzingen
8993	103039	MS Distribution Sàrl		CREVIN
8994	103042	GROUPE MS Distribution		CREVIN
8995	103043	IBACOM - Jean Francois Rogue		Chappes
8996	103044	BMJ S.A.S.U		Celles sur Durolle
8997	103045	Andara Tools & Plant Hire Ltd.		Orpington
8998	103046	FOCUS PLANT HIRE		ORPINGTON, KENT
8999	103047	De Jong & Roos B.V.		Schagen
9000	103049	AD Fixings Ltd.		Newcastle upon Tyne
9001	103050	ISERO Ijzerhandel B.V.	Pijnenburg	Kaatsheuvel
9002	103051	SGS Industrial Services GmbH		Dorf an der Pram
9003	103052	Cl. Bergmann GmbH & Co. KG		Kassel
9004	103053	Isol-Rénov Habitat SAS		Bitche
9005	103055	Genissel ENP SARL	Vincent	Roussé-Vassé
9006	103056	BAUEN+LEBEN GmbH & Co.KG		Ottendorf-Okrilla
9007	103057	Europarts b.v.	Auto onderdelen & Hydraulische	Aalsmeer
9008	103058	SIG Technical Insulation - Swansea		Ammanford, Swansea
9009	103059	Friedrich Bauzentrum GmbH & Co. KG		Elz
9010	103060	Nagel Baumaschinen	Frankfurt GmbH	Frankfurt
9011	103061	Raiffeisen Waren GmbH	(Ndl. Fritzlar)	Fritzlar
9012	103062	Ecitec Toolbox Outlet		Assen
9013	103063	E.Raiss GmbH & Co. Baustoffhandel	KG	Thannhausen
9014	103068	Josef Sedlmayr e.k.	Inhaber Sedlmayr-Bekmann	Freyung
9015	103069	CRH		Amsterdam
9016	103070	David Harries & Co.		Whitland, Carmarthen
9017	103072	Maschinen Stockert	Großhandels-GmbH	Hohenbrunn / München
9018	103073	Capital Baustoffe GmbH		Berlin
9019	103074	BAUKING Südwestfalen GmbH	(Ndl. Siegen)	Siegen
9020	103075	Raiffeisen Waren GmbH	(Ndl. Hünfeld)	Hünfeld
9021	103076	YM FIX SARL		Le Pin
9022	103077	Baushop Express GmbH		München
9023	103078	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leiden
9024	103079	Smit-Commerce d.o.o.		Gornji Stupnik
9025	103080	Jens Scherzer	schrauben-dealer.com	Plauen
9026	103081	SFI SASU		Ennezat
9027	103082	Bohrstand	Heller Tools GmbH	Dinklage
9028	103083	ALFIS SARL		Chennevriéres sur Marne
9029	103084	HEIMWERK Baumarkt - Genthin		Genthin
9030	103086	HEIMWERK Baumarkt - Burg		Burg
9031	103088	OKOV INTERNATIONAL LLC		Belgrade-Novi
9032	103089	BMN IJzerwaren Den Helder		Den Helder
9033	103090	Falk Rauch Werkzeuge		Magdeburg
9034	103091	KRAFT Shpk		Tirana, Kashar
9035	103092	FDB Guardian GmbH		Neuenstein
9036	103093	BAUKING Westfalen GmbH	(Ndl. Hagen)	Hagen
9037	103094	Ruf Bauzentrum GmbH & Co.KG		Feuchtwangen
9038	103095	TSS Tools Supply - Import Company		Arnhem
9039	103096	BAUKING Ostfalen GmbH	Fachhandel Braunschweig	Braunschweig
9040	103097	Ems Schrauben GmbH		Werlte
9041	103099	C. G. Christiansen GmbH & Co.	(Baustoffe + Holz)	Flensburg
9042	103100	Handelshof Vorpommern GmbH	Partner für Technik	Grimmen
9043	103101	V Produkte GmbH	Falk Schönau	Plößberg
9044	103103	btb Rockermeier	Diamanttechnik	Reichertshofen/Hög
9045	103104	Rawlplug Co. Ltd.	Thornliebank Ind. Estate	Glasgow
9046	103105	Nawrot Groß- u. Einzelhandel		Ahlen (Westfalen)
9047	103106	Bauking Südwestfalen	(Ndl. Arnsberg)	Arnsberg
9048	103107	BAUKING Ostfalen GmbH	(Ndl. Halberstadt)	Halberstadt
9049	103108	Henselmann et Fils Sarl		Niderviller
9050	103112	Raiffeisen-Waren GmbH		Meiningen
9051	103114	Nouvelle Quincaillerie Bordelaise	Benedetti SARL	Eysines
9052	103115	DONCKERS ANTWERPEN		Antwerpen
9053	103116	Handwerkskammer für Oberfranken	Berufsbildungs- und Technologie-	Bayreuth
9054	103117	SSW Bedachungs- und Holzfachhandel	GmbH & Co. KG	Mönchengladbach
9055	103120	Dänus Baubedarf GmbH		Gebenstorf
9056	103121	Klokow Industrietechnik GmbH		Schwerin
9057	103122	SAS ILE DE FRANCE FIXATION		Saint Denis la Plaine
9058	103123	Gehelle	SAS	Varenne Saint Hilaire
9059	103124	Stanley Black & Decker GmbH		Idstein/Taunus
9060	103125	leikon metall & technik GmbH	Vertriebsgesellschaft mbH	Lienz
9061	103126	Quincaillerie Dubos	SARL	Noisy le Grand
9062	103127	BAUKING Südwestfalen GmbH	(Ndl. Meinerzhagen)	Meinerzhagen
9063	103128	LM Fixations Sarl		Bussy-Saint-Georges
9064	103129	Rabattring Frankreich Großhandel		.
9065	103130	Rabattring Frankreich Fachhandel		.
9066	103132	Laboureau	Sarl	Paris
9067	103133	Diamant Löttechnik Nord GmbH		Husby
9068	103134	Suchail	SAS	Saint Étienne
9069	103135	Alois Jakob Metall am Bau GmbH		Waldkirchen
9070	103136	Keil Profi-Werkzeuge GmbH		Engelskirchen-Loope
9071	103137	CPA-Werkzeuge		Aichach
9072	103138	Raiffeisen-Waren GmbH		Mühlhausen
9073	103139	BAUKING Ostfalen GmbH	(Ndl. Salzwedel / Brietz)	Salzwedel OT Brietz
9074	103140	Phoenix Industrial Supplies Ltd.	Cardiff Branch	Cardiff
9075	103141	Origo Distribution Ltd.		Dublin
9076	103142	Bauxpert Knipper GmbH & Co. KG		Werlte
9077	103143	Terratruck Distribution Serv. Ltd.		Leicester
9078	103144	Yorkshire Fixings Solutions Ltd.	Unit E3, Otley Mills	West Yorkshire
9079	103145	METALKA ZASTOPSTVA TORNA, D.O.O.		Ljubljana-Crnuce
9080	103146	Uždaroji akcin? bendrov? "Glomera"		Garliavos
9081	103147	REVERT SAS CARNOT SAS		Versailles
9082	103148	BAUKING Berlin-Brandenburg GmbH		Potsdam
9083	103149	BAUKING Berlin-Brandenburg GmbH		Königs Wusterhausen
9084	103150	BAUKING Berlin-Brandenburg GmbH		Brandenburg
9085	103152	BAUKING Berlin-Brandenburg GmbH		Hoppegarten
9086	103153	BAUKING Berlin-Brandenburg GmbH		Fürstenwalde
9087	103154	BAUKING Berlin-Brandenburg GmbH		Berlin Hohenschönhausen
9088	103155	BAUKING Berlin-Brandenburg GmbH		Berlin Schöneberg
9089	103156	High-Tech Sealants & Fixings Ltd.		Swindon, Wiltshire
9090	103157	Beilke GmbH		Soest
9091	103158	BAUKING Südwestfalen GmbH	(Ndl. Plettenberg)	Plettenberg
9092	103159	FRW	Falk Rauch	Magdeburg
9093	103160	Luschka & Wagenmann GmbH & Co.KG		Mannheim
9094	103161	Polvo B.V.	Holtgrefe Waalwijk	Waalwijk
9095	103163	J.W. Zander GmbH & Co. KG WEST	PRIVATE LABEL ZA-TEC	Bochum
9096	103165	BAUKING Ostfalen GmbH	(Ndl. Magdeburg)	Magdeburg
9097	103166	Bussemas & Pollmeier GmbH & Co.KG		Bielefeld
9098	103167	team baucenter GmbH & Co KG		Neustadt
9099	103168	BAUKING Südwestfalen GmbH	(Ndl. Lennestadt)	Lennestadt
9100	103169	Hubert Graf Technisches Geschäft	GmbH	Rheine
9101	103170	BAUKING Berlin-Brandenburg GmbH		Prenzlau
9102	103171	WTH Jens Lüdemann		Großenhain/ OT Strauch
9103	103172	BAUKING Weser-Ems GmbH	(Ndl. Melle)	Melle
9104	103173	Rabattring Frankreich Sosaca		.
9105	103174	Hermann Remmers GmbH		Lindern
9106	103175	BVG Cementmüller Baustoffvetrieb	GmbH & Co. KG	Tostedt
9107	103177	Karlhans Efinger Baustoff GmbH		Trossingen
9108	103178	Pribon BVBA		Kasterlee
9109	103179	Raiffeisen Waren GmbH		Jena
9110	103180	LuDz Mitte GmbH & Co. KG	Hermann Albert Bumke GmbH & Co.KG	Hannover
9111	103181	Dietmar Rauch	Alles für Haus & Garten	Leipzig
9112	103182	BMN Bouwmaterialen BV	Schiedam	Schiedam
9113	103183	Absolute Power Tools Ltd.		Bowerhill, Melksham
9114	103184	F.I. Services - Master PRO		Mitry Mory
9115	103185	BAUKING Westfalen GmbH	(Ndl. Bochum)	Bochum
9116	103186	Smart Solutions Suppliers		Lattakia
9117	103187	Mundfortz Baustoffe GmbH		Schwalmtal
9118	103188	TFix Polska Sp.z.o.o.	Piotr Malinowski	Sekocin Nowy
9119	103189	CC SuppliesLtd	Unit 4	Rochester, Kent
9120	103190	Raiffeisen Waren GmbH	(Ndl. Göttingen)	Göttingen
9121	103191	Brüning GmbH		Geldern
9122	103192	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leerdam
9123	103193	Quincaillerie Portalet SARL		Boe
9124	103194	Multiquip Supplies	Unit 1 Glenmore Bus Park	Chippenham
9125	103195	Raiffeisen Waren GmbH	(Ndl. Hanau)	Hanau
9126	103196	FLOORMATEX AG		Hünenberg (ZG)
9127	103197	DURADOR ARGENTINA		Bahía Blanca
9128	103198	Quincaillerie Portalet SARL		Montauban
9129	103199	Befestigungshandel und	Dienstleistungen Frank Friedhoff	Marl
9130	103200	SAS SCORS		Rosny Sous Bois Cedex
9131	103201	PYLO SARL		Mougins
9132	103202	BEIJING JHF CONSTRUCTION HARDWARE	CO.LTD	Chaoyang District, Beijing
9133	103203	CAC DISTRIBUTION	Clément Charnaux	Chelles
9134	103204	Technisch Bureau Ouborg		Hoogblokland
9135	103205	maschinen+technik Sauerland GmbH	&Co. KG	Schmallenberg
9136	103206	Gerritse IJzerwaren Vestiging Zeist		Zeist
9137	103207	SAS NOLLINGER		TRAPPES CEDEX
9138	103208	BAUKING Westfalen GmbH	(Ndl. Wuppertal)	Wuppertal
9139	103209	2K Polymer Systems Ltd.		Alfreton, Derbyshire
9140	103210	bauCompany24 GmbH		Göppingen
9141	103211	Sarl Maison Jacques Séguin	SARL	Randan
9142	103212	Apprich-Baustoffe GmbH & Co KG		Essingen
9143	103213	Flie-San GmbH Großhandel		Kevelaer
9144	103214	ZI-TECHASIA SOLUTIONS LTD.	11/F-12/F,  Ploenchit Center	Bangkok
9145	103215	LS Chemie GmbH		Wuppertal
9146	103216	ASW GmbH & Co.KG		Attendorn
9147	103217	Decco Ltd.		Newbury
9148	103218	Elektromaschinenbau	Matthias Wendland	Sulingen
9149	103219	Toban Engineering Ltd.	T/A M B Trading	West Yorkshire
9150	103220	Amazon EU Sarl	Niederlassung Deutschland	München
9151	103221	Amazon EU Sàrl / Amazon Media EU	Sàrl	Luxemburg
9152	103222	Amazon EU SARL	Niederlassung Tschechien	Dobroviz
9153	103223	Amazon Fulfillment Poland sp.z o.o.		Bielany Wroclawskie
9154	103224	bauzentrum Röhrig GmbH	(hagebaumarkt)	Treis-Karden
9155	103225	AGP Bauzentrum GmbH	Fachhandel Wernigerode	Wernigerode
9156	103226	MIOR, d.o.o.		Maribor
9157	103227	G7 Industrial Supplies Ltd	Unit 7 Courtyard 3	Mapplewell, Barnsley
9158	103230	SARL AIMONETTO		Saint-Etienne de Saint-Geoirs
9159	103231	BIEVRE LOCATION SARL		Brion
9160	103232	Isero IJzerwarengroep B.V.	DC Waddinxveen	Waddinxveen
9161	103233	Quincaillerie Portalet SAS		Pau
9162	103234	Van der Winkel Eindhoven	Isero IJzerwarengroep	Eindhoven
9163	103235	Quincaillerie Donibane SARL		St Jean de luz
9164	103236	Villaret Energies Fioul SARL		Le Mazet St Voy
9165	103238	ÜHolz	Krämer STEIN FORMEN	Schleusingen OT Erlau
9166	103239	Nordwest Handel AG	FachWerk	Dortmund
9167	103240	Westfälische Gesenkschmiede GmbH		Breckerfeld
9168	103241	SPARKY Polska Spz.o.o.		Zielona Góra
9169	103242	Großhandel Mohr GmbH		Suhl-Sehmar
9170	103243	Ruwomat BVBA		Aalter
9171	103244	Adamantem Products Ltd.	Unit 1	Lancing, West Sussex
9172	103245	Isero IJzerwarengroep B.V.	Scholte en de Vries	Beverwijk
9173	103246	IQ Builders Merchant Ltd.	Unit 51,The Granary Rural Busin. C.	East Sussex
9174	103247	Plymouth Tools & Spares		PLymouth
9175	103248	Heller Tools RUS, Ltd.		Moscow
9176	103249	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
9177	103250	E. Wertheimer GmbH	Baustoffe	Achern
9178	103251	Paul Swertz GmbH		Goch
9179	103252	Paul Swertz GmbH		Straelen
9180	103253	Paul Swertz GmbH		Alpen
9181	103255	C.C. Curtze GmbH & Co.KG		Korbach
9182	103256	Baustoff-Centrum Linnenbecker		Greifswald
9183	103258	Schwandorf GmbH & Co.KG		Schwandorf
9184	103259	Baustoff-Centrum Linnenbecker		Stralsund
9185	103260	Baustoff-Centrum Linnenbecker		Bielefeld
9186	103262	Baustoff-Centrum Linnenbecker		Rinteln
9187	103264	Baustoff-Centrum Linnenbecker		Minden
9188	103265	Jewson Limited	Saint Gobain House	Coventry
9189	103266	Baustoff-Centrum Linnenbecker		Lemgo
9190	103267	Baustoff-Centrum Linnenbecker		Bad Oeynhausen
9191	103268	Baustoff-Centrum Linnenbecker		Erwitte
9192	103269	Seeger Baustoffe GmbH		Zimmern o.R.
9193	103270	BAUKING Ostfalen GmbH		Helmstedt
9194	103271	Spit S.A. - SAS SOC PROSPECTION	INVENTIONS TECHNIQUE	Bourg-les-Valence
9195	103272	Minegishi Co., Ltd.	Mr. Yoshihiro Abe	103-0027 Tokyo-to
9196	103273	Jackdaw Tools Ltd.		Willenhall
9197	103274	Götz + Moriz GmbH	Baustoffe	Müllheim
9198	103275	Lecot - Biermans		Breda
9199	103278	Götz + Moriz GmbH	Baustoffe	Titisee-Neustadt
9200	103280	Götz + Moriz GmbH	Baustoffe	Lörrach
9201	103281	Fabory Nederland BV	Attn. Financial Shared Service	TILBURG
9202	103282	Apex UK		West Sussex
9203	103285	Rawlplug Ireland Limited		Drogheda / Co.Louth. Ireland
9204	103286	Nirolux NV Agrodieren		Hertsberge Oostkamp
9205	103287	Nagel Werkzeug-Maschinen GmbH		Freiburg
9206	103288	Götz + Moriz GmbH	Baustoffe	Bad Krozingen
9207	103289	Wales & West Building Products Ltd.		Wales
9208	103290	Wilh. Heunert GmbH & Co. KG	Inh. Anne Jansen, Marita Burmann	Soest
9209	103294	Shopbox 24	Elektro-Schölzel GmbH & Co. KG	Demnitz-Thumitz
9210	103295	Selmach Machinery Ltd.		Hereford
9211	103296	PROFIX AG		Lausen
9212	103297	Hans Schuy Baustoffgesellschaft	mbH	Köln
9213	103298	OVD Oberlausitzer Vertriebs- und	Dienstleistungs GmbH	Obergurig
9214	103302	Alfred Smit Fliesen- und	Baustoffhandel GmbH & Co. KG	Bad Zwischenahn
9215	103303	Uni Elektro Fachgroßhandel	GmbH & Co. KG	Eschborn
9216	103304	Prommersberger e.K.		Rattiszell
9217	103305	BEWENG s.a.		Luxembourg-Bonnevoie
9218	103306	Kistenpfennig S.ár.l Luxembourg	Francois Krier	Luxembourg
9219	103308	Steffen Schröder		Dinklage
9220	103309	Fast Mover Tools Ltd.		Dunstable
9221	103311	Revillard JEAN SAS		Cruseilles
9222	103312	Isero IJzerwarengroep B.V.		Dordrecht
9223	103313	SAS VISWOOD		Sury-le-Comtal
9224	103314	Kraftool I/E GmbH		Böblingen
9225	103315	Promabo GmbH		Oer-Erkenschwick
9226	103316	Josef Fahr GmbH & Co. KG		Moers
9227	103317	Euro Techno Com S.A.S		Eaubonne
9228	103318	L R M SAS		La Courneuve
9229	103319	D'CAT SAS		Bernes Sur Oise
9230	103321	Breger Freres et Fils S.A.R.L.		Luxembourg-Gasperich
9231	103323	BT Brammer B.V.		Enschede
9232	103324	Comat S.A.		LUXEMBOURG-HOWALD
9233	103325	COMPTOIR MATERIEL OUTILLAGE SARL	CMO	Montreuil
9234	103326	Lueb+Wolters GmbH & Co.KG		Borken
9235	103327	Otto Schulte		Wuppertal
9236	103328	BKW Hartmetall GmbH		Kaarst
9237	103329	IRIS FLOW.er SARL		Saint Chamond
9238	103330	SFI SASU		Ennezat
9239	103331	Quincaillerie Portalet	Zl de Beauregard  SARL	Brive la Gaillarde
9240	103332	Gebr. Fürstenberg GmbH	Baustoffhandel	Kyritz
9241	103334	team baucenter GmbH & Co KG		Eggebek
9242	103335	Kasnord GmbH		Sassenburg
9243	103336	Isero IJzerwarengroep B.V.	ISERO Breur Vlaardingen	Vlaardingen
9244	103337	BMN Wijcks Afbouwmaterialen	Volendam	Volendam
9245	103338	SOSACA HYERES		HYERES
9246	103340	Kalup doo		Hrvace
9247	103343	Markus Bornträger GmbH		Haan
9248	103344	Holz Braun GmbH & Co.KG		Reutlingen
9249	103345	Lusga Baumaschinen GmbH		Hamburg
9250	103347	CGS PRO	APC	Vichy
9251	103348	Verkatto sp.Z.o.o.		Opoczno
9252	103350	Formschluss	Umreifungstechnik & Zubehör	Dortmund
9253	103352	Caleffi Armaturen GmbH		Mühlheim/Main
9254	103354	b+z werkzeuge GmbH		Stuttgart
9255	103355	AH-Gartentechnik & Werkzeuge	Alexander Heeb	Mainz
9256	103356	D.E.S.BVBA		Roeselare
9257	103357	Quincaillerie Portalet		Feytiat
9258	103358	SAŠA KRANJEC		Zagreb
9259	103359	CREUSOT EQUIPEMENTS SAS		LE CREUSOT
9260	103361	TilePal Ltd.	Target House	Perth
9261	103362	Remmers Gruppe AG		Löningen
9262	103366	Freund Eisenwaren Öfen & Kamine		Waldkirchen
9263	103367	Isero IJzerwarengroep B.V.		Soest
9264	103369	Edwin Benischke	Werksvertretungen	Altdorf
9265	103370	Hotze GmbH & Co.KG	Baustoffe Leese	Laatzen-Gleidingen
9266	103371	LuDZ Mitte GmbH & Co.KG		Barsinghausen
9267	103372	Quincaillerie Portalet SAS		Merignac
9268	103373	BAUKING Westfalen GmbH	Ndl. Recklinghausen	Recklinghausen
9269	103374	ALLARD - Tanguy Allard		Fouenant
9270	103375	AMS - Frédéric Mayet		St Cyr sur Loire
9271	103376	ACL Lefebvre - Aude Campion	Bureaux 216/217	Bondus
9272	103377	Rajko Schade	Leiter-Sicherheitssysteme	Göda
9273	103378	Radius		Dublin
9274	103379	Scott Safety Supplies Ltd.		Sunderland
9275	103380	BAUKING Weser-Ems GmbH	(Ndl. Lorup)	Lorup
9276	103381	SIMURO Baubedarf AG		Urdorf
9277	103382	EUROPE DIAMOND		Cuijk
9278	103384	Panorama24 GmbH		Isernhagen
9279	103386	PermaRock Products Ltd.		Loughborough, Leicestershire
9280	103387	Produebel GmbH	Der Befestingsspeziallist	Leipzig-Engelsdorf
9281	103388	Der Baustoff-Mann Schneider KG		Gladbeck
9282	103389	Bohrerdepot	Namfon Wolschke	Oranienburg
9283	103390	Soc.IT Commerciale	Utensili S.P.A.	MILANO
9284	103391	bauwelt Delmes Heitmann	GmbH & Co. KG	Norderstedt
9285	103393	KLJENSEN	Rabattring Norwegen Großhandel	Tananger
9286	103394	KL JENSEN	Rabattring Norwegen Fachhandel	Tananger
9287	103395	Hermann Bach GmbH & Co. KG		Lippstadt
9288	103396	WMH e.K. Werkzeug-	und Maschinenhandel Freiburg	Freiburg
9289	103397	Bauzentrum Pelzer GmbH		Hürth
9290	103398	SAS BAGGIO		Carvin Cedex
9291	103400	Polvo Moerdijk CM		Zevenbergen
9292	103401	Paul Swertz GmbH		Kleve
9293	103404	Paul Swertz GmbH		Moers
9294	103406	MMR Fixing Specialists	Unit 3, Priestley Point	Worsley, Manchester
9295	103407	Atrumpa	Neumann, Florian	Kolkwitz
9296	103408	Sorbo Industribeslag AS		Trondheim
9297	103409	Carl Beutlhauser	Baumaschinen GmbH	Rednitzhembach
9298	103410	Industrieofen Bader & Scheffer GmbH		Denkendorf
9299	103411	gme GmbH & Co. KG		Offenburg
9300	103412	QUINCAILLERIE MOREL EURL		DAX
9301	103413	W. Renner GmbH		Landsberg am Lech
9302	103415	Holländer Bedachungszentrum GmbH		Speyer
9303	103416	Becker Baustoffe GmbH & Co.KG		Rietberg
9304	103417	UNIPRO LIMITED	Behind Vision Plaza	Nairobi
9305	103418	HS Handelsagentur Hans Schlüter		Hörnerkirchen
9306	103419	Hein GmbH & Co.KG		Mitwitz
9307	103420	BauXpert Knipper GmbH & Co. KG	Niederlassung Werlte	Werlte
9308	103451	Black & Decker Limited		County Durham
9309	103473	Wenzel Präzisionswerkzeuge e.U.		Wien
9310	103506	Höller GmbH	Innov. Warenbewirtschaftung	Wals
9311	103517	Spiral Reihs & Co. KG	Werkzeug- und Maschinenhandel	Wien
9312	103579	Dubick & Stehr	Baumaschinen GmbH	Hamburg
9313	103584	Thomann GmbH	Handwerker- u. Industriebedarf	Lindau
9314	103586	Berliner Schrauben GmbH & Co KG		Berlin
9315	103590	Eisen-Schneider	Inh. Christoph Hassenbach e. K.	Wiesbaden
9316	103602	Black & Decker (US) Inc.		Towson, MD 21286
9317	103607	Karl Grabenhorst	EISENWAREN	Dahlenburg
9318	103624	Albert Berner Deutschland GmbH		Künzelsau - Garnberg
9319	103661	WIB Werler	Industrie-Bedarf-Handels-GmbH	Werl
9320	103680	Lorenz Drucklufttechnik	Vertiebs GmbH	Grub Am Forst
9321	103702	Franz Kerstin Hausbau GmbH & Co.KG		Soest
9322	103727	Elektron Berlin GmbH		Berlin
9323	103747	Hans Daniels GmbH	Baugeraete	Dortmund
9324	103760	Eisen Krug	Inh. Erich Jeschke	Kassel
9325	103766	Richter Baustoffe GmbH	(Ndl. Falkenstraße Baustoffe)	Lübeck
9326	103773	Karl Binder		Schönaich
9327	103779	E.+E. Boss GmbH		Albstadt
9328	103790	W. Herr GmbH	Werkzeuge - Maschinen	Kelkheim-Fischbach/Ts.
9329	103810	Fehrs Baustoffe GmbH		Vaale
9330	103831	Heinrich Murjahn GmbH & Co KG	Fachgroßhandel für Haustechnik	Mölln
9331	103834	Stürmer Werkzeuge Maschinen KG		Hallstadt
9332	103858	Hocke - Baubedarf GmbH		Wiesbaden
9333	103860	Guntelmann	Werkzeug GmbH	Bielefeld
9334	103867	Ludden GmbH		Lingen 1
9335	103868	Diamant-Technik-Wesel		Wesel
9336	103897	Wilhelm Kleeberg GmbH & Co.KG	Elektromaschinenbau	Flensburg
9337	103926	BML Baumaschinen AG		Koenigsbach-Stein
9338	103936	Bielemeyer GmbH & Co.KG		Menden
9339	103945	Baustoffe FRAJO GmbH	Baubedarf	Garmisch-Partenkirchen
9340	103948	Heinz Hesse KG		Wuppertal
9341	103968	Hans Peter Ehler		Schopfloch
9342	103975	Hans Eisele GmbH		Glatten
9343	104001	Geilert & Kanstein oHG	Schrauben u. Verbindungselem.	Lohfelden
9344	104045	KremerGlismann GmbH & Co. KG		Barmstedt
9345	104049	Egon Haupthoff GmbH & Co.KG		Heiligenstedten
9346	104051	bauXpert Christiansen GmbH & Co KG		Niebüll
9347	104052	bauXpert Dittmer GmbH & Co. KG		Lütjenburg
9348	104055	Heinr.Köhn	Holz-und Baustoffe GmbH	Suederbrarup
9349	104056	Seemann Baustoff-Fachmarkt GmbH		Hürup
9350	104058	Jacob Sönnichsen AG		Klein Roennau
9351	104062	Bauzentrum Struve GmbH		Hamweddel
9352	104063	HZF Bauzentrum Fehmarn GmbH		Burg/Fehmarn
9353	104092	Weigel Werkzeuge OHG	Inh. Jens & Michael Weigel	Burbach
9354	104100	G.F.Lotter GmbH	Grosshandel Werkzeuge	Neutraubling
9355	104104	F. Brüggemann Nachf. GmbH.		Lemgo
9356	104105	Hefele GmbH & Co KG		Plattling
9357	104107	Anton Mayer	Befestigungstechnik	Illertissen
9358	104112	Uwe Kloska GmbH		Bremen
9359	104121	Eisen Mülfarth KG	Inh. F.P. Mülfarth	Bruehl
9360	104155	Antonius Venker GmbH & Co. KG	Werkzeug-Service	Salzbergen
9361	104163	Anton Kreitz &	W.H. Ostermann GmbH	Herne
9362	104164	Fritzen & Co. Baustoffe GmbH		Emden
9363	104165	Tegral GmbH & Co. KG		Überherrn-Altforweiler
9364	104181	H.Engert GmbH & Co. KG		Kreuztal
9365	104182	Melle Dachbaustoffe GmbH	Betriebsbedarf	Osterode/Harz
9366	104185	Hoba-Schrauben	Großhandelsgesellschaft mbh	Olfen
9367	104197	Gass GmbH		Speyer
9368	104203	Meier Handwerkerbedarf	GmbH & Co. KG	Ansbach
9369	104217	W. Klatt GmbH		Celle
9370	104221	Max Schön AG	Niederlassung Rostock	Rostock
9371	104229	Eduard Lutz Schrauben-Werkz. GmbH		Neubrandenburg
9372	104236	S & W Metall + Werkzeug GmbH		Alfeld
9373	104260	Smalcalda Handels-GmbH		Schmalkalden
9374	104261	Einkaufs- U.Liefergenossensch.	D.Metallverarb.Handwerks Egmbh	Apolda
9375	104264	Werkzeug - Maschinenhandel	Uwe Neidhard	Zella-Mehlis
9376	104286	AS Verbindungsteile	Inh. Helmut Antwerber	Koeln
9377	104296	Edwin Sperling	Eisenwaren + Werkzeuge	Zerbst
9378	104302	Hans Lüttke	Haus der Technik GmbH	Nordenham
9379	104306	GENIATEC GmbH	NL Rostock	Rostock-Kavelstorf
9380	104315	Fachmarkt Görlacher GmbH		Villingen
9381	104322	Baumarkt Wismar GmbH & Co.KG		Wismar Haffeld
9382	104348	Werkzeug Schultze GmbH	Gewerbegebiet Nord-West	Schoenebeck
9383	104356	Baumarkt Röbel GmbH & Co.KG		Röbel/Müritz
9384	104358	M. Meesenburg GmbH		Wolgast
9385	104362	Ackrutat GmbH & Co. KG		Neumünster
9386	104368	Handelshof Vorpommern GmbH	Partner für Technik	Grimmen
9387	104383	TTH Technikhandel GmbH	Erfurt	Erfurt
9388	104384	Bama Werkzeug + Maschinen-	Handel GmbH	Stralsund
9389	104386	Hilbertz GmbH		Wallenhorst
9390	104388	Lutz Lippold	Eisenwaren	Wilkau-Haßlau
9391	104404	Handelshof Riesa GmbH	Partner für Technik	Riesa
9392	104411	Fachmarkt Twyhues GmbH		Loitz
9393	104428	Werkzeugprofi GmbH		Lutherstadt Wittenberg
9394	104442	Paul Seidler	WZ und Maschinen	Bautzen
9395	104444	Steffen Klaus GmbH i.L.	Baumaschinen + Baugeräte	Herzberg
9396	104445	Handelshof Stendal GmbH	Partner für Technik	Stendal
9397	104450	Friedrich Niemann GmbH & Co.KG		Bentwisch/Rostock
9398	104456	Elgora GmbH		Oranienburg
9399	104461	Wocken Industriebedarf	GmbH & Co.KG AH-Nr. 10185	Bautzen
9400	104471	Raab Karcher Baustoffe GmbH		Schleusingen
9401	104474	Eylert GmbH & Co.KG	Werkzeuge	Chemnitz
9402	104479	Blumenbecker Industriebedarf GmbH	Heinz-Wilhelm Hoffmann	Beckum
9403	104484	Baumarkt Gramzow GmbH		Gramzow
9404	104490	THG Technische Handelsges. mbH		Brake
9405	104505	Diamasa Diamanttechnik GmbH & Co KG		Grimma
9406	104509	Messinger Schrauben GmbH		Frankfurt
9407	104510	Teuchert Bau- und Industriebedarf	GmbH	Großschirma
9408	104519	Krehahn & Krehahn Bauservice GbR		Naumburg
9409	104531	Rühr GmbH	Werkzeuge-Maschinen	Oberasbach
9410	104534	Kühl Qualitätswerkzeuge	Andreas Kühl	Eisenberg/Thür.
9411	104536	Tools Werkzeug-	Fachhandels GmbH	Großenhain
9412	104545	Binzer Baumarkt Bernd Schwartz KG		Ostseebad Binz
9413	104551	Nüßing Baubeschlag GmbH	Dortmund	Dortmund
9414	104554	Schnelle & Co	Erfurter Bau- u. Industrieb. GmbH	Erfurt
9415	104555	Leitermann GmbH & Co.	Fachmarkt KG	Göpfersdorf
9416	104562	Lotter Metall GmbH & Co KG	WZ und Sanitärhandel	Borna/OT Zedtlitz
9417	104565	DTH Kesselsdorf GmbH		Kesselsdorf
9418	104571	Richter	Bau- und Industriebedarf	Friedersdorf
9419	104587	EMB Elektromaschinenbau	Service GmbH	Chemnitz
9420	104600	Theodor Kiessling Fachgroßhandel KG	für Industrie und Handwerk	Auerbach
9421	104603	Ungering GmbH		Kleve
9422	104604	Bruno Zachenbacher	Werkzeugvermietung + Verkauf	Duesseldorf
9423	104605	Mothes Baumarkt Jens Mothes		Malchin
9424	104620	Firma Karl Briesemeister	Inh. Ralf Briesemeister	Eisenhuettenstadt
9425	104625	Werner Kirschke	Eisenwarenfachgeschaeft	Greiz/Thür.
9426	104627	Handelshof Bitterfeld GmbH	Partner für Technik	Bitterfeld-Wolfen
9427	104630	Bach GmbH	Fachmarkt für Industrie u. Profis	Marienberg
9428	104632	Handelshof Bautzen GmbH	Partner Für Technik	Bautzen
9429	104633	Handelshof Cottbus GmbH	Partner für Technik	Massen
9430	104636	Otto Pauling Nachf. e.K.	Inh. Christel Weber	Leipzig
9431	104647	BMH Löcknitz GmbH	Baustoffe	Löcknitz
9432	104651	Achimer Baustoffmarkt GmbH		Achim
9433	104655	Gierth & Herklotz OHG	Bau- und Industriebedarf	Bernau/Rehberge
9434	104661	Kadow	Handel und Services e.K.	Greifswald
9435	104662	Silvia Steinke	Der Fachgroßhandel	Perleberg
9436	104666	Carl Daum	Inh. Ingrid Pocher	Eisenberg/Thür.
9437	104668	Kemnitz Werkzeuge-Maschinen-	Befestigungstechnik  Kahlert GmbH	Korbußen
9438	104673	Eltrik	Elektrotechnik GmbH	Limbach - Oberfrohna
9439	104678	Raiffeisen-Warengenossenschaft	Hildburghausen EG	Hildburghausen
9440	104681	EGN Baustoffmarkt		Kröpelin
9441	104682	Leiwema Ochs KG	Eisenwaren/Werkzeuge	Markkleeberg
9442	104684	Prüßner Werkzeuge, Maschinen,	Industriebedarf, Handel GmbH	Aschersleben
9443	104688	Heribert Sohlmann GmbH		Hörstel-Riesenbeck
9444	104689	Gübe Werkzeuge GmbH	Wolfgang Kaudelka	Dessau
9445	104707	Baumarkt Gnoien GmbH & Co.KG		Gnoien
9446	104710	Martin Koeberlein GmbH	WZ und Industriebedarf	Neumark
9447	104715	Rülke OHG		Glauchau
9448	104724	ELG Holzhandwerk Dippoldiswalde eG		Dippoldiswalde/OT Obercarsdorf
9449	104725	THL Thomas Lipfert	Diamant u. Vermessungstechnik	Frankfurt / Oder
9450	104732	Werner Ditzinger GmbH	TTH-Technikhandel	Zella-Mehlis
9451	104737	T. Wurbs u. Co GmbH	Kompaktmarkt	Karstädt
9452	104743	Ruko GmbH	Präzisionswerkzeuge	Holzgerlingen
9453	104746	Otto Holländer GmbH	Inh. Dieter und Arne Petersen	Trittau
9454	104747	Peter Heinemann	Gartentechnik und Werkzeuge	Bitterfeld-Wolfen
9455	104751	Jaschinsky Werkzeuge	GmbH & Co.KG	Magdeburg
9456	104756	Paufler Werkzeugfachhandel	Ralf Paufler	Radebeul
9457	104771	Wermas Werkzeughandels GmbH	Werkzeuge Maschinen	Lohfelden
9458	104772	Werkzeug Hajek		Döbeln
9459	104774	Ernst Winterhoff GmbH & Co.KG		Remscheid
9460	104781	Werkzeughandel Holger Marlow e.K.	Inh. Andreas Holtz	Neubrandenburg
9461	104784	illgen Fachgroßhandel GmbH	Werkzeuge, Reinigungsmittel und	Neustrelitz
9462	104788	HNT GmbH	WZ und Service	Riesa
9463	104790	H. und H. Industriehandel	GmbH & Co.KG	Olpe
9464	104796	dth Diamant- und Befestigungst.	Günter Aust	Templin/Hammelspring
9465	104797	Lindenthaler Metallwaren		Gera
9466	104798	Manfred Hüllinghorst	Maschinenhandel GmbH & Co KG	Prenzlau
9467	104799	Gebr. Löffler GmbH Baustoffe		Greiz
9468	104800	Baumarkt u. Baustoffhandel	Buttstädt	Buttstädt
9469	104805	Baumaschinen Haase + Scherf GmbH		Sömmerda
9470	104810	Werkzeughandel Weber	Wismar GmbH	Wismar
9471	104816	LHG Leipziger Handelsgesellschaft	Verbindungstechn. u. Betriebsb. mbH	Leipzig
9472	104823	Manderscheid	Handelsgesellschaft mbH	Hoyerswerda
9473	104826	G. Wurth GmbH		Niederfischbach
9474	104828	May Fixation Sarl.	Befestigungstechnik	Pratz-Preizerdaul
9475	104829	DVS-Werkzeug-Service GmbH		Thalheim
9476	104839	Hoenicke Werkzeuge		Jueterbog
9477	104842	Jörg Deutsch		Lenzen
9478	104843	Drögemeier Industriebedarf	Inh. Dirk Drögemeier e.K.	Bückeburg
9479	104848	Beeck + Koch	Inh. Henrik Pflugmacher e.K.	Braunsbedra
9480	104850	Bauzentrum Schnepf GmbH & Co.KG		Teterow
9481	104851	EKF Klein GmbH & Co KG	Baumaschinen	Kuerten-Biesfeld
9482	104852	Werkzeug Roloff GmbH	Werkzeug	Stendal
9483	104862	Unifur Industriebedarf	Reinhard Fümel	Bergwitz
9484	104867	Stock B.I.G. GmbH		Siek
9485	104873	Westfalia Werkzeug Company		Halle/Saale
9486	104877	Henri Benthack GmbH & Co. KG		Grevesmühlen
9487	104878	Freitag Werkzeuge und	Industriebedarf GmbH	Neuenkirchen
9488	104879	Irrgang Werkzeuge GmbH		Eberswalde
9489	104882	K u. B GmbH	Fachgroß- u. Einzelh.f. Handwerk	Zerbst
9490	104887	Baumarkt Ueckermünde GmbH & Co. KG		Ueckermünde
9491	104898	STZ  Klingner GmbH		Poelzig
9492	104903	Rudolf Pöppel GmbH & Co.KG	Maschinen + Werkzeuge	Memmingen
9493	104904	HH Baugeräte GmbH	Baugerätehandel	Plauen
9494	104910	Franz Sieland GmbH	Industriebedarf	Arnsberg-Neheim
9495	104917	Baustoffmarkt Bützow GmbH & Co. KG		Bützow
9496	104920	Baumarkt Teterow GmbH & Co KG		Teterow
9497	104921	AGON Werkzeuge und Wälzlager GmbH		Bochum
9498	104924	Schmitt Elektrogroßhandel GmbH		Erfurt
9499	104925	Lüneburger Eisenhandlung	W.L. Schröder GmbH & Co KG	Lüneburg
9500	104926	Hartmetall- und	Diamantwerkzeuge	Fambach
9501	104929	Hantel Montagetechnik	Grosshandelsgesellschaft	Renzow
9502	104938	Klaus-Dieter Gratz	Elektro Maschinen Bau	Struth-Helmershof
9503	104939	Anke & Söhne	Industrievertretung	Plauen
9504	104940	Nienhaus, Thielkes & Co. GmbH		Coswig
9505	104954	Kirsch	Bau- und Industriebedarf GmbH	Belgershain
9506	104957	Andreas Schreiner	Werkzeugfachhandel	Jessnitz
9507	104962	E M A - Kalberlah GmbH	Fachhandel	Bernburg
9508	104967	Werktec GmbH		Dingelstädt
9509	104968	B V A  Ingolf Müller GmbH		Windischleuba
9510	104969	Ernst Meyer GmbH	Steinindustriebedarf	Nürnberg
9511	104973	Adolf Schween GmbH	NL Sangerhausen	Sangerhausen
9512	104975	Blumenbecker	Industriebedarf GmbH	Iserlohn
9513	104986	MF Manfred Faske GmbH & Co.KG		Vechta - Calveslage
9514	104988	Odenwaelder Baumaschinen	GmbH & Co.KG	Merseburg
9515	104996	Bodo Küster	Werkzeuge und Maschinen	Mellingen
9516	104999	Egon Jesse		Simonshaven
9517	105000	Danfoss Power Solutions ApS		Nordborg
9518	105010	Oliver Fischer	Werkzeugdienst	Waldesruh
9519	105011	Gase Center Calau		Calau
9520	105013	Werner Frick GmbH		Korntal-Münchingen
9521	105015	Raab Karcher Baustoffe GmbH		Gotha
9522	105017	WMB Walther GmbH	Werkzeuge Maschinen Baubeschl.	Arnstadt
9523	105018	Hans Humpenöder GmbH	Baustofffachhandel	Schwabach
9524	105024	Bohr- u. Sägetechnik GmbH	WZ und Service	Radeberg
9525	105025	Jäckel Baubedarf GmbH		Bühl/Baden
9526	105028	Nagel Baumaschinen	Magdeburg GmbH	Barleben
9527	105037	Gulden Elektrowerkzeuge	Diamant. u. Befestigungstechnik	Zemmer Schleidweiler
9528	105044	M.Wolpert	Schlüsseldienst	Köln
9529	105046	Jürgen Hauschild GmbH	Fachgroßhandel	Wünschensuhl
9530	105047	BauPunkt Hain   Masch.Verm.-	und Baubedarf Handels GmbH	Lutherstadt Eisleben
9531	105051	Van Ree B.V.		Alkmaar
9532	105053	dth Wandura Ltd.	Diamant- u. Befestigungst.	Cunewalde
9533	105058	Timmerman's IJzerhandel b.v.		Alkmaar
9534	105065	Max Pohlhaus	Inh. Jörg Priebe e. K.	Borkwalde
9535	105066	Selectequip Ltd.	Unit 7, Britannia Enterprise Park	Lichfield, Staffs.
9536	105070	BAUKING Berlin-Brandenburg GmbH	Niederlassung Spandau	Berlin
9537	105075	MJM Werkzeug-Vertriebs GmbH & Co.KG		Rendsburg
9538	105086	Nienhaus & Thielkes GmbH		Rhede
9539	105090	Hemmersbach	Industriebedarf GmbH	Berlin
9540	105098	Keller & Kalmbach GmbH		Regensburg
9541	105104	Firma Plat		St. Annaparochie
9542	105116	Wocken Industriebedarf	GmbH & Co.KG AH-Nr. 10184	Magdeburg
9543	105118	Machine Mart Ltd.	Head Office	Nottingham
9544	105126	Unimet Zentrallager Ost	GmbH & Co KG	Neuruppin
9545	105130	OREN s.r.o.		Udlice
9546	105131	Raab Karcher Baustoffe GmbH		Erfurt
9547	105140	Industriebedarf Mütschard e.K.	Inh. Andy Hunhold	Rathenow
9548	105141	Patzer Technische Fachhandels-	gesellschaft GmbH	Saalfeld
9549	105143	Gebr. Wurster GbR		Woltersdorf
9550	105153	Augustin GmbH		Gunzenhausen
9551	105159	D. Dummert	Werkzeughandel	Berlin
9552	105163	IHR Werkzeughandel	Holger Antonijevic	Schwedt/Oder
9553	105169	Georg GmbH	Ihr Partner f. Sicherheit + Technik	Breitscheid
9554	105170	Siegfried Jakob		Dessau
9555	105190	Sächsische Handelsagentur	Holger Gutseel	Leipzig
9556	105191	SIG First Fix M&E (Kem Edwards)	Unit 4	Ruislip
9557	105193	SSV-Kroschke GmbH		Wutha-Farnroda
9558	105208	Hillmann & Ploog Waren GmbH		Waren (Müritz)
9559	105218	Zuid IJzerhandel V.O.F		Amsterdam
9560	105219	Raiffeisen Warengen. E. G.		Eisfeld
9561	105220	Kopprasch Industrie- u. Baubedarf		Dohna/OT Meusegast
9562	105225	Quauck GmbH	Baumaschinen u. Baubedarf	Gerichshain
9563	105226	Joseph Peters	Beschläge-Garderoben	Konstanz
9564	105229	HIWESO GmbH	Werkzeuge u. Maschinenh.	Gotha
9565	105242	P. Hendriks Uden B.V.		Uden
9566	105244	Jecor Professioneel B.V		Putten
9567	105248	Auke Rauwerda B.V.		Leeuwarden
9568	105252	EWL Elektrowerkzeuge	Bau- u. Gartentechnik	Chemnitz
9569	105253	Reinhold Werkzeuge GmbH		Stollberg
9570	105254	M.H.W. Horbach	Werkzeuge	Alsdorf
9571	105263	Bauzentrum Schnepf GmbH & Co.KG		Malchin
9572	105278	Herwig Bohrtechnik	Schmalkalden GmbH	Schmalkalden
9573	105284	Udo Wendelmuth	Handelsvertretung	Schwansee
9574	105287	O.J. Keller		Berlin
9575	105291	Hoza Holding B.V		Wenum Wiesel
9576	105296	Deinzer U. Weyland U. Co GmbH		Altlandsberg
9577	105302	Bernhard Menge	Werkzeug-Werkzeug-Maschinen	Recklinghausen
9578	105304	Adolf Christel		Schwarzenfeld
9579	105306	Gnoth Tischlereibedarf		Salzwedel
9580	105308	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Neuruppin
9581	105311	Kelterborn Schweißtechnik GbR		Saalfeld
9582	105314	Römhild Fachhandel		Naumburg/Saale
9583	105321	Huke Verbindungstechnik GmbH	Niederlassung/Lager, Kerspleben	Erfurt
9584	105324	Neustrelitzer Industriebedarf	Beilke GmbH	Neuruppin
9585	105329	Heiko Knop	Industriebedarf	Elze
9586	105335	M Donnelly & Co Ltd	Dublin Industrial Estate	Glasnevin Dublin
9587	105343	Döhle	Eisenwaren/Werkzeuge	Sömmerda
9588	105352	Barm Werkzeughandel		Ganderkesee
9589	105356	Prenzlauer Baubedarf GmbH		Prenzlau
9590	105361	PRIVATVERKAUF		Dinklage
9591	105364	Schär Werkzeug-Maschinenhandel	und Industriebedarf GmbH	Crimmitschau
9592	105365	EUROBAUSTOFF Handelsgesellschaft	mbH & Co. KG	Karlsruhe
9593	105374	Eurobaustoff Regionaler Einkauf	Rheinland	Euskirchen
9594	105375	Wildenhayn  - Wachholz		Blankenfelde
9595	105383	Schiffsversorgung (SVR)	Rostock GmbH	Rostock
9596	105385	Johannes Schmidt	Schweißtechnik	Lauchhammer Ost
9597	105389	Dieter Haufe	Elektrowerkzeuge	Großröhrsdorf
9598	105391	DSS Diamant-Säge-Service GmbH		Duisburg
9599	105392	Deutschmann & Söhne GbR		Bernau
9600	105393	Grischke   Baustellenbedarf GmbH		Goslar
9601	105395	eltric GmbH		Bayreuth
9602	105400	Elektromaschinen-Service Klähr	Inhaber Matthias Bär	Frankfurt/Oder - Markendorf
9603	105402	Mehlhorn Baumaschinen		Erfurt
9604	105407	Wilkens Baustoffe GmbH		Groß Wokern
9605	105417	V.O.F. R & B TOOLS		Zutphen
9606	105421	Rehmet u. Hessel GmbH	Fachhandels- u. Reparatur-Service	Wurzen Ot Dehnitz
9607	105425	Gassmann Industriebedarf GmbH		Heiligenstadt
9608	105430	WIB Weimarer Industriebedarf GmbH		Weimar
9609	105441	T.E.A.M. GmbH	Industriebedarf	Kall
9610	105442	Michael Ullrich	Elektromaschinenbau & Werkzeuge	Floh-Seligenthal OT Hohleborn
9611	105443	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Schwerin
9612	105445	Lex Beschläge- und Baubedarf	Handels GmbH	Arnstorf
9613	105455	B M V	Baumaschinenvertrieb	Roedenstal
9614	105471	Friedrich Delker GmbH	Werkzeuge - Maschinen	Halle/Saale
9615	105473	Roland Gessner	Inh. Christina Gessner e.K.	Eisenhüttenstadt
9616	105476	Raiffeisenbank eG	Büchen Crivitz Hagenow Plate	Hagenow
9617	105477	Klaus Naguschewski	Betriebsausrüster	Stralsund
9618	105487	Klokow Industrietechnik GmbH		Parchim
9619	105491	Provak Amsterdam B.V.		Amsterdam
9620	105493	Paul Gröne GmbH	z.Hd. Herrn Marcel Dreyer	Dinklage
9621	105497	Van Smeden Harlingen B.V.		Harlingen
9622	105498	De Beer Professioneel B.V.		Zutphen
9623	105499	BEROLINA Werkzeug-Fachhandel GmbH		Berlin
9624	105508	J. Wilson (Power Tools) Ltd.		Glasgow, Strathclyde
9625	105509	Fixings Direct	Unit C, Castle Court	Coventry, West Midlands
9626	105513	Scheller und Partner	Handels und Service Center	Hildburghausen
9627	105515	Te Koppele B.V.		Eibergen
9628	105516	Suckfüll Handels GmbH		München
9629	105533	Driltec, LLC.		Byram, MS 39272
9630	105534	HV Baugeräte GmbH		Zwickau
9631	105543	Jürgen Drescher	Schweißt., Arbeitssch., Profiwerkz.	Neustrelitz
9632	105551	HEMMINK B.V.		Zwolle
9633	105552	König & Landl GmbH		WIEN
9634	105556	Martin GmbH & Co. KG	Bauzentrum	Reinsdorf
9635	105558	Breur	IJzerhandel Rivium B.V.	Capelle a/d IJSSEL
9636	105559	Drebo	Werkzeugfabrik GmbH	Altshausen
9637	105568	Bücheler & Martin GmbH	Fachhandel für Baustoffe	Singen
9638	105574	Wessex Fixings Ltd.		Andover, Hampshire
9639	105575	Readyfix Ltd.		Preston
9640	105577	Mach Tools Incorporated		Quezon City  1115 Metro Manila
9641	105586	Eisen Fendt GmbH		Marktoberdorf
9642	105599	Samitech AG	Befestigungstechnik	ST. MARGRETHEN/ SG
9643	105600	SAS CHARLES BONNET ET FILS	MANUFACTURE A	Monswiller
9644	105619	Willers	Nachf. Fischer + Koenig oHG	Oldenburg
9645	105626	CBS	Colditzer-Bau-Service GmbH	Colditz
9646	105641	Scheja Werkzeuge		Heygendorf
9647	105642	Detlef Paulsen	Betriebsausrüster GmbH	Pampow
9648	105649	Rokossa GmbH		Melle
9649	105650	Fachmarkt R. Brand GmbH		Meppen-Nödike
9650	105651	Ziesmann	Baugeräte GmbH	Torgau
9651	105655	Midland Fixings Ltd.	The Parrs	Nottinghamshire
9652	105658	Werkzeug-Schlitt	Groß-u. Einzelhandel	Maxdorf
9653	105665	SSK Schrauben Schmid GmbH		Kirchheim/Teck
9654	105672	H + W Diamantwerkzeuge	Inh. Roland Bolze	Jena-Löbstedt
9655	105675	Werkzeug Adler	WZ und Industriebedarf	Werdau
9656	105676	W. Burger en Zonen		Amsterdam
9657	105684	Manfred Häussler GmbH		Winnenden
9658	105695	H + K Baustoffe GmbH		Kamenz
9659	105710	BASTIAN GmbH	Werkzeuge und Arbeitsschutz	Mühlhausen
9660	105719	Wittig GmbH		Jessen
9661	105722	Bus' Handelmij B.V.		Zwolle
9662	105723	Holzhauser GmbH	Baumaschinen	Kirn
9663	105740	SSG Schrauben Scholz GmbH		Berlin
9664	105750	Gebhardt Bauzentrum GmbH		Goldbach
9665	105757	Werkzeug-Weber GmbH & Co. KG		Aschaffenburg
9666	105760	HolzLand	H. Wulf GmbH	Ahrensburg
9667	105763	Diethold Schweißtechnik		Sömmerda
9668	105766	Eisen Heinrich GmbH		Egling
9669	105772	Louis Scheuch GmbH	Stammhaus Kassel	Kassel
9670	105775	WELU GmbH		Salzweg
9671	105777	ELG des Bau- und Baunebenhandw. eG		Meissen
9672	105785	Action Fixings		Colchester Essex
9673	105786	Worcester Tools & Fixings		Worcester, Worcestershire
9674	105790	Pietzschmann Baumaschinen GmbH		Großweitzschen
9675	105794	WMMG GmbH	Werkzeug,Maschinen,Messgeräte	Berlin
9676	105797	IJzerhandel A.Ottenhof B.V.	Afd. Bouw en Industrie	Oldenzaal
9677	105809	Stubbe & Beck GmbH		Dinslaken
9678	105811	Deterding GmbH		Pennigsehl
9679	105817	Omega Spares Ltd.	Unit 7, Cabot Business Village	Dorset
9680	105824	Eisen-Fackler		München
9681	105827	Christian Wimschneider GmbH	Maschinen-und Werkzeuge Großhandel	Untermitterdorf
9682	105835	Anchor Fixings Ltd.	Rathenraw Industrial Estate Unit 30	Antrim
9683	105836	Kernow Fixings		St. Austell, Cornwall
9684	105841	Martin Wimmer	Baumaschinen - Landtechnik	Oberflossing
9685	105845	Meesenburg Großhandel KG	NL Greifswald	Greifswald
9686	105847	Werkzeug & Maschinen für Handwerk	& Industrie - Inh. R. Wedel	Pommersfelden
9687	105849	Fixings & Powertool Center Ltd.		Redhill, Surrey
9688	105855	Mietpark Großklos	Baugeräte und Minibagger	Kusel
9689	105856	BVD Bautechnik-Handels-	gesellschaft mbh	Ueckermünde
9690	105860	Vernhold GmbH		Osnabrück
9691	105873	König Baustoffe GmbH & Co.KG		Regen
9692	105876	Rumpf + Schuppe GmbH	Baumaschinen - Baugeräte	Zittau
9693	105885	KAYSER GmbH	Systemlieferant f.Ind.,Bau,Dienstl.	Koblenz
9694	105886	Kaufhaus Janßen		Nordenham
9695	105890	Peter M. Börsch KG		Remscheid
9696	105892	Neele Bouw & Techniek B.V.		Hardenberg
9697	105893	BMT - Baumaschinen-	gesellschaft Thallwitz mbh	Thallwitz
9698	105907	Dieter Kurth Bedachungs-Fach-	handel GmbH	Burscheid-Dürscheid
9699	105908	Gbr. Swinkels Bouwmaterialen B.V		Lieshout
9700	105911	Eder GmbH	Profi Fachmarkt	Tuntenhausen
9701	105915	Heinrich Rießelmann	Holz und Baustoffe GmbH	Damme
9702	105922	Weha GmbH		Königsbrunn
9703	105934	Garrison Dales Ltd. (G110)	Unit 1, Wassage Court	Droitwich, Worcs
9704	105936	Partnerverbund	Pyramide GmbH	Karlsruhe
9705	105937	Raab Karcher Baustoffe GmbH		Stralsund
9706	105942	KGV - Geräteverkauf	Helmut Kanzinger	Bötzingen
9707	105949	SIG Fixings Wolverhampton		Oldbury
9708	105951	B & L  Schweißtechnik GbR		Büttstedt
9709	105952	Werkzeug Prüver GmbH		Bautzen
9710	105954	Metalleinkauf e.G.	Nürnberg	Nürnberg
9711	105960	Fritz Brinkmann	Bedachungsgroßhandel GmbH	Herford-Diebrock
9712	105961	BAUKING Weser-Ems GmbH	Niederlassung Bramsche	Bramsche
9713	105964	Krapp Objekte GmbH & Co. KG		Gelsenkirchen
9714	105973	Ace Fixings Ltd.	Woodside Industrial Estate	Ballymena, Co. Antrim
9715	105977	Blackpool Power Tool Company	GEBR002	Huddersfield HD1 4WQ
9716	105980	Himmler Bauzentrum GmbH & Co. KG		Höver
9717	105986	Elektrowerkzeuge Winter	Inh. Steffi Winter	Schwielowsee / OT Geltow
9718	105989	Jürgen Schmieder	Baumaschinen, Baugeräte	Troisdorf-Spich
9719	105992	OLYMPIA EMPRESAS UNIDAS C.A.	RIF: J-00102871-4	Caracas  Venezuela
9720	106000	Brun & Böhm Baustoffe GmbH		Potsdam
9721	106007	J. W. Zander GmbH & Co		Dortmund
9722	106016	Interfix Supplies Ltd.	Shaw Lane Industrial Estate	Doncaster
9723	106019	FLB-Direct Handelsunternehmen UG		Herbolzheim
9724	106026	Dieter Truckenbrodt	Maschinen u. Werkzeuge	Grümpen
9725	106036	NL Raab Karcher Meißen	STARK Deutschland GmbH	Meißen
9726	106038	Heiko Grohnert	Baubedarf	Emleben
9727	106039	Schrauben-Fleischer	Inh. Frank Fleischer	Freital
9728	106053	Gerhard Küster GmbH	Sanitär & Heizungs-Fachhandel	Hannover
9729	106062	Standard Power Tools		Lewisham, London
9730	106069	WSM Werkzeuge GmbH		Mühlacker
9731	106072	Steinrück GmbH & Co. KG		Bergisch Gladbach
9732	106074	Feilen-Pieper GmbH & Co. KG		Wagenfeld
9733	106078	VHI Vollmer	Handel für Industrieausrüstung	Groitzsch
9734	106085	Leitermann GmbH & Co. Fachmarkt KG		Schmölln
9735	106086	Marree Technische Groothandel B.V.		Harderwijk
9736	106091	Klauser GmbH		WIESELBURG
9737	106097	Fresemann  GmbH	Schraubengroßhandlung	Dörpen
9738	106099	Rubix GmbH		Celle
9739	106103	Infix Ltd.		Bristol
9740	106104	BEV Baugeräte GmbH		Mönchengladbach
9741	106109	Boiten Techniek BV		Stadskanaal
9742	106111	Werner Schweißtechnik GmbH & Co. KG		Görlitz
9743	106119	W. Bohnsack	Handelsvertretung für Werkzeuge	Greifswald
9744	106121	Schaebbicke Präzisions-Werkzeuge		Berlin
9745	106124	Herbert Müllner	Werkzeuggroßhandel GmbH	EUGENDORF
9746	106128	KSA	Kubben + Steinemer GmbH + Co.KG	Aachen
9747	106135	BAUKING Weser-Ems GmbH	Niederlassung Bremen	Bremen
9748	106142	Buchberger	Baugeräte Handel GmbH	Ingolstadt
9749	106145	Wilhelm Drescher	Eisenwaren GmbH	Lahnau
9750	106147	Tetenborg Befestigungstechnik		Saerbeck
9751	106152	Holtzmann & Sohn GmbH		Ronnenberg-Empelde
9752	106153	Perfekter Halt GmbH & Co. KG		Remscheid
9753	106156	Eulenstein Baustoffe	Inh. Peter Metzner	Pössneck
9754	106159	Wiegand Fuchs	Industrie- u. Handwerkerbedarf	Neuensalz
9755	106166	ARTEC	Maler- und Baubedarf	Erfurt
9756	106168	Hotze GmbH & Co KG Baustoffe Leese	Niederlassung Rahden	Rahden
9757	106177	Industrie-Bedarf Meyer KG		Gütersloh
9758	106187	August Kuhfuß GmbH	Nachf. Ohlendorf GmbH	Dessau-Roßlau
9759	106194	Industrial Supplies (NI) Ltd	Unit 27-29 Mallusk Enterprise Park	Newtonabbey, Co.Antrim
9760	106202	WEWO Schrauben-	Befestigungsteile GmbH	Straelen
9761	106207	Schmidt Kfz- u.Baumaschinenteile	Vertriebs GmbH	Aachen
9762	106208	Wilhelm Hoffschulte	Nachf. Kassens GmbH & Co KG	Meppen
9763	106213	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
9764	106214	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
9765	106228	Gebr. Fürstenberg GmbH	Baustoffhandel	Rathenow
9766	106233	Hobex Fachhandel GmbH		Berlin
9767	106236	Wolf Baumaschinen und Baugeräte	Handels-GmbH	Bad Mergentheim
9768	106238	IuG Industrie- und Gewerbe-	fachgroßhandel GmbH	Chemnitz
9769	106243	KTG Baumaschinen GmbH		Berlin
9770	106245	Groenhart Group B.V.	Centraal Magazijn	Purmerend
9771	106247	JGV GmbH		Grafenhausen
9772	106257	L P K Lothar Philipps	Präzi.-Werkzeuge + Maschinen	Korschenbroich
9773	106265	Adolf Würth GmbH & Co. KG		Künzelsau
9774	106267	BBN Bouwmaterialen BV		te Alkmaar
9775	106268	Wolfgang Schulz EWI	Groß- und Einzelhandel	Lutherstadt Wittenberg /OT Str
9776	106269	Panno GmbH	Fachgroßhandel für Haustechnik	Bornheim/Hersel
9777	106270	BAUKING Weser-Ems GmbH	Niederlassung Nienburg	Nienburg
9778	106274	Manfred Binz	Diamant- u. Bautechnik e.K.	Lahnau
9779	106277	Baer GmbH	Präzisionswerkzeuge	Weinheim - West
9780	106278	Friedrich Kessel GmbH		Mainz
9781	106280	Baustoffmarkt Dargun GmbH & Co.KG		Dargun
9782	106281	Kaiser & Stuckert	Industrie- und Baubedarf GmbH	Kiel
9783	106284	HBV  Hermsdorfer Beschlag	Vertrieb GmbH	Hermsdorf/Thür.
9784	106285	Wöhlk GmbH	Holz und Baustoffe	Grosspostwitz OT Ebendörfel
9785	106287	i&M Mobau Baustoffzentren	Bauer GmbH	Saalfeld
9786	106289	Reerink IJzerwaren		Vaassen
9787	106295	Maurus BauPunkt	Baubedarf GmbH	Biberach / Riß
9788	106296	Nüßing GmbH	Niederlassung Grimma	Grimma
9789	106302	Hänig Bauzentrum GmbH & Co. KG		Limbach - Oberfrohna
9790	106307	UAB "TERONIS"		Vilnius
9791	106316	Dachdeckermaschinen und Baugeräte	Inh. Lutz Mäder	Olbersleben
9792	106318	Gedema GmbH		Hagen
9793	106319	Mac Panther GmbH	Airport-Stadt Mitte	Bremen
9794	106326	Nozar GmbH & co KG		Ascheberg
9795	106334	beko GmbH		Monheim
9796	106336	W. Tebbenjohanns Nachf. GmbH		Oldenburg
9797	106340	hagebau Handelsges. für Baust.	mbH & Co. KG	Soltau
9798	106346	FESTA  Handels- und Dienst-	leistungsgesellschaft mbH	Leipzig
9799	106347	Fröhle Dachbaustoffe GmbH		Lohne
9800	106352	Profi-Baubedarf Czentarra GmbH		Cottbus
9801	106368	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Ribnitz-Damgarten
9802	106374	Adolf Neuendorf GmbH		Berlin
9803	106378	Schone Baustoffhandel GmbH		Aschersleben
9804	106381	V.J. Technology Ltd.	Technology House	Ashford, Kent
9805	106386	Service Dobritsch Comerce GmbH		DOBRITSCH
9806	106387	LWS Loske Werkzeug Service		Wolfenbüttel
9807	106393	DTS Diamanttechnik	Swen Schiebel	München
9808	106396	Multi-Fix (Pty) Ltd	M.B.Distributors	Cape Town
9809	106398	Hornung GmbH & Co.KG	Fachhandel für Natur-Baustoffe	Stutensee-Blankenloch
9810	106399	AGO Durckluft	Miete-Verkauf-Service GmbH	Velten
9811	106406	RIAG	Baubedarf GmbH & Co.KG	Rudolstadt
9812	106416	Roland Lehmann	Baubedarf	Grünewald
9813	106417	ALPEN-MAYKESTAG GMBH		PUCH
9814	106418	Optimal Versand	Istvan Horogh	Worbis
9815	106419	Baustoffmarkt Wolgast GmbH & Co.KG		Wolgast
9816	106422	Macey Industrial Fixings	Unit 9, The Martlets	Hailsham, East Sussex
9817	106424	Mod-Fix Ltd.		Cardiff
9818	106432	BAUKING Weser-Ems GmbH	Niederlassung Bad Essen	Bad Essen
9819	106433	R.v.Beekveld	Technische Groothandel b.v.	Heeswijk-Dinther
9820	106439	Hantschel Werkzeuge		Lüdenscheid
9821	106448	Makita (UK) Ltd.		Milton Keynes Bucks
9822	106449	eberle-hald Handel und	Dienstleistungen Metzingen GmbH	Metzingen
9823	106459	Handelshof Cottbus GmbH	Partner für Technik	Cottbus
9824	106461	BAUKING Weser-Ems GmbH	Niederlassung Löningen	Löningen
9825	106463	Voskamp Bouw en Industrie B.V.		Amsterdam
9826	106464	Ferney Group BV		Heerhugowaard
9827	106510	Vanguard Fixings Ltd.		West Midlands
9828	106511	IJzerhandel Knoef B.V.		Hengelo
9829	106512	Donath Baumaschinen & Geräte GmbH	Baumaschinenhandel	Mülsen
9830	106513	Meyer-BHS-Eisenach e.K.		Eisenach
9831	106516	Buijtendijk B.V.		Den Helder
9832	106519	Artmann GmbH	Werkzeuge und Maschinen	Ahaus
9833	106520	Hartjenstein Werkzeuge GmbH	Baubedarf Industriebedarf	Wilhelmshaven
9834	106526	Wilhelm Linnenbecker GmbH & Co. KG		Versmold
9835	106528	Joseph Gleave & Son Ltd.	International Tool Distributors	Stretford, Manchester
9836	106537	EGN Baustoffmarkt Neustrelitz	GmbH & Co.KG	Neustrelitz
9837	106539	IHR Rabenstein Handels GmbH		Bersenbrück
9838	106540	HAUPA GmbH		Remscheid
9839	106541	MUNGO	Befestigungstechnik AG	OLTEN
9840	106545	WMZ Werkzeug- u. Maschinenhandel	Zwönitz Troll & Konopka GbR	Zwönitz
9841	106547	Werkzeughandel Clauß		Plauen
9842	106552	Voskamp Bouw en Industrie B.V.		ALMELO
9843	106556	BLT GmbH Herzberg	Profi Baubedarf	Herzberg
9844	106557	Profi Power Plus Diamant- u.	Bohrtechnik Weßelburg	Beesten
9845	106560	Post B.V.	Technische groothandel	Kampen
9846	106561	L + L Lisowski GmbH & Co KG		Herford
9847	106567	Meesenburg GmbH & Co. KG	NL Oldenburg	Flensburg
9848	106572	HNT Riesa GmbH	NL Leipzig Handel und Service	Leipzig
9849	106578	Uwe Kloska GmbH	Technischer Ausrüster	Bremerhaven
9850	106579	Schrauben-Listner	Inh. Stephan Listner	Brand-Erbisdorf
9851	106581	Müller Bohrtechnik GmbH		Lutherstadt Wittenberg
9852	106592	MP Industrie- u. Handwerksbedarf	GBR	Oschersleben
9853	106596	Rudolf Sievers GmbH	Partner für Technik	Winsen
9854	106597	Josef Hansen GmbH & Co.KG		Solingen
9855	106600	Josef Kurz		St. Wolfgang
9856	106604	Industrieberatung + Verkauf	H.-G. Krähwinkel	Rinteln
9857	106605	Hartmut Jänsch	Druckluftanlagen/Werkzeuge	Pößneck
9858	106606	Montec GmbH		Albstadt/Laufen
9859	106612	Werner Schönweiß GmbH	Werkzeuge-Maschinen	Schwarzenbruck-Pfeifferhütte
9860	106624	Batifixing Sàrl		Fischbach
9861	106626	MZW Elsterwerda UG	Werkzeuge-Industriebedarf	Elsterwerda
9862	106628	M A W Werkzeuge GmbH		Wipperfürth
9863	106639	Jürgen Neydorff	Werkzeuge-Maschinen-Industriebed.	Weiterstadt
9864	106640	Mearaj Gulf General Trading Co W.LL	Branch #6: Ez Al Deira Carpentry	Shuwaikh, Code 70651
9865	106642	Northern Power Tools and Acces.Ltd.	Unit 1A	Kendal
9866	106648	Longdia GmbH		Celle
9867	106654	Otto Röhrs GmbH	Baustoffe	Scheeßel
9868	106655	WE-MA-TEC	Technischer Handel GmbH	Limburg/Lahn
9869	106658	V. Kluge GmbH	Motorgeräte - Baumaschinen -	Frankenberg
9870	106661	Interhire Power Tool Service Ltd.		Ilkeston, Derbyshire
9871	106662	Jakob NOE Nachfolger - Stuttgarter	Baugeräte Industrie GmbH & CO.KG	Möglingen
9872	106663	Pröbster GmbH	Werkzeuge-Elektromotoren-	Hilpoltstein
9873	106664	A. Vergeer B.V.		Benschop
9874	106676	Strautmann Werkzeuge GmbH		Bad Laer
9875	106680	Udo Dömer Technik		Nordwalde
9876	106681	Handelshof Bautzen GmbH	Filiale Bernbruch/Kamenz	Kamenz OT Bernbruch
9877	106686	Rex Crystal Fixings Ltd.		Wakefield, West Yorkshire
9878	106687	Knoke Kaubanduse OÜ	Knoke Trading LLC	TALLINN
9879	106688	Ortjohann & Kraft	Wkz.- u. Masch.hd. GmbH	Rietberg-Mastholte
9880	106695	Josef Gebhardt	Elektromotoren GmbH	Nabburg
9881	106696	COBALT Sh.p.k		TIRANA
9882	106702	Alexander Holstein	Diamantwerkzeuge	Rieste
9883	106704	Walter Schlötterer	Werkzeuge	Dinkelsbühl
9884	106712	Leitermann GmbH & Co.	Fachmarkt KG	Oelsnitz/Erzg.
9885	106714	Robert Mann	Werkzeuge	Ebsdorfergrund-Hachborn
9886	106715	BEDO Innenausbausysteme	Baustoffe GmbH & Co KG	Berlin
9887	106721	STAMA GbR	Baumaschinen-Baugeräte	Erfurt
9888	106722	Bautenschutz Eilenburg GmbH		Thallwitz-Böhlitz
9889	106726	Power Fixings Ltd.		Brislington, Bristol
9890	106736	Roger W. Jones Ltd.		Rhyl, Denbighshire
9891	106760	Technipoint b.V.		Coevorden
9892	106761	SPAX International GmbH & Co.KG		Ennepetal
9893	106763	Wöhlk GmbH	Holz- u. Baustoffhandel	Markersdorf OT Holtendorf
9894	106767	Roskam B.V.		Amsterdam
9895	106771	NABOTEC GmbH	Nagel-, Bohr- und Trenntechnik	Rotenburg/F.
9896	106773	Janetschek	Schweißtechnik-Vertriebs GmbH	Cham
9897	106775	INTERPARES-MOBAU-Zentrallager	Rheinland GmbH & Co. KG	Euskirchen
9898	106777	HKL Baumaschinen GmbH	Gewerbegebiet Fichtenweg	Erfurt Kerspleben
9899	106778	M A H -Werkzeuge	Hans Hofmann	Eggolzheim
9900	106783	Dunkel - Bau Technik		Aichwald
9901	106787	Dach Walter GmbH		Großschwabhausen
9902	106788	Denis Büchner	Werkstattausrüstungen	Weimar
9903	106795	Meisl GmbH	Elektro-Mechanik	Berchtesgaden
9904	106801	NICHT LIEFERN! KUNDE IST INSOLVENT	Rouweler Vakzaak	Goor
9905	106803	Werkzeug Schade GmbH		Göda
9906	106817	Mobau Profi Zentrum	Wirtz & Classen	Heinsberg
9907	106823	Voskamp	Industrie + Techniek BV	Hengelo OV
9908	106824	Voskamp Bouw en Industrie B.V.		Rijssen
9909	106825	Voskamp Bouw en Industrie B.V.		Enschede
9910	106826	Achtermann GmbH		Troisdorf
9911	106827	Schrauben Weiß	Inhaber André Weiß	Aue
9912	106828	Werkzeug Werner		Gotha
9913	106835	Michael Baldino	Eisenwaren und Werkzeuge	Sprendlingen
9914	106837	Bude GmbH		Roßleben-Wiehe
9915	106842	Händel GmbH	Baugeräte	Ingolstadt
9916	106853	Stang GmbH & Co.KG		Gmund-Moosrain
9917	106854	GfB Handelsgesellschaft	Bef. Technik GmbH	Treuen
9918	106858	Vernhold GmbH		Münster-Hiltrup
9919	106862	NBP Nürnberger Bund PVH GmbH		Hagen
9920	106864	Schuebo GmbH		Kreuztal
9921	106867	Adolf Richter GmbH		Kiel
9922	106873	team baucenter GmbH & Co KG		Eggesin
9923	106874	Reca Norm GmbH		Ingolstadt
9924	106881	Dozon Bouwtechniek B.V.		Doetinchem
9925	106886	Walter Gmelch e. K.	Inh. Lenz Gmelch	Geisenfeld
9926	106889	Nüßing GmbH		Siegen
9927	106891	Böhm GmbH & Co KG		Potsdam
9928	106892	AMTHOR	Fachgroßhandel	Rudolstadt
9929	106904	Leeuwbouw B.V.		Zwolle
9930	106911	Pumpen & Maschinen	Inh. D. Weise	Ronneburg
9931	106912	G & T Imports Ltd.		Birkirkara
9932	106913	dth	Arnold Jank	Kolkwitz-Milkersdorf
9933	106920	ABsys SA		Kleinbösingen
9934	106927	Brema GmbH		Hohenlinden
9935	106929	Gutmann Fachmarkt GmbH		Haslach im Kinzigtal
9936	106937	Raiffeisen-Handelsgenossenschaft	Schöneck eG	Schöneck
9937	106938	GEITH & NIGGL GmbH & Co. KG	Baugeräte Baustoffe Mietpark	München
9938	106945	Andrea Holdgrün	Technischer Außendiensthandel	Buchen/Hainstadt
9939	106950	Ingo Weber	Techn. Fachgroßhandel	Reichshof-Denklingen
9940	106951	WEO Werkzeughandel GmbH		Essen/Oldenburg
9941	106952	BSB Service f.d. Baugewerbe		Taufkirchen
9942	106958	HAWIB Handwerks- u. Industrie-	bedarf GmbH	Chemnitz
9943	106963	Groothandel Delftechniek B.V.		Delfzijl
9944	106965	Buttinoni Giuseppe E Figli SNC		ALBINO (BG)
9945	106966	BBF Baumaschinen GmbH		Grimma
9946	106970	Ernst Granzow GmbH & Co.		Leonberg
9947	106971	HEUGER Cottbus GmbH		Cottbus
9948	106976	Throm GmbH		Büdingen
9949	106978	Woldt Bau- und Industrie-Service		Eberswalde
9950	106982	Baustoff Union GmbH & Co.KG		München
9951	106986	Bauzentrum	Bad Langensalza	Bad Langensalza
9952	106994	wolfcraft GmbH		Kempenich
9953	106998	Rüde Bau- und Industriebedarf GmbH		Meiningen
9954	107000	Markus Schwarz	Handwerkerbedarf	Ravensburg
9955	107002	Artur Beglau	WZ und Industriebedarf	Taucha
9956	107003	EGN Baustoffhandel Grimmen	GmbH & Co.KG	Grimmen
9957	107004	dts Manfred Quandt		Stutensee-Blankenloch
9958	107007	Maier + Kaufmann GmbH		Steinach
9959	107010	Bilawsky	Maschinen u. Werkzeuge	Murg-Niederhof
9960	107016	Eichsfeld Holz GmbH	Holz & Beschlagfachhandel	Leinefelde
9961	107021	MMS Mario Ludolph	Miet u. Maschinenservice	Borken
9962	107027	Piel-DIE TECHNISCHE Großhandlung	GmbH	Soest
9963	107034	Achim Schwandt	Elektrotechnik	Deensen
9964	107036	Industriebedarf Ohmert GmbH		Euskirchen
9965	107038	ABRABORO Kft		Szentendre
9966	107039	Schunke Werkzeughandel		Berlin
9967	107040	BSG Baugeräte Schünke GmbH		Heideland OT Koenigshofen
9968	107043	K & K Elektrotechnik GmbH		Luckenwalde
9969	107044	Achhammer GmbH & Co.KG	Werkzeuge Maschinen Montageartikel	Nittendorf
9970	107045	Berliner Schrauben GmbH & Co KG		Oer-Erkenschwick
9971	107059	Buckmann Bauzentrum GmbH & Co.KG		Bremen
9972	107060	PROFESS	Horst Jochen Wieprecht	St. Leon-Rot
9973	107062	Niklaus Baugeräte GmbH		Singen
9974	107066	Flügel Handwerkerbedarf GmbH		Lautertal
9975	107067	Holzzentrum Wöhlk Dresen	GmbH & Co. KGtoffe	Dresden
9976	107076	padre- Paul Dreiner	Verwaltungs UG & Co. KG	Wermelskirchen
9977	107080	Wiedemann Werkzeuge		Kaufering
9978	107084	ATTERER Stahlcenter GmbH		Marktoberdorf
9979	107089	Odenwälder Baumaschinen GmbH		Mörlenbach
9980	107090	Busse Technischer Handel	GmbH & Co. KG	Emden
9981	107093	Niklaus Baugeräte GmbH		Gomaringen
9982	107097	EBV Werkzeug- u. Verbindungs-	elemente-Vertriebs-GmbH	Bleialf
9983	107098	Ulmener Werkzeuge Gehl GmbH		Ulmen
9984	107100	SPH Straacher Produktions- und	Handelsges. mbH	Straach
9985	107101	Baumgärtel GmbH		Neuwied-Oberbieber
9986	107104	Saeed Mohamed Basuliman Est for Tra	Building 3118  Unit No. 6	Riyadh, Kingdom of Saudi Arabi
9987	107106	WMS Vertriebs- GmbH		Schwaigern
9988	107108	Einkaufs- und Liefergenossenschaft	Metall e.G. GroßHdl. San. Heiz	Lübben
9989	107109	HeimwerkerZentrum Wagner GmbH		Elz
9990	107111	Nüssing GmbH	Niederlassung Sonnenwalde	Sonnewalde
9991	107120	BHG AG - BFH Bayreuth		Bayreuth
9992	107125	Wilh. Jansen - Eisenjansen	GmbH & Co. KG	Geilenkirchen
9993	107126	FEGA & Schmitt GmbH	Elektrogroßhandel	Hanau
9994	107132	Stabilo - Landtechnik	Berthold Kieninger e. K.	Aalen Waldhausen
9995	107135	EGRO Warenhandel	Hagen Helmig	Mülheim
9996	107138	Schrauben - Heidig	Normteilhandel	Zittau - Pethau
9997	107145	Fritz Schlund	Elektromotoren	Coburg
9998	107151	Berliner Schrauben GmbH & Co KG		Münster
9999	107153	CEF Elektrofachgroßhandlung	Nord  GmbH	Karslruhe
10000	107156	Nüßing GmbH		Emleben
10001	107157	Brigitte Schröder	Werkzeughandel	Lahnstein
10002	107159	Thomas Leis	Werkzeuge - Service	Calbe/Saale
10003	107160	KARACA MAKINA Ltd.	Persembe Pazari Cad. Cesme sok.	Karakoy-ISTANBUL
10004	107180	Bauzentrum Pfaffenhofen GmbH&Co.KG		Pfaffenhofen
10005	107185	Boogaard		Haarlem
10006	107187	Regts Holding BV I.O.		Sneek
10007	107193	Groenhart Group B.V.		Zwaag
10008	107194	Groenhart Group B.V.		Alkmaar
10009	107196	Wijngo Holland B.V.		Gouda
10010	107199	Hans Möller & Sohn GmbH		Kelkheim
10011	107200	MSM-Wälzlager und	Industriebedarf GmbH	Troisdorf-Oberlar
10012	107210	Hornung GmbH & Co. KG		Stutensee - Friedrichstal
10013	107213	Baustoff Union GmbH & Co.KG	NL BU West	München
10014	107214	FEGA & Schmitt Elektrogroßh. GmbH	NL Fulda	Fulda
10015	107216	E + B Stahlhandel GmbH & Co KG		Bendorf
10016	107217	Ronald Brauer	Motorgeräte	Landsberg/OT Queis
10017	107228	MARKANT Handels und Service GmbH	Inkasso/Zentralregulierung	Offenburg
10018	107235	WEHAMA Magdeburg GmbH		Magdeburg
10019	107237	ELG des metallverarb. Handwerks	Meißen eG	Meissen
10020	107246	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Woerden
10021	107252	Holthöwer GmbH	Fachzentrum	Dülmen
10022	107254	BMN Van Keulen I Amsterdam		Amsterdam
10023	107256	Baustoff-Union Neuenhagen GmbH		Neuenhagen
10024	107259	Schulz Baubedarf GmbH	Ludwigsfelde	Ludwigsfelde
10025	107260	A & R Koch	Druckluft- und Befestigungstechnik	Schlotheim
10026	107268	SEEFELDER GmbH	Baubeschläge-Werkzeuge	Landshut
10027	107283	Albert Leymann GmbH & Co.	Baustoffe	Sulingen
10028	107287	B & W Befestigungstechnik	Werkzeuge	Ludwigslust
10029	107291	Pelzl Elektrogrosshandels GmbH		Glauburg
10030	107293	Eberle Hald Handel&Dienstleistungen	Dresden GmbH	Coswig
10031	107294	Staubach & Christiani GmbH		Gelsenkirchen
10032	107295	Jura-Schrauben GmbH & Co. KG		Nürnberg
10033	107296	Häder GmbH		Melle
10034	107300	Gradl Befestigungstechnik		Kümmersbruck
10035	107305	Bau Team Röther		Ahrensbök
10036	107307	August Bischoff GmbH & Co. KG		Bad Dürkheim
10037	107310	Klaus Braun GmbH		Kastellaun
10038	107315	Elektromaschinenbau Gärtner GbR		Elsterwerda
10039	107319	Govers B.V.		Den Helder
10040	107320	Schweißtechnik Becker	Inh. Barbara Stanke	Erfurt/Urbich
10041	107325	Mann Diamanttechnik GmbH & Co.KG		Bochum
10042	107326	Jörg Bergander e. K.	Inh. Jörg Bergander	Schipkau
10043	107329	A. Selzer	Industriebedarf-Großhandel GmbH	Schmelz-Hüttersdorf
10044	107332	Appelhagen & Kolberg Handelsver-	tretungen Inh. Erwin Kolberg	Neubrandenburg
10045	107340	Leuther Schleifmittel und Diamant-	werkzeuge	Panketal
10046	107344	Befestigung & Technik Witten	Reinhard Ikenmeyer	Witten
10047	107345	JÄGER DIREKT	Jäger-Fischer GmbH & Co. KG	Reichelsheim
10048	107349	Strehlaer Baumaschinen GmbH	Baugerätehandel	Strehla
10049	107350	Verbindungstechnik & Baustoffhandel	Jürgen Schiffer GmbH	Isseroda
10050	107352	Werkzeug Partner	Jörg Noack	Lauchhammer - Mitte
10051	107353	EW-präsent GmbH		Witten-Annen
10052	107354	BBI Beck Befestigungstechnik	Industriebedarf GmbH & Co.KG	Hameln
10053	107361	Heiratec GmbH	Industrie + Haustechnik	Stadtoldendorf
10054	107364	Mathias Peter Cakó	Werkzeuge u. Maschinen	Neuching
10055	107365	GROSS-Werkzeuge KG		Osthofen
10056	107368	BAUKING Weser-Ems GmbH	Niederlassung Osnabrück-Fledder	Osnabrück
10057	107376	MONTTEC GmbH		Siegen
10058	107381	S & S Elektro-Fachgroßhandlung GmbH	Schmidt + Schneider	Dillenburg - Manderbach
10059	107384	IHW Koch	Inhaber Frank Lutze	Nordhausen
10060	107393	Meier Vertriebs GmbH & Co.KG		Pr. Oldendorf-Holzhausen
10061	107397	Gierth & Herklotz GmbH	Mietgeräte	Bernau/Rehberge
10062	107398	Zwager IJzerhandel BV		Den Haag
10063	107400	Otto Roth GmbH & Co KG		Stuttgart
10064	107404	CS-SECUTEC GmbH		Speicher
10065	107406	Reidl GmbH & Co.KG		Hutthurm
10066	107408	Werkzeuge Dietrich	GmbH & Co.KG	Burgdorf
10067	107410	J. Pfefferl	Breitfeld	Aholming
10068	107413	Keller & Kalmbach GmbH	Filiale Würzburg	Würzburg
10069	107416	Otto Röhrs GmbH	NL Rotenburg	Rotenburg/Wuemme
10070	107418	Rudolf Sievers GmbH	Partner für Technik	Hagenow
10071	107423	F. Schünke GmbH		Lauchringen
10072	107425	Armin Braun GmbH		Offenburg-Zunsweier
10073	107427	Hass + Hatje GmbH	Baustoffzentrum	Rellingen
10074	107433	Walter Wesemeyer GmbH		Greifswald
10075	107436	Handelsunternehmen Sebastian Ehlert		Hallungen
10076	107437	Baubedarf Rentz GmbH		Neukirchen-Vluyn
10077	107440	Berger Bau- + Industriebedarf GmbH		Eggenfelden
10078	107443	EUROPART Materials GmbH	Abt. Rechnungsprüfung	Hagen
10079	107444	hagebaucentrum Bolay GmbH & Co KG	Abt. Mietpark	Rutesheim
10080	107448	WMT GmbH	Werkzeuge Maschinen	Hildesheim
10081	107459	TYÖKALUTUONTI OY	Professional Tools	HELSINKI
10082	107460	Wille GmbH	Baugeräte-Schalungstechnik	Neubrandenburg
10083	107468	S & L	Fachgroßhandel f. d. Raumausstatter	Balve-Garbeck
10084	107471	Machens Industriebedarf GmbH		Hohenhameln OT Clausen
10085	107474	Tom Tritschler GmbH		Erftstadt
10086	107475	A-Z Baumaschinenhandel	Hattingen GmbH	Krefeld
10087	107481	Schleyer	Sicherheit & Technik	Wetter
10088	107484	Mobau Klein GmbH		Niederkassel-Mondorf
10089	107497	Elektrowerkzeuge Hoffmann e.K.	Inhaber Daniel Hoffmann	Lüdenscheid
10090	107499	De Schuur B.V.		Kootwijkerbroek
10091	107503	HEMÜ Werkzeuge GmbH		Linsengericht
10092	107504	Torsten Pischko		Kaltensundheim
10093	107505	Krüger & Scharnberg GmbH	FH Schwarzenbek	Schwarzenbek
10094	107507	Hass + Hatje Baustoffzentrum		Ratzeburg
10095	107508	Walter Wesemeyer GmbH		Siek
10096	107509	Bergsma Leek	Gereedschappen	Leek
10097	107510	Carl Beutlhauser	Baumaschinen GmbH	Regensburg
10098	107515	BTE Bauteile Ergenzinger GmbH	Hauptverwaltung Düsseldorf/Germany	Düsseldorf
10099	107517	Schweißfachhandel	R. Lerch	Wachstedt
10100	107520	Bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Buchholz
10101	107523	NL Raab Karcher Waiblingen	Stark Deutschland GmbH	Waiblingen
10102	107531	Oliver Grund	Elektrowerkzeuge	Duisburg
10103	107536	Eisen Thielen GmbH & Co		Daun/Eifel
10104	107544	Provak Drachten		Drachten
10105	107545	Krüger & Scharnberg G.m.b.H.		Hamburg
10106	107549	KaDo GmbH	Baumaschinen & Baugeräte	Neunkirchen
10107	107553	Bauer Baugeräte		Düren
10108	107554	MTA Schleif- u. Befestigungst.	Vertriebs-GmbH	Dasing
10109	107558	Boogaard		Heemskerk
10110	107562	Piller Maschinenhandel OHG		Kollnburg
10111	107564	STUKK ABE	Einkaufsg. f. das Stuckgewerbe eG	Nürnberg
10112	107576	W. Grün GmbH & Co. KG		Gießen
10113	107581	Klaus Meier GmbH	Werkzeug + Maschinenhandel	Trier
10114	107582	Carl Beutlhauser GmbH	Baumaschinen	Dresden
10115	107585	OOO Toolfor		Moscow, Russia
10116	107586	Strobel Diamant GmbH		Pforzheim
10117	107588	Baupunkt Flügel GmbH	Masch. Verm.- u. Baubedarf	Wismar
10118	107589	Hass + Hatje GmbH		Bad Oldesloe
10119	107590	PROFESS	Bauprodukte Handels GmbH	Ahrensburg
10120	107591	MANAL doo		Zagreb
10121	107592	KREBS Baubeschlag GmbH		Berlin
10122	107595	Theodor Wölpert GmbH & Co.	Baustoffe Fliesen	Neu-Ulm
10123	107602	BePe Befestigungstechnik GmbH		Waldbröl
10124	107604	UNION Bauzentrum HORNBACH GmbH		Annweiler
10125	107610	BHG Bau-Heimwerker-Garten-Markt	GmbH & Co.KG	Altentreptow
10126	107611	Krabbes Dienstleistungscenter	Inh. J. Stoye	Leipzig
10127	107615	Michaelis Fachgroßhandel		BERLIN TEMPELHOF
10128	107617	UNION Bauzentrum HORNBACH GmbH		Billigheim
10129	107621	MULTITOOLINDO SEJAHTERA	Komplek Pertokoan	Jakarta / INDONESIA
10130	107622	Häsele Baucentrum		Schwäbisch Hall
10131	107623	Hass + Hatje GmbH	Baustoffzentrum	Bad Segeberg
10132	107627	Baumaschinen und Nutzfahrzeuge	Wolfgang Trinks	Frohburg
10133	107628	Dubick & Stehr	Baugeräte GmbH	Schwerin
10134	107638	BAUKING Weser-Ems GmbH	Niederlassung Osnabrück-Atter	Osnabrück/Atter
10135	107641	UNION Bauzentrum HORNBACH GmbH		Germersheim
10136	107645	Heinrich Knobloch GmbH		Rhauderfehn
10137	107649	HKN Handelskontor Nord	GmbH & Co. KG	Wilhelmshaven
10138	107650	Verpa Senco B.V.		Lelystad
10139	107655	IMG		Wenum-Wiesel
10140	107658	Hockertz Baumaschinen		Bitburg - Flughafen
10141	107664	Leitermann GmbH & Co.	Fachmarkt KG	Rochlitz
10142	107665	Theodor Wölpert GmbH & Co.	Baustoffe - Fliesen	Herbrechtingen-Bolheim
10143	107670	Apprich-Baustoffe GmbH & Co KG		Böbingen
10144	107672	ankox GmbH		Magstadt
10145	107674	Restemeyer GbR		Westerkappeln
10146	107675	Optimera Estonia AS		TALLINN
10147	107677	BGN Gleichauf Haustechnik	GmbH & Co. KG	Neumarkt
10148	107679	Bianca Hitzler GmbH	Diamantwerkzeuge	Dillingen/Donau
10149	107680	Lorenz	Baubedarf	Malchin
10150	107684	Nordhäuser Stahl GmbH		Nordhausen
10151	107685	Bauzentrum Otto Zillinger	GmbH & Co.KG	Osterhofen
10152	107687	C.F. Janus GmbH & Co.KG	Baustoffhandel Hagebau 118501	Wismar
10153	107688	Felbick Werkzeuge	Inh. Karl Ernst Felbick	Remscheid
10154	107689	Werkzeugfachhandel	Dieter Erdmann	Neuenhagen
10155	107690	HK-Industriebedarf GmbH		Mönchengladbach
10156	107691	team baucenter GmbH & Co KG		Bentwisch/Rostock
10157	107694	Heinrich Thorwesten KG	Baustoff-u. Bedachung	Balve
10158	107695	ELEKTROWERKZEUGE	Volker Lauche	Wohlmirstedt
10159	107703	Meus Maschinen		Lichtenhagen/Dorf
10160	107706	Maschinen-Gruber GmbH		Falkenberg
10161	107709	Teuchert Dichte Bauwerke GmbH		Großschirma
10162	107710	B.S.H. GmbH	Bau- u. Sanitärhandel	Breidenbach-Biedenkopf
10163	107713	GEORGES ZAKA & CO. S.A.R.L.	Rbeiz Bldg.	BEIRUT / LEBANON
10164	107714	Schrader Handel GmbH & Co. KG		Northeim
10165	107715	Schotte Verbindungstechnik	GmbH & Co.KG	Wuppertal (Barmen)
10166	107716	Deterding Fachmarkt GmbH		Nienburg
10167	107718	UNION Bauzentrum HORNBACH GmbH		Kandel-Mindersloh
10168	107721	HÜBNER WERKZEUGE GMBH		Großröhrsdorf
10169	107730	Ernst Noeke GmbH & Co.KG		Meschede
10170	107732	Querfurter Fahrzeugteile	und Industriebedarf GmbH	Querfurt
10171	107745	Premier Fixings	Unit 1	Aberdeen
10172	107747	C.D.F. Supplies Ltd.		Chorley
10173	107750	Martindale Industrial Fasteners	Unit 3D	Longridge, Lancashire
10174	107751	Mark Up Tools Ltd.		Manchester
10175	107752	Avantifix (Fixing Solutions) Ltd.	Bridge Works	Rothwell, Leeds
10176	107754	Lloyd & Jones Engineers Ltd.	Langton House	Bootle, Merseyside
10177	107758	Harlequin Fixings	Unit D Block 2	Kilmarnock
10178	107759	Northfield International Ltd.		Billingham,Stockton-on-Tees
10179	107761	Crown Tools & Fixings Ltd.	Unit 49, Grace Business Centre	Mitcham, Surrey
10180	107762	Fast Pak Ltd.		Stourbridge, West Midlands
10181	107763	Herts Tool Co	T/A HTC Fastenings Ltd.	St. Albans, Herts.
10182	107771	London Plant Hire (Dermamoss Ltd)	Tool Hire & Sales	Finchley, London
10183	107773	S & S Elektro-Fachgroßhandlung GmbH	Schmidt & Schneider	Overath-Untereschbach
10184	107775	Biebrach C. H. Morgenstern GmbH		Dresden
10185	107777	Eurotools International Ltd.	Brent House, 3rd floor, Suite A14	Harrow, Middlesex
10186	107780	Western Bolt & Eng. Supplies Ltd.		Taunton
10187	107781	EBB Erfurter Baumaschinen und	Baugeräte GmbH	Erfurt
10188	107785	P.E.T Hire Centre Ltd.		CREWE, CHESHIRE
10189	107790	Lawson H.I.S. Ltd.	Unit 1, Itchen House	Southampton, Hampshire
10190	107792	Bauwelt Delmes Heitmann	Profi-Fachmarkt	Seevetal
10191	107796	IFI Limited	Units 1,2,3	Peterborough, Cambridgesh.
10192	107801	Specialist Contractors Supplies Ltd	Unit 29	Wolverhampton
10193	107808	Rajkovic Handels GmbH		WIEN
10194	107809	Feucht GmbH	Baustoffe + Fliesen	Backnang
10195	107811	Cable Ties Direct		Sheffield, South Yorkshire
10196	107815	Schreier Maschinenhandel	Inh. Doris Collrep	Erfurt
10197	107817	Invicta Tools & Fixings Ltd.	Wincheap Industrial Estate	Canterbury, Kent
10198	107826	Edge Building Products		Horsham
10199	107828	Brabbin & Rudd	Industrial Supplies & Engineers M.	Bolton, Lancashire
10200	107829	hagebau Centrum Köthen GmbH & Co.KG	Baustoffhandel	Köthen
10201	107834	Berriman & Chapman		Scarborough, N.-Yorkshire
10202	107836	VIJAK d.o.o.	trgovsko podjetje	Trzin
10203	107839	Mur-fix Ltd.	The JM Centre	Swinton, Manchester
10204	107847	BAUKING Westfalen GmbH	Niedl. Gladbeck	Gladbeck
10205	107854	dth Ingo u. Olaf Hartmann GbR	Fachgeschäft	Chemnitz
10206	107859	Baustoff Union GmbH & Co.KG	Baustoff Großhandlung	Grafing
10207	107863	EUROBAUSTOFF Zentrallager OST	GmbH & Co KG	Petersberg OT Wallwitz
10208	107866	Bachar & Elias Taoutel		Aleppo Syria
10209	107871	Brianson Electrical		Croydon, Surrey
10210	107878	MECHANICAL World S.A.C.	RUC 20506591431	Lima 32, PERU
10211	107879	Technischer Handel u. Service	Inh: Vera Sauer	Görlitz
10212	107883	Swansea Fasteners & Eng. Sup. Ltd.	Units 7 & 8 Horizon Park	Swansea
10213	107888	Kellner & Kunz AG	Schrauben - Werkzeuge - Normteile	WELS
10214	107890	Mobau Dörr & Reiff GmbH		Eschweiler
10215	107891	Kohrmann Baumaschinen	GmbH	Renchen
10216	107892	TK Baumaschinen GmbH		Detmold
10217	107894	Gerhardt GmbH	Hagebau Profi	Dreieich
10218	107902	Fastfix Tools Ltd.		Southampton, Hampshire
10219	107904	Martin Meier AG		Eichstätt
10220	107906	Bauzentrum Sievert GmbH & Co.KG		Marktredwitz
10221	107907	Kneissl Industriebedarf GmbH		Lauda-Königshofen
10222	107913	Wolfgang Knabe GmbH		Damme
10223	107918	Eisen Krapp GmbH & Co.KG		Bad Laer
10224	107928	Stainless Steel Centre		Cattedown, Plymouth
10225	107930	Makita Australia Pty Ltd		Pemulwuy
10226	107934	B & P GbR Fachhandel für Werkzeug	Inh. Klaus Panasik & Olaf Barnewitz	Nauen
10227	107936	Mobau Döör & Reiff GmbH		Stolberg-Mausbach
10228	107939	Mayer + Ruppert GmbH	I & M Bauzentrum	Hochdorf-Assenheim
10229	107941	FWB South West Ltd.		Truro, Cornwall
10230	107950	Hans Koll	Landtechnik	Meggerdorf
10231	107954	IJzerhandel Zwaard B.V.		Delft
10232	107955	M & F Werkzeughandel GmbH		Windeck
10233	107957	Arbeitsschutz- & Baugerätehandel	Gerd Wald	Mansfeld / OT Großörner
10234	107964	Duchy Fasteners Ltd.	Units 1 to 4	Perranporth, Cornwall
10235	107966	CEF Elektrofachgroßhandlung	Norderstedt GmbH	Norderstedt
10236	107968	UNION Bauzentrum HORNBACH GmbH		Münchweiler
10237	107971	Hermann-Josef Stoffels	Werkzeuge u. Maschinenhandel	Dierscheid
10238	107972	Tobias Hipp	Fa. Hipp	Lechbruck am See
10239	107974	Bauzentrum Seyfarth GmbH		Potsdam
10240	107977	SAS ALSAFIX		GRIES (Strasbourg)
10241	107978	Hattemleeuw B.V.		Hattem
10242	107987	Bau- und Heimwerkershop	Inh. Ines Machalett	Obergebra
10243	107988	Bauzentrum Schnepf GmbH & Co.KG	Interpares-Mobau	Güstrow
10244	107992	TOCAFIX AG		Spreitenbach
10245	107994	BBS Bur Baumaschinen Service GmbH		Rochlitz
10246	107999	Peter Seiwert GmbH	Elektrotechn. Großhandlung	Illingen
10247	108001	reichelt elektronik GmbH		Sande
10248	108007	KHANDAKER MILL STORES	VAT Registrat. Number: 21281033487	DHAKA-1100, BANGLADESH
10249	108009	Tobias Ebeling	Werkzeugfachhandel	Alsleben
10250	108011	H & W Eisenwarenhandelsges. mbH		Hamm
10251	108019	Henrich-Gerolstein Zweig-NL	Henrich BZ GmbH & Co.KG	Gerolstein
10252	108024	EURL OUTILSEC	Equipements Industrielles	EL-HAMIZ  ALGER
10253	108028	Mobau Dörr & Reiff GmbH		Düren-Gürzenich
10254	108031	Fegime Deutschland GmbH & Co.KG		Nürnberg
10255	108035	Albert Leymann	Baustoffe GmbH & Co.	Twistringen
10256	108036	Jewema Werkzeuge + Maschinen GmbH		Jena
10257	108037	H.W. Meyer sen. Wwe. GmbH + Co.KG		Soltau
10258	108039	Rohse & Lipfert GmbH		Unterwellenborn
10259	108041	First Fix	Unit 1 B	North Yorkshire
10260	108045	Strauch & Böttcher GmbH & Co.KG	i&m Bauzentrum	Gröden
10261	108046	Berry Clark & Co. Ltd.	Berry House, Gypsy Lane	Staffordshire
10262	108048	Steinacker Stalleinrichtungen	Inh. Thomas Steinacker	Dinkelsbühl
10263	108049	IBT Ingold & Burgert GmbH		Freiburg
10264	108053	EUROBAUSTOFF Zentrallager Bayern	GmbH & Co.KG	Rohr
10265	108054	Wesco KG	Fachgrosshandel für Gebäudetechnik	Wenden-Hünsborn
10266	108058	Kellerðs IJzerhandel B.V.	Goederenontvangst (2ee roldeur)	Rotterdam
10267	108062	Pawils Elektromaschinenbau GmbH		Peine
10268	108063	Elias Illgen	Werkzeuge u. Bautechnik	Oelsnitz OT Neuwürschnitz
10269	108064	Bauzentrum Spies GmbH		Geseke
10270	108072	ALARM Werkzeuge GmbH		Remscheid
10271	108080	Fachmarkt Krethe		Cadenberge
10272	108082	Wabners Bautechnik GmbH		Velten
10273	108083	PROMATECH Trading GmbH	z.Hd. Herrn Schlickum	Hamburg
10274	108089	Peter Gieraths GmbH & Co. KG		Remagen
10275	108091	Ter Laare B.V.		Maassluis
10276	108093	profibau	Handel Logistik Service GmbH	Göppingen
10277	108096	Ruhland-Kallenborn GmbH	Baustoffhandel	Blieskastel
10278	108100	Diamant Technik	Jakob Schmidt	Bad Dürkheim
10279	108108	Lindner Werkzeuge		Bad Gottleuba
10280	108111	Bakker de Houthandel		Hoogkarspel
10281	108112	L.J. Machine Tools Ltd.		Lurgan, Co.Armagh, N.-IRL.
10282	108113	C. G. Christiansen GmbH & Co.	Holz- und Baustoffzentrum	Mildstedt
10283	108116	Eurofasteners Ltd.		Weymouth, Dorset
10284	108117	Moog GmbH		Paderborn
10285	108118	Stupp Baustoffe GmbH		Bad Soden-Salmünster
10286	108122	Grampian Fasteners		Dyce, Aberdeen, SCOTLAND
10287	108123	OOO YASTA""		Kyiv / Ukraine
10288	108126	P.A.M. Ties Ltd.	Electric House	Tyldesley, Manchester
10289	108128	UNION Bauzentrum HORNBACH GMBH		Kaiserslautern-Einsiedlerhof
10290	108130	Bolt & Bearing (London) Ltd.	Unit B5, Valley Link Estate	Enfield
10291	108131	Stefan Balleis Industrie- und	Werksbedarf e.K. - Inhaber	Baar
10292	108133	1st Fix Systems Ltd.	Unit 3 Abercorn House,	Newcastle-upon-Tyne
10293	108135	mkw Fachhandel	Klaus Mayer	Wachenroth
10294	108136	AER SIA		Marupes nov
10295	108141	Bauzentrum Zeiß GmbH & Co KG		Fürth/Odenwald
10296	108142	Hurter Elektromaschinenbau GmbH		Leutkirch/Allgäu
10297	108143	Stelter GmbH		Verl
10298	108146	Gebr. Kinzer oHG	Vermietung-Verkauf-Wartung	Altenstadt/H.
10299	108147	Baustoffunion GmbH & Co.KG		Ansbach
10300	108151	dth Martin Henke		Hagen
10301	108152	Schäfer	Werkzeuge Baumaschinen	St. Ingbert
10302	108154	BHG Handelszentren GmbH		Luckau
10303	108156	Mainline Products Ltd.	Unit 3b Aspect Court	Silverdale, Newcastle u. Ly.
10304	108158	Workwear Center		Glenrothes, Fife/Scotland
10305	108160	Bauvista GmbH & Co. KG	Einzelhandel	Lage
10306	108161	GAAC Commerz GmbH		Mittenwalde
10307	108163	Strukta Ltd.	T/A Advance Fixings	Andover, Hampshire
10308	108165	bauXpert Gebhard GmbH & Co. KG		Zeven
10309	108173	M+V Bauservice OHG		Waren (Müritz)
10310	108179	DMB Baumaschinen		Embsen
10311	108184	RapierStar Imports Ltd.	Star Business Park	Macclesfield, Cheshire
10312	108186	Jan Fr. Gehlsen GmbH & Co. KG	Holzland	Rendsburg
10313	108188	W-tec Waidhofer & Winkler GmbH	Techn. Industriebedarf	KEMMELBACH
10314	108192	ITW Construction Products		Middelfart
10315	108193	Werner Industriebedarf		Barnstorf
10316	108195	Adams Bausysteme	Bauelemente + Industriebedarf	Acht
10317	108197	Fierro Vignoli S.A.		Montevideo
10318	108198	Ahrens Fachmarkt GmbH & Co.		Lügde
10319	108200	bauwelt Geesthacht		Geesthacht
10320	108203	HORNBACH Baustoff UNION GmbH	Zentrale	Neustadt
10321	108209	Robert Röhlinger GmbH		Schiffweiler-Heiligenwald
10322	108213	Celo GmbH		Wilnsdorf
10323	108216	Georg C. Hansen GmbH & Co.KG		Husum
10324	108217	Stahlhandel Haug	GmbH & Co.KG	Bad Friedrichshall
10325	108218	INTERNATIONAL GROUP AP SUALPE		Madrid
10326	108224	BETO		Oud-Beijerland
10327	108225	IHB Industrie- und Handwerksbedarf	Inh. Thomas Schwotzer	Lauter-Bernsbach
10328	108226	Toplicht GmbH		Hamburg
10329	108227	H. gr. Beilage GmbH & Co.KG	Holz - u. Baufachhandel	Vechta
10330	108228	Wilhelm Schlotfeldt	Stahl- & Sanitärfachgroßhandel	Niebüll
10331	108232	Hans Koll	Landtechnik Ndl. Rendsburg	Rendsburg
10332	108235	CCD Diamanttechnik		Bremen
10333	108236	ITW Construction Products U.K.		Glenrothes
10334	108238	Bauzentrum Schrobenhausen		Schrobenhausen
10335	108239	Bauzentrum Mayer GmbH & Co.KG		Ingolstadt
10336	108240	Marshall Industrial Supplies Ltd.	Unit E Acorn Park	Nottingham
10337	108241	Herzog Stahlhandel GmbH		Calw-Heumaden
10338	108242	DB Industriewaren		Halle
10339	108243	Sommer Gas-, Löt- u. Schweiss-	technische Handels GmbH	Pirna
10340	108244	Centro Logistico Heller		Madrid
10341	108247	I & M Mobau Baustoffzentrum	Bauer GmbH	Rudolstadt
10342	108248	Zeppelin Rental GmbH & Co.KG		Schwerin
10343	108250	Hamann GmbH		Bad Neuenahr-Ahrweiler
10344	108255	ELAWI	Eisenwaren + Werkzeuge	Wildeshausen
10345	108259	Bauzentrum Schulte GmbH & Co.KG		Papenburg
10346	108260	Bauzentrum Schulte GmbH & Co.KG		Rhede (Ems)
10347	108267	Van Deursen Diamanttechnieken B.V.		Helmond
10348	108272	Ace Fixings (Cumbria) Ltd.	Unit 34, Gilwilly Road	Penrith, Cumbria
10349	108274	elbe-tools GmbH		Wittenberge
10350	108279	Werner Schmitt	Spezialwerkzeuge	Kestert/Rhein
10351	108281	Apparatebau Jürgen Schmitz GmbH		Koblenz
10352	108282	Hannelore Rehbein	Dachzubehör Befestigungstechnik	Furth im Wald
10353	108284	BerCo d.o.o.		Maribor
10354	108288	Mietpark - Pößneck	Baumaschinen u. Werkzeug Verleih	Pößneck
10355	108297	Toolstation (Bridgwater) Ltd.	Express Park	Bridgwater, Somerset
10356	108301	ELG des Bauhandwerks e.G.		Leipzig
10357	108302	Bauzentrum Pelzer GmbH		Wesseling
10358	108305	Biehringer GmbH	Zerspanungswerkzeuge und Maschinen	Georgensgmünd
10359	108307	Heinrich Mehring GmbH & Co.KG		Dinslaken
10360	108311	BMK GmbH	Baubedarf Mietpark Kundendienst	Dresden
10361	108312	Rudolf Sievers GmbH	Partner für Technik	Schwerin-Görries
10362	108313	EUROBAUSTOFF Handelsges.mbH & Co KG		Bad Nauheim
10363	108315	Künkel Baugeräte	Fachhandel & Vermietung	Nauen
10364	108318	Weber Diamantwerkzeuge	Inh. Ulrich Weber	Kasbach-Ohlenberg
10365	108324	Quick Sharp Services	Signal Hill	Gawcott Buckinghamshire
10366	108326	Hamblin Watermains Ltd.	The Old Bam	Winnersh, Berkshire
10367	108327	K.S.V. Srl		ORTONA (CH)
10368	108330	Dalhoff GmbH & Co.KG	Baustoffzentrum	Frankfurt/Oder
10369	108332	HBA Handels und Dienstleistung GmbH		Velten
10370	108333	Scholte & De Vries - Estoppey B.V.		Diemen
10371	108336	TIS Techn.Industriebedarf Schorr		Nonnweiler-Otzenhausen
10372	108337	Georg Weber GmbH		Bad Pyrmont
10373	108338	Schönig + Würz GmbH	Elektro-Großhandlung	Groß-Zimmern
10374	108341	Guillet S.A.	B.P. 5	Villebois
10375	108342	HBK Dethleffsen GmbH		Flensburg
10376	108343	HBK Dethleffsen GmbH		Treia
10377	108347	W. Tebbenjohanns Nachf. GmbH		Vechta
10378	108349	HESS Diamantwerkzeuge GmbH		Herne
10379	108366	S + W GmbH	Schrauben + Werkzeuggroßhandel	Karlstadt
10380	108370	hego-Oldenburg NL der	WeGo Systembaustoffe GmbH & Co oHG	Oldenburg
10381	108378	Heinz Fälschle	Werkzeuge & Maschinen	Deiningen
10382	108379	HBT Hydraulik-und BauTechnik GmbH		Pirna
10383	108380	Wolfgang Lötzke	Bautechnik	Osnabrück
10384	108381	PRETEC	Pre Cast Technology AB	Kungälv
10385	108384	F. Reyher Nchfg. GmbH & Co.KG		Hamburg
10386	108386	Paul van Benthem IJzerwaren		Losser
10387	108387	W & Z  Befestigungssysteme	Inh. Oliver Zembsch	Schweinfurt
10388	108393	Ennens GmbH & Co.KG	Bau- und Industrietechnik	Ostrhauderfehn
10389	108401	SureFix Industrial Supplies		Cheltenham
10390	108403	ELG - Holz Naumburg e.G.		Naumburg
10391	108407	Gruber Diamantwerkzeuge		Idar-Oberstein
10392	108409	Peter Kasberger Baustoff GmbH		Neuötting
10393	108410	Peter Kasberger Baustoff GmbH		Pfarrkirchen
10394	108411	Peter Kasberger Baustoff GmbH		Pocking
10395	108412	Peter Kasberger Baustoff GmbH		Freyung
10396	108413	Peter Kasberger Baustoff GmbH		Passau
10397	108416	Wrayway & Co. Ltd.	Wholesale Ironmongery and Hardware	Harrogate, Nort Yorkshire
10398	108421	Bauzentrum Bühler KG		Schramberg
10399	108424	Frank Bauer	Werkzeughandel	Berlin
10400	108428	bauXpert Knipper GmbH & Co. KG		Sögel
10401	108431	Multifix Supply Company Ltd.	Pinnacle House	Boxley, Maidstone
10402	108435	Engineering Agencies Ltd.	Atholl Works	Dunfermline, Fife
10403	108436	L. Andrees GmbH	Elektro- & Baubedarf	Lotte-Büren
10404	108439	SIG Fixings	Park 26, Unit E	Bradford
10405	108440	A1 Fixings Ltd.		Sheffield, South Yorkshire
10406	108444	Krebeck Technischer Handel e.K.		Damme
10407	108447	Taktfest S.R.L. Romania	J22/117/2003	Iasi
10408	108449	Safeline GmbH		Dortmund
10409	108451	Wilhelm Fricke SE		Heeslingen
10410	108452	Rothkegel Baufachhandel GmbH	ZEK	Leipzig/Lindenthal
10411	108459	Rothkegel Baufachhandel GmbH		Merseburg/OT Beuna
10412	108460	F. & K. Paulich GmbH	Baustoffhandel	Glaubitz
10413	108462	HBK Dethleffsen GmbH		Bredstedt
10414	108465	BHG Freital	Inh. Dirk Mühle	Freital
10415	108471	The Hireman (London) Ltd.		London
10416	108476	DEG Dach-Fassade-Holz eG		Hamm-Rhynern
10417	108478	GOTOOLS GmbH		Bad Aibling
10418	108480	E.D.E. GmbH	Format" Baugeräte Arbeitskreis"	Wuppertal
10419	108488	CEF Elektrofachgroßh. Nord GmbH	Gruppenbüro Hamburg	Hamburg
10420	108490	Udo Lang	Elektrowerkzeuge	Eschau
10421	108491	Hein GmbH	Baumaschinen und Nutzfahrzeuge	Annaberg-Buchholz
10422	108493	Baustoff-Zentrum GmbH		Finsterwalde
10423	108494	AToS GmbH	Allgäuer-Tool-Service	Memmingen
10424	108498	Steffen Eisenkolb S+E	Werkzeughandel	Aschersleben
10425	108499	Tramann & Sohn GmbH & Co.KG		Oldenburg
10426	108500	MS Tools	Inhaber Markus Stolle	Allersberg
10427	108501	Wehle Werkzeuge + Maschinen		Ühlingen
10428	108503	Rothkegel Baufachhandel GmbH	NL Wolfen	Wolfen
10429	108504	Rothkegel Baufachhandel Dessau GmbH		Dessau-Roßlau
10430	108506	Fastfix Bristol Ltd. t/a Fastfix	Unit 4, Circuit 32	Bristol
10431	108508	South Western Tool Supplies Ltd.	Bell Tools	Horfield, Bristol
10432	108511	Bergmann & Franz Nachf. GmbH & CoKG		Berlin
10433	108521	Makita (New Zealand) Ltd.		Auckland
10434	108549	HTZ Handel-Technik-Zubehör	Burkhard Brede	Lippetal
10435	108551	Dachdecker-Einkauf West eG	Zweigniederlassung Lage	Lage
10436	108554	Dachdecker-Einkauf West eG	Zweigniederlassung Hagen	Hagen
10437	108556	Dachdecker-Einkauf West eG	Zweigniederlassung Krefeld	Krefeld
10438	108557	Dachdecker-Einkauf West eG	Zweigniederlassung Wesel	Wesel
10439	108558	Dachdecker-Einkauf West eG	Zweigniederlassung Solingen	Solingen
10440	108559	Dachdecker-Einkauf West eG	Zweigniederlassung Düsseldorf	Düsseldorf
10441	108560	Dachdecker-Einkauf West eG	Zweigniederlassung Fuldabrück	Fuldabrück
10442	108561	Dachdecker-Einkauf West eG	Zweigniederlassung Mülheim	Mülheim
10443	108562	Dachdecker-Einkauf West eG	Zweigniederlassung Meschede	Meschede
10444	108563	BeRo GmbH  & Co.KG		Gütersloh
10445	108564	RJ Fixings Ltd.	Unit 36C,  Inchmuir Road	Bathgate, West Lothian
10446	108572	Data Powertools Ltd.		Cardiff, WALES
10447	108573	Power Point (Northern) Ltd.	Thirsk Industrial Park	Thirsk, N.-Yorkshire
10448	108576	S & S Elektro-Fachgroßhandlung GmbH	Schmidt + Schneider	Wenden-Gerlingen
10449	108577	Voskamp Bouw en Industrie B.V.		Utrecht
10450	108578	Voskamp Bouw en Industrie B.V.		Eindhoven
10451	108579	Hofmann	Schleiftechnik	Emmerthal
10452	108581	Barnitts Ltd.		York
10453	108582	Krause GmbH	Baumaschinen - Baugeräte	Dollern
10454	108583	Arreche GmbH	Baugeräte, Industrie & Baumaschinen	Münchweiler
10455	108585	SPITZNAS Maschinenfabrik GmbH		Velbert-Langenberg
10456	108590	Baustoffzentrum Lauchhammer GmbH		Lauchhammer-West
10457	108593	Baustoff-Zentrum GmbH		Herzberg
10458	108596	Origo Distribution Ltd	C/O Masonry Fixings LTD	Dublin
10459	108599	SJ Andrew & Sons	Steel Stockholding & Eng. Supplies	Redruth, Cornwall
10460	108601	Heger GmbH		Heitersheim
10461	108602	Moser Agrar & Baufachzentrum e.K.		Schweitenkirchen
10462	108603	RKW Richard Knöchlein	Werkstatt-Technik	Deining
10463	108605	Emil Fohrer GmbH & Co.KG		Wuppertal
10464	108610	Tool & Fix Ltd.		Leigh, Lancashire
10465	108621	Phoenix Tools & Diamonds	Unit 1 Sandygate Business Park	Kingsteignton, Devon
10466	108622	Friedbert Schilke	Baustoffe - Werkzeuge	Heusweiler
10467	108626	Jürgen Rauscher	Werkzeughandlung	Eichenbühl
10468	108629	Gnädig GmbH		Lahr
10469	108632	Völkers Baustoffhandel GmbH		Kalkar
10470	108633	The Fixing Company	Unit 3 Coolmine Central	Dublin 15, IRELAND
10471	108638	Bauzentrum Szonn	Andreas Szonn GmbH	Kolkwitz
10472	108641	HG - Technik	Harald Gröger	Allmenhausen
10473	108642	CEF Elektrofachgroßhandlung Nord	GmbH Gruppenbüro Niederrhein/	Aachen
10474	108671	Bauzentrum Sommer GmbH		Eggersdorf
10475	108672	Jacob Sönnichsen AG	Baustoffe	Flensburg
10476	108674	MS Baubedarf Mario Steiner		Großfahner
10477	108678	Jacob Sönnichsen AG	Baustoffe	Neubrandenburg
10478	108682	SIG plc	Head Office	Wolverhamptom
10479	108686	Janssen Elektromaschinen GmbH		Emden
10480	108687	Pehavo - OSS		Oss
10481	108690	Jacob Sönnichsen AG	Baustoffe	Greifswald
10482	108691	Hans Papenbrook GmbH & Co.	Holztechnik	Lübz
10483	108693	Jacob Sönnichsen AG	Baustoffe	Neustrelitz
10484	108698	Carl Hinrichs e.K.	Inh. Kai Hinrichs	Augustfehn
10485	108705	Schumann Kfz-Werkstatt-Technik	Inh. Mirko Schumann	Penig OT Tauscha
10486	108708	Schrauben- & Normteile- Service	Susann Friedrich	Wurzen
10487	108711	Meyer	Schrauben & Industriebedarf e.K.	Papenburg
10488	108713	Sitebox Ltd.	Unit 19	Redhill, Surrey
10489	108717	Bussemas & Pollmeier GmbH & Co.KG		Verl
10490	108718	DCS Construction Products Ltd	Unit 6 Ebbsfleet Industrial Estate	Northfleet, Kent
10491	108720	NSB Nord-Süd Baustoffhandelsge-	sellschaft mbH & Co. KG	Bad Bramstedt
10492	108721	C Fixings Ltd.		Chadderton, Oldham
10493	108733	Petry Bauzentrum GmbH & Co.KG		Herborn/b. Idar Oberstein
10494	108734	Gebhardt Bauzentrum GmbH		Marktheidenfeld
10495	108735	Josef Thelen GmbH & Co.KG	Baumarkt und Baustoffe	Simmerath
10496	108741	Deeg GmbH	Werkzeuge-Maschinen	Velten
10497	108743	normax R. Max Radke	Technischer Bedarf u. Service	Radebeul
10498	108747	MEKOPA Diamanttechnik	Inh. Klaus Meise	Bad Zwesten
10499	108748	Thomas Rieger		Regensburg
10500	108750	A C Fixings Ltd.	Unit 8, Dukes Park Ind. Estate	Chelmsford, Essex
10501	108751	Worminghaus Baustoffh. GmbH & Co.KG	Bauzentrum	Husum
10502	108754	Ramset	A Division of ITW Australia PTY LTD	VIC 3116
10503	108758	Rollwitzer Heizung-Sanitär- und	Baustoffhandel GmbH	Rollwitz
10504	108767	Bus Handelmaatschappij B.V.		Zwolle
10505	108768	Ferdinand Wieland Großhandlung	Holz-Baustoffe-Kunststoffe	Leichlingen
10506	108770	Elektromechanik GmbH Garz	EMG	Garz/Rügen
10507	108772	Albert Leymann GmbH & Co.		Stuhr-Brinkum
10508	108773	J.N. Köbig GmbH	Bauzentrum	Eisenberg
10509	108776	Wilhelm Siemsen GmbH & Co. KG	Baustoffhandel	Eckernförde
10510	108777	Eisen Lautner e.K.		Kemnath
10511	108779	Gematecs Befestigungs- u. Montage-	technik	Hohentengen
10512	108780	Baustoff Brandes GmbH		Magdeburg
10513	108781	Te Flierhaar Sanitair B.V.		Nunspeet
10514	108782	MK Baubedarf Nord GmbH		Neumuenster
10515	108783	Black & Decker Limited S.a.r.L.		Luxembourg
10516	108785	Black & Decker  Limited BVBA	UK BRANCH	Slough, Berkshire, SL1 4DX
10517	108792	Gebrüder Löffler GmbH Baustoffe		Reichenbach
10518	108793	MSR GmbH	Baustoffhandel	Berga
10519	108796	T.P. Handel und Vertrieb	Torsten Plaul	Dresden
10520	108797	Meboldt Isolier- u.	Befestigungstechnik	Leidringen
10521	108799	Premier Services (Scotland) Ltd.		Granton, Edinburgh
10522	108800	Union Bauzentrum Hornbach GmbH		Karlsbad-Ittersbach
10523	108801	F.X. Ruch KG	Baustoffe	Messkirch
10524	108803	Hertools Werkstattservice	Inh. Mario Herold	Auerbach
10525	108810	Craighead Building Supplies	Clydesmill Grove Ind. Estate	Glasgow, SCOTLAND
10526	108811	Mobau Selbach GmbH		Rösrath
10527	108818	Portatools	Eastwood Industrial Estate	Leigh-on-Sea, Essex
10528	108822	WMS Erdmann Team GmbH		Garzau
10529	108827	Mechanical & Electrical Fixings Ltd	Bilston Glen Industrial Estate	Loanhead, Midlothian
10530	108836	Hardware & Fastener Supplies Ltd.	Unit 12, The Grange Ind. Park	Goole, East Yorkshire
10531	108840	Rudolf Krämer Eisenwaren GmbH		Duisburg
10532	108844	SIG Fixings	Federation Business Park	Dunston, Tyne and Wear
10533	108845	Bryson Products		Coulsdon, Surrey
10534	108848	Kosel GmbH	Werkzeugfabrik	Altshausen
10535	108851	WEWO Frank Wosnitza		Aalen
10536	108854	UNION Bauzentrum HORNBACH GmbH		Hauenstein
10537	108859	Erwin Hellmuth		Heilsbronn
10538	108862	Golz (UK) Limited	Unit A5	Northfleet, Kent
10539	108863	Baustoffmarkt Günding		Bergkirchen OT Günding
10540	108865	Werkzeugschleiferei M&R GmbH		Bernau
10541	108870	Direct Construction & Tunneling	Supplies Ltd.	Basildon, Essex
10542	108874	Bau-Center Neustadt-Glewe	GmbH & Co. KG	Kaliss
10543	108875	Jochen Krupp	BIT-Baufachmarkt	Waldmohr
10544	108876	Enorm IJzerhandel tðAmbachtsplein		Hazerswoude-Dorp
10545	108879	hwg-vertrieb	tools and more	Mirskofen/Essenbach
10546	108880	Hadwiger	Großhandel für Gebäudetechnik	Gersthofen
10547	108881	Eberle-Hald Handel- und Dienst-	leistungen Metzingen GmbH	Deisslingen
10548	108882	Eberle-Hald Handel&Dienstleistungen	Metzingen GmbH	Rainau-Goldshöfe
10549	108883	Eberle-Hald Handel&Dienstleistungen	Metzingen GmbH	Meckenbeuren
10550	108884	Lecot N.V. 51791		Kortrijk-Heule
10551	108886	Rocbo Boortechniek B.V.		Ruurlo
10552	108892	RB Handelsvertretungen	Ralf Baldauf	Marienberg
10553	108893	SIG Fixings Glasgow	95 Westburn Drive	Cambuslang,Glasgow, SCOTLAND
10554	108896	Faitsch OHG		Trossingen
10555	108897	A.P. Hjortso A/S		Ballerup
10556	108898	Pro Scheich	Eisenwaren	Fulda
10557	108899	Alltools Ltd.	Woodburn House	Sheffield, South Yorkshire
10558	108901	Mutzbauer GmbH & Co.KG	Befestigungstechnik	Weiden
10559	108910	Agroma GmbH & Co. KG		Uffenheim-Langensteinach
10560	108911	Saint-Gobain Building Distribution	Deutschland GmbH	Magdeburg
10561	108912	Raab Karcher Baustoffe GmbH		Stuttgart
10562	108913	Sundmäker GmbH & Co.KG		Bohmte
10563	108915	Florencio Augusto Chagas, S.A.	CHAGAS	Torres Vedras
10564	108922	Hofacker GmbH		Gelnhausen - Meerholz
10565	108925	Goldbacher Bauelemente GmbH		Goldbach
10566	108928	Metallgeno GmbH		Pasewalk
10567	108940	Zeppelin Rental GmbH & Co.KG	Zentraler Rechnungseingang	Berlin
10568	108943	Lücking Baustoffe GmbH & Co.		Bad Driburg
10569	108945	MS-Profiwerkzeuge e.K.	Matthias Schumacher	Tholey
10570	108946	Eduard Lutz Schrauben-Werkzeuge	Neuburg GmbH	Neuburg
10571	108948	Handwerks- und Industriebedarf	Hans-Otto Kuhl	Papenburg
10572	108951	Toolexpert Benelux BV	Toolstation Europe Ltd.	Bleiswijk
10573	108953	Hotze GmbH & Co.KG	Baustoffe Leese	Leese
10574	108954	Possling GmbH & Co.KG		Berlin
10575	108958	Möbius Diamanttechnik		Diesbar-Seußlitz
10576	108963	Technical Supplies Int.Co. LLC		Sohar, Sultanate of Oman
10577	108965	Rothkegel Baufachhandel	Wittenberg GmbH	Jüterbog
10578	108975	Cord Jürgen Bruns		Wardenburg
10579	108976	Kentec Tool Hire	Unit 2 Riverdale Estate	Tonbridge, Kent
10580	108978	Stanze & Kuhlmann GmbH		Peine
10581	108980	MSR Bauzentrum Berka		Berka
10582	108981	Andre Köhler	Werkzeughandel + Schärfdienst	Erfweiler
10583	108982	Wocken Industriepartner	GmbH & Co.KG	Emden
10584	108984	Stockbrink & Offermanns GmbH	Werkzeuge & Maschinen	Niederkrüchten
10585	108986	BB-Technik s.r.o.		Banská Bystrica
10586	108987	Essex Fasteners	Division of Orbital H.S. Ltd.	Wickford, Essex
10587	108989	UNION Bauzentrum HORNBACH GmbH		Kapellen-Drusweiler
10588	108990	Schachenmeier GmbH		Efringen-Kirchen
10589	108998	Staufen Baumaschinen GmbH		Göppingen
10590	109000	Bell Tools		Gloucester
10591	109001	Krapp Eisen GmbH & Co.KG		Aurich Sandhorst
10592	109002	Krapp Eisen GmbH & Co.KG		Westerstede
10593	109015	Stephan Heinitz		Kleinheubach
10594	109017	Schultz Bauzentrum GmbH & Co. KG		Speyer
10595	109022	Bauzentrum Teichmann GmbH		Geithain
10596	109026	Ramset New Zealand		GLENFIELD - AUCKLAND 1330
10597	109028	Steelrex Limited		Moskau
10598	109045	Heß - Hydraulik		Roding
10599	109046	Garms Baustoffe GmbH & Co.KG		Dötlingen-Aschenstedt
10600	109051	Garms Baustoffe GmbH & Co.KG		Ganderkesee
10601	109053	MP Building Supplies Co Ltd.	Rail Arch	Bethnal Green, London
10602	109054	Wilhelm Siemsen GmbH & Co.KG		Schleswig
10603	109055	Bauzentrum Gebr. Löffler GmbH		Reinsdorf b. Zwickau
10604	109058	VON DER HEYDT GMBH		Speyer
10605	109065	BAUKING Weser-Ems GmbH	Niederlassung Quakenbrück	Quakenbrück
10606	109066	Raiffeisenhandelsgesellschaft	Strasburg m.b.H.	Strasburg
10607	109069	E.D.Elson Ltd.	Builders & Timber Merchants	St. Albans
10608	109071	Wilhelm Kruel e.K.	Autoteile - Industriebedarf	Idar-Oberstein
10609	109074	Fourmost Fixing Ltd.		Rochester
10610	109078	Werkzeug Nord		Rhauderfehn
10611	109080	ERIKS Deutschland GmbH		Bielefeld
10612	109084	Zeppelin Rental GmbH & Co.KG	Mietstation Rostock West	Rostock
10613	109085	Zeppelin Rental GmbH & Co.KG	Mietstation Greifswald	Greifswald
10614	109087	Zeppelin Rental GmbH		Neubrandenburg
10615	109088	Martin Bauservice Ltd.		Sinn Fleisbach
10616	109089	Chas. Lowe & Sons	(Builders Merchant) Ltd	Knebworth, Herts.
10617	109091	Heinrich Deeken	Eisenwaren Baubeschläge Werkzeuge	Cloppenburg
10618	109093	Fixings Tyne Tees	Fixings Group	Hartlepool
10619	109094	Bury Fixings Group	Premier House, Telford Way	Colchester, Essex
10620	109095	Breur Ijzerhandel Gouda B.V.		Moordrecht
10621	109102	MCP Group Ltd.		Northfield, Aberdeen
10622	109105	Armagrip	Advance House	Ferryhill, Co Durham
10623	109107	FEGA & Schmitt Elektrogroßhandel	GmbH	Ansbach
10624	109108	Baugema Baumaschinen GmbH		Rostock-Pastow
10625	109110	Bison Industrial Limited		Botley
10626	109112	Handelshof Bautzen GmbH	Filiale Görlitz	Görlitz
10627	109113	Handelshof Bitterfeld GmbH		Halle
10628	109114	Handelshof Chemnitz GmbH	Partner für Technik	Chemnitz
10629	109115	Handelshof Riesa GmbH	Filiale Döbeln	Döbeln
10630	109116	Handelshof Riesa GmbH		Dresden
10631	109117	Handelshof Riesa GmbH	Filiale Großenhain	Großenhain
10632	109118	Handelshof Riesa GmbH	Partner für Technik	Oschatz
10633	109119	Handelshof Stendal GmbH		Pritzwalk
10634	109120	Handelshof Vorpommern GmbH		Greifswald
10635	109121	Handelshof Vorpommern GmbH	Filiale Stralsund	Stralsund
10636	109122	Rudolf Sievers GmbH	Partner für Technik	Buxtehude
10637	109123	Rudolf Sievers GmbH	Partner für Technik	Hamburg-Eidelstedt
10638	109124	Formed Group Ltd.	Unit 2 Crofton Road	Lincoln
10639	109127	Finlex International Ltd	Bunkell Road	Norwich
10640	109135	bhv quattro	die passende Lösung	Saarbrücken
10641	109137	Karl-Hermann Eichfelder		Bamberg
10642	109138	i & M Mietservice &	Containerdienst GmbH & Co.KG	Simmerath
10643	109141	Dröge + Leifert GmbH & Co.KG		Werl
10644	109143	Gerwens Fachcenter GmbH		Gronau
10645	109145	Fidel Schub GmbH & Co.KG		Viechtach
10646	109148	Weber Stahlhandel GmbH		Bad Kreuznach
10647	109149	Millcot Tools	The Mill	Danbury, Essex
10648	109151	Fixmart		Kent
10649	109153	Welfix		Shrewsbury
10650	109163	BHG Handelszentren GmbH		Luckau
10651	109166	Fixfirm		Lincoln
10652	109167	Handwerks- u. Industriebedarf GmbH		Schwarzheide
10653	109169	Henrich Baustoffzentrum		Kastellaun
10654	109171	Fixfast Ltd.	Teal House, 23A Greenbank Ind. Est.	Co Down Northern Ireland
10655	109173	Search Workshop Supplies LTD		Londonderry
10656	109177	Dörfelt GmbH		Zwickau
10657	109178	Joachim Kaltwasser	Montagetechnik	Nordhausen
10658	109179	Bison Machinery Ltd.		Stafford
10659	109182	SANPROFI	Fliesen-Sanitärfachhandel	Saalfeld
10660	109183	OOMS IJzerwaren NV		BALEN
10661	109185	Stabilo-Wetterauer GmbH		Sinsheim
10662	109186	Asamco CV		Bornem
10663	109188	Iliaens NV		Alken
10664	109191	Galler Metalen NV		Antwerpen
10665	109192	Baustoffzentrum Modernes Bauen GmbH	Oelsitz	Riesa
10666	109193	ERIKS NV		Mol
10667	109194	De Draaiboom Gereedschappen NV		Antwerpen
10668	109199	Mapeco Wommelgem N.V.		Wommelgem
10669	109200	Zeppelin Rental GmbH	Mietstation Magdeburg	Magdeburg
10670	109201	Stahlwille	Eduard Wille GmbH & Co.KG	Wuppertal
10671	109202	VAN SPIJK B.V.		Oirschot
10672	109205	Ets JEAN LOBET sprl		Marche-en-Famenne
10673	109206	Baufachzentrum Wittenberge	Zwgndl.d.Baufachz.Falkenhagen GmbH	Wittenberge
10674	109207	H. Rießelmann GmbH		Molbergen
10675	109209	Saxonia Baustoffe GmbH	c/o Raab Karcher Baustoffe GmbH	Magdeburg
10676	109210	ITT-Bulgaria LLC		Stara Zagora
10677	109211	BV DEMA-SHOP	Declerco Marc N.V.	Roeselare
10678	109216	NV Gebroeders Van Den Abbeele		Lokeren
10679	109220	REWORKS bvba		Peer
10680	109221	Jacob Sönnichsen AG	Baustoffe	Pasewalk
10681	109225	E.I.S. PVH GmbH & Co. KG		Köln-Ossendorf
10682	109228	Steenhoff Baugeräte GmbH & Co. KG		Rhauderfehn
10683	109230	Beoman Oy		Espoo
10684	109232	De Kinder Hardware BVBA		Buggenhout
10685	109237	Unimet Zentrallager Süd	GmbH & Co. Handels KG	Burgthann / Ezelsdorf
10686	109238	EKV-Nord GmbH & Co.KG		Nordhorn
10687	109239	Bau-Maschinen und - Geräte GmbH	Ing. Herbert Dressler	Güstrow
10688	109243	Selkent Fastenings Ltd.	Osprey House	Orpington, London
10689	109244	THEUNISSEN N.V.		GENK
10690	109246	Ruhland-Kallenborn & Co. GmbH	Baustoffhandel	Gersheim
10691	109248	PWP Industrial	Jaguar House	Bedford
10692	109250	MOORS N.V.		Hasselt
10693	109253	Top Gun Tools & Fixings	Trident Business Park	Blackpool
10694	109255	LIETAR OUTILLAGE SA	SA LIMA PROJECTS	La Louvière
10695	109258	Brans Gereedschappen		Lommel
10696	109259	SA Etablissements Jean Collas		Büllingen
10697	109266	GROCO C.V.B.A.		LOCHRISTI
10698	109270	Gillet Baumarkt GmbH	Fil. Herxheim	Herxheim
10699	109276	Wilkhas nv		GRIMBERGEN (BEIGEM)
10700	109277	Frank Rieger	DIAMANT am BAU	Hamburg
10701	109278	VSA Belgium NV		Geel
10702	109281	Bau- & Handwerkerbedarf GmbH		Weyhe
10703	109285	Bauexpert GmbH & Co. KG		Babenhausen
10704	109291	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Bamberg
10705	109295	Seven Day Tools	Abercynon	Mid Glam , South Wales
10706	109300	Otto Röhrs GmbH	NL Soltau	Soltau
10707	109301	Karch Maschinen- und Befestigungs-	technik GbR	Dietfurt
10708	109303	RS Machine Tools	DenmoreIndustrial Estate	Aberdeen , Scotland
10709	109305	Pro-Fix CP Ltd.		Horley, Surrey
10710	109306	Compania Distribuidora de Pernos	y Afines S.R.L.	La Molina, Lima
10711	109307	NV Maldoy		SINT KATELIJNE WAVER
10712	109308	Ruf Baustoffe GmbH	Beton und Fertigbau	Wilburgstetten
10713	109310	Synergy	Electrical & Mechanical Products	Hoddeston
10714	109312	Jakob Küng AG	Befestigungstechnik	Bad Ragaz
10715	109313	Neo-Select A/S	Postboks 45	Lierskogen
10716	109314	E. G. Kistenmacher GmbH & Co. KG		Hamburg
10717	109320	Emmson Supplies Ltd.		Staffordshire
10718	109321	Diatech Scotland	Apex House	Perth
10719	109323	Brockhaus Baubedarf GbmH		Rheda-Wiedenbrück
10720	109325	MAG 45 B.V.		Eindhoven
10721	109327	PELZER TOOLS SA	Werkzeug & Zubehör	Eupen
10722	109329	Normteile Ehret GmbH	KFZ-Werkzeuge	Breisach
10723	109330	Otto Röhrs GmbH	NL Verden/Aller	Verden
10724	109331	Toolfix Joinery & Construction	Supplies Limited	Peterborough, Cambridgeshire
10725	109332	AES Industrial Supplies Limited		Didcot
10726	109334	STARK Building Materials UK Ltd	Binley Business Park,Merchant House	Coventry
10727	109336	HTI Thüringen Handel KG	Fachgroßhandel	Erfurt
10728	109337	HTI Thüringen Handel KG	Niederlassung Mossbach	Triptis
10729	109338	Hopster Bau GmbH & Co.KG		Fürstenau
10730	109341	Baumaschinen und Geräte-	vermietung OHG	Groß Lüdershagen
10731	109342	Wilhelm Stark	Baustoffe GmbH	Tuttlingen
10732	109343	Westendorf & Oppermann	Tessiner Baustoffhandel GmbH	Tessin
10733	109345	DESAIR N.V. GEREEDSCHAPPEN		OVERPELT
10734	109346	Wertheimer Betonfertigteile GmbH	Baustoffe	Baden-Baden
10735	109347	Kraft Baustoffe GmbH		München
10736	109348	Voskamp Bouw en Industrie B.V.		Apeldoorn
10737	109350	GefA Stahl- und Metallbau GmbH		Wilhelmshaven
10738	109353	MARCO BV		Herselt
10739	109356	WS-Norm	Inh. Ralph Brüderlein	Georgensgmünd
10740	109357	Ernst Blanke Baustoffe GmbH & CoKG		Wunstorf
10741	109359	Schneider & Rüseler	Technischer Handel GmbH	Hagen
10742	109362	AGO Druckluft MVS GmbH		Berlin
10743	109371	Ehning Baustoffhandel GmbH		Borken-Weseke
10744	109373	KOCKELBERGH NV	GEREEDSCHAPPEN	TEMSE
10745	109377	Lerou ijzerwaren N.V.		BRUGGE
10746	109378	Toolspot BVBA	Celine Dewulf	OOSTENDE
10747	109381	EWM Menschel GmbH		Gifhorn
10748	109382	WE-Di-Ma	Inh. Olaf Braunsdorf	Riesa
10749	109383	MietTeufel		Oldenburg
10750	109384	C. u. D. Bargen	Holz u. Baustoff GmbH	Jever
10751	109386	Jacob Sönnichsen AG	Baustoffe	Kölpinsee
10752	109388	Hornbach Union Bauzentrum		Baumholder
10753	109390	Tornado Fixings Ltd.	c/o Woodside Ind. Estate	Ballymena, Co Antrim
10754	109400	RuW Industriebedarf oHG		Köln
10755	109401	Van den Broeck-Beenckens NV	tav. Rob Adams	Herenthout
10756	109402	Handelshof Stendal GmbH	Partner für Technik	Magdeburg
10757	109411	Karl Sommer	Maschinen & Werkzeug Fachhandel	Söchau
10758	109412	Manfred Papperitz	Werkzeug und Industriebedarf	Bannewitz
10759	109414	Schmahl GmbH	Eisenwaren - Werkzeuge	Koblenz
10760	109416	HBS Technische Groothandel B.V.		DIEMEN
10761	109417	Frank Papperitz	Industrievertretungen	Pirna
10762	109418	Benz GmbH & Co.KG	Baustoffe	Neckarbischofsheim
10763	109419	HWV	Werkzeugvertrieb Hamburg GmbH	Hamburg
10764	109425	ITS Fischer UG		Parchim
10765	109427	Baufachmarkt Bracher GmbH & Co. KG		Monheim
10766	109428	Gebrüder Löffler GmbH Baustoffe	Filiale Petersberg	Petersberg
10767	109430	Gebr. Schweder Baustoffhandels GbR		Plau am See
10768	109432	Lorenz Innecken	Eisenwaren - Werkzeuge - Beschläge	Wismar
10769	109434	Böhm GmbH Brandenburg & Co.	Fliesen- und Baustoffhandel KG	Kloster Lehnin OT Rietz
10770	109436	Otto Röhrs GmbH		Sottrum-Hassendorf
10771	109437	Einkaufsbüro Deutscher      CIRCUM	Eisenhändler GmbH	Wuppertal
10867	109663	SGBD Deutschland GmbH	NL Raab Karcher	Bingen Sponsheim
10772	109438	City Tool Hire Ltd.	Laurie Bedford 020 8574 3523	Southall, Middlesex
10773	109442	Stang GmbH & Co. KG		Miesbach
10774	109446	Meier Baustoffe GmbH		Amberg
10775	109447	SRL QUINCAILLERIE DENIS		Saint-Ghislain
10776	109450	Hogenhout Bouw Service		Badhoevedorp
10777	109451	A WIJNANT NV		Geraardsbergen
10778	109458	Direct Tool Company	Castle Hill Farm	Southampton, Hampshire
10779	109459	Toolman Yardley		Yardley, Birmingham
10780	109461	ASK Kloska GmbH	Techn. Ausrüster/Arbeitsschutz	Wilhelmshaven
10781	109462	Zeppelin Rental GmbH & Co.KG	Shop Lübeck	Lübeck
10782	109463	Woodcraft 82		Pyle, NR Bridgend
10783	109472	Bruno Heinen AG		Bütgenbach
10784	109473	Zeppelin Rental GmbH & Co.KG	Shop Wuppertal	Wuppertal
10785	109480	Diamond Direct Supplies		Gravesend, Kent
10786	109481	Stabilo GmbH		Empfingen
10787	109482	BMF HOLLAND b.v.		OOSTERHOUT
10788	109485	Outillage Nourisson Claude	RISS	Montbrison Cedex
10789	109488	Lauer GmbH		Herbrechtingen
10790	109498	BBT	Bohr-+ Befestigungssysteme AG	Bösingen
10791	109500	MBB Hensch + Spindler GmbH		Göppingen-Ursenwang
10792	109503	NL Raab Karcher Che.-Röhrsdorf	STARK Deutschland GmbH	Chemnitz Röhrsdorf
10793	109505	Toolexpert OY		Helsinki
10794	109512	Aichinger GmbH		A-Pasching
10795	109515	ERIKS bv		Rotterdam
10796	109518	Zeppelin Rental GmbH & Co.KG	PROFI-BauSHOP Dortmund	Dortmund
10797	109519	Tukkumyynti Mikko Keskinen OY		Tuuri   FINLAND
10798	109522	Handelsonderneming	P.Visser en Zonen B.V.	Raamsdonksveer
10799	109524	Dymatec Ltd.		Houghton Regis,Bedfordshire
10800	109526	Elektro Lörler GmbH		Mainz
10801	109531	Blumenstock	Inh. W. Joas e.K.	Fellbach-Schmiden
10802	109533	Frantos GmbH & Co. KG		Heubach
10803	109536	Weldi		Wyry (Katowice) POLEN
10804	109539	Jacob Cement Baustoffe		Harrislee
10805	109540	Reifenberg Service verbindet e.K.		Hüblingen
10806	109542	Seiler Baustoffhandel GmbH		Thonhausen
10807	109545	Rothkegel Baufachhandel	Wittenberg GmbH	Luth. Wittenberg
10808	109548	Prinz Deutschland GmbH	Maschinen und Werkzeuge	Haselbachtal
10809	109549	Thomschke Baumaschinen		Pulsnitz
10810	109550	StaBe Baubedarf		Anger
10811	109551	A. Leymann GmbH & Co		Porta Westfalica
10812	109552	Carl-Arnold Brill GmbH	c/o Hild- Löbbecke GmbH	Bottrop-Kirchhellen
10813	109553	Armafix Ltd.	Units 3-4	Leeds
10814	109555	August Büssing GmbH		Emstek
10815	109557	Palmaers Vakhandel NV		Bilzen
10816	109559	Kraft Baustoffe GmbH	NL Höhenkirchen	Höhenkirchen
10817	109562	Precisia Metior s.r.o.		Mohelnice
10818	109567	Thurrock Engineering Supplies LTD	Unit 1,	Grays, Essex
10819	109569	TrendHaus	Reiner Bromm	Brackenheim
10820	109571	MÜLLER & CO.	Werkzeug-Handelsgesellschaft mbH	REMSCHEID
10821	109572	NG Werkzeughandel GmbH		Neuss
10822	109573	E/D/E GmbH	Fachkreis Baugeräte	Wuppertal
10823	109574	Eredi Franchi - Idea3 SRL		Pasiano di Pordenone (PN)
10824	109575	RBB Baustoffe & Baumaschinen GmbH		Dresden
10825	109578	Bernd Stünn GmbH & Co. KG	Baustoffhandel	Herdorf/Sieg
10826	109584	Der Schraubenladen	Inh. Margarete Schulz e.K.	VS-Villingen
10827	109585	Castle Brooke Tools (UK) Ltd.		Sheffield
10828	109587	Marks GmbH & Co.KG		Schleswig
10829	109588	Theisen + Kahl OHG	Oberflächen Partner	Andernach
10830	109590	Zeppelin Rental GmbH & Co.KG	Zentrale - Profi Baushop	Garching
10831	109591	Kraft Baustoffe GmbH	NL Wolfratshausen	Höhenkirchen
10832	109592	RHG Mittelsachsen eG	RHG Baustoffe	Rossau
10833	109595	Baufachhandel Podlaha		Großschirma
10834	109599	Matuszyk Wies?aw Eugeniusz		Wien
10835	109600	Kammer & C SRL		Vimodrone, Italy
10836	109601	PRO - LINE S.A.		Petange
10837	109603	Gebr. Fürstenberg GmbH	NL Friesack	Friesack
10838	109605	J&M Supplies & Construction LTD	Unit 3	Crayford, Kent
10839	109610	MICHEL	Schweisstechnik- Technische Gase	Bad Frankenhausen - OT Ringleb
10840	109612	Wizner Building & Fencing Supp Ltd		Kibbutz Usha ISRAEL
10841	109615	SIGF Wolverhampton		Wolverhampton, West Midlands
10842	109618	Baumaschinen van der Walle GmbH		Bocholt
10843	109621	Freeway Tools and Fixings Ltd.		Burgess Hill, West Sussex
10844	109622	Zentraleinkauf Baubedarf	ZEB GmbH & Co KG	Paderborn
10845	109624	Meier Baustoffe GmbH		Lauf a.d. Pegnitz
10846	109625	Meier Baustoffe GmbH		Schnaittenbach
10847	109626	Meier Baustoffe GmbH		Sulzbach-Rosenberg
10848	109627	bauXpert GmbH		Bad Bramstedt
10849	109630	Dullaert-Steenhout BVBA		Ninove
10850	109631	Eurobaustoff Handelsges.mbH & Co.KG	Einkauf Regional Ost	Petersberg OT Wallwitz
10851	109632	Nüßing GmbH	Niederlassung Berlin	Berlin
10852	109635	Meier Baustoffe GmbH		Weiden
10853	109640	Bauzentrum	Wiek & Co.GmbH	Erwitte
10854	109641	Meier Baustoffe GmbH		Neumarkt
10855	109643	HEKA THOMAS HENTSCHEL		Crimmitschau
10856	109645	MKT Metall-Kunststoff-Technik	GmbH & Co. KG	Weilerbach
10857	109646	TWH Trierer Werkzeughandel GmbH		Trier
10858	109647	Smiths Equipment Hire Ltd		Avroe Crescent,Blackpool
10859	109648	Zeppelin Rental GmbH & Co.KG	Shop Hamburg-Harburg	Hamburg
10860	109650	F. X. Ruch KG		Stühlingen
10861	109653	Union Bauzentrum Hornbach GmbH		Merzig
10862	109656	Rite-Fix Ltd.	Unit 29,  Highlands Road	Solihull
10863	109657	Schneebecke & Dorn + Co. GmbH		Kolbermoor
10864	109658	Witschel GmbH	Baustoffhandel	Großenhain
10865	109659	Lapwing UK Ltd	Unit 3	Pershore
10866	109661	ETACO	ENG. AND TRADING COMP.	6 OF OCTOBER CITY-GIZA EGYPT
11716	150703	Kinker GmbH		Peiting
10868	109664	Klaassen GmbH		Uplengen-Hollen
10869	109667	Zeppelin Rental GmbH & Co.KG		Stuttgart
10870	109674	Wilhelm Gienger KG	Fachgroßhandel für Haustechnik	Tiefenbach
10871	109675	Hans Bohner GmbH & Co.Kg	Eisen- und Sanitärgroßhandel	Oettingen i.Bay.
10872	109678	BBS Matthias Landgraf		Dresden
10873	109682	Maier + Kaufmann GmbH		Offenburg
10874	109684	Issler + Pütz		Grenzach-Wyhlen
10875	109688	Mesatec S. Meerpohl	Werkzeug- & Maschinenhandel	Friesoythe-Kampe
10876	109692	Peter Herr	Werkzeuge & Maschinen	Baden-Baden
10877	109697	Lahrmann tech. Handel	GmbH & Co.KG	Dinklage
10878	109701	Lampfix		Hertfordshire
10879	109702	Zeppelin Rental GmbH	miete.chemnitz-roehrsdorf(at)	Chemnitz-Röhrsdorf
10880	109703	Thomas Bührmann	Allgemeiner Handel und Vertrieb	Bakum
10881	109706	Union Bauzentrum Hornbach GmbH		Losheim
10882	109707	Handelskontor Seevetal GmbH	Partner für Technik	Seevetal-Maschen
10883	109708	RSW Handels GmbH	LIMITED LIABILITY COMPANIES	Bautzen
10884	109710	Strut Direct Ltd.		West Midlands
10885	109713	Huis A. Suys IJzerwaren		Menen-Lauwe
10886	109714	Wassink b.v.		VAASSEN
10887	109716	Och GmbH		Nürnberg
10888	109722	Andreas Galler	Diamanttechnik & Spezialwerkz.	Waldhufen / OT Jänkendorf
10889	109723	wolfcraft SK s.r.o.		MALÉ DVORNÍKY
10890	109724	Holzzentrum Wöhlk Cottbus	GmbH & Co. KG	Cottbus
10891	109725	Alliance Fixings Systems Ltd.	Unit 6D Glover Ind. Estate	Washington, Tyne & Wear
10892	109726	Erika Luxem Handelsgesellschaft	mbH	Elsenfeld
10893	109731	Powers Peruana SAC	RUC 20511082219	Lima
10894	109733	TOX-Dübel Technik GmbH		Krauchenwies-Ablach
10895	109735	Channel Commercials PLC		Kent
10896	109739	Diaquip		Bredbury, Stockport
10897	109740	W & F Baustudio	Wilken & Fedtke OHG	Güstrow
10898	109743	Suffolk Fasteners UK	Unit 38	Ipswich, Suffolk
10899	109747	Riverside Hardware & Eng. Supplies	Unit 3c North Road	Bridgend
10900	109749	BAUKING Weser-Ems GmbH	Niederlassung Natrup-Hagen	Natrup-Hagen
10901	109750	GEN NEXT TOOLS		Mumbai
10902	109753	Lehmeier Sandra e.K.	Baumaschinen	Ludwigshafen
10903	109755	Blank & Seegers KG		Nohra
10904	109756	De Bouwhof B.V.		Zoetermeer
10905	109757	Direct Building Products Ltd.		Bradford
10906	109758	Technical Fixings Solutions LTD	Unit E2, LOC8 Business Park	Hollingbourne, Kent
10907	109759	Landmaxx BHG GmbH		Radebeul
10908	109761	Bau- & Kommunalservice Wegner		Waren
10909	109765	Oßwald Fahrzeugteile & Technischer	Handel GmbH & Co. KG	Mühlhausen
10910	109766	SPIT SAS	Division RED HEAD	PARIS
10911	109768	FERRINET SAS		Santafe do Bogota, DC Bogota
10912	109772	OBAS UK	Chappel Hill Ind. Estate	Preston, Longridge
10913	109774	Sheffield Windows		Sheffield
10914	109776	Mawill S.a.r.l.		Diekirch
10915	109781	Zimmer & Söhne GmbH		Erkelenz
10916	109782	Leitermann GmbH & Co.	Fachmarkt KG Niederl. Glauchau	Remse / OT Weidensdorf
10917	109783	Deuschle Industriebedarf GmbH	Partner für Industrie & Gewerbe	Uhingen
10918	109788	Handelshof Riesa GmbH	Partner für Technik	Meißen
10919	109791	SUALPE                  TRYUN BRAND	Suministros Alonso Pellicer, S.L.	Madrid
10920	109793	Franklin Industrial Supplies Ltd.	Unit 11	Kings Lynn, Norfolk
10921	109794	Schneider	Handelsvertretung	Pyrbaum-Seligenporten
10922	109795	Onesite	Unit 9, South Lowerstoft Ind. Est.	Lowerstoft, Suffolk
10923	109796	Mobau Wirtz & Classen	Baufachhandel GMbH & Co.KG	Hückelhoven
10924	109801	KraSaTec GmbH		Oettersdorf
10925	109802	ZEUS Zentrale für Einkauf u.	Service GmbH & Co.KG	Soltau
10926	109805	Specht Betriebsausstattung GmbH		Rotenburg ( Wümme)
10927	109809	EGU Elektro Großhandels Union	Rhein-Ruhr GmbH & Co.KG	Dortmund
10928	109811	Alpha Wholesale	Orchard Business Park	Tonbridge, Kent
10929	109813	Austinat Werkstattbedarf		Rudolstadt
10930	109815	Unimet Zentrallager West	GmbH & Co. Handels-KG	Hachenburg
10931	109816	Makita Africa	Zone Franche Logistique Port Tanger	wilaya de Tanger
10932	109820	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Bindlach
10933	109821	Müller + Schnigge		Schleiden-Gemünd
10934	109823	U.K. Fixings Limited	Unit 5-6	Sheffield
10935	109824	Sandach Befestigungstechnik GmbH		Essen
10936	109826	Jepsen Handel e.K.		Flensburg
10937	109827	Eelen BV		Kasterlee
10938	109828	Wack Builders Wholesale LTD		Cramlington,Northumberland
10939	109829	Wocken Industriepartner	GmbH & Co. KG	Braunschweig
10940	109830	Bau- & Brennstoffe Bender	Inh. Echard Bender e.K.	Morsbach
10941	109831	BMG Baustoffe		Coburg
10942	109835	NV SERCOMAT		Arendonk
10943	109839	RAAHEN PULTTI OY		Raahe
10944	109840	Baustoff Netzband GmbH		Genthin
10945	109842	HEPT Co., LTD		Nowon-gu, Seoul
10946	109846	Maier + Kaufmann		Lahr
10947	109848	Schröder Bauzentrum GmbH & Co.KG		Itzehoe
10948	109852	Kajaanin Konekymppi		Kajaani
10949	109855	Union Bauzentrum Hornbach GmbH		Landstuhl
10950	109857	Internet Logistical Solutions Ltd	Little Bramleys	East Sussex
10951	109859	Gebr. Mayer GmbH & Co.KG	Niederlassung Sachsen	Chemnitz
10952	109863	Technischer Handel	Raymund Pfeiffer	Leipzig
10953	109868	Beate Schaitanow		Markkleberg
10954	109875	Hans Bohner GmbH & Co.	Eisengroßhandel	Treuchtlingen
10955	109876	Norbert Förster	Betreutes Bohren	Dinkelsbühl
10956	109879	SIG Fixings Leeds		Leeds, West Yorkshire
10957	109883	Veens Techniek B.V.		Druten
10958	109890	VD Gereedschappen		Zwalm
10959	109892	DEG Dach-Fassade-Holz eG	Essen	Essen-Frillendorf
10960	109893	Lahden Työkalupiste Oy	TOOLPOINT	Lahti
10961	109894	Suomen Kiinnikekeskus OY		Pori
10962	109895	Praetner GmbH & Co. Handels-KG		Freising
10963	109899	ZEDEV Einkauf und Service AG	MARKE HELLER	ZÜRICH
10964	109901	Weniger GmbH	Elektrogroßhandel	Cunewalde
10965	109906	SPIRA Baugeräte- und Schalungs-	logistik GmbH	Speyer
10966	109908	Chr. Seraphim (Agencies) LTD	Mr. Chrysostomos Chrysostomou	Alambra Cyprus
10967	109909	Siebels GmbH & Co. KG		Norden
10968	109912	Martin Palme (Privat)	The Winnetka Unit 5B	Bangkok
10969	109915	PTG Präzisionstechnik	Handelsgesellschaft mbH	Hagen
10970	109917	CID Group	CID House,Peckfield Business Park	Leeds
10971	109919	John Murphy (Castlerea) Ltd	IDA Business Park	Castlerea, Co. Roscommon
10972	109920	Novasolv Ltd		Loughgall
10973	109924	GS-TOOLS	Elektrowerkzeuge u. Industriebedarf	Dresden
10974	109925	Power Tool Warehouse		Royton, Oldham
10975	109926	Gebr. Fürstenberg GmbH	Niederlassung Rhinow	Rhinow
10976	109927	Schrauben Seidel	Inh. Steffen Seidel	Schönheide
10977	109930	W&S Werkzeug und Schrauben GmbH		Rödermark
10978	109932	ITA Overseas Pte Ltd		Singapore 408938
10979	109935	Straufhainer Schraubenhandel	Petri GmbH	Straufhain
10980	109937	SteelRex Georgia LLC		Tbilisi Georgia
10981	109938	Raiffeisen-Handelsgenossenschaft	Mittelsachsen eG	Leisnig
10982	109941	Dachdecker-Einkauf Ost eG	Zentrale	Braunschweig
10983	109942	Dachdecker-Einkauf Braunschweig		Braunschweig
10984	109944	Achenbach & Gauer GmbH		Rockenhausen
10985	109947	AVANTI Svenska försäljnings AB	Mats Ahlberg	Vallentuna
10986	109948	Venanz Fischer Baustoffzentrum	Inh. Alois Fischer e.K.	Kronach-Friesen
10987	109950	SCP Building Products Ltd.		Totnes, Devon
10988	109951	OWI Sargans AG	c/o Stierlin AG	Schaffhausen
10989	109955	Rothenburger Bauzentrum Pehl GmbH		Rothenburg o.d.T.
10990	109958	ZEDACH eG		Hamm-Rhynern
10991	109962	Eder GmbH	Profi Fachmarkt	Bad Endorf
10992	109963	Profi-Eder Fachmarkt		Wasserburg
10993	109964	Theo Förch GmbH & Co. KG		Schwerin
10994	109967	JIT Industrial Consumables	Unit 5, Manorcrest Court	Lincolnshire (GB)
10995	109970	Dachdecker- und Baustoff-Eink.	Zweigniederlassung Fehrbellin	Fehrbellin
10996	109971	Joachim Hochberger	Maschinen u. Werkzeuge	Bad Endorf
10997	109972	Toolstation (Redditch) Ltd	Arrow 3, Arrow Valley	Redditch
10998	109975	Express Fixings & Fittings Ltd.	Unit 32k & 33k	Isle of Man
10999	109978	CMS Consumables Ltd.	29 St. George Hill	Perranport, Cornwall
11000	109979	INTERNATIONAL GROUP AP SUALPE	MÖVE-DÜBEL  phone: 34 676 360612	Madrid
11001	109980	Nordwest Handel AG	Lager Promat	Dortmund
11002	109982	Müller & Schnigge OHG		Jüterbog
11003	109985	Fixings Plus		Aston, Birmingham
11004	109986	V.J. Technology Ltd.- VJT BRAND	Technology House	Ashford, Kent
11005	109987	Gustav Herbstreuter GmbH & Co. KG		Simmern (Hunsrück)
11006	109988	HOBTEC Industrievertretungen	Inh. Frank Hoberg	Bremen
11007	109990	Wiedemann GmbH & Co.KG		Sarstedt
11008	109994	VOS TOOLS BVBA		Brecht
11009	109996	KGS Winter GmbH		Dortmund
11010	109998	DE IJZERWINKEL		Aarschot
11011	109999	TCG Allgemein Intern	Samira Merino	Dinklage
11012	120001	DEWITT TOOL CO INC		Miami
11013	150000	Quimica Peruana sac	Ruc: 20481388610	Aranjuez, Trujillo
11014	150001	A. Aivazoglou P. Dalaglis A.E.		Thessaloniki
11015	150002	Amanav Marketing Ltd.		San Fernando
11016	150003	A S P	Abrasives & Screw Products Limited	Merseyside, L37 4AQ
11017	150004	ALLMEDIA spol. s. r. o.		Bratislava
11018	150005	Auro - Befestigungssysteme GmbH		Wels
11019	150006	Uždaroji akcin? bendrov? "Anjes?"		Kauno
11020	150007	Abcon Industrial Products Limited	attn. Mr. Paul Gilsenan	Cootehill, Co Cavan
11021	150008	Hirtenfellner GmbH		Premstätten
11022	150009	SAS ALPHA COUPE FRANCE		SCHWEIGHOUSE SUR MODER
11023	150010	AROA, S.A.	Phone 1 809 241-1689	Santiago República Dominicana
11024	150011	Armacell Austria GmbH		Gödersdorf
11025	150012	Gerontis E. & Sons Ltd.		Rhodos
11026	150013	Al Daaem Est.	Hardware Tools	Jeddah 21532
11027	150014	A.V.V. Management BV		VA Gemert
11028	150015	Serracon Limited	DART Tool Group	Kirkcaldy
11029	150016	ANDREAS THEOPHILOU	COMMISSION AGENT	NICOSIA
11030	150017	SERCO	attn. Mr. Hatem El Gamal	Cairo
11031	150018	AURORA	Magdalena Caputa	Paczków
11032	150019	APEX OILFILD SUPPLIES	Tel.: (+20)2-27 04 65 00-2518 04 97	New Maad Cairo, Egypt
11033	150020	Andimar OÜ		Tartu
11034	150021	Ets. TECH Electric		BEIRUT
11035	150022	Ajetikarosserieteile	Arben Ajeti	Mägenwill
11036	150023	High Force	Engineering Solutions Ltd.	Amman
11037	150024	Alrokey For Industrial Marketing	Attn. Nabil	CAIRO
11038	150025	Amos Industries Australia		Parkinson 4115 Brisbane, Queen
11039	150026	Jassim Mohammed Abdulrehman	Al-Bahar Industries W.L.L.	Safat - 13020 Kuwait
11040	150027	Thomas Baumgartner	Meinrad	Bad Mitterndorf
11041	150028	Baccina 2004 s.r.l.		Roma
11042	150029	Bader Maschinen GmbH		Vomp
11043	150030	Bata Trading & Contracting Co.		AMMAN
11044	150031	SASU BATI DIAM	Christophe THIEVENAZ	DOLOMIEU
11045	150032	SIA "B-BALTIC"		Riga
11046	150033	Exacon Group		Broadmeadows VIC 3047
11047	150034	AAP Group Scandinavia AB		LJUNGBY
11048	150035	ABC Tools S.p.A.		Cologno Monzese (Mi)
11049	150036	Borgh B.V.		Almere
11050	150037	Ludwig Bruder	Warenhandel	Wien
11051	150038	Braccio di Ferramenta		Rovigo
11052	150039	Bordo International Pty. Ltd.		Scoresby, Vic. 3179
11053	150040	BD - Werkzeugtechnik AG		ZÜRICH
11054	150041	BO RYUNG TRADING AND	MFG.CO. ,L TD.	SEOUL
11055	150042	LA. BELL. SAS	DI COSTANTINI VIVIANO & C.	POLPET DI PONTE NELLE ALPI (BL
11056	150043	Industrietechnik	Buchhauser GmbH	Voitsberg
11057	150044	Boon Koon Hardwae PTE LTD		Singapore 209520
11058	150045	BOESSO s.n.c. di Masciotta N. &	Colaiacovo E.	ROMA
11059	150046	BTX TOOLS	attn. Mr. Patrice BATOUX	JUZENNECOURT
11060	150047	S.C. EJOT ROMANIA SRL		Bradu, Geamana village distric
11061	150048	BI-Produkter as		Billingstad
11062	150049	Boomerang Tools Inc.		Longueuil  QC  J4G 1L902
11063	150050	Baltic Project Group SIA		Riga
11064	150051	Bratja Petrovi  GmbH		Lowetsch
11065	150052	Blacks Fasteners Limited		Christchurch
11066	150053	BINÉTA KER. SZOLG. BT		Budapest
11067	150054	Antonio Capaldo Spa		Manocalzati/Avellino
11068	150055	Cominvest CZ s.r.o.		Brno - Líše?
11069	150056	Fox & Gunn Limited		Pakuranga, Auckland
11070	150057	CAVEDIL NEW SAS DI V. SALSANO & C.		CAVA DEI TIRRENI
11071	150058	Choy Chan Wah Enterprises Pte.Ltd.	Mr. Choy Meng Chun, Manag.Director	Singapore 914033
11072	150059	D.M.P. STEEL s.r.o.		Bratislava
11073	150060	Lietuvos ir Suomijos uždaroji	akcin? bendrov? "DR?TSRAIGTIS"	Kauno
11074	150061	AB FASTEX FÄSSTTEKNIK		Vinslöv
11075	150062	EUR SECURITY CENTER s.a.s. di	C.Novelli	Roma
11076	150063	D'AMICO S.r.l.	Forniture & Servizi	Roma
11077	150064	EJOT AUSTRIA GmbH & Co. KG		Voitsberg
11078	150065	Cash Ferretero las Quemadas, C.B.		Cordoba
11079	150066	Century Fasteners Limited	Unit D10	DUBLIN
11080	150067	ESAN EXPRESS PERU, S.A.C		Lima
11081	150068	FIME SRL		BELFIORE (VR)
11082	150069	C.C.E.C. Distributors		DUBLIN 22
11083	150070	Foka Saz Choob	Seifi, David	Teheran
11084	150071	Fakhry Hardware & Tools		Beirut
11085	150072	MARIO FORCONI s.n.c.		ROMA
11086	150073	EJOT Benelux bvba		Bornem
11087	150074	ESAN SRL, Bolivia	Contact: Luis Felipe Espinoza Corte	Barrio Nueva Jerusalen UV 0063
11088	150075	EUROPA FERRAMENTA s.r.l.		ROMA
11089	150076	Folkestone Fixings LTD Dyna House		KENT
11090	150077	1001 Dribnytsya LLC		Lviv
11091	150078	EJOT S.A.S.	di EJOT Tecnologie di fissagio S.R.	CAMPODARSEGO (PD)
11092	150079	Coimapor Qjusa , S.L.		Vigo / Ponteverda
11093	150080	J.A.C. Suministros Industriales S.L		Segovia
11094	150081	Eurobit Co. Srl - Tools Group	attn.  Mr. Maggioni	BARZANO (LC)
11095	150082	JUAN FERNANDO GALUSSO PENA	IMPORTACIONES	MONTEVIDEO
11096	150083	SIA "CKM"		Riga
11097	150084	Thürmer Tools ApS.	DANSKE VAERKTOEJ ApS	Gilleleje
11098	150085	J.K. Enterprises	Phone : 91 9820803630	Mumbai 400 055
11099	150086	APOLO FIJACIONES Y HERRAMIENTAS,	S.L.	Castellar del Valles (Barcelon
11100	150087	Ferrometal Oy		Nurmijärvi
11101	150088	GFC Fasters & Consstruction Product		Penrose, Auckland 1061
11102	150089	J-P. Fracheboud AG	FRA-TOOLS	Orpund
11103	150090	Agro Green Investments	Engineering & Agricultural	CAIRO
11104	150091	Ferramenta FE.PI s.a.s.	di F. Piscitelli & S. Romano	Napoli
11105	150092	MetriaTools S.R.L	RNC 131-16286-1	San Francisco de Macorís Provi
11106	150093	Metritools	attn. Mr. Luis Pacheco	GRENOBLE
11107	150094	F.lli di Donato srl.		Marina di Città Sant' Angelo (
11108	150095	UAB DIKTUM		Kaunas
11109	150096	DIMPFLMEIER RAPPRESENTANZE		Roma
11110	150097	Doukas A.E.B.E		Athen
11111	150098	DELVE 2 SIA		RIGA
11112	150099	L'Aquilotto di M. Martini		Roma
11113	150100	LOBOMATIC AB		Helsingborg
11114	150101	LE TOOLS	Emmerich Litzko	Kirchbichl
11115	150102	Lindqvist AS		Bergen
11116	150103	482 LLC		Kyiv
11117	150104	Importadora ECO S.A.,		VALPARAISO,
11118	150105	SAS SA ATELIERS LR ETANCO		LE PECQ
11119	150106	Przedsiebiorstwo Handlowo Uslugowe	ELWIERT	Gdansk
11120	150107	Ferreteria El Barato, S.L.		Cardona Barcelona
11121	150108	Eurimex International	attn. Mr. John Horne	CLEVEDON, SOMERSET
11122	150109	Equipa Quatro Lda	Comércio e construcones Lda.	São Bartolomeu de Messines
11123	150110	Envotec - Umwelt & Sanierung GmbH		Pinkafeld
11124	150111	Maja-L ltd.		JURMALA
11125	150112	PREMIER RENDER SUPPLIES Ltd	Phil Gilpin	LEEDS
11126	150113	Pecol, SA	Sistemas de Fixcao	Agueda
11127	150114	ProMart Oy		Laskutus
11128	150115	Diamond Tech AS		Hamresanden
11129	150116	Palmieri Francesco E Luca S.N.C		Sassari
11130	150117	F A C I  di Cacace e.C.		Roma
11131	150118	Profi-Tool-Center e.U.	Stefan Böckl	Hollabrunn
11132	150119	Phoenix Distribution	Mr. Gerard Jenkins	Finglas Dublin 11
11133	150120	SARL FIX 2 PRO	Fixer - Percer	CHARENTON LE PONT
11134	150121	Festool s.r.o.		Ceská Lípa
11135	150122	Bischetti s.r.l.		ROMA
11136	150123	PROFMET GRUP SRL		Chisinau Moldova
11137	150124	PASSEPARTOUT DI ANDREA BIANCONCINI	E C. S.A.S.	ROMA
11138	150125	Greenmill Supply Company Ltd	attn. Mr. Bruce Miller, Director	Colchester
11139	150126	Güney Hirdavat A.S.		BAGCILAR   ISTANBUL
11140	150127	Gehco Fixing BVBA		Houthalen
11141	150128	RUKU GmbH	Schraubengrosshandel &	Feldbach
11142	150129	Grupo 15, S.L.		Don Benito - Badajoz
11143	150130	Mafisa Oy	Ruuvikeskus	Helsinki
11144	150131	SNC GEFIX SNC		PORTES LES VALENCE
11145	150132	Granidisco, S.L.		Caldas de Reis Ponevedra
11146	150133	Gottfred Petersen AS		Middelfart
11147	150134	S.C. Gross Technik S.R.L.		Bukarest
11148	150135	Evropeiskii Instrument LLC		Bila Cerkva Kiivska Oblast
11149	150136	Mauceri Professional S.R.L		Roma
11150	150137	GES Global Engineering systems	att. Mr. Eng. A. Mansour	CAIRO
11151	150138	Hashahal Trad. House Ltd		Rishon Lezion
11152	150139	Herman Slovakia Production s.r.o.		Kosice
11153	150140	Hausken Tekniske AS		Stavanger
11154	150141	Horváth Csapágy Kft.	Horváth Csaba	Zalaegerszeg
11155	150142	Trent Industrial Supplies Ltd	attn. Mr. Alan Cunningham	Staffordshire
11156	150143	Schrauben Heckele GmbH		Markt Hartmannsdorf
11157	150144	Imcoinsa 1985, S.L.		Abadiño (Bizkaia)
11158	150145	JAATA OÜ		Tallinn
11159	150146	Izzo Domenico		Maddaloni (Caserta)
11160	150147	BE-KA Teknik Hirdavat Dis.	Ticaret ve Sanayi Ltd Sti	Okmeydani - Istanbul
11161	150148	Imexa d.o.o.		Ljubljana
11162	150149	INSTRO  SIA		Riga
11163	150150	Naka Ltda.		Montevideo
11164	150151	ITALCHIAVI s.r.l.		ROMA
11165	150152	Suministros BEYMA, S.L.		LORCA (MURCIA)
11166	150153	Hei Trading Oy	OTV 003728344278	Docuscan
11167	150154	IMCOMINER S.A.S.	John Julian Y Samara Guerrero	CALI - VALLE
11168	150155	Ets. JADIR	attn.: Mr. Serge Jamourian	BEIRUT
11169	150156	Isauro Neves Ferreira, Ltda.		S. Bernardo - Aveiro
11170	150157	Jayce Industries		Jungwon-gu, Seongnam-si, Gyeon
11171	150158	Joma AB		Gnosjö
11172	150159	POE IMPORT	attn. Mr. Lachhar, Manager	Papeete, Tahiti
11173	150160	Industrial Tooling Products (UK) Lt	attn.: Mr. Andy Bagshaw	Chesterfield, Derbyshire
11174	150161	Jaybro Group PTY Ltd.		SEVEN HILLS, NSW 1730
11175	150162	PAESANO ALDO		ROMA
11176	150163	Inter-Prima SRL	Loc. Valea Lupului	Iasi
11177	150164	MK Trade FZE		Ras AL Khaimah
11178	150165	ZUJER TRADING Co. (LLC)	Tel.: +971 4 224 9422	Dubai, U.A.E.
11179	150166	KNO Werkzeughandel GmbH		Kirchbichl
11180	150167	Kamlesh Trading Co. LLC		Dubai
11181	150168	Krebs Baumaterial AG		Hünenberg
11182	150169	KROMAC LAMANNA FRANCESCO s.r.l.		CROTONE
11183	150170	Magi. Adrian Kawan		Stainz
11184	150171	BRADOS LP		Edinburgh
11185	150172	Kress-elektrik Bulgarien GmbH		Lowetsch
11186	150173	OX GROUP UK	Myles Woodcock, R& D Manager	LONDON
11187	150174	Kärkikiinnike Oy		Helsinki
11188	150175	Kale Hirdavat ve Makina A.S.	contact: Mr. Ali Özkara	Edirnekapi-Eyup ISTANBUL
11189	150176	KNIPEX Tools Middle East FZE		Jebel Ali Dubai, U.A.E
11190	150177	HEE Photonics Labs Ltd.		Riga
11191	150178	KNAUF Fibre		Ungersheim
11192	150179	Kiinnike-Kolmio Oy		Tampere
11193	150180	INTEGRATED STORES FOR GENERAL	SUPPLIES	Amman
11194	150181	George Katsafados Ltd	phone No. 00357-22467686	Latsia
11195	150182	La Chiusura S.r.l.		Casapulla (Caserta)
11196	150183	Labor-International B.V.		Ede
11197	150184	Loconsole Michele s.r.l.		Bari
11198	150185	Lekr - Ing. Marián Krsák		Bratislava
11199	150186	LABO EPE		Peristeri/Athen
11200	150187	NorDiaTek AS		Kviteseid
11201	150188	Latina Supply Solutins Company	VAT: 608 030 2886	Bostanci/Kadikoy/Istanbul Tel.
11202	150189	Mitropoulos M.IKE		Patra/GR
11203	150190	GIUSEPPE MALVESTIO		Zero Branco (TV)
11204	150191	Oy Maanterä Ab		Vantaa
11205	150192	Mak Fastener Specialists Ltd	Unit A	Tallaght, Dublin 24
11206	150193	2 M di Ciani Massimo & C. s.a.s.		Todi (Perugia)
11207	150194	Friedrich Marzolf	Technischer Großhandel	Kuchl an der Salzach
11208	150195	V. Meyer A/S		Brøndby
11209	150196	Mijama A/S		Greve
11210	150197	Jordan Medows for Ind. Supplies	Tel +962 6 4767272	Amman
11211	150198	MDM Group Sp.z.o.o.S.k.		Ostrzeszow
11212	150199	PT Multi Baja Fastindo		Tangerang
11213	150200	ARKO LTD.		PATRA
11214	150201	MidWest Ports		Geraldton WA 6530
11215	150202	MAG-KRAK sp.z.o.o.		Krakow
11216	150203	Masonry Hardware PTY. Ltd.		Ringwood, VIC 3134
11217	150204	Mark-Up Tools Ltd	attn. Mr. Sheikh	Strangeways Manchester
11218	150205	K. Mitropoulos EPE		Athen
11219	150206	Mascoutech Inc.		Longueuil, QC J4G 2M1
11220	150207	TH. Methanis & Sia OE		Athen
11221	150208	MAGHIDRA JM EIRL	contact: Mr. Juan Mercedes Esquivel	SANTO DOMINGUITO   TRUJILLO
11222	150209	MCM Construction Materials	Supply Co. Ltd.	N.T., Hong Kong.
11223	150210	Adolf Würth GmbH & Co. KG		Künzelsau
11224	150211	NOVOMET KG Ltd.		SOFIA
11225	150212	Nagy & Nagy Kft.	Zoltán Nagy	Budapest
11226	150213	NOVATOOLS, S.L.		OIARTZUN (GUIPUZCOA)
11227	150214	NOVATOOLS, S.L.		OIARTZUN (GUIPUZCOA)
11228	150215	Nazar K. Al Dilijan& Sons Co.		Dammam 31481
11229	150216	A.D. NIKOLOPOULOI BROS O.E		TAYROS ATHEN
11230	150217	NAREX S.R.O.		Ceska Lipa
11231	150218	Ortner GmbH		Loosdorf/Melk
11232	150219	Oto Oskar Osicka	IMPORT - EXPORT - DISTRIBUTION	TEMICE
11233	150220	Brammer Iberia, S.A.		Galdakao (Bizkaia)
11234	150221	Oil Supply Limited Liability Compan		Baku
11235	150222	Odörfer Haustechnik KG		Graz
11236	150223	Dach Klinkier Grzegorz Kasiura	(Member of Siec Budowlana Trade)	Krapkowice
11237	150224	Przedsi?biorstwo Us?ugowo Handlowe	Marbet Beata Grygorowicz	Opole
11238	150225	Multi-form II Sp. z o.o.	(Member of SIEC BUDOWLANA Trade)	Tychy
11239	150226	Uni-Dach  Kozub Zbigniew, Kozub El?	Spó?ka Jawna	Olkusz
11240	150227	El-Stan Firma Handlowo-Us?ugowa Fro	Stanis?aw	Gryfów ?l?ski
11241	150228	Lubar S. A.	(Member of SIEC BUDOWLANA)	Rybnik
11242	150229	PAOLUCCI GIANCARLO E SANTE	SOCIETA' IN ACCOMANDITA	Roma
11243	150230	K.S.PAPADOPOULOS & CO	? ? ???????????? ??? ??? ?? ||K S P	Thessaloniki / ?????????
11244	150231	A. Papantonopoulos & SIA EE	tel. 2310-722425	THESSALONIKI
11245	150232	Powerluck 8 Pilippines, Inc.		Las Pinas City Philippines
11246	150233	JURMIR J.M.W. Rudzinscy	Sp. Jawna	BRODNICA
11247	150234	KARLI EFSTATHIA		ATHENS
11248	150235	Agila Global Stone, S.L.U.		Murcia
11249	150236	Plieger B.V.		Zaltbommel
11250	150237	Plumbers Choice		Bayswater, Vic 3153
11251	150238	Gienger Spol.s r.o.		Napajedla
11252	150239	GIENGER CENTRON s.r.o.		Praha
11253	150240	GIENGER BOHEMIA, s.r.o.		Otovice
11254	150241	GIENGER Tábor spol. s r.o.		Tábor
11255	150242	GIENGER Granit s.r.o.		Prešov
11256	150243	PechaSan spol.s r.o.		STRAKONICE 1
11257	150244	S.PAPATHEODOSIOU SPAP A.E		ATHEN
11258	150245	RHINOS CO., LTD.	phone: 81 667667770	Osaka 543-0018
11259	150246	REI Tools		Croydon VIC 3136
11260	150247	Repuestos Paniagua, S.A.		Badajoz
11261	150248	Fa. Bauservice Rindler GmbH		Klagenfurt
11262	150249	RB Tools GmbH	Generalvertretung	Au-Wädenswil
11263	150250	RK - HPD e.U.	Richard Kraßnitzer	Zweinitz/Weitensfeld
11264	150251	Rosenstatter Vertriebs GmbH		St. Pantaleon
11265	150252	R.E.I.T.  S.p.A.	attn. Mr. A. Zanon	SAN GIORGIO IN BOSCO (PD)
11266	150253	RAME,S.L.	SUMINISTROS INDUSTRIALES	Cadiz
11267	150254	RAWL FRANCE SA		MITRY MORY CEDEX
11268	150255	OOO "Technotorg"		Krasnojarsk
11269	150256	Sollenberg S.	VERKTYGSAKTIEBOLAG	Hässleholm
11270	150257	SVB BVBA		EL ERP
11271	150258	SPITTEX ITALIA S.R.L.		Bari
11272	150259	Ulemj LLC International Trading	Schüco Office	Ulaanbaatar
11273	150260	SESA TOOLS, S.A.		Hernani (Guipúzcoa)
11274	150261	Soc. It. Commerciale Utensili SpA		Milano
11275	150262	Sibilio S.r.l.		Frattamaggiore (Na)
11276	150263	BV UFTTOOLS - UFTLAS		Deinze
11277	150264	SCANDEX		Kaunas
11278	150265	Suministros Industriales Teymo S.L.		Motril (Granada)
11279	150266	Ali Dawood Al Shamary	Project Manager	Baghdad / Al Karadah
11280	150267	Union Day Limited	Room C	KOWLOON, HONG KONG
11281	150268	Jesus Salamero, S.L.	Ferreteria Salamero	(Monzon) Huesca
11282	150269	TMAX Corporation Co., Ltd.	Attn: Ms Wena Tangthavorn	Wangthonglang Bangkok 10310
11283	150270	Scell-it S.A.S.	attn. Franck DEBRUYNE	LESQUIN
11284	150271	Siu Industry Company Limited	Attn.Mr. Nguyen Caole	Ho Chi Minh City
11285	150272	Soroush / Mr. Abdulla Mohamad	Abdolmonhamad Mob:+ 9647701431996	Sulaimany Kurdistan Iraq
11286	150273	Safe-Entry. co.	Andrew Pearcy	LUTON
11287	150274	KREP-TEHNO		Ekaterinburg City
11288	150275	Santco Trading Inc.	Mr. Shayan Sadeghian	ONTARIO
11289	150276	Sanistal A/S		Silkeborg
11290	150277	Sheffield Group		Cardiff NSW 2285
11291	150278	Karim Al Shamary Store		Baghdad
11292	150279	Trucut		Warkworth 0910 Auckland
11293	150280	PROF. PRAXIS N. V.		Herne
11294	150281	UNITED HARDWARE	attn. Mr. Niall O'Neill	Dublin 24
11295	150282	SCE-SINGFA SDN. BHD.		Kajang Selangor Darul Ehsan
11296	150283	Skagen Trådindustri		Aalborg SV
11297	150284	United Equipment Co.	Eng. Usama Ibrahim A. Moathy	Sarai El Koba CAIRO
11298	150285	Radio Thomas Soder	Elektro u. Fernsehtechnik	Bad Aussee
11299	150286	TFA Solutions Limited	attn.  Mr. Tommy Forest	BRAEHEAD
11300	150287	MB Svajok		Klevines village
11301	150288	SOLMAT Hanusiak sp.k.		Kraków
11302	150289	Simuro Baubedarf AG		Baar
11303	150290	SEDISA	Mr. Gustavo Gaiarin Coronel	SURCO - LIMA 33
11304	150291	KERN-DEUDIAM	Building Hardware & Tools Trading L	DUBAI
11305	150292	Tomisa Herramientas S.L.		Alhaurín de la Torre  - Málaga
11306	150293	Josef Steinberg	Industrie u. Werkstattbedarf	Satteins
11307	150294	SPIRAL Reihs & Co. KG		Wien
11308	150295	INTERCONSULT	di SALICE EMANUELE	TREVISO
11309	150296	Sandtech, Inc.		Morton Grove, Illinois 60053
11310	150297	Ferramenta San Cesareo		San Cesareo (Roma)
11311	150298	Mahle Metal Leve S/A		Mogi Guaçu / SP
11312	150299	StrongArm Drills Inc.		So. San Francisco, CA 94080
11313	150300	SAMAR di Savino Mariangela		Fasano
11314	150301	SWIT		Bangalore
11315	150302	Spojmat	Stanislav Janik	Bratislava
11316	150303	Stemax LLC		Kiev
11317	150304	Stuart Trading as Infinite Bargains		Peterlee, Durham
11318	150305	STS Ltd	attn. Mr. Ryan Lumb	LEEDS
11319	150306	MAJER		Mszana Dolna
11320	150307	ITALIA STYLE SRL		ROMA
11321	150308	TILE EZE, INC.	Abi Michailidis  (FIN 47-2304520)	Naples,Florida 34108-0124
11322	150309	TAKAGI CO., LTD.	THE THIRD DEPARTMENT	NIIGATA
11323	150310	THEOTHRIDIS IOANNIS & SOHN OE	?????????? ??????? ??? ???? ??	Thessaloniki
11324	150311	VINCENT srl		THIENE VI
11325	150312	TOPFAST	Engineering Supplies	Paarden Eiland, Cape Town
11326	150313	TORREGIANI MELE	di Felci Lucilla	VELLETRI
11327	150314	BV Stock Americain G. Vermeersch		Diksmuide
11328	150315	TECNOSTYLE s.a.s.	di Pesce Antonia & c.	Noicattaro (Bari)
11329	150316	VITEKNO di Eraldo Vagnozzi		Teramo
11330	150317	VKP STEEL, s.r.o.		Banska Bystirica
11331	150318	Torgovaya Kompaniya Intek	(Joint stock companie)	Moscow
11332	150319	Torex Handels AG		Villmergen
11333	150320	INVOICE	Arsenal-Stroy Lmt	St. Petersburg
11334	150321	Tecnologías Metal Mecánicas	Avanzadas Limitada	SANTIAGO
11335	150322	VHS Unipessoal, Lda		Touguinho-Vila do Conde
11336	150323	Técniques de Clima i Sanitari, S.L.	CALLE CUBELLES, 7	Barcelona
11337	150324	Teclisa Levante, S.L.U		Paterna
11338	150325	Torgra Mayan, S.L.		Cordoba
11339	150326	Twistfix Ltd., KKM Buildings	attn. David J Chadwick	Portsmouth
11340	150327	Grupo Teclisa Illes Baleares Delega		Palma de Mallorca Islas Balear
11341	150328	TECNO S.R.L.	Ufficio Commerciale	Roma
11342	150329	Guido Hinken	Vertriebsleiter	Nordhorn
11343	150330	David Quinn	QnC Enterprises \\ Team-Tough.com	Canon City Co. 81212
11344	150331	Entegral Endustriyel Urunler San.ve	Tic.Ltd.Sti.	Erenkoy - Kadikoy-?stanbul
11345	150332	G. Vella & Sons Limited		Marsa MRS1912
11346	150333	Vartec S.R.L.		Anagni-Frosinone
11347	150334	VANZO SAS di Vanzo S. & C.		CAMPO SAN MARTINO (PD)
11348	150335	Vorpa s.r.l.		Riccione (FC)
11349	150336	Van Roij Fasteners Europe B.V		Deurne
11350	150337	Schalbau Vitzthum GmbH		Unken
11351	150338	Suministros Industriales Val-Sur, S		Albal (Valencia)
11352	150339	VIX AS		FREDRIKSTAD
11353	150340	Van Roij Fasteners Hungária Kft.		Dunaharaszti
11354	150341	A.EMS	Baumaterial GmbH	Gebenstorf
11355	150342	Industrietechnik Vallant		St. Andrä im Lavanttal
11356	150343	Suministros Industriales Valdeorras		Orense
11357	150344	S. A. S. VACO		MONTBRISON
11358	150345	WILMART SAS		LIBERCOURT
11359	150346	WING ON CHEUNG & CO (S) PTE LTD		Singapore 415928
11360	150347	Widmer AG	Eisenwaren-Werkzeuge	Muellheim TG
11361	150348	Wakai Holdings CO., LTD.		Higashi Osaka City Osaka Pref.
11362	150349	WÜRTH Bulgarien EOOD	????-???????? - ????	German
11363	150350	MAY Fixation Sarl.		Pratz-Préizerdaul
11364	150351	Würth-Portugal	Técnica de Montagem, Lda.	Sintra
11365	150352	Wera Werk s.r.o.		Bystrice nad Pernstejnem
11366	150353	Winkler Schulbedarf GmbH		Karlstetten
11367	150354	WEKO Tools Kft.		Vác
11368	150355	WENO Technika Mocowa? Czaika Sp.k.		RE?SKA WIE?
11369	150356	WRZECIONO SPÓ?KA Z OGRANICZON?	ODPOWIEDZIALNO?CI?	OPOLE
11370	150357	Werka AG		Opfikon
11371	150358	HSK Werksvertretung	Nikolaus Wagner	Payerbach
11372	150359	Wielitsch KG		Maria Saal
11373	150360	Yildiz Demir Hirdavat	Yomtov Bensason	Okmeydani - Istanbul
11374	150361	Zgonc Handel GmbH		Wien
11375	150362	MCM Hirdavat ITHALAT IHRACAT	MAKINA SAN. TIC. LTD. STI.	Karaköy Istanbul
11376	150363	Yun Chan Ind. Co. Ltd.		Dali district Taichung City 41
11377	150364	ZANOTTI  FABIO  S.A.S.	di Zanotti Fabio E C.	GHEDI (BS)
11378	150365	mbi	matérial bâtiment industrie	CHAMPIGNY SUR MARNE
11379	150366	YH-UY Marketing Inc.		Quezon City
11380	150367	Lackner & Urnitsch GmbH	Präzisionsmaschinen und Werkzeuge	GRAZ
11381	150368	BMI Monier B.V.		GP Montfoort
11382	150369	MONROVIA SUMINISTROS	INDUSTRIALES, S.L.	GURIEZO (CANTABRIA)
11383	150370	Ulrich Harms GmbH	Maschinen + Werkzeuge	Wieren
11384	150371	G.U.T. SONNTAG Sonntag KG	Fachgroßhandel f.	Münster
11385	150372	Meissel-Discount	Susanne Andrae	Upgant-Schott
11386	150373	Anatol Reiswich	Gebäudetrocknung	Wipperfürth
11387	150374	PAV e.K.	Handel, Dienstleistung, Consulting	Langenhagen
11388	150375	Dachbaustoffhandel	Reiswich GmbH	Wipperfürth
11389	150376	ABS Handelsgesellschaft mbH		Hamburg
11390	150377	Schlüssel 40	Inh. Ioannis Aidinaoglou	Düsseldorf
11391	150378	Schwahn	Beschlag- und Holzhandel	Halberstadt
11392	150379	Adam GmbH		Kempen
11393	150380	Aulmann,Kruener & Co.	Inh. Th. Teichmüller	Hamburg
11394	150381	Bezug + Absatzgenossen-	schaft	Neunkirchen
11395	150382	A - Z Mietservice	Klaus Geißler	Springe
11396	150383	Daniel Arnold		Overath
11397	150384	ARGU Ihr Holzfachmarkt	Stefan Gutting	Neustadt/Weinstrasse
11398	150385	Erich Abram GmbH		Hemmingen/OT Arnum
11399	150386	Adam GmbH		Kaiserslautern
11400	150387	Werkzeug 1x1	Tilo Frisch	Braunsbedra/ OT Roßbach
11401	150388	A.L.B. Aluminiumhandels- und	Industriebau GmbH	Bad Honnef
11402	150389	A+B Werkzeuge u. Maschinen	GmbH	Ahaus
11403	150390	Adolphs-Bautenschutz GmbH		Engelskirchen
11404	150391	WSM Walter Solbach Metallbau GmbH		Waldbröl
11405	150392	Josef Attenberger GmbH		St. Wolfgang
11406	150393	A - Z	Holz - und Bedachungshandel GmbH	Wuppertal
11407	150394	Der Baustoff Mann	Schneider KG 700506	Oberhausen
11408	150395	Jörg Johann	Industrievertretungen	Wermelskirchen
11409	150396	LLC “Abron”	Inhaber: Oleksandr Abrosimov	Kyiv
11410	150397	Baumgarten Geräte GmbH		Hannover
11411	150398	kwb Germany GmbH		Stuhr
11412	150399	BZN Herm. Meyer & Sohn GmbH & Co.	KG	Oldenburg
11413	150400	BÖ-LO Werkzeug & Maschinen	Inh. Matthias Schütze	Quakenbrück
11414	150401	Heinrich Biesang OHG		Bad Oeynhausen
11415	150402	Adam Berkel GmbH		Fulda
11416	150403	Eska	Maschinentechnik e.K.	Rudolstadt
11417	150404	IHB GmbH	Industrie- und Heimbedarf	Krefeld
11418	150405	Burghardt S.	Diamant Schleifwerkzeuge	Quickborn
11419	150406	Bohrcraft Werkzeuge	GmbH & Co. KG	Remscheid
11420	150407	Udo Brucksch	Werkzeugschärfbetrieb	Dommitzsch
11421	150408	BWG Bauteam Profi Produkte	Vertriebs & Logistik GmbH	Steinbach-Hallenberg
11422	150409	Nordwest Handel AG	Wilhelm E. Beckmann GmbH & Co. KG	Hagen
11423	150410	Dahlhäuser GmbH	Qualitätsprodukte	Nümbrecht
11424	150411	BHT	Baustoffe Handel & Transport GmbH	Bachra
11425	150412	DeMi-Befestigung Köln	Michels GmbH	Köln
11426	150413	Demo GmbH & Co. KG		Norderstedt
11427	150414	RIAG Baubedarf GmbH & Co. KG	(EVB Nr. 11806)	Rudolstadt
11428	150415	MECHANIK - ECK BUSCH	Inh. Monika Busch	Freiberg
11429	150416	Lothar Baier	Werkzeuge und Schleifmittel	Ispringen
11430	150417	Gartenpaul Brands Inh. Andre Blöchl		Wedemark
11431	150418	Industrieberatung	Thomas Bünting	Jeddeloh 1
11432	150419	BTS Bautechnik-Service GmbH		Waren
11433	150420	Melle Gallhöfer Dach GmbH		Großschweidnitz
11434	150421	Dahlmann GmbH		Großefehn
11435	150422	Begra Befestigungstechnik Gramm	GmbH	Gedern
11436	150423	WHV GmbH	Werkzeug-Handel-Vermietung	Bernburg
11437	150424	Wolf Burkhardt	Spezialwerkzeuge	Zweibrücken
11438	150425	Industriebedarf Insel	Andreas Insel	Sinzig
11439	150426	Friedrich Bormann OHG	Eisenwaren, Sanitär, Heizung, Bauar	Bad Harzburg-Harlingerode
11440	150427	Alexander Belloth Service	Elektro- und Schweißgeräte · Techni	Hallbergmoos
11441	150428	Bonn Stahl GmbH	Verwaltung	Bonn
11442	150429	Eichfelder-Werkzeuge		Bamberg
11443	150430	Eichenberg Werkzeuge	Inh. Andreas Grothe	Aerzen / OT Heckendorf
11444	150431	Baumgarten Betonbearbeitung GmbH		Hannover
11445	150432	Hans Becker	Handwerk + Haus + Garten	Kleinblittersdorf
11446	150433	Begra Befestigungstechnik	Behr GmbH	Gedern
11447	150434	BERG TECTOOL GmbH		Köln
11448	150435	BURG-WÄCHTER KG		Wetter
11449	150436	Luttmann & Co. GmbH		Lippstadt
11450	150437	Industrie und Werkstatttechnik-Nord	GmbH (NW 8921)	Nienburg/Weser
11451	150438	Boehl-Weissenfeld GmbH & Co. KG		Remscheid
11452	150439	Braun Reiner		Rodenbach
11453	150440	Erwin Kauth	ERKA Schleifen	Blankenheim
11454	150441	G.U.T. Bergmann KG		Großdubrau OT Sdier
11455	150442	Burgzem GmbH		Bad Münder
11456	150443	BHV Kiefer	Baudienstleistung Handel & Vermietu	Zell-Atzenbach
11457	150444	EFG Hanse KG	Elektro-Fachgroßhandel	Barsbüttel
11458	150445	A. Brickwedde	Technischer Handel GmbH & Co. KG	Osnabrück
11459	150446	Peter Belousow  GmbH		Aichach
11460	150447	BTS Bau Technische Systeme GmbH & C	KG	Waltrop
11461	150448	BSW-Schrauben-Werkzeughandels-GmbH		Bruchsal
11462	150449	ROKA	Sebastian Clausen Großhandel e.K.	Hamburg
11463	150450	EAS Elektro-Ausrüstungs-	Service GmbH	Rheinberg
11464	150451	Cordes & Graefe Emden KG	Fachgroßhandel für Haustechnik	Emden
11465	150452	Erich Carlé GmbH & Co. KG	Bedachungsfachhandel	Gießen
11466	150453	Weishaupt Werkzeuge		Krumbach
11467	150454	Pasquale Cantatore	Industrievertretungen	Friedberg/Haberskirch
11468	150455	Carlé + Fatum	Bedachungsfachhandel	Kriftel
11469	150456	Dereh - Bedachnung GmbH	Zimmerer & Dachdeckermeisterbetrieb	Beerfelden
11470	150457	Dienes Werke	GmbH & Co. KG	Overath
11471	150458	Dörrenberg	Edelstahl GmbH	Engelskirchen
11472	150459	KERN-DEUDIAM	Diamantwerkzeuge und Maschinen	Hövelhof
11473	150460	WEGA Handels Gbr.	Bodo Kaiser, Wolfgang Kaiser	Burscheid
11474	150461	Werkzeug-Döring GmbH	(NW 6110)	Wuppertal
11475	150462	DÜNA	Befestigungstechnik GmbH	Meschede-Freienohl
11476	150463	Reinhard Eck	Werkzeugfachhandel und	Zella-Mehlis
11477	150464	DO IT 5479	Silberspeer GmbH	Wehr
11478	150465	BÖRNER-WERKZEUGE		Uslar
11479	150466	Opitec Handel GmbH		Giebelstadt-Sulzdorf
11480	150467	Daniel Gruppe GmbH		Lübbecke
11481	150468	Ecker Eisenwaren GmbH		Stolberg
11482	150469	Dieter Irmscher	Handel & Service von Bautechnik	Chemnitz
11483	150470	Dunken Verbindungselemente GmbH		Braunschweig
11484	150471	Dach-Hartwig GmbH		Bickenbach
11485	150472	Dachkauf GmbH	Dachbaustoffe	Hattorf am Harz
11486	150473	AK Industrie- u.Montageteile	Renate Antwerber	Flammersfeld
11487	150474	Diederichsen Tresoröffnung		Hamburg
11488	150475	Friedrich Duss	Maschinenfabrik GmbH & Co. KG	Neubulach
11489	150476	Peter Drösser GmbH	(NW 6134)	Köln
11490	150477	Werkzeugprofi	Inhaber: Stefan Schrapers	Mülheim / Ruhr
11491	150478	3 Chem GmbH	Chemisch-technische Spezialprodukte	Geislingen / Steige
11492	150479	Erich Drescher	Handel und Service	Au / Bad Feilnbach
11493	150480	Baufachzentrum Dörries GmbH		Delligsen
11494	150481	Ralph Penther		Kisdorf
11495	150482	Werkzeugvertrieb	Michael Jungen	Heilbronn
11496	150483	Dobermann GmbH & Co. KG	Baustoffhandelsgesellschaft	Münster
11497	150484	Diversio GmbH & Co. KG	(NW 9351)	Sohren
11498	150485	Eggers H.J.	Eisenwaren	Braunschweig
11499	150486	Ebnet Josef		Patersdorf
11500	150487	Engel GmbH		Hamburg
11501	150488	Diewe GmbH		Kissing
11502	150489	EJOT GmbH & Co. KG		Bad Berleburg
11503	150490	Hopert & Klinzmann		Haldensleben
11504	150491	Holz Leipzig		Leipzig
11505	150492	Eyssler Arthur GmbH & Co. KG	Fachgroßhandel	Neustadt/Sa.
11506	150493	Dornis Dach- und	Wandbaustoffe GmbH	Kölleda
11507	150494	Uwe Eißmann GmbH	Fachhandel für Dach und Fassade	Wilkau-Haßlau
11508	150495	Eisen-Schlitt	Ortwin Herbst	Frankenthal/Pfalz
11509	150496	Esser Großhandels- und	Dienstleistungs GmbH	Essen
11510	150497	Emder Schiffsausrüstung GmbH		Emden
11511	150498	Michael Engelhardt	Handelsvertretung	Föritztal OT Neuhaus-Schiersch
11512	150499	Rolf Dammers OHG		Hamburg
11513	150500	Heitkamm GmbH	Dachbaustoffe	Chemnitz
11514	150501	SK-Work-Wear	Inh.Stefanie Kehl	Grassellenbach
11515	150502	Etanco GmbH		Wilnsdorf-Wilden
11516	150503	Druse GmbH	Werkzeuge & Industriebedarf	Buchholz
11517	150504	BreGu e.K.	Inhaber Stefan Bremm	Krummhörn-Greetsiel
11518	150505	Shopbox24	elektro-schölzel GmbH & Co. KG	Demitz-Thumitz
11519	150506	H. W. Meyer sen. Wwe GmbH & Co. KG		Soltau
11520	150507	Engel 4.0 GmbH		Hamburg
11521	150508	Peter Hermann Biertz e.k.		Losheim am See
11522	150509	rud. entenmann gmbh	(NW 8234)	Heidelberg
11523	150510	Deutsche Everlite GmbH		Wertheim
11524	150511	Hermann Fatum GmbH & Co. KG	Bedachungsfachhandel	Hungen
11525	150512	Fahrzeugteile-Handelsgesellschaft	Carl F. Müller mbH	Hamburg
11526	150513	Frank + Warnecke	Industriebedarf GmbH	Braunschweig
11527	150514	Reinhold Feltes	Inhaber Rainer Feltes	Trier
11528	150515	FAMEX - Werkzeuge	Lühdorff R. GmbH	Remscheid
11529	150516	Erich Frank	Schrauben, Metall- und Normteile Gm	Aachen
11530	150517	Krapp Eisen GmbH & Co. KG		Lohne
11531	150518	Theo Förch GmbH & Co. KG		Neuenstadt
11532	150519	FTH	Fredenbecker Technik & Handels	Stade
11533	150520	Herm. Fichtner Hof GmbH		Hof
11534	150521	P.F.Freund & Cie. GmbH		Wuppertal
11535	150522	Uwe Fischer	Holzbau	Coburg
11536	150523	Werner Flosbach GmbH & Co.KG		Remscheid
11537	150524	PRIMIUM	Lager und Liefergesellschaft	Wuppertal
11538	150525	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11539	150526	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11540	150527	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11541	150528	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11542	150529	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11543	150530	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11544	150531	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11545	150532	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11546	150533	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11547	150534	FREDIAM	Johann Frenka	Germering
11548	150535	DER Fuchs GmbH		Kirchlinteln
11549	150536	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11550	150537	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11551	150538	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11552	150539	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11553	150540	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11554	150541	fortuna Sportgeräte GmbH		Gehlert
11555	150542	Fritsche & Perleberg GmbH	Elektro- und Sicherheitstechnik	Schönebeck
11556	150543	ISAHO Versand e. K.		Hohndorf
11557	150544	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11558	150545	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11559	150546	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11560	150547	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11561	150548	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11562	150549	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11563	150550	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11564	150551	G. Felber Handwerker-Zubehör		Ahaus
11565	150552	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11566	150553	Freialdenhoven Baumaschinen	Inh. Ralf Freialdenhoven	Eschweiler
11567	150554	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11568	150555	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11569	150556	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11570	150557	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11571	150558	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11572	150559	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11573	150560	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11574	150561	Festool GmbH		Wendlingen
11575	150562	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11576	150563	FAMOS GmbH & Co. KG		Neu-Ulm
11577	150564	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11578	150565	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11579	150566	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11580	150567	Fritz Tresor Transporte GmbH		Maintal
11581	150568	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11582	150569	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11583	150570	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11584	150571	FEKATEC GmbH		Aurich
11585	150572	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11586	150573	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11587	150574	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11588	150575	FAKTUM Bauprodukte GmbH		Wilnsdorf
11589	150576	Foxx Gmbh		Wittenberge
11590	150577	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
11591	150578	Werkstatttechnik Marcus Fronober		Bennewitz
11592	150579	Fillbach Dach-Handel GmbH	(AH.-Nr.438215)	Heistenbach
11593	150580	Bernd Müller - Hausmeisterservice &	Trockenbau	Selm
11594	150581	Grießbach Stefan	Elektromaschinenbau	Auerbach-Rebesgrün
11595	150582	Gaishauser Erwin		Tiefenbach
11596	150583	G + K Schrauben-Befestigung-	Vertriebs GmbH	Pfungstadt
11597	150584	Uwe Grimm	Treppenbaubedarf	Groß Wokern
11598	150585	Holz Loddenkemper GbR		Marienfeld
11599	150586	G + M Geräte- und Maschinen-	handlungs GmbH	Marktredwitz
11600	150587	Häuslein	Werkzeuge - Maschinen	Marktheidenfeld-Glasofen
11601	150588	Glashandel Pritz GmbH		Engelskirchen
11602	150589	GOJ Werkzeug GmbH	(NW 8772)	Nürnberg
11603	150590	GS Maschinenhandel	Diamantwerkzeuge	Ahausen-Eversen
11604	150591	Globus Türen & Fenster	Handels GmbH	Hamburg
11605	150592	Anton Gallhöfer Dach und Fassade	GmbH	Oberhausen
11606	150593	EGU Elektro Grosshandels Union Rhei	Ruhr GmbH & Co. KG	Dortmund
11607	150594	Hülsewig Karl	Steinindustriebedarf	Witten
11608	150595	Georg Geiger	Inh. Alfons Reitberger	Kempten/Allgäu
11609	150596	Garden-Tec Rothe		Zeitz
11610	150597	DiTec GmbH & Co. KG		Haiger
11611	150598	Gundlach Diamantwerkzeuge		Schwalmstadt
11612	150599	GERICON Consulting & Connecting	Gerd Riethmüller	Balingen
11613	150600	Anton Gallhöfer Dach + Fassade GmbH		Birkenfeld
11614	150601	GIMA GmbH & Co. KG		Herrieden-Neunstetten
11615	150602	Gründl Bedachungsfachhandel GmbH		Sömmerda
11616	150603	Burkhard Giegerich GmbH & Co. KG		Großwallstadt
11617	150604	Melle Gallhöfer Dach GmbH		Stuttgart
11618	150605	Melle Gallhöfer Dach GmbH	Niederlassung Döbern	Döbern
11619	150606	EXPORTA GmbH		Bremen
11620	150607	GFE - Gesellschaft für Fertigungste	und Entwicklung Schmalkalden e.V.	Schmalkalden
11621	150608	GV Montageprodukte GmbH		Landshut
11622	150609	Melle Gallhöfer Dach GmbH		Dingelstädt
11623	150610	GERICON GmbH		Balingen
11624	150611	GC24-Express KG		Unna
11625	150612	Emil Holzmann GmbH		Radevormwald
11626	150613	Goecke GmbH & Co. KG		Schwelm
11627	150614	Gerhard Hof GmbH		Mühlheim/Main
11628	150615	Hoffmann GmbH	Qualitätswerkzeuge	München
11629	150616	TeHa Attendorn GmbH	Technischer Handel	Attendorn
11630	150617	HAUPA GmbH		Remscheid
11631	150618	Hinst	Eisenwaren GmbH	Kellinghusen
11632	150619	Holtegel GmbH		Flensburg
11633	150620	TIB Hydraulik GmbH		Göttingen
11634	150621	Hörhammer	Werkzeuge & Maschinen	Moosburg
11635	150622	BSD Bildungs-	und Servicezentrum GmbH	Großröhrsdorf
11636	150623	HOHA Holzhandel	Norbert Stern	Rudolstadt
11637	150624	Detlev Heyert	Diamant-Technik	Harsdorf
11638	150625	Heitkamm GmbH	Dachbaustoffe	Ahlen
11639	150626	Ferdinand Horstmann GmbH & Co. KG		Bad Oeynhausen
11640	150627	Höck-Jansen GmbH		Overath
11641	150628	Hoppe GmbH & Co. KG		Brilon
11642	150629	Arnold Houben GmbH		Köln
11643	150630	Huber	Werkzeuge & Maschinen	Oberviechtach
11644	150631	BHT GmbH	Bedachungshandel Tritschler	Sexau
11645	150632	Hampel Bedachungs GmbH	Bedachungen Dachbaustoffe	Göttingen
11646	150633	HABA Bauhandwerksbedarf	Inh. Stephanie Heinrich	Idar-Oberstein
11647	150634	Hendriks Werkzeuge		Goch
11648	150635	Peter Hartmann	Werkzeuge und Maschinen	Bielefeld
11649	150636	HABO Handelsgesellschaft für	Werkzeugbedarf mbH	Varel
11650	150637	HOME TEC GmbH		Weyhe
11651	150638	HWG - Vertrieb tools and more	Heinz-Werner-Gabriel e.K	Ergolding
11652	150639	H.R. Tempel	GmbH & Co. KG	Nürnberg
11653	150640	Wilhelm Huber GmbH	Fachgroßhandel f. Ökologische	Burgberg i. Allgäu
11654	150641	W.Hägele	Rohrisolierungen Befestigungen	Ottenbach
11655	150642	Hecker`s Sohn e.K.	(NW 4820)	Dresden
11656	150643	DRAGON	Verkaufsgesellschaft mbH	Fischerbach/Schwarzwald
11657	150644	Hübner Werkzeuge GmbH		Großröhrsdorf
11658	150645	Hyland- Baugeräte GmbH		Hannover
11659	150646	Hartlmaier	Technische Handels GmbH	München
11660	150647	Fliesenmarkt Herberhold		Lippstadt
11661	150648	Hyland-Baugeräte GmbH		Großröhrsdorf-Bretnig
11662	150649	Höhne	Werkzeug und Maschinentechnik	Bönningstedt
11663	150650	Hartmut Richter Industriebedarf Gmb		Bochum
11664	150651	Volker Heß	Bau- und Gerüstbaubedarf	Oberlungwitz
11665	150652	HWV Werkzeugvertrieb Hamburg GmbH	(NW7836)	Hamburg
11666	150653	Hartmann Werkzeuge e.K.		Gemmrigheim
11667	150654	WBV Werkzeug- &	Baumaschinenvermietungsgesellschaft	Wermelskirchen
11668	150655	TIB Technischer Industriebedarf	GmbH Bernsbach	Lauter-Bernsbach
11669	150656	heima24 GmbH & Co. KG		Wehingen
11670	150657	HIK Systems GmbH		Heidenheim
11671	150658	HSK	Handels Scheune Kirchner	Rüdershausen
11672	150659	Häcker Eisenwaren GmbH & Co. KG		Geislingen
11673	150660	Hessberger GmbH Baustellentechnik		Frankfurt am Main
11674	150661	HEYCO Qualitätswerkzeuge GmbH & Co.	KG	Remscheid
11675	150662	Herwig-Bohrtechnik	Schmalkalden GmbH	Schmalkalden
11676	150663	Päffgen Dachbaustoffe		Kaarst
11677	150664	Hesselkamp GmbH & Co. KG		Norderstedt
11678	150665	Andreas Pabst Handelsvertretung		Lohmar-Birk
11679	150666	HIFI Components GmbH		München
11680	150667	Herrlinger KG	Fachgroßhandel für Haustechnik	Eislingen
11681	150668	Harzig Kleb- und Dichtstoffe GmbH		Augsburg
11682	150669	Holzfachmarkt Gerschwitz GmbH		Rottenburg an der Laaber
11683	150670	TIB	Technischer Industrie-Bedarf Lackma	Essen
11684	150671	BPH-Tools	Inh. Uwe Bruder	Bietingheim-Bissingen
11685	150672	Heilna Trade GmbH		Neu-Isenburg
11686	150673	ISH Hoffmann Industrieservice		Enger
11687	150674	Jehle Stefan GmbH	Werkzeuge + Maschinen	Landsberg a. L.
11688	150675	Irrgang-Werkzeughandel	GmbH	Eberswalde
11689	150676	J + K GmbH	Janßen + Klinkebiel	Apen - Augustfehn
11690	150677	H. Isik GmbH	Diamantwerkzeuge	Bochum
11691	150678	Thomas Jilg	Industrieberatung	Schauenstein
11692	150679	INTEK	Leyh und Gulden OHG	Ingolstadt
11693	150680	IMPEX	Eduard Schuffenhauer	Kaufbeuren
11694	150681	imBau GmbH	Werkzeuge & Maschinen	Künzell
11695	150682	INTRA-TEC GmbH	Schrauben-Hammer	Bergisch Gladbach
11696	150683	Heinrich Jensen e.K.		Bredstedt
11697	150684	innofixx equipment GmbH		Berlin
11698	150685	Innofixx Vertriebs GmbH		Hamburg
11699	150686	Norbert Junk	Präzisionswerkzeuge	Sulzbach
11700	150687	Jäger-Plastik GmbH & Co. KG	Kunststoffspritzgußwerk	Engelskirchen-Loope
11701	150688	Hermann Jaeger GmbH		Hamburg
11702	150689	Kahrl + Wiemann GmbH	Industrievertretungen	Wermelskirchen
11703	150690	Keiper GmbH	Großhandel	Taunusstein
11704	150691	Redko GmbH	Niederlassung Kiel	Kiel
11705	150692	KALM	Befestigungssysteme GmbH	Kaiserslautern
11706	150693	Kerschgens Werkstoffe und Mehr	GmbH	Stolberg / Rhld.
11707	150694	BK Elmar Knobling	GmbH & Co. KG	Wassenberg-Ophoven
11708	150695	Kämper Werkzeuge		Radevormwald
11709	150696	Karl Jöcker	GmbH & Co. KG	Singen
11710	150697	Walter Cordbarlag GmbH & Co.		Bielefeld
11711	150698	JRB Handelsvertretungs GmbH	DER HEIMWERKER	Falkensee
11712	150699	Konnex - IT GmbH		Hameln
11713	150700	KBM	Handelsgesellschaft mbH	Salzatal OT Schiepzig
11714	150701	E. Werner Koch	techn. Groß- und Einzelhandel	Gummersbach
11715	150702	Rolf King	Werkzeuge	Rickenbach
11717	150704	Baufachmarkt Knöpfle GbR	Inh. Achim Langenbacher	Blumberg
11718	150705	Uwe Kloska GmbH	Technischer Ausrüster	Bremen
11719	150706	KB - Fenster GmbH		Kruft
11720	150707	Fritz Kruse	Baumaschinen GmbH	Hagen
11721	150708	Kaiser GmbH & Co. KG		Schalksmühle
11722	150709	Kasprick Diamantwerkzeuge GmbH		Köln
11723	150710	Carl Kürle e.K.	Techn. Großhandlung	Lübeck
11724	150711	Käsbeitzer J.	Werkzeuge	Hengersberg
11725	150712	Heinz Baustoffe	Fachmarkt - Fliesen- Werkzeuge	Ingolstadt/Donau
11726	150713	Krapp Eisen GmbH & Co.KG		Dinklage
11727	150714	Eisen-Kehrer	Thomas Kehrer	Großostheim
11728	150715	Volker Klein	Werkzeuge für Bauhandwerk + Industr	Quierschied
11729	150716	Kroboth Baumaschinen GmbH		Seligenstadt-Froschhausen
11730	150717	Sicherheitstechnik Krauße GmbH		Saalfeld
11731	150718	Kühn Sicherheit GmbH	Haus für Sicherheit	Hannover
11732	150719	Erich Viohl KG		Bremen
11733	150720	KTS GmbH	Kunststoff-Technik Service	Werne
11734	150721	Gerd Kottmeier	Werkzeughandel + Reparatur	Vlotho
11735	150722	Kuhlmann GmbH & Co. KG		Borken
11736	150723	Klamor GmbH	Baumaschinenhandel & Vermietung	Dortmund
11737	150724	HEINZ GmbH		Rodewisch/V.
11738	150725	Küne + Sehringer GmbH	Bedachungs-Fachgroßhandel	Phillipsburg (Rheinsheim)
11739	150726	Kaiser GmbH	Holzbearbeitungsmaschinen	Wuppertal
11740	150727	P. Kilbinger KG		Neuss
11741	150728	KHS Haustechnik GmbH		Schneverdingen
11742	150729	Arno Koch	Großhandel	Neunkirchen
11743	150730	W. Schweisfurth	Eisenwaren und Industriebedarf	Kreuztal
11744	150731	DESOI GmbH		Kalbach / Rhön
11745	150732	Kunkel GmbH	Befestigungssysteme	Saarbrücken
11746	150733	Kress-elektrik GmbH	& Co. KG, LKZ 811088	Bisingen
11747	150734	Stefan Kuhnen GmbH		Trier
11748	150735	Franz Kerstin Hausbau GmbH & Co. KG	(AH.-Nr. 10115 VL 77336 ZR-Nr.0135)	Soest
11749	150736	MH - Montagen, Schweißtechnik und	Handel	Mainz - Kostheim
11750	150737	Oliver Lehmann KDO Marine Service		Hamburg
11751	150738	Klein Baubeschläge GmbH		Wiehl
11752	150739	km GbR		Neustadt
11753	150740	Heinrich Küpper e.K.		Gummersbach
11754	150741	Hermann Kemper GmbH & Co. KG		Remscheid
11755	150742	Johann Kirschner Werkzeug- und	Maschinenhandel	Eichstätt
11756	150743	Heinrich KUPER GmbH & Co. KG		Korbußen
11757	150744	Kaprotex GmbH		Marktredwitz
11758	150745	Kirsch BioPharm GmbH		Wedemark OT Bissendorf
11759	150746	Kühl-Qualitätswerkzeuge-Baugeräte-	Baumaschinen und Vermietungs GmbH	Eisenberg
11760	150747	Kapeller Solar - Heizung - Sanitär		Wolfsburg
11761	150748	Tischlerei Markus Köser GmbH		Wipperfürth
11762	150749	Robin Klautzsch	Eisenwaren	Derschen
11763	150750	Lindenthaler Metallwaren	Matthias Lotz	Gera
11764	150751	Lahm & Halpaus Ges. für	Befestigungstechnik GmbH	Mannheim
11765	150752	Heinz Werner Lang	Werkzeughandel	Remscheid
11766	150753	Heinrich Lütticken GmbH	Stahlhandel	Wittlich
11767	150754	Lössl Wolfgang	Schreinereibedarf	Rosenheim
11768	150755	A. Leistner	Werkzeugtechnik GmbH & Co. KG	Stützengrün
11769	150756	LB-Werkzeugtechnik GmbH		Mulda
11770	150757	Emil Lux  GmbH & Co. KG	Werkzeughandel	Wermelskirchen
11771	150758	Lauerer GmbH		Zachenberg
11772	150759	Lukas Erzett	Vereinigte Schleif- und Fräswerkzeu	Engelskirchen
11773	150760	Leipziger Kisten- und	Leistenfabrik GmbH	Leipzig
11774	150761	KEIL Befestigungstechnik GmbH		Engelskirchen
11775	150762	LH Haustechnik	SANITÄR/Heizung/Elektrik	Leichlingen
11776	150763	Lidac Deutschland GmbH		Dortmund
11777	150764	Maik Jansen		Engelskirchen
11778	150765	LUDIS Handel Spezial		Bornheim
11779	150766	Leysser Sanitär Heizung Fliesen Gmb	(NW 30071)	Idar-Oberstein
11780	150767	Lutz Eduard	Schrauben-Werkzeuge GmbH	Weilheim
11781	150768	Liesk Baustoffe GmbH		Schwarzheide
11782	150769	LEOLO Trailerzubehör	Inh. C. Rommersbach	Saerbeck
11783	150770	LK-Werkzeuge		Mandelbachtal
11784	150771	Schweißtechnik Thöne GmbH	Linde Gas & More	Aachen
11785	150772	Laubrock KG		Havixbeck
11786	150773	Klaus Meier GmbH	Werkzeuge & Maschinenhandel	Trier
11787	150774	IFP Ihr Fachhandelspartner	Werkzeug + Ausstattung GmbH	Berlin
11788	150775	Martens Dieter	Baudienstleistungen	Engelskirchen
11789	150776	Michlbauer -Baugeräte		München
11790	150777	Rabied Biedron Diamanttechnik GmbH		Bad Liebenzell
11791	150778	Melle Gallhöfer Dach GmbH	Niederlassung Betriebsbedarf	Osterode/Harz
11792	150779	Mayer Anton	Befestigungstechnik	Illertissen
11793	150780	Muskat GmbH		Hamburg
11794	150781	Müller Horst GmbH		Ratingen
11795	150782	Schwirten GmbH & Co.KG	Metallwarenfabrik	Marienheide
11796	150783	Mann & Magar GmbH     HB-Nr.628830	Baugeräte/ Baumaschinen	Merzig/Saar
11797	150784	Ulrich Manzke	Stahlbau & Handel GmbH Teterow	Teterow
11798	150785	Miersch & Stephan GmbH	Fachh. f. Dach & Fassade	Dresden
11799	150786	Michels Schraubenquelle GmbH		Ladeburg
11800	150787	Migacut		Moosburg/Isar
11801	150788	Mack GmbH		Burgheim
11802	150789	Melle Gallhöfer Dach GmbH	Niederlassung Osterode	Osterode am Harz
11803	150790	Melle Gallhöfer Dach GmbH	Niederlassung Nordhausen	Nordhausen
11804	150791	Melle Gallhöfer Dach GmbH		Landsberg/OT Gütz
11805	150792	Melle Gallhöfer Dach GmbH		Amt Wachsenburg
11806	150793	Melle Gallhöfer Dach GmbH		Emersleben
11807	150794	Melle Gallhöfer Dach GmbH		Lohfelden
11808	150795	Melle Gallhöfer Dach GmbH	Niederlassung Biebesheim	Biebesheim
11809	150796	Bernard Menge	Inh. Wilhelm Menge	Recklinghausen
11810	150797	Josef Dietl	Autoteile & Werkzeuge	Neukirchen
11811	150798	Montage Service direkt		Kreßberg-Marktlustenau
11812	150799	UDITEC Diamantwerkzeuge	Inh. Rainer Ufer	Lindlar
11813	150800	Maja Industriebedarf		Remscheid
11814	150801	M & F Werkzeughandel GmbH		Windeck
11815	150802	Hoffmann Diamant Technik	Diamantwerkzeuge Erdraketen,Baum.	Niederkassel-Ranzel
11816	150803	W. Markmiller oHG	Eisen-Heizung-Sanitär-Küchen	Rennertshofen
11817	150804	Werkzeughandel Möller	Inh.Thomas Möller	Königsee
11818	150805	MBM Maschinen-& Werkzeughandel	Wolfgang Rieß	Mauschbach
11819	150806	Moser Industrieposten	Siegfried Moser	Haag i. OB.
11820	150807	Stefan Meyer	Industrie- und Werkstattprodukte	Bad Schwartau
11821	150808	Dieter Ueberberg	Inh. Daniel Ueberberg	Engelskirchen
11822	150809	MK Montagetechnik GmbH		Pirmasens
11823	150810	GT Gerätetechnik GmbH		Wels
11824	150811	Rosemarie Reiser		Kirchhaslach
11825	150812	H.Marx GmbH & Co.      L-Nr.70910	Schreinerei-Bedarfsartikel KG	Limburg -Staffel
11826	150813	Melle Gallhöfer Dach GmbH	Niederlassung MVG Genthin	Genthin
11827	150814	Multipick Direct GmbH		Bonn
11828	150815	Metz Diamant- und Schleiftechnik		Herxheim
11829	150816	Mabau-Handel GmbH		Konz
11830	150817	Johann Moissl	Metall- und Balkonbau	Kröning
11831	150818	Dobler-MBM GmbH		Möckmühl
11832	150819	Elektro-Mechanik Meisl GmbH		Berchtesgaden
11833	150820	Sascha Meerpohl Metallbau	Meisterbetrieb	Apen
11834	150821	Fachmarkt Ewald Mayer		Engen
11835	150822	Neumann GmbH	Vertretungen	Laatzen
11836	150823	Nedschroef Altena GmbH		Altena
11837	150824	N.E.S. GmbH		Lüdenscheid
11838	150825	R. Pöppel GmbH & Co. KG	Maschinen u. Werkzeuge	Memmingen
11839	150826	Netzband Bauzentrum GmbH		Neu Isenburg
11840	150827	Fachhaus Andreas Nickel (e.K.)	Inh. Andreas Gromeier	Salzwedel
11841	150828	Natursteinservice	Inh. Carsten Zieschang	Vierkirchen
11842	150829	Nicolay	Fachgroßhandel für Dach- und	Wuppertal
11843	150830	Wolfgang Nieweg GmbH		Osnabrück
11844	150831	Mohr Steffen Dachbaustoffe GmbH		Stade-Wiepenkathen
11845	150832	Elektro-Pönicke GmbH		Zeulenroda-Triebes
11846	150833	Primero-Schiefer GmbH		Wipperfürth
11847	150834	Effektiv-Werkzeuge	und Maschinen	Remscheid
11848	150835	NV Technische Waren	Inhaber: Tomislav Vrdoljak	Frankfurt am Main
11849	150836	Alfred Oberhofer Werkzeuge Gartenbe		Langquaid
11850	150837	Andreas Nölling	Handelsvertretung	Morsbach
11851	150838	Metabau Reinsdorf	Inh. Tom Gottschall	Wittenberg
11852	150839	Ostendorp Frank	Schrauben und Dübel	Leverkusen
11853	150840	OTEC - Olaf Otto		Freudenberg
11854	150841	Oeben Werkzeugmaschinen	Inh. Ulrich Oeben	Mönchengladbach
11855	150842	Ostermann Inh. Garnreiter	Bau- und Möbelbeschläge	Rosenheim
11856	150843	Martin Geus	Meisterbetrieb	Kürten
11857	150844	Pirson GmbH		Nauheim
11858	150845	Orbis Will GmbH + Co. KG		Ahaus
11859	150846	Detlef Paulsen Betriebsausrüstung G	& Co. KG	Kiel
11860	150847	Auto Nagel A33 GmbH & Co. KG		Borgholzhausen
11861	150848	Parzinger Baustoffe		Altenmarkt
11862	150849	BVS - Tagewerben GmbH	Baumaschinen	Weißenfels/ OT Tagewerben
11863	150850	Plastoform GmbH		Waldachtal-Salzstetten
11864	150851	Friedhelm Seidler		Wesel
11865	150852	Päpke Mario	Arbeitsschutz von A-Z	Teltow
11866	150853	Putsch Wilhelm GmbH & Co. KG		Remscheid-Hasten
11867	150854	Reca Norm GmbH & Co. KG		Ingolstadt
11868	150855	Pfeiffer, August GmbH		Stetten
11869	150856	MPS-Sägen GmbH		Wasserliesch
11870	150857	Plegge + Bauer	Baubeschläge GmbH	Kaiserslautern
11871	150858	Han Miet-Service GmbH		Offenbach/Main
11872	150859	Werkstattservice Roland Peldßus	Inh. Cornelia Wachsmuth	Neubrandenburg
11873	150860	Picard GmbH		Wuppertal
11874	150861	Nikolas Papendorf	Baustoffe, Holzbau, Bauservice	Gifhorn
11875	150862	diaX Diamantwerkzeuge		Malsch
11876	150863	Lars Jelonnek	Der Tresorchirurg	Köln
11877	150864	ProKilo GmbH & Co.KG		Engelskirchen
11878	150865	ProKilo GmbH Co. KG		Köln
11879	150866	Polizeipräsidium Einsatz	Direktion Spezialeinheiten -	Göppingen
11880	150867	Peters Eisenwaren		Friesenheim
11881	150868	August Richter Eisen-,	Röhren- und Eisenwaren	Geseke
11882	150869	Relma GmbH		Zwickau
11883	150870	rictools Innovative Werkzeuge	Inh. Christian Richter	Ingelheim
11884	150871	Theodor Riewer	Handelsgesellschaft mbH	Bitburg
11885	150872	Riedelsche Dachbaustoffe GmbH		Stralsund
11886	150873	Riedelsche Dachbaustoffe GmbH		Rostock
11887	150874	Gerh. Rottländer GmbH & Co. KG		Overath
11888	150875	Runge-TSN	Technischer Service Nord GmbH	Kisdorf
11889	150876	Rettenberger GmbH &Co KG	Holz-und Heimwerkermarkt	Ottobrunn
11890	150877	ZTR Rossmanek GmbH	Werkzeuge und Maschinen	Balve
11891	150878	Jörg Rauh Handelsvertretung		Schönheide
11892	150879	Robbers Industriebedarf GmbH		Sögel
11893	150880	Otto Roller e.K.	Inh. Kersten Roller	Pirmasens
11894	150881	BMI Deutschland GmbH	Zentraler Rechnungseingang	Oberursel
11895	150882	Riedt GmbH	Beschlag-Systeme	Mosbach
11896	150883	Alexander Rillmann		Annweiler am Trifels
11897	150884	Frank Rohde	Handelsvertreter für Tischlerei-	Greifswald
11898	150885	DWB	Dach- und Wandbaustoffe	Minden
11899	150886	F. Walter Roth KG	Eisen- und Sanitär-Großhandel	Salzgitter-Lebenstedt
11900	150887	RVS Streit Schrauben		Ried
11901	150888	RBV	Ravensberger Baustoff-Vertrieb	Bielefeld
11902	150889	Ludwig Meister GmbH & Co. KG		Mainz
11903	150890	Rentas	Mietgeräte	Essen
11904	150891	Rentas	Mietgeräte	Gelsenkirchen-Schalke
11905	150892	Rentas	Mietgeräte	Recklinghausen
11906	150893	Rentas Mietgeräte	Inh. S. Krokor	Kreuztal
11907	150894	Rentas Mietgeräte	Inh. Thomas Danker	Wetzlar
11908	150895	Rentas Mietgeräte	Inh. Hans-Thomas Papsdorf	Hamm
11909	150896	Rentas Mietgeräte		Neubrandenburg
11910	150897	Christoph Röwekamp	Werkzeug und Maschinen	Wallenhorst
11911	150898	Rentas	Mietgeräte	Berlin
11912	150899	Bau- und Heimwerkermarkt	Sailer GmbH	Landsberg/ Lech
11913	150900	RENTAS	Mietgeräte	Köln-Dellbrück
11914	150901	RENTAS GmbH	Herr Markus Blachut	Duisburg-Meiderich
11915	150902	DWF Baustoff-Fachhandel GmbH		Berlin
11916	150903	Manfred Raskob	Werkzeuge-Maschinen GmbH	Wittlich
11917	150904	I&M Baustoffhandel	Bruchhof GmbH & Co. KG	Bendorf
11918	150905	RENTAS Mietgeräte		Euskirchen
11919	150906	RANIT Befestigungssysteme GmbH		Herten
11920	150907	Rentas Mietgeräte	(im toom-Baumarkt)	Duisburg-Rheinhausen
11921	150908	RKD Diamantwerkzeuge		Lutherstadt Eisleben
11922	150909	Röselers Werkzeuge	Inh. Marc Schütt	Ecklak
11923	150910	Rentas Mietgeräte	Inh. David Helbig	Falkensee
11924	150911	DBS Dachbaustoffe GmbH		Lübeck
11925	150912	Seipel	Industriebedarf	Hanau
11926	150913	Sommer Handelsgesell-	schaft mbH	Pirna
11927	150914	SBB Baumaschinenhandel GmbH		Schneverdingen
11928	150915	Sartorius Werkzeuge GmbH & Co.KG		Ratingen
11929	150916	Sauerwein & Dilcher	Liefer. Nr.74508	Bad Hersfeld
11930	150917	Seelbach International GmbH		Rennerod
11931	150918	Sindele Richard		Spaichingen
11932	150919	Sarris GmbH	Werkzeuge Maschinen	Remshalden
11933	150920	Sievering GmbH & Co. KG		Steinheim
11934	150921	Südmetall Otto Leonhard GmbH		Maisach
11935	150922	G. Sachs Eisenwaren GmbH		Kulmbach
11936	150923	SAKO Maschinen-Handels GmbH		Dinslaken
11937	150924	sauter GmbH		Herrsching
11938	150925	Süd-Metall	Beschläge GmbH	Ainring-Hammerau
11939	150926	Paul Seidler	Werkzeuge und Industriebedarf	Bautzen
11940	150927	Troglauer GmbH	(AH.-Nr. 10383, VL 77336, ZR-Nr.013	Bingen
11941	150928	PROFISHOP GmbH		Bremen
11942	150929	Sprödhuber & Sprödhuber GmbH	Holzbearbeitungsmaschinen, Service	Barbing
11943	150930	SFT-Bauelemente		Frankfurt am Main
11944	150931	Gerd Seitz GmbH		Dürrwangen
11945	150932	SANPRO® GmbH		Wermelskirchen
11946	150933	Schindler Eisenhandel GmbH		Landsberg/Lech
11947	150934	Scharpf E. GmbH	Holzbau Zimmerei	Esslingen
11948	150935	Raiffeisen Baumarkt GmbH		Willich
11949	150936	Schönberger + Weiss GmbH	Holztechnik	Nürnberg
11950	150937	Schirmer Elektromaschinenbau		Stendal
11951	150938	Hans Schmidt GmbH	Werkzeuge-Maschinen	Kaiserslautern
11952	150939	H. Schallenberg GmbH & Co.KG		Lengerich
11953	150940	Schützeichel GmbH & Co. KG	Gerätebau Wiedtal	Neustadt/Wied
11954	150941	Schär Tools GmbH & Co.KG		Crimmitschau
11955	150942	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Eifel
11956	150943	Stitz Hermann & Co.	Fachgroßhandel für Haustechnik	Barsbüttel
11957	150944	Präzisionswerkzeuge Wurzen	Dipl.-Ing. (FH) Uwe Schmidt	Wurzen
11958	150945	Schäpers GmbH		Essen
11959	150946	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Mayen
11960	150947	HDL Industrievertretung GmbH	-Gewerbegebiet Hommerich-	Lindlar / Hommerich
11961	150948	Schrauben Schneider Dortmund	Norbert Schneider	Dortmund
11962	150949	Dieter Schmidtke	Werkzeuge und Maschinen	Overath
11963	150950	Franz Scheitler	Baugeräte Werkzeuge	Taufkirchen-Potzham
11964	150951	Schleyer Sicherheit + Technik	Inh. R. Schramm	Wetter
11965	150952	Michael Schlittmeier GmbH		Vilsbiburg
11966	150953	Florian Schmideder	Eisenwaren - Werkzeuge - Normteile	Landshut
11967	150954	Klaus Schäffer	Handelsvertretung	Gommersheim
11968	150955	Schröder GmbH		Saarbrücken / Gersweiler
11969	150956	SCHLEMER GmbH	Baustoffhandel,Agrarhandel	Au bei Bad Aibling
11970	150957	M. Schulte Söhne GmbH & Co. KG		Linz
11971	150958	BAUFIX Bau - und Werkzeugbedarf	Reinhard Schermutzki	Waren (Müritz)
11972	150959	Schroeder GmbH	Das Elektrohaus	Friedberg
11973	150960	Klaus Schindler GmbH		Engelskirchen
11974	150961	Schedler KG	Fachgroßhandel für Haustechnik	Siegen
11975	150962	Gase-Center Schürmann	Holger Schürmann	Meinerzhagen
11976	150963	BSG Schünke		Heideland/ OT Königshofen
11977	150964	Schuster KG		Weingarten
11978	150965	XXL-Automotive GmbH & Co. KG		Haßfurt
11979	150966	BE-Vertrieb	Burkhard Schulze	Königstein
11980	150967	Peter Schmid Technischer Bedarf e.	Inh. Holger Schmid	Villingen-Schwenningen
11981	150968	Christian Schallenberg GmbH		Köln
11982	150969	Mario Schierlinger		Sinzing - Viehhausen
11983	150970	Schlesinger Elektrofachmarkt		Klipphausen
11984	150971	Stock  B.I.G. GmbH	(AH-Nr. 10090, VL 77336 ZR-Nr. 0135	Siek
11985	150972	Stiegeler	Eisenwaren und Brennstoffe e.K.	Kirchheim / Schw.
11986	150973	Stock  B.I.G. GmbH		Siek
11987	150974	Stinner GmbH	Baustoffe	Morsbach
11988	150975	Straacher Produktions- u. Handels-	GmbH	Lutherstadt Wittenberg
11989	150976	Steinbach Horst	Titan-Werkzeuge	Hude
11990	150977	Günter Steffan	Werkzeugvertretung	Harsewinkel
11991	150978	Peter Stolz Baustoffe		Bergweiler
11992	150979	Steiko GmbH		Hilpoltstein
11993	150980	Grabmale Strässer GmbH		Engelskirchen
11994	150981	Sikur	Chemische Produkte GmbH	Heinsberg
11995	150982	ASR-Rollen		Selters
11996	150983	MTW Tools UG		Wiesbaden
11997	150984	Stümpel GmbH & Co. KG	Dachzubehör - Werkzeuge -	Bad Wünneberg - Haaren
11998	150985	Süd Tech Handelsges. mbH		Köln
11999	150986	Lechner GmbH & Co. KG	Zerspanungstechnik	Leverkusen
12000	150987	SUCHY Montagetechnik GmbH		Bayreuth
12001	150988	Sikora Werkzeuge	Bruno Sikora	Dreieich
12002	150989	Steiner Haustechnik KG	Fachgroßhandel für Haustechnik	Bergheim bei Salzburg
12003	150990	TAUTZ Druckluft- und	Sandstrahltechnik GmbH	Mannheim
12004	150991	Tox-Duebel-Technik GmbH		Krauchenwies-Ablach
12005	150992	Techro GmbH		Rösrath
12006	150993	Thote-Industriebedarf GmbH		Henstedt-Ulzburg
12007	150994	Elektro-Walk	Werkzeuge Motoren	Salzwedel
12008	150995	Witte-Metallwaren GmbH+Co.KG		Beckum
12009	150996	trobatec GmbH	Dachbaustoffe	Niedernhall
12010	150997	Toge Dübel GmbH & Co. KG		Nürnberg
12011	150998	Thüringer Handels-GmbH	Forst- und Gartentechnik	Zella-Mehlis
12012	150999	THG Technik Handel Götze GmbH		Heinsberg
12013	151000	Thüringer Handels-GmbH	Forst- & Gartentechnik	Zellla-Mehlis
12014	151001	Thumm & Co.		Nürtingen
12015	151002	TecNet	FachGroßHandel für Elektro-	Köln-Dellbrück
12016	151003	witec GmbH	Werkzeug- und Industrietechnik	Rödermark
12017	151004	Baufachmarkt Wittmann GmbH	Baustoffe - Fliesen	Wendelstein- Gsl.
12018	151005	Baubedarf Thiele		Erfurt
12019	151006	Tools - Vertrieb & Service	Karsten Siegismund	Lossatal Ortsteil: Falkenhain
12020	151007	TRP Beschläge GmbH	Michael Thode	Lübeck
12021	151008	Tools Rent 24 GmbH		Ratingen
12022	151009	Peter Trepke	Vertrieb von Verbindungselementen	Romrod/Ober-Breidenbach
12023	151010	TRP Beschläge GmbH		Berlin
12024	151011	Coenen UG (Haftungsbeschränkt)		Kranenburg
12025	151012	Technikhandel	Inh. Mario Keith	Arnstadt
12026	151013	AMG HAUSTECHNIK KG		Niederzier
12027	151014	ARENS & STITZ HAUSTECHNIK		Pinneberg
12028	151015	Meier KG		Urmitz
12029	151016	Cordes & Graefe Osnabrück KG	Fachgroßhandel für Haustechnik	Osnabrück
12030	151017	Hermann Stitz & Co. Rostock KG	Fachgroßhandel für Haustechnik	Dummerstorf
12031	151018	Sächsische Haustechnik Dresden KG		Klipphausen
12032	151019	Cordes & Graefe Bremen KG	Haustechnik	Stuhr
12033	151020	HS-C. Hempelmann Schönebeck KG	Fachgroßhandel für Haustechnik	Schönebeck
12034	151021	Seegers KG	Fachgroßhandel für Haustechnik	Altenstadt
12035	151022	HS-C.Hempelmann KG	Fachgroßhandel für Haustechnik	Hildesheim
12036	151023	Gottschall & Sohn KG	Fachgroßhandel für Haustechnik	Grevenbroich
12037	151024	HS-C.Hempelmann Kassel KG	Fachgroßhandel für Gebäudetechnik	Kassel
12038	151025	Karl Brand KG	Fachgroßhandel für Gebäudetechnik	Gütersloh
12039	151026	Vollbrecht + Pohl KG	Fachgroßhandel für Haustechnik	Rendsburg
12040	151027	Cordes & Graefe Stade KG	Fachgroßhandel für Haustechnik	Stade
12041	151028	Wilhelm Gienger Mannheim KG	Fachgroßhandel Für Haustechnik	Mannheim
12042	151029	Gienger & Renz KG		Öhringen
12043	151030	Sächsische Haustechnik Edki KG	Fachgroßhandel für Haustechnik	Hartenstein/OT Thierfeld
12044	151031	Heldt Sauerland KG	Gebäudetechnik	Meschede
12045	151032	Sächsische Haustechnik Leipzig KG	Fachgroßhandel für Haustechnik	Markranstädt
12046	151033	Franz Silberhorn KG	Fachgroßhandel für Haustechnik	Friedberg
12047	151034	Eisenvater & Stitz KG	Haustechnik	Lüneburg
12048	151035	Rath KG	Fachgroßhandel für Haustechnik	Hochheim
12049	151036	Gienger & Funk KG Haustechnik		Wendelstein
12050	151037	Gienger München KG Haustechnik		Markt Schwaben
12051	151038	Hassmann KG	Fachgrosshandel f. Haustechnik	Hof
12052	151039	Gienger Erlstätt KG	Fachgroßhandel für Haustechnik	Grabenstätt
12053	151040	Karl Endrich KG	Fachgroßhandel für Haustechnik	Würzburg
12054	151041	Holzhauer KG		Merzig
12055	151042	Haustechnikhandel Halle-Dessau KG	Diemitz	Halle
12056	151043	G.U.T. Feldtmann KG		Lübeck
12057	151044	Birk KG		Nürtingen
12058	151045	Gienger Memmingen KG	Fachgroßhandel für Haustechnik	Memmingen
12059	151046	Kemmerling KG	Fachgroßhandel für Haustechnik	Köln
12060	151047	Gienger KG	Fachgroßhandel Haustechnik	Ettlingen
12061	151048	Rhein Ruhr Collin KG	Fachgroßhandel für Haustechnik	Duisburg
12062	151049	Bucher KG		Zimmern
12063	151050	Neugart KG	Fachgroßhandel für Haustechnik	Hennef
12064	151051	Max Carl KG	Fachgroßhandel für Haustechnik	Großheirath
12065	151052	Eisenvater KG	Fachgroßhandel für Haustechnik	Schwülper
12066	151053	Bär & Ollenroth KG	FGH für Haustechnik und Industriebe	Berlin
12067	151054	Fendel KG		Dessau-Roßlau
12068	151055	Friedrich Wüst KG	Fachgroßhandel Haustechnik	Stuttgart
12069	151056	Franz Scheuerle Ulm KG		Ulm
12070	151057	Heuer GmbH & Co. KG		Timmendorfer Strand
12071	151058	COBE Bauspezialartikel	Inh. Tiemo Fischer	Cottbus
12072	151059	Wilhelm Gienger KG	Fachgroßhandel für Haustechnik	Kornwestheim
12073	151060	August Brötje KG	Fachgroßhandel für Haustechnik	Bremen
12074	151061	Herbert Heldt KG	Gebäudetechnik	Bergkamen
12075	151062	G.U.T. Emmel KG		Leimen
12076	151063	August Brötje Handel KG	Fachgroßhandel für Haustechnik	Rastede
12077	151064	HS-C. Hempelmann KG Hannover	Fachdgroßhandel für Haustechnik	Langenhagen
12078	151065	Conmetall Meister GmbH		Wuppertal
12079	151066	TAG - Technische Anlagen Wagner	Inhaber: Frank Altenburg	Karsdorf
12080	151067	Bucher KG	Fachgroßhandel für Haustechnik	Freiburg im Breisgau
12081	151068	TECTO Dachbaustoffe GmbH		Stolpen
12082	151069	WITTE Werkzeuge	KIRCHHOFF Witte GmbH	Hagen-Fley
12083	151070	G.U.T. Feldtmann Gebäudetechnik KG	Barmbek-Nord	Hamburg
12084	151071	HTI Collin & Schulten KG	Zentrale Rechnungsprüfung	Duisburg
12085	151072	Meiler GmbH		Erkheim
12086	151073	HS-C.Hempelmann KG	Fachgroßhandel für Haustechnik	Hildesheim
12087	151074	Thewa GmbH	Bereich Shop	Wessling Neuhochstadt
12088	151075	ELPRON GmbH		Zossen
12089	151076	Max Pohlhaus	Inh. Jörg Priebe e. K.	Borkwalde
12090	151077	US-Service GmbH		Lehmrade
12091	151078	Philipps + Sturm GmbH & Co. KG	Gerüstbaubedarf	Niedernhall-Waldzimmern
12092	151079	Marcel Bornemann		Hamburg
12093	151080	B. VOMBERG GmbH & Co. KG		Schlüchtern
12094	151081	Vogt	Industrievertretungen GmbH	Bielefeld
12095	151082	Viessmann Modelltechnik GmbH		Hatzfeld-Reddighausen
12096	151083	Volk Sicherheitstechnik e.K.	Nikolaus Siegel	Ravensburg- Oberzell
12097	151084	Andreas Vollmert		Porta Westfalica
12098	151085	Peter von Ohle GmbH		Essen
12099	151086	Werkzeug-Kontor Lübeck	Inh. Thomas Hinz e.K	Lübeck
12100	151087	Vahldiek Verbindungs- und	Befestigungstechnik GmbH	Braunschweig
12101	151088	Westfalia Werkzeugcompany	GmbH & Co. KG	Hagen
12102	151089	WHS Werkzeughandel GmbH		Stutensee
12103	151090	Fachzentrum Wepler		Kirchhain
12104	151091	Weimeister Christian	Die Eisenkrämerei GmbH	Hamburg
12105	151092	Wakai GmbH		Frankfurt
12106	151093	Winte Klaus		Stuhr
12107	151094	Dieter Wich GmbH & Co. KG	Werkzeuge	Lentföhrden
12108	151095	Wartner Uwe	Werkzeuge	Bogen
12109	151096	Greiner tools & technics	Inh. Robert Greiner	Suhl-Wichtshausen
12110	151097	Michael Grenz		Hannover
12111	151098	WSH GmbH & Co. KG	Sanitär- & Heizungsgroßhandel	Warendorf
12112	151099	Wera Werkzeuge Gmbh		Wuppertal
12113	151100	gwk-Befestigungstechnik GmbH		Kitzingen
12114	151101	WEBU Werkzeugtechnik	Andreas Withoeft e.K.	Schneverdingen/Insel
12115	151102	Willig Werkzeuge		Delitzsch / OT Schenkenberg
12116	151103	Athlet-Qualitätswerkzeuge	WURO Wilhelm Uebach GmbH & Co. KG	Freudenberg-Niederndorf
12117	151104	WWB Dachbaustoffe GmbH & Co. KG		Köthen (Anhalt)
12118	151105	Otto Weirich GmbH + Co KG	Baustoff - Sanitärhandel	Breidenbach-Achenbach
12119	151106	Winkelmann GmbH & Co. KG	Harald Winkelmann	Lübbecke
12120	151107	Wüst Fernmeldetechnik	Michael Wüst	Ludwigshafen
12121	151108	WEBA Schulausstattung GmbH		Hirschhorn
12122	151109	Walther Baumaschinen und Geräte Gmb		Eisenberg
12123	151110	WEDA	Roland Werner GmbH	Reutlingen
12124	151111	WADO	Partner von Handel, Handwerk und	Riederich
12125	151112	Schrauben Schwarz	Heinz-Wolfgang Schwarz	Köln
12126	151113	Wohlhüter GmbH		Ravensburg
12127	151114	Celo	Befestigungssysteme GmbH	Aichach
12128	151115	Richard Weber	Groß- und Einzelhandel	Euskirchen
12129	151116	Wetec GmbH & Co. KG		Remscheid
12130	151117	Andreß	Industrie- & Handelsvertretung	Kleinostheim
12131	151118	FHS - Freie Handelsvertretung	Udo Weyrauch	Monzingen
12132	151119	WEPO GmbH		Leverkusen
12133	151120	Georg Friedr. Wiechard GmbH & Co. K		Lauterbach
12134	151121	Wegertseder GmbH		Ortenburg
12135	151122	Heinrich Wacker e.K.		Lüdenscheid
12136	151123	Alexander Klippenstein		Hannover
12137	151124	W & S Werkzeug und Schrauben GmbH		Rödermark
12138	151125	Die Werkkiste	Krautwald & Trölsch GmbH	Hamburg
12139	151126	Hans Willibald	Maschinenbau + Industrieservice	Gaißach Obergries
12140	151127	Handelsagentur	Elke Wohlleb	Reutlingen
12141	151128	Elting KG		Dülmen
12142	151129	WUNEX Einkaufs- GmbH & Co. KG		Trier
12143	151130	Rudolf Krämer Eisenwaren GmbH		Duisburg
12144	151131	WS GmbH	Bau & Handel	Krefeld
12145	151132	BZN Bauzentrum Esens	GmbH & Co. KG	Esens
12146	151133	Stefan Weiss	Werkzeughandel	Friedberg
12147	151134	Zinnkann GmbH	Eisenwaren-Schließanlagen	Worms
12148	151135	Zwiener GmbH & Co. KG		Laer
12149	151136	Hans Zellmer GmbH		Seeshaupt
12150	151137	Michael Zinsmeister	-Metallbaumeisterbetrieb-	Bad Feilnbach
12151	151138	Metallbau Denzer		Overath
12152	151139	Stefan Stuht GmbH		Ribnitz - Damgarten
12153	151140	Schwarzt GmbH		Lahmspringe
12154	151141	4 POWERPAC GROUP LTD.		Wellington 5240
12155	151142	COBA-Baustoffgesellschaft	für Dach + Wand GmbH & Co. KG	Osnabrück
12156	151143	RENTAS Mietgeräte	Inhaber: Jürgen Heyduck	Hattingen
12157	151144	Imexa d.o.o.		Ljubljana, Slowenien
12158	151145	Tile EZE	Abi Michailidis	Naples, Florida 34108-0124 USA
12159	151146	Borgh B.V.		AD Almere
12160	151147	Gebr. Huth KG		Bremerhaven
12161	151148	Pantaleo Stomeo		Engelskirchen
12162	151149	Cordes & Graefe KG		Bremen
12163	151150	EK/servicegroup		Bielefeld
12164	151151	Nordwest Handel AG		Dortmund
12165	151152	KEM	Krämer Einkauf + Marketing Gruppe	Duisburg
12166	151153	Kasprick Diamantwerkzeuge GmbH		Köln
12167	151154	Gerätebau Wiedtal - Schützeichel	GmbH & Co. KG	Neustadt/Wied
12168	151155	FDF-Dienstleistungsgesellschaft mbH	Cooperation für Einkauf, Logistik	Wilnsdorf
12169	151156	Hülsewig Karl	Steinindustriebedarf	Witten
12170	151157	Andreas Stockbauer		Waldkirchen
12171	151158	Interpares Mobau (Zentrale)	GmbH & Co. KG	Karlsruhe
12172	151159	HS Handelsagentur Import + Export	Hans Schlüter	Brande-Hörnerkichen
12173	151160	VIKING Tools Inc.		Gyeonggi-do 13017 South KOREA.
12174	151161	LLC Speceurotools	Office 2	Minsk
12175	151162	Löhle KG		Grolsheim
12176	151163	Weber Werkzeuge		83365 Nußdorf (Oberbayern)
12177	151164	DRILTEC, LLC		Byram, MS  39272
12178	151165	Heller Tools GmbH		Dinklage
12179	151166	UAB Kesko Senukai Lithuania		KAUNAS
12180	151167	EJOT Baubefestigungen GmbH		Bad Laasphe
12181	151168	wolfcraft SK s.r.o.		Male Dvorniky
12182	151169	wolfcraft GmbH	Warenlieferung	Kempenich
12183	151170	Adolf Würth GmbH & Co. KG		Künzelsau
12184	151171	VISWOOD		Sury Le Comtal
12185	151172	LYSI SAS		La Charité sur Loire
12186	151173	CD Juwel GmbH		Thyrnau
12187	151174	Dönges GmbH & Co. KG		Wermelskirchen
12188	151175	Franz Schoppe	Industrie- und Schiffsbedarf	Kiel
12189	151176	Madatex s.r.o.		Púchov
12190	151177	Josef Hansen GmbH & Co. KG		Solingen
12191	151178	Jäger Direkt Jäger Fischer GmbH & C	KG	Reichelsheim
12192	151179	MJM Werkzeugvertriebsgesellschaft	mbH & Co. KG	Rendsburg
12193	151180	NL Raab Karcher Meißen	STARK Deutschland GmbH	Meißen
12194	151181	Berliner Schrauben	GmbH & Co. KG	Berlin
12195	151182	Peter Belousow  GmbH		Schrobenhausen
12196	151183	Baustoff-Zentrum GmbH		Finsterwalde
12197	151184	Ernst Winterhoff GmbH & Co. KG		Remscheid
12198	151185	Schrauben-Listner	Inh.Stephan Listner	Brand-Erbisdorf
12199	151186	Dübel & Bohrer GmbH	Befestigungstechnik	Hamburg
12200	151187	JEVITH A/S		Roskilde
12201	151188	Beijing Jiu He Feng Construction	Hardware Co.,Ltd	Daxing district Beijing
12202	151189	Dachdecker-Einkauf	Soltau e.G.	Soltau
12203	151190	Holstein Alexander	Diamantwerkzeuge	Rieste
12204	151191	Bohle AG		Haan
12205	151192	Höynck & Spengler GmbH		Iserlohn
12206	151193	B.Schlichter GmbH & Co. KG		Lathen/Ems
12207	151194	MTA Schleif- und Befestigungs-	technik Vertriebs GmbH	Dasing
12208	151195	Rogger Fasteners AG		Grossaffoltern
12209	151196	Hans Möller & Sohn GmbH		Kelkheim
12210	151197	Marlow Holger	Werkzeughandel	Neubrandenburg
12211	151198	Thommel GmbH & Co. KG		Ravensburg
12212	151199	Carl Pfeiffer GmbH & Co. KG	Werkzeuge - Maschinen	Stockach
12213	151200	W. Holland-Letz GmbH & Co. KG		Bebra
12214	151201	HSB Handels- & Servicegesellschaft	für Baumaschinen mbH	Ensdorf
12215	151202	J. & F. Sorg GmbH		Düsseldorf
12216	151203	Schmieder Baumaschinen	Inh. Frank Bergerhausen	Troisdorf-Spich
12217	151204	Reinhard Wedel		Pommersfelden
12218	151205	Andreas Galler	Diamanttechnik & Spezialwerkzeuge	Waldhufen / OT Jänkendorf
12219	151206	Hahn + Kolb  Group	Werkzeuge GmbH	Ludwigsburg
12220	151207	Rülke OHG		Glauchau
12221	151208	AS Verbindungsteile	Inh. H. Antwerber	Köln
12222	151209	Oliver Grund Elektrowerkzeuge-	Handel- und Reparaturserivce	Duisburg
12223	151210	albw Handels GmbH	AH-Nr. 10162 VL-Nr. 77336 ZR-Nr. 01	Waghäusel-Kirrlach
12224	151211	Michael Baldino	Eisenwaren- und Werkzeuge	Sprendlingen
12225	151212	Eisen-Schmid GmbH & Co. KG		Hausach-Baden
12226	151213	Bau- & Kommunalservice Wegner		Waren/Müritz
12227	151214	MS Profiwerkzeuge		Sotzweiler
12228	151215	Hahn + Kolb  Group	Werkzeuge GmbH	Ludwigsburg
12229	151216	H&W Diamantwerkzeuge	Inh. Roland Bolze	Jena
12230	151217	Peter Herr	Werkzeuge und Maschinen	Baden-Baden
12231	151218	August Ring GmbH		Velbert
12232	151219	Pro Scheich		Fulda
12233	151220	O.K. Werkzeugservice	Olaf Jentzsch	Langenweißbach
12234	151221	Karcher K.E.	GmbH & Co. KG	Rheinau-Freistett
12235	151222	Herm. Stocks & Co.	(GmbH & Co)	Hamburg
12236	151223	Ingo Weber	Techn. Fachgroßhandel	Reichshof
12237	151224	Rüger GmbH	(NW 7696)	Rüsselsheim
12238	151225	Eduard Lutz Schrauben-Werkzeuge	Neuburg GmbH	Neuburg / Donau
12239	151226	Loesch shop GmbH		Quickborn
12240	151227	Rohse & Lipfert GmbH		Unterwellenborn
12241	151228	A & R Koch	Druckluft- und	Schlotheim
12242	151229	Achtermann GmbH		Troisdorf
12243	151230	TWH Trierer Werkzeughandel GmbH	(NW 7002)	Trier
12244	151231	Dachbaustoffe Rath GmbH u. Co. KG		Rostock
12245	151232	Alexander Erasmus GmbH + Co.		Düren
12246	151233	Kaiser & Stuckert	Industrie- und Baubedarf GmbH	Kiel
12247	151234	Chr. Ufer GmbH	Sanitär- und Stahlgroßhandlung	Landau
12248	151235	Karl Gollinger	Werkzeuge + Maschinen	Augsburg
12249	151236	Zwickert Eisenwaren GmbH		Emden
12250	151237	Ullner u. Ullner GmbH		Paderborn
12251	151238	Bertsch Natursteine	Rainer Bertsch	Dormettingen
12252	151239	Fendel Gebäudetechnik KG		Schwarzheide
12253	151240	Cord Jürgen Bruns		Wardenburg
12254	151241	SSG Schrauben Scholz GmbH		Berlin
12255	151242	PT. Majjatra Eizoku Indonesia		Bekasi - Jawa Barat
12256	151243	Schwan Werkzeuge	Hermann Schwandt e.K.	Remscheid
12257	151244	Stephan Heinitz		Kleinheubach
12258	151245	Lamello AG	Verbindungstechnik	Bubendorf
12259	151246	ILG GmbH	Elektrogroßhandel	Bonn
12260	151247	H.M. Lemke Handelsagentur e.K.		Königswinter
12261	151248	GEMAX Werkzeuge GmbH & Co. KG		Trier
12262	151249	BJC Tools Erp		EL Erp
12263	151250	Keil Fördertechnik GmbH		Ruppach-Goldhausen
12264	151251	G.U.T. Offenburg KG	Goldscheuer	Kehl
12265	151252	Alu Leitl GmbH		München
12266	151253	Frank Papperitz		Pirna
12267	151254	Rhodius Abrasives GmbH		Burgbrohl
12268	151255	Stronghold	steel products & engineering CO.,LT	Pathumthani
12269	151256	KnopBau GmbH	Alexander Knop	Bergneustadt
12270	151257	BAD & Duschmontagen	Michael Pöllmann	Marschacht
12271	151258	UrSprung GmbH		Miltenberg
12272	151259	ATS-Antriebstechnik	Angelo Sciannimanica	Solingen
12273	151260	MIG BALTIC SIA		Marupes nov.
12274	151261	S.C. Reisser Tehnic S.R.L.		Cluj-Napoca
12275	151262	ASW GmbH & Co. KG		Attendorn
12276	151263	Daex GmbH	Bedachungs- und Holzfachhandel	Hürth
12277	151264	Helmuth Ferlings Elektro - Großhand		Mainburg
12278	151265	Layer-Großhandel GmbH & Co. KG	Inh.: Jürgen Layer	Tettnang
12279	151266	H.A. Mönkemöller GmbH	Technischer Großhandel	Herford
12280	151267	Wiedemann Industrie- und	Haustechnik GmbH	Burg
12281	151268	Adolph C. Eisenwarenhandel		Berlin
12282	151269	TOOL-CO Irrgang Marquardt Werk-	zeug OHG	Berlin
12283	151270	Druse Handelsges. mbH	Eisen	Buchholz-Nordheide
12284	151271	Lingsch Werkzeuge		Berlin
12285	151272	Philipp GmbH		Berlin-Wittenau
12286	151273	INHA GmbH		Berlin
12287	151274	Wolfram Lochert	Befestigungstechnik	Wermsdorf
12288	151275	AMLEX Handels GmbH & Co. KG		Essen
12289	151276	Hauck W. GmbH		Schwegenheim
12290	151277	Seidler & Hentschel oHG	Bauzubehör	Bernburg
12291	151278	Stender Bautechnik	Vertrieb + Service	Ventschow
12292	151279	DER NEUE EISENHENKEL GmbH	(NW 5202)	Kiel
12293	151280	Friedrich Niemann GmbH & Co. KG		Kiel
12294	151281	Borchers & Speer	Handelsgesellschaft mbH.	Kiel
12295	151282	Pflüger - Baustoffe GmbH		Marktbergel
12296	151283	Conax UG	Axel Graneist	Leipzig
12297	151284	Sormat Oy		Rusko
12298	151285	Bach & Wesco KG		Bergisch Gladbach
12299	151286	Kuroga Montagebedarf GmbH & Co. KG		Hamburg-Eilbek
12300	151287	Wilfried Uwe Koch	Handelsvertretung	Bönningstedt
12301	151288	Meißner Bohr- und	Diamantwerkzeuge	Amelinghausen
12302	151289	Richard Petersen	Inh. Stefan Jähde e.K. Eisenwaren	Schleswig
12303	151290	Eduard Röseler	Inh. Gerd Röseler	Stade
12304	151291	Keil Innendienst		Dinklage
12305	151292	BAUIGEMA-Siegfried GmbH		Geraberg
12306	151293	Team Thaler GmbH	Diamantwerkzeuge	Oberau
12307	151294	Wölfling KG, C.		Pirmasens
12308	151295	Theodor Erich Großhandels Gmbh	Frau Gisela Karin Erich	Hamburg
12309	151296	FOXTOOL	Inh. Mirko Schweidler	Königsbrück
12310	151297	Eisen-Wolff	Uwe Wolff	Hamburg
12311	151298	DEG Koblenz	Alles für das Dach eG	Koblenz
12312	151299	HKL BAUMASCHINEN GmbH		Hamburg
12313	151300	MAKRO-STAHL	Max Krohn & Sohn Handels. GmbH & Co	Itzehoe
12314	151301	De Stalen Greep NV		Tielt
12315	151302	Schurmann Industriebedarf-	Handelsgesellschaft mbH	Reinbek
12316	151303	HG Bau- u.Hobby-	markt GmbH	Rüsselsheim
12317	151304	Eisen Trabandt GmbH		Stade
12318	151305	Salchow & Berger Baubedarf GmbH	(NW36270)	Essenbach
12319	151306	Maschinen Kaul GmbH & Co. KG		Düsseldorf
12320	151307	Würth HandelsgesmbH	Sonderartikel	Böheimkirchen
12321	151308	MARWITZ Baumaschinenhandel	GmbH & Co. KG	Hamburg
12322	151309	W. Hartmann GmbH & Co. KG	Werkzeugmarkt	Oststeinbek
12323	151310	Grenzland Baugeräte		Hückelhoven
12324	151311	E. Volz Werkzeughandels GmbH		Mayen
12325	151312	Karl Rother GmbH	Baumaschinen-Baugeräte	Köln
12326	151313	Lüttmann GmbH	Werkzeugmaschinenvertr.	Rheine
12327	151314	BWI Wahl GmbH	Gewerbegebiet "Mühlenbruch"	Königswinter
12328	151315	Heykes Diamantwerkzeuge GmbH		Wiesmoor
12329	151316	Nordwest Handel AG		Dortmund
12330	151317	Steel and Tube Holdings Ltd		Avondale, Auckland
12331	151318	Egon Jesse		Ouderkerk ad Amstel
12332	151319	Becker-Jostes GmbH & Co. KG		Sundern
12333	151320	Franko Werkstatt-Technik GmbH		Himmelkron
12334	151321	Einkaufsbüro Deutscher	Eisenhändler GmbH	Wuppertal
12335	151322	E.I.S. Kooperationszentrale für	Eisenwaren- und Hausratfach-	Köln (Ossendorf)
12336	151323	ABT-Allgemeine Befestigungstechnik	Inh.: Thomas Wlodyka e.K.	Marl
12337	151324	Gödde GmbH		Köln
12338	151325	SSK Schrauben Schmid GmbH		Dresden
12339	151326	Keilbach Befestigungssysteme GmbH		Mühlhausen
12340	151327	Befestigungs-Technik Reim	Inhaber Sylvia Huber	Am Ettersberg OT Heichelheim
12341	151328	Zweck GmbH	Werkzeuge-Autoersatzteile-Zubehör	Neuruppin
12342	151329	Dresen e.K.	Lutz Hans	Düsseldorf
12343	151330	Karl Westhelle & Sohn	SKF Kugellager, Werkzeuge, Maschine	Olsberg
12344	151331	Bäßler Befestigungstechnik	Matthias Bäßler	Geithain
12345	151332	Wilhelm Marx GmbH & Co. KG		Frankfurt am Main
12346	151333	Eisen-Schmidt GmbH & Co.	Groß- und Einzelhandel	Amberg
12347	151334	Conrad Electronic GmbH		Hirschau
12348	151335	Gillet Baustoffe		Landau
12349	151336	HV - Michel GmbH		Rodalben
12350	151337	1aSchrauben.de	Inh. Ronny Scharf	Grammetal, Utzberg
12351	151338	Gebr. Mayer GmbH & Co. KG	(EVB-Nr. 11303)	Fürth
12352	151339	Christian Forkel		Rödental
12353	151340	Krönlein GmbH + Co. KG		Schweinfurt
12354	151341	Eisen- Knorr GmbH		Weiden
12355	151342	Eisen-Jacob e.K.	Inh. Peter Weiß	Aschaffenburg
12356	151343	Davidi-Werkzeugtechnik	GmbH	Erkrath
12357	151344	Dimu Dieter Muthmann	GmbH	Berlin
12358	151345	Technischer Handel Nienhagen	Sergej Brauer OHG	Nienhagen
12359	151346	Workshop Nagel e. K.	Inh. Christian Nagel	Berlin
12360	151347	Agimus KG		Mellingen
12361	151348	Beton Kemmler GmbH		Tübingen
12362	151349	Friedrich Kicherer KG		Ellwangen
12363	151350	Klever Horst	Werkz.Masch.Schärfdienst	Rastatt
12364	151351	EVB BauPunkt	Einkauf- und Handelsgemeinschaft	Göppingen
12365	151352	fischerwerke GmbH & Co. KG		Waldachtal
12366	151353	Zweygart Fachhandelsgruppe	GmbH & Co. KG	Gärtringen
12367	151354	Gienger Regensburg KG	Fachgroßhandel für Haustechnik	Regenstauf
12368	151355	Fa. Otten OHG		Mainz
12369	151356	ZEG Zentraleinkauf	Holz u. Kunststoff e.G.	Mannheim
12370	151357	RECA NORM GmbH		Kupferzell
12371	151358	Weber Josef	Eisenwaren	Heidelberg
12372	151359	Gerhard Scheifele GmbH	Befestigungstechnik	Pfedelbach
12373	151360	DIBOTEC Befestigungstechnik	Klaus Dietrich	Baindt
12374	151361	HAGMEYER GmbH		Geislingen
12375	151362	Hacker GmbH	Holzbearbeitungsmasch.	Rosenheim
12376	151363	König J. GmbH & Co.	Maschinen-Center	Karlsruhe-Durlach
12377	151364	Hommel-Hercules-	Werkzeughandel GmbH&CoKG	Viernheim
12378	151365	Brütsch-Rüegger Tools GmbH	Deutschland	Mannheim
12379	151366	C. Schrade GmbH	Handel + Dienstleistungen	Neckarsulm
12380	151367	Thomas Rosenkranz	Technischer Handel	Neunkhausen
12381	151368	Franz Heydt Fachhandels-GmbH	(AH.-Nr. 10071, VL 77336, ZR.-Nr.01	Rastatt
12382	151369	Georg Schmieder GmbH & Co. KG	Steinindustrie und Handwerker-	Stuttgart
12383	151370	Hug Rudolf GmbH	Werkzeuge	Waldshut-Tiengen
12384	151371	Eduard Lutz Schrauben-Werkzeuge Gmb		Weilheim
12385	151372	Eberle-Hald Handel und Dienstleistu	Metzingen GmbH	Stuttgart
12386	151373	Wilhelm Nibler GmbH & Co.KG		Walldorf
12387	151374	Dr. Keller Maschinen GmbH		Freiburg
12388	151375	Ernst Triebel	Inh. Dieter Tägmeyer	Achim
12389	151376	Fritz Gabriel GmbH & Co. KG	Präzions-Werkzeuge	Bielefeld
12390	151377	Oltrogge & Co.		Bielefeld
12391	151378	Henze & Bleck GmbH		Ronneberg
12392	151379	Lutz Eduard	Schrauben-Werkzeuge GmbH	Gersthofen
12393	151380	J.H. Jaeger & Eggers	Handelsgesellschaft m.b.H	Bremen
12394	151381	BHB pro Handwerk & Industrie		Schmelz
12395	151382	ToolTeam	(NW 8547)	Köln
12396	151383	Layer-Großhandel GmbH & Co. KG	Inh. Jürgen Layer	Liebenwalde
12397	151384	TFIX POLSKA Sp. Z o.o.		Sekocin Nowy
12398	151385	Feldmann + Grever GmbH	Baumaschinen Baugeräte	Cloppenburg
12399	151386	P.H.Brauns GmbH & Co. KG	Partner für Technik	Hannover
12400	151387	BayWa AG	Baustoffe	Sonthofen
12401	151388	eFIB GmbH	Elektrotechnischer Fachgroßhandel	Gersdorf
12402	151389	Thies + Co. GmbH	Baustoffgroßhandlung	Hoya
12403	151390	EXACT GmbH & Co. KG	Präzisionswerkzeuge	Remscheid
12404	151391	Carl Wilh. Meyer GmbH & Co.	Großhandel GmbH	Oldenburg
12405	151392	Kötter + Siefker	GmbH + Co KG	Lotte-Büren
12406	151393	Lange & Co. KG	(AH.-Nr. 10019)	Kassel
12407	151394	Verrechnung der Verschmelzung	Heller / KEIL	x
12408	151395	Hans Kiesling GmbH & Co. KG	Werkzeuge, Maschinen, Schrauben,	Bremerhaven-Lehe
12409	151396	Repmann GmbH		Rödelsee-Fröhstockheim
12410	151397	Rohdenburg H. H. GmbH		Lilienthal
12411	151398	Eisen Vetter GmbH		Urbach
12412	151399	GB-Breidenstein	Diamantwerkzeuge	Dillenburg
12413	151400	Lerbs AG		Stuhr
12414	151401	Böwe GmbH		Aurich
12415	151402	Friedrich Detering GmbH		Emden
12416	151403	Schreiber Baumaschinen	GmbH & Co. KG	Bremen
12417	151404	Werner Pigorsch GmbH	Werkzeuge - Maschinen	Bremerhaven
12418	151405	Kolster	Inh. Bastian Grimm e.K.	Osterholz-Scharmbeck
12419	151406	Johannes Lefeld GmbH		Rietberg
12420	151407	Rentamin Werkzeugvermietung u. -	service UG	Bruckmühl
12421	151408	TIM Service GmbH		Bad Saulgau
12422	151409	Gebben & Heidemann UG & Co. KG	Agrar- & Industriebedarf	Haren-Wesuwermoor
12423	151410	UAB "Technosta"		Kauno
12424	151411	H.J. Bergmann	Handelsges. mbH & Co. KG	Bremen
12425	151412	Fricke GmbH & Co. KG	Werkzeughandel	Flechtorf
12426	151413	Aug. Heseding GmbH		Lohne
12427	151414	Industriebedarf  Niemann-Laes GmbH		Lüneburg
12428	151415	Perschmann Hch. GmbH	Werkzeuge und Beratung	Braunschweig
12429	151416	Carl-Arnold Brill GmbH	Baubeschläge   Industriebedarf	Nordhorn
12430	151417	Fritz Weg GmbH & Co. KG	(NW 7938)	Eschenburg-Wissenbach
12431	151418	Beli	Beyer + Liessmann KG	Kriftel
12432	151419	Mr. Clifford Staines	Phone: +44 7526 702200	Blackhall, Co. Durham
12433	151420	Werkzeug-Vogel	Inh. Kamila Vogel	Fronhausen/Lahn
12434	151421	Wilhelm Götte GmbH	Baumaschinen Baugeräte	Kassel
12435	151422	D-Tack Klebeband GmbH		Hüttlingen
12436	151423	Martin Freimuth Baumaschinen	Inh. Gerd Schellhaas	Oestrich-Winkel
12437	151424	Borrmann Edgar GmbH & Co. KG	Hausger.-Eisenw.-Werkzge	Fernwald
12438	151425	Eisen-Fischer GmbH & Co. KG	(NW 7229)	Limburg
12439	151426	FILO Baumaterial-Support GmbH		Döttingen
12440	151427	tools & more Industriebedarf	Frank Simon	Halle / Saale
12441	151428	Wittmann Werkstattbedarf GmbH		Günding
12442	151429	InDia Thiemt	Industriebedarf & Diamanttechnik	Bad Salzdetfurth
12443	151430	Stahl & Krähe GmbH	Werkzeug- u. Maschinenhandel	Zweibrücken
12444	151431	Wölpert Theodor GmbH & Co.	z.Hd. Herrn Barth	Bad Waldsee
12445	151432	SC OMP SRL		Bacau
12446	151433	Homberg Eisenhandel	GmbH	Dingolfing
12447	151434	I.S.M. Industrieservice GmbH		Babenhausen
12448	151435	Ladwein GmbH & Co. KG		Dierdorf
12449	151436	Kloy GmbH		Neustadt/Weinstraße
12450	151437	SCHEIBER GmbH		Weilerbach
12451	151438	Robert Schlott	Werkzeuge und Maschinen	Geretsried/Gelting
12452	151439	blizz-z Handwerk Direkt GmbH		Feuchtwangen
12453	151440	Andresen & Jochimsen	Exportpak GmbH & Co. KG	Hamburg
12454	151441	Uhlendorff, Gerhard	GmbH & Co. KG	Mönchengladbach
12455	151442	BEVER GmbH		Kirchhundem
12456	151443	GFB Handelsgesellschaft für Befesti		Oberhausen
12457	151444	Baustoff-Union	GmbH	Nürnberg
12458	151445	Grünhage Baumaschinen	Verkauf - Vermietung - Reparatur	Irxleben b. Magdeburg
12459	151446	Wollschläger GmbH & Co. KG		Bochum
12460	151447	Goldmann Roland	Fassadenbauer	Pforzheim
12461	151448	Peter von Ohle GmbH		Essen
12462	151449	Bauwaren Mahler GmbH		Augsburg
12463	151450	Herrmann Alois GmbH	Eisenwaren	Merchweiler
12464	151451	Profixings Pribon BV		Kasterlee
12465	151452	Berger Bau- und Industriebedarf Gmb		Traunstein
12466	151453	Friedberger Eisenhandl.	Chrisitan Knieß GmbH	Friedberg
12467	151454	GMS Bautechnik GmbH		Klagenfurt am Wörthersee
12468	151455	Keller + Kalmbach GmbH	(AH.-Nr.10031, VL 77336, ZR.-Nr.013	Unterschleißheim
12469	151456	Eisen Fischer		Nördlingen
12470	151457	ChemTechniek Nederland		Veenendaal
12471	151458	Hüllinghorst Maschinenhandel	GmbH & Co. KG	Bielefeld
12472	151459	Stockert Großhandels-	GmbH	Hohenbrunn/M.
12473	151460	Rockermeier btb	Diamanttechnik	Reichertshofen/Hög
12474	151461	Neustrelitzer Industriebedarf	Beilke GmbH	Neustrelitz
12475	151462	TRUTEK Fasteners Polska SP z.o.o.		Raszyn, Warszawy
12476	151463	Otto Schulte	Inh. Klaus Grünewald e. K.	Wuppertal
12477	151464	team baucenter GmbH	Niederlassung Eggebek	Eggebek
12478	151465	Produebel GmbH	Der Befestigungsspezialist	Leipzig
12479	151466	WMH e.k.	Werkzeug- und Maschinenhandel	Freiburg
12480	151467	IBS Industrieofenbau GmbH		Denkendorf
12481	151468	Dubick & Stehr	Baumschinen GmbH  (EVB Nr. 10402)	Hamburg
12482	151469	Eisen-Schneider	Inhaber Christoph Hassenbach e.K.	Wiesbaden-Schierstein
12483	151470	Albert Berner GmbH		Künzelsau
12484	151471	Lorenz Drucklufttechnik		Grub am Forst
12485	151472	Hans Daniels GmbH   (HB-Nr.336639)		Dortmund
12486	151473	W. Herr GmbH	Baumaschinen / Baugeräte	Kelkheim / Fischbach
12487	151474	Fehrs Baustoffe GmbH		Vaale
12488	151475	Hocke Baubedarf GmbH(HB-Nr.692778)		Wiesbaden
12489	151476	Weigel Werkzeuge OHG	Inh. Jens & Michael Weigel	Burbach
12490	151477	Lotter G.F. GmbH	(AH.-Nr. 10195, VL 77336, ZR.-Nr.01	Neutraubling
12491	151478	Tegral GmbH & Co. KG		Überherrn
12492	151479	Scholly Montagezubehör GmbH		Perchtoldsdorf
12493	151480	Lutz	Schrauben und Werkzeuge	Neubrandenburg
12494	151481	S&W Metall und Werkzeug GmbH		Alfeld
12495	151482	Görlacher GmbH	Handwerkstadt	Villingen-Schwenningen
12496	151483	Schultze GmbH	Werkzeuge	Schönebeck
12497	151484	Ackrutat GmbH & Co. KG		Neumünster
12498	151485	Industrial Technologies	Bielefeld GmbH	Bielefeld
12499	151486	Hilbertz GmbH & Co. KG		Wallenhorst
12500	151487	WERKZEUGPROFI KG		Lutherstadt Wittenberg
12501	151488	Niemann Friedrich	GmbH & Co. K.G.	Bentwisch/Rostock
12502	151489	Blumenbecker Industriebedarf GmbH		Beckum
12503	151490	THG Technische	Handelsgesellschaft mbH	Brake
12504	151491	Krehahn Bauservice GmbH	Gewerbeg. Steinkreuzweg	Naumburg
12505	151492	TOOLS	Werkzeughandel GmbH	Großenhain
12506	151493	LEITERMANN GmbH & Co. Fachmarkt KG		Göpfersdorf
12507	151494	Lotter Metall GmbH & Co. KG	Stammhaus Zedtlitz	Borna / OT Zedtlitz
12508	151495	dth	Kleber + Krumbiegel GmbH	Kesselsdorf
12509	151496	Richter	Bau-und Industriebedarf	Friedersdorf
12510	151497	Bruno Zachenbacher	Werkzeugvermietung	Düsseldorf
12511	151498	Bach GmbH Fachmarkt für	Industrie und Profis	Marienberg
12512	151499	Pauling Eisenwaren	Werkzeuge & Arbeitsschutz	Leipzig
12513	151500	Gierth & Herklotz	Mietgeräte GmbH	Bernau
12514	151501	Kadow	Handel und Service e.K.	Greifswald
12515	151502	Leiwema Ochs KG	Werkzeuge - Eisenwaren	Markkleeberg
12516	151503	Jaschinsky Werkzeuge GmbH & Co. KG		Magdeburg
12517	151504	Ralf Paufler	Werkzeugfachhandel	Radebeul
12518	151505	Illgen Frank	Werkzeuge	Neustrelitz
12519	151506	Hüllinghorst Maschinenhandel	GmbH & Co. KG	Prenzlau
12520	151507	LHG Leipziger Handeslgesellschaft m	AH-Nr. 10304, VL 77336, ZR-Nr.0135	Leipzig
12521	151508	Manderscheid	Werkz.,Masch.,Ind.bedarf	Hoyerswerda
12522	151509	G. Wurth GmbH	Schrauben-Werkzeuge-Normteile	Niederfischbach
12523	151510	Thalheimer Werkzeughandel	Inh. Rüdiger Zilly	Thalheim
12524	151511	PRIVATVERKAUF KEIL		Dinklage
12525	151512	Beeck & Koch	Inh. Henrik Pflugmacher e. K.	Braunsbedra
12526	151513	Stock  B.I.G. GmbH		Siek
12527	151514	Krämer & Feldmann GmbH		Hamburg
12528	151515	Freitag	Werkzeuge und Industriebedarf GmbH	Neuenkirchen
12529	151516	STZ Klingner GmbH	(NW 4863)	Pölzig
12530	151517	Hantel Montagetechnik	Großhandelsges. b.R.	Renzow
12531	151518	Nienhaus, Thielkes & Co. GmbH		Coswig-Dresden
12532	151519	Kirsch	Bau- und Industriebedarf GmbH	Belgershain
12533	151520	Manfred Faske GmbH & Co. KG	(AH.-Nr.10066)	Vechta
12534	151521	WMB-Walther GmbH Fachhandel	Werkzeuge-Maschinen-Baubeschläge	Arnstadt
12535	151522	Hans Humpenöder GmbH		Schwabach
12536	151523	Nagel Baumaschinen	Magdeburg GmbH	Barleben-Magdeburg
12537	151524	Hauschild Jürgen GmbH		Berka/Wera - OT Wünschensuhl
12538	151525	Wurster Gebr.	Werkzeugfachhandel	Woltersdorf
12539	151526	Augustin GmbH		Gunzenhausen
12540	151527	Detlef Dummert	Gewerbebetrieb	Berlin
12541	151528	Ihr Werkzeughandel	Inh.  Holger Antonijevic	Schwedt
12542	151529	Georg GmbH	Grosshandel	Breitscheid
12543	151530	Reinhold Werkzeuge		Stollberg/Erzgeb.
12544	151531	Kelterborn Schweißtechnik GbR		Saalfeld
12545	151532	Barm Werkzeughandel		Ganderkesee/Heide
12546	151533	Wildenhayn + Wachholz OHG		Blankenfelde
12547	151534	SVR GmbH	Kloska-Technik	Rostock
12548	151535	Mehlhorn GmbH	Baumaschinen Baubedarf	Erfurt
12549	151536	Gassmann Industriebedarf GmbH		Heiligenstadt
12550	151537	T.E.A.M Industriebedarf GmbH		Kall
12551	151538	Ullrich Ralf		Hohleborn / Floh -Seligenthal
12552	151539	Wiemann GmbH	Elektrogroßhandel	Bünde
12553	151540	BEROLINA	Werkzeug-Fachhandel GmbH	Berlin
12554	151541	Schweißtechnik - Industriebedarf	Drescher	Neustrelitz
12555	151542	DreBo	Werkzeugfabrik GmbH	Altshausen
12556	151543	Ch. Bonnet & Fils S.A.R.L.	ZA de la Weidmatt	Monswiller
12557	151544	Willers Nachf. OHG	Inh. Fischer + König	Oldenburg
12558	151545	Raimund Scheja	Werkzeug Maschinen Schweißtechnik	Heygendorf
12559	151546	Paulsen Detlef	Betriebsausrüster GmbH	Pampow/Schwerin
12560	151547	Rokossa GmbH	Elektromaschinen	Melle
12561	151548	SSK Schrauben Schmid GmbH		Kirchheim/Teck
12562	151549	Holzhauser GmbH	Baumaschinen-Schalung-Baugeräte	Kirn
12563	151550	WELU Germany GmbH		Hutthurm
12564	151551	Einkaufs- und Liefergenossenschaft	des Bau- und Baunebenhandwerks	Meißen
12565	151552	BVD Bautechnik	Handelsgesellschaft mbH	Ueckermünde
12566	151553	Dieter Kurth GmbH	Fachhandel für Dach und Fassade	Burscheid - Dürscheid
12567	151554	MOURITS TOOLS & TECHNIQUES B.V.		Barendrecht
12568	151555	BEV Baugeräte GmbH		Mönchengladbach
12569	151556	Werner Schweißtechnik GmbH & Co.KG	(NW 4869)	Görlitz
12570	151557	Bohnsack Wilhelm	Werkzeuge + Schweißtech.	Greifswald
12571	151558	Schaebbicke-Präzisionswerkzeuge	Inh. Manfred Schaebbicke	Berlin
12572	151559	BUCHBERGER	Baugeräte Handel GmbH	Ingolstadt
12573	151560	Perfekter Halt oHG	Ralf Postler - Jutta Hämmerling -	Remscheid
12574	151561	Wiegand Fuchs		Neuensalz
12575	151562	ARTEC	Arbeitstechnik, Maler & Baubedarf	Erfurt
12576	151563	industrie-bedarf MEYER KG		Gütersloh
12577	151564	Kuhfuss August	Nachf. Ohlendorf GmbH	Dessau
12578	151565	Hobex Fachhandels GmbH	Partner für Licht und Handwerk	Berlin-Charlottenburg
12579	151566	IuG Industrie- u. Gewerbe-	Fachgroßhandels GmbH	Chemnitz
12580	151567	KTG Baumaschinen	(EVB Nr. 11145)	Berlin
12581	151568	JGV GmbH		Grafenhausen
12582	151569	Peter Belousow GmbH		Neuburg/Donau
12583	151570	Manfred Binz	Diamant & Bautechnik	Gießen
12584	151571	Baer Ultra Präzisionswerkzeuge		Weinheim
12585	151572	HBV Hermsdorfer Beschlag	Vertrieb GmbH	Hermsdorf
12586	151573	Mac Panther GmbH	Maschinenbau	Bremen
12587	151574	Eberle-Hald Handel und Dienstleistu	Metzingen GmbH	Metzingen
12588	151575	Artmann Werkzeug- und	Maschinenvertriebs GmbH	Ahaus-Wüllen
12589	151576	Hartjenstein	Schrauben & Industriebedarf	Wilhelmshaven
12590	151577	Montec GmbH		Albstadt
12591	151578	WE-MA-TEC	Techn. Handel GmbH	Limburg
12592	151579	Pröbster Ludwig		Hilpoltstein
12593	151580	Robert Mann	Maschinen Werkzeuge Schweißtechnik	Ebsdorfergrund OT Hachborn
12594	151581	FWS GmbH & Co.KG		Hagen
12595	151582	MAH Werkzeuge		Eggolsheim
12596	151583	Schrauben Weiß	Normteile	Aue
12597	151584	Bude GmbH		Roßleben
12598	151585	Händel Baugeräte	GmbH	Ingolstadt
12599	151586	Schuebo GmbH		Kreuztal
12600	151587	Brema Baugerätehandel GmbH		Hohenlinden
12601	151588	WEO Werkzeughandel	Essen-Oldenburg GmbH	Essen-Oldenburg
12602	151589	BSB Service für das Baugewerbe GmbH		München
12603	151590	Markus Schwarz	Diamantwerkzeugtechnik	Ravensburg - Schmalegg
12604	151591	Artur Beglau	Werkzeug-Fachhandel	Taucha
12605	151592	DTS Diamanttechnik	Manfred Quandt	Stutensee
12606	151593	Maier + Kaufmann GmbH	Baustoffe	Steinach
12607	151594	Bilawsky Leopold	Maschinen - Werkzeuge	Murg - Niederhof
12608	151595	PIEL DIE TECHNISCHE	GROSSHANDLUNG GmbH	Soest
12609	151596	Industriebedarf Ohmert GmbH		Euskirchen
12610	151597	ABRABORO KFT.		Budapest
12611	151598	BSG Baugeräte	Schünke GmbH	Heideland/OT Königshofen
12612	151599	Berliner Schrauben GmbH & Co. KG	Niederlassung Oer-Erkenschwick	Oer-Erkenschwick
12613	151600	Buckmann Bauzentrum	GmbH & Co. KG	Bremen
12614	151601	PROFESS	Baubedarf und Diamanttechnik	St. Leon-Rot
12615	151602	Padre-Paul Dreiner	Verwaltungs UG & Co. KG	Wermelskirchen
12616	151603	ATTERER Stahlcenter GmbH		Marktoberdorf
12617	151604	Odenwälder Baumaschinen GmbH	(AH.-Nr. 10374,VL 77336, ZR.-Nr.013	Mörlenbach
12618	151605	Busse Technischer Großhandel GmbH	& Co KG	Emden
12619	151606	Niklaus Baugeräte GmbH	(AH.-Nr. 10378)	Gomaringen
12620	151607	EBV Werkzeug- und Verbindungs-	elemente Vertriebs GmbH	Bleialf
12621	151608	Wilh. Jansen-Eisenjansen	GmbH & Co. KG	Geilenkirchen
12622	151609	Berliner Schrauben GmbH & Co. KG	Zweigniederlassung Münster	Münster
12623	151610	Bauzentrum Pfaffenhofen GmbH & Co.K	(EVB Nr. 11326)	Pfaffenhofen
12624	151611	Baustoff Union GmbH & Co KG	Baugeräte/Werkzeuge 174504	München
12625	151612	E&B Stahlhandel GmbH & Co. KG	L-Nr.558	Bendorf
12626	151613	Ronald Brauer	Vertrieb-Service-Vermietung	Landsberg
12627	151614	Seefelder GmbH	Baubeschläge - Werkzeuge	Landshut
12628	151615	Leymann Albert GmbH & Co	Bau - Zentrum	Sulingen
12629	151616	B & W Befestigungstechnik	Werkzeuge	Ludwigslust
12630	151617	Staubach & Christiani GmbH		Gelsenkirchen
12631	151618	Bergander KG Jörg	Werkzeuggroßhandel	Schipkau
12632	151619	Neptun Werkzeuge AG		Däniken
12633	151620	VBS Verbindungstechnik &	Baustoffhandel	Grammetal OT Isseroda
12634	151621	BBI Befestigungstechnik	GmbH & Co.KG	Hameln
12635	151622	IHW Koch	Inh. Frank Lutze	Nordhausen
12636	151623	Otto Roth GmbH & Co. KG	Schrauben- Rohrleitungsartikel	Stuttgart
12637	151624	CS Secutec	Handelsgesellschaft mbH	Speicher
12638	151625	WEYLAND HAUSTECHNIK KG		St. Florian am Inn
12639	151626	Berger GmbH     (EVB Nr.10202)	Bau und Industriebedarf	Eggenfelden
12640	151627	Machens Industriebedarf GmbH		Hohenhameln/Clauen
12641	151628	A-Z Baumaschinenhandel Hattingen	GmbH (EVB Nr. 10120)	Hattingen
12642	151629	HEMÜ Werkzeuge GmbH		Linsengericht-Altenhaßlau
12643	151630	Beutlhauser WaGro		Regensburg
12644	151631	KaDo Baumaschinen	Baugeräte GmbH	Neunkirchen
12645	151632	Alois Piller	Maschinenhandel	Kollnburg
12646	151633	Carl Beutlhauser	Baumaschinen GmbH	Rednitzhembach
12647	151634	BauPunkt Flügel GmbH	(EVB Nr. 10606)	Wismar
12648	151635	Be Pe	Befestigungstechnik Penz	Waldbröl
12649	151636	BHG Bau Heimwerker	Gartenmarkt GmbH & Co.KG	Altentreptow
12650	151637	Janus C.F. GmbH & Co. KG	Gewerbegebiet Hoher Damm	Wismar
12651	151638	Christian Wilhelm Plattner		Eitweg
12652	151639	Biebrach - C.H. Morgenstern GmbH		Dresden
12653	151640	EBB Erfurter	Baumaschinen & Baugeräte	Erfurt
12654	151641	Feucht Baustoffe Fliesen	GmbH	Backnang
12655	151642	dth Fachgeschäft	Ingo & Olaf Hartmann GbR	Chemnitz
12656	151643	Tobias Ebeling	Werkzeugfachhandel	Alsleben
12657	151644	WESCO KG		Wenden
12658	151645	Illgen Werkzeuge und Bautechnik		Oelsnitz
12659	151646	PROMATECH	Trading GmbH	Hamburg
12660	151647	Stefan Balleis e.K.	(NW9006)	Baar
12661	151648	mkw Werkzeuge & Maschinenfachhandel	Inh. Klaus Mayer	Schlüsselfeld
12662	151649	Matthias Schäfer	Elektrowerkzeuge	St. Ingbert
12663	151650	M+V Bauservice OHG.		Waren (Müritz)
12664	151651	Werner Uwe	Industriebedarf	Barnstorf
12665	151652	H. Gr. Beilage GmbH & Co. KG		Vechta
12666	151653	CCD Diamanttechnik	Inh. Uwe Gerecke	Bremen
12667	151654	Bauzentrum Pfaffenhofen	GmbH & Co. KG	Schrobenhausen
12668	151655	Bauzentrum Pelzer GmbH	L-Nr. 720034	Köln
12669	151656	K.S.V. Srl	Gianfranco Forciniti	ORTONA (CH)
12670	151657	TIS	Technischer Industriebedarf Schorr	Nonnweiler
12671	151658	GUILLET SAS		VILLEBOIS
12672	151659	Hess Germany		Herne
12673	151660	Fälschle Werkzeuge & Maschinen	Industriebedarf	Deiningen
12674	151661	Kasberger Baustoffe GmbH	z.Hd. Herrn Erze	Neuötting
12675	151662	Bühler - Bauzentrum		Schramberg
12676	151663	Krebeck Technischer Handel e.K.		Damme
12677	151664	Wilhelm Fricke SE		Zeven/Heeslingen
12678	151665	Dachdecker Einkauf Hamm	H. Lütke Harmann	Hamm
12679	151666	ATOS GmbH		Memmingen
12680	151667	Dachdecker-Einkauf eG		Lage / Lippe
12681	151668	Krause	Baumaschinen - Baugeräte GmbH	Dollern
12682	151669	Arreche GmbH		Münchweiler
12683	151670	Baustoff-Zentrum GmbH	Lauchhammer	Lauchhammer
12684	151671	Baustoff-Zentrum GmbH	Herzberg	Herzberg
12685	151672	Leigh tools & accessories Limited		Leigh Lancashire WN7 1SH
12686	151673	Gnädig GmbH	Fachmarkt	Lahr
12687	151674	MS Baubedarf	Mario Steiner	Großfahner
12688	151675	Carl Hinrichs oHG	Eisenwaren	Augustfehn-Apen
12689	151676	MK Baubedarf Nord GmbH		Neumünster
12690	151677	Black & Decker	European Accessories Business	Slough, Berks SL1 3YD
12691	151678	Erwin Hellmuth	Maschinen und Diamantwerkzeuge	Heilsbronn
12692	151679	Eberle-Hald Handel u. Dienst-	leistungen Metzingen GmbH	Meckenbeuren
12693	151680	Faitsch OHG		Trossingen
12694	151681	Metallgeno GmbH		Pasewalk
12695	151682	Von der Heydt		Speyer
12696	151683	Baugema Baumaschinen	GmbH	Pastow
12697	151684	bhv quattro GmbH	(ADRESSE NICHT MEHR AKTUELL)	Saarbrücken
12698	151685	Fidel Schub GmbH & Co. KG		Viechtach
12699	151686	ASAMCO CV		Bornem
12700	151687	E.G. Kistenmacher GmbH & Co. KG		Hamburg
12701	151688	Wertheimer Betonfertigteile GmbH		Baden-Baden
12702	151689	Ernst Blanke Baustoffe	GmbH & Co. KG	Wunstorf
12703	151690	We-Di-Ma	Inh. Olaf Braunsdorf	Riesa
12704	151691	ITS GmbH (NW 4824)	Industrie Technik und	Parchim
12705	151692	Innecken Lorenz	(HB 580958)	Wismar
12706	151693	ASK Kloska GmbH		Wilhelmshaven
12707	151694	ProBau Chemnitz GmbH	Baustoff - Fachhandel	Chemnitz-Röhrsdorf
12708	151695	Dymatec		Luton Bedforedshire LU4 8NU
12709	151696	Oberflächen-Partner	Theisen + Kahl OHG	Andernach/Rhein
12710	151697	MVS Zeppelin GmbH & Co. KG		Garching b. München
12711	151698	MKT Metall-Kunststoff-	Technik GmbH & Co. KG	Weilerbach
12712	151699	Witschel GmbH	Baustoffhandel	Großenhain
12713	151700	Gienger Passau KG	Fachgroßhandel Haustechnik	Tiefenbach
12714	151701	Hans Bohner GmbH & Co. KG	Eisen-und Sanitärgroßhandel	Oettingen i.Bay
12715	151702	RSW Handelsgesellschaft mbH	LIMITED LIABILITY COMPANIES	Bautzen
12716	151703	Erika Luxem	Handelsgesellschaft mbH	Elsenfeld
12717	151704	Blank & Seegers KG	Thüringer Fachgroßhandel für	Grammetal
12718	151705	MAWILL sarl.	Materiel de Batiment	Diekirch
12719	151706	INTERNATIONAL GROUP AP SUALPE		Madrid
12720	151707	BIV GmbH  (EVB-Nr.10232)		Bindlach
12721	151708	SPIRA Baugeräte- und	Schalungslogistik GmbH	Speyer
12722	151709	CID Products LLP /  CID House	attn. Mr. Jeff Soulsby	LEEDS
12723	151710	SSH Straufhainer Schraubenhandel	Petri GmbH	Straufhain
12724	151711	Dachdecker-Einkauf Ost eG		Braunschweig
12725	151712	ZEDACH eG	Zentralgenossenschaft des	Hamm
12726	151713	Fa. Joachim Hochberger	Maschinen, Werkzeuge	Bad Endorf- Hemhof
12727	151714	Gustav Herbstreuter GmbH & Co. KG		Simmern (Hunsrück)
12728	151715	DBS Diamantbohren- und Sägen GmbH		Durmersheim
12729	151716	Sichtermann Montagebedarf		Unna
12730	151717	AccurA Diamond Tools Ltd.	Accura House	Dublin 12
12731	151718	Etanco Benelux NV - SA		Wommelgem
12732	151719	Vorpa s.r.l.		Riccione (FC)
12733	151720	Firma Ebeling	Inh. Karsten Genthe	Wolfsburg
12734	151721	HausFux GmbH		Feuchtwangen
12735	151722	Mühl Product & Service **konkurs**	Berlin/Brandenburg GmbH	Neuruppin
12736	151723	Schellberg Befestigungs-	technik-Vertriebs GmbH	Bornheim-Walberberg
12737	151724	Manuela Schneider		Engelskirchen
12738	151725	Unitech Isam Kabbani & Partners	for Building &Construction Material	Jeddah
12739	151726	Galler Hans	Werkzeuge	Geisenfeld
12740	151727	Mietzentrum Reul	Bau- und Gartengeräte GmbH	Offenbach
12741	151728	Angelo Papeo Ferramenta		Binetto (Bari)
12742	151730	Optimal-Versand	Istvan Horogh	Worbis
12743	151731	Bau- und Industriebedarf	Kai Uwe Szombach	Lüdenscheid
12744	151732	Berkele Industriebedarf &	Dienstleistungen GmbH	Bergheim
12745	151733	Faitsch Inh. Peter Ulmschneider e.K		Trossingen
12746	151734	Cut & Break Diamond Products, Inc.		Quezon City, Philippines 1105
12747	151735	Ida GmbH	Industriedachabdichtungen	Bad Marienberg
12748	151736	Europeiskie Instrumenty LLC	Office 15 (Office 315) on 3rd Floor	Minsk
12749	151737	Wovar		Groningen
12750	151738	Melle Gallhöfer Dach GmbH	NL Osterode Betriebsbedarf 0889	Neuss
12751	151739	TSR-ELSITE Oy	Attn: M.Niittymäki toimisto	Turku
12752	151740	Sousa Solutions Ltda		Rio das Ostras
12753	151741	Vydra & Herr GmbH	Werkzeuge-Maschinen-Betriebseinr.	Leinfelden-Echterdingen/Stette
12754	151742	Tobias Hölker	Heller Tools GmbH	Dinklage
12755	151743	WILMART SAS	PA Portes du Nord	LIBERCOURT
12756	151744	Plankunde Australien, Asien		Plankunde
12757	151745	Plankunde Ost-Europa		Plankunde
12758	151746	Plankunde ehem. Soviet Staaten		Plankunde
12759	151747	Plankunde Russland		Plankunde
12760	151748	Plankunde Mittlerer Osten, Afrika &	Indien	Plankunde
12761	151749	Plankunde Nord-Amerika		Plankunde
12762	151750	Plankunde Nordic		Plankunde
12763	151751	Plankunde Holland & Belgien		Plankunde
12764	151752	Plankunde DACHL		Plankunde
12765	151753	Plankunde Frankreich		Plankunde
12766	151754	Plankunde Iberia		Plankunde
12767	151755	Plankunde Süd-Europa		Plankunde
12768	151756	Plankunde England		Plankunde
12769	151757	Unifix Systems Pte Ltd	Att. Tan Puay Leng (Annie)	Singapore
12770	151758	Melle Gallhöfer Dach GmbH	Niederlassung Zittau	Zittau
12771	151759	Hans Wilms GmbH & Co. KG		Mönchengladbach
12772	151760	Kanca Makine Pazarlama ve Ticaret A		Karakoy, Istanbul
12773	151761	Neukunden-Angebot DE		Dinklage
12774	151762	Neukunden-Angebot GB		Dinklage
12775	151763	Neukunden-Angebot ENG €		Dinklage
12776	151764	Neukunden-Angebot NL		Dinklage
12777	151765	Neukunden-Angebot ES		Dinklage
12778	151766	Neukunden-Angebot FR		Dinklage
12779	151767	Elektro Brisch GmbH & Co. KG	Elektro Großhandel	Bochum
12780	151768	Adamas België NV		Herentals
12781	151769	RM Tools, UAB (LTD)		Vilnius
12782	151770	Kadach & Rick GmbH		Sankt Augustin
12783	151771	BEG GmbH		Föhren
12784	151772	FERRAMENTA PORTO DI RIPETTA S.R.L.		Roma
12785	151773	G.S.T. Griesch GmbH		Geestland-Langen
12786	151775	W. Schermuly GmbH		Villmar
12787	151776	Linde GmbH	Befestigungstechnik	Braunschweig
12788	151777	Plankunde DACHL KB Gebiet 9		Plankunde
12789	151778	Plankunde DACHL KB Gebiet 7		Plankunde
12790	151779	Plankunde DACHL KB Gebiet 5		Plankunde
12791	151780	Plankunde DACHL KB Gebiet 3		Plankunde
12792	151781	Plankunde DACHL KB Gebiet 2		Plankunde
12793	151782	Plankunde DACHL KB Gebiet 1		Plankunde
12794	151783	Schmidt's Haustechnik KG		Bürs
12795	151784	Harbor Freight Tools		Calabasas
12796	151785	Sicherheitstechnik Michael Mayer		Dachau
12797	151786	TFG Lipp KG		Zella-Mehlis
12798	151787	Bauzentrum Mayer GmbH & Co. KG		Ingolstadt
12799	151788	MAQUIMAX.PE EIRL		Trujillo
12800	151789	Reisser Csavar Kft		Szar
12801	151790	LSB Manufaktur GmbH		Engelskirchen
12802	151791	Plankunde DACHL KB Gebiet 6		Plankunde
12803	151792	Plankunde Süd-Amerika		Plankunde
12804	151793	Muster Abwicklung DE		Dinklage
12805	151794	Muster Abwicklung INT		Dinklage
12806	151795	Seojeon MJ		Hanam
12807	151796	Eelen BV		Kasterlee
12808	151797	Groenhart Group B.V.	Centraal Magazijn	Purmerend
12809	151798	SA Etablissements Jean Collas		Büllingen
12810	151799	In de Boerenhandel bv		Boechout/Antwerpen
12811	151800	Diatool BVBA		Turnhout
12812	151801	A.T.E.P.I.R. DI GUALDAMBRINI	ALESSANDRO E C. SAS	Roma
12813	151802	Di MASTROMATTEO ALESSANDRO		ROMA
12814	151803	ISF Constructions & Trade		Athen
12815	151804	SAS Prodesca		Pont d'Ain
12816	151805	Dachbaustoffe Rath GmbH & Co. KG	(Ndl. Schwerin)	Schwerin
12817	151806	JRB Handelsvertretungs GmbH	Der Heimwerker	Falkensee
12818	151807	TSSP Distribution		Astana
12819	151808	THEMIS GIANNAKIS S.A.		Athen
12820	151809	GC Linz Haustechnik KG		Linz
12821	151810	WMS - Werkzeuge + Maschinen	Inh. Uwe Sedlmaier	Bruckberg
12822	151811	4MORE	Inh. Felix Schorstädt	Kuchen
12823	151812	GIENGER spol.s r.o.		Nitra
12824	151813	BVBA IJZERWAREN NELIS	Vakhandel en Installatiebedrijf	Glabbeek
12825	151814	EURO NARCIS S.R.L.		Targu Mures, Jud. Mures
12826	151815	JEUS KOREA		GYEONGGI-DO
12827	151816	NV SERCOMAT		Arendonk
12828	151817	Lecot N.V. 51791		Kortrijk-Heule
12829	151818	NV O.M.C.T.		Averbode
12830	151819	Brico Massart		Tienen
12831	151820	Kerkstoel Profi & Sanicenter NV		Heist-op-den-Berg
12832	151821	De Sutter W&S bv		Aalter
12833	151822	BV De Sutter & Zonen		Oudenaarde
12834	151823	Bax IJzerwaren NV		Hamont-Achel
12835	151824	TD Projects		Pelt
12836	151825	Pro-Coop	-Rabattring-	Grobbendonk
12837	151826	BV STOCK VAN DE WALLE		Assenede
12838	151827	SCHRAMM KG		Landau
12839	151828	Richter Baustoffe GmbH		Barsbüttel
12840	151829	Schlüsseldienst Sandmann Münster eK		Münster
12841	151830	WMS Vertriebs- GmbH		Schwaigern
12842	151831	REWORKS bvba		Peer
12843	151832	NV Etn. ALDERS		Pelt
12844	151833	Hemmersbach	Industriebedarf GmbH	Berlin
12845	151860	Spray-Tech Kft		Budapest
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: vertrieb
--

COPY public.reports (id, owner_oid, owner_email, owner_name, customer_no, customer_name, contact_person, place, date, short_report, next_steps, classification, order_value_eur, offer_value_eur, next_visit_weeks, is_new_account, overnight, day_status, created_at, updated_at) FROM stdin;
1	0d682275-df53-4078-a65d-73f947a320c4	kkaluza@hellertools.com	Kaluza Kenneth - Heller Tools GmbH	333	SORMAT OY	attn. Simo Lieskivi	RUSKO (FINNLAND)	2025-08-18	333	333	B	333.00	333.00	333	f	f	VACATION	2025-08-18 12:54:39.550833+00	2025-08-18 12:54:39.550833+00
2	0d682275-df53-4078-a65d-73f947a320c4	kkaluza@hellertools.com	Kaluza Kenneth - Heller Tools GmbH	100002	EUMACOP für Buchhaltung	BITTE NICHT LÖSCHEN	Dinklage	2025-08-21	fkjfjk	fjkfj	B	8.00	8.00	88	t	t	ILLNESS	2025-08-18 13:05:19.340092+00	2025-08-18 13:05:19.340092+00
1378	excel-import-user	import@system.com	Guido Hinken	109643	Heka	Herr Hatvani	\N	2025-05-05	Aufgrund der schlechten Liefersituation droht der Kunden auf Bosch umzustellen. Es kann nicht sein das wieder 6x100/160mm 4Power Pro Hammerbohrer nicht lieferbar sind.	Es werden jetzt 50er Packs umgepackt damit der Kunde zufrieden ist! Aber es ist weiterhin kritisch!	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1379	excel-import-user	import@system.com	Guido Hinken	nn	Terwey	Herr Witte	Nordhorn	2025-05-07	Angebot ausarbeiten	Angebot über 7 mtr. Heller	A	\N	15000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1380	excel-import-user	import@system.com	Guido Hinken	nn	Kaiser	Herr Pesser	Blomberg	2025-05-08	4Power Anfrage	Angebot gegen Hilti	A	\N	5000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1381	excel-import-user	import@system.com	Guido Hinken	Verband	hagebau 	\N	\N	2025-05-08	Musteraufbau	Alles Lieferbar? Abstimmung mit FB	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1382	excel-import-user	import@system.com	Guido Hinken	105090	Hemmersbach	\N	\N	2025-05-08	Kauft 50er Packs 4Schneider bei Projahn	Angebot gegen Projahn kalkulieren und mit Jörg besprechen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1383	excel-import-user	import@system.com	Guido Hinken	103031	Zander	Herr Röttlingsberger	Gelsenkirchen	2025-05-09	Hausmesse	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1384	excel-import-user	import@system.com	Guido Hinken	Verband	Dannhauser	Herr Glas	Weiden	2025-05-12	Sortimentsgespräch	Gespräch 12.05.2025 um 14:00	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1385	excel-import-user	import@system.com	Jörg Priebe	103073	Capital Baustoffe 	Frau Weithe, Hr.Janosch	Berlin	2025-05-06	06.05.25 Neuheiten, Neulistung, Aktion … , doppelten Auftragswert, eventuell - 10% Aktion Lieferung 30.05.25	\N	A	\N	5000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1386	excel-import-user	import@system.com	Jörg Priebe	101322	Possling GmbH & CoKG	Hr.Pezoldt,Hr.Hentrich	Berlin	2025-05-07	108954 FOD/ 101323 LA Neuheiten, Neulistung Meissel, KS Aktion, … 10% (bis 30.05.25 Lieferung)ab gesamt 5000.-	\N	A	\N	5000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1387	excel-import-user	import@system.com	Jörg Priebe	102902	HFM Gruppe 	Herr Schilling	Luckenwalde	2025-05-14	HFM Gruppe (BZ Sommer und 3 HFM Standorte 102902 Pankow; Pilgramer 102907; Luckenwalde102901; BZ Sommer 108671 //Umbau a 8500.- (Warenrücknahme Pennerartikel Heller Einrichtung vor ca. 5 Jahren)	\N	A	\N	8500.00	45791	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1388	excel-import-user	import@system.com	Jörg Priebe	103155	Bauking Berlin Schöneberg	Jan Schwanitz	Berlin Schöneberg	2024-05-07	Sonderaktion einmaliger, interne Promoaktion -10%	\N	A	\N	2500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1389	excel-import-user	import@system.com	Jörg Priebe	106459	Handelhof PFT GmbH	Herr Buchs	Cottbus	2025-05-08	Einkaufsstop, Reteure 1a Pennerware, doppelten Auftragswert (PFT Cottb.106459; Massen 104633	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1390	excel-import-user	import@system.com	Jörg Priebe	108638	Andreas Szonn GmbH  	\N	Kolkwitz	2025-05-08	  Gersell.-nr.38369             Kd.-nr. 108638	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1391	excel-import-user	import@system.com	Jörg Priebe	100172	Mrose GmbH	\N	Forst	2025-05-08	EDE Wz Union	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1392	excel-import-user	import@system.com	Jörg Priebe	106352	Czentarra Profi Baubed.	Herr Czentarra jun.	Cottbus	2025-05-08	kein Interesse bleibt bei Bosch	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1393	excel-import-user	import@system.com	Jörg Priebe	107843	Dalhoff GmbH & Co. KG	Marcus Dalhoff (GF)	Fürstenwalde	2025-05-09	komplette Unterlage, 1.Gespräch Wettbewerb Bosch (Standort Frankfurt/Oder 108330)	\N	B	\N	\N	45804	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1394	excel-import-user	import@system.com	Jörg Priebe	101306	WorkShop Nagel	Christian Nagel	Berlin	2025-05-06	SDS Meissel, Duster Expert XC SDS plus, KS Aktion, weiter Sortimnet listen und bestellen Zusage erfogt 06.05.25	\N	B	1000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1395	excel-import-user	import@system.com	Marcel Bornemann	100469	Freidrich Lange 	Herr Ebauer	Bergedorf	2025-05-05	Kundenreklamation , Diamantbohrkrone Aufnahme abgerissen 	Verschleiß schon zu hoch für Gutschrift oder austausch	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1396	excel-import-user	import@system.com	Marcel Bornemann	103579	Dubich & Stehr 	Herr Defren	Hamburg	2025-05-05	Bestseller Aktion besprochen Angebot Push Aktion nachgefasst . Info alle großen Unternehmen habe die Auftragsbücher voll für 2 Jahre 8 machen aber erst was wenn es wieder Fördergelder gibt oder die Zinsen bei den Banken gesenkt werden damit sie Geld verdienen . ( HochTief , Strabag , Otto Wulf usw. ) 	HKS Classic neue größen Akku Handkreissägen reinbringen 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1397	excel-import-user	import@system.com	Marcel Bornemann	100469	Freidrich Lange 	Herr Nörnberg	Hamburg	2025-05-05	Marktlage und zufriedenheit mit neuem Liefranten aushorchen , möglichkeiten wieder liefern zu können .	weiter besuche und mögliche fehler von Milwalkee suchen um wieder liefern zu können 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1398	excel-import-user	import@system.com	Marcel Bornemann	109123	Rudolf Sievers	Herr Dölling	Hamburg	2025-05-05	Penner Liste von HKS besprechen und lösungen suchen . 	Waren Rückführung über Seevatal Haupthaus zum Doppelten AW.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1399	excel-import-user	import@system.com	Marcel Bornemann	100255	Niebuhr 	Herr Gelser	Elmshorn	2025-05-05	Test Trijet Ultimat gegen Hilti und BoschExpert 	Test Positiv Kunden kauft aber über EDE Lager da günstiger als direkt bei uns .	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1400	excel-import-user	import@system.com	Marcel Bornemann	104049	Egon Haupthoff	Herr Adomeit	Heiligenstedten	2025-05-06	Sortimentsüberarbeitung 	Weiterer Abverkauf bevor wir das Sortiement anpassen und die Präsenation überarbeiten 	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1401	excel-import-user	import@system.com	Marcel Bornemann	109848	Schröder Bauszuentrum 	Herr Schlüter	Itzehoe 	2025-05-06	Aktuelle unterlagen Bestseller Aktion 	Kunde ist bei Bosch und ist nicht wechselbereit 	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1402	excel-import-user	import@system.com	Marcel Bornemann	100671	Schröder Bauzentrum 	Herr Roloff	Heide	2025-05-06	Aktuelle unterlagen Bestseller Aktion 	Kunde ist bei Bosch und ist nicht wechselbereit 	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1403	excel-import-user	import@system.com	Marcel Bornemann	108228	Schlotfeld 	Herr Melchera	Niebüll	2025-05-06	Gespräch über Wettbewerber im umkreis und Preisgestaltung 	Kunder hat überwiegend Makita zubehör aber merkt das einige Kunden Heller bevorzugen 	B	300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1404	excel-import-user	import@system.com	Marcel Bornemann	104051	Bauxpert Christiansen	Herr Petersen	Niebüll	2025-05-06	Gespräch über Umstellung Schleifen von makita auf Heller besprochen planung läuft 	Fixieren des Umbaus und der Erweitung Heller Produkte im Markt 	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1405	excel-import-user	import@system.com	Marcel Bornemann	108672	Jacob Cement	Herr Agge JC         Herr Kruse EB	Flensburg	2025-05-07	Gespräch über die Erwiterung Trennen Schleifen in den anderen Standorten der Gruppe HKS Classic nochmals per PDF zugesendet um die Standorte von Makita HKS weg zu bekommen . Herr Kruse Eurobausoff war vor Ort und es ging wieder um Lieferantenkonzentration . Weitere INFO für mich einige Gespräche mit anderen Eurobaustoff Händlern können Positiv für uns werden . 	Treffen auf der Rundreise mit Herrn Agge um Standort zu Optimieren 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1406	excel-import-user	import@system.com	Marcel Bornemann	108776	Siemsen	Herr Czarnecki	Eckernförde	2025-05-07	Neuheiten Bestseller 2025 und Dispo mit Kunden MDE 	Planung Optimierung der Präsentation / Dispo mit Kunden MDE	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1407	excel-import-user	import@system.com	Marcel Bornemann	100816	Rudolf Sievers	Herr Tode	Geesthacht	2025-05-08	Anschauen der Artikel ob Retounierfähig 	Penner liste 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1408	excel-import-user	import@system.com	Marcel Bornemann	100517	Rudolf Sievers	Herr Alpert Herr Pahl	Seevetal	2025-05-08	Gespräch über die Artikel die zurück gehen sollen vereinfachung und die gegebenheiten , vorgaben der Restruckturierung der Gruppe Partner für Technik 	Nächster Termin Artikel sichten und die Rückführungen mit Doppeltem AW in die Wege leiten	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1409	excel-import-user	import@system.com	Marcel Bornemann	102203	Mölder Bauzenturm	Herr Niebuhr	Lüneburg Rettmer 	2025-05-08	Erste resüme ü ber die einrichtung und gespräche mit dem AD Herrn Martin Camp über wünsche der Kunden HSS Stepteck Bohrer …	Stepteck Fühbezug anbieten 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1410	excel-import-user	import@system.com	Marcel Bornemann	102989	Rudolf Sievers	Herr 	\N	2025-05-08	Anschauen der Artikel ob Retounierfähig 	Läuft über Seevetal zusammen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1411	excel-import-user	import@system.com	Marcel Bornemann	102750	BÜRO	Herr Bornemann	Hamburg	2025-05-09	Teamsmeeting Planung Berichte Hotel buchen Termine und Angebote vorbereiten ,	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1412	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Alfred Crone GmbH	Herr Wienert	58256 Ennepetal	2025-05-05	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP ist Herr Wienert er war heute leider außer Haus.Die Kollegin hat sich bisschen Zeit genommen. Vor Ort sind aktuell 5m Bosch mit denen man sehr zufrieden ist. Man will die Infos an Herrn Wienert weiterleiten und bei Interesse würde er sich bei mir melden. Aktuelle Unterlagen abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1413	excel-import-user	import@system.com	Pantaleo Stomeo	103093	Bauking Westfalen GmbH	Herr Christian Klaas	58093 Hagen	2025-05-05	Allgemeiner Kundenbesuch, vor Ort habe ich festgestellt das unsere Wand immer noch komplett zerrupft ist und mehrere Haken leer sind. Mit Christian Klaas heute besprochen das wir hier eine Sortimentsbereinigung + Umbau durchführen werden. Die kpl. 4m Präsentation haben wir neu geplant und Christian Klaas wird mir nun eine Auflistung der Retoure zukommen lassen um den Wert zu ermitteln, gleichzeitig werde ich vom ID ein Angebot erstellen lassen um zu sehen wie hoch der Wert ist der neu reinkommt um das dann gegenrechnen zu können. Der Umbau soll dann Ende Mai / Anfang Juni erfolgen. Aktuelle neue Unterlagen abgegeben	Angebot über die neuen Module vom ID erstellen lassen	A	\N	6000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1414	excel-import-user	import@system.com	Pantaleo Stomeo	102961	Bauking Südwestfalen GmbH	Frau Denise Lopes-Ferreira	58636 Iserlohn	2025-05-05	Allgemeiner Kundenbesuch, Kunde ist seit dem Umbau im März sehr zufrieden. Unsere Ware wird wieder vom Kunden angenommen. Wand hatte wieder einige Lücken, Denise dachte das wären Artikel aus dem Rückstand. Nachdem ich mit Paul gesprochen habe und wie alles geklärt haben was noch offen ist, konnte ich Denise davon überzeugen wieder zu bestellen da mehr fehlt als was noch im Rückstand ist. Dies will Sie nun die Tage tun. Aktuelle neue Unterlagen abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1415	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Heinz Schäfer GmbH	Hr. Kauffel & Hr. Sefkatli	58802 Balve	2025-05-05	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist sowohl Herr Sefkatli und Herr Kauffel. Herr Kauffel heute nicht im Haus daher mit Herrn Sefkatli gesprochen. Vor haben wir hier 3,75 x 2m von KWB die man erst mitte 2024 neu eingerichtet hat und man damit bisher auch sehr zufrieden ist. Man fand unsere Unterlagen usw. interessant aber meinte direkt das man jetzt erstmal noch mind. 1 Jahr warten will um zu schauen wie das mit KWB läuft da es aktuell keine Probleme usw. gibt. Herr Sefkatli wird die Unterlagen an Herrn Kauffel auch weiterleiten und sollte er was er nicht glaubt anderer Meinung sein wird man sich bei mir melden. Aktuelle neue Unterlagen abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1416	excel-import-user	import@system.com	Pantaleo Stomeo	103158	Bauking Südwestfalen GmbH	Herr Tim Bussmann	58840 Plettenberg	2025-05-05	Allgemeiner Kundenbesuch, unsere 3m Wand sieht katastrophal aus. 1/3 der Wand ist komplett leer was daran liegt das man hier nicht bestellen darf oder umlagern muss. 2/3 sind mit bunten aufklebern markiert und der Kunde ist mit der Wand auch sehr unzufrieden und würde gerne was ändern. Dies will er sich aber erstmal genehmigen lassen von der Zentrale, ich habe Ihm heute alles was er wissen muss bzgl. der Sortimentsbereinigung mitgeteilt und dagelassen. Er wird sich nun Gedanken machen und auch mit der Zentrale sprechen und dann auf uns zukommen. Aktuelle neue Unterlagen abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1417	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Bauzentrum Tönnes GmbH & Co. KG	\N	51399 Burscheid	2025-05-06	Vor Ort festgestellt das, dass Unternehmen unter der angegeben Adresse aus der Eurobaustoffliste nicht vorhanden ist.	Korrekte Adresse herausfinden und beim nächsten mal wieder besuchen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1418	excel-import-user	import@system.com	Pantaleo Stomeo	100985	Roland Luennemann GmbH	Herr Adolfo Ruggiero	51379 Leverkusen	2025-05-06	Allgemeiner Kundenbesuch, Herr Ruggiero teilte mir heute wieder mit das es sehr sehr Ruhig ist und die Kunden immer weniger kaufen würde. Er versucht unsere Artikel schon mit Spezialpreisen den Kunden anzubieten aber hier sind wir im Diamantbereich leider immer noch zu teuer im Vergleich zum Onlinehandel. Haben gemeinsam überlegt welche Möglichkeiten es geben könnte um den Umsatz zu steigern aber solange die Auftragslage so Ruhig wie aktuell ist wird man hier keine investitionen machen. Aktionen und aktuelle Unterlagen vorgestellt und abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2176	excel-import-user	import@system.com	Paulo Santos	108075	Tolway Fixings	Brian Hunt	Norwich	2025-06-12	Not Buying	\N	C	\N	\N	5	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1419	excel-import-user	import@system.com	Pantaleo Stomeo	102865	Kipp & Grünhoff GmbH	Herr Andreas Engelmann	51427 Bergisch Gladbach	2025-05-06	Allgemeiner Kundenbesuch, es war geplant das ich heute bei diesem Kunden vorbei fahre. Zufällig hatte er morgen angerufen und um einen Besuch gebeten da er eine Reklamation vorliegen hat. Als ich dann hier war haben wir festgestellt das die reklamierten Bohrer nicht von Heller sind sondern Makita Bohrer. Sonst ist der Kunde mit Heller sehr zufrieden, Der Verkauf läuft wie überall immer noch sehr schleppend, er will aber  jetzt in kürze wieder ne Bestellung tätigen da paaar Haken leer sind. Aktuelle neue Unterlagen vorgestellt und abgegeben. 	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1420	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Ingo Weber	Herr Ingo Weber	51580 Reichshof	2025-05-06	Kunde ist mir bekannt gewesen durch KEIL, auch bei Heller kaufte er vor ca. 2 Jahren in kleinen Mengen. Hier ist Potenzial meiner Meinung nach. Heute da gewesen und Heller vorgestellt auch wenn Ihm die Firma schon bekannt ist. All unsere Produkte und Aktionen näher gebracht. Aus dem Gespräch heraus meinte Herr Weber zu mir das man sich nicht auf einen Lieferanten festlegen wird. Man denkt hier so das man da kauft wo Aktionen oder die Preise am besten sind. Heller Aktion vorgestellt aber es besteht aktuell kein Interesse. Aktuelle Unterlagen abgegeben.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1421	excel-import-user	import@system.com	Pantaleo Stomeo	100283	Bauking Südwestfalen GmbH	Herr Frank Sparka	51766 Engelskirchen	2025-05-06	Allgemeiner Kundenbesuch, Frank Sparka teilte mir mit das nach dem Umbau im Februar unsere Ware mehr verkauft wird und besser beim Kunden ankommt was auch dazu führte das einige Haken leer waren. Dispo über die App sollte ich nicht machen weil er das über das System erfassen muss. Bin mit Ihm aber die 5m Wand durchgegangen und wir haben alles gemeinsam notiert was bestellt werden muss. Aktuelle Unterlagen und Aktion vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	1500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1422	excel-import-user	import@system.com	Pantaleo Stomeo	100562	Bauking Südwestfalen GmbH	Herr Baum	51545 Waldbröl	2025-05-06	Allgemeiner Kundenbesuch, Herr Baum hat sich bisschen Zeit genommen und wir haben uns ein wenig über die aktuelle 2m Wand vor Ort unterhalten. Er meinte das man hier vermutlich was kürzen müsste und er habe auch die Info von der Zentrale das man in diesem Jahr umbauen soll. Wie genau das aussehen soll weis man aber nicht. Wir denken aber beide nicht das man die 2m kürzt, im Gegenteil vllt kommt noch 1m dazu. Wollen aber abwarten bis die Info von der Zentrale kommt. Aktionen vorgestellt und gemeinsam mit den aktuellen Unterlagen dagelassen	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1423	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Wilhelm Rink GmbH & Co. KG 	Herr Erb & Herr. Dreier	35606 Solms	2025-05-07	Kunde gehört zur Zander-Gruppe. Der AP im EK ist Herr Patrick Erb und Herr Waldemar Dreier, die Vertriebsinnendienstleitung Herr Ralf Dreuth. Diese Woche sind aber alle bei einer Weiterbildung und haben keine Zeit. Der Kollege an der Theke meinte auch das die im Einkauf ab kommender Woche für 2-3 Wochen im Urlaub sind und man erst danach einen Termin machen kann also macht es erst im Juni 2025 Sinn. Dennoch kurz die Firma Heller vorgestellt, Ordner sollte ich nicht da lassen sondern dann abgeben wenn der Termin vor Ort mit Herrn Erb oder Herr Dreier ist.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1424	excel-import-user	import@system.com	Pantaleo Stomeo	100824	FKR Baucentrum NL Marburg	Herr Sascha Kay	35039 Marburg	2025-05-07	Allgemeiner Kundenbesuch, Herr Kay ist weiterhin mit Heller sehr zufrieden. Vor kurzem hat er noch die Wand mit einer Bestellung aufgefüllt und hier sind keine Lücken vorhanden und somit ist eine DISPO auch nicht notwendig. Die Entscheidung beim Thema Diamant ist hier leider gegen Heller gefallen, man hatte Marcrist und die hagebau hat nun vorgegeben das Diewe liefern soll. Die haben nun 1m neu eingerichtet. Sonst wie gesagt alles gut, aktuelle neue Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1425	excel-import-user	import@system.com	Pantaleo Stomeo	100038	Raiffeisen Waren GmbH	Herr Fritz	35083 Wetter	2025-05-07	Allgemeiner Kundenbesuch, Herr Fritz hat vor ort keine Reklamationen oder Beschwerden. Die Wand hatte allerdings einige Lücken, auf mein Angebot eine Dispo zu machen kam die Antwort das er es selber machen muss, es gibt Artikel die nicht bestellt werden dürfen weil man diese umlagern muss und das sieht er dann immer erst im System. Er will die Tage mal eine Bestellung machen. Das Thema Sortimentsbereinigung was wir Anfang des jahres besprochen hatte, ist auch erstmal vom Tisch, hier fehlt die Zeit intern und man will so weitermachen wie bisher. Aktuelle neue Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1426	excel-import-user	import@system.com	Pantaleo Stomeo	103003	Rompel Baustoffe GmbH	Frau Saßmannshausen	35216 Biedenkopf	2025-05-07	Allgemeiner Kundenbesuch, ich wusste das hier umgebaut werden sollte. Heute festgestellt das dies bereits erfolgt ist und man auch unsere Ware schon selbstständig neu und ordentlich platziert hat. Haben nun Platz für 1 Modul mehr wo das 3d Kreissägemodul reinkommt. Wand hatte zudem paar Lücken wo wir direkt auch ne DISPO gemacht hat + bisschen aus der Aktion verkauft.. Kunde bekommt zusätzlich noch paar Hakenreihen die man austauschen muss damit alles schön ordentlich aussieht und dann ist man hier auch wieder sehr zufrieden. Neue aktuelle Unterlagen vorgestellt und dagelassen.	DISPO + Artikel der Modulteile in den ID geben damit es als Auftrag erfasst wird 	B	700.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1427	excel-import-user	import@system.com	Pantaleo Stomeo	107710	B.S.H. GmbH	Herr Theiß	35236 Breidenbach-Biedenkopf	2025-05-07	Allgemeiner Kundenbesuch, Herr Scheld heute krank und Herr Schran hat Urlaub daher hat sich der Kollege Herr Theiß bisschen Zeit genommen der aber mit Heller eigentlich nix zu tun hat. Ihm sind keine Reklamationen oder Beschwerden bekannt, die Wand hatte einige Lücken aber Herr theiß wollte nicht entscheiden das ich da ne DISPO machen soll weil es die anderen entscheiden sollen. Aktuelle Unterlagen vorgestellt die er dann auch direkt im Ordner abgeheftet hat, dabei ist mir aufgefallen das er noch nicht alle Unterlagen hatte, diese habe ich dann aus dem Auto geholt und den Ordner mal auf dem aktuellen Stand gebracht. 	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1447	excel-import-user	import@system.com	Andreas Stockbauer	101003	Gebhardt Bauzentrum GmbH	Hr. Kopp	Fürth	2025-05-06	Schleifen besprochen, da alle anderen Stadorte bereits mit eingerichtet haben. Hat keine grosen Bedarf, wird aktuell über Schleifgitter von Triuso abgedeckt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1428	excel-import-user	import@system.com	Pantaleo Stomeo	101286	Raiffeisen Waren GmbH	Frau Elisabeth Wickert	34466 Wolfhagen	2025-05-08	Allgemeiner Kundenbesuch, Frau Wickert hatte vor ort eine Reklamation wo bei 3 Bit-Pakete die falschen Bits drin waren. Hier habe ich bilder gemacht und werde diese dem ID zwecks bearbeitung zuschicken. Frau Wickert teilte mir dann heute mit das unsere Wand an einer anderen Stelle platziert wird. Aktuell haben wir 3,75m und bei der neuen Stelle sind es 5m hier muss Sie mit Stephan Helbing klären was wir neu mit reinnehmen. (Beispiel Kreissägen vom 3D Modul auf die normalen Module erweitern. Hier muss man beachten das es 1,25m Wände sind) Sind ist Frau Wickert sehr zufrieden und wird heute spätestens morgen ne Bestellung schicken da einige Haken leer waren. Aktuelle neue unterlagen vorgestellt und dagelassen.	Reklamation in den ID geben, klären wann wir den Umbau machen und was neu dazu kommt.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1429	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Baustoff Dietrich	Herr Viktor Kusmischin	34127 Kassel	2025-05-08	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Kusmischin. Vor Ort sind 3 x2m von Triuso mit denen man lt. Herrn Kusmischin an sich auch zufrieden ist. Dennoch fand er es sehr interessant und ich habe ausführlich Heller und unsere verschiedene Konzepte vorgestellt. Er möchte jetzt im internen Netz mal paar Preise abgleichen und sollten wir da immer noch interessant sein will er sich bei mir melden um dann evtl. einen neuen Termin zu vereinbaren wo man dann über einen Behangplan usw. reden kann. Aktuelle neue Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1430	excel-import-user	import@system.com	Pantaleo Stomeo	103061	Raiffeisen Waren GmbH	Herr Kraushaar	34560 Fritzlar	2025-05-08	Allgemeiner Kundenbesuch, Herr Kraushaar hat mit erzählt das es immer noch sehr ruhig ist und man die Bestände immer noch runter fahren muss bzw unten halten muss. Daher wurde bisher auch nochso viel bestellt. Aktionen auch wieder vorgestellt, auch hier wieder die Aussage das Ihm selbst die Aktionen gefallen und er auch einiges machen würde es aber nicht darf. Neuheiten vorgestellt.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1431	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	DHT Dämmstoff Handel + Technik	\N	34225 Baunatal	2025-05-08	Allgemeiner Kundenbesuch, hier hatte der Kunde mich ja Mitte 2024 kontaktiert mit der Bitte das ich mal vorbei fahren solle weil er Heller ins Programm aufnehmen wollte. Er hat mich im kompletten letztem Jahr hingehalten und heute war ich wieder da um zu schauen wie es denn jetzt aussieht. Musste feststellen das dieser Standort geschlossen wird und daher kommt keine Einrichtung in Frage.	Keine weiteren Besuche mehr notwendig	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1432	excel-import-user	import@system.com	Pantaleo Stomeo	109708	HH Bautzen	A. Kalinowski	Bautzen	2025-05-06	Retourware ca. 2500 € begutachtet und Rücknahmen 1:2 besprochen. Alle Retourartikel wurden innerhalb der ganzen PfT- Gruppe 1 Jahr lang nicht 1 x verkauft. Herr Volbers hatte um Klärung gebeten.	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1433	excel-import-user	import@system.com	Pantaleo Stomeo	106285	Wöhlk	H. Jeremies	Grosspostwitz	2025-05-06	Rabattaktion wird beim besten Willen nicht, zu viel Ware da	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1434	excel-import-user	import@system.com	Pantaleo Stomeo	106111	Werner	Herr W + H. Spelz	Görlitz	2025-05-06	Bes. bei Stefan und Christian Spelz vom NW wegen FachWerk- Neugestaltung. Fazit: Heller bleibt in gleichem Umfang drin, jetzt 5 m- Wand. Neue Sortimente wie Schleifen, Diamant, Starlock, Sägen aber schon anderweitig besetzt.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1435	excel-import-user	import@system.com	Pantaleo Stomeo	109708	RSW	Herr otto	Bautzen	2025-05-06	Vorwiegend online-Handel mit Zubehör, hat nur nennenswerten Erfolg mit grossen Marken wie Bosch und DeWalt, Gewinne drastisch geschrumpft, fast keine Laufkundschaft mehr, öffnen Laden nur noch nach Anmeldung bzw. Klingelzeichen. Von Heller noch viel Altware da, auch die 75er Meissel	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1436	excel-import-user	import@system.com	Frank Papperitz	109708	HH Bautzen	A. Kalinowski	Bautzen	2025-05-06	Retourware ca. 2500 € begutachtet und Rücknahmen 1:2 besprochen. Alle Retourartikel wurden innerhalb der ganzen PfT- Gruppe 1 Jahr lang nicht 1 x verkauft. Herr Volbers hatte um Klärung gebeten.	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1437	excel-import-user	import@system.com	Frank Papperitz	106285	Wöhlk	H. Jeremies	Grosspostwitz	2025-05-06	Rabattaktion wird beim besten Willen nicht, zu viel Ware da	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1438	excel-import-user	import@system.com	Frank Papperitz	106111	Werner	Herr W + H. Spelz	Görlitz	2025-05-06	Bes. bei Stefan und Christian Spelz vom NW wegen FachWerk- Neugestaltung. Fazit: Heller bleibt in gleichem Umfang drin, jetzt 5 m- Wand. Neue Sortimente wie Schleifen, Diamant, Starlock, Sägen aber schon anderweitig besetzt.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1439	excel-import-user	import@system.com	Frank Papperitz	109708	RSW	Herr otto	Bautzen	2025-05-06	Vorwiegend online-Handel mit Zubehör, hat nur nennenswerten Erfolg mit grossen Marken wie Bosch und DeWalt, Gewinne drastisch geschrumpft, fast keine Laufkundschaft mehr, öffnen Laden nur noch nach Anmeldung bzw. Klingelzeichen. Von Heller noch viel Altware da, auch die 75er Meissel	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1440	excel-import-user	import@system.com	Andreas Stockbauer	108413	Peter Kasberger Baustoff GmbH	Hr. Hartl	Passau	2025-05-05	kein Verkauf von Aktionsprodukten, auch hier keine Muster vor Ort. Auftrag für Warenrücknahme/ Sortimentsbereinigung aufgenommen. Warenrücknahme wird noch von Herrn Hartl aus einzelnen NL zusammengeführt und dann zurückgeschickt. Schleifen und Trennen vorgestellt	\N	B	1200.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1441	excel-import-user	import@system.com	Andreas Stockbauer	101221	Segl Bauzentrum GmbH	Hr. Diezelt	Pfarrkirchen	2025-05-05	Reklamationsbearbeitung, Neuprodukte Schleifen, Trennen, Meissel	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1442	excel-import-user	import@system.com	Andreas Stockbauer	108410	Peter Kasberger Baustoff GmbH	Hr. Gerleigner	Pfarrkirchen	2025-05-05	keine Aktionsmuster	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1443	excel-import-user	import@system.com	Andreas Stockbauer	102931	Reisinger GmbH	Hr. Fritsche	Burghausen	2025-05-05	4 Power mit Preissenkung besprochen, aufgrund Vorliebe der Monteure möchte er es erst intern besprechen.Aktionsprodukte 	\N	B	360.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1444	excel-import-user	import@system.com	Andreas Stockbauer	101347	Baustoff Union GmbH	Hr. Heyn, Hr. Götz	Nürnberg Hafen	2025-05-06	Bestückung und Erweiterung mit Hernn Heyn besprochen, kann erst fix gemacht werden wenn Hr. Götz wieder aus dem Urlaub da ist.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1445	excel-import-user	import@system.com	Andreas Stockbauer	101241	Eisenhandel Prell GmbH + Co.KG	\N	Schwabach	2025-05-06	aktuelle Unterlagen abgegeben. 	\N	B	135.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1446	excel-import-user	import@system.com	Andreas Stockbauer	107564	STUKK ABE	Hr. Bär	Fürth	2025-05-06	aktuelle Aktion besprochen und gemailt, stellt nach und nach wieder um.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1448	excel-import-user	import@system.com	Andreas Stockbauer	107180	Bauzentrum Pfaffenhofen GmbH&Co.KG	Hr. Moll, Hr. Westermeier	Pfaffenhofen	2025-05-07	Hr. Moll hat seit Mai Stunden reduztiert und ist Mittwoch nicht mehr da. Sortimentsbereinigung bereits verschickt. Hat bei Bestellung auch Trennscheiben mit aufgenommen und KSB von Heller mitbestellt. Schrobenhausen wird von Hr. Westermeier mit betreut	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1449	excel-import-user	import@system.com	Andreas Stockbauer	108602	Moser Agrar & Baufachzentrum e.K.	Hr.Tragl	Schweitenkirchen	2025-05-07	neues Trennscheiben Schleifensortiment wird sehr gut angenommen. Reklamation Gutschrift geklärt.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1450	excel-import-user	import@system.com	Andreas Stockbauer	108239	Bauzentrum Mayer GmbH & Co.KG	Hr. Finkenzeller	Ingolstadt	2025-05-07	Kundenfrequenz geht aktuell wieder nach oben. Profitage verlaufen allerdings schleppend mit weinig interesse und nicht zufriedenstellend. Schleifen und Trennen aktuell kein Thema da zwei Lieferanten, neue Spachtelmeissel möchte er mit Thekenleiter und AD absprechen. Aktion per mail geschickt.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1451	excel-import-user	import@system.com	Andreas Stockbauer	101471	Martin Meier GmbH	\N	Gaimersheim	2025-05-07	Beide Standorte bereits von Milwaukee umgebaut	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1452	excel-import-user	import@system.com	Andreas Stockbauer	106142	Buchberger	\N	Ingolstadt	2025-05-07	Neukunde EDE, hat Bosch, Unterlagen abgegeben, Sortimentserweiterungen vorgestellt	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1453	excel-import-user	import@system.com	Andreas Stockbauer	106842	Händel GmbH	\N	Ingolstadt	2025-05-07	Nullkunde, ehemals Keil (2 Module), hat aufgrund ungangigkeit Bohrer komplett aus dem Sortiment genommen, da er hauptsächlich auf Grossgeräte und Baumschinen spezialisiert ist und in unmittelbarer Nähe von Buchberger (siehe oben) ist. Keine weiteren Besuche	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1454	excel-import-user	import@system.com	Andreas Stockbauer	102953	Max Schierer GmbH	Hr. Venus	Straubing	2025-05-08	aktuell noch wenig los, allerdings steigende Kundenfrequenz. Hat langsam seine Bestände reguliert, da er die Bestände von Cham komplett umgelagert bekommen hat. Schleifen und Trennen interessant, Unterlagen dagelassen. 225er aktuell von Butler, allerdings da auch nur 25er Pack und deutlich teurer.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1455	excel-import-user	import@system.com	Andreas Stockbauer	107685	Bauzentrum Otto Zillinger	Hr. Hies	Osterhofen	2025-05-08	Umbau Regen angesprochen, da 100% Zillinger Tochter, keine Steuerung aus Osterhofen da Regen deutlich umsatzstärker ist. Aktion vorgestellt und gemailt. Schleifen/ Trennen nicht interessant da beides von Butler	\N	B	250.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1456	excel-import-user	import@system.com	Andreas Stockbauer	109446	Meier	Hr. Gebhard	Amberg	2025-05-12	\N	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1457	excel-import-user	import@system.com	Andreas Stockbauer	103419	Hein GmbH & Co.KG	\N	Mitwitz	2025-05-14	\N	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1458	excel-import-user	import@system.com	Andreas Stockbauer	101001	Gebhardt Bauzentrum GmbH	Hr. Treutlein	Karlstadt	2025-05-15	\N	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1459	excel-import-user	import@system.com	Cord-Jürgen Bruns	105619	Willers	H. König	Oldenburg	2025-05-05	Vorher: E-Mails gescheckt; Aktion Topseller vorgestellt: Spachtelmeissel sind interessant	beim nächsten Besuch nachfassen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1460	excel-import-user	import@system.com	Cord-Jürgen Bruns	108499	Tramann	H. Wilhelm	Oldenburg	2025-05-05	Aktion Topseller vorgestellt: Auftrag bekommen	liefern	B	750.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1461	excel-import-user	import@system.com	Cord-Jürgen Bruns	107649	HKN	Herr Pentrop	WHV	2025-05-06	Aktion vorgestellt; einige spannende Artikel, aber aktuell keinen Bedarf: er will mit seinen Kollegen hierüber sprechen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1462	excel-import-user	import@system.com	Cord-Jürgen Bruns	109461	Kloska	Herr Borries	WHV	2025-05-06	Aktion vorgestellt: nicht interessant, da Bosch Premiumlieferant ist; Heller nur bei langen SDS	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1463	excel-import-user	import@system.com	Cord-Jürgen Bruns	102134	Böwe	Herr Janssen	Aurich	2025-05-06	Aktion vorgestellt; Muster bestellt	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1464	excel-import-user	import@system.com	Stephan Heinitz	107066	Flügel Handwerkerbedarf	W. Flügel	Lautertal	2025-05-05	Top-Seller-Aktion vorgestellt, Dispo, über Preise Stichsägen gesprochen, Allmat und HSS-Co neu angesprochen, Hausmesse Ende September 1. Gespräch hierüber	Turnusgemäßer Besuch - Angebote für Hausmesse 26/27.09. bis Mitte August einreichen	B	669.07	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1465	excel-import-user	import@system.com	Stephan Heinitz	102797	Linzing & Dörr	J. Funk	Biebesheim	2025-05-05	auf Kundenwunsch neuen Katalog mitgebracht, Top-Seller-Aktion vorgestellt, über mögliche Einrichtung in NDL Nierstein gesprochen - vorerst bleibt es beim vorhandenen Maxi-Tower	\N	C	\N	\N	26	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1466	excel-import-user	import@system.com	Stephan Heinitz	100733	Raiffeisen-Waren-GmbH	Herr Elbrecht	Stockstadt a. R.	2025-05-05	gehört zur Raiffeisen-Gruppe, Niederlassung schließt zum 31.05. - Ware wird auf andere Raiffeisen-Niederlassungen umgelagert	\N	C	\N	\N	0	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1467	excel-import-user	import@system.com	Stephan Heinitz	108338	Schönig & Würz	Herr Schönig	Groß-Zimmern	2025-05-05	Schließt um 16:30 - Wiederbesuch Folgetag	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1468	excel-import-user	import@system.com	Stephan Heinitz	105750	Gebhardt	Herr Seelmann	Goldbach	2025-05-06	gewünschte Unterlagen mitgebracht, kleine letzte Nacharbeiten der Ersteinrichtung erledigt, kleine Reklamation aufgrund falscher Verpackung erledigt, Top-Seller-Aktion vorgestellt, Verkaufspersonal Fragen zu einigen Produkten beantwortet, Dispos nur über EDI-Orders	über Neuheiten und Aktionen auf dem Laufenden halten, Infos AllmatPro sobald verfügbar, evtl. Muster zum testen zur Verfügung stellen	A	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1469	excel-import-user	import@system.com	Stephan Heinitz	108338	Schönig & Würz	Herr Schönig	Groß-Zimmern	2025-05-06	Top-Seller-Aktion vorgestellt, bestellt ausschließlich per Mail, Diamantprogramm angesprochen, Allmat Pro angesprochen	Infos AllmatPro wenn verfügbar, 	C	\N	\N	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1470	excel-import-user	import@system.com	Stephan Heinitz	107894	Gerhardt 	Herr Irmak	Dreieich	2025-05-06	Top-Seller-Aktion vorgestellt, auf Umbau der Warenpräsentation angesprochen - Angleichung an Ersteinrichtung in NDL Offenbach - bestellt selbst, wollte noch die kommende Werkzeugnacht im Oktober ansprechen, da Einladung schon eingegangen - soll abgewartet werden, bis erste Infos kommen	nachhaken wegen Umbau Dreieich, Vorbereitung Werkzeugnacht (Details werden mir zugeschickt, danach kann die Planung beginnen)	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1471	excel-import-user	import@system.com	Stephan Heinitz	107894	Gerhardt 	Herr Janischowski	Offenbach	2025-05-06	Scannerschienen an den Modulen fallen ab, hatte welche im Auto - Scannerschienen neu angeklebt, Top-Seller-Aktion vorgestellt, Kreissägen nachgehakt, 	regelmäßig besuchen, Schulung nochmal ansprechen beim nächsten Besuch	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1472	excel-import-user	import@system.com	Stephan Heinitz	101174	Köbig 	Herr Rahn	Ockstadt	2025-05-06	Top-Seller vorgestellt, anschl. Teams-Meeting auf Parkplatz wg. Kurzarbeit - Info durch GH, danach Heimreise um Arbeitszeit under Kurzarbeit einzuhalten 	regelmäßig besuchen, bestellt über EDI Orders	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1473	excel-import-user	import@system.com	Allgemein	102695	Hornbach Union BZ	M. Kohlbacher	Buchen	2025-05-07	Top-Seller Aktion vorgestellt, neuen Katalog mitgebracht, gelieferte VK-Etiketten gesteckt, 	regelmäßig in großen Abständen besuchen	C	\N	\N	16	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1474	excel-import-user	import@system.com	Allgemein	100515	Baufuchs	\N	Osterburken	2025-05-07	Top-Seller-Aktion vorgestellt, Kunde hat vor langer Zeit Ware bezogen - nun komplett auf KWB, sehe wenig Potential	\N	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1475	excel-import-user	import@system.com	Allgemein	100097	Hornbach Union BZ	M. Kohlbacher	Seckach 	2025-05-07	sehr kleine Niederlassung von Hornbach-Buchen, Top-Seller-Aktion angesprochen	kleine Einrichtung (1m höchstens) möglich, jedoch nicht in naher Zukunft - wird in großen Abständen wieder besucht, Kontakt auch über NDL Buchen, da gleicher AP möglich	C	\N	\N	26	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1476	excel-import-user	import@system.com	Allgemein	107809	Feucht GmbH	P. Wurst	Backnang	2025-05-12	Termin Neuheiten/neuer Katalog/Aktion	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1477	excel-import-user	import@system.com	Allgemein	100756	G. Wiedmann	M. Jahn	Urbach	2025-05-12	Modulumbau - 6 Module in 2,5D Wand integrieren, danach Erweiterung 4PowerPro Range 18-25mm	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1478	excel-import-user	import@system.com	\N	101446	Roth Baustoffe	Herr Roth	Neckargemünd	2025-05-13	Aktion/Neuheiten/neuer Kunde - kürzlich Einrichtung	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1479	excel-import-user	import@system.com	\N	101687	F. Kessel	\N	Kehl-Kork	2025-05-13	\N	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1480	excel-import-user	import@system.com	Allgemein	108629	Gnädig	T. Moog	Lahr	2025-05-13	 Regelbesuch - Neuheiten/Aktionen/Reklamationen/Regalpflege	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1481	excel-import-user	import@system.com	Allgemein	101388	Werkzeug-Jäger NDL Maulburg	\N	Maulburg	2025-05-14	Ersteinrichtung - weitere Kundenbesuche danach je nach vorhandener Zeit	\N	A	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1482	excel-import-user	import@system.com	Allgemein	108990	Schachenmeier	Hr. Walter	Efringen-Kirchen	2025-05-14	Aktion/Reklamation/Regelbesuch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1483	excel-import-user	import@system.com	Allgemein	109684	Issler und Pütz	Hr. Schlageter	Grenzach-Wyhlen	2025-05-14	Aktion/Reklamation/Regelbesuch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1484	excel-import-user	import@system.com	\N	101686	Veeser	Hr. Metzger	Freiburg	2025-05-15	Aktion/Reklamation/Regelbesuch	\N	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1485	excel-import-user	import@system.com	\N	108800	Hornbach Union BZ	Hr. Nolde	Karlsbad-Ittersbach	2025-05-15	Modulumbau (verschoben vom 02.05.2025)	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1486	excel-import-user	import@system.com	\N	102854	GoldmannLindenberger	Hr. Ponnuturai	Pforzheim	2025-05-15	Regalpflege/Aktion/Starlock-Nachbestückung	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1487	excel-import-user	import@system.com	Steve Bell	106661	Interhire	Dave	Nottingham	2025-05-07	order stock, rebar promo offer	quote starlock /jigsaw again	C	1200.00	600.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1488	excel-import-user	import@system.com	Steve Bell	100027	Merit	Max Morton	Nottingham	2025-05-07	Meeting update Diamond, offer for extra - not interested, rebar promo	SDS Max	C	\N	600.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1489	excel-import-user	import@system.com	Steve Bell	105118	Machine Mart Ltd.	Phil	Nottingham	2025-05-07	Collect warranty Return, visit shop manager new catalogue	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1490	excel-import-user	import@system.com	Steve Bell	108440	A1 Fixings Ltd.	Lee	Sheffiled	2025-05-08	quiet atm, normal business will call as usual	Regular vist	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1491	excel-import-user	import@system.com	Steve Bell	109774	Sheffield Windows	Andy	Sheffiled	2025-05-08	New literature, Van dealer promo	Follow up 2 weeks for deal	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1492	excel-import-user	import@system.com	Steve Bell	109823	U.K. Fixings Limited	Gareth	Sheffiled	2025-05-08	Rebar promo, extra discount in May order	Follow up next week	B	350.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1493	excel-import-user	import@system.com	Steve Bell	103227	G7 Industrial Supplies Ltd	Andrew Ibitson	Barnsley	2025-05-08	DSO, literature and follow up	overdue pay	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1494	excel-import-user	import@system.com	Yasir Angar	101468	HOMBERGER S.P.A.	Luca Boscarino	IT	2025-05-09	Umsatzsteigerung	Wird im Mai bestellen	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1495	excel-import-user	import@system.com	Yasir Angar	150332	G. Vella & Sons Limited	Patrick Vella	MT	2025-05-07	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1496	excel-import-user	import@system.com	Mark Smethurst	107750	Martindales industrial Fasteners	Alan	Preston	2025-05-06	discussed offer of 3% on orders over £3000. + HSS	Email details of offer.	B	300.00	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1497	excel-import-user	import@system.com	Mark Smethurst	Prospect	Allthread	Scott	Preston	2025-05-06	Catalogue and HSS promotion.	Follow up next month	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1498	excel-import-user	import@system.com	Mark Smethurst	100800	Fortress Fasteners	Pat 	Clitheroe	2025-05-06	Meeting, Hss promo and Rebar promotion.	Quote for Cutting discs	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1499	excel-import-user	import@system.com	Mark Smethurst	Prospect	Peak Hardware	Lee 	Great Harwood	2025-05-06	discussed catalogue and price list.	Follow up next month	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1500	excel-import-user	import@system.com	Mark Smethurst	Prospect	S I J Supplies	Simon	Bacup	2025-05-06	Mobile Dealer discussed HSS Promotion.	Pricing on Hss bits singles	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1501	excel-import-user	import@system.com	Mark Smethurst	108573	Power Point Northern	Alan	Thirsk	2025-05-07	Stock order and discussed Bulk order discount.	Follow up end of month.	A	\N	\N	3	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1502	excel-import-user	import@system.com	Mark Smethurst	Prospect	Paxtons Aggricultural	Phil Hurst	Northallerton	2025-05-07	catalogue and HSS promotion.	Follow up end of month.	B	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1503	excel-import-user	import@system.com	Mark Smethurst	prospect	Sam Turners Ltd	Charles Cooper	Northallerton	2025-05-07	Meeting, Hss promo and Rebar promotion.	Email Pricing and Discount	A	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1504	excel-import-user	import@system.com	Mark Smethurst	prospect	Workshop Supplies	Lewis Harrop	Newton aycliffe	2025-05-08	Catalogue and HSS promotion. NMBS member.	Email Pricing and Discount	B	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1505	excel-import-user	import@system.com	Mark Smethurst	100888	Aerotech Abrasives	Nathan	Wetherby	2025-05-08	dicussed offer of 3% on orders over £3000 +Hss	Follow up end Month	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1506	excel-import-user	import@system.com	Mark Smethurst	prospect	GR Electrical Supplies	Chris Johnson-Firth	Wetherby	2025-05-08	Discussed catalogue and price list.	Pricing and Discounts	C	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1507	excel-import-user	import@system.com	Mark Smethurst	107752	Avantifix	Adam	Leeds	2025-05-08	Discussed offer and Pick up catalogues etc.	Follow up next month	A	\N	\N	3	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1508	excel-import-user	import@system.com	Mark Smethurst	109917	CID Group	James	Leeds	2025-05-08	Catalogue and Price list.	Follow Up, Rebar promo	A	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1509	excel-import-user	import@system.com	Vorname, Nachname	150055	Cominvest	Tomas Viktora	Brno	2025-05-05	Besprechung der Hausmesse, Angebot 10%, Angebot 10+1\nVerkauf in Slowakei, Musterkoffer für Sales manager	Auftrag zu erwarten KW 21\nMusterkoffen vorbereiten	A	10000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1510	excel-import-user	import@system.com	Vorname, Nachname	105130	Oren	Martina Honolkova	43141 Údlice	2025-05-05	Lieferung von den drei Linien SDS Plus,	Konzept mit den MiniTowern abstimmen	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1511	excel-import-user	import@system.com	Jens Werner	100548	Förch	Knoth, Simone	\N	2025-05-08	Michael Hagendorn heute privat erreicht, er wurde zusammen mit über 40 anderen Mitarbeitern aufgrund der schlechten Auftragslage entlassen	Hallo Herr Werner,\n \nvielen Dank für Ihre email. Ich habe bzgl. Ihrer email eben mit meinem Kollegen aus dem Produktmanagement gesprochen.\n \nLeider ist es so, dass wir aktuell keine Ansatzpunkte für einen Ausbau haben. Das muss aber nicht so bleiben. \n \nMelden Sie sich doch gerne Ende des Jahres wieder. Ansonsten habe ich Ihren Kontakt in meinen Unterlagen und komme auf Sie zu sofern sich etwas Interessantes ergibt.\n \nBis dahin wünsche ich Ihnen eine gute Zeit.\n \nMit freundlichen Grüßen / Best Regards\n \nSimone Knoth\nPurchasing Construction\n \nTel. +49 7139 95 19214\nsimone.knoth@foerch.de\n \nTheo Förch GmbH & Co. KG\nTheo-Förch-Str. 11-15\n74196 Neuenstadt	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1512	excel-import-user	import@system.com	Jens Werner	107038	ABRABORO Kft	Markus Zimmermann	\N	2025-05-08	Angebot über Sommeraktion mit 5l Bierfass unterbreitet	Prüfung des Angebots /Lieferfähigkeit muss verbessert werden	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1513	excel-import-user	import@system.com	Jens Werner	101358	CRETEC CO. LTD	Dongdal	\N	2025-05-05	Telefonmeeting mit Dongdal wegen 2. Auftrag	100k € Auftrag erwartet Ende Mai nächstes Gespräch	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1514	excel-import-user	import@system.com	Jens Werner	103602	Black & Decker (US) Inc.	Felix Gu	\N	2025-05-07	TEAMS Meeting Auftragsbestand, reklamationen / Spring offer	versuchen Aktionsauftrag zu erhalten	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1515	excel-import-user	import@system.com	Jens Werner	106417	ALPEN-MAYKESTAG GMBH	Robert Holleis	\N	2025-05-06	Spring offer	Guten Morgen Herr Werner,\n\nwir haben unsere Reichweiten und Möglichkeiten geprüft und haben uns entschieden, \ndass wir weiterhin nur im normalen Bereich Bestellungen platzieren werden.\nDa unser Lager grundsätzlich gut bestückt ist, können wir leider keine \naußerordentlichen Mengen bestellen, obwohl der Preisnachlass natürlich interessant wäre.\nVielen Dank!\n\nFreundliche Grüße/Best regards \n\nRobert Holleis \nDirector Supply Chain	A	\N	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1516	excel-import-user	import@system.com	Jens Werner	151804	SAS Prodesca	Emmanuel Salomez	\N	2025-05-06	wöchentlich Kontakt / spring offer	nachhaken spring offer	A	50000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1517	excel-import-user	import@system.com	Jens Werner	150336	Van Roij Fasteners Europe B.V	Richard Munsters	\N	2025-05-09	Spring offer  / Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Auftrag über 52k erhalten	A	52000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1518	excel-import-user	import@system.com	Jens Werner	109571	MÜLLER & CO.	Sebastian Henke	\N	2025-05-05	Spring offer	Termin in Remscheid, 03.06.2025	A	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1519	excel-import-user	import@system.com	Jens Werner	108754	Ramset	Frazer Robinson	\N	2025-05-08	Spring offer	Kunde prüft, ob Sonderbestellung neben Konsi aufgegeben werden kann	A	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1520	excel-import-user	import@system.com	Jens Werner	100128	FE ZEVIJ BV, COOP GRHANDVER ZEVIJ	Roy van Gestel	\N	2025-05-06	spring offer	Termin nach Test 4-Schneider vereinbaren	A	50000.00	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1521	excel-import-user	import@system.com	Jens Werner	151795	Seojeon MJ	Heekyung	\N	2025-05-09	Angebot 14"+16" Trennscheiben abgegeben	nachhaken	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1522	excel-import-user	import@system.com	Jens Werner	100848	IRONSIDE	Thomas Verdy	\N	2025-05-05	Gespräch anfangs positiv. Zusage 11 von 12 Miotgliedern für Wechsel von Diager zu TCG. Durch Aktivitäten mit Marke Heller beim Mitglied Tout Faire in Frankreich wird die Entscheidung auf Ende Mai vertagt. Ohne diese Aktivität hätten wir heute die Zusage für Erstbelieferung im Okt 2025 erhalten	Dear Werner \n\nUnderstood am in vacation this week but we will have internal discussion \nAlso e meeting with Toutfaire as well because we need also to clarify things on this side \nAlso we are not against to combine ironside selection and complete it with some Heller items\nGive me 2 weeks and I will comeback to you \n\nAll the best \nThomas \n\n	A	\N	1200000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1523	excel-import-user	import@system.com	Jens Werner	151050	Neugart KG	Andreas Gundelach	\N	2025-05-05	Meeting mit Herrn Gundelach für GC Hausmessen Mai Juni. 	Rabatt für Messeaufträge ab 2,5k€	A	\N	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1524	excel-import-user	import@system.com	Jens Werner	103348	Verkatto sp.Z.o.o.	Przemysław Sadurski	\N	2025-05-05	spring offer	nachfassen	B	\N	15000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1525	excel-import-user	import@system.com	Paulo Santos	109243	Selkent Fastenings Ltd.	Richard	\N	2025-05-06	Offer for Bulk order, positive feedback	Follow up on the 19/05	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1526	excel-import-user	import@system.com	Paulo Santos	107871	Brianson Electrical	Ray	\N	2025-05-06	Order 	\N	B	607.26	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1527	excel-import-user	import@system.com	Paulo Santos	102654	Corefix Ltd	Kieron	\N	2025-05-06	Order 	\N	C	289.97	\N	45805	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1528	excel-import-user	import@system.com	\N	101590	Hayley GROUP LIMITED	Steve/Tonia	\N	2025-05-07	Order new  account	\N	C	190.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1529	excel-import-user	import@system.com	Paulo Santos	109110	Bison Industrial Limited	Max Morton	Botley	2025-05-07	Collect Return, Offer +1% for each 1K on top of the 5K to a max. of 10%	Follow up next week	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1530	excel-import-user	import@system.com	Paulo Santos	109458	Direct Tool Company	Nick Morton	Southampton	2025-05-07	Meeting, Offer to get on plan +1K on top of the 3K to a max of 8%	Follow up next week	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1531	excel-import-user	import@system.com	Paulo Santos	100325	Swiftfix Distributors Ltd	Steve	Southampton	2025-05-07	open new premises, opportunity for POS	Follow up 	B	175.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1532	excel-import-user	import@system.com	Paulo Santos	107790	Lawson H.I.S. Ltd.	Paul Lyons	Southampton	2025-05-08	Offer HSS dril bits against WURTH (R & TiN)	Follow up next week	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1533	excel-import-user	import@system.com	Paulo Santos	102725	Macsalvors Ltd.	Clint Wood	Redruth (Cornwall)	2025-05-09	Phone Meeting - Offer 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1534	excel-import-user	import@system.com	Jens Werner	107038	ABRABORO Kft	Markus Zimmermann	\N	2025-05-14	Angebot über Sommeraktion mit 5l Bierfass unterbreitet	Auftrag erhalten	A	55000.00	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1535	excel-import-user	import@system.com	Jens Werner	106417	ALPEN-MAYKESTAG GMBH	Robert Holleis	\N	2025-05-14	Spring offer	5% für Sonderauftrag	A	25000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1536	excel-import-user	import@system.com	Jens Werner	100719	A.S.F. Fischer BV	Dominic Bravenboer	\N	2025-05-14	Spring offer  / Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Termin Mai / Juni Ausbau Zusammenarbeit	B	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1537	excel-import-user	import@system.com	Jens Werner	151795	Seojeon MJ	Heekyung	\N	2025-05-13	Angebot 14"+16" Trennscheiben abgegeben	nachhaken	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1538	excel-import-user	import@system.com	Mark Smethurst	Prospect	C W BERRY	KEITH NAYLOR	LEYLAND	2025-05-12	JV with SB Met with Keith. Showed catalogue.	follow up next month	A	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1539	excel-import-user	import@system.com	Mark Smethurst	Prospect	R J BUILDERS HARDWARE	SUE AND MICK	BLACKBURN	2025-05-12	JV with SB Meeting with Sue and Mick. Quote for SDS.	Quote for sds	A	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1540	excel-import-user	import@system.com	Mark Smethurst	105977	BLACKPOOL POWER TOOLS	STEVE AND RYAN	BLACKPOOL	2025-05-12	JV with SB 5% discount on order over £3000	Follow up next end of month	A	\N	3000.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1541	excel-import-user	import@system.com	Mark Smethurst	100682	EDMUNDSON ELECTRICAL	LEWIS	BLACKPOOL	2025-05-12	JV with SB Catalogue and Price list.	Follow up next month	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1542	excel-import-user	import@system.com	Mark Smethurst	Prospect	LES GOULDING S.O.T.	LES GOULDING	CARNFORTH	2025-05-13	catalogue and hss promotion	Follow up next month	C	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1543	excel-import-user	import@system.com	Mark Smethurst	100850	ABILITY SUPPLIES	LESLEY	SUNDERLAND	2025-05-13	Hss promotion. 5% on £3000 order 10% on £10000	Follow up end of month.	A	\N	3000.00	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1544	excel-import-user	import@system.com	Mark Smethurst	100112	R J FIXINGS	STEVE  	NEWCASTLE	2025-05-13	5% discount on order over £3000	Prices end of month	A	\N	3000.00	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1545	excel-import-user	import@system.com	Mark Smethurst	109093	FIXINGS TYNE TEES	MARK	HARTLEPOOL	2025-05-13	5% discount on order over £3000	Follow up end of month.	A	\N	3000.00	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1546	excel-import-user	import@system.com	Mark Smethurst	100914	D MCFARLANE	DENNIS AND GRAHAM	GATESHEAD	2025-05-14	Catalogue and Price list.	email discounts and prices	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1547	excel-import-user	import@system.com	Mark Smethurst	103049	A D FIXINGS	DAVE	NECASTLE	2025-05-14	5% discount on order over £3000 + HSS promo	follow up next month	A	200.00	3000.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1548	excel-import-user	import@system.com	Mark Smethurst	Prospect	S A BUILDING SUPPLIES	DAVID	CO. DURHAM	2025-05-14	Cold call left catalogue and business card	follow up next month	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1549	excel-import-user	import@system.com	Mark Smethurst	Prospect	J T DOVE	PAUL FROST	DARLINGTON	2025-05-14	Cold call left catalogue and business card	follow up next month	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1550	excel-import-user	import@system.com	Mark Smethurst	Prospect	STEVE MORGAN S.O.T.	STEVE MORGAN	BOLTON	2025-05-15	Cold call left catalogue and business card + Hss	Follow up end of month.	C	\N	\N	8	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1551	excel-import-user	import@system.com	Mark Smethurst	100605	PLUMBERS CHOICE	TAHIR	BRADFORD	2025-05-16	Hss promotion. 5% on £3000 	email quote	C	\N	3000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1552	excel-import-user	import@system.com	Mark Smethurst	NEW AC	BILPRO	SAM, PHIL AND BEN	BRADFORD	2025-05-16	10% on order over £3000 first order.	Follow up next week	B	\N	3000.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1553	excel-import-user	import@system.com	Mark Smethurst	Prospect	FAUNCH LTD	STEVE FAUNCH	BRADFORD	2025-05-16	Hss Promotion and catalogue.	follow up next month	B	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1554	excel-import-user	import@system.com	Mark Smethurst	109757	DIRECT BUILDING	ANDY CLAPHAM	BRADFORD	2025-05-16	Catalogue and Price list.	follow up end next week	A	\N	\N	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1555	excel-import-user	import@system.com	Mark Smethurst	108126	PAM TIES	ASH AND STEVE	TYLDESLEY	2025-05-16	Hss Promotion and catalogue.	follow up with rebar promotion	A	250.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1556	excel-import-user	import@system.com	Paulo Santos	109758	Technical Fixings Sol.	Stuart	Kent	2025-05-12	Meeting, quote, Offer 2.5K GBP for 6%	Follow up 15/05	A	\N	2500.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1557	excel-import-user	import@system.com	Paulo Santos	109793	Franklin Industrial 	Lisa	Email Tel/ Call	2025-05-12	Phone call about Offer + Order	\N	B	2100.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1558	excel-import-user	import@system.com	Paulo Santos	109480	Diamond Direct Supplies	Mac	Kent	2025-05-12	Trijet 5x260mm Production + Offer 11K GBP for 8%	\N	B	800.00	11000.00	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1559	excel-import-user	import@system.com	Paulo Santos	101448	CCU Tool and Plant 	Vanish	Kent	2025-05-12	Meeting+New catalogue	\N	C	\N	\N	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1560	excel-import-user	import@system.com	Paulo Santos	109110	Bison Industrial Limited	Max Morton	Email Tel/ Call	2025-05-12	Follow up about the Offer/Check if its possible	Follow last week May	A	\N	5000.00	5	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1561	excel-import-user	import@system.com	Paulo Santos	108862	Golz (UK) Limited	Becky	Northfleet	2025-05-13	CV, BT Deal keep going but really slow	\N	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1562	excel-import-user	import@system.com	Paulo Santos	109151	Fixmart	Bradley	Northfleet	2025-05-13	Cv, New Catalogue	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1563	excel-import-user	import@system.com	Paulo Santos	109811	Alpha Wholesale	Bob	Kent	2025-05-13	Meeting to see where we place has a suplier	Send promotions	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1564	excel-import-user	import@system.com	Paulo Santos	Prospect	HTFS	Paul Ballinger	Swindon	2025-05-13	Mobile, Old account to come back	Follow up 16/05	C	\N	\N	12	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1565	excel-import-user	import@system.com	Paulo Santos	100286	A Solutions UK Ltd	Sean	Twickernam	2025-05-14	Meeting, Offer, new products Offer 4K GBP for 6%	45804	A	\N	4000.00	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1566	excel-import-user	import@system.com	Paulo Santos	102482	Construction SS	Alain Weyers	Slough	2025-05-14	Meeting to see where we place aas a suplier	new meeting 2/06	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1567	excel-import-user	import@system.com	Paulo Santos	108431	Multifix 	David Shimwell	Madstone	2025-05-14	Meeting, Move forward with Development team	new meeting 29/05	A	\N	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1568	excel-import-user	import@system.com	Paulo Santos	107941	FWB South West Ltd.	Jack 	Tel Call	2025-05-14	Phone call result in an order, quote Hss Set's	Follow up Week 22	C	50.00	\N	5	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1569	excel-import-user	import@system.com	Paulo Santos	109480	Diamond Direct Supplies	Mac	Email Tel/ Call	2025-05-14	Offer Accepted by phone	\N	B	11800.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1570	excel-import-user	import@system.com	Paulo Santos	108750	A C Fixings Ltd.	Sean	Chelmsford	2025-05-15	CV, received order with missing items	order processed	A	900.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1571	excel-import-user	import@system.com	Paulo Santos	109149	Millcot Tools	Tim	Maldon	2025-05-15	CV, Offer £2500 - 6.5%	Follow up Week 22	C	\N	2500.00	7	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1572	excel-import-user	import@system.com	Paulo Santos	100342	Total Diamond Products	Kim	Basildon	2025-05-15	Meeting, offer £2K - 5% additional discount	Follow up Week 22	B	\N	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1573	excel-import-user	import@system.com	Nikolaj Ljabach	100897	Profipartner	Bartosz Swierewski	Warschau	2025-05-12	Siehe separate Mail. Sonderauftrag kommt	Auftrag abwarten, nächste Woche nachfassen	A	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1574	excel-import-user	import@system.com	Nikolaj Ljabach	101026	Izoservice	Adam Shishkowskij	Warschau	2025-05-13	Siehe separate Mail. Sonderauftrag kommt	Auftrag abwarten, nächste Woche nachfassen	B	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1575	excel-import-user	import@system.com	Nikolaj Ljabach	102095	Erpatech	Jacer Biedron	Wrozlaw	2025-05-16	Sonderangebot JW / Angebot Allmat Pro	Auftrag abwarten, nächste Woche nachfassen	A	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1576	excel-import-user	import@system.com	Nikolaj Ljabach	101935	Rawlplug	Mariusz Jazefowiak	Wrozlaw	2025-05-16	Sonderangebot JW / Angebot Allmat Pro / Zahlungskonditionen	Auftrag abwarten, nächste Woche nachfassen	A	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1577	excel-import-user	import@system.com	\N	102890	Energo	Lutfulla	E-Mail/Whatsapp	2025-05-14	Auftrag eingegangen 10 K Euro. War efür 500 Euro kann nicht geliefert werden.\nAuftragsbearbeitng un dKoordination	Ab erstellen und Liefern	B	10000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1578	excel-import-user	import@system.com	Nikolaj Ljabach	101599	NG Elektro	Hr. Bergner	E-Mail/Whatsapp	2025-05-14	Aufrag eingegangen. Kunde angelegt. Ab Wert 3400, Ware für 1300 Euro kann  nicht geliefert werden	Warten auf OC Bestätigung\nAuslieferung\nKoordination der retsbestände mit EK	A	3400.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1579	excel-import-user	import@system.com	\N	101371	Kardesler	Hr. Klimenko	E-Mail/Whatsapp	2025-05-13	Kunde ist bereit 50% der Liefrung zu zahlen.\nPrüfung letzter Modalitäten\nSanktionsprüfunk Alternativkunde Türkei	Warten auf die Zahlung / Auslieferung	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1580	excel-import-user	import@system.com	\N	100499	Vosmerik	Hr. Bugdanowskij	E-Mail/Whatsapp	2025-05-13	Abstimmung China-Lieferung	registrierung des vertrages, Zahlung, Auslieferung	A	30000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1581	excel-import-user	import@system.com	Nikolaj Ljabach	100483	Techmont	Zbigniew Klimek	E-Mail/Whatsapp	2025-05-14	Anmahnung Zahlung / Kleiner Auftrag	Zahlung abwarten und nachfassen	A	726.00	\N	45809	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1582	excel-import-user	import@system.com	Nikolaj Ljabach	150211	Novomet	Frau Boeva	E-Mail/Whatsapp	2025-05-14	Anmahnung Zahlung / Kleiner Auftrag	Zahlung abwarten und nachfassen	A	\N	\N	45809	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1583	excel-import-user	import@system.com	Nikolaj Ljabach	109937	Steelrex	Vano Kardashvili	E-Mail/Whatsapp	2025-05-14	Anmahnung Zahlung / Nächster Auftrag	Zahlung abwarten und nachfassen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1584	excel-import-user	import@system.com	Nikolaj Ljabach	151260	MIG Baltic	Aigars Baumanis	E-Mail/Whatsapp	2025-05-14	Anmahnung Zahlung / Kleiner Auftrag	Zahlung abwarten und nachfassen	A	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1585	excel-import-user	import@system.com	Nikolaj Ljabach	108136	AER	Janis Ivanovs	\N	2025-05-16	Angebot für die Auschreibung	\N	B	\N	14000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1586	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE	Rafael	Madrid	2025-05-13	Neue Logistik und Angebot mit Sonderkondition -7,5%	\N	A	0.00	300000.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1587	excel-import-user	import@system.com	Gunter Diedrich	108218	Hiperconstruccion Ruiz	Manolo	Villalba P29	2025-05-13	Sägeblätter-Programm	\N	B	400.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1588	excel-import-user	import@system.com	Gunter Diedrich	108218	SHERMACON	José	Villalba P29	2025-05-13	Reklamation SDS-max	\N	B	0.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1589	excel-import-user	import@system.com	Gunter Diedrich	108218	La UNICA	José Manuel	Villalba P29	2025-05-13	Sägeblätter-Programm	\N	B	350.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1590	excel-import-user	import@system.com	Gunter Diedrich	108218	Pedro DURAN	Pedro	Talavera de la Reina	2025-05-15	GH, 2618,2518, Meissel, Sägenprogramm	\N	B	0.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1591	excel-import-user	import@system.com	Gunter Diedrich	108218	La ZAMORANA	Julián	Talavera de la Reina	2025-05-15	GH, 2618,2518, Meissel, Sägenprogramm	\N	B	400.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1592	excel-import-user	import@system.com	Gunter Diedrich	108218	La FLORESTA	Antonio	Talavera de la Reina	2025-05-15	GH, Extra lange SDS-plus 2018 DEMO	\N	B	0.00	800.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1593	excel-import-user	import@system.com	Gunter Diedrich	108218	TOOLS TALAVERA	\N	Talavera de la Reina	2025-05-15	EH, Range, Vorteile, Mini-DEMO	\N	C	0.00	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1594	excel-import-user	import@system.com	Gunter Diedrich	108218	ALQUIMO	Juan Antonio	Talavera de la Reina	2025-05-15	Vermieter, SDS-max, Meissel	\N	B	0.00	2500.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1595	excel-import-user	import@system.com	Gunter Diedrich	108218	Maquinas FERPI	Pépe	Talavera de la Reina	2025-05-15	Vermieter, SDS-max, Meissel	\N	B	550.00	\N	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1596	excel-import-user	import@system.com	Yasir Angar	102263	STC-Trading Oy	Illka Hattunen	FI	2025-05-13	Umsatzsteigerung	Wird im Mai bestellen	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1597	excel-import-user	import@system.com	Yasir Angar	101009	Vantaan Kiinnike ja Rak Oy	Mika Pyysalo	FI	2025-05-13	Umsatzrückstand zu Plan	Bestellt regelmäßig  nach Bedarf. Rü steht aus.	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1598	excel-import-user	import@system.com	Yasir Angar	109894	Suomen Kiinnikekeskus OY	Jani Havukainen	FI	2025-05-13	Umsatzrückstand zu Plan	Bestellt regelmäßig  nach Bedarf. 	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1599	excel-import-user	import@system.com	Yasir Angar	102914	EXPERTbeslag A/S	Johny Andersen	DK	2025-05-13	Umsatzsteigerung	Bestellt regelmäßig  kleine Mengen nach Bedarf.	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1600	excel-import-user	import@system.com	Yasir Angar	103408	Sorbo Industribeslag AS	Ove Jensen	NO	2025-05-13	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1601	excel-import-user	import@system.com	Yasir Angar	102874	Ahlsell Sverige AB	Rickard  Andersson	SE	2025-05-13	Umsatzsteigerung	Keine Rü	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1602	excel-import-user	import@system.com	Yasir Angar	150100	LOBOMATIC AB	Jonathan Westh	SE	2025-05-13	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1603	excel-import-user	import@system.com	Yasir Angar	150087	Ferrometal Oy	Juuso Moilanen	FI	2025-05-13	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1604	excel-import-user	import@system.com	Yasir Angar	150054	Antonio Capaldo Spa	Renato Dimpflmeier	IT	2025-05-13	Umsatzrückstand zu Plan	Hat bestellt	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1605	excel-import-user	import@system.com	Yasir Angar	150252	R.E.I.T.  S.p.A.	Paola Tellatin	IT	2025-05-13	Umsatzrückstand zu Plan	Hat bestellt	A	\N	\N	45812	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1606	excel-import-user	import@system.com	Yasir Angar	101468	HOMBERGER S.P.A.	Luca Boscarino	IT	2025-05-13	Umsatzsteigerung	Wird im Mai bestellen	A	\N	\N	45812	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1607	excel-import-user	import@system.com	Yasir Angar	101043	UBB S.R.L.	Eleisabetha Piras	IT	2025-05-13	Umsatzsteigerung	Hat noch 25K  Auftragsbestand 	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1608	excel-import-user	import@system.com	Yasir Angar	150181	George Katsafados Ltd	Elena Nicolaou	CY	2025-05-13	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	10000.00	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1609	excel-import-user	import@system.com	Yasir Angar	102733	EDIL2000 SRL	\N	IT	2025-05-13	Umsatzsteigerung	Keine Rü bisher	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1610	excel-import-user	import@system.com	Yasir Angar	103390	Soc.IT Commerciale	\N	IT	2025-05-13	Umsatzrückstand zu Plan	Keine Rü bisher	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1611	excel-import-user	import@system.com	Yasir Angar	106912	G & T Imports Ltd.	Joanna Galea  	MT	2025-05-13	Umsatzrückstand zu Plan	Hat bestellt	B	18000.00	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1612	excel-import-user	import@system.com	Yasir Angar	100852	ECONOMOTECHNIKI S.A.	Anne Laure	GR	2025-05-13	Umsatzrückstand zu Plan	Hat bestellt	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1613	excel-import-user	import@system.com	Yasir Angar	150310	THEOTHRIDIS IOANNIS & SOHN OE	Herr Stefanos	GR	2025-05-13	Umsatzrückstand zu Plan	Wird  ggfs. noch im Mai bestellen	B	\N	\N	45812	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1614	excel-import-user	import@system.com	Yasir Angar	150001	A. Aivazoglou P. Dalaglis A.E.	Herr Stefanos	GR	2025-05-13	Umsatzrückstand zu Plan	Hat 8.000€ bestellt	B	8000.00	\N	45812	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1615	excel-import-user	import@system.com	Yasir Angar	151808	THEMIS GIANNAKIS S.A.	Herr Stefanos	GR	2025-05-13	Umsatzsteigerung	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1616	excel-import-user	import@system.com	Yasir Angar	150332	G. Vella & Sons Limited	Patrick Vella	MT	2025-05-13	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1617	excel-import-user	import@system.com	Yasir Angar	100120	Gulf Diameter Est. for Trading	Jamshed Attassery	SA	2025-05-13	Umsatzrückstand zu Plan	Lager ist voll! Keine große Bestellung vor Juni!	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1618	excel-import-user	import@system.com	Yasir Angar	109612	Wizner Building & Fencing Supp Ltd	Eyal Wizner	IL	2025-05-13	Umsatzsteigerung	Nächste Bestellung Mitte Mai	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1619	excel-import-user	import@system.com	Yasir Angar	109750	GEN NEXT TOOLS	Rafiq Banatwala	IN	2025-05-13	Umsatzsteigerung	Hat bereits 100k Umsatz und 150k bestellt	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1620	excel-import-user	import@system.com	Yasir Angar	150013	Al Daaem Est.	Mr Zaki	SA	2025-05-13	Umsatzsteigerung	Bestellt erst wieder in Q3 oder Q4	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1621	excel-import-user	import@system.com	Yasir Angar	100906	Alexandria Progress Trading Co.	Michael Suleiman	EG	2025-05-13	Umsatzrückstand zu Plan	Bestellt erst wieder in Q3 oder später	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1622	excel-import-user	import@system.com	Yasir Angar	150138	Hashahal Trad. House Ltd	Ehud Quittner	IL	2025-05-13	Umsatzsteigerung	Nächste Bestellung voraussichtlich im Juni	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1623	excel-import-user	import@system.com	Yasir Angar	106396	Multi-Fix (Pty) Ltd	Celeste  Smith	ZA	2025-05-13	Umsatzsteigerung	Nächste Bestellung Anfang Juni	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1624	excel-import-user	import@system.com	Yasir Angar	102922	GLOBAL SOURCE MIDDLE EAST GENERAL	Sameer Subair	AE	2025-05-13	Umsatzrückstand zu Plan	Bestellt regelmäßig  nach Bedarf	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1625	excel-import-user	import@system.com	Yasir Angar	107713	GEORGES ZAKA & CO.	Antoine Zaka	LB	2025-05-13	Umsatzrückstand zu Plan	Hat gerade 18 k bestellt	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1626	excel-import-user	import@system.com	Yasir Angar	150301	SWIT	Mathew Jacob	IN	2025-05-13	Umsatzsteigerung	Hat gerade bestellt. Bestellt regelmäßig nach Bedarf	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1627	excel-import-user	import@system.com	\N	107104	Saeed Mohamed Basuliman Est for Tra	Saeed Basuliman	SA	2025-05-13	Umsatzsteigerung	Hat gerade bestellt. Bestellt regelmäßig nach Bedarf	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1628	excel-import-user	import@system.com	\N	100401	SEDISA SAC	Gustavo Gaiarin	PE	2025-05-13	Umsatzsteigerung	Hat Anfang des Jahres 110k bestellt. 	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1629	excel-import-user	import@system.com	\N	101508	Segupro SAC	Miguel Gomez	PE	2025-05-13	Umsatzsteigerung	Hat  40k bestellt. 	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1630	excel-import-user	import@system.com	\N	150298	Mahle Metal Leve S/A	Fabiano Araujo 	BR	2025-05-13	Umsatzsteigerung	Bestellt regeläßig 2000 Stk.	A	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1631	excel-import-user	import@system.com	\N	150104	Importadora ECO S.A.,	Alexander Sessler	CL	2025-05-13	Umsatzrückstand zu Plan	Bestellt regelmäßig  nach Bedarf. Rü steht aus.	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1632	excel-import-user	import@system.com	\N	100236	Kilman	Jonathan Soto	CL	2025-05-13	Umsatzrückstand zu Plan	Bestellt regelmäßig  nach Bedarf. Auftrag Strecke zugesagt.	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1633	excel-import-user	import@system.com	Martin, Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-05-15	Gespraech ueber die derzeitige Situation, wann wird eine neue Bestellung kommen. AB 3.8K EUR	Naechste Gespraech naechste Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1634	excel-import-user	import@system.com	Martin, Palme	109842	Hept SK	Hr. Bong	Mail	2025-05-14	Kunde versuch alles moeglich Zahlung im Mai zu taetigen, AB 13.8K EUR	Naechste Gespraech Anfang naechster Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1635	excel-import-user	import@system.com	Martin, Palme	103214	ZI-TECH TH	Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-05-15	Kleinere Luftfrachbestellungen erhalten. In Kuerze kommt eine HSS Inch Bestellung. AB 8.4K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2196	excel-import-user	import@system.com	Steve Bell	100007	Merit	Cam	Nottingham	2025-06-11	Max order	Normal visit	B	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1636	excel-import-user	import@system.com	Martin, Palme	100998	RFM MAL	Khiam, Raymond	Mail	2025-05-09	Nachfrage wegen 10 % / 15K EUR Bestellwert	Naechste Woche nachhaken, da MD im Urlaub	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1637	excel-import-user	import@system.com	Martin, Palme	100081	BAP INDO	Reza	Mail, Messenger	2025-05-14	Nachfrage wegen 10 % / 15K EUR Bestellung, Bestellung komt in Kuerze, Angebot erstellt und dem Kunden zugesendet	Die Bestellung sollte dann in Kuerze kommen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1638	excel-import-user	import@system.com	Martin, Palme	100714	Sing Kee HK	Ric	Mail	2025-05-14	Nachfrage wegen 10 % / 15K EUR Bestellwert	Kunde im Urlaub, naechste Woche erhalte ich eine Antwort	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1639	excel-import-user	import@system.com	Martin, Palme	150033	Exacon AUS	Harvey	Mail, Messenger	2025-05-12	Bestellung ausgeliefert, nachhaken fuer die neue Promotion 10 %/15K EUR Bestellwert, kann den Bestellwert nicht erreichen. Bestellung ueber 6.3K EUR erhalten. AB 6.3K EUR	Sehr oft in Kontakt mit Mail und Messenger.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1640	excel-import-user	import@system.com	Martin, Palme	100501	CSH SIN	Eric	Mail, Messenger	2025-05-12	35K EUR im Februar bestellt, teilweise ausgeliefert, 4.9K EUR im AB. Neue Promotion 10 %/15K EUR im Juni/July anbieten. AB 4.9K EUR sollte im Mai ausgeliefert werden.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1641	excel-import-user	import@system.com	Martin, Palme	150039	Bordo AUS	Jerry, Yvonne	Mail	2025-05-14	Bestellung ist mit Teillieferung geliefert worden. 	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1642	excel-import-user	import@system.com	Martin, Palme	150267	UnionDay HK	Jason	Mail	2025-05-15	Nachfrage wegen 10 % / 15K EUR Bestellwert	Naechste Woche nochmals nachhaken, wenn keine ANtwort, evtl. In Kuerze Besuch planen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1643	excel-import-user	import@system.com	Martin, Palme	151242	Majjatra INDO	Gunawan, Lili	Mail	2025-05-14	Bestellung ueber 5.7K EUR erhalten, ist bereits ausgeliefert. Fragt an, wann die Muster fuer die China Bohrer versendet werden.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1644	excel-import-user	import@system.com	Martin, Palme	150348	Wakai JP	Iwawaki, Nene	Mail	2025-05-13	Angebot gesendet gehabt. Kunde wartet auf seinen Kunden zur Bestaetigung des Angebots. AB 12.8K EUR	Naechste Woche nachhaken, wenn keine Bestellung kommt	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1645	excel-import-user	import@system.com	Martin, Palme	150041	BoRyung SK	Cavin	Mail	2025-05-08	Nachfrage wegen 10 % / 15K EUR Bestellwert. Wird nicht bestellen, haben noch Lager und PL Kunden sind aggressive im Preis.	Denke der Kunde wird bei uns nicht mehr kaufen werden in Zukunft	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1646	excel-import-user	import@system.com	Martin, Palme	151317	Steel & Tube NZ	Aries	Mail	2025-05-15	Nachfrage wegen 10 % / 15K EUR Bestellwert. 15K EUR werden zu hoch sein, angefragt, welche Hoehe moeglich ist, dann ein verminderter Rabatt, wenn die Hoehe stimmt.	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1647	excel-import-user	import@system.com	Martin, Palme	151141	Powerpac NZ	Jay, Patrick	Mail	2025-05-15	Nachfrage wegen 10 % / 15K EUR Bestellwert. 15K EUR sind zu hoch. Keine Bestellung in Kuerze, da noch Lagerbestand. 	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1648	excel-import-user	import@system.com	Martin, Palme	150052	Blacks Fasteners NZ	Roger, Marcus	Mail	2025-05-15	Moechten Heller Distributor werden, Muster festgelegt, mussen nun versendet werden, hoffentlich sind alle verfuegbar. Ende Mai Pruefung, ob 10 %/15K EUR Bestellung gemacht werden kann. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist von mir dann angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1649	excel-import-user	import@system.com	Martin, Palme	151734	Cut & Break PH	Junel, Raul	Mail, Messenger	2025-05-16	Nachfrage wegen 10 % / 15K EUR Bestellwert. Wird gesprueft, Entscheidung in 10 Tagen, da der Inhaber nicht im Haus. Anfrage erhalten, wo wir die Laengen nicht haben.	Naechste Woche nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1650	excel-import-user	import@system.com	Martin, Palme	150279	Trucut NZ	Rod	Mail	2025-05-13	Hatten wir als Kunden Ende 2022 verloren gehabt, habe nun nach 2 Jahren wieder einen guten Draht zum Kunden bekommen. Will wieder Turboclean kaufen. Moechte sich aber zuerest noch mit seinem Sales Team beraten, wird im Mai sein, da nicht alles Sales Mitglieder verfuegbar. Werde bei 10K EUR einen Rabatt von 5 % anbieten.	Naechste Woche nachhaken	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1651	excel-import-user	import@system.com	Stephan Heinitz	107809	Feucht GmbH	P. Wurst	Backnang	2025-05-12	Termin Neuheiten/neuer Katalog/Aktion, lt. Kundenaussage läuft eine Bestellung	Kunde möchte für AD 15 Preislisten	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1652	excel-import-user	import@system.com	Stephan Heinitz	100756	G. Wiedmann	M. Jahn	Urbach	2025-05-12	Modulumbau - 6 Module in 2,5D Wand integrieren, danach Erweiterung 4PowerPro Range 18-25mm	Erweiterung 4PowerPro - Range mit vorhandener Ware abgleichen und zusenden	B	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1653	excel-import-user	import@system.com	Stephan Heinitz	101446	Roth Baustoffe	Herr Roth	Neckargemünd	2025-05-13	Aktion/Neuheiten/neuer Kunde - kürzlich Einrichtung, Preisauszeichnung soll neu gestalttet werden, Kunde gibt Bescheid - evtl. Hauspreise nötig, Schulungsbedarf festgestellt - wird bei Gelegenheit vor Ort gemacht	nachhaken wg. Preisauszeichnung	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1654	excel-import-user	import@system.com	Stephan Heinitz	108629	Gnädig	T. Moog	Lahr	2025-05-13	 Regelbesuch - Neuheiten/Aktionen/Reklamationen/Regalpflege, bestellt generell selbst, Super-Quick Bohrkrone angefragt - Angebot gleich vor Ort erledigt	\N	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1655	excel-import-user	import@system.com	Stephan Heinitz	150631	BHT 	Hr. Stecher	Sexau	2025-05-13	Keil-Kunde, 10+1 Aktion angeboten, Coba- Mitglied, auf Heller angesprochen - lt. Kunde macht das keinen Sinn, da er nur minimal Werkzeug im Sortiment führt	\N	C	\N	\N	26	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1656	excel-import-user	import@system.com	Stephan Heinitz	108990	Schachenmeier	Hr. Walter	Efringen-Kirchen	2025-05-14	Aktion/Reklamation/Regelbesuch	\N	B	\N	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1657	excel-import-user	import@system.com	Stephan Heinitz	101388	Werkzeug-Jäger NDL Maulburg	\N	Maulburg	2025-05-14	Ersteinrichtung aufgebaut, VK-Unterlagen, Überblick übers Sortiment, Kontaktdaten geklärt, Besuchsrythmus wohl nicht nötig da alles über Zentrale abgewickelt wird, bei 3 Modulen wurden Etiketten nicht mitgeliefert	\N	A	\N	\N	16	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1658	excel-import-user	import@system.com	Stephan Heinitz	109684	Issler und Pütz	Hr. Schlageter	Grenzach-Wyhlen	2025-05-14	Termin/Besuch wurde telefonisch abgesagt, wird vom Homeoffice aus mit Aktion versorgt, bestellt auch für gewöhnlich selbst	Infos aktuelle Aktikonen	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1659	excel-import-user	import@system.com	Stephan Heinitz	101686	Veeser	Hr. Metzger	Freiburg	2025-05-15	Aktion vorgestellt, Reklamationen bearbeitet, wg. Schleifen nachgehakt - Kunde schickt Dispo über EDI Orders	bereits vor Ort erledigt	A	\N	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1660	excel-import-user	import@system.com	Stephan Heinitz	108800	Hornbach Union BZ	Hr. Nolde	Karlsbad-Ittersbach	2025-05-15	Modulumbau (verschoben vom 02.05.2025)	\N	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1661	excel-import-user	import@system.com	Stephan Heinitz	102854	GoldmannLindenberger	Hr. Ponnuturai	Pforzheim	2025-05-15	Regalpflege/Aktion/Starlock-Nachbestückung - war nicht möglich, da die am 11.04.2025 bestellten Etiketten immer noch nicht beim Kunden eingetroffen sind und somit eine Auszeichnung oder Bestellung dieser Artikel nicht möglich ist - 	Etiketten rausschicken, damit der Kunde bestellen kann	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1662	excel-import-user	import@system.com	Pantaleo Stomeo	100258	August Prelle GmbH ( Bauking)	Frau Wehrmann	38644 Goslar	2025-05-12	Ersteinrichtung 3m, vor Ort musste ich feststellen das unsere 3m leider noch nicht komplett frei geräumt waren und somit musste erstmal Platz geschaffen werden. Anschließend kam dann leider raus das aufgrund das der Kunde alle Module verändert hat und somit unser ID die Bestellung nicht anhand der Modulnummer eingeben konnte sondern alles einzeln das nix vorsortiert war. Alle Grundgestelle waren einzeln, die Hakenreihen, Scannerschienen, Fußschilder usw. waren alle in den Kartons verteilt. Zudem waren alle Artikel in 3 verschiedenen Kartons nicht sortiert verpackt worden. Bin mit der einrichtung daher heute nicht fertig geworden weil ich alles erstmal sortieren musste und weil einiges fehlte was per Express morgen geliefert wird. 	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1663	excel-import-user	import@system.com	\N	100258	August Prelle GmbH ( Bauking)	Frau Wehrmann	38644 Goslar	2025-05-12	Heute wieder vor Ort gewesen um die Präsentation fertig zu stellen. Leider musste ich bis 10:45 Uhr warten bis die fehlenden Teile endlich ankamen. Als dann alles da war die Präsentation fertig gestellt und die Ware die der Kunde (1großer Karton mit unsortierter Ware) vor Ort hatte mit in die Wand sortiert. Der Kunde ist mit dem Ergebnis zufrieden. \n\nDa ich anschließend noch 4 Stunden Fahrt vor mir hatte konnte ich heute keine weiteren Kunden besuchen. 	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1664	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Baufach-Centrum Kaiser GmbH	Herr Meier	32257 Bünde	2024-05-15	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen wollte mich und die Firma Heller bei Herrn Schuh vorstellen. Der ist hier der Verantwortliche wie ich aus der Niederlassung in Gütersloh erfahren habe. Leider musste ich vor Ort feststellen das Herr schuh Urlaub hat und man unbedingt vorher mit Ihm einen termin machen sollte weil er die meiste Zeit in den Niederlassungen unterwegs ist oder auch viele Termine hat. Herr Meier meinte ich kann zwar den Ordner hier lassen das würde allerdings nix bringen und einen anderen Kollegen der dafür zuständig ist gibt es nicht. Somit bin ich wieder gefahren und werde einen Termin mit Herr Schuh vereinbaren und nochmals hinfahren.	Termin mit Herrn Schuh vereinbaren um dann Heller vorzustellen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1665	excel-import-user	import@system.com	Pantaleo Stomeo	100248	Schnittger Baustoffe GmbH & Co. KG 	Herr Sören Ihlenfeld	32312 Lübbecke	2025-05-15	Allgemeiner Kundenbesuch, Herr Ihlenfeld mit Heller weiterhin sehr zufrieden. Wir haben uns gemeinsam die Wand angeschaut und überlegt was wir ändern können um diese noch interessanter zu gestalten. Haben uns geenigt das er das vorhandene Allmat Lochsägen Modul gegen ein Bohrkronen Modul austauscht und zusätzlich nehmen wir die Lewis Schlangenbohrer mit ins Sortiment und erweitern somit unser Sortiment. Den Umbau machen wir dann in ca. 2 Wochen	Dem Innendienst die Infos geben welche neuen Module benötigt werden damit das als Auftrag erfasst werden kann und dann Termin vereinbaren zwecks Umbau.	B	2200.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1666	excel-import-user	import@system.com	Pantaleo Stomeo	100256	Schnittger Baustoffe GmbH & Co. KG 	Herr Malte Ruttke	32278 Kirchlengern	2025-05-15	Allgemeiner Kundenbesuch, auch hier ist man wie in Lübbecke mit Heller sehr zufrieden. Ich habe Herrn Malte Ruttke erklärt was wir im anderen Standort nun verändern werden und konnte Ihn dann auch überzeugen bei sich diese Änderung vorzunehmen. Aufgrund des vorhandenen Platzes wird man hier aber nur das Allmat Lochsägen Modul gegen das Bohrkronen Modul austauschen.	Dem Innendienst die Infos geben welche neuen Module benötigt werden damit das als Auftrag erfasst werden kann und dann Termin vereinbaren zwecks Umbau.	B	1500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1667	excel-import-user	import@system.com	Pantaleo Stomeo	106168	Hotze GmbH & Co. KG 	Herr Jasper Joltrop	32369 Rahden	2025-05-15	Allgemeiner Kundenbesuch, hier wollte mich wie bei allen anderen Hotze Standorten mal umschauen und nachhören wie die Lage ist. Vor Ort musste ich feststellen das der Markt komplett umgebaut wurde und man jetzt nix mehr von Heller hat, alles was vor ort war (3 x 1,25 x 2m) wurde nach Laatzen (Hannover) umgelagert und vor Ort ist nur noch der Butler-Tower. An Maschinenzubehör wird im Profifachmarkt hier nix mehr angeboten, im Baumarkt nebenan gibt es Artikel von Conmetall. Also hier wird kein Umsatz mehr kommen. 	Keine weiteren Besuche mehr notwendig	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1668	excel-import-user	import@system.com	Marcel Bornemann 	100318	Jacob Cement	Herr Lewe/ Dzwalla 	Lübeck	2025-05-12	Angebot Schleifen Trennen besprochen , geplanter umbau für die 1 Juni Woche	1 Juni Woche Umbau geplant	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1669	excel-import-user	import@system.com	Marcel Bornemann 	103766	Richter Baustoffe	Herr Klieforth	Lübeck	2025-05-12	Angebot von Bosch vorliegen , Bosch macht druck und versucht mit allen mitteln Markt zu machen 	Kunden weiter an uns binden	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1670	excel-import-user	import@system.com	Marcel Bornemann 	102878	Richter Baustoffe	Herr Ziegler 	Lübeck	2025-05-12	Kurzes gespräch über Frau Dittmann die hat das Unternehmen verlassen , Kennenlernen von Herrn Bunig Regionalleiter Nord ( frage bezüglich Lieferperformance beI Hagebau Tagung ) gefahr durch falsche aussagen von anderen Händlern .	Kunden weiter an uns binden	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1671	excel-import-user	import@system.com	Marcel Bornemann 	100175	Jacob Cement	Herr Scheel	Rostock	2025-05-12	Angebot Schleifen Trennen liefern zu Ende Mai 	Aufbau Umbau Einrichtung Trennen Schleifen 1 Juni Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1672	excel-import-user	import@system.com	Marcel Bornemann 	100199	Richter Baustoffe	Herr Meilke	Roggenthin	2025-05-12	Aktuelle Unterlagen und Stimmungslage im Hause Richter abgeklopft , Zufrieden mit Heller keine Negativen aussagen . Stimmung am Markt wird besser . 	Schleifen Trennen weiter versuchen ins Haus zu bringen 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1673	excel-import-user	import@system.com	Marcel Bornemann 	106368	Jacob Cement	Frau Hering	Ribnitz Damgarten	2025-05-12	Trennen und Schleifen Angebot angesprochen plann ist es in der 1 Juni Woche umzubauen zusätzlich ergänzen von 4 Power Doppelmodul und dafür Bionic raus .	Angebot nachhalten und erfassen lassen	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1674	excel-import-user	import@system.com	Marcel Bornemann 	100131	Jacob Cement	Herr Engelage	Bergen auf Rügen	2025-05-13	Angebot Schleifen Trennen , Einrichtung geplnnt in der 27 KW Liefern in der 26 KW	Aufbau Trennen Schleiden in KW 27 geplannt	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1675	excel-import-user	import@system.com	Marcel Bornemann 	109121	Handelshof Stralsund	Frau Rosenburg	Stralsund	2025-05-13	Sichten der Altware die Zurück geführt werden soll gegen Doppeltem AW	Nach Rückführung Präsentation anpassen 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1676	excel-import-user	import@system.com	Marcel Bornemann 	108690	Jacob Cement	Herr Mundt Herr Clemann	Greifswald	2025-05-13	Trennen Schleifen besprochen , Aufbau einrichtung geplant in der 1 Juni Woche	Aufbau Trennen Schleifen 1 Juni Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1677	excel-import-user	import@system.com	Marcel Bornemann 	103256	Linnenbecker 	Herr Mewes	Greifswald	2025-05-13	Etiketten stecken die gefehlt haben , es fehlten leider wieder welche . Kundenanfrage Sägen von Faserzement platten .	Etiketten nachdrucken die Gefehlt haben und beim nächsten besuche stecken	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1678	excel-import-user	import@system.com	Marcel Bornemann 	108693	Jacob Cement	Herr Sanow	Neustrelitz	2025-05-13	Angebot Trennen Schleifen besprochen Herr Sanow bespricht das mit NL und gibt Info	Planung ist in der 1 Juni Woche Trennen Schleifen Einrichten wenn bestellung von Herrn Sanow erfolgt 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1679	excel-import-user	import@system.com	Marcel Bornemann 	108678	Jacob Cement	Herr Schalk	Neubrandenburg	2025-05-14	Angebot Trennen Schleifen besprochen folgetermin geplannt 	1 Juni Woche Fixieren Auftrag	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1680	excel-import-user	import@system.com	Marcel Bornemann 	104781	Holger Marlow 	Herr Holtz	Neubrandenburg	2025-05-14	Gemeinschaftbesuch bei Metallbau NSB Herr Groß Starlock Test teile besprochen 	Muster an NSB zum Test senden  Gespräch über Warenpräsentation im Hause geht schritt für Schritt in die Richtige richtung Kunde fast Vertrauen 	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1681	excel-import-user	import@system.com	Marcel Bornemann 	102814	Handelshof Neubrandenburg	Herr Möller	Neubrandenburg	2025-05-14	Sichten der Altware die Zurück geführt werden soll gegen Doppeltem AW	Nierdlassung wird vielleicht ende des Jahres geschlossen , gespräch über kleineren Standort noch nicht fix . 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1682	excel-import-user	import@system.com	Marcel Bornemann 	104368	Handelshof Grimmen	Herr Olenik	Grimmen	2025-05-14	Pennerliste von HKS besprochen Rückführug zentral über Grimmen mit vorheriger anschauung von mir . 	Retouren Artikel anschauen und sortieren Doppelter AW zur Retourenware 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1683	excel-import-user	import@system.com	Marcel Bornemann 	101132	Mölder Bauzenturm	Herr Kunkel	Hamburg	2025-05-15	Herr Kunkel die Unterschiedlichen SDS Plus Bohrer Erläutert und weiter über eine mögliche Einrichtung Starlock und Bohrer gesprochen Kunde meldet sich wenn alles geklärt ist .	Warten auf Antwort vom Kunden was und in welchem Umfang was zu tun ist , Nachfassen in ca 4 Wochen	A	\N	\N	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1684	excel-import-user	import@system.com	Marcel Bornemann 	100294	Hass & Hatje	Frau Hoffmann	Hitzhusen	2025-05-15	Gespräch über Angebot ( Diskusion in der Gruppe Hass & Hatje ob Butler kommt mit Schleifen oder nicht ) 	Frau Hoffmann will Heller in Schleifen 	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1685	excel-import-user	import@system.com	Marcel Bornemann 	150481	Ralph Penta	Herr Penta	Kisdorf	2025-05-15	Kurzes gespräch über zurückhaltung bei Kunden ( Kaufen momentan wenig da alles Kleine Unternehmer mit wenig Arbeit ) 	Aktionsartikel vorbereiten	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1686	excel-import-user	import@system.com	Marcel Bornemann 	103579	Dubich & Stehr 	Herr Defren	Hamburg	2025-05-15	Lieferdatum AB Klären über Laura ( Samira ) hat angepasst und neue AB zugesendet	HKS Classic Akku usw beim nächsten bestellen berücksichtigt ( Herr Defren )	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1687	excel-import-user	import@system.com	Marcel Bornemann 	102750	Büro	Herr Bornemann	Hamburg	2025-05-16	Teamsmeeting Planung Berichte Hotel buchen Termine und Angebote vorbereiten ,	Angebote JC und Aufträge JC vorbereiten 	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1688	excel-import-user	import@system.com	Jörg Priebe	105090	Hemmersbach In dustriebedarf	Hr.Hemmersbach	Berlin	2025-05-08	 SNP Angebot div. Abm. 6-12x210 je 100Stk. Gegen ProJahn, Meissel, Stich.u.Säbensöge dito. - Angebot G.H // bst. 09.05.25/ Gesamtangebot 12.05.25	\N	B	\N	\N	45421	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1689	excel-import-user	import@system.com	Jörg Priebe	105090	Hemmersbach In dustriebedarf	Hr.Hemmersbach	Berlin	2025-05-12	 SNP Angebot div. Abm. 6-12x210 je 100Stk. Gegen ProJahn, Meissel, Stich.u.Säbensöge dito. - Angebot G.H // bst. 09.05.25/ Gesamtangebot 12.05.25	\N	B	984.30	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1690	excel-import-user	import@system.com	Jörg Priebe	106000	Brun & Böhm GmbH	Hr.Pasewalk,Hr.Knoblich	Potsdam	2025-05-12	Präsentation.- und Verkaufskonzept, Neuheiten, … Präsentationumbau, Erweiterung/ Angebot top_Seller/ Komplettumbau Eurobaustoffe Ende 3.Q25	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1691	excel-import-user	import@system.com	Jörg Priebe	100117	Siebert Oetzel OHG	Christian Klenke	Berlin	2025-05-12	Aktion Mai 10% auf alles ab 5000.-	\N	A	\N	5000.00	45793	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1692	excel-import-user	import@system.com	Jörg Priebe	109163	BHG Handelszentrten Luckau	Silvio Bunk	Lübben	2025-05-12	Heller_Top_Seller Dünntrennsch. Doste je 40Stk. 314275; 314299/ d225mm Trockensch.-scheib je 40Stk. 323260 K80; 323284 K180	\N	A	994.40	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1693	excel-import-user	import@system.com	Jörg Priebe	102902	HFM Gruppe 	Herr Schilling	Luckenwalde	2025-05-14	HFM Gruppe (BZ Sommer und 3 HFM Standorte 102902 Pankow; Pilgramer 102907; Luckenwalde102901; BZ Sommer 108671 //Umbau a 8500.- (Warenrücknahme Pennerartikel Heller Einrichtung vor ca. 5 Jahren)	\N	A	\N	8500.00	45791	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1694	excel-import-user	import@system.com	Jörg Priebe	101125	Konak Baustoffhandelsges.	Herr Umit	Berlin	2025-05-14	Umzug, Umbau Power Tower; Neuheiten Vorst. N.B.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1695	excel-import-user	import@system.com	Guido Hinken	Verband	NW Kuppeltreffen 	\N	\N	2025-05-13	Termine 	Nachfassen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1696	excel-import-user	import@system.com	Guido Hinken	nn	Kaiser	\N	\N	2025-05-13	Angebot passt	Muster versenden	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1697	excel-import-user	import@system.com	Guido Hinken	Verband	Nordwest	Herr Neynaber	\N	2025-05-13	Lagerauftrag Heller mit 10% Extra Rabatt ab 50.000€ nochmals angeboten.	\N	A	\N	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1698	excel-import-user	import@system.com	Guido Hinken	Verband	hagebau	Herr Pellny	\N	2025-05-14	PFM Listung Neuheiten ergänzen auch Schleifen, Trennen und Diamant	Listung geprüft, Fehler behoben und versendet	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1699	excel-import-user	import@system.com	Guido Hinken	nn	Brickwedde	Herr Königsmann	Osnabrück	2025-05-14	Angebot nachgefasst	Geht in Elternzeit. Entscheidung im Juli	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1700	excel-import-user	import@system.com	Guido Hinken	nn	Delmes	\N	\N	2025-05-14	Bosch Bierfaß Aktion ab VK Wert 75€ gibt es 1 Bier Faß für den Endkunden!	Sommer Grill Aktion planen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1701	excel-import-user	import@system.com	Guido Hinken	Verband	Bauking	\N	\N	2025-05-14	Bauking/ BME Bonus 2023 mit AV besprochen	Auszahlung vorbereiten	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1702	excel-import-user	import@system.com	Guido Hinken	nn	Baustoff Verbund Süd	Herr Lippert	\N	2025-05-15	Vertrag unterzeichnet	Gesellschafterliste und Rabattliste an ADM mailen	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1703	excel-import-user	import@system.com	Guido Hinken	nn	Suki	Herr Graf	\N	2025-05-15	Genereller Austausch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1704	excel-import-user	import@system.com	Guido Hinken	nn	Suki 	Herr Schörkhuber	\N	2025-05-15	Lagerhaus AT	Präsentation mailen	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1705	excel-import-user	import@system.com	Guido Hinken	nn	Böttcher	Herr Wünsch	\N	2025-05-15	Erstkontakt 	Präsentation und Katalog mailen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1706	excel-import-user	import@system.com	Guido Hinken	nn	Lagerhaus 	\N	\N	2025-05-15	Kontakt wird über Herrn Schörkhuber vermittelt	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1707	excel-import-user	import@system.com	Guido Hinken	Verband	Bauking / BMN / BME	\N	\N	2025-05-15	Bonusvereinbarung 2025 Vorschlag mit AV  besprochen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1708	excel-import-user	import@system.com	Guido Hinken	Verband	Contract Company	\N	\N	2025-05-16	Neukunde Honig 	Telefonat nächste Woche	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1709	excel-import-user	import@system.com	Andreas Stockbauer	109446	Meier	Hr. Gebhard	Amberg	2025-05-12	Hr. Gebhard geht im November in Rente, neuer Mitarbeiter kommt Anfang Juni	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1710	excel-import-user	import@system.com	Andreas Stockbauer	100713	Danhauser	Hr. Moser	Amberg	2025-05-12	Modulwandpflege	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1711	excel-import-user	import@system.com	Andreas Stockbauer	102566	Danhauser	Hr. Trautner	Schwandorf	2025-05-12	Bestellung wurde bereits selber gemacht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1712	excel-import-user	import@system.com	Andreas Stockbauer	109626	Meier	Hr. Feigl	Sulzbach	2025-05-12	Bestellung wurde bereits selber gemacht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1713	excel-import-user	import@system.com	Andreas Stockbauer	107120	BHG AG - BFH Bayreuth	Hr. Glas	Bayreuth	2025-05-12	Teams Termin 14.00h Erweiterung Standort Weiden, Folgetermin am 20.05.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1714	excel-import-user	import@system.com	Andreas Stockbauer	104203	Meier Handwerkerbedarf GbR	\N	Ansbach	2025-05-13	aktuell kein Bedarf, Unterlagen aktualisiert	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1715	excel-import-user	import@system.com	Andreas Stockbauer	109308	Ruf Baustoffe GmbH	\N	Wilburgstetten	2025-05-13	Unterlagen, Aktion	in Besuchsrythmus einpflegen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1716	excel-import-user	import@system.com	Andreas Stockbauer	100329	Pflüger Baustoffe GmbH	\N	Marktbergel	2025-05-13	aktuell kein Bedarf, Unterlagen aktualisiert	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1717	excel-import-user	import@system.com	Andreas Stockbauer	103419	Hein GmbH & Co.KG	\N	Mitwitz	2025-05-14	Aktion	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1718	excel-import-user	import@system.com	Andreas Stockbauer	102093	Langguth GmbH	\N	Coburg	2025-05-14	Angebot Schleifen besprochen um Wand wieder aufzufüllen nach Sortimentsbereinigung Duster	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1719	excel-import-user	import@system.com	Andreas Stockbauer	107145	Fritz Schlund	\N	Coburg	2025-05-14	Aktion	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1720	excel-import-user	import@system.com	Andreas Stockbauer	100992	Gebhardt Bauzentrum GmbH	Hr. Huss	Erlangen	2025-05-14	Aktion, interessiert an Spachtelmeissel, Hr. Zenk kümmert sich um Einlistung 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1721	excel-import-user	import@system.com	Andreas Stockbauer	101001	Gebhardt Bauzentrum GmbH	Hr. Treutlein	Karlstadt	2025-05-15	Mitarbeiterschulung, 	Angebot Bittower	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1722	excel-import-user	import@system.com	Andreas Stockbauer	101004	Gebhardt Bauzentrum GmbH	Hr. Seufert	Hammelburg	2025-05-15	Aktion, interessiert am Spachtelmeissel	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1723	excel-import-user	import@system.com	Andreas Stockbauer	108734	Gebhardt Bauzentrum GmbH	Hr. Häusler	Marktheidenfeld	2025-05-15	Aktion, interessiert am Spachtelmeissel. Möchte Schleifmeter von Dewalt umstellen, muss noch Bestand abverkaufen. Termin für Juli avisiert	Wiedervorlage	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1724	excel-import-user	import@system.com	Andreas Stockbauer	101006	Gebhardt Bauzentrum GmbH	Hr. Franz	Höchberg	2025-05-15	Aktion, Rekalmation Bits nochmal thematisiert	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1725	excel-import-user	import@system.com	Andreas Stockbauer	105847	Werkzeug & Maschinen für Handwerk	Hr. Wedel	Pommersfelden	2025-05-15	Angebot 4Power nachgefasst, ist aktuell noch in Prüfung	Wiedervorlage	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1726	excel-import-user	import@system.com	Frank Papperitz	104828	DVS	Frau Zilly	Thalheim	2025-05-15	Altkunde, der verstärkt Kabelkonfektion macht, hat ein paar Trennscheibendosen bestellt, Bohrer sonst fast alle von Oren	\N	B	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1727	excel-import-user	import@system.com	Frank Papperitz	107611	Krabbes	Robert Gerber	Leipzig	2025-05-14	Absatz stark eingebrochen, hohe Bestände, kauft auch Kleinbedarf Heller beim NW	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1728	excel-import-user	import@system.com	Frank Papperitz	104505	Diamasa	Sylvia Hoffmann	Grimma	2025-05-14	Aktion und Meisselaktion besprochen, kauft manchamla Ratio, sonst DeWalt-Partner 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1729	excel-import-user	import@system.com	Frank Papperitz	106572	HNT Leipzig	Frau Petersohn	Leipzig	2025-05-14	Chef nicht da, vorwiegend Bezug ab Stammhaus Riesa	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1730	excel-import-user	import@system.com	Frank Papperitz	108301	ELG Bau	Frau Banus	Leipzig	2025-05-14	Dia + Trenn bereits durch Disk, Schleifen bei Bauteam	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1731	excel-import-user	import@system.com	\N	105190	SHA	Thomas Hofmann	Leipzig	2025-05-14	Heller- Wand sehr voll, will Sortiment nicht ausweiten, kaum Laufkundschaft, Schwerpunkt: online-Handel Makita und Husquarna und neu: Milwaukee	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1732	excel-import-user	import@system.com	Frank Papperitz	100760	Bauking	Mirko Braunert	Leipzig	2025-05-14	0- Dreher begutachtet, Klebepunkte ein Problem auf Verpackung Kreissägen, versuchen es erstmal mit starker Preisreduzierung, Umbau steht an	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1733	excel-import-user	import@system.com	Frank Papperitz	107912	Paul Sommer Steinindustriebedarf	Tino Schönfeld	Löbau	2025-05-15	spezialisierter Fachhandel, Erstauftrag 3 x HM- Stockermeissel zum Test	\N	B	100.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1734	excel-import-user	import@system.com	Cord-Jürgen Bruns	108698	Hinrichs  	\N	Apen	2025-05-12	Stich und Säbelsägen aufgebaut; Anfrage Kreissägen und Bohrkronen bekommen	anbieten	A	\N	5000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1735	excel-import-user	import@system.com	Cord-Jürgen Bruns	102856	Schulte	Herr Neuenstein	Rhede	2025-05-13	Anfrage Artikel für Dealer Days 2xPrivat und Gewerbe	auswählen und anbieten	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1736	excel-import-user	import@system.com	Cord-Jürgen Bruns	103187	Mundfortz	Herr Nobereit	Schwalmtal	2025-05-13	Aufbau Sortimentserweiterung Starlock und Schleifen	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1737	excel-import-user	import@system.com	Cord-Jürgen Bruns	100220	Paul Swertz GmbH	Jutta Seyen, NLL	Viersen	2025-05-14	Unterlagen aktualisiert; Aktionen vorgestellt: findet sie toll - aber zur Zeit keinen Bedarf!	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1738	excel-import-user	import@system.com	Cord-Jürgen Bruns	103404	Paul Swertz GmbH	Herr Rudnick	Moers	2025-05-14	Unterlagen aktualisiert; Aktionen vorgestellt; findet die EAN-Codes auf Kreissägeblättern immernoch zu klein; will bestellen und das Minus durch die Gutschrift ausgleichen	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1739	excel-import-user	import@system.com	Cord-Jürgen Bruns	102917	Baucentrum Stewes GmbH & Co.KG	Herr Schmitthausen	Dinslaken	2025-05-14	Unterlagen aktualisiert; Aktionen vorgestellt; Herr Ötztürk (ppa.) hatte keine Zeit	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1740	excel-import-user	import@system.com	Cord-Jürgen Bruns	102951	Baucentrum Stewes GmbH & Co.KG	Melis Mustafa	Wesel	2025-05-14	FM; Unterlagen aktualisiert; Aktionen vorgestellt; sie will ihrem Mitarbeiter hier nicht vorgreifen, wird aber mit ihm sprechen, was passt	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1741	excel-import-user	import@system.com	Cord-Jürgen Bruns	103023	Baucentrum Stewes GmbH & Co.KG	Herr Wollborn	Wesel	2025-05-14	BM; Unterlagen aktualisiert und Aktionen vorgestellt; Präsentation aufgeräumt und Ware eingeräumt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1742	excel-import-user	import@system.com	Cord-Jürgen Bruns	109371	Ehning Baustoffhandel GmbH	Herr Rottstegge	Borken-Weseke	2025-05-14	hatte schon Feierabend	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1743	excel-import-user	import@system.com	Cord-Jürgen Bruns	109371	Ehning Baustoffhandel GmbH	Herr Rottstegge	Borken-Weseke	2025-05-15	Unterlagen aktualisiert; Aktionen vorgestellt; Angebot nachgefasst; das passt ihm noch nicht: Änderungen besprochen und eine passende Lösung gesucht	Änderungen ausarbeiten und anbieten	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1744	excel-import-user	import@system.com	Cord-Jürgen Bruns	102415	Wessmann Bauzentrum GmbH & Co. KG	Herr Eggern	Lingen (Ems)	2025-05-15	Unterlagen aktualisiert; Reklamation bearbeitet; möchte Starlock in der Wand integrieren	Vorbereiten und im Mai nochmals besuchen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1745	excel-import-user	import@system.com	Cord-Jürgen Bruns	108428	bauXpert Knipper GmbH & Co. KG	Her Purk	Sögel	2025-05-15	Herr Purk informierte mich, dass man auf Bosch umstellen wird; Begründung:Preise: Bosch hat 3Qualitäten und Preis-Segemente; die mittlere ist auf Nivau von Makita; für diese hat man sich entschieden mit einigen Produkten der Premium Serie; Termin im Juni; ein weiterer Grund ist unsere anhaltend schlechte Lieferperformance	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1746	excel-import-user	import@system.com	Jens Werner	106265	Adolf Würth GmbH & Co. KG	 Helen Pfitzer	\N	2025-05-20	Terminanfrage für Sortimentsausbau	nachhaken	A	\N	20000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1747	excel-import-user	import@system.com	Jens Werner	102095	ERPATECH BEATA PRAGA SP. Z O.O.	Michał Ulikowski	\N	2025-05-20	Angebot 2-Schneider 5,2mm	nachhaken	B	\N	10000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1748	excel-import-user	import@system.com	Jens Werner	100909	Hoffnung Korea	Jay Kim	\N	2025-05-22	Fragen zu Rückständen / Habe dem Kunden 5% angeboten für neuen Auftrag	Kunde prüft, ob Sonderbestellung trotz Rückständen aufgeben kann	A	85000.00	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1749	excel-import-user	import@system.com	Jens Werner	101935	Rawlplug S.A.	Michał Sadowski	\N	2025-05-22	Besuch durch NL. Darafhin habe ich heute ALLMAT PRO, Rebar Breaker, Core Drills, INCH Range angeboten	Warten auf Rückmeldung	B	\N	150000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1750	excel-import-user	import@system.com	Yasir Angar	150100	LOBOMATIC AB	Jonathan Westh	SE	2025-05-21	Umsatzrückstand zu Plan / Call mit Marcus Bergstedt.	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1751	excel-import-user	import@system.com	Yasir Angar	150087	Ferrometal Oy	Juuso Moilanen	FI	2025-05-21	Umsatzrückstand zu Plan / Call mit Juuso Moilanen	Wird im Mai bestellen	B	\N	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1752	excel-import-user	import@system.com	Yasir Angar	101468	HOMBERGER S.P.A.	Luca Boscarino	IT	2025-05-20	Umsatzsteigerung / Besprechung - Auftrag für OMNIA	Wird im Mai bestellen	A	\N	\N	45812	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1753	excel-import-user	import@system.com	Yasir Angar	150181	George Katsafados Ltd	Elena Nicolaou	CY	2025-05-21	Umsatzrückstand zu Plan	Wird im Mai bestellen	B	10000.00	\N	45812	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1754	excel-import-user	import@system.com	Martin, Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-05-19	Mail bezueglich groesserer Bestellung, wann wird eine neue Bestellung kommen. Noch keine Entscheidung AB 3.8K EUR	Naechste Gespraech naechste Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1755	excel-import-user	import@system.com	Martin, Palme	109842	Hept SK	Hr. Bong	Mail	2025-05-22	Wir habe im Moment Zahlungsrueckstaende von ca. 46.6K EUR, und lt. Kunden will er diese bis Mitte des Jahres bezahlen. Ich habe hier auch Druck ausgeuebt, ob er auch bereits Teilzahlungen machen kann, was es dann auch einfacher fuer den Kunden macht und seinen Willen zeigt, dies auch richtig in Angfriff zu nehmen. Habe auch mitgeteilt, dass wir bei Nichteinhaltung bis Mitte des Jahres uns dann ueberlegen muessen, hier ueber einen neuen Distributor nachzudenken. Der PL Kunde Cretec macht ihm natuerlich auch das Leben schwer, da er mit heftigen Promotions in den Markt geht. AB 13.8K EUR	Naechste Gespraech Anfang naechster Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1756	excel-import-user	import@system.com	Martin, Palme	103214	ZI-TECH TH	Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-05-20	Kleinere Luftfrachbestellungen erhalten. In Kuerze kommt eine HSS Inch Bestellung. AB 10.7K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1757	excel-import-user	import@system.com	Martin, Palme	105577	Mach Tools PH	Nancy Yu & Karlo Yu	Tel., Mail, Messenger	2025-05-20	Verschiffung Lieferung. 45K EUR im Maerz bestellt, teilweise ausgeliefert. AB 24.4K EUR welche im Mai ausgeliefert werden sollte.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1758	excel-import-user	import@system.com	Martin, Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-05-22	 Angebot erstellt und dem Kunden zugesendet, 22.05.. 11 neue Positionen (ca. 3-4K EUR) werden dem Angebot hinzugefuegt. Offizielle Bestellung erfolgt nach Bestaetigung des MD	Die Bestellung sollte dann in Kuerze kommen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1759	excel-import-user	import@system.com	Martin, Palme	100714	Sing Kee HK	Ric	Mail	2025-05-23	Kunde war bis 22.05.2025 im Urlaub. 23.05.2025 nachgefragt, Kunde wird pruefen.	Nachfassen wegen der 10%/15K EUR Bestellung, letzte Woche der Promotion 	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1760	excel-import-user	import@system.com	Martin, Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-05-22	Interesse weiterhin fuer den Tapcon Bohrer, Kunde moechte nun Muster haben, an AD weitergeleitet, um die Muster von Lieferanten zu bekommen. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2223	excel-import-user	import@system.com	Guido Hinken	Verband	Nordwest	\N	\N	2025-06-12	Kalkulation Meißelprogramm für Tecwerk	Angebot gemailt	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1761	excel-import-user	import@system.com	Martin, Palme	100501	CSH SIN	Eric	Mail, Messenger	2025-05-22	AB 4.9K EUR sollte im Mai ausgeliefert werden. Lieferung steht bereits, Rueckfragen, wie geliefert werden soll.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1762	excel-import-user	import@system.com	Martin, Palme	150348	Wakai JP	Iwawaki, Nene	Mail	2025-05-20	Angebot gesendet. Endkunde hat weiterhin noch nicht entschieden. AB 12.8K EUR	Naechste Woche nachhaken, wenn keine Bestellung kommt	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1763	excel-import-user	import@system.com	Martin, Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-05-23	Moechten Heller Distributor werden, Muster festgelegt, mussen nun versendet werden, hoffentlich sind alle verfuegbar. Ende Mai Pruefung, ob 10 %/15K EUR Bestellung gemacht werden kann. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist von mir dann angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1764	excel-import-user	import@system.com	Martin, Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-05-23	Nachfrage wegen 10 % / 15K EUR Bestellwert. Wird weiterhin gesprueft. Anfrage fuer ein Porjekt erhalten, Durchmesser mit den Laengen teilweise nicht als Standard. Andere Durchmesser angeboten. Hier taeglich in Kontakt, um den Auftrag zu bekommen, da hier mit Folgeauftraegen zu rechnen ist.	Naechste Woche nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1765	excel-import-user	import@system.com	Pantaleo Stomeo	103074	Bauking Südwestfalen GmbH	Herr Hübner	57080 Siegen	2025-05-19	Allgemeiner Kundenbesuch, Herr Hübner hatte um einen Termin gebeten um mal wieder über das Thema Sortimentsbereinigung zu sprechen. Vor Ort habe ich Ihm nochmals erklärt was vereinbart ist und das er 1zu1 zurückgeben kann wir aber nur einmalig umbauen. Er will aber die knapp 8000 € Stückchenweise zurückgeben weil er nicht auf einmal so viel bestellen kann. Wir haben dann ca. 1 1/2 Stunden damit verbracht die Retoure zu packen und eine neue Bestellung zu planen. Am Ende ist nun raus gekommen das man jetzt ca. 1600 € zurückgeben will und auch nur für den selben Wert bestellen. Den Rest will er dann im Laufe des jahres nach und nach zurückgeben.	Warten bis Herr Hübner die Retoure und Bestellung mir zukommen lässte um diese dann zwecks Erfassung an den ID weiterzuleiten	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1766	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Carl Müller Söhne	Herr Alexander Günter	57612 Kroppach	2025-01-01	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Günter. Vor Ort sind 1,25 x2m von Makita mit denen man lt. Herrn Günter auch zufrieden ist, man zudem sehr gute Konditionen weil man auch die Maschinen davon verkauft und man schon ewig Makita hat.  Er kann sich nivht vorstellen das man hier einen Wechsel vornehmen wird, dennoch durfte ich unseren aktuellen Ordner vorstellen und da lassen den er sich dann mal in Ruhe anschauen will. Er meinte zum Schluss das wir uns aber keine allzu großen Hoffnungen machen sollen das man auf uns zukommt.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1767	excel-import-user	import@system.com	Pantaleo Stomeo	101173	Bauking Südwestfalen GmbH	Herr Bottenberg	57290 Neunkirchen	2025-05-19	Allgemeiner Kundenbesuch, bei diesem Standort handelt es sich einen der wenigen Baukings wo wirklich alles in Ordnung ist. Die Wand ist gut gefüllt und man hat keine Reklamationen oder Beschwerden vorliegen. Aufgrunddessen das die Wand noch gut gefüllt ist, ist heute keine Dispo notwendig. Aktuelle Aktion erneut vorgestellt.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1768	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	R. Göbel Baufachhandel GmbH	\N	57076 Siegen	2025-05-19	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen ohne mich als Firma Heller auszugeben. Vor Ort habe ich festgestellt das man hier so gut wir garkein Maschinenzubehör anbietet. Man kann Fliesen, Beton, Steine usw. kaufen aber eine wirkliche Verkaufsfläche ist hier nicht vorhanden. 	Keine weiteren Besuche mehr notwendig	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1769	excel-import-user	import@system.com	Pantaleo Stomeo	103013	Rompel Baustoffe GmbH	Herr Michael Schnöde	57319 Bad Berleburg	2025-05-19	Allgemeiner Kundenbesuch, die Umlagerung der Ware aus der anderen Niederlassung ist bereits erfolgt. Vor Ort ist nun ein wenig Ware die Herr Schnöde nun retounieren möchte und dafür dann im doppelten Wert neue Ware bestellt.  Sonst ist hier alles in Ordnung, man hat keine Reklamation oder Beschwerde vorliegen. Katalog, Preisliste, Aktion und neue Flyer vorgestellt und abgegeben !	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1770	excel-import-user	import@system.com	Pantaleo Stomeo	101073	Bauking Südwestfalen GmbH	Frau Jennifer Bohleber	57462 Olpe	2025-05-19	Allgemeiner Kundenbesuch, Frau Bohleber meinte heute wieder zu mir das man von der Zentrale die Info hat das Bestände reduziert werden müssen und das man eigentlich nicht bestellen soll. Dennoch wollte Sie das ich wie vereinbart alle 4-6 Wochen eine Dispo mache. Nachdem ich im März noch darauf verzichten sollte, habe ich heute eine DISPO gemacht. Kunde ist mit Heller sehr zufrieden und hat keine Reklamationen oder so vorliegen. Artikel aus der Aktion wurden wieder bestellt. 	In Abständen von 4-6 Wochen immer wieder hinfahren und eine DISPO machen	A	600.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1771	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Raiffeisen Waren GmbH	Frau Andrea Rohde	34497 Korbach	2025-05-20	Kunde ist mir vor 2 Wochen aufgefallen als er über eine NL die bereits bei uns kauft Butler Artikel gekauft hat. Daraufhin für heute einen Termin mit Frau Rohde vereinbart, heute mich und Heller vorgestellt. Vor Ort sind NUR 2 Module mit paar Bohrer von Hans Werner und unsere Butler Artikel. Habe es geschafft Frau Rohde direkt zu überzeugen und Sie wird nun erstmal eine kleine Ersteinrichtung von 1,25 x 2m mit 7 Modulen von Heller erhalten. Das ganze soll dann auch mitte Juni schon eingerichtet werden.	Behangplan erstellen und dem ID die Bestellung mitteilen zwecks Eingabe damit mitte Juni eingerichtet werden kann.	B	4000.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1772	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Clemens Kühlert GmbH & Co. KG	Herr Wienert	34414 Warburg	2025-05-20	Eursobaustoffneukunde: Heute wollte ich mich und die Firma Heller bei diesem Kunden vorstellen. Vor Ort habe ich erfahren das es sich bei dieser Filialie nur um ein Außenlager ohne wirklicher Verkaufsfläche handelt. Man hat 5 verschiedene Abmessungen an Bohrer hier im Büro platziert und das wars. Der Einkauf läuft komplett über die Zentrale in 34434 Borgentreich und der Ansprechpartner hier ist Herr Förster. Gerne kann ich mal mit Ihm sprechen und dann da Heller vorstellen	In der Zentrale in 34434 Borgentreich vorstellig werden und Heller vorstellen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1816	excel-import-user	import@system.com	Mark Smethurst	Prospect	UK Drills Ltd	Peter	Hindley	2025-05-20	Cold call. Catalogue and Business card.	Follow up end next month	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1773	excel-import-user	import@system.com	Pantaleo Stomeo	101370	FKR Baucentrum NL Wabern	Herr König 	34590 Wabern	2025-05-20	Allgemeiner Kundenbesuch, der Kunde wurde von mir im Februar 2025 neu eingerichtet und ist sehr sehr zufrieden. Man hat keine Reklamationen oder Beschwerden in dieser Zeit erhalten und man musste auch schon einige Haken wieder füllen. Auch heute waren einige Haken leer und nach Rücksprache mit Herrn König sollte ich eine DISPO durchführen. Katalog und Preisliste vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	1000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1774	excel-import-user	import@system.com	Pantaleo Stomeo	100826	FKR Baucentrum NL Schwalmstadt	Herr Wollny	34613 Schwalmstadt	2025-05-20	Allgemeiner Kundenbesuch, Herr Ahlheit der normalerweise mein AP ist, ist aktuell in KUR. Die Vertretung  macht Herr Wollny, er hatte mich vor 3 Wochen nach neuen Etiketten gefragt, die ich bei Paul angefordert hatte und meinte das diese immer noch nicht da sind. Paul direkt per Mail informiert das er bitte dem Kunden schnellstmöglich die Etiketten zuschicken lässt. Sonst ist hier alles in Ordnung, die Wand war gut gefüllt, daher keine DISPO notwendig. Katalog und Preisliste abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1775	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Krügers Baufachzentrum GmbH	Frau Svenja Kirk	31840 Hessisch Oldendorf	2025-05-21	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Frau Svenja Kirk. Vor Ort vertreibt man Hauptsächlich Maschinen von Metabo und man hat dann noch 4m von Maschinenzubehör von Metabo. Man ist damit sehr sehr zufrieden und man hat auf keinen Fall vor irgendwas daran zu ändern. Schön das wir vor Ort waren und alles mal vorgestellt haben aber einem Wechsel wird man hier solange es so läuft wie es aktuell läuft nicht anstreben. Aktuellen Ordner abgegeben	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1776	excel-import-user	import@system.com	Pantaleo Stomeo	101047	Krüger Hannover GmbH & Co, KG	Herr Droboyan	30952 Ronnenberg	2025-05-21	Allgemeiner Kundenbesuch, Kunde wurde ja Ende 2024 von mit eingerichtet und der Verkauf der Ware startete erst Ende Februar 2025 weil man mit dem Umbau noch nicht fertig war. Auch heute stellte sich heraus das man immernoch am Umbauen ist und die Offizielle Neueröffnung noch nicht stattgefunden hat. Man Verkauft aber schon Ware und unsere Produkte kommen gut an aber ein Fazit kann natürlich noch nicht ausgesprochen werden. Dispo nicht gewünscht das macht mein Haupt AP Herr Hülse, der ist allerdings diese Woche krank. Aktuelle neue Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1777	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Holtzmann & Sohn GmbH	Empfangsdame	30952 Ronnenberg	2025-05-21	Eurobaustoffneukunde: Wollte mich und die Firma Heute hier vorstellen. Bei diesem Standort handelt es sich aber nur um einen Riesen Aussteller für Badezimmer, Pools usw. Auf Nachfrage bei der Empfangsdame meinte Sie zu mir das man hier keinen Fachmarkt oder sowas hat wo man Maschinenzubehör verkauft. Hier muss man also klären in welchem Standort Maschinenzubehör anbietet und dann dahin fahren und vorstellig werden	Rausfinden in welchem der Standorte Maschinenzubehör verkauft wird und dann da vorstellig werden	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1778	excel-import-user	import@system.com	Pantaleo Stomeo	103370	Hotze GmbH & Co. KG 	Herr Jasper Holtrop	30880 Laatzen-Gleidingen	2025-05-21	Allgemeiner Kundenbesuch, vor ort stellte ich fest das mein alter AP Herr Lausch nicht mehr im Unternhemen tätig ist. Neuer AP und Niederlassungsleiter ist Herr Holtrop, er kennt Heller aus alten Zeiten in der Filiale Rahden. Er ist an sich mit Heller sehr zufrieden und muss erstmal ankommen, er hat vor einiges im markt zu verändern und da kann es auch sein das man mal über das Hellersortiment schaut. Dies soll aber nicht vor November passieren da er noch andere Baustellen hat die viel dringender sind. Vor unsere Wand lag die Bestellung die frisch eingetroffen und noch eingerümt werden muss, daher keine Dispo notwendi. Neuen Ordner Herrn Holtrop gegeben damit er aktuelle Unterlagen hat. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1779	excel-import-user	import@system.com	Pantaleo Stomeo	100507	Karl Krüger GmbH & Co. KG 	Herr Sergiu Filion	31134 Hildesheim	2025-05-21	Allgemeiner Kundenbesuch, Herr Engelbrecher nicht da dafür der Kollege Herr Filion. Man hat keine Reklamationen oder Beschwerden vorliegen und ist mit Heller auch sehr zufrieden. Die Wand hatte einige Lücken, daher eine DISPO nach Rücksprache mit Herrn Filion gemacht. Aktuellen Ordner und Preisliste abgegeben. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	700.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1780	excel-import-user	import@system.com	Pantaleo Stomeo	107448	WMT GmbH	Herr Vornkahl	31135 Hildesheim	2025-05-22	Allgemeiner Kundenbesuch, Herr Willeke diese Woche leider nicht da. Dafür der Kollege der sich ein wenig Zeit genommen hat. Es gibt nix zu meckern, man hat keine Reklamationen oder Beschwerden, vor kurzem hat man noch für knapp 400 € bestellt und somit isst keine Dispo notwendig. Neuheiten und Aktionen erneut vorgestellt aber hier ist kein interesse.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1781	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Butterbrodt Bauzentrum 	Herr Robert Ernst	31137 Hildesheim	2025-05-22	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Robert Ernst. Direkt am eingang hat mich Herr Ernst abgefangen und fragte mich wer ich bin, habe Ihm Heller und unser Konzept vorgestellt, daraufhin meinte er das man hier garkein Maschinenzubehör verkauft und daher uninteressant ist. Selbst auf nochmaligen Fragen ob hier kein Bohrer, Meißel oder Stichsägeblatt oder so verkauft wird wiederholte er das man nix verkauft und nix ausgestellt hat. Als wir uns dann verabschiedet haben bin ich durch den Laden gegangen und sehe das da 4 Module Hans Werner mit Bohrer und Diamant von Diewe ausgestellt ist. Der Herr Ernst wollte mich einfach nur loswerden und ich glaube nicht das hier was kommt.	Keine weiteren Besuche mehr notwendig	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1782	excel-import-user	import@system.com	Pantaleo Stomeo	105980	Himmler Bauzentrum GmbH & Co. KG	Herr Gutzlaff	31319 Höver	2025-05-22	Allgemeiner Kundenbesuch, Herr Gutzlaff meinte heute zu mir nachdem er ja im Febraur meinte das es einen neuen Chef geben würde und er sich alle Sortimente anschauen wird um dann ggf. Änderungen vorzunehmen das Heller so weiterlaufen soll wie bisher. Man ist zufrieden und hat keine Beschwerden oder Reklamationen. Es ist sehr Ruhig und wenn Bedarf ist wird bestellt. Dispo nicht gewünscht da man das hier selbst macht. Neuen Katalog und Preisliste abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1783	excel-import-user	import@system.com	Pantaleo Stomeo	106270	Bauking Weser Ems 	Herr Scholz	31582 Nienburg	2025-05-22	Allgemeiner Kundenbesuch, Herr Scholz ist sehr zufrieden. Man hat keine Reklamationen oder Beschwerden vorliegen. Erst gestern hat er noch eine Bestellung getätigt wo er auf eine AB wartet. Neue komplette Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1784	excel-import-user	import@system.com	Marcel Bornemann 	102750	Büro	Herr Bornemann	Hamburg	2025-05-19	Rückstandliste Musterhalle Hagebau Soltau Prüfen , Modulteile und Ware Nachsenden lassen 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1785	excel-import-user	import@system.com	Marcel Bornemann 	100517	Rudolf Sievers	Herr Pahl	Seevetal	2025-05-19	Sortiemensbereingung aus den 7 Häusern Rudolf Sievers sichten und Sortiernen in wiedereinlagerbar und geht nicht zurück . Besprechen und gegenauftrag für die Ware die zurückgeführt wird .	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1786	excel-import-user	import@system.com	Marcel Bornemann 	102750	Auto packen für Musterhalle	Herr Bornemann	Hamburg	2025-05-19	Auto Packen Modulteile und weiter Artikel s wie aufbauhilfen Tisch Werkzeug ..	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1787	excel-import-user	import@system.com	Marcel Bornemann	102750	Büro	Herr Bornemann	Hamburg	2025-05-23	Teamsmeeting Berichte Planung und Umbau Angebot .	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1788	excel-import-user	import@system.com	Guido Hinken	Verband	NW Zentrale	\N	Dortmund	2025-05-19	Fachwerk wird weiter ausgebaut. Kennenlernen neuer PM Herr Laber 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1789	excel-import-user	import@system.com	Guido Hinken	100403	Baucentrum Stewes GmbH & Co. KG	Herr Ruwe	Gladbeck	2025-05-19	Store-Check: Heller im Baumarkt; hat keine Probleme, will bestellen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1790	excel-import-user	import@system.com	Guido Hinken	101031	Baucentrum Stewes GmbH & Co. KG	Herr Bergermann	Gladbeck	2025-05-19	Store-Check: Vergleich im PFM; keine Probleme	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1791	excel-import-user	import@system.com	Guido Hinken	103401	Paul Swertz GmbH	Herr Küsters	Kleve	2025-05-19	Unterlagen aktualisiert; Neuheiten und Aktionen vorgestellt: interessiert	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1792	excel-import-user	import@system.com	Guido Hinken	103251	Paul Swertz GmbH	Herr Wehr	Goch	2025-05-19	Aktionen und Neuheiten vorgestellt: bestellt	erfassen und liefern	A	3200.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1793	excel-import-user	import@system.com	Guido Hinken	103252	Paul Swertz GmbH	Herr Schwartges	Straelen	2025-05-20	Aktionen und Neuheiten vorgestellt: bestellt	erfassen und liefern	B	400.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1794	excel-import-user	import@system.com	Guido Hinken	106817	Mobau Profi Zentrum	Herr Nietsch	Heinsberg	2025-05-20	Aktionen und Neuheiten vorgestellt: bestellt; Kreissägen anbieten	erfassen und liefern	A	1000.00	300.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1795	excel-import-user	import@system.com	Guido Hinken	100026	Kipp & Grünhoff GmbH & Co. KG	Herr Widdermann	Köln	2025-05-20	Aktionen und Neuheiten vorgestellt: will Schleifen bestellen; Macht im Herbst eine Hausmesse: Teilnahme und WKZ 500,-€ zugesagt	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1796	excel-import-user	import@system.com	Steve Bell	105655	Midfix	Dan	Nottingham	2025-05-19	On plan Lit, offer Rebar cutters & £6000 @ 6% May June invoice	Reg Visit	B	\N	6000.00	8	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1797	excel-import-user	import@system.com	Steve Bell	105118	Machine Mart	Phil	Nottingham	2025-05-19	Warranty return	Meeting Buyer	A	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1798	excel-import-user	import@system.com	Steve Bell	102809	Power Tools Plus	Luke / Charlie	Nottingham	2025-05-19	stock order (ordered in April) - Quite MD/ Buyer on Vacation	Meet with Paul MD	B	150.00	550.00	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1799	excel-import-user	import@system.com	Steve Bell	100027	Merit	Cam	Nottingham	2025-05-19	Lit, Rebar Promo- not interested 2000 in May 5% June invoice 	Reg Visit	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1800	excel-import-user	import@system.com	Steve Bell	Prospect	Juice Electrical	\N	Nottingham	2025-05-19	Office moved (website not updated) HQ Derby for visit 	Appt with Derby Steve	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1801	excel-import-user	import@system.com	Steve Bell	109459	Toolman Yardley	Paul	Birmingham	2025-05-20	Stock Order 	Visit	B	1500.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1802	excel-import-user	import@system.com	Steve Bell	109985	Fixings Plus	Andy /Louise /Matt	Birmingham	2025-05-20	\N	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1803	excel-import-user	import@system.com	Steve Bell	100758	Express Electrical	\N	Birmingham	2025-05-20	Birm Branch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1804	excel-import-user	import@system.com	Steve Bell	109656	Ritefix	Paul	Birmingham	2025-05-20	Refresh meeting, new staff Becky,  Izzy, Katey (Laura baby, Amy 2 Vanesa retiring, own label and pricing 	Extra discount Heller or TCG	B	300.00	580.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1805	excel-import-user	import@system.com	Steve Bell	100190	DFS Fixings	\N	Leicester	2025-05-21	Offers additional discount - not interested, Starlock / Jisaw pricing	Price schedule 	B	\N	2500.00	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1806	excel-import-user	import@system.com	Steve Bell	150160	ITP 	Andy	Chesterfield	2025-05-21	unavailable	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1807	excel-import-user	import@system.com	Steve Bell	109656	Ritefix	Paul	Huddersfield	2025-05-22	Site Visit, demo trijet, rebar cutter	\N	B	200.00	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1808	excel-import-user	import@system.com	Steve Bell	Prospect	LEWS	Jim	Huddersfield	2025-05-22	Follow up introduction	Pricing meeting	B	\N	\N	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1809	excel-import-user	import@system.com	Mark Smethurst	107828	Brabbin and Rudd Bolton	Ian	Bolton	2025-05-19	Meeting with Ian. Showed offers. 5% on £3000	Follow up next month	B	\N	3000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1810	excel-import-user	import@system.com	Mark Smethurst	100758	Express Electrical Bolton	Nathan, Sunhil	Bolton	2025-05-19	Meeting with Nathan, Sunhil. Showed offers.	Follow up next month	B	520.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1811	excel-import-user	import@system.com	Mark Smethurst	101375	PM Hardware	Mark	Bury	2025-05-19	Showed hss promotion	Follow up in 2 months	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1812	excel-import-user	import@system.com	Mark Smethurst	Prospect	Anthony Axford Timber	No Contact	Bolton	2025-05-19	Cold call buyer based at Farnworth branch.	No further action at branch	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1813	excel-import-user	import@system.com	Mark Smethurst	107828	Brabbin and Rudd Wigan	John	Wigan	2025-05-19	Meeting with John. Showed offers.	Follow up next month	B	350.00	3000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1814	excel-import-user	import@system.com	Mark Smethurst	Prospect	Entwistle Joynt	Buyer	Wigan	2025-05-19	Cold call. Catalogue and Business card.	Follow up Rebar promo	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1815	excel-import-user	import@system.com	Mark Smethurst	100758	Express Electrical Wigan	Karl Fischer	Wigan	2025-05-20	Meeting with Karl. 5% on £3000 order.	Follow up next month	B	3000.00	3000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1817	excel-import-user	import@system.com	Mark Smethurst	100761	Leigh Timber Supplies	Billy	Leigh	2025-05-20	Showed offers. 	Follow up end of month.	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1818	excel-import-user	import@system.com	Mark Smethurst	Prospect	Anthony Axford Timber	Purchasing@	Farnworth	2025-05-20	Catalogue and Business card.	Quote on Prices NMBS	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1819	excel-import-user	import@system.com	Mark Smethurst	Prospect	UK Tools and Accessories	Paul Bates	Bolton	2025-05-20	Catalogue and Business card.	Quote prices	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1820	excel-import-user	import@system.com	Mark Smethurst	Prospect	Longhorn Hardware	Richard based at Carlisle 	Lancaster	2025-05-21	Catalogue. Buyer based in Carlisle.	Need appt at Carlisle	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1821	excel-import-user	import@system.com	Mark Smethurst	Prospect	Gareth Edmondson	Gareth	Carnforth	2025-05-21	Catalogue. Hss promotion.	Follow up next Month	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1822	excel-import-user	import@system.com	Mark Smethurst	Prospect	Lakeland supplies	Barry	Kendal	2025-05-21	Catalogue and Rebar promotion.	Follow up end next month	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1823	excel-import-user	import@system.com	Mark Smethurst	108272	Ace Fixings	Matt	Penrith	2025-05-21	Meeting with Matt. Rebar promotin and Hss.	Quote for Cutting Range	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1824	excel-import-user	import@system.com	Mark Smethurst	Prospect	R and C Supplies	Richard	Hull	2025-05-22	Catalogue and Business card.	Follow up next month	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1825	excel-import-user	import@system.com	Mark Smethurst	100640	T & D Supplies	Gary	Hull	2025-05-22	Met with Gary. Prices and Rebar offer.	Email Discounts and prices	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1826	excel-import-user	import@system.com	Mark Smethurst	107750	Martindales industrial Fasteners	Peter	Preston	2025-05-22	Telephone meeting with peter. Took order.	Follow up next month	B	400.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1827	excel-import-user	import@system.com	Mark Smethurst	Prospect	Chris Seager Tools	Chris  	Beverley	2025-05-22	Catalogue and Business card. Hss promotion.	Email pricing and Discount	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1828	excel-import-user	import@system.com	Cord-Jürgen Bruns	100403	Baucentrum Stewes GmbH & Co. KG	Herr Ruwe	Gladbeck	2025-05-19	Store-Check: Heller im Baumarkt; hat keine Probleme, will bestellen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1829	excel-import-user	import@system.com	Cord-Jürgen Bruns	101031	Baucentrum Stewes GmbH & Co. KG	Herr Bergermann	Gladbeck	2025-05-19	Store-Check: Vergleich im PFM; keine Probleme	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1830	excel-import-user	import@system.com	Cord-Jürgen Bruns	103401	Paul Swertz GmbH	Herr Küsters	Kleve	2025-05-19	Unterlagen aktualisiert; Neuheiten und Aktionen vorgestellt: interessiert	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1831	excel-import-user	import@system.com	Cord-Jürgen Bruns	103251	Paul Swertz GmbH	Herr Wehr	Goch	2025-05-19	Aktionen und Neuheiten vorgestellt: bestellt	erfassen und liefern	A	3200.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1832	excel-import-user	import@system.com	Cord-Jürgen Bruns	103252	Paul Swertz GmbH	Herr Schwartges	Straelen	2025-05-20	Aktionen und Neuheiten vorgestellt: bestellt	erfassen und liefern	B	400.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1833	excel-import-user	import@system.com	Cord-Jürgen Bruns	106817	Mobau Profi Zentrum	Herr Nietsch	Heinsberg	2025-05-20	Aktionen und Neuheiten vorgestellt: bestellt; Kreissägen anbieten	erfassen und liefern	A	1000.00	300.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1834	excel-import-user	import@system.com	Cord-Jürgen Bruns	100026	Kipp & Grünhoff GmbH & Co. KG	Herr Widdermann	Köln	2025-05-20	Aktionen und Neuheiten vorgestellt: will Schleifen bestellen; Macht im Herbst eine Hausmesse: Teilnahme und WKZ 500,-€ zugesagt	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1835	excel-import-user	import@system.com	Cord-Jürgen Bruns	103208	BAUKING Westfalen GmbH	Herr Kowalewski	Wuppertal	2025-05-21	Aktionen und Neuheiten vorgestellt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1836	excel-import-user	import@system.com	Cord-Jürgen Bruns	100932	Nettelbeck GmbH	Herr Kaleyta	Wuppertal	2025-05-21	Aktionen und Neuheiten vorgestellt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1837	excel-import-user	import@system.com	Cord-Jürgen Bruns	100764	Kipp & Grünhoff GmbH & Co. KG	Herr Schmidt	Monheim	2025-05-21	Unterlagen aktualisiert; ist ein neuer Mitarbeiter: Schulung durchgeführt; will bestellen	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1838	excel-import-user	import@system.com	Cord-Jürgen Bruns	103373	BAUKING Westfalen GmbH	Herr Hühnl	Recklinghausen	2025-05-21	hat den Baustein "s" bestellt; Hausmesse bei Eröffnung: Teilnahme zugesagt; 5% für einen Auftrag nach der Eröffnung als WKZ	vorbereiten und liefern; aufbauen	B	\N	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1839	excel-import-user	import@system.com	Cord-Jürgen Bruns	109749	BAUKING Weser-Ems GmbH	Herr Auerbach	Natrup-Hagen	2025-05-21	hat Sägen und Bits bestellt; will Regalteile für 3m Wand und dann vorhandene Ware integrieren; anschl. soll das Regal aufgefüllt werden…	vorbereiten und liefern; aufbauen	B	1650.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1840	excel-import-user	import@system.com	Cord-Jürgen Bruns	105915	Heinrich Rießelmann	Herr Lammers	Damme	2025-05-22	Präsentation aufgebaut; Regalteile und Ware fehlt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1841	excel-import-user	import@system.com	Cord-Jürgen Bruns	105915	Heinrich Rießelmann	Herr Lammers	Damme	2025-05-22	Nacharbeiten: Präsentation abgeschlossen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1842	excel-import-user	import@system.com	Andreas Stockbauer	101347	BU Nürnberg Hafen	Hr. Götz	Nürnberg Hafen	2025-05-19	Anrufen wegen Erweiterung, Termin am 26.05.25	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1843	excel-import-user	import@system.com	Andreas Stockbauer	102053	Wassermann & Co GmbH	Hr. Klapfer	Memmingen	2025-05-19	Warenrücknahme nach Sortimentsbereinigung, Sortimentsbereinigung wird vorerst selber abverkauft	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1844	excel-import-user	import@system.com	Andreas Stockbauer	102618	Theodor Wölpert GmbH & Co.KG	Hr. Harfmann	Ertingen	2025-05-19	Hr. Harfmann hat Termin telefonsich abgesagt wegen Krankheit	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1845	excel-import-user	import@system.com	Andreas Stockbauer	100918	Kleinlein Bauzentrum GmbH	Hr. Reisacher	Waltenhofen	2025-05-19	Aktuelle Aktionen und Sortimensterweiterungen vorgestellt. Führt weiterhin Projahn. Nächster Termin mit Hr. Kleinlein Jun. Abstimmen.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1846	excel-import-user	import@system.com	Andreas Stockbauer	103001	Danhauser GmbH & Co KG	Hr. Glas	Weiden	2025-05-20	Termin Sortimentserweiterung 11.00h, Vorschalg wird noch intern besprochen, Einrichtungstermin am 24.07.25	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1847	excel-import-user	import@system.com	Andreas Stockbauer	109635	Meier Baustoffe GmbH	Hr. Schmeissner/ Hr. Beer	Weiden	2025-05-20	Termin Sortimentserweiterung 13.30h, Sortimentserweiterung genehmigt, Liefertermin zum 02.06.25	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1881	excel-import-user	import@system.com	Gunter Diedrich	108218	GRUPO-15	Don Antonio	DON BENITO	2025-05-21	Implantation Sägeblätter-2m	\N	B	2500.00	0.00	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1848	excel-import-user	import@system.com	Andreas Stockbauer	108413	Peter Kasberger Baustoff GmbH	Hr. Hartl	Passau	2025-05-22	Warenrücknahme Sortimentsbereinigung? Warenrücknahme erstellt und an Innendienst weitergeleitet zur Anlage Callnr. Ware wird von Kasberger zurückgesendet.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1849	excel-import-user	import@system.com	Andreas Stockbauer	100452	Auer Landshut	Hr. Schneidenbach	Landshut	2025-05-22	Aktuelle Aktion, neue Meissel besprochen, Hr. Schneidenbach bespricht es innerhalb des Teams, Spachtelmeissel interessant. Aktionen nach wie vor nicht gewünscht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1850	excel-import-user	import@system.com	Andreas Stockbauer	102148	Auer Baustoffe GmbH & Co. KG	Hr. Moser	Dorfen	2025-05-22	Aktuelle Aktion, neue Meissel besprochen, Spachtelmeissel interessant. Aktionen nach wie vor nicht gewünscht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1851	excel-import-user	import@system.com	Andreas Stockbauer	105516	Suckfüll Handels GmbH	Hr. Öztürk	München	2025-05-22	Nicht erreicht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1852	excel-import-user	import@system.com	Nikolaj Ljabach	108136	AER	Janis Ivanovs	E-Mail	2025-05-20	Abstimmung Tenderauftrag / Neuer regulärer Auftrag zu Standardkonditionen	Ausliefern	A	34000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1853	excel-import-user	import@system.com	Nikolaj Ljabach	150211	Novomet	Frau Boeva	E-Mail	2025-05-20	Auftragserteilung / Zahlung der Overdues	Ausliefern	A	11000.00	\N	45809	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1854	excel-import-user	import@system.com	Nikolaj Ljabach	150055	Cominvest	Tomas Viktora	E-Mail	2025-05-22	Auftrag über 13 K Euro mit 10% & +30 tagen.\nAuslieferquote bei 60%	Klärung der Lieferquote und der termine	A	13000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1855	excel-import-user	import@system.com	Nikolaj Ljabach	151260	MIG Baltic	Aigars Baumanis	E-Mail	2025-05-20	Anmahnung Zahlung / Kleiner Auftrag	Ausliefern	A	5000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1856	excel-import-user	import@system.com	Nikolaj Ljabach	101054	MK Trade	Donna Turturova	E-Mail/Whatsapp	2025-05-21	Abstimmung Auftrag	Klärung der Lieferquote und der termine	A	12000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1857	excel-import-user	import@system.com	Nikolaj Ljabach	109210	ITT Bulgarien	Boyan Jelev	E-Mail	2025-05-20	Abstimmung Auftrag	Ausliefern	A	168000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1858	excel-import-user	import@system.com	Nikolaj Ljabach	101371	Kardesler	Hr. Klimenko	E-Mail/Whatsapp	2025-05-22	Abstimmung geldeingang / Abstimmung Exportpapiere	Warten auf die Zahlung / Auslieferung	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1859	excel-import-user	import@system.com	Nikolaj Ljabach	100499	Vosmerik	Hr. Bugdanowskij	E-Mail/Whatsapp	2025-05-22	Abstimmung China-Lieferung\nMenge zur Auslieferung ca 10.000 Euro / Rechnung gestellt	Warten auf Geldüberweisung und Auslieferung	A	10000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1860	excel-import-user	import@system.com	Nikolaj Ljabach	150148	IMEXA	Dejan Bokalic	E-Mail/Whatsapp	2025-05-22	Vorbereitung eines Auftrages / Abstimmung Konditionen / targetpreise SDS Max und Vierschneider	Abstimmung des Rabattes mit GL / Weitere abstimmung mit dem Kunden	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1861	excel-import-user	import@system.com	Nikolaj Ljabach	100530	Senukai	Ernestas Viržaitis	E-Mail	2025-05-21	Hello, \nSorry no, we will be attending Stanley Black and Decker fair in Praha. 	Abstimmung mit dem Ex-MA von Senukai wegen der Preissenkungsforderung	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1862	excel-import-user	import@system.com	Nikolaj Ljabach	150095	Diktum	Violeta Gaubienė <violeta@diktum.lt>	E-Mail	2025-05-21	We look forward to seeing you at our new office on May 29th at Julijanavos g.2A, Kaunas :)	Besuch KW 22	B	\N	\N	45806	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1863	excel-import-user	import@system.com	Nikolaj Ljabach	150060	Drugstraitis	Kęstutis Akelis	E-Mail	2025-05-21	Hello Nikolaj,\nof course we can meet. Just let me know Your approximately time of arrival day before.	Besuch KW 22	B	\N	\N	45806	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1864	excel-import-user	import@system.com	Nikolaj Ljabach	150006	Anjese	\N	E-Mail	2025-05-21	\N	Besuch KW 22	C	\N	\N	45806	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1865	excel-import-user	import@system.com	Nikolaj Ljabach	103146	Glomera	Arvydas Novikovas	E-Mail	2025-05-21	So our best bet would meet up there. Although we will be on a tight schedule, so let’s keep in touch and hopefully we'll find a chance to see each other there.	Besuch KW 22	A	\N	\N	45806	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1866	excel-import-user	import@system.com	Nikolaj Ljabach	151410	Technosta	Giedrius Stikliunas	E-Mail	2025-05-21	Miochten Sie Kurz informieren, das Nachste Woche Ich bin in Urlaub und bin nicht in Biuro und in Kaunas.\nAndrius hat sehr viel Arbait und wird sehr besetzt – hat sehr Viel zu Tun – und Leider hat Kain Zeit zum treffen.	Besuch KW 23	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1867	excel-import-user	import@system.com	Egon Jesse	106463	Voskamp	\N	Rotterdam	2025-05-20	Besuch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1868	excel-import-user	import@system.com	Egon Jesse	103232	Isero	\N	Rotterdam	2025-05-20	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1869	excel-import-user	import@system.com	Egon Jesse	109756	Bouwhof	\N	Zoetermeer	2025-05-20	Besprochen Umtausch von De Walt/Bosch auf komplett und nur Heller. Ruckwaren und saubermachen von assorti.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1870	excel-import-user	import@system.com	Egon Jesse	100029	Boerenhandel	\N	Boechout	2025-05-21	Besuch/Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1871	excel-import-user	import@system.com	Egon Jesse	109353	Marco	\N	Herselt	2025-05-21	Besuch/Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1872	excel-import-user	import@system.com	Egon Jesse	151820	Kerkstoel	\N	Heist od Berg	2025-05-21	Besprechen Angebot umbau Nochmals besprochen. Brauchen noch etwas zeit	\N	B	3500.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1873	excel-import-user	import@system.com	Egon Jesse	100645	Cop	\N	Boom	2025-05-21	Besuch/Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1874	excel-import-user	import@system.com	Egon Jesse	109188	Iliaens	\N	Alken	2025-05-22	Besuch beprechen neue Presentation und Ausbau Assortiment	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1875	excel-import-user	import@system.com	Egon Jesse	109472	Heinen	\N	Bütchenbach	2025-05-23	Besuch/Etiketten	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1876	excel-import-user	import@system.com	Egon Jesse	109259	Collas	\N	Büllingen	2025-05-23	Besuch/Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1877	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE	Rafael	Madrid	2025-05-19	Media-Center Messe-Rückwände HELLER von SUALPE	\N	A	0.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1878	excel-import-user	import@system.com	Gunter Diedrich	108218	SUMISTRAL	Joaquín	TOLEDO	2025-05-20	Instaladores	\N	B	0.00	400.00	6	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1879	excel-import-user	import@system.com	Gunter Diedrich	108218	SITASA	Antonio	TOLEDO	2025-05-20	SET-Range+2618+Sägeblätterrange	\N	B	0.00	1000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1880	excel-import-user	import@system.com	Gunter Diedrich	108218	SUINCE	Pepe	TOLEDO	2025-05-20	Kaum Interesse aber doch an Bundbohrern SDS-plus	\N	B	0.00	0.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1882	excel-import-user	import@system.com	Gunter Diedrich	108218	RUIZ	Manolo	P29-Villalba	2025-05-21	Muster-31055-0  (sehr langsam Palette)	\N	B	0.00	0.00	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1883	excel-import-user	import@system.com	Gunter Diedrich	108218	HIPERMADERA	Junajo	Talavera de la Reina	2025-05-22	Kreissägeblätter, 394+790	\N	B	0.00	500.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1884	excel-import-user	import@system.com	Gunter Diedrich	108218	Ferr DURAN	Pedro y Rafa	Talavera de la Reina	2025-05-22	BIT, 2618+2625, Sägeblätter-Implantation	\N	B	0.00	3000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1885	excel-import-user	import@system.com	Gunter Diedrich	108218	BigMAT Rámos	Srta.Felipa	Talavera de la Reina	2025-05-22	Baustoff, Lange SDS-plus 2018+2725+2925+1118+1125	\N	B	0.00	400.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1886	excel-import-user	import@system.com	Gunter Diedrich	108218	Maquinaria MALTA	Enrique	Talavera de la Reina	2025-05-22	Range, Vorteile, zeigt wenig/kein Interesse	\N	C	0.00	0.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1887	excel-import-user	import@system.com	Gunter Diedrich	108218	Sum.Ind.POLARSTOCK	Don José	Talavera de la Reina	2025-05-22	HSS+HSS/Co+924/925+906 nur SET	\N	B	0.00	400.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1888	excel-import-user	import@system.com	Gunter Diedrich	108218	Aluminios JJ	José Juán	Talavera de la Reina	2025-05-22	Fertigung und VK Aluminium und Teilefertigung-906-990	\N	B	0.00	0.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1889	excel-import-user	import@system.com	Frank Papperitz	101021	Schrauben-Schmid	Jens Wehrmeister	Dresden	2025-05-20	Bosch voll drin, aber auch Milwaukee macht sich breit, HSS und Bits in Hausmarke, Lage für Heller schwierig, weil Kirchheim entscheidet	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1890	excel-import-user	import@system.com	Frank Papperitz	109643	HEKA	Janos Hatvani	Crimmitschau	2025-05-21	Ware für seine Juni-Aktion ist rechtzeitig gekommen, Kuh erstmal vom Eis.	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1891	excel-import-user	import@system.com	Frank Papperitz	109548	Prinz	Herr Becker	Haselbachtal	2025-05-22	Bohrerabsatz nur noch gering, da weniger Bautätigkeit ihrer Kunden. Führt nur Heller- Bohrer	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1892	excel-import-user	import@system.com	Frank Papperitz	108379	HBT	Herr Wagner	Pirna	2025-05-22	Hat 1 m Heller-Wand, aber vorwiegend Eigenbedarf. Pläne für Weiterverkauf haben sich kaum verwirklicht.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1893	excel-import-user	import@system.com	Frank Papperitz	106681	Handelshof Bautzen, NL K.	Sandy Kokel	Kamenz	2025-05-22	Heller auf 4 m präsentiert, aber kaum Bestand, weil Einkauf stark limitiert. Schließung dieser Filiale in Gespräch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1894	excel-import-user	import@system.com	Frank Papperitz	105695	H+K	Frau Hauffe	Kamenz	2025-05-22	Heller- Wand top, aber auch Zubehör von Bosch und Makita sowie Müllner-Ware. Habe 2 neue Meissel vorgestellt, wollen aufnehmen.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1895	excel-import-user	import@system.com	Stephan Heinitz	101746	Eisen-Butsch	Hr. Patzelt	Weinheim	2025-05-19	Dispobesuch	Aktion nachhaken	B	852.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1896	excel-import-user	import@system.com	Stephan Heinitz	100436	Schäfer Bauzentrum I&M	Hr. Fritzinger	Wartenberg-Rohrbach	2025-05-19	Erweiterungs-Gespräch Starlock-Trennen-Schleifen	Angebot Starlock-Tower und ausgesuchte Artikel aus Trennen und Schleifen, Angebot muss dann an Rückware angepasst bzw. korrigiert werden	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1897	excel-import-user	import@system.com	Stephan Heinitz	109944	Achenbach und Gauer	R. Tenz	Rockenhausen	2025-05-19	Neuen Katalog/VK Unterlagen mitgebracht, Neuheiten und Aktionen vorgestellt 	\N	B	\N	\N	26	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1898	excel-import-user	import@system.com	Stephan Heinitz	109388	Union BZ Hornbach	Hr. Feldbauer	Baumholder	2025-05-19	Erweiterung Schleifen angesprochen - Dispo - Aktion vorgestellt 	sobald der Kunde mir den Bestand der Fremdware Schleifen durchgegeben hat, erfolgt Angebot mit doppeltem AW zwecks Umstellung	A	794.00	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1899	excel-import-user	import@system.com	Stephan Heinitz	100023	Ruhland Kallenborn	A. Fuchs	Ensdorf	2025-01-01	Wegen Hausmesse 23.05. gesprochen, Aufbau, Organisation usw. Hausmessen Auftrag angeboten, Aktion angesprochen 	Teilnahme Hausmesse 24.05.	B	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1900	excel-import-user	import@system.com	Stephan Heinitz	102562	Bricowelt	Hr. Betzen	Oberpallen	2025-05-20	Regelbesuch, Aktion vorgestellt und einige Artikel verkauft, Neuheiten angesprochen, Bestellung läuft, wurde durch Besuch noch kurzfristig erhöht	\N	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1901	excel-import-user	import@system.com	Stephan Heinitz	1003321	Breger	Alphonse Commodi	Gasperich	2025-05-20	Kein Bedarf im Moment	Aktion zumailen	B	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1902	excel-import-user	import@system.com	Stephan Heinitz	1003324	Comat	Fabio Neves	Howald	2025-05-20	Regelbesuch, Kunde bestellt f.g. selbst, keine Reklamationen oder ähnliches - alles in Ordnung	\N	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1903	excel-import-user	import@system.com	Stephan Heinitz	109653	Union Bauzentrum Hornbach	Hr. Schmidt	Merzig	2025-05-20	Aktion vorgestellt, Bodenfläche 	\N	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1904	excel-import-user	import@system.com	Stephan Heinitz	108622	Schilke	Hr. Schilke	Heusweiler	2025-05-21	Aktion angesprochen und verkauft; Auftrag nach Moduldurchsicht	\N	B	721.00	\N	8	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1905	excel-import-user	import@system.com	Stephan Heinitz	108209	R. Röhlinger	Hr. Sielemann	Schiffweiler	2025-05-21	Aktion angesprochen, Auftrag nach Moduldurchsicht, Dach- und NDL-Abteilung gesprochen	\N	A	1030.00	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1906	excel-import-user	import@system.com	Stephan Heinitz	108209	R. Röhlinger	Hr. Ebert	Neunkirchen	2025-05-21	AP nicht im Haus, Aktionsunterlagen dagelassen, 	\N	A	\N	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1907	excel-import-user	import@system.com	Stephan Heinitz	107968	Union BZ Hornbach	Hr. Tretter 	Münchweiler	2025-05-21	Besuch wg. Online-Sortiment und der Präsentation - Kunde bekommt Tower-Display, Bestellung sollte in den kommenden Tagen eintreffen, da Hornbach sich mit den Mengen noch nicht ganz klar ist	Tower-Display zur Präsentation reservieren sobald Kunde den Erstauftrag schickt	A	\N	\N	6	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1908	excel-import-user	import@system.com	Stephan Heinitz	100213	Pinsel-Wurm	Hr. Steil	Mutterstadt	2025-05-19	Aktion vorgestellt - Spachtelmeißel sind interessant, Kunde kauft aktuell keine Standard-Meißel mehr, da Makita Flach und Spitzmeißel mit 3,25 € anbietet.	Preise an GH weitergegeben	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1909	excel-import-user	import@system.com	Stephan Heinitz	108854	Union BZ Hornbach	Hr.Dausch	Hauenstein	2025-05-22	Modulumbau, Integration 4PowerPro, Sortimentsbereinigung und Wand auf neuesten Stand bringen - danach Gespräche über deutliche Erweiterung: Stichsägen, Säbelsägen, Schleifen, evtl. Trennen	warten auf Bestandsangabe vom Kunden, dann maßgeschneidertes Angebot bzgl. Umstellung	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1910	excel-import-user	import@system.com	Stephan Heinitz	109015	Heinitz Stephan	\N	Kleinheubach	2025-05-23	Homeoffice - Vorbereitung Hausmesse Ruhland-Kallenborn und Anreise nach Ensdorf	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1911	excel-import-user	import@system.com	Stephan Heinitz	100023	Ruhland-Kallenborn	Hr. Fuchs	Ensdorf	2025-05-24	Hausmesse 07-18 Uhr, anschl. Heimreise	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1912	excel-import-user	import@system.com	Jens Werner	150336	Van Roij Fasteners Europe B.V	Richard Munsters	\N	2025-05-26	 Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Nachhaken	A	52000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1913	excel-import-user	import@system.com	Jens Werner	100719	A.S.F. Fischer BV	Dominic Bravenboer	\N	2025-05-26	Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Nachhaken	B	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1914	excel-import-user	import@system.com	Jens Werner	106340	Hagebau Butler	Andreas Pellny	\N	2025-05-27	Ausbau Butler	Gespräche mit Sortiko über Sortimentserweiterung	A	\N	150000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1915	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE	Rafael	Madrid	2025-05-26	Strategiebesuch AV	Angebot 1418&2618&Meissel	A	0.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1916	excel-import-user	import@system.com	Gunter Diedrich	108218	CÁMARA Burgos	Rafa	Burgos	2025-05-26	Neubaubesichtigung 6.000 qm	Mérida-Niederlassung	B	0.00	0.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1917	excel-import-user	import@system.com	Gunter Diedrich	108218	TPF Burgos	Francisco	Burgos	2025-05-26	8m Lineal Modulwände besichtigt	Sägenmodule auffüllen	A	0.00	0.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1918	excel-import-user	import@system.com	Gunter Diedrich	150213	NOVATOOLS	José	San Sebastian	2026-05-27	AllMAT-neu & XproPreisvergleich Angebot -10%PlanAuftrag	XPRO-Preisangebot	A	0.00	30000.00	8	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1919	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE	Joaquin	Madrid	2025-05-28	Konsilagerabrechnungen 05'2025	\N	A	20000.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1920	excel-import-user	import@system.com	\N	108218	SUALPE/ALQUIMO	Juan Antonio	Talavera de la Reina	2025-05-28	Vermieter, Demo-Absaugbohrer-1818 in unterschiedlichen B	\N	B	400.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1921	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE/Ferr DURAN	Rafa	Talavera de la Reina	2025-05-28	Extralange SDS-plus&FlexiDemo	Preis anbieten	B	0.00	600.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1922	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE/CÁMARA-Mérida	Don Antonio	Mérida	2025-05-29	Angebot Implantation 4m Module (wie Zentrale) Range	Angebot erstellen	B	0.00	3600.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1923	excel-import-user	import@system.com	Egon Jesse	100231	BMN	\N	Harderwijk	2025-05-26	Besuch reklamation	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1924	excel-import-user	import@system.com	Egon Jesse	151547	Chemtechniek	\N	Veenendaal	2025-05-26	Besuch ausbau zu PL/Heller.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1925	excel-import-user	import@system.com	Egon Jesse	101497	Voskamp	\N	Almelo	2025-05-28	Abgesagt Neue termin 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1926	excel-import-user	import@system.com	Egon Jesse	105797	Otttenhof	\N	Oldenzaal	2025-05-28	Besuch/Auftrag gemacht	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1927	excel-import-user	import@system.com	Egon Jesse	100414	Sleiderink	\N	Oldenzaal	2025-05-28	Besuch Vorschlag Slneiden und schleifen  machen	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1928	excel-import-user	import@system.com	Egon Jesse	100472	Sleiderink	\N	Denekamp	2025-05-28	Besuch	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1929	excel-import-user	import@system.com	Nikolaj Ljabach	150148	IMEXA	Dejan	E-Mail	2025-05-26	Sonderangebot	Nachhaken KW 23	A	\N	150000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1930	excel-import-user	import@system.com	Nikolaj Ljabach	106307	Teronis	Asta / Dmitrij	Vilnius	2025-05-30	Neuausrichtung des Geschäftes	Siehe separate E-Mail	B	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1931	excel-import-user	import@system.com	Nikolaj Ljabach	150095	Diktum	Violeta Gaubienė <violeta@diktum.lt>	Kaunas	2025-05-29	Mehrere operative und strategische Angelegenheiten. Siehe separate Mail	Nachlieferung Verpackung Konusverlängerung\nÜbrprüfung HSS Preise	B	\N	15000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1932	excel-import-user	import@system.com	Nikolaj Ljabach	150060	Drugstraitis	Kęstutis Akelis	Kaunas	2025-05-29	Aktuelle Lieferungen\nAngebot PL für Trijet	Angebot Trijet als Private Label\nAngebot Konusbohrer	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1933	excel-import-user	import@system.com	Nikolaj Ljabach	150006	Anjese	Aurimas Mistautas / Vilius Cerniaskas	Kaunas	2025-05-29	Kenenlernen des neuen EK-Teams	Versand Kataloge und POS beim nächsten Auftarg	C	\N	5000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1934	excel-import-user	import@system.com	Nikolaj Ljabach	103146	Glomera	Arvydas Novikovas	Vilnius	2025-05-26	Persönliches Treffen am Rande der LIGNA\nAngebot Bier-Promo\nWettbewerbsangebote von AER Latvia	Schreiben an AER\nBierPromo (bereits erledigt)	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1935	excel-import-user	import@system.com	Martin, Palme	100501	CSH SIN	Eric	Mail, Messenger	2025-05-28	26.05.2025 Anfrage Trijet Ultimate 16 x 1200 x 1340 mm, nicht lieferbar bis Ende Juli. Eigenfertigung 8 Wochen Lieferzeit, somit werde ich den Auftrag nicht bekommen.\nRechnungen wurden bereits angemahnt aber die Lieferung ist noch nicht angekommen, Termin war 6. Mai, alle Lieferungen nochmals koordiniert.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1936	excel-import-user	import@system.com	Martin, Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-05-30	Offizielle Bestellung erhalten.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1937	excel-import-user	import@system.com	Martin, Palme	103214	ZI-TECH TH	Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-05-30	Anmahnungen Lieferungen, Rueckstaende pruefen usw.. AB 8.1K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Anfang Juli Angebot fuer 10 % fuer 15K EUR Bestellwert als Juli Promotion	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1938	excel-import-user	import@system.com	Martin, Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-05-30	Interesse weiterhin fuer den Tapcon Bohrer, Kunde moechte nun Muster haben, an AD weitergeleitet, um zu pruefen, ob wir diese in Dinklage machen koennen. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1939	excel-import-user	import@system.com	Martin, Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-05-30	Pushe fuer eine neue Bestellung, da 15K EUR bisher zu hoch sind, probiere hier um zumindest eine zu bekommen. Angebot fuer Projekt noch nicht vom Endkunden entschieden.	Naechste Woche nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1940	excel-import-user	import@system.com	Martin, Palme	105577	Mach Tools PH	Nancy Yu & Karlo Yu	Tel., Mail, Messenger	2025-05-29	Verschiffung Lieferung. 45K EUR im Maerz bestellt, teilweise ausgeliefert. AB 24.4K EUR wurden berechnet.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1962	excel-import-user	import@system.com	Mark Smethurst	108435	Engineering Agencies	Muir	Dumfirmline	2025-05-28	Hss Promotion, Rebar Cutter Promotion.	Email offers, call 4 weeks.	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1941	excel-import-user	import@system.com	Martin, Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-05-29	Die Mai Pruefung ergab, dass sie so langsam den Keil Brand (10K EUR sind auf dem Schiff und die Lieferung wird Mitte/Ende Juni erwartet) auslaufen lassen, um dann gleich eine groessere Bestellung fuer den Heller Brand zu machen, wo wir dann evtl. durch einen Erstausstattungsrabatt einen groesseren Wert erzielen koennten. Werden aber zwischendurch bereits Heller bestellen, um einen Soft Launch zum Heller Brand zu machen zu machen. Verpackungsfrage offen, wird noch diskutiert, ob Klipp oder Tasche, die dann auch nachhaltig sein soll, da dies in NZ sehr gross geschrieben wird. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist vom Kunden angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1942	excel-import-user	import@system.com	Martin, Palme	150279	Trucut NZ	Rod	Mail	2025-05-29	10K EUR einen Rabatt von 5 % angeboten. Preislich sind wir nicht wettbewerbsfaehig, da Bosch (Clean Plus-8X) einen gerningeren Preis hat. Habe hier nach dem jaeglichen Verbrauch angefragt, von dort koennen wir dann eine neue Kalkulation machen.	Solbald ich den jaehlichen Verbrauch habe, dann werden wir eine Kalkulation machen und ich klaere dies dann mit AV	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1943	excel-import-user	import@system.com	Martin, Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-05-29	Laengeres Gespraech mit Francesco, wollen weiterhin mit uns arbeiten, sie machen gerade Stock Clearance. Habe ihn unterrichtet, dass wir uns um einen 2. Distributor ausschau halten. Wenn es hier zu einer Entscheidung fuer einen direkten Konkurrenten kommt, wie z.B. Synergy Construction (auch Kunde von Iccons), dann kann die Zusammenarbeit etwas abkuehlen aber bei Amor oder PlumBoss gibt es keine direkten Ueberschneidungen. Anfrage bezueglich China Bohrer, Preisliste nochmals gesendet. Projekt fuer 10 mm Duster, Target Preis 11.53 EUR abgelehnt, ist nicht machmar fuer unsere Marge. Noch keine Entscheidung AB 0.1K EUR	Naechste Gespraeche naechste Woche	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1944	excel-import-user	import@system.com	Martin, Palme	151242	Majjatra INDO	Gunawan, Lili	Mail	2025-05-29	Fragt an, wann die Muster fuer die China Bohrer versendet werden. Kunde will in weitere Regionen auf Java zu expandieren. Im Moment ist das Geschaeft ruecklaeufig, wird erst wieder im Juli ca. 5K EUR betsellen.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1945	excel-import-user	import@system.com	Martin, Palme	150039	Bordo AUS	Jerry, Yvonne	Mail	2025-05-29	Nachfrage wegen 10 % / 15K EUR Bestellwert. Es wird keine Bestellung kommen, da noch Lagerbestand vorhanden und der Kunde geht mehr auf chinesische Produkte. Hier muessen wir abwarten, ob der Kunde weiterhin bei uns bestellen wird, wegen der CN Bohrer, die er dann direkt vom CN Lieferanten beziehen wird.	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1946	excel-import-user	import@system.com	Martin, Palme	100998	RFM MAL	Khiam, Raymond	Mail	2025-05-26	Nachfrage wegen 10 % / 15K EUR Bestellwert, wird keine Bestellung kommen, der Bestellwert zu hoch und der Kunde hat noch Lagerbestand. Warten auf die Muster der China Produkte	Besuch einplanen nach meinem Urlaub	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1947	excel-import-user	import@system.com	Martin, Palme	150348	Wakai JP	Iwawaki, Nene	Mail	2025-05-27	Angebot gesendet. Endkunde hat weiterhin noch nicht entschieden, am 27.05.2025 nachgefragt, ob der Endkunde bereits entschieden hat. AB 12.8K EUR	Naechste Woche wieder nachhaken, wenn keine Bestellung kommt	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1948	excel-import-user	import@system.com	Martin, Palme	109842	Hept SK	Hr. Bong	Mail	2025-05-27	Wir habe im Moment Zahlungsrueckstaende von ca. 53K EUR, und lt. Kunden will er diese bis Mitte des Jahres bezahlen, auch mit Teilzahlungen bis Ende Juni alles ueber die Buehne sein muesste. Ich habe gesagt, dass dies die letzte Chance sein wuerde, bevor wir dann die naechsten Schritte fuer einen neuen Distributor starten werden. Der PL Kunde Cretec macht ihm natuerlich auch das Leben schwer, da er mit heftigen Promotions in den Markt geht. AB 13.8K EUR	Mail bezueglich der Zahlungsrueckstaende gesendet, dass wir einen Zahlungsplan benoetigen, ansonsten muessen wir andere Schritte einleiten.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1949	excel-import-user	import@system.com	Martin, Palme	150041	BoRyung SK	Cavin	Mail	2025-05-26	Kunde resigniert, Markt preislich zu umkaempft.	Denke der Kunde wird bei uns nicht mehr kaufen werden in Zukunft	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1950	excel-import-user	import@system.com	Martin, Palme	151317	Steel & Tube NZ	Aries	Mail	2025-05-26	Nachfrage wegen 10 % / 15K EUR Bestellwert, Kunden wird nicht bestellen, Markt ist im Moment sehr ruhig, Bestellung wahrscheinlich erst 2. Jahreshaelfte	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1951	excel-import-user	import@system.com	Martin, Palme	150267	UnionDay HK	Jason	Mail	2025-05-26	Nachfrage wegen 10 % / 15K EUR Bestellwert, werden nicht jetzt bestellen.	evtl. In Kuerze Besuch planen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1952	excel-import-user	import@system.com	Martin, Palme	100714	Sing Kee HK	Ric	Mail	2025-05-26	Kunde war bis 22.05.2025 im Urlaub. 23.05.2025 nachgefragt. Kunde wird nicht bestellen, da noch Lagerbestand. Der Kunde bestellt nur einmal im Jahr und wird bei einer naechsten Promotion im Juli/August bestellen.	Neue Promotion 10% fuer eine Bestellung im Juli anbieten	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1953	excel-import-user	import@system.com	Martin, Palme	151141	Powerpac NZ	Jay, Patrick	Mail	2025-05-26	Nachfrage wegen 10 % / 15K EUR Bestellwert. 15K EUR sind zu hoch. Keine Bestellung in Kuerze, da noch Lagerbestand. 	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1954	excel-import-user	import@system.com	Mark Smethurst	HA77:M82oliday	Bank Holiday	\N	\N	2025-05-26	Spring Bank Holiday UK	\N	B	\N	\N	\N	f	f	VACATION	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1955	excel-import-user	import@system.com	Mark Smethurst	100888	Aerotech Abrasives	Nathan	Wetherby	2025-05-27	Hss Promotion, Rebar Cutter Promotion.	Follow up 4 weeks	A	350.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1956	excel-import-user	import@system.com	Mark Smethurst	Prospect	Barry Carter Supplies	Andy	Harrogate	2025-05-27	Showed catalogue and offers.Showed samples. . 	Quote Prices	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1957	excel-import-user	import@system.com	Mark Smethurst	108573	Powerpoint Northern	Allan	Thirsk	2025-05-27	Showed offers. Checked on tool bars, wrote out stock order for June.	Follow up 4 weeks	A	1300.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1958	excel-import-user	import@system.com	Mark Smethurst	107758	Harlequin Fixings	 	Kilmarnock	2025-05-27	Showed Rebar Cutter Promotion and Hss Promotion. Flat bit Pricing.	Quote Prices	C	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1959	excel-import-user	import@system.com	Mark Smethurst	Prospect	Craighead Building Supplies	(Ian)	Glasgow	2025-05-27	Showed Rebar Cutter Promotion and Hss Promotion.	Follow up. Quote prices.	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1960	excel-import-user	import@system.com	Mark Smethurst	108827	M.E.F.	Paul	Edinburgh	2025-05-28	5% extra on £3000 order. Rebar promotion. Hss promotion.	follow up 8 weeks	A	\N	3000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1961	excel-import-user	import@system.com	Mark Smethurst	108799	Premier Services	Stuart	Edinburgh	2025-05-28	5% extra on £3000 order. Rebar promotion. Hss promotion.	Email offers	B	600.00	3000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1963	excel-import-user	import@system.com	Mark Smethurst	109321	Diatech	Alex	Perth	2025-05-28	Rebar cutter Promotion. New catalogue and Price list.	Email offers to CID	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1964	excel-import-user	import@system.com	Mark Smethurst	Prospect	Hiighland Industrial supplies	Ian Young	Perth	2025-05-28	Cold call. Showed catalogue and price list. Rebar promotion.	Contact Head office	A	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1965	excel-import-user	import@system.com	Mark Smethurst	Prospect	Tektum supplies	Scott	Glasgow	2025-05-29	Cold call. Showed catalogue and price list. Rebar promotion.	Follow up, email offers.	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1966	excel-import-user	import@system.com	Mark Smethurst	Prospect	Cambell Miller	Purchasing	Glasgow	2025-05-29	Cold call. Showed catalogue and price list. 	Email catalogue and prices	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1967	excel-import-user	import@system.com	Mark Smethurst	101564	LSK Building Supplies	Daryl and James	Glasgow	2025-05-29	Catalogue, Price list. 5% on £2500 order, 10% on £5000 order.	Follow up next month	B	\N	2500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1968	excel-import-user	import@system.com	Mark Smethurst	Prospect	Mcdermid Supplies	Calum	Dumfries	2025-05-29	Cold call. Hss promotion, Rebar promotion.	Quote Prices	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1969	excel-import-user	import@system.com	Mark Smethurst	Prospect	City Tools	Lesley	Carlisle	2025-05-29	Rebar cutter Promotion. 	Quote Prices email offers	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1970	excel-import-user	import@system.com	Paulo Santos	108750	A C Fixings Ltd.	Sean 	Chelmsford	2025-05-28	Problem with the last order items missing, Plan this year so far, offer promotion RB	Follow up next week Phone call	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1971	excel-import-user	import@system.com	Paulo Santos	109149	Millcot Tools	Tim	Danbury	2025-05-28	Offer promo Rebar breaker, Using SDS Alpen at the moment, Trying to revert to Heller	Keep sending inofrmation	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1972	excel-import-user	import@system.com	Paulo Santos	100342	Total Diamond Products	Kim/John	Basildon	2025-05-28	Offer Rebar Promo, actual turnover	Follow Up to support	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1973	excel-import-user	import@system.com	Paulo Santos	109743	Suffolk Fasteners UK	Emma	Ipswich	2025-05-28	Quote for a stock order, Rebar Promotion	Follow up order 	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1974	excel-import-user	import@system.com	Paulo Santos	101356	VC Materials Limited	Caetano	London	2025-05-28	Meet Phone and email, Quote, discuss, Order 	Place order Wednesday Morning	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1975	excel-import-user	import@system.com	Paulo Santos	108431	Multifix Supply Company Ltd.	Warrick Reevs	Boxley	2025-05-29	Meeting, clarify range of SDS, agreed trial order, TCG for 2026	Follow up next week	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1976	excel-import-user	import@system.com	Paulo Santos	109758	Technical Fixings Solutions LTD	Stuart Wells	Maidstone	2025-05-29	Meet Stuart, New catalogues, prices for Rec. Saw Blades (buying £4.5)	Report, Follow up about SDS range	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1977	excel-import-user	import@system.com	Paulo Santos	109480	Diamond Direct Supplies	Mac Han	Grays	2025-05-29	Courtesy Visit, Great turnover so far double the plan for 2025	Visit to other end user planned	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1978	excel-import-user	import@system.com	Paulo Santos	109567	Thurrock Engineering Supplies LTD	Luke	Dartford	2025-05-29	Lapsed account, visit to leave new catalogue	Prepare Price List in Excel	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1979	excel-import-user	import@system.com	Guido Hinken	Verband	Eurobaustoff	\N	\N	2025-06-03	Monatsaktion 10+1 auf SDS-Produkte 	Mailing 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1980	excel-import-user	import@system.com	Guido Hinken	Verband	EDE	\N	\N	2025-06-04	Abstimmung Fortis	Anpassungen vornehmen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1981	excel-import-user	import@system.com	Guido Hinken	Verband	Eurobaustoff	\N	\N	2025-06-05	Musteraufbau Eurobaustoff 6 mtr. Ausgearbeitet	Aufbau KW 26 in Dinklage	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1982	excel-import-user	import@system.com	Guido Hinken	Verband	Hagebau	\N	\N	2025-06-05	Hagebau Profi Fachmarkt Werbung Herbst/Winter Vorschlag erstellt für 1/3 Seite	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1983	excel-import-user	import@system.com	Jens Werner	102253	ITM	Alberic Paradiso	\N	2025-06-04	Angebot über Gesamtsortiment	\N	A	72000.00	250000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1984	excel-import-user	import@system.com	Jens Werner	106994	wolfcraft GmbH	Manuel Kreuer, Thomas Deuster	\N	2025-06-06	10k € Auftrag für Spring offer erhalten	Lieferfähigkeit verbessern	A	10000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1985	excel-import-user	import@system.com	Jens Werner	107038	ABRABORO Kft	Markus Zimmermann	\N	2025-06-03	Angebot über Sommeraktion mit 5l Bierfass unterbreitet	Auftrag erhalten	A	55000.00	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1986	excel-import-user	import@system.com	Jens Werner	101358	CRETEC CO. LTD	Dongdal	\N	2025-06-04	Telefonmeeting mit Dongdal wegen 2. Auftrag	100k € Auftrag erwartet Ende Mai nächstes Gespräch	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1987	excel-import-user	import@system.com	Jens Werner	151804	SAS Prodesca	Emmanuel Salomez	\N	2025-06-02	Angebot für Spanien	Warten auf Feedback	A	50000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1988	excel-import-user	import@system.com	Jens Werner	150336	Van Roij Fasteners Europe B.V	Richard Munsters	\N	2025-06-02	 Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Nachhaken	A	52000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1989	excel-import-user	import@system.com	Jens Werner	109571	MÜLLER & CO.	Sebastian Henke	\N	2025-06-02	Termin vor Ort Ausweitung Zusammenarbeit	Termin in Remscheid, 03.06.2025	A	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1990	excel-import-user	import@system.com	Jens Werner	100530	UAB KESKO SENUKAI LITHUANIA	Ernestas Virzaitis	\N	2025-06-02	Kunde liegt Angebot aus China vor und will wechseln, da deutlich günstiger	Alternativ Angebot made in China verschickt	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1991	excel-import-user	import@system.com	Jens Werner	100719	A.S.F. Fischer BV	Dominic Bravenboer	\N	2025-06-04	Vorstellung kombiniertes Bohrwerkzeug mit Setzwerkzeug	Nachhaken	B	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1992	excel-import-user	import@system.com	Jens Werner	151725	Unitech Isam Kabbani & Partners	Mohammad Al Najjar	\N	2025-06-04	Spring offer und Teams Termin vereinbaren	Follow up Meeting im Mai	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1993	excel-import-user	import@system.com	Jens Werner	100848	IRONSIDE	Thomas Verdy	\N	2025-06-04	Gespräch anfangs positiv. Zusage 11 von 12 Miotgliedern für Wechsel von Diager zu TCG. Durch Aktivitäten mit Marke Heller beim Mitglied Tout Faire in Frankreich wird die Entscheidung auf Ende Mai vertagt. Ohne diese Aktivität hätten wir heute die Zusage für Erstbelieferung im Okt 2025 erhalten	Dear Werner \n\nUnderstood am in vacation this week but we will have internal discussion \nAlso e meeting with Toutfaire as well because we need also to clarify things on this side \nAlso we are not against to combine ironside selection and complete it with some Heller items\nGive me 2 weeks and I will comeback to you \n\nAll the best \nThomas \n\n	A	\N	1200000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1994	excel-import-user	import@system.com	Jens Werner	151041	Holzhauer KG	Frau Quad	\N	2025-06-02	Telefongespräch: Mitglied GC, größeres Bauprojekt	Auftrag über 15k-20k € für Anfang Mai erwartet	C	\N	15000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1995	excel-import-user	import@system.com	Jens Werner	150236	Plieger BV	Haico Kroep	\N	2025-06-02	Angebot CONEL 	Warten auf Feedback	A	\N	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1996	excel-import-user	import@system.com	Nikolaj Ljabach	150060	Drugstraitis	Kęstutis Akelis	E-Mail	2025-06-05	Angebot Trijet unter PL	Nachhaken in 2 Wochen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1997	excel-import-user	import@system.com	Nikolaj Ljabach	101599	NG Elektro	Herr Bergner	E-Mail	2025-06-05	Angebot Bohrkronen	Nachhaken in 2 Wochen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1998	excel-import-user	import@system.com	Nikolaj Ljabach	107675	Optimera Estonia	Sergei Kruglov	E-Mail	2025-06-05	\N	Auslieferung	A	7300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
1999	excel-import-user	import@system.com	Nikolaj Ljabach	103358	Vijci Kranjec	Laura	E-Mail	2025-06-05	\N	Auslieferung	A	5200.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2000	excel-import-user	import@system.com	Nikolaj Ljabach	103146	Glomera	Giedrius	E-Mail	2025-06-05	\N	Auslieferung	A	4360.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2001	excel-import-user	import@system.com	Nikolaj Ljabach	151176	Madatex	Zdeno	E-Mail	2025-06-05	\N	Auslieferung	B	2500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2002	excel-import-user	import@system.com	Nikolaj Ljabach	150141	Horvath 	Csaba	E-Mail	2025-06-05	\N	Auslieferung	B	2200.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2003	excel-import-user	import@system.com	Nikolaj Ljabach	103007	CEG	Zuzana	E-Mail	2025-06-05	Sonderauftrag Kassetten	Auslieferung	A	700.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2004	excel-import-user	import@system.com	Nikolaj Ljabach	150148	Imexa	Dejan	WhatsApp	2025-06-05	Kundenantwort:"Will do order 150k -13% just have to get some Orders from customers first :)"	In Erwartung des Auftrages	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2005	excel-import-user	import@system.com	Nikolaj Ljabach	108123	YASTA/Profitool	Andrej/Maxim	WhatsApp	2025-06-05	Kundenantwort:"Guten Abend, Nikolay) Die Liste ist längst fertiggestellt und an Andrei weitergeleitet worden. Heute Mittag haben wir sie gerade besprochen, und soweit ich weiß, sollte er sich bald bei Ihnen melden."	In Erwartung des Auftrages	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2006	excel-import-user	import@system.com	Nikolaj Ljabach	101562	Optimera Latvia	Alexandars	E-Mail	2025-06-05	Zusendung der Sattistik Optimera EE	In Erwartung des Auftrages	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2007	excel-import-user	import@system.com	Martin, Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-06-06	Interesse weiterhin fuer den Tapcon Bohrer, Angebot (verschiedene Verpackungsvarianten) gesendet, Prototyp ist noch nicht fertig gestellt, wird erst erfolgen, wenn das Interesse beim Kunden weiterhin fuer Made in Germany besteht. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2008	excel-import-user	import@system.com	Martin, Palme	103214	ZI-TECH TH	Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-06-06	Anmahnungen Lieferungen, Rueckstaende pruefen usw. Kleine Luffrachtbestellung erhalten. Ein Endkunde ist interessiert in PL, Anforderungen & Kontidionen diskutioert und uebergeben. AB 8.1K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Anfang Juli Angebot fuer 10 % fuer 15K EUR Bestellwert als Juli Promotion	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2009	excel-import-user	import@system.com	Martin, Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-06-06	Offizielle Bestellung erhalten. Trijet Ultimate mit 8 Wochen Lieferzeit ist nicht gut, auch nach Pruefung ergab sich kein besserer Liefertermin!! Klaerung der Lieferung, mit welchem Spediteur geliefert werden soll.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2010	excel-import-user	import@system.com	Martin, Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-06-06	Die Mai Pruefung ergab, dass sie so langsam den Keil Brand (10K EUR sind auf dem Schiff und die Lieferung wird Mitte/Ende Juni erwartet) auslaufen lassen, um dann gleich eine groessere Bestellung fuer den Heller Brand zu machen, wo wir dann evtl. durch einen Erstausstattungsrabatt einen groesseren Wert erzielen koennten. Werden aber zwischendurch bereits Heller bestellen, um einen Soft Launch zum Heller Brand zu machen zu machen. Verpackungsfrage ob Klipp oder Tasche, werden die gleichen Varianten als bei Keil nehmen fuer den Start. Zukuenftig soll es die nachhaltige Variante sein, da dies in NZ sehr gross geschrieben wird. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist vom Kunden angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2011	excel-import-user	import@system.com	Martin, Palme	151141	Powerpac NZ	Jay, Patrick	Mail	2025-06-06	Keine Bestellung in Kuerze, da noch Lagerbestand ud eine Lieferung unterwegs	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2012	excel-import-user	import@system.com	Martin, Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-06-05	Kunde hat noch genug auf Lager, deshalb jetzt noch keine neue Bestellung. Projekt verloren, Lieferzeiten fuer Trijet Ultimate nicht akzeptabel.	Naechste Woche nachhaken wegen dem Projekt	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2013	excel-import-user	import@system.com	Martin, Palme	151317	Steel & Tube NZ	Aries	Mail	2025-06-05	Nachfrage wegen 10 % / 15K EUR Bestellwert, Kunden wird nicht bestellen, Markt ist im Moment sehr ruhig und Lagerbestand noch vorhanden. Bestellung wahrscheinlich erst 2. Jahreshaelfte	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2014	excel-import-user	import@system.com	Martin, Palme	150279	Trucut NZ	Rod, Justin	Mail	2025-06-05	Preislich sind wir nicht wettbewerbsfaehig, da Bosch (Clean Plus-8X) einen gerningeren Preis hat. Habe eine neue Kalkulation erstellt und mit AV durchgesprochen und neue Preise angeboten. Kunde evaluieret den Markt, sprich mit seinen Dealer, wie die neuen Preise funktionieren wuerden, danach Feedback	Ende aechste Woche nachhaken	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2015	excel-import-user	import@system.com	Martin, Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-06-04	Weiteres Gespraech mit Francesco, wie Situation im Management aufgenommen wurde, weitere Gespraeche werden hier kommen. Habe ihn unterrichtet, dass wir uns um einen 2. Distributor ausschau halten. Wenn es hier zu einer Entscheidung fuer einen direkten Konkurrenten kommt, wie z.B. Synergy Construction (auch Kunde von Iccons), dann kann die Zusammenarbeit etwas abkuehlen aber bei Amor oder PlumBoss gibt es keine direkten Ueberschneidungen. Anfrage bezueglich China Bohrer, Preisliste nochmals gesendet. Projekt fuer 10 mm Duster, Target Preis 11.53 EUR abgelehnt, ist nicht machmar fuer unsere Marge. Noch keine Entscheidung AB 0.1K EUR	Naechste Gespraeche nach weiteren Diskussionen bei Iccons	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2016	excel-import-user	import@system.com	Martin, Palme	151242	Majjatra INDO	Gunawan, Lili	Mail	2025-06-04	Fragt an, wann die Muster fuer die China Bohrer versendet werden. Zahlungsrueckstaende beim Kunden nachgefasst, Ueberweisung am 4.06. erfolgt. Bestellung 5.2K EUR erhalten	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2017	excel-import-user	import@system.com	Martin, Palme	109842	Hept SK	Hr. Bong	Mail	2025-06-04	Angefragt, welchen Status die Zahlungsrueckstaende von ca. 53K EUR, und lt. Kunden will er diese weiterhin bis Ende Juni bezahlen, auch mit Teilzahlungen versuchen zu taetigen, sodass dann alles bis Ende Juni alles ueber die Buehne sein muesste. Ich habe gesagt, dass dies die letzte Chance sein wuerde, bevor wir dann die naechsten Schritte fuer einen neuen Distributor starten werden. Der PL Kunde Cretec macht ihm natuerlich auch das Leben schwer, da er mit heftigen Promotions in den Markt geht. AB 13.8K EUR	Naechste Woche nachhaken	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2018	excel-import-user	import@system.com	Martin, Palme	150279	Trucut NZ	Rod, Justin	Mail	2025-06-03	Preislich sind wir nicht wettbewerbsfaehig, da Bosch (Clean Plus-8X) einen gerningeren Preis hat. Habe eine neue Kalkulation erstellt und mit AV durchgesprochen und neue Preise angeboten.	Naechste Woche nachhaken, wenn keine Bestellung oder Rueckfragen kommen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2019	excel-import-user	import@system.com	Egon Jesse	103232	Isero 	\N	Den Haag	2025-06-02	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2020	excel-import-user	import@system.com	Egon Jesse	100231	BMN 2x	\N	Den haag	2025-06-02	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2021	excel-import-user	import@system.com	Egon Jesse	109756	Bouwhof	\N	Zoetermeer	2025-06-02	Besprochen uber Umtausch von Heller und deWalt waren.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2022	excel-import-user	import@system.com	Egon Jesse	103232	Isero	\N	Eindhoven	2025-06-03	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2023	excel-import-user	import@system.com	Egon Jesse	100231	BMN	\N	Deurne	2025-06-03	Wand Umbau	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2024	excel-import-user	import@system.com	Egon Jesse	103232	Isero 	\N	Helmond	2025-06-03	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2025	excel-import-user	import@system.com	Egon Jesse	101497	Stock vd Walle	\N	Assenede	2025-06-04	Besuch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2026	excel-import-user	import@system.com	Egon Jesse	108884	Lecot	\N	Eeklo	2025-06-04	Besuch 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2027	excel-import-user	import@system.com	Stephan Heinitz	100347	Union Bauzentrum Hornbach	Herr Machuletz	Primasens 	2025-06-02	Termin mit Herren Machuletz, Tretter und Bleck bzgl. Online-Verkaufspräsentation/Artikellistungen usw.	siehe Zeile 86	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2028	excel-import-user	import@system.com	Stephan Heinitz	108854	Union Bauzentrum Hornbach	Herr Callsen/Herr Dausch	Hauenstein	2025-06-02	wg. Sortimentserweiterung Stichsägen, Säbelsägen, Starlock, Scheifen, Trennen, Diamant gesprochen; Rückware KWB und Heller vom 4Power-Umbau besprochen, Kunde bekommt Angebot über die Sortimentserweiterung	Angebot Sortimentserweiterung erstellen	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2029	excel-import-user	import@system.com	Stephan Heinitz	106398	Hornung	Herr Leyerle	Blankenloch	2025-06-03	Regelbesuch, Aktionen und Neuheiten angesprochen, Fremdwarendifferenz Einrichtung 2023 endlich geklärt, Kunde hat Sortimentsbereinigung angesprochen	\N	A	\N	\N	8	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2030	excel-import-user	import@system.com	Stephan Heinitz	107718	Union Bauzentrum Hornbach	Herr Wendel	Kandel	2025-06-03	Aktionen und Neuheiten angesprochen, 	\N	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2031	excel-import-user	import@system.com	Stephan Heinitz	107617	Union Bauzentrum Hornbach	Herr Hemberger	Billigheim	2025-06-03	Aktionen und Neuheiten angesprochen, Bit-Tower angesprochen - 	Bit-Tower entwerfen und anbieten	B	\N	\N	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2032	excel-import-user	import@system.com	Stephan Heinitz	101135	Gillet	Herr Heimbichner	Landau	2025-06-03	Aktionen und Neuheiten angesprochen, Spachtelmeißel angesprochen, 	\N	A	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2033	excel-import-user	import@system.com	Stephan Heinitz	101209	Union Bauzentrum Hornbach	Herr Gotzen	Neuhofen	2025-06-03	Aktionen und Neuheiten angesprochen, auf Umbau bzw. Sortimentserweiterung Stichsägen, Säbelsägen, Starlock Bits und Schleifen angesprochen - noch keine Entscheidung gefallen, Angebot bereits seit mehreren Monaten vorliegen	\N	B	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2034	excel-import-user	import@system.com	Stephan Heinitz	102708	Gillet	Herr Schubing	Neustadt	2025-06-03	Aktionen und Neuheiten vorgestellt	\N	B	\N	\N	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2035	excel-import-user	import@system.com	Stephan Heinitz	108203	Hornbach	Herr Machuletz	Neustadt	2025-06-03	Einzelartikel f. Online-Verkauf zusammengestellt, vorbereitet und Warenpräsentation ausgearbeitet	\N	A	\N	5000.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2036	excel-import-user	import@system.com	Stephan Heinitz	100788	Bolay	Herr Kaya	Rutesheim	2025-06-04	Besprechung Unternehmergrillfest/Hausmesse 24.06.	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2037	excel-import-user	import@system.com	Stephan Heinitz	101388	Werkzeug-Jäger NDL Willstädt	Herr Steurer	Willstädt	2025-06-04	Aufbau Handwerkerfrühstück, Vorbereitung HW-Frühstück	\N	A	\N	\N	16	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2038	excel-import-user	import@system.com	Stephan Heinitz	101388	Werkzeug-Jäger NDL Willstädt	Herr Steurer	Willstädt	2025-06-05	Handwerkerfrühstück	Warenpräsentation in Absprache mit Karlsruhe überarbeiten	A	\N	\N	16	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2039	excel-import-user	import@system.com	Stephan Heinitz	108800	Union Bauzentrum Hornbach	Herr Nolde	Karlsbad-Ittersbach	2025-06-05	2,5D-Umbau Kreissägen auf Kundenwunsch, nun 6m Warenpräsentation vorhanden	Angebot neues Modul Allmat Pro	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2040	excel-import-user	import@system.com	Stephan Heinitz	109015	Heinitz Stephan	\N	Kleinheubach	2025-06-06	Angebote vorbereiten, Teams-Meetings etc.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2041	excel-import-user	import@system.com	Pantaleo Stomeo	101545	Frank Niebergall Handelsunternehmen	Herr Niebergall	37269 Eschwege	2025-06-02	Allgemeiner Kundenbesuch, die Neueröffnung vor ein paar Wochen war gut. Es geht jetzt hier drum unsere Produkte aktiv anzubieten um Drehzahlen zu bekommen aber Herr Niebergall ist was das angeht sehr optimistisch. Wand war noch gut gefüllt daher keine Dispo notwendig. Er hätte gerne ne Excelpreisliste. Allgemeine neue Unterlagen vorgestellt und abgegeben.	Excel-Preisliste vom ID erstellen lassen und Herrn Niebergall zuschicken lassen.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2042	excel-import-user	import@system.com	Pantaleo Stomeo	100428	Raiffeisen Waren GmbH	Frau Ilyasov	37269 Eschwege	2025-06-02	Allgemeiner Kundenbesuch, Herr Mengel der hier zuständig war ist mittlerweile in Rente und die neue AP ist Frau Ilyasov. Hier habe ich mich vorgestellt und einen neuen Ordner mit den kompletten Unterlagen abgegeben. Wand hatte einige Lücken und daher direkt eine DISPO gemacht. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	1300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2075	excel-import-user	import@system.com	Cord-Jürgen Bruns	102863	Kipp & Grünhoff GmbH & Co. KG	Herr Wert	Ratingen	2025-06-04	Aktionen und Neuheiten vorgestellt; möchte bestellen - stimmt sich mit Herrn Widdermann ab; Dispo macht er selber; bezügl. der BA: er prüft und meldet sich	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2043	excel-import-user	import@system.com	Pantaleo Stomeo	107714	Schrader Handel GmbH	Herr Robin Gaw	37154 Northeim	2025-06-02	Hier gibt es zum einen einen Groß- und Einzelhandel. Im Großhandel sind wir mit 1 m (6 Modulen) vertreten läuft aber nur nebenbei. Und hier besteht kein Interesse was neues dazu zu nehmen. Im Einzelhandel läuft dagegen sehr viel aber man will da nur Bosch haben (10m Wand vorhanden) Aktionen vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2044	excel-import-user	import@system.com	Pantaleo Stomeo	100018	Raiffeisen Waren GmbH	Herr Senft	37339 Leinefelde-Worbis	2025-06-02	Allgemeiner Kundenbesuch, Herr Senft hat sich Zeit genommen und wir haben uns ein wenig unterhalten. Man ist mit Heller soweit zufrieden aber man merkt einfach das die Kunden immer weniger kaufen und man soll auch die Bestände unten halten daher ist der Umsatzrückgang auch so wie er ist. Komplette neue Unterlagen vorgestellt und abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2045	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Bauzentrum Tönnes GmbH & Co. KG	Herr Gerald Leich	51109 Köln	2025-06-03	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Gerald leich. Vor Ort sind 5m x 2m Milwaukee an Maschinenzubehör und noch 3m x 2m Milwaukee Maschinen. zusätzlich hat man noch 1m Starlock von Bosch. An den Milwaukee Sachen will und wird man nix verändern. Man ist da sehr zufrieden und hat auch super Konditionen. Wo man überlegen könnte wäre bei den Starlock Sachen von Bosch, hier muss man aber mit dem Standortleiter sprechen der aber aktuell nicht da ist und auch länger ausfallen wird. Gerne kann ich Ende August nochmal vorbei kommen wenn die Sommerferien rum sind und dann kann man schauen ob da wirklich was verändert wird. Aktuellen neuen Ordner abgegeben	Ende August 2025 wieder hinfahren und schauen ob wir Bosch bei Starlock verdrängen können	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2046	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Henrich Baustoffzentrum	Herr Michael Tomek	51105 Köln	2025-06-03	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Michael Tomek. Bei diesem Standort handelt es sich um einen sehr sehr kleinen Standort, man vertreibt tatsächlich überhaupt kein Maschinenzubehör. Anders sieht es in der Zentrale in Siegburg oder in bergisch Gladbach aus. Da hätten wir vllt. größere Chancen. Dennoch neuen Ordner vorgestellt und dagelassen. 	Standort in Bergisch Gladbach demnächst anfahren 	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2047	excel-import-user	import@system.com	Pantaleo Stomeo	105907	Dieter Kurth GmbH	Herr Kurth jun.	51399 Burscheid	2025-06-03	Allgemeiner Kundenbesuch, Herr Kurth hat mir heute wieder einmal bestätigt das er mit dem wenigen was vor Ort ist vollkommen glücklich ist und das auch ausreicht. Man will nicht erweitern und wenn Bedarf ist wird man bestellen. Aktionen vorgestellt aber aktuell kein Bedarf. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2048	excel-import-user	import@system.com	Pantaleo Stomeo	103297	Hans Schuy Baustoffgesellschaft	Herr Landsberg	51381 Leverkusen	2025-06-03	Allgemeiner Kundenbesuch, hier ist mir ja bewusst das wir gegen die vorhandene 5m Bosch Wand wenig Chancen auf Umsatz haben. Dies hat Herr Landsberg mir heute wiedermal zu verstehen gegeben. Die noch laufenden Aktionen erneut vorgestellt, will sich die in Ruhe anschauen und bei Bedarf meldet er sich.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2049	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Höck Jansen GmbH	Herr Benjamin Fidorra	51647 Gummersbach	2025-06-03	Allgemeiner Kundenbesuch, der Kunde war vor Jahren mal KEIL Kunde und aufgrund was da passiert ist hat er KEIL rausgeschmissen und Milwaukee genommen. Man ist im Nordwest und bezieht auch Promat. Hatte Ihm letztes Jahr mal Heller vorgestellt, er wollte sich die Sachen anschauen. Heute hat er mir mitgeteilt das Heller nicht in Frage kommt, die haben damals KEIL zu gemacht und aus dem Grund will man nicht Heller aufnehmen. Katalog, Preisliste, Flyer und Aktion vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es Neuheiten oder neue Aktionen gibt und diese vorstellen in der Hoffnung den Kunden für Heller zu gewinnen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2050	excel-import-user	import@system.com	Pantaleo Stomeo	109830	Bau- & Brennstoffe Bender	Herr Bender	51597 Morsbach	2025-06-03	Allgemeiner Kundenbesuch, Herr Bender ist weiterhin mit Heller sehr zufrieden und hat nix zu meckern. Auch unsere neuen Produkte (Diamant, Schleifen und Trennen) kommen bei seinen Kunden sehr gut an. Hier waren auch paar Haken leer so das ich wieder eine kleine Dispo gemacht habe. Bei den rechteckigen Schleifblätter ist keine klett vorhanden obwohl es so angegeben ist. Hier muss es geprüft werden. Sonst komplett neue Unterlagen vorgestellt und abgegeben.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2051	excel-import-user	import@system.com	Pantaleo Stomeo	100248	Schnittger Baustoffe GmbH & Co. KG 	Herr Sören Ihlenfeld	32312 Lübbecke	2025-06-04	Umbau vorhandene 2m Präsentation. Kunde hat die Allmat Lochsägen zurückgegeben und dafür das Modul Bohrkronen und Lewis Schlangenbohrer neu mit aufgenommen. Heute vor Ort die komplette Wand umgabaut. Module neu angeordnet und umgehangen und alles wieder hübsch gemacht. Kunde ist sehr zufrieden. Es waren ein paar Haken leer daher direkt eine kleine DISPO durchgeführt. Aktuelle neue Unterlagen vorgestellt und abgegeben.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2052	excel-import-user	import@system.com	Pantaleo Stomeo	100256	Schnittger Baustoffe GmbH & Co. KG 	Herr Malte Ruttke	32278 Kirchlengern	2025-06-04	Umbau vorhandene 2m Präsentation. Kunde hat die Allmat Lochsägen zurückgegeben und dafür das Modul Bohrkronen und eine 7ner Hakenreihe Schalungsbohrer neu mit aufgenommen. Heute vor Ort die komplette Wand umgabaut. Module neu angeordnet und umgehangen und alles wieder hübsch gemacht. Kunde ist sehr zufrieden. Einige Etiketten haben gefehlt und die werden nun nachgeschickt. Aktuelle neue Unterlagen vorgestellt und abgegeben.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2053	excel-import-user	import@system.com	Pantaleo Stomeo	101502	Peter Trepke	-	36329 Romrod	2025-06-05	Heute wollte ich mich bei diesem Kunden vorstellen da er hin und wieder mal bisschen Umsatz macht und ich schauen wollte ob da mehr geht. Vor Ort musste ich leider feststellen das an der angegebenen Adresse nur ein Wohnhaus mit einer großen Scheune ist. Hier gibt es kein Ladengeschäft und auch keine Klingel die auf den Namen passt. Hier muss die Adresse beim nächsten mal abgeklärt werden. 	Adresse abklären wo der Firmensitz ist und bei meiner nächsten Tour hier im Gebiet erneut besuchen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2109	excel-import-user	import@system.com	Paulo Santos	108471	The Hireman (London) Ltd.	Noel	London	2025-06-03	New catalogues, promotions	Send prices for Recip Saw Blades	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2054	excel-import-user	import@system.com	Pantaleo Stomeo	101280	Raiffeisen Waren GmbH	Herr Heil	36124 Eichenzell	2025-06-05	Allgemeiner Kundenbesuch, vor Ort stellte ich fest das mein eigentlicher AP Herr Erich Froese einen Herzinfakt hatte und erstmal ausfällt. Herr Heil hat das vorübergehend übernommen. Mich kurz vorgestellt und mit Ihm zur Wand gegangen und alles besprochen. Einige Haken waren leer und daher direkt ne DISPO gemacht. Aktion vorgestellt woraus er Forstnerbohrer Kassetten bestellt hat. Neue aktuelle Unterlagen abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	1000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2055	excel-import-user	import@system.com	Pantaleo Stomeo	108898	Pro Scheich	Herr Hartung	36043 Fulda	2025-06-05	Allgemeiner Kundenbesuch, es hat sich nix verändert. Man hat vor Ort ja 2m Ruko und 1m Makita und bei Heller wird nur auf Kundenanfrage SDS-Max oder Meißel bestellt. So ist man auch zufrieden und will da vorerst auch nix ändern.  Aktionen sind nicht interessant aktuell und es wird alles so bleiben wie es ist. Aktionen nochmals vorgestellt aber aktuell keinen Bedarf	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2056	excel-import-user	import@system.com	Pantaleo Stomeo	102474	Wemag GmbH & Co. KG	Herr Faulstich	36043 Fulda	2025-06-05	Allgemeiner Kundenbesuch, man hat ja auf 20qm Milwaukee (Maschinen & Zubehör) und da ist man sehr zufrieden mit. Hin und wieder wird aber bei uns bestellt, was auch so bleiben wird aber eine Umstellung komplett auf Heller ist nicht vorgesehen. Aktionen vorgestellt aber aktuell kein Bedarf. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2057	excel-import-user	import@system.com	Pantaleo Stomeo	Neukunde	Holz-Jung GmbH & Co. KG	Herr Andre Becker	36251 Bad Hersfeld	2025-06-05	Eurobaustoffneukundenbesuch: Heute bei diesem Kunden gewesen und mich und die Firma Heller vorgestellt. AP hier im Haus ist Herr Andre Becker. Bei diesem Standort handelt es sich um einen sehr sehr kleine Filiale die Zentrlae sitzt in Kirchhain bei Marburg und dort ist Herr Reinel der AP für den Einkauf. Man vertreibt tatsächlich überhaupt kein Maschinenzubehör. Hier mal in der Zentrale vorbei fahren denn da wird noch Maschinenzubehör verkauft. 	In der Zentrale in Kirchhain bei Marburg vorbei fahren und mit Herrn Reinel sprechen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2058	excel-import-user	import@system.com	Jörg Priebe	107108	ELG Lübben	Herr Melchert	Lübben	2025-06-08	Diamtscheiben, Fächerscheiben ja; Dünntrennscheibe PACK Weilter 125x1 netto € Stk. 0,5-0,52 dann ja	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2059	excel-import-user	import@system.com	Jörg Priebe	100117	Siebert Oetzel OHG	Christian Klenke	Berlin	2025-06-02	NEIN zu Aktion Mai 10% auf alles ab 28000 bis 3000.-, hat noch genügent	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2060	excel-import-user	import@system.com	Jörg Priebe	103073	Capital Baustoffe 	Frau Weithe, Hr.Janosch	Berlin	2025-06-04	06.05.25 Neuheiten, Neulistung, Aktion … , doppelten Auftragswert, eventuell - 10% ab 5000.-	\N	A	\N	\N	45820	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2061	excel-import-user	import@system.com	Jörg Priebe	103073	Capital Baustoffe 	Frau Weithe, Hr.Janosch	Berlin	2025-06-04	06.05.25 Neuheiten, Neulistung, Aktion … , doppelten Auftragswert, eventuell - 5% ab 5000.-// Bestellungen folgen Ende KW 23/24/26	\N	A	1457.46	\N	45820	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2062	excel-import-user	import@system.com	Jörg Priebe	101322	Possling GmbH & CoKG	Hr.Pezoldt,Hr.Hentrich	Berlin	2025-06-05	108954 FOD/ 101322 HA/ 101323 LA  - Auftrag Lager + HSS CO Stepstar Stahlbohrer DIN 338RN 32504 2 und 31227 1; Lagerauftrag KW 24 gesamt 2500.- - 3%	\N	A	5397.26	2500.00	45820	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2063	excel-import-user	import@system.com	Jörg Priebe	106228	Gebr. Fürstenberg Standort Rathenow	.Alexander Bertz	Rathenow	2025-06-05	Angebot, Konditionen, Diamanttechnik, Schleifen, Kondition 45/63% SNP 125,230x3; 125x7; …, Rest doppelten Auftragswert Twermin Juni Fix, interene Vereinbarung M.P. 	\N	B	\N	3479.47	45820	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2064	excel-import-user	import@system.com	Jörg Priebe	107259	Schulz Baubedarf, Standort Brauburger	Michel Müller, ADM	Neustadt	2025-06-05	Aktionsauftrag ab 2500.- zusätzlich - 10%, momentannoch kleiner Lagerbestand, Arbeit für div. Gr. 12-14-16x 1000… nein, eventuelle in den nächsten 3 Monaten wenn dafür Arbeit ist in der Abdichtiung	\N	B	\N	\N	45888	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2065	excel-import-user	import@system.com	Cord-Jürgen Bruns	108698	Hinrichs  	Herr Ritter	Apen	2025-06-02	Auftrag Bohrkronen	\N	B	3000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2066	excel-import-user	import@system.com	Cord-Jürgen Bruns	102856	Schulte	Herr Neuenstein	Rhede	2025-06-02	Besprechung Dealer Days	Leider ohne Heller	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2067	excel-import-user	import@system.com	Cord-Jürgen Bruns	100201	Paul Swertz GmbH	Herr Schagen	Emmerich	2025-06-03	Möchte Umbauen: Duster Expert, Allmat, Rooftil und CeraExpert Highspeed raus und dafür Allmat Pro, 2. 4Power Modul und Starlock Schleifen rein; Differenz wird mit einer Dispo ausgeglichen.	Umbau planen; Teile bestellen; Umbautermin vereinbaren	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2068	excel-import-user	import@system.com	Cord-Jürgen Bruns	103253	Paul Swertz GmbH	Herr Verhoeven	Alpen	2025-06-03	Aktionen und Neuheiten vorgestellt: findet er gut! Für die StepStar hätte er gerne ein Thekendisplay	mit Marketing sprechen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2069	excel-import-user	import@system.com	Cord-Jürgen Bruns	100218	Paul Swertz GmbH	Herr Daamen	Geldern-Veert	2025-06-03	Unterlagen aktualisiert; Aktionen und Neuheiten vorgestellt; er musste aus Einkaufspolitischen Gründen die Starlock Blätter von Makita nehmen und hat uns ausgelistet	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2070	excel-import-user	import@system.com	Cord-Jürgen Bruns	103187	Mundfortz Baustoffe GmbH	Herr Nobereit	Schwalmtal	2025-06-04	Nacharbeiten Präsetation; Neuheiten vorgestellt: will StepStar bestellen; hätte gerne ein Thekendisplay	mit Marketing sprechen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2071	excel-import-user	import@system.com	Cord-Jürgen Bruns	150727	Kilbinger KG	Herr Güttges	Neuss	2025-06-04	auf den Tischkalender hingewiesen; hat 2m Bosch aufgenommen; mit Keil gut zufrieden; will bestellen	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2072	excel-import-user	import@system.com	Cord-Jürgen Bruns	107515	BTE GmbH	Frau Ergenzinger	Düsseldorf	2025-06-04	City-Büro; Dienstleistungsunternehmen; Unterlagen aktualisiert; kauft nur, wenn Kunden anfragen bei Bedarf	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2073	excel-import-user	import@system.com	Cord-Jürgen Bruns	101007	Sorg GmbH	Herr Sorg	Düsseldorf	2025-06-04	war ein Einzelkämpfer; hat das Unternehmen geschlossen	löschen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2074	excel-import-user	import@system.com	Cord-Jürgen Bruns	100901	Steinrück GmbH & Co. KG	Herr Schulz	Düsseldorf	2025-06-04	Unterlagen aktualisiert; Neuheiten und Aktionen vorgestellt: interessiert; möchte mit uns eine Aktion planen; StepStar hätte er gerne ein Display; braucht Muster von Excenterschleifscheiben 150mm K120 und K180	Muster versenden	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2175	excel-import-user	import@system.com	Paulo Santos	109127	Finlex International Ltd	Alan Tang	Norwich	2025-06-12	Regular visit	Send prices for the abrasives	A	851.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2076	excel-import-user	import@system.com	Cord-Jürgen Bruns	100496	Mobau Baustoff-Union GmbH	Herr Schmal	Aachen	2025-06-05	Starlock Präsentation mit Schleifen aufgebaut; Retouren bearbeitet und mitgenommen; 10 Starlock Koffer verkauft	Auftrag erfassen und liefern	A	900.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2077	excel-import-user	import@system.com	Frank Papperitz	104788	HNT Riesa	Uwe Scheiblich	Riesa	2025-06-02	leider Fan von Projahn geworden, Gründe: Lieferung fast immer komplett am nächsten Tag, Top- Preise, Top Qualität. Von Heller noch Trijet und die meissten Meissel + HSS- Kassetten, Leider kaum noch Absatz Stocker- uns Spachtelmeissel, Kunden kaufen das wohl billiger im Netz	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2078	excel-import-user	import@system.com	Frank Papperitz	107611	Krabbes	Mario Stoye	Leipzig	2025-06-02	HSS jetzt von PTG, statt Bohrcraft, Stepstar vorgestellt, will damit nicht anfangen, SDS alle von Heller, außer billige 4er-SDS-Sätze von PTG	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2079	excel-import-user	import@system.com	Frank Papperitz	104756	Paufler	Roland P.	Radebeul	2025-06-02	alter Keil- Fan, kauft aber verstärkt auch beim NW-Lager	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2080	excel-import-user	import@system.com	Frank Papperitz	100760	Bauking- Mischstandort	Mirko Braunert	Leipzig	2025-06-02	0-Dreher zur Retoure vorbereitet (ca. 950 €), Gegenauftrag 1:1 vereinbart, alle KSB im Abverkauf, Wandumbau auf je 2 x 2018, 4Power, Trijet, Stichsägen und 1 x Meissel, und HSS-Co. jetzt Ware viel sichtbarer	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2081	excel-import-user	import@system.com	Frank Papperitz	101498	TIB	Herr Eberle	Lauter	2025-06-06	hat wieder Trennscheiben bestellt, die seien besser als Klingspor	\N	B	300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2082	excel-import-user	import@system.com	Steve Bell	107752	Avantifix	Mike	Leeds	2025-06-02	Meeting with Owner / Avantifix / Warehouse	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2083	excel-import-user	import@system.com	Steve Bell	107751	Mark Up Tools	Kazim	Manchester	2025-06-04	Stock order	\N	A	1000.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2084	excel-import-user	import@system.com	Mark Smethurst	108126	Pam Ties	Simon	Tyldesley	2025-06-02	Spoke with Simon, Offers, Took order.	Quote for Hss sets	A	900.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2085	excel-import-user	import@system.com	Mark Smethurst	101559	Fastline Services	Adam	Doncaster	2025-06-02	Presentation of Trijet Features and benefits.	send digital presentation	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2086	excel-import-user	import@system.com	Mark Smethurst	101607	Nortech Services Ltd	Tony	Hull	2025-06-02	Met with Tony. New Account, showed samples and Pricing.	Follow up 2 weeks	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2087	excel-import-user	import@system.com	Mark Smethurst	100640	TD Supplies	Gary	Hull	2025-06-02	Follow up Meeting to discuss pricing	Follow up with samples	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2088	excel-import-user	import@system.com	Mark Smethurst	Prospect	Industrial Supplies Ltd	Phil	Hull	2025-06-02	Cold call. Showed catalogue and samples.	follow up 4 weeks	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2089	excel-import-user	import@system.com	Mark Smethurst	107750	Martindales ind supplies	Peter	Preston	2025-06-03	Showed Offers. Collected faulty product and took order.	email presentation	B	350.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2090	excel-import-user	import@system.com	Mark Smethurst	100800	Fortress Fasteners	Pat	Clitheroe	2025-06-03	Follow up Meeting to discuss pricing	Quote for cutting business	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2091	excel-import-user	import@system.com	Mark Smethurst	Prospect	Steve Halstead	Steve	Giggleswick	2025-06-03	Cold Call. Discussed catalogue.	Follow up 8 weeks	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2092	excel-import-user	import@system.com	Mark Smethurst	Prospect	Powersaver Electrical	Richard	Burnley	2025-06-03	Cold Call. Catalogue and offers.	Follow up 4 weeks	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2093	excel-import-user	import@system.com	Mark Smethurst	Prospect	Sutcliffe Tool Company	Alex	Burnley	2025-06-03	NMBS Member, Discussed pricing.	Email pricing.	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2094	excel-import-user	import@system.com	Mark Smethurst	103008	3D Tooling Ltd	John	Bolton	2025-06-04	Catalogue, Price list. 5% on £2500 order, 10% on £5000 order.	Email pricing.	B	\N	2500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2095	excel-import-user	import@system.com	Mark Smethurst	107752	Avantifix	Adam	Leeds	2025-06-04	Meeting with Adam. Discussed 10+1 calender offer.	Follow up 2 weeks	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2096	excel-import-user	import@system.com	Mark Smethurst	Prospect	Powersaver Electrical	Gavin	Brighouse	2025-06-04	Cold Call. Meeting with Gavin buyer for both branches.	Email Quote and offers	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2097	excel-import-user	import@system.com	Mark Smethurst	Prospect	Rothwells supplies Ltd	Cynthia	Rochdale	2025-06-04	Prospect. Showed catalogue and business card.	Email Offers	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2098	excel-import-user	import@system.com	Mark Smethurst	Meeting	Sales Meeting	sales team	Oakham	2025-06-05	Sales Meeting with S. Bell. - P. Santos.	meeting	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2099	excel-import-user	import@system.com	Mark Smethurst	Meeting	Sales Meeting	sales team	Oakham	2025-06-06	Sales Meeting with S. Bell. - P. Santos.	meeting	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2100	excel-import-user	import@system.com	Mark Smethurst	Amin	Meeting and Admin	sales team	Oakham	2025-06-06	Travel back from sales meeting.	admin	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2101	excel-import-user	import@system.com	Paulo Santos	100181	DGL Workshop Supplies LTD	Lynn	Hertfordshire	2025-06-02	Regular Visit, Order	Order	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2102	excel-import-user	import@system.com	Paulo Santos	101945	Metro Fixings Ltd.	Laurence	Hertfordshire	2025-06-02	Meeting, collect Return, Order, Promotion Rebar Breaker	Follow Up Promotion	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2103	excel-import-user	import@system.com	Paulo Santos	107763	Herts Tool Co	Simone	Hertfordshire	2025-06-02	Payments, meet guys from the counter, new catague	Follow up promotion	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2104	excel-import-user	import@system.com	Paulo Santos	101369	J K Supplies Ltd.	Joe	Hertfordshire	2025-06-02	Regular Visit, Hss sets offer, Mobile Dealer	Call Joe in 2 Weeks	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2105	excel-import-user	import@system.com	Paulo Santos	103295	Selmach Machinery Ltd.	Bill	Hertfordshire	2025-06-02	Regular, Lapsed account, Coming on Board again.	Send sending information	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2106	excel-import-user	import@system.com	Paulo Santos	100335	Optimum Trade Supplies Ltd.	Lee Lucas	Peterborough	2025-06-02	Call, Msg with order	Follow up Promotions	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2107	excel-import-user	import@system.com	Paulo Santos	102934	APM Plumbing Ltd.	Brian	London	2025-06-03	New catalogues, quote for order, promotions	Follow up for order	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2108	excel-import-user	import@system.com	Paulo Santos	103046	Focus Plant	Bradley	London	2025-06-03	New catalogues, promotions, They will request  quote in 2weeks	Call in 2 weeks	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2110	excel-import-user	import@system.com	Paulo Santos	109243	Selkent Fastenings Ltd.	Robert	Orpington	2025-06-03	Meeting, Preparation Bulk Order for June	Follow up with call in 1 wekk	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2111	excel-import-user	import@system.com	Paulo Santos	109743	Suffolk Fasteners UK	Emma	Ipswich	2025-06-03	Call, Email order	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2112	excel-import-user	import@system.com	Paulo Santos	102843	East Engineering Components Ltd.	Mark East	Milton Keynes	2025-06-04	Meeting Mark, Turnover, SDS Plus range	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2113	excel-import-user	import@system.com	Paulo Santos	101914	Abbot Fixings	Kevin	Milton Keynes	2025-06-04	Meeting Kevin, Duster drill Bits	Ask for sizes in 1 Week	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2114	excel-import-user	import@system.com	Paulo Santos	102133	Motion Plus Ltd.	Paul 	Milton Keynes	2025-06-04	Regualr Visit, Lapsed account, offer promotion HSS sets	Call in 1 Week	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2115	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE	Rafael	Madrid	2025-06-04	Campaña SDS-Plus 10+1 GRATIS, Garantien, Zahlungsverzug	\N	A	0.00	3400.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2116	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - SUINSA4,SL	Juan Manuel	Salamanca	2025-06-03	Komplette Range	Angebot erarbeiten	B	0.00	800.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2117	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - LJM Sum.Ind,SL	Luis	Salamanca	2025-06-03	Stichsägeblätterprogramm, Erstauftrag	\N	B	400.00	0.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2118	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Suministros INTEC	Pedro & Rafael	Salamanca	2025-06-03	TriJET MUSTER, Sonderrange mit Tiefenanschlag, Anker	Angebot erarbeiten + Muster	B	0.00	0.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2119	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Maq.CALDERON	Don Marcus	Salamanca	2025-06-03	Vermieter, Extra lange Bohrer und Meissel	\N	B	500.00	0.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2120	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Ferr.Martín ONTORIA	Sr.Martín	Salamanca	2025-06-03	SDS-plus & Sägerange	\N	B	0.00	0.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2121	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Ferr.Avenida	María-Luisa	Salamanca	2025-06-03	Anfrage Sägen für Paletten mit Nägeln "MUSTER"	Muster + Angebot schicken	B	0.00	400.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2122	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Comercial Agricola Pérez	Juán	Navalmoral de la Mata	2025-06-04	Angebot erstellen 6 Module lt.SUALPE	Angebot erarbeiten	B	0.00	1800.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2123	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Sum.MORALO	Pedro-Pablo	Navalmoral de la Mata	2025-06-04	TOP potential, 3 & 4m Modulwandangebot erstellen	Angebot erarbeiten	A	0.00	6000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2124	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - GRUMELEC	Agustín	Navalmoral de la Mata	2025-06-04	Meissel & TriJET & kleines Sägenprogramm	\N	B	200.00	500.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2125	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Ferr.DURÁN	Joaquín	Navalmoral de la Mata	2025-06-04	Komplette Range, ähnlich wie Talavera-Zentrale	Angebot erarbeiten	B	0.00	2000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2126	excel-import-user	import@system.com	Gunter Diedrich	108218	SUALPE - Ferr.Valentín Morales	Don Valentín	Navalmoral de la Mata	2025-06-04	Sucht nur Angebote/Preise & SET´s (HSS&SDS+)	\N	C	0.00	0.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2127	excel-import-user	import@system.com	Yasir Angar	102263	STC-Trading Oy	Illka Hattunen	FI	2025-06-13	Kunde bestellt im Juni	10% Extrarabatt anbieten	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2128	excel-import-user	import@system.com	Yasir Angar	101009	Vantaan Kiinnike ja Rak Oy	Mika Pyysalo	FI	2025-06-13	Kunde bestellt regelmäßig . Hat im Mai bestellt +  ggfs. Auftrag im Juni	Neues Angebot Kreissägen aus CN	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2129	excel-import-user	import@system.com	Yasir Angar	109894	Suomen Kiinnikekeskus OY	Jani Havukainen	FI	2025-06-13	Bestellt regelmäßig  nach Bedarf. 	10% Extrarabatt anbieten	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2130	excel-import-user	import@system.com	Yasir Angar	102914	EXPERTbeslag A/S	Johny Andersen	DK	2025-06-13	Bestellt regelmäßig  nach Bedarf. 	10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2131	excel-import-user	import@system.com	Yasir Angar	103408	Sorbo Industribeslag AS	Ove Jensen	NO	2025-06-13	Bestellt regelmäßig  nach Bedarf. Neue Bestellung im Juni	10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2132	excel-import-user	import@system.com	Yasir Angar	102874	Ahlsell Sverige AB	Rickard  Andersson	SE	2025-06-13	Bestellt regelmäßig  nach Bedarf. 	10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2133	excel-import-user	import@system.com	Yasir Angar	150100	LOBOMATIC AB	Jonathan Westh	SE	2025-06-13	Bestellt regelmäßig  nach Bedarf.  Wird ggfs im Juni bestellen	10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2134	excel-import-user	import@system.com	Yasir Angar	150087	Ferrometal Oy	Juuso Moilanen	FI	2025-06-13	Call mit Juuso Moilanen        -       Wird im Juni bestellen	10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2135	excel-import-user	import@system.com	Yasir Angar	150054	Antonio Capaldo Spa	Renato Dimpflmeier	IT	2025-06-13	Umsatzrückstand zu Plan        -     Hat bestellt	\N	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2136	excel-import-user	import@system.com	Yasir Angar	150252	R.E.I.T.  S.p.A.	Paola Tellatin	IT	2025-06-13	Umsatzrückstand zu Plan        -     Hat bestellt	\N	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2137	excel-import-user	import@system.com	Yasir Angar	101468	HOMBERGER S.P.A.	Luca Boscarino	IT	2025-06-13	Auftrag für OMNIA wurde bestellt	Neues Angebot HSS Stufen- Spiralbohrer	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2138	excel-import-user	import@system.com	Yasir Angar	101043	UBB S.R.L.	Eleisabetha Piras	IT	2025-06-13	Hat noch 25K  Auftragsbestand . Hat weitere 10000€ bestellt. 	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2139	excel-import-user	import@system.com	Yasir Angar	150181	George Katsafados Ltd	Elena Nicolaou	CY	2025-06-13	Wird im Juni bestellen	10% Extra anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2140	excel-import-user	import@system.com	Yasir Angar	102733	EDIL2000 SRL	\N	IT	2025-06-13	Wird im Juni bestellen	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2141	excel-import-user	import@system.com	Yasir Angar	103390	Soc.IT Commerciale	\N	IT	2025-06-13	Wird im Juni bestellen	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2142	excel-import-user	import@system.com	Yasir Angar	106912	G & T Imports Ltd.	Joanna Galea  	MT	2025-06-13	Umsatzrückstand zu Plan        -       Hat bestellt	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2143	excel-import-user	import@system.com	Yasir Angar	100852	ECONOMOTECHNIKI S.A.	Anne Laure	GR	2025-06-13	Umsatzrückstand zu Plan        -       Hat bestellt	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2144	excel-import-user	import@system.com	Yasir Angar	150310	THEOTHRIDIS IOANNIS & SOHN OE	Herr Stefanos	GR	2025-06-13	Umsatzrückstand zu Plan        -       Auftrag  im Juni	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2145	excel-import-user	import@system.com	Yasir Angar	150001	A. Aivazoglou P. Dalaglis A.E.	Herr Stefanos	GR	2025-06-13	Umsatzrückstand zu Plan        -       Hat 8.000€ bestellt	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2146	excel-import-user	import@system.com	Yasir Angar	151808	THEMIS GIANNAKIS S.A.	Herr Stefanos	GR	2025-06-13	Umsatzsteigerung        -       Wird im Juni  bestellen	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2147	excel-import-user	import@system.com	Yasir Angar	150332	G. Vella & Sons Limited	Patrick Vella	MT	2025-06-13	Umsatzrückstand zu Plan        -       Hat bestellt	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2148	excel-import-user	import@system.com	Yasir Angar	100120	Gulf Diameter Est. for Trading	Jamshed Attassery	SA	2025-06-13	Umsatzrückstand zu Plan        -       Lager ist voll! Keine große Bestellung vor Q3 - Angebot aus CN versendet.	Angebot - SDS aus CN >>nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2149	excel-import-user	import@system.com	Yasir Angar	109612	Wizner Building & Fencing Supp Ltd	Eyal Wizner	IL	2025-06-13	Umzug / neues Lager       Hat bestelt , nächster Auftrag im Juli	Angebot - aus CN >>nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2150	excel-import-user	import@system.com	Yasir Angar	109750	GEN NEXT TOOLS	Rafiq Banatwala	IN	2025-06-13	Umsatzsteigerung        -       Hat bereits 100k Umsatz und 150k bestellt	Angebot - SDS Max >>nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2151	excel-import-user	import@system.com	Yasir Angar	150013	Al Daaem Est.	Mr Zaki	SA	2025-06-13	Umsatzsteigerung        -       Bestellt erst wieder in Q3 oder Q4	Angebot >>nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2152	excel-import-user	import@system.com	Yasir Angar	100906	Alexandria Progress Trading Co.	Michael Suleiman	EG	2025-06-13	Umsatzrückstand zu Plan        -       Bestellt ggfs. erst wieder in Q3 oder später	Angebot >>nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2153	excel-import-user	import@system.com	Yasir Angar	150138	Hashahal Trad. House Ltd	Ehud Quittner	IL	2025-06-13	Umsatzsteigerung        -       Hat bestellt	10% Extrabatt anbieten	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2154	excel-import-user	import@system.com	Yasir Angar	106396	Multi-Fix (Pty) Ltd	Celeste  Smith	ZA	2025-06-13	Umsatzsteigerung        -       Nächste Bestellung im Junii	10% Extrabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2155	excel-import-user	import@system.com	Yasir Angar	102922	GLOBAL SOURCE MIDDLE EAST GENERAL	Sameer Subair	AE	2025-06-13	Umsatzrückstand zu Plan        -       Bestellt regelmäßig  nach Bedarf	Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2156	excel-import-user	import@system.com	Yasir Angar	107713	GEORGES ZAKA & CO.	Antoine Zaka	LB	2025-06-13	Umsatzrückstand zu Plan        -       Hat zuletzt 18 k bestellt	Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2157	excel-import-user	import@system.com	Yasir Angar	150301	SWIT	Mathew Jacob	IN	2025-06-13	Umsatzsteigerung        -       Hat im Mai bestellt. Bestellt regelmäßig nach Bedarf	Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2158	excel-import-user	import@system.com	Yasir Angar	107104	Saeed Mohamed Basuliman Est for Tra	Saeed Basuliman	SA	2025-06-13	Umsatzsteigerung        -       Hat im Mai bestellt. Bestellt regelmäßig nach Bedarf	10% Extrabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2159	excel-import-user	import@system.com	Yasir Angar	100401	SEDISA SAC	Gustavo Gaiarin	PE	2025-06-13	Umsatzsteigerung        -       Hat Anfang des Jahres 110k bestellt. 	Nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2160	excel-import-user	import@system.com	Yasir Angar	101508	Segupro SAC	Miguel Gomez	PE	2025-06-13	Umsatzsteigerung        -       Hat  40k bestellt. 	Nachfassen	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2161	excel-import-user	import@system.com	Yasir Angar	150298	Mahle Metal Leve S/A	Fabiano Araujo 	BR	2025-06-13	Bestellt regelmäßig nach Bedarf    Bestellt regeläßig 2000 Stk.	5% Extrarabatt anbieten	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2162	excel-import-user	import@system.com	Yasir Angar	150104	Importadora ECO S.A.,	Alexander Sessler	CL	2025-06-13	Umsatzrückstand zu Plan        -       Bestellt regelmäßig  nach Bedarf. Rü steht aus.	Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2163	excel-import-user	import@system.com	Yasir Angar	100236	Kilman	Jonathan Soto	CL	2025-06-13	Umsatzrückstand zu Plan        -       Bestellt regelmäßig  nach Bedarf. Auftrag Strecke zugesagt.	Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2164	excel-import-user	import@system.com	Paulo Santos	107817	Invicta Tools & Fixings	Carl Wanstall	Canterbury	2025-06-09	Not Buying, meeting, NMBS member	info when we start with NMBS	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2165	excel-import-user	import@system.com	Paulo Santos	102689	ParkerSteel Ltd	Brian Nicholson	Canterbury	2025-06-09	Not buying,Meet to see where place as a supplier	Send promos	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2166	excel-import-user	import@system.com	Paulo Santos	109480	Diamond Direct Supplies	Mac Han	Grays	2025-06-09	Information about NMBS, meeting, they want to move	Inform the start	A	\N	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2167	excel-import-user	import@system.com	Paulo Santos	102482	Construction Site Supplies	Alain Wyers	Slough	2025-06-10	Meeting, New Buyer(former Selkent), organising stock and codes	Send the promos and NMBS Info	B	\N	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2168	excel-import-user	import@system.com	Paulo Santos	103156	H. Sealants & Fixings	Paul Balinger	Swindon	2025-06-10	Start buyng again, regular visit	send inofrmation about Long Series	B	\N	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2169	excel-import-user	import@system.com	Paulo Santos	105849	Fixings & Powertool Center	Ralph Whit.	Redhill	2025-06-10	Information about NMBS, meeting, they want to move	Info when strat NMBS	B	\N	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2170	excel-import-user	import@system.com	Paulo Santos	108713	Sitebox Ltd.	James Dolan	Redhill	2025-06-10	Regular Visit	Send the info with the promos	C	229.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2171	excel-import-user	import@system.com	Paulo Santos	109331	Toolfix Joinery & Const.	Nigel Burt	Peterborough	2025-06-11	Meet, discuss how can you put more range, collection of return 	Send the info with the promos	C	\N	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2172	excel-import-user	import@system.com	Paulo Santos	102511	Carter Eng. Supplies	Brian Carter	Peterborough	2025-06-11	Meet Brian, Buying form Bosch, Speak about Trijet Sds Plus	Send the promos by email	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2173	excel-import-user	import@system.com	Paulo Santos	100335	Optimum Trade Supplies	Lee Lucas	Peterborough	2025-06-11	Meet with Lee, mobile promo, order made	keep in touch	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2174	excel-import-user	import@system.com	Paulo Santos	109248	PWP Industrial	Ruth Fryer	Bedford	2025-06-11	Improve the partnership, just buying when Heller is asked	Send promos by email	C	50.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2177	excel-import-user	import@system.com	Paulo Santos	109743	Suffolk Fasteners UK	Emma Digby	Ipswich	2025-06-12	Regular Visit, Collect return.	Pay attention to payments	C	220.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2178	excel-import-user	import@system.com	Martin Palme	103214	ZI-TECH TH	Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-06-12	Anmahnungen Lieferungen, Rueckstaende pruefen usw.. Ein Endkunde ist interessiert in PL, Anforderungen & Kontidionen diskutioert und uebergeben. Neue kleine Luftfracht Bestellung in Bearbeitung und sollte heute, spaetestens am Montag eintreffen. AB 8.1K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Anfang Juli Angebot fuer 10 % fuer 15K EUR Bestellwert als Juli Promotion	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2179	excel-import-user	import@system.com	Martin Palme	151242	Majjatra INDO	Gunawan, Lili	Mail, Messenger	2025-06-12	Fragt an, wann die Muster fuer die China Bohrer versendet werden. Kunde DHL Abwicklung betreuen mit dem  Kunden (via DHL Indonesia). 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2180	excel-import-user	import@system.com	Martin Palme	150348	Wakai JP	Iwawaki, Nene	Mail	2025-06-12	Angebot gesendet. Endkunde hat weiterhin noch nicht entschieden, am 27.05.2025 nachgefragt, ob der Endkunde bereits entschieden hat. AB 12.8K EUR	Naechste Woche wieder nachhaken, wenn keine Bestellung kommt	A	\N	3.50	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2181	excel-import-user	import@system.com	Martin Palme	109842	Hept SK	Hr. Bong	Mail	2025-06-12	Angefragt, welchen Status die Zahlungsrueckstaende von ca. 53K EUR, und lt. Kunden will er diese weiterhin bis Ende Juni bezahlen, auch mit Teilzahlungen versuchen zu taetigen, sodass dann alles bis Ende Juni alles ueber die Buehne sein muesste. Ich habe gesagt, dass dies die letzte Chance sein wuerde, bevor wir dann die naechsten Schritte fuer einen neuen Distributor starten werden. Der PL Kunde Cretec macht ihm natuerlich auch das Leben schwer, da er mit heftigen Promotions in den Markt geht. AB 13.8K EUR	Naechste Woche nachhaken	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2182	excel-import-user	import@system.com	Martin Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-06-12	Weiteres Gespraech mit Francesco, wie Situation im Management aufgenommen wurde, weitere Gespraeche werden hier kommen. Habe ihn unterrichtet, dass wir uns um einen 2. Distributor ausschau halten. Wenn es hier zu einer Entscheidung fuer einen direkten Konkurrenten kommt, wie z.B. Synergy Construction (auch Kunde von Iccons), dann kann die Zusammenarbeit etwas abkuehlen aber bei Amor oder PlumBoss gibt es keine direkten Ueberschneidungen. Eine schriftliche Stellungnahme wird in den naechsten 2 Wochen kommen. Anfrage bezueglich China Bohrer, Preisliste nochmals gesendet. Projekt fuer 10 mm Duster, Target Preis 11.53 EUR abgelehnt, ist nicht machmar fuer unsere Marge/DB. Noch keine Entscheidung AB 0.1K EUR	Naechste Gespraeche nach weiteren Diskussionen bei Iccons	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2183	excel-import-user	import@system.com	Martin Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-06-12	Kunde hat noch genug auf Lager, deshalb jetzt noch keine neue Bestellung. Projekt verloren, Lieferzeiten fuer Trijet Ultimate nicht akzeptabel. Mail an Kunden, dass die Situation im Moment nicht zufriedenstellend ist, welche Massnahmen plant der Kunde.	Naechste Woche nachhaken wegen dem Projekt	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2184	excel-import-user	import@system.com	Martin Palme	100998	RFM MAL	Khiam, Raymond	Mail	2025-06-12	Warten auf die Muster der China Produkte. Forecast Abfrage fuer Juni.	Besuch einplanen nach meinem Urlaub	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2185	excel-import-user	import@system.com	Martin Palme	150039	Bordo AUS	Jerry, Yvonne	Mail	2025-06-12	Kunde geht mehr auf chinesische Produkte. Hier muessen wir abwarten, ob der Kunde weiterhin bei uns bestellen wird, wegen der CN Bohrer, die er dann direkt vom CN Lieferanten beziehen wird. Forecast Abfrage fuer Juni.	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2186	excel-import-user	import@system.com	Martin Palme	151141	Powerpac NZ	Jay, Patrick	Mail	2025-06-12	Keine Bestellung in Kuerze, da noch Lagerbestand ud eine Lieferung unterwegs	Naechste Woche nachhaken, wenn keine Bestellung kommt	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2187	excel-import-user	import@system.com	Martin Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-06-11	Trijet Ultimate mit 8 Wochen Lieferzeit ist nicht gut, auch nach Pruefung ergab sich kein besserer Liefertermin!! Internet Lead an den Kunden gegeben und besprochen.	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2188	excel-import-user	import@system.com	Martin Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-06-13	Interesse weiterhin fuer den Tapcon Bohrer, Angebot (verschiedene Verpackungsvarianten) gesendet, Prototyp ist noch nicht fertig gestellt, wird erst erfolgen, wenn das Interesse beim Kunden weiterhin fuer Made in Germany besteht. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2189	excel-import-user	import@system.com	Martin Palme	150279	Trucut NZ	Rod, Justin	Mail	2025-06-10	Habe eine neue Kalkulation erstellt und mit AV durchgesprochen und neue Preise angeboten. Kunde evaluieret den Markt, sprich mit seinen Dealer, wie die neuen Preise funktionieren wuerden. Lead time und Lieferoptionen besprochen.	Naechste Woche nachhaken	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2190	excel-import-user	import@system.com	Martin Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-06-10	Die Mai Pruefung ergab, dass sie so langsam den Keil Brand (10K EUR sind auf dem Schiff und die Lieferung wird Mitte/Ende Juni erwartet) auslaufen lassen, um dann gleich eine groessere Bestellung fuer den Heller Brand zu machen, wo wir dann evtl. durch einen Erstausstattungsrabatt einen groesseren Wert erzielen koennten. Werden aber zwischendurch bereits Heller bestellen, um einen Soft Launch zum Heller Brand machen zu koennen. Verpackungsfragen sind geklaert. Zukuenftig soll es die nachhaltige Variante sein, da dies in NZ sehr gross geschrieben wird. Warten auf die 2. Heller Muster Lieferung (Termin 18.06. zur Auslieferung), da 4 Wochen Unterschied zur ersten Lieferung. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist vom Kunden angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2191	excel-import-user	import@system.com	Martin Palme	105577	Mach Tools PH	Nancy Yu & Karlo Yu	Tel., Mail, Messenger	2025-06-09	Verschiffung Lieferung. 45K EUR im Maerz bestellt, teilweise ausgeliefert. AB 24.4K EUR wurden berechnet.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2192	excel-import-user	import@system.com	Martin Palme	151317	Steel & Tube NZ	Aries	Mail	2025-06-09	Markt ist im Moment sehr ruhig und Lagerbestand noch vorhanden. Bestellung wahrscheinlich erst 2. Jahreshaelfte	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2193	excel-import-user	import@system.com	Steve Bell	107752	Avantifix	Adam / Alex	Leeds	2025-06-10	Offer promotion, queit recent order placed /Accounts	Follow up abrasive	B	\N	300.00	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2194	excel-import-user	import@system.com	Steve Bell	151717	AccurA Diamond Tools Ltd.	Gary	Teams	2025-06-11	Special enquiry / Follow up meeting	Visit July	B	\N	300.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2195	excel-import-user	import@system.com	Steve Bell	106661	Interhire	David / James	Nottingham	2025-06-11	DSO /stock order	eail statement and dso release order on payment	B	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2197	excel-import-user	import@system.com	Steve Bell	108573	Power Point (Northern ltd)	Allan	Thirsk	2025-06-12	Special Meeting to Discuss NMBS	next order heller then move th NMBS	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2198	excel-import-user	import@system.com	Steve Bell	105973	Ace Fixings	Alex	Teams	2025-06-13	Teams meeting NMBS / Stock profile	Visit July	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2199	excel-import-user	import@system.com	Marcel Bornemann	101057	Geißler & Kuper 	Herr Keitel	Celle	2025-06-10	Ersatzteile für Starcutter usw.	\N	B	380.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2200	excel-import-user	import@system.com	Marcel Bornemann	104058	Jacob Cement	Herr Voß	Klein Rönnau	2025-06-10	Angebot Schleifen Trennen besprochen Warenrücknahme Fehlbestellung	Angebot erstellen Trennen Schleifen 	A	\N	900.00	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2201	excel-import-user	import@system.com	Marcel Bornemann	107623	Hass & Hatje	Herr Bänsch	Bad Segeberg	2025-06-10	Neuer AP für Fachmarkt Herr Bänsch Vorstellung	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2202	excel-import-user	import@system.com	Marcel Bornemann	150911	DBS Dachbaustoffe	Herr Silkenbäumer	Lübeck	2025-06-10	Keil Kunde der zu Eurobaustoff gewechselt ist , Heller Unterlagen abgegeben und auf die Produktvielfalt hingewiesen Kauft bei Keil Dachziegelbohrer 	nachfassen nach 6-8 Wochen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2203	excel-import-user	import@system.com	Marcel Bornemann	102878	Richter Baustoffe	Herr Hetzer	Lübeck	2025-06-10	Neuer AP Herr Hetzer Frau Dittmann ist nicht mehr im Unternehmen , Vorstellung frühbezug Stepstar bei Herrn Warnke der spricht mit der Fachgruppe	Nachfassen bei nächstem Besuche auch bei den Personen aus der Fachgruppe in anderen Standorten 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2204	excel-import-user	import@system.com	Marcel Bornemann	107589	Hass & Hatje	Herr Hein	Bad Oldesloh	2025-06-10	Vorstellung Stepstar und Bestseller so wie Allmat Pro 	Warten auf Penner Liste mögliche erweiterung Schleifen 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2205	excel-import-user	import@system.com	Marcel Bornemann	103009	Bauking ( Krüger & Scharnberg )	Herr Waschgler 	Hamburg	2025-06-11	Hausmesse Kunden Schulung und Mitarbeiter , Neuheiten vorstellen und gespräche über die Sparpolitik der BME Gruppe auch im Fachmarkt viel Auslauf gesetzt und nicht mehr nachbestellbar . 	Nacharbeit Hausmesse 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2206	excel-import-user	import@system.com	Marcel Bornemann	100812	Möders Bauzentrum 	Herr Dammann	Adendorf	2025-06-12	Gespräch über Neuheiten und die Einrichtung im Haus in Lüneburg möglichkeiten auch Adendorf umzurüsten >Vorteile usw .	weiter daran Arbeiten das die Gruppe zu Heller findet , haben momemtan ( Dewalt , Milwalkee , Makita und Heller als Lieferanten  ) 	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2207	excel-import-user	import@system.com	Marcel Bornemann	102203	Möders Bauzentrum 	Herr Niebuhr	Lüneburg	2025-06-12	Neuprodukte Stepstar und Bestseller vorgestellt und gespräch über den Fachmarkt im Baumarkt ( auch viele Endkunden nutzen den am Wochenende 	Mitarbeiter Schulung als nächstes geplannt Kunden kommt auf mich zu wenn die Urlabsziet vorbei ist	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2208	excel-import-user	import@system.com	Marcel Bornemann	151414	Niemann - Laes 	Herr Wölper 	Lüneburg	2025-06-12	Unterlagen Heller abgegeben ( Keilkunden bei Heller bis jetzt ) Lahmann Dinklage gekauft somit Ziel Makita und Bosch aus dem Hause zu verdrängen	Termin mit  möglichkeiten auf Angebot Umstellung 	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2209	excel-import-user	import@system.com	Marcel Bornemann	151189	Dachdeckereinkauf Soltau	Herr Tiedke	Soltau	2025-06-12	Keil Kunde Neue Unterlagen und Heller Gesammt abgegeben , möglichkeiten für den Dachdeckereinkauf zu Zentraliesieren im Werkzeugzubehör	Termin mit  möglichkeiten auf Angebot ( besprechen welche Produkte  )	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2210	excel-import-user	import@system.com	Marcel Bornemann	102979	Richter Baustoffe	Herr Röhrs 	Schneverdingen	2025-06-12	Aktion vorgestellt und Stepstar ( Herr Röhrs gehört zu Fachgruppe Werkzeug ) 	Nachfassen Stepstar Frühbezug	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2211	excel-import-user	import@system.com	Marcel Bornemann	102750	Büro Hamburg	Herr Bornemann	Hamburg	2025-06-13	Büro Planung Termine  Hotel buchen ; Einrichtung Schleifen JC Gruppe in KW 25 . 	Termine Neukunden ( sinnvoll Planen ) kostet viel Zeit und bringt spät Umsatz 	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2212	excel-import-user	import@system.com	Jörg Priebe	105090	Hemmersbach In dustriebedarf	Hr.Hemmersbach	Berlin	2025-06-11	 SNP Angebot div. Abm. 6-12x210 je 100Stk. Gegen ProJahn, Meissel, Stich.u.Säbensöge dito. - Angebot G.H // bst. 09.05.25/ Gesamtangebot 12.05.25	\N	B	777.20	\N	45820	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2213	excel-import-user	import@system.com	Jörg Priebe	101322	Possling HA	Herr Thomasn Hentrich	Berlin	2025-06-12	Sonderauftrag, Neulistung Meißel 5%; Ergänzung zum 05.06.25 Auftrag // Angebot Allmat Pro	\N	A	866.12	\N	45828	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2214	excel-import-user	import@system.com	Jörg Priebe	108954	Possling FOD	Herr Thomasn Hentrich	Berlin	2025-06-12	Sonderauftrag, Neulistung Meißel 5%; Ergänzung zum 05.06.25 Auftrag// Angebot Allmat Pro	\N	A	906.76	\N	45828	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2215	excel-import-user	import@system.com	Jörg Priebe	101323	Possling LA	Herr Thomasn Hentrich	Berlin	2025-06-12	Sonderauftrag, Neulistung Meißel 5%; Ergänzung zum 05.06.25 Auftrag // Angebot Allmat Pro	\N	A	636.31	\N	45828	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2216	excel-import-user	import@system.com	Jörg Priebe	103155	Bauking Berlin Schöneberg	Jan Schwanitz	Berlin Schöneberg	2026-06-12	Sonderaktion einmaliger, interne Promoaktion -3%; darf keine separaten Aufttrag über 2500.- setzten, Zentralanweisung	\N	A	1021.33	\N	45828	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2217	excel-import-user	import@system.com	Jörg Priebe	101306	WorkShop Nagel	Christian Nagel	Berlin	2025-06-12	Keil Juni Kalender Aktion 10+1 auf alle Meißel; Heller Kalenderaktion 10+1 auf alle SDS-plus;  \nHeller Tools Artikel Meißel, Kreissägblätter, …. * Intern ab 2500.- Heller 10% einmalig nur im Juni möglich*	\N	A	4336.64	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2218	excel-import-user	import@system.com	Guido Hinken	Verband	Hagebau	\N	\N	2025-06-10	Musteraufbau Inhaltsliste erstellt und Werte ermittelt	Fehlende Artikel werden durch Marcel noch eingerichtet	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2219	excel-import-user	import@system.com	Guido Hinken	Verband	Eurobaustoff	\N	\N	2025-06-10	Auftrag für den Musteraufbau ist erfasst	Prüfen ob alles verfügbar ist.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2220	excel-import-user	import@system.com	Guido Hinken	150732	Kunkel	\N	\N	2025-06-12	Bundbohrer HK Angefragt	Kalkulieren	A	2000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2221	excel-import-user	import@system.com	Guido Hinken	151174	Dönges	\N	\N	2025-06-12	Lagerauftrag 10% ab 7.500€ angeboten	\N	A	\N	7500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2222	excel-import-user	import@system.com	Guido Hinken	Verband	Bauking	Herr Achilles	\N	2025-06-12	Vertrag Bauking nur wenn BME Vertrag angepasst wird. Schleifen und Trennen erweitern. Leere Haken dürfen nicht sein in den Standorten, die Bausteine müssen umgesetzt werden und Minimum 2-3 Stück auf einen Haken sein.	Folgetermin KW 23 nach Freigabe des BME Vertrags.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2224	excel-import-user	import@system.com	Cord-Jürgen Bruns	108698	Carl Hinrichs e.K.	Herr Ritter	Augustfehn	2025-06-10	Einrichtung Bohrkronen Präsentation: abgeschlossen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2225	excel-import-user	import@system.com	Cord-Jürgen Bruns	106135	BAUKING Weser-Ems GmbH	Herr Feldmann	Bremen	2025-06-10	Anpassung und Umbau der Präsentation: abgeschlossen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2226	excel-import-user	import@system.com	Cord-Jürgen Bruns	109749	BAUKING Weser-Ems GmbH	Herr Auerbach	Natrup-Hagen	2025-06-11	Umbau der Präsentation auf 3D Baustein; nicht fertig gestellt	fehlende Teile besorgen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2227	excel-import-user	import@system.com	Cord-Jürgen Bruns	103867	Ludden GmbH	Herr Wilken	Lingen	2025-06-12	Neuheiten vorgestellt: Meissel und Allmat Pro interessant; Stepstar EK entspricht seinem aktuellen VK …; für den Allmat Pro hätte er gerne eine Artikelnummern Übersicht alt/neu; er möchte einen 4Power Tag (Test 4Power gegen Kundenbohrer) und Neuheiten gemeinsam mit einem PSA Lieferanten machen; hierzu soll ich ihm kurz einen Plan erstellen; Termin steht noch nicht genau fest evtl. KW 28	Vergleichsliste erstellen; Konzept schreiben und vorbereiten	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2228	excel-import-user	import@system.com	Cord-Jürgen Bruns	109749	BAUKING Weser-Ems GmbH	Herr Auerbach	Natrup-Hagen	2025-06-12	Umbau der Präsentation auf 3D Baustein abgeschlossen und Retouren bearbeitet	Auftragseingang kontrollieren	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2229	excel-import-user	import@system.com	Andreas Stockbauer	107685	Bauzentrum Otto Zillinger	Hr. Hies	Osterhofen	2025-06-02	Aktuelle Aktionen, hat nach wie vor sehr wenig Umsatz, da direkt nebenan der hauseigene Hagebaumarkt ist	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2230	excel-import-user	import@system.com	Andreas Stockbauer	107180	Bauzentrum Pfaffenhofen GmbH&Co.KG	Hr. Moll, Hr. Westermeier	Pfaffenhofen	2025-06-10	Aktuelle Aktionen, Hr. Moll macht aktuell aus Personalgründen auch die Fachmarktleitung für Schrobenhausen, Besuch hier entfällt somit	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2231	excel-import-user	import@system.com	Andreas Stockbauer	108602	Moser Agrar & Baufachzentrum e.K.	Hr.Tragl	Schweitenkirchen	2025-06-10	Aktuelle Aktionen, Hr. Tragl hat Urlaub, Hr. Ortmann macht vertretung	\N	B	300.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2232	excel-import-user	import@system.com	Andreas Stockbauer	108239	Bauzentrum Mayer GmbH & Co.KG	Hr. Finkenzeller	Ingolstadt	2025-06-10	Aktuelle Aktionen, nach wie vor sehr ruhig, Dispo	\N	B	800.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2233	excel-import-user	import@system.com	Andreas Stockbauer	101347	Baustoff Union GmbH	Hr. Götz/ Hr. Heyn	Nürnberg Hafen	2025-06-11	Aufbau Aktionstower	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2234	excel-import-user	import@system.com	Andreas Stockbauer	101003	Gebhardt Bauzentrum GmbH	Hr. Kopp	Fürth	2025-06-11	Aktuelle Aktionen, Beschwerde über Lieferzeiten nochmals abgeklärt, Hr. Kopp(niederlassungsverantwortlicher)ist hier eigentlich entspannt und verständlich, Thekenkraft Hr. Braun ist hier der Unruhestifter	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2235	excel-import-user	import@system.com	Andreas Stockbauer	101166	BAUSTOFF UNION GmbH	Hr. Brehm	Langenzenn	2025-06-11	Sortimentsgespräch zur Erweiterung, Angebot folgt durch ID, hat nächste Woche Urlaub, nachfassen bei NL Leitung Frau Preiss	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2236	excel-import-user	import@system.com	Andreas Stockbauer	109635	Meier Baustoffe GmbH	Hr. Schmeissner, Hr. Merkl	Weiden	2025-06-12	Aufbautermin Regalerweiterung von Seitenbehang auf 2mtr. Wand, Rücknahme Altware mit anforderung Callnummer erledigt	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2237	excel-import-user	import@system.com	Andreas Stockbauer	103001	Danhauser GmbH & Co KG	Hr. Herzog	Weiden	2025-06-12	Regalerweiterung von 2 auf 3mtr. Final festegelsgt, Angebot durch ID folgt, Hr. Glas (Sortiko) in CC	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2238	excel-import-user	import@system.com	Nikolaj Ljabach	150148	Imexa	Dejan 	E-Mail	2025-06-11	Auftrag über 160 K Euro mit Sonderkonditionen, netto ca 139	Packen und versenden	A	160000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2239	excel-import-user	import@system.com	Nikolaj Ljabach	101620	Dia Elit	Sergej/Igor/Marjan	E-Mail\nPaketversand	2025-06-11	Auftrag über 23 K Euro / Abstimmung der AB	Liefertermine mit LK abstimmen	A	23000.00	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2240	excel-import-user	import@system.com	Nikolaj Ljabach	100089	Penny Plus	Lejla	E-Mail	2025-06-11	Auftrag eingegangen	Auftrag eingeben und ausliefern/ 10+1 Aktion anwenden	C	2000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2241	excel-import-user	import@system.com	Nikolaj Ljabach	103146	Glomera	Arvydas	E-Mail	2025-06-11	Auftrag eingegangen	Ausliefern	A	5000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2242	excel-import-user	import@system.com	Nikolaj Ljabach	101066	Keneta	Besart	Pristina	2025-06-11	Besuch in Pristina zwecks neuanfang von der Zusammenarbeit. Siehe Bericht	Warten auf Auftrag mit Targetpreisen\nNachhacken in 2 Wochen	C	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2243	excel-import-user	import@system.com	Nikolaj Ljabach	151260	MIG Baltic	Aivars	E-mail	2025-06-11	Auftrag eingegangen	Ausliefern	B	3100.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2244	excel-import-user	import@system.com	Nikolaj Ljabach	109937	Steelrex Geo	Vano	WhatsApp	2025-06-11	Aussenstehende Forderungen / Auftrag mit 10+1 SDS Plus	Druck wegen Zahlung ausübern	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2245	excel-import-user	import@system.com	Nikolaj Ljabach	100243	Yasta / Profitool	Andrey Kravchenko	WhatsApp	2025-06-11	Auftrga mit 10+1 SDS Plus	Warten auf Feedback. \nNachhacken in 2 Wochen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2246	excel-import-user	import@system.com	Nikolaj Ljabach	101380	Soroush	Mrs. Soroush	WhatsApp	2025-06-11	Aussenstehende Forderungen	Warten auf Feedback. \nNachhacken in 2 Wochen	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2247	excel-import-user	import@system.com	Nikolaj Ljabach	101627	BUSTECHNIC HAVACILIK OTOMOTİV	Fatih Tutuş	E-mail	2025-06-10	Neuanlage Kunde	Warten auf den 1. Auftrag	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2248	excel-import-user	import@system.com	Nikolaj Ljabach	101562	Optimera LV	\N	Paketversand	2025-06-10	\N	Warten auf Feedback. \nNachhacken in 2 Wochen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2249	excel-import-user	import@system.com	Nikolaj Ljabach	107675	Optimera EE	\N	Paketversand	2025-06-10	\N	Warten auf Feedback. \nNachhacken in 2 Wochen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2250	excel-import-user	import@system.com	Nikolaj Ljabach	150211	Novomet	Frau Boeva	E-mail	2025-06-10	Klärung der größerer reklamation / Kunde unzufrieden	Fehler beim Packen abstellen !	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2251	excel-import-user	import@system.com	Nikolaj Ljabach	103007	CEG	Zuzana Ondrejkova	E-Mail	2025-06-10	Auftragseiingang	Ausliefern	A	4000.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2299	excel-import-user	import@system.com	Cord-Jürgen Bruns	108393	Ennens	Herr Kramer	Ostrhauderfehn	2025-06-19	Aktionen und Neuheiten vorgestellt; gut zufriede; hat derzeit sehr wenig Kundschaft, will aber trotzdem versuchen noch einen Auftrag zu schicken	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2384	excel-import-user	import@system.com	Paulo Santos	108818	Portatools	Garth Jones	South End	2025-06-16	Talk about NMBS, possible new Customer	Visit again 	C	\N	\N	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2252	excel-import-user	import@system.com	Pantaleo Stomeo	100999	B. Friebertshäuser	Herr Friebertshäuser	35075 Gladenbach	2025-06-10	Allgemeiner Kundenbesuch, Herr Friebertshäuser ist an sich mit Heller zufrieden. Sein Problem ist einfach das er viele Kunden verloren hat und somit auch viel weniger Umsatz macht als in den letzten Jahren. Es wird einfach zu wenig bei Ihm gekauft um sich eine Erweiterung oder so vorzustellen. Aktionen vorgestellt, diese will er sich in Ruhe anschauen und meldet sich dann bei mir. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2253	excel-import-user	import@system.com	Pantaleo Stomeo	106145	Wilhelm Drescher 	Herr Drescher	35633 Lahnau	2025-06-10	Allgemeiner Kundenbesuch, hier gibt es nix neues. Kunde ist zufrieden, wenn Bedarf ist wird bestellt und man hat nix zu meckern. Aktionen vorgestellt und mit Katalaog und Preisliste dagelassen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2254	excel-import-user	import@system.com	Pantaleo Stomeo	102335	Fritz Weg GmbH & co. KG	Herr Hees	35713 Eschenburg	2025-06-10	Allgemeiner Kundenbesuch, Herr Hees war heute da aber wollte und konnte sich keine Zeit für mich nehmen, er hat mir aber zu verstehen gegeben das man nicht vor hat viel mehr mit Heller zu machen als wie bisher. Man bestellt wirklich nur dann wenn die anderen nicht liefern können oder man spezielle Kundenanfragen nach Heller Produkte hat. Aktionen  dagelassen	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2255	excel-import-user	import@system.com	Pantaleo Stomeo	102408	Werkzeug Vogel Inh. Kamila Vogel	Frau Vogel	35112 Fronhausen	2025-06-10	Allgemeiner Kundenbesuch, Frau Vogel hatte mal wieder keine Zeit. Ich sollte dem Kollegen die Neuheiten und Aktionen vorstellen und er würde es dann an Frau Vogel weitergeben. Wand war gut gefüllt, daher keine DISPO durchgeführt. Aktionen und Kalender abgegeben. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2256	excel-import-user	import@system.com	Pantaleo Stomeo	107381	S & S Elektro Fachgroßhandlung GmbH (EGU)	Herr Kuhli	35684 Dillenburg	2025-06-10	Allgemeiner Kundenbesuch, Herr Kuhli ist mit unserem Sortiment was wir letztes Jahr neu eingerichtet haben 1x2m zufrieden. Die Kunden sind zwar noch sehr verhalten was das Kaufen angeht aber er ist guter Dinge das es in den kommenden Wochen besser läuft. Aktionen nochmals vorgestellt aber aktuell ist kein Bedarf, Neuheitenflyer vorgestellt und dagelassen, Katalog, Preisliste und Aktionen vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2257	excel-import-user	import@system.com	Pantaleo Stomeo	102805	Bussemas & Pollmeier GmbH	Herr Nieweg	33334 Gütersloh	2025-06-11	Kunde hatte um einen Termin gebeten weil er seine Wand (aktuell 8 Module Heller + 2m Makita mit Sägen und Schleifen) überarbeiten will und alles von Heller beziehen möchte. Nachdem er mich ca. 30 min hat warten lassen haben wir uns die Wand angeschaut und einen Behangplan ausgearbeitet über 3m Heller mit allem. Im Gegenzug würden wir Makita rausnehmen. Hier werde ich nun den Behangplan erstellen und das Angebot erstellen lassen um dieses dann Herrn Nieweg zukommen zu lassen. Neuen Ordner mit aktuellen Unterlagen abgegeben.	Behangplan erstellen und dem ID zwecks Angebotserstellung geben	B	\N	8500.00	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2258	excel-import-user	import@system.com	Pantaleo Stomeo	103416	Becker Baustoffe GmbH & Co. KG	Herr Winter	33397 Rietberg	2025-06-11	Allgemeiner Kundenebesuch. Herr Winter hat mir nochmals bestätigt das man mit der Umstellung letzten Jahres auf Hans-Werner sehr zufrieden ist und man nicht vor hat iwas zu ändern. Man werde auch in Zukunft auf Hans-Werner setzen. Sollte es hier Schwierigkeiten hat man als zweiten Lieferanten Makita da und das soll so bleiben da man auch hier sehr zufrieden ist. Für Heller also wenig Chancen auf Geschäfte in Zukunft. Auch die Aktionen sind nicht so interessant.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2259	excel-import-user	import@system.com	Pantaleo Stomeo	102225	Johannes Lefeld	Herr Münster	33397 Rietberg	2025-06-11	Allgemeiner Kundenbesuch, hier ist mir bewusst das es sehr schwierig wird da der Kunde auf einer Fläche von 20 qm alles von Bosch ausgestellt hat. Dennoch aktuelle Unterlagen da gelassen, man hat diese angenommen aber mir direkt mitgeteilt das es sehr sehr unwahrscheinlich ist das man sich von Bosch trennen würde. Aktionen vorgestellt aber aktuell keinen Bedarf	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2260	excel-import-user	import@system.com	Pantaleo Stomeo	101871	Fritz Gabriel GmbH & Co. KG 	Herr Gabriel	33615 Bielefeld	2025-06-11	Allgemeiner Kundenbesuch, Herr Gabriel betonte wiedermal das er aufgrund der großen Boschnachfrage seiner Kunden hier nix umstellen wird und bei Bosch bleibt. Zusätzlich bezieht man die meisten Sachen sowieso über das EDE-Lager und das soll auch so bleiben. Chancen Umsatz bei Heller daher so gut wie nicht vorhanden. Aktuelle Aktionen und Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2261	excel-import-user	import@system.com	Pantaleo Stomeo	107694	Heinrich Thorwesten KG	Herr Jargurdzija	58802 Balve	2025-06-12	Allgemeiner Kundenbesuch, auch Herr Jagurdzija klagte über eine aktuell sehr ruhige Lage. Bei Ihm ist TOTE HOSE meinte er und man will sich in dieser Zeit nix auf Lager legen. Auch der geplante Umbau (Rückgabe 0-Dreher und dafür was anderes) ist auf Eis gelegt. Aktionen vorgestellt, er findet die Preise bei den Diamant und Schwarzen Scheiben interessant, will sich aber überlegen ob es Sinn macht da man Lieferanten hat und jetzt in dieser Zeit sich nicht noch mehr aufs Lager zu legen. Will sich hierzu melden wenn Bedarf besteht. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2262	excel-import-user	import@system.com	Pantaleo Stomeo	100738	Arns + Römer KG	Herr Heierhoff	58640 Iserlohn	2025-06-12	Allgemeiner Kundenbesuch, Herr Heierhoff hatte letztes Jahr von mir ein Angebot bezüglich einer 1m Präsentation erhalten da vor Ort alles durcheinander hängt. Das Angebot liegt auch vor und soll auch umgesetzt werden aber nicht zum jetzigen Zeitpunkt. Er teilte mir mit das es aktuell sehr ruhig ist und man nicht absehen kann wann wieder der Aufschwung kommt und daher aktuell eine solche Investition nicht getätigt werden kann. Fakt ist man wird es machen aber man weis noch nicht wann. Aktionen erneut vorgestellt, hier könnte die Diamant- und Schwarze Scheiben interessant sein. Er schaut sich das in Ruhe an und gibt mir dann Rückmeldung. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2300	excel-import-user	import@system.com	Cord-Jürgen Bruns	109228	Steenhoff	Herr Broers	Rhauderfehn	2025-06-19	Aktionen und Neuheiten vorgestellt: Stepstar und Spachtelmeissel sind für ihn interessant, evtl. noch der Erdnageleintreiber	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2263	excel-import-user	import@system.com	Pantaleo Stomeo	100942	Höynck & Spengler GmbH	Herr Hoynck	58642 Iserlohn	2025-06-12	Allgemeiner Kundenbesuch, Herr Spengler war heute leider nicht im Haus. Dafür hat sich sein Kollege sehr viel Zeit genommen und hat mir ausführlich über die aktuell andauernden Probleme und Umsatzrückgänge berichtet. Man habe wohl auch schon Mitarbeiter entlassen müssen weil es so ruhig ist.\nAktionen und Neuheiten vorgestellt aber aktuell kein Bedarf. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2264	excel-import-user	import@system.com	Pantaleo Stomeo	100177	Bauking Südwestfalen GmbH	Herr Papajewski	58708 Menden	2025-06-12	Allgemeiner Kundenbesuch, Sven Papajewski ist ab sofort mein neuer AP im Haus. Herr Flach hat gekündigt und bevor er ging meinte er zu Sven das er mit mir das Thema umbau abschließen soll. Ich war also heute vor ort und habe Sven aufgeklärt wie die Vereinbarung ist und was beachtet werden muss bei der Rückgabe 1zu1. Aktuell sind vor Ort 4m, Sven weis noch nicht ob er alles auf 3m kürzen will aufgrund des hohen Rückgabewerts. Er hat nun alle Daten vorliegen und will sich Gedanken machen und sich dann bei mir melden mit den Infos was und wie viel er tatsächlich zurückgeben will und wie wir umbauen sollen. Aktionen, Katalog, Preisliste und Flyer vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2265	excel-import-user	import@system.com	Pantaleo Stomeo	103936	Bielemeyer GmbH & Co. KG 	Herr Martin Grunert	58706 Menden	2025-06-12	Allgemeiner Kundenbesuch. Herr Grunert hat mir wieder mal zu verstehen gegeben das er alles was er braucht direkt über Nordwest bezieht. Er will auch das es so bleibt und kann sich nicht vorstellen dies zu verändern.  Daher muss man davon ausgehen das kaum bis garkein Umsatz hier gemacht wird. ...Aktionen + Neuheitenflyer abgegeben Besuch max 2-3 im Jahr	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2266	excel-import-user	import@system.com	Pantaleo Stomeo	107481	Schleyer	Herr Schramm	58300 Wetter	2025-06-12	Allgemeiner Kundenbesuch. Kunde ist gleichzeitig auch KEIL Kunde. Bei Heller kauft er nur den Allmat und bei KEIL den Goldcraft. Mehr Bohrer hat er auch nicht im Angebot. Erweiterung ist hier so gut wie garnicht möglich. Neuste Aktionen vorgestellt und dagelassen	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2267	excel-import-user	import@system.com	Jens Werner	151160	VIKING Tools Inc.	M.S. Kim	\N	2025-06-11	offene Aufträge Zulieferer Rhodius Terminoptimierung , Ware wird benötigt	Planung nächste Aufträge	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2268	excel-import-user	import@system.com	Jens Werner	101358	CRETEC CO. LTD	Dongdal	\N	2025-06-12	Telefonmeeting mit Dongdal wegen 2. Auftrag	100k € Auftrag erwartet Ende Mai nächstes Gespräch	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2269	excel-import-user	import@system.com	Jens Werner	151804	SAS Prodesca	Emmanuel Salomez	\N	2025-06-12	Angebot für Spanien	Warten auf Feedback	A	50000.00	50000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2270	excel-import-user	import@system.com	Yasir Angar	150181	George Katsafados Ltd	Elena Nicolaou	CY	2025-06-20	Wird im Juni bestellen	10% Extra anbieten Nachfassen	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2271	excel-import-user	import@system.com	Yasir Angar	100852	ECONOMOTECHNIKI S.A.	Anne Laure	GR	2025-06-20	Umsatzrückstand zu Plan        -       Hat bestellt	\N	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2272	excel-import-user	import@system.com	Yasir Angar	150332	G. Vella & Sons Limited	Patrick Vella	MT	2025-06-20	Umsatzrückstand zu Plan        -       Hat bestellt	Besuch in Malta am 23.06.2025	B	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2273	excel-import-user	import@system.com	Yasir Angar	109750	GEN NEXT TOOLS	Rafiq Banatwala	IN	2025-06-19	Umsatzsteigerung        -       Hat bereits 100k Umsatz und 150k bestellt	Angebot - SDS Plus/Max 9,5%	A	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2274	excel-import-user	import@system.com	Pantaleo Stomeo	101072	Bauking Ostfalen GmbH	Herr Sens	39638 Gardelegen	2025-06-16	Allgemeiner Kundenbesuch, Kunde an sich sehr zufrieden mit dem ersten Jahr wo er Heller hat. Ware kommt bei den Kunden gut an. Einige Haken waren leer aber er wollte nicht das ich eine DISPO mache weil er umlagern muss. Hier muss anscheinend die Zentrale mal mitteilen das man bestellen darf. Beim nächsten Besuch, 2-3 Tage vorher anrufen und ein Termin machen da es um eine Sortimentsbereinigung geht. Neue aktuelle Unterlagen vorgestellt und dagelassen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2275	excel-import-user	import@system.com	Pantaleo Stomeo	102659	Mölders Baucentrum GmbH	Herr Romankewitsch	39590 Tangermünde	2025-06-16	Allgemeiner Kundenbesuch, vor Ort hatte Herr Romankewitsch eine Reklamation die ich dem ID weiterleiten werde von einem kaputten Bohrer. Sonst sehr zufrieden. Haken waren einige leer, aber auch hier will man selbst bestellen daher keine DISPO gemacht. Aktionen und alle neuen Flyer vorgestellt und mit dem Katalaog und Preisliste abgegeben. Bei der nächsten Bestellung will man evtl. was aus der Aktion bestellen.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen / Reklamation dem ID weiterleiten	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2276	excel-import-user	import@system.com	Pantaleo Stomeo	100751	VR Plus Altmark-Wendland eG	Herr Königsmann	39606 Osterburg Hansestadt	2025-06-16	Allgemeiner Kundenbesuch, Herr Königsmann weiterhin sehr zufrieden mit Heller. Es ist immer noch sehr ruhig hier. Man gehört nun zur Hagebau und ich soll den Butler Tower mal anbieten. Aktuelle neue Unterlagen vorgestellt und dagelassen. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2277	excel-import-user	import@system.com	Pantaleo Stomeo	107235	WEHEMA Magdeburg GmbH	Herr Schulz	39124 Magdeburg	2025-06-16	Allgemeiner Kundenbesuch, Herr Schulz hatte leider sehr wenig Zeit, meinte aber das Ihm keine Reklamationen oder Beschwerden bekannt sind. Aktuelle Unterlagen und Aktionen vorgestellt und dagelassen, man wird sich diese in Ruhe anschauen.  Stich- & Säbelsägen hat er von Wilpu seid 20 Jahren und will da auch nix ändern.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2278	excel-import-user	import@system.com	Pantaleo Stomeo	103165	Bauking Ostfalen GmbH	Herr Wohlgemuth	39128 Magdeburg	2025-06-16	Allgemeiner Kundenbesuch, an sich ist der Kunde mit Heller und meiner Arbeit sehr zufrieden. Man hat allerdings von der Zentrale Druck das die Bestände zu hoch sind und das zu viele 0-Dreher in der Wand sind. Somit ist aktuell vor Ort 1 Modul komplett leer und etliche Haken sind auch leer aber dies soll so bleiben auch wenn es nicht schön aussieht. Der Umbau soll wohl im 3ten Quartal erfolgen und so lange wird hier nix gemacht. Aktionen, Katalog und Preisliste abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2334	excel-import-user	import@system.com	Jörg Priebe	101612	Linnenbecker GmbH & Co.KG 	Herr Wellnitz	Berlin	2025-06-16	Modulbst. Tower Power 6-8 Module	\N	B	\N	\N	1	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2279	excel-import-user	import@system.com	Pantaleo Stomeo	107159	Thomas Leis 	Herr Leis	39240 Calbe/Saale	2025-06-17	Vorstellung meiner Person und Übergabe des aktuellen Katalogs, Preisliste und Kompetenzflyer / Überblick verschafft was es für ein Kunde ist / Kunde bestellt überwigend über Nexmart, da hier oft von Heller nix verfügbar war wurden die Bestellungen weniger. Er ist aber nicht abgeneigt wieder mehr mit Heller zu machen,. Heute hatte er leider wenig Zeit, er schaut sich die Unterlagen an und wird auch wieder eine Bestellung tätigen	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2280	excel-import-user	import@system.com	Pantaleo Stomeo	104348	Werkzeug Schultze GmbH	Herr Engler	39218 Schoenebeck	2025-06-17	Allgemeiner Kundenbesuch. Hier ist Heller vor Jahren rausgeflogen und ich wollte versuchen uns wieder interessant zu machen. Herr Engler meinte aber das man inzwischen 15m Bosch und 1m Milwaukee hat und damit sehr zufrieden ist. Heller ist aktuell nicht mehr interessant, aktuelle neue Unterlagen vorgestellt und abgegeben.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2281	excel-import-user	import@system.com	Pantaleo Stomeo	109381	EWM Menschel GmbH	Herr Brandes	38518 Gifhorn	2025-06-17	Allgemeiner Kundenbesuch, hierbei handelt es sich um einen sehr sehr kleinen Laden wo der Verkauf von Maschienenzubehör nur nebenbei gemacht wird. Vor Ort gibt es keine wirkliche Warenpräsentation. Bohrer, Stichsägen usw. hängen an der Wand querbeet an Einzelhaken. Wirklich festen Lieferanten hat man nicht da man da kauft wo es aktuell an günstigsten ist. Komplette aktuelle Unterlagen abgegeben und Aktionen vorgestellt, hier will man sich Gedanken machen und sich dann bei uns melden wenn was gutes dabei ist. 	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2282	excel-import-user	import@system.com	Pantaleo Stomeo	103107	Bauking Ostfalen GmbH	Herr Jankiewicz	38820 Halberstadt	2025-06-17	Allgemeiner Kundenebesuch, Herr Jankiewicz hat den Posten von Frau Schimsky übernommen und ist nun mein AP. Ihm gefällt die aktuelle Präsentation überhaupt nicht und da habe ich Ihm direkt auf die 3m Bausteine der Bauking angesprochen und Ihm diese Schmackhaft gemacht. So sehr das er direkt zugesagt hat und wir nun den Baustein "S" hier einrichten können. Dies soll so schnell wie möglich erfolgen. Neuen Ordner mit allen aktuellen Unterlagen vorgestellt und dagelassen.	Auftrag für den Umbau dem ID zwecks Eingabe geben und den Umbau einplanen	B	8000.00	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2283	excel-import-user	import@system.com	Pantaleo Stomeo	101207	Bauking Ostfalen GmbH	Frau Klodtka	38116 Braunschweig	2025-06-17	Allgemeiner Kundenbesuch, Frau Klodtka ist mit der Einrichtung dir wir im Sommer 2024 durchgeführt haben zufrieden. Der Anfang war ein wenig schleppend aber nach und nach fangen nun auch die Kunden an unsere Produkte zu kaufen. Aktionen und Neuheiten vorgestellt. Hier will Sie mit Ihrem Kollegen besprechen ob Sie daraus was bestellen können. Sonst alles super, Aktuelle Unterlagen und Aktion abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2284	excel-import-user	import@system.com	Pantaleo Stomeo	101613	Raiffeisen Waren GmbH	Frau Rohde	34497 Korbach	2025-06-18	ERSTEINRICHTUNG:\nHeute die Neueinrichtung 1x2m + 1x Butler Tower durchgeführt. Es war alles bis auf paar Etiketten für die Einrichtung dabei. Frau Rohde ist mit dem Ergebnis sehr zufrieden und eine Erweiterung ist durchaus denkbar, jetzt will man erstmal so starten und schauen wie die Produkte ankommen. Aktuellen Ordner hat Frau Rohde...	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2285	excel-import-user	import@system.com	Nikolaj Ljabach	100897	ProfiPartner	Bartosz	E-Mail	2025-06-17	Beer Promo Aktion	Hi Nikolaj,\nI don't like beer but others definitely do:) we'll make an order so get a beer ready.\n	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2286	excel-import-user	import@system.com	Nikolaj Ljabach	103146	Glomera	Arvydas	E-Mail	2025-06-17	BeerPromo Aktion	You already know we do and it is a great promo! \nAlthough unfortunately, we have missed our window of time for this order. Regarding these kind of promos for us it is better to do them around April and get that cold beer in May. 😊\n\nWe really appreciate the idea and we would love to get back to it next year around March, if it is okay with you ? This way we could take full advantage of the opportunity\n	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2287	excel-import-user	import@system.com	Nikolaj Ljabach	100243	OOO PROFITOOL (PROFITOOL LTD)	Kravchenko	E-Mail	2025-06-17	Abstimmung neue Exportpreise	Finalisieren / Aufrtagsbearbeitung	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2288	excel-import-user	import@system.com	Nikolaj Ljabach	102680	LINK CZ, s.r.o.	Jaroslav Koptal	E-Mail	2025-06-17	Erinnerung 10+1 SDS Plus	Montag, 23.06. nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2289	excel-import-user	import@system.com	Nikolaj Ljabach	105130	OREN s.r.o.	Fr. Honolkova	E-Mail	2025-06-17	Erinnerung 10+1 SDS Plus	Montag, 23.06. nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2290	excel-import-user	import@system.com	Nikolaj Ljabach	101026	IZOSERVICE sp.z.o.o.	Adam	E-Mail	2025-06-17	Erinnerung 10+1 SDS Plus	Montag, 23.06. nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2291	excel-import-user	import@system.com	Nikolaj Ljabach	101371	KARDEŞLER GÜMRÜK MÜŞAVİRLİĞİ	Murat	E-Mail	2025-06-17	Abholug der Ware	Vertrag mit dem nachfolger unterschreiben	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2292	excel-import-user	import@system.com	Nikolaj Ljabach	101516	LTD Energy	\N	E-Mail	2025-06-17	Erinnerung 10+1 SDS Plus	Montag, 23.06. nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2293	excel-import-user	import@system.com	Nikolaj Ljabach	103091	KRAFT Shpk	Klevi Kola	E-Mail	2025-06-17	Erinnerung 10+1 SDS Plus	Montag, 23.06. nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2294	excel-import-user	import@system.com	Nikolaj Ljabach	109937	Steelrex Geo	Bakar / Vano	E-Mail	2025-06-18	Abstimmung Zahlungsplan	Zahlungsplan nachverfolgen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2295	excel-import-user	import@system.com	Cord-Jürgen Bruns	107151	Berliner Schrauben	Herr Elfring	Münster	2025-06-16	Aktionen und Neuheiten vorgestellt; Umsatzrückgänge besprochen: massive Verluste bei Fliesenbohrern: kein Grund bekannt; Projahn macht keine 1000,-€ im Jahr: daran kann es also nicht liegen; er wird der Sache auf den Grund gehen und versucht zu bestellen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2296	excel-import-user	import@system.com	Cord-Jürgen Bruns	101621	WIMA	Herr Bünder	Arnsberg	2025-06-16	Heller, Aktionen vorgestellt; kauft i.d.R. über NW Lager; Unterlagen abgegeben	Excel-Preisliste mit Konditionen zusenden	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2297	excel-import-user	import@system.com	Cord-Jürgen Bruns	100878	Beleke	Herr Sartison	Arnsberg	2025-06-16	Aktionen und Neuheiten vorgestellt; Reklamation bearbeitet	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2298	excel-import-user	import@system.com	Cord-Jürgen Bruns	103106	Bauking 	Herr Fabri	Arnsberg	2025-06-17	Baustein eingerichtet: nicht abgeschlossen, da Regalteile fehlen	neuen Termin in der nächsten Woche	B	\N	\N	1	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2301	excel-import-user	import@system.com	Cord-Jürgen Bruns	102207	Sanders	Herr Hebbelmann	Papenburg	2025-06-19	Aktionen und Neuheiten für Herrn Schröer abgegeben; mit Herrn Hebbelmann über die Aktionen und Stepstar gesprochen: er will in der kommenden Woche zum Kuppeltreffen kommen und einen größeren Auftrag mitbringen und bei GH abgeben…; Reklamation bearbeitet; Präsentation aufgeräumt	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2302	excel-import-user	import@system.com	Cord-Jürgen Bruns	108259	Schulte	Herr Robbe	Papenburg	2025-06-19	Herr Robbe ist zur Zeit allein in der Abteilung: 2 Mitarbeiter haben gekündigt: einer ist heimatnah gewechselt, der andere ist zu Makita gegangen…; Aktionen und Neuprodukte vorgestellt; er muss vor seinem Urlaub (ab nächster Woche) noch einmal bestellen: 25 leere Haken…; ich durfte keine Dispo machen, da er sich alles genehmigen lassen muss! Er will nach seinem Urlaub das Thema schleifen und trennen angehen!	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2303	excel-import-user	import@system.com	Jens Werner	105533	Driltec, LLC.	Leslie Berch	\N	2025-06-17	kurzfristig benötigte Bohrer vom US Lager	Versandabwicklung 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2304	excel-import-user	import@system.com	Jens Werner	151160	VIKING Tools Inc.	M.S. Kim	\N	2025-06-17	offene Aufträge Zulieferer Rhodius Terminoptimierung , Ware wird benötigt	Planung nächste Aufträge	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2305	excel-import-user	import@system.com	Jens Werner	107038	ABRABORO Kft	Markus Zimmermann	\N	2025-06-18	Abraboro hat einen neuen Großkunden gewonnen	Auftrag über 50k € in Planung 	A	\N	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2306	excel-import-user	import@system.com	Jens Werner	101358	CRETEC CO. LTD	Dongdal	\N	2025-06-18	Telefonmeeting mit Dongdal wegen 2. Auftrag	100k € Auftrag erwartet 	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2307	excel-import-user	import@system.com	Jens Werner	106417	ALPEN-MAYKESTAG GMBH	Robert Holleis	\N	2025-06-18	Rückstände 	prüfen, ob wir Bohrer schneller liefern	A	25000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2308	excel-import-user	import@system.com	Jens Werner	109571	MÜLLER & CO.	Sebastian Henke	\N	2025-06-18	neues Angebot zugesendet, um Kunden zu halten	Warten auf Feedback	A	\N	30000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2309	excel-import-user	import@system.com	Jens Werner	108754	Ramset	Frazer Robinson	\N	2025-06-17	neuen Auftrag Absaugbohrer aus Tender erhalten	Liefertermine verbessern	A	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2310	excel-import-user	import@system.com	Jens Werner	151795	Seojeon MJ	Heekyung	\N	2025-06-19	Angebot über 230 + 180mm Trennscheiben	nachhaken	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2311	excel-import-user	import@system.com	Jens Werner	104743	Ruko GmbH	Kunal Bhosale	\N	2025-06-19	Angebot 2+4 Schneider made in China verschickt	nachfassen	A	\N	120000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2312	excel-import-user	import@system.com	Jens Werner	151725	Unitech Isam Kabbani & Partners	Mohammad Al Najjar	\N	2025-06-19	Termin per Teams vereinbaren	nachfassen	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2313	excel-import-user	import@system.com	Jens Werner	100848	IRONSIDE	Thomas Verdy	\N	2025-06-19	Gespräch anfangs positiv. Zusage 11 von 12 Miotgliedern für Wechsel von Diager zu TCG. Durch Aktivitäten mit Marke Heller beim Mitglied Tout Faire in Frankreich wird die Entscheidung auf Ende Mai vertagt. Ohne diese Aktivität hätten wir heute die Zusage für Erstbelieferung im Okt 2025 erhalten	nachfassen\n	A	\N	1200000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2314	excel-import-user	import@system.com	Jens Werner	106340	Hagebau Butler	Andreas Pellny	\N	2025-06-17	Follow up Termin zum Musteraufbau	Sortiment finalisieren	A	\N	150000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2315	excel-import-user	import@system.com	Jens Werner	über USA	Drill America	\N	\N	2025-06-17	zweiter Aufttag	Abwicklung	C	35000.00	35000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2316	excel-import-user	import@system.com	Guido Hinken	100313	PROFIX AG	\N	Lausen	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2317	excel-import-user	import@system.com	Guido Hinken	151245	Lamello AG	\N	Bubendorf	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2318	excel-import-user	import@system.com	Guido Hinken	150319	Torex Handels AG	\N	Villmergen	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2319	excel-import-user	import@system.com	Guido Hinken	102572	FILO	\N	Döttingen	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2320	excel-import-user	import@system.com	Guido Hinken	101713	MR SWISS AG	\N	Wettingen	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2321	excel-import-user	import@system.com	Guido Hinken	150357	Werka AG	\N	Opfikon	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2322	excel-import-user	import@system.com	Guido Hinken	Eurobaustoff	Hug Baustoffe AG	\N	Nänikon	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2323	excel-import-user	import@system.com	Guido Hinken	101244	EFCO Befestigungstechnik AG	\N	Nänikon	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2324	excel-import-user	import@system.com	Guido Hinken	100505	RAMO Handels GmbH	\N	Kilchberg	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2325	excel-import-user	import@system.com	Guido Hinken	150249	RB Tools GmbH	\N	Au-Wädenswil	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2326	excel-import-user	import@system.com	Guido Hinken	107992	TOCAFIX AG	\N	Spreitenbach	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2327	excel-import-user	import@system.com	Guido Hinken	Eurobaustoff	SABAG Biel/Bienne AG	\N	Biel	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2328	excel-import-user	import@system.com	Guido Hinken	151195	Rogger Fasteners AG	\N	Grossaffoltern	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2329	excel-import-user	import@system.com	Guido Hinken	101239	bernaTech GmbH	\N	Bern	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2330	excel-import-user	import@system.com	Guido Hinken	109498	BBT	\N	Bösingen	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2331	excel-import-user	import@system.com	Guido Hinken	Eurobaustoff	BAUMAT AG	\N	Wichtrach	2025-06-18	Tour Gebeit Schweiz für KW 27 geplant	Nachfassen	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2332	excel-import-user	import@system.com	Guido Hinken	Eurobaustoff	Terwey	\N	Nordhorn	2025-06-19	Angebot 6 mtr. Heller	\N	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2333	excel-import-user	import@system.com	Jörg Priebe	101306	WorkShop Nagel	Christian Nagel	Berlin	2025-06-16	Keil Juni Kalender Aktion 10+1 auf alle Meißel; Heller Kalenderaktion 10+1 auf alle SDS-plus;  \nHeller Tools Artikel Meißel, Kreissägblätter, …. * Intern ab 2500.- Heller 10% einmalig nur im Juni möglich*	\N	A	4336.64	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2335	excel-import-user	import@system.com	Jörg Priebe	103073	Capital Baustoffe 	Frau Weithe, Hr.Janosch	Berlin	2025-06-16	doppelten Auftragswert Rest ca. 772,73, KW 26 Warenrückn. KW 26, separates Angebot Separater Sonderauftrag im Monat Juni ab netto € 2500.- minus 10% Sonderrabatt.\nBestellung / Lieferung KW 26\n	\N	A	\N	2500.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2336	excel-import-user	import@system.com	Jörg Priebe	102978	BHG Wittsock	Hr. Engelhardt	Wittstock	2025-06-17	Präsentation.- und Verkaufskonzept, Neuheiten, … Präsentationumbau, Erweiterung (Metabo)/ Angebot top_Seller/Eurobaustoff Formun JA Besuch  bei G.H. ….eventuell Komplettumbau Eurobaustoffe Ende 4.Q25	\N	B	\N	\N	8	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2337	excel-import-user	import@system.com	Jörg Priebe	106228	Gebr. Fürstenberg Standort Rathenow	Herr Bertz	Rathenow	2025-06-18	Rest doppelten Auftragswert hiermit erledigt; Neuheiten Diamanttechnik, Schleifen, Kondition 45/63% Angebot 3x Ersteinlagerungsauftrag - 10% (keine Warenrücknahme) genehmigt G.H. 	\N	B	2060.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2338	excel-import-user	import@system.com	Jörg Priebe	103148	Bauking Berlin-Brandenburg GmbH, Standort Potsdam	Oliver Schütze	Potsdam	2026-06-18	Sonderaktion einmaliger, interne Promoaktion -6%; darf keine separaten Aufttrag über 2500.- setzten, Zentralanweisung	\N	A	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2339	excel-import-user	import@system.com	Jörg Priebe	108045	Strauch & Böttcher	Herr Strauch	Gröden	2026-06-18	Angebotserstellung (Eurobaustoffe) 1x 1x1,6x0,47 Hellerwand Bohrer; dito Diamanttechnik gegen Disc , Finale Entscheidung 30.05.26	\N	B	\N	5929.63	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2340	excel-import-user	import@system.com	Jörg Priebe	103152	Bauking Dahlewitz Hoppegaren 	Frau Wendt	Dahlewitz	2025-06-18	1m Wand (Makita raus) ja, Finale Besprechnung 30.06.25	\N	B	\N	4946.14	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2341	excel-import-user	import@system.com	Marcel Bornemann	103831	Murjahn	Herr Burmeister 	Mölln	2025-06-16	Bestseller Flyer und Stepstar Frühbezug angesprochen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2342	excel-import-user	import@system.com	Marcel Bornemann	107507	Hass & Hatje	Herr Steffen	Ratzeburg	2025-06-16	Erweiterung Kreissägeblätter besprochen 	Angebot erstellen HKS Classic	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2343	excel-import-user	import@system.com	Marcel Bornemann	104052	Bauxpert Dittmer	Frau Bruhn	Lütjenburg	2025-06-16	Bestseller Flyer und Stepstar Frühbezug angesprochen	Nachfassen Aktionen 	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2344	excel-import-user	import@system.com	Marcel Bornemann	100708	Richter Baustoffe	Herr Büttner	Heiligenhafen	2025-06-16	Bestseller und Stepstar sowie Pennerliste und Umbau im laufe des Jahres 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2345	excel-import-user	import@system.com	Marcel Bornemann	101525	Richter Baustoffe	Herr Wendlandt	Burg auf Fehmannn	2025-06-16	Staepstar und HKS Classic so wie Bestseller flyer besprocehn	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2346	excel-import-user	import@system.com	Marcel Bornemann	100318	Jacob Cement	Herr Lewe	Lübeck	2025-06-17	Einrichtungs vorbereitung Trennen Schleifen Neune Wand Modulkteile 1 Meter und Wand jetzt 1,25 m 	Donnerstag ist die Ware dort und dann Einrichten	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2347	excel-import-user	import@system.com	Marcel Bornemann	108690	Jacob Cement	Herr Mundt	Greifswald	2025-06-17	Komunikationsleisten nachstecken bei Einrichtung gefehlt 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2348	excel-import-user	import@system.com	Marcel Bornemann	108693	Jacob Cement	Herr Sanow	Neustrelitz	2025-06-17	Angebot Trennen Schleifen besprochen 	Termin für Umbau wird ca 15.7.25	A	\N	870.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2349	excel-import-user	import@system.com	Marcel Bornemann	108672	Jacob Cement/ Eurobaustoffe	Herr Kruse Herr AGGE	Groß Nemerow	2025-06-17	Gespräch über Schulungen und mögliche Erweiterungen uín der Gruppe Jacob Cement . Eurobaustoff berater Herr Kruse auf Umbau möglichkeiten in der Eurobaustoff Gruppe befragt und AP bekommen 	Termin Flensburg	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2350	excel-import-user	import@system.com	Marcel Bornemann	108678	Jacob Cement	Herr Schalk	Neubrandenburg	2025-06-18	Gespräch über Angebot Trennen Schleifen 	Nachfassen 	A	\N	870.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2351	excel-import-user	import@system.com	Marcel Bornemann	104368	Handelshof Vorpommern	Herr Graf	Grimmen	2025-06-18	Rückführung Nulldreher aus der Gruppe gesichtet und auf wiedereinlagerung sortiert .	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2352	excel-import-user	import@system.com	Marcel Bornemann	106368	Jacob Cement 	Frau Hering	Ribnitz Damgarten	2025-06-18	Einrichtung Trennen Schleifen und Doppelmodul 4 Power 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2353	excel-import-user	import@system.com	Marcel Bornemann	100318	Jacob Cement	Herr Lewe	Lübeck	2025-06-19	Aufbau Trennen Schleifen 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2354	excel-import-user	import@system.com	Marcel Bornemann	105443	Jacob Cement 	Herr Heyden	Schwerin	2025-06-19	Angebot Umbau Trennen Schleifen besprechen	\N	A	\N	970.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2355	excel-import-user	import@system.com	Marcel Bornemann	107418	Rudolf Sievers 	Herr Rätz	Hagenow	2025-06-19	Bestseller und Stepstar vorgestellt 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2356	excel-import-user	import@system.com	Marcel Bornemann	102836	Richter Baustoffe	Herr Drebenstadt	Hagenow	2025-06-19	Dispo mit Kunden MDE Bestseller und Stepstar vorgestellt und über die Fachgruppe verteilt 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2357	excel-import-user	import@system.com	Marcel Bornemann	102750	Büro Hamburg	Herr Bornemann	Hamburg	2025-06-20	Rteamsmeeting Bericht Angebot vorbereitung nächste Woche 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2358	excel-import-user	import@system.com	Steve Bell	109739	Diaquip	Ki Mary	Stockport	2025-06-16	Literature rebar cutter promotion	\N	B	\N	550.00	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2359	excel-import-user	import@system.com	Steve Bell	108126	PAM	Simon, Steve	Wigan	2025-06-16	Increase sales, gap analysis	Pricing , Con stock AV?	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2360	excel-import-user	import@system.com	Steve Bell	100758	Express Electrical	Terry	Stockport	2025-06-16	Branch visit, quiet using Heller	MS to follow up	B	\N	250.00	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2361	excel-import-user	import@system.com	Steve Bell	108721	C Fix	Karl	Chadderton	2025-06-18	Trijet and stock enquiry	\N	B	700.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2362	excel-import-user	import@system.com	Steve Bell	103406	MMR	Wayne	Heydock	2025-06-18	NMBS agree to move invoicing	MS to follow up	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2363	excel-import-user	import@system.com	Steve Bell	109919	JMC	Kevin	Teams	2025-06-19	10+1 sds back orders, stock order,GAP	Visit Aug / Sept	A	25000.00	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2364	excel-import-user	import@system.com	Steve Bell	107751	Mark Up	Kazim	Manchester	2025-06-19	quiet, stock order	\N	A	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2383	excel-import-user	import@system.com	Paulo Santos	109149	Millcot Tools	Tim 	Maldon	2025-06-16	Regular Visit, Promo Rebar	Send information	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2365	excel-import-user	import@system.com	Martin Palme	103214	ZI-TECH TH	Volker, Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-06-20	Gespraech mit Volker Braun, Economy ist im Moment sehr stark am straucheln, innerpolistischer Konflikt wegen Grenzstreit mit Cambodia und auch ruecklaeufigen Touristenzahlen, innerpolitische Probleme, Regierung strauchelt ebenfalls, hohe private Verschuldung und Budget bereits mitte des Jahre ausgereitzt. Man muss auch sehen, wie der Konflikt im mittleren Osten hier zur Economy beitraegt, hoehere Oelpreise sind sicherlich nicht hilfreich. Neue kleine Luftfracht Bestellung am Dienstag erhalten. AB 10.0K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Anfang Juli Angebot fuer 10 % fuer 15K EUR Bestellwert als Juli Promotion	A	1900.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2366	excel-import-user	import@system.com	Martin Palme	151242	Majjatra INDO	Gunawan, Lili	Mail, Messenger	2025-06-20	Fragt an, wann die Muster fuer die China Bohrer versendet werden. Bestellung von letzter Woche bereits ende letzter Woche ausgeliefert.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2367	excel-import-user	import@system.com	Martin Palme	109842	Hept SK	Hr. Bong	Mail	2025-06-20	Kunde erhaelt einen Regierungskredit, welcher fruehestens in 10 Tagen, spaetestens aber in 3 Wochen ausgezahlt wird. Er kann eine neue Bestellung senden, damit diese im System ist, diese wird aber blockiert, bis der Zahlungseingang zu verzeichnen ist. Damit stellen wir sicher, dass er nach 3 Monaten ohne Lieferung dann schnell wieder neue Ware erhaelt, um Umsatz zu machen. Der Rueckstand kann dann sofort nach Zahlungseingang ausgeliefert werden. AB 13.8K EUR	Naechste Woche nachhaken	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2368	excel-import-user	import@system.com	Martin Palme	100509	Iccons AUS	Phil R., Francesco M	Tel., Mail	2025-06-20	Weiteres Gespraech mit Francesco, wie Situation im Management aufgenommen wurde, weitere Gespraeche werden hier folgen. Habe ihn unterrichtet, dass wir uns um einen 2. Distributor ausschau halten. Wenn es hier zu einer Entscheidung fuer einen direkten Konkurrenten kommt, wie z.B. Synergy Construction (auch Kunde von Iccons), dann kann die Zusammenarbeit etwas abkuehlen aber bei Amor oder PlumBoss gibt es keine direkten Ueberschneidungen. Eine schriftliche Stellungnahme wird in den naechsten 2 Wochen kommen. Anfrage bezueglich Ueberlaenge fuer den Duster Expert & China Bohrer, Preisliste nochmals gesendet.  Bestellung ueber 11.8K EUR erhalten. AB 12K EUR	Naechste Gespraeche nach weiteren Diskussionen bei Iccons	A	11800.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2369	excel-import-user	import@system.com	Martin Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-06-20	Gleiche Probleme wie Mach Tools, 2. Quartal stark ruecklaeufig, hoffen auf das 3. Quartal, dass hier wieder mehr Nachfragen und Projekte kommen. Lagerbestand noch vorhanden aber es werden verschiedene Durchmesser benoetigt und eine Bestellung ist in Vorbereitung.  MD im Moment auf Urlaub bis Ende Juni, die Bestellung soll dann, wenn vom MD bestaetigt Anfang Juli kommen.	Anfang Juli nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2370	excel-import-user	import@system.com	Martin Palme	100998	RFM MAL	Khiam, Raymond	Mail	2025-06-16	Warten auf die Muster der China Produkte. Forecast Abfrage fuer Juni.	Besuch einplanen nach meinem Urlaub	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2371	excel-import-user	import@system.com	Martin Palme	150039	Bordo AUS	Jerry, Yvonne	Mail	2025-06-16	Kunde geht mehr auf chinesische Produkte. Hier muessen wir abwarten, ob der Kunde weiterhin bei uns bestellen wird, wegen der CN Bohrer, die er dann direkt vom CN Lieferanten beziehen wird. Forecast Abfrage fuer Juni.	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2372	excel-import-user	import@system.com	Martin Palme	151141	Powerpac NZ	Jay, Patrick	Mail	2025-06-16	Keine Bestellung in Kuerze, da noch Lagerbestand ud eine Lieferung unterwegs	Naechste Woche nachhaken, wenn keine Bestellung kommt	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2373	excel-import-user	import@system.com	Martin Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-06-17	Trijet Ultimate mit 8 Wochen Lieferzeit ist nicht gut, auch nach Pruefung ergab sich kein besserer Liefertermin!! Internet Lead an den Kunden gegeben und besprochen.	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2374	excel-import-user	import@system.com	Martin Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-06-20	Interesse weiterhin fuer den Tapcon Bohrer, Angebot (verschiedene Verpackungsvarianten) gesendet, Prototyp ist noch nicht fertig gestellt, wird erst erfolgen, wenn das Interesse beim Kunden weiterhin fuer Made in Germany besteht. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2375	excel-import-user	import@system.com	Martin Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-06-17	Nach Gespraechen hat Roger Black (Inhaber) seiner Sourcing Abt. geschrieben, dass er die volle Heller Range bestellen moechte. Es wird in Kuerze eine grossere Bestellung erefolgen. Der Uebergang von Keil zu Heller wird also schneller erfolgen. Unser Trijet Ultimate ist als bester Bohrer im Markt gepiesen worden. Warten auf die 2. Heller Muster Lieferung (Termin 18.06. zur Auslieferung), da 4 Wochen Unterschied zur ersten Lieferung. AB 1.8K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist vom Kunden angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2376	excel-import-user	import@system.com	Martin Palme	105577	Mach Tools PH	Nancy. Kenneth & Karlo Yu	Tel., Mail, Messenger	2025-06-17	Erstes Quartal war sehr gut, im 2. Quartal sind die Zahlen ruecklaeufig, hat auch etwas damit zu tun, dass dort PM Wahlen waren. Hoffen, dass das 3. Quartal dann auch wieder in die Zahlen vom 1. Quartal gehen. AB 0K EUR wurden berechnet.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2377	excel-import-user	import@system.com	Martin Palme	151317	Steel & Tube NZ	Aries	Mail	2025-06-17	Markt ist im Moment sehr ruhig und Lagerbestand noch vorhanden. Bestellung wahrscheinlich erst 2. Jahreshaelfte	Naechste Woche nachhaken, wenn keine Bestellung kommt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2378	excel-import-user	import@system.com	Martin Palme	100501	CSH SIN	Eric	Mail, Messenger	2025-06-18	26.05.2025 Anfrage Trijet Ultimate 16 x 1200 x 1340 mm, nicht lieferbar bis Ende Juli. Eigenfertigung 8 Wochen Lieferzeit, Auftrag nicht bekommen, Kunde wird Zukauf beim Wettbewerber machen.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2379	excel-import-user	import@system.com	Mark Smethurst	100761	Leigh Timber Supplies	Billy	Leigh	2025-06-19	meeting . check on tool bars. Stock order.	quote for cutting business.	C	300.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2380	excel-import-user	import@system.com	Mark Smethurst	107752	Avantifix	Adam	Leeds	2025-06-20	Meeting. Collect samples. Drop off warranties.	Warranties.	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2381	excel-import-user	import@system.com	Paulo Santos	108750	A C Fixings Ltd.	Sean	Chelmsford	2025-06-16	Regular visit, order	Keep information, Moving to NMBS	A	900.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2382	excel-import-user	import@system.com	Paulo Santos	108987	Essex Fasteners	Vince	Chelmsford	2025-06-16	Stop Buying since Covid, Bosch now	Visit every 3 months	C	\N	\N	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2385	excel-import-user	import@system.com	Paulo Santos	109029	S.E. Apex Ltd.	Andy	South End	2025-06-16	Customer to vist another time	Visit again 	B	\N	\N	12	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2386	excel-import-user	import@system.com	Paulo Santos	103244	Adamantem Products Ltd.	Tim Johnson	London	2025-06-17	Regular visit, Promo Rebar Breakers, Hss sets	Send by email the offer	C	\N	\N	12	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2387	excel-import-user	import@system.com	Paulo Santos	103246	IQ Builders Merchant Ltd.	Stewart	London	2025-06-17	Stoped buying, Possible move to NMBS	\N	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2388	excel-import-user	import@system.com	Paulo Santos	106422	Macey Industrial Fixings	Keith Macey	London	2025-06-17	Stop Buying, didn’t give any reason	Visit in 2 months	C	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2389	excel-import-user	import@system.com	Paulo Santos	107928	Stainless Steel Centre	Gary/Keith	Plymouth	2025-06-18	Meet with Gary/Keith, asked 90 days to pay 	Maintain	B	1700.00	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2390	excel-import-user	import@system.com	Paulo Santos	109950	SCP Building Products	Lester Wallis	Devon	2025-06-18	Changed to DART 2 Years ago, Happy	Keep sending Information	B	\N	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2391	excel-import-user	import@system.com	Paulo Santos	8621	Phoenix Tools & Diamonds	Barry Moore	Devon	2025-06-19	Meet Barry, Order, Talk about the new drill bits	Information about Drill bits	A	1400.00	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2392	excel-import-user	import@system.com	Paulo Santos	5836	Kernow Fixings	Aaron Pisgrove	Devon	2025-06-19	Talk about Rebar Promo, new catalogues	Send always information by email	B	200.00	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2393	excel-import-user	import@system.com	Paulo Santos	7941	FWB South West Ltd.	Steve White	Truro	2025-06-19	Regular Visit	Talk to Head office about Hss Sets	B	250.00	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2394	excel-import-user	import@system.com	Paulo Santos	7964	Duchy Fasteners Ltd.	Chris	Devon	2025-06-19	Stop Buying, Financial situation	Keep in touch 	C	\N	\N	6	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2395	excel-import-user	import@system.com	Paulo Santos	100742	Pegasus Kitchens 	Bobby Vekaria	London	2025-06-20	Phone call, Order by email	Visit next week 	C	198.00	\N	1	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2396	excel-import-user	import@system.com	Paulo Santos	107780	Western Bolt & Eng.  Ltd.	Julie David	Tauton	2025-06-20	Order by email	Visit next  	C	400.00	\N	6	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2397	excel-import-user	import@system.com	Egon Jesse	109199	Mapeco	\N	Wommelgem	2025-06-16	Versuch zu neu aufbau	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2398	excel-import-user	import@system.com	Egon Jesse	???	Alders	\N	Pelt	2025-06-17	Neue kunde Besuch(Keil)	Ehrste Auftrag folgt	C	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2399	excel-import-user	import@system.com	Egon Jesse	106464	Ferney inspirience day	\N	\N	2025-06-18	\N	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2400	excel-import-user	import@system.com	Martin Palme	103214	ZI-TECH TH	Volker, Anucha, Rorkchai	Thailand, Mail, Tel. & Messenger	2025-06-27	Innerpolistischer Konflikt wegen Grenzstreit mit Cambodia spitzt sich zu, grosse Demo in Bangkok am 28.06. Starke ruecklaeufige Touristenzahlen. Regierung strauchelt, hohe private Verschuldung und Budget bereits mitte des Jahre ausgereitzt. Man muss auch sehen, wie der Konflikt im mittleren Osten hier zur Economy beitraegt, hoehere Oelpreise sind sicherlich nicht hilfreich. Neue kleine Luftfracht Bestellung am 23.06. erhalten. AB 14.1K EUR	Fast taeglich in Kontakt mit dem Kunden. Im Anfang Juli Angebot fuer 10 % fuer 15K EUR Bestellwert als Juli Promotion	A	4324.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2401	excel-import-user	import@system.com	Martin Palme	151242	Majjatra INDO	Gunawan, Lili	Mail, Messenger	2025-06-23	Fragt an, wann die Muster fuer die China Bohrer versendet werden. China Bohrer sind mit Sheh Kai versehen und diese koennen wir nicht versenden.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2402	excel-import-user	import@system.com	Martin Palme	150348	Wakai JP	Iwawaki, Nene	Mail	2025-06-27	Angebot gesendet. Endkunde hat weiterhin noch nicht entschieden, fragt nach Spezialrabatt an, habe 3 % gegeben. Pruktion fuer bestehende Bestellung wieder nach hinten geschoben, was fast bei jeder Bestellung der Fall ist und wirklich nicht gut ist bei japanischen Kunden. AB 12.8K EUR	Naechste Woche wieder nachhaken, wenn keine Bestellung kommt	A	\N	3500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2403	excel-import-user	import@system.com	Martin Palme	109842	Hept SK	Hr. Bong	Mail	2025-06-26	Kunde hat die Ueberweisung fuer din gesamten offenen Zahlungsbetrag am Doonerstag getaetigt. Eine neue Bestellung ist eingetroffen und eine weitere noch in Bearbeitung und wird in den naechsten Tagen kommen. Der Rueckstand kann dann sofort nach Zahlungseingang ausgeliefert werden. AB 24K EUR	Naechste Woche nachhaken	A	8649.48	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2404	excel-import-user	import@system.com	Martin Palme	100509	Iccons AUS	Phil R., Francesco M, Pierre M.	Tel., Mail	2025-06-26	Weiteres Gespraech mit Francesco, wie Situation im Management aufgenommen wurde, weitere Gespraeche werden hier folgen. Habe ihn unterrichtet, dass wir uns um einen 2. Distributor ausschau halten. Wenn es hier zu einer Entscheidung fuer einen direkten Konkurrenten kommt, wie z.B. Synergy Construction (auch Kunde von Iccons), dann kann die Zusammenarbeit etwas abkuehlen aber bei Amor oder PlumBoss gibt es keine direkten Ueberschneidungen. Eine schriftliche Stellungnahme wird in den naechsten 2 Wochen kommen. China Bohrer werden nicht bei uns bestellt, da der bisherige Lieferant die besseren Preise zu haben scheint. Anfrage ueber laengere Duster Expert (900, 1100 & 11200 mm) koennen produziert werden, waren bereits bei anderen Projekten schon einmnal angefragt. Der Kunde ist unterrichtet und ich warte hier auf das Feedback. AB 2.1K EUR	Naechste Gespraeche nach weiteren Diskussionen bei Iccons	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2405	excel-import-user	import@system.com	Martin Palme	151734	Cut & Break PH	Junel, Raul, Edz	Mail, Messenger	2025-06-27	Gleiche Probleme wie Mach Tools, 2. Quartal stark ruecklaeufig, hoffen auf das 3. Quartal, dass hier wieder mehr Nachfragen und Projekte kommen. Lagerbestand noch vorhanden aber es werden verschiedene Durchmesser benoetigt und eine Bestellung ist in Vorbereitung.  MD im Moment auf Urlaub bis Ende Juni, die Bestellung soll dann, wenn vom MD bestaetigt Anfang Juli kommen.	Anfang Juli nachhaken	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2406	excel-import-user	import@system.com	Martin Palme	100998	RFM MAL	Khiam, Raymond	Mail	2025-06-23	Warten auf die Muster der China Produkte. Forecast Abfrage fuer Juni.	Besuch einplanen nach meinem Urlaub	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2407	excel-import-user	import@system.com	Martin Palme	100081	BAP INDO	Reza, Dimas, Regina	Mail, Messenger	2025-06-23	Trijet Ultimate mit 8 Wochen Lieferzeit ist nicht gut, auch nach Pruefung ergab sich kein besserer Liefertermin!! Internet Lead an den Kunden gegeben und besprochen. AB 18K EUR	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2425	excel-import-user	import@system.com	Marcel Bornemann	107427	Hass & Hatje	Herr Bürger 	Rellingen	2025-06-24	Aktion Bestseller und Stepstar vorgestellt 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2487	excel-import-user	import@system.com	Gunter Diedrich	109815	SUALPE	Rafa & Chimo	Madrid	2025-06-23	Kundenreiseplan Navarra Kw-27	\N	A	3000.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2408	excel-import-user	import@system.com	Martin Palme	150033	Exacon AUS	Harvey, Jay	Mail, Messenger	2025-06-25	Interesse weiterhin fuer den Tapcon Bohrer, Angebot (verschiedene Verpackungsvarianten) gesendet, Prototyp ist noch nicht fertig gestellt, wird erst erfolgen, wenn das Interesse beim Kunden weiterhin fuer Made in Germany besteht. AB 1.5K EUR	Sehr oft in Kontakt mit Mail und Messenger.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2409	excel-import-user	import@system.com	Martin Palme	150279	Trucut NZ	Rod, Justin	Mail	2025-06-25	Habe eine neue Kalkulation erstellt und mit AV durchgesprochen und neue Preise angeboten. Kunde evaluieret den Markt, sprich mit seinen Dealer, wie die neuen Preise funktionieren wuerden. Lead time und Lieferoptionen besprochen. Werden Anfang/Mitte Juli besprechen, ob sie erneut mit uns starten.	Naechste Woche nachhaken	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2410	excel-import-user	import@system.com	Martin Palme	150052	Blacks Fasteners NZ	Roger, Marcus, Jason	Mail	2025-06-27	Eine Heller Bestellung ist in Bearbeitung und wird in den naechsten 2 Wochen bei uns eintreffen, ich hoffe daher, dass wir das lead time Problem fuer den Trijet Ultimate in den Griff bekommen, ansonsten habe ich hier ein grosses Problem, wenn der Kunde 8-10 Wochen warten muss. Der Uebergang von Keil zu Heller wird also schneller erfolgen. Unser Trijet Ultimate ist als bester Bohrer im Markt gepiesen worden. AB 0K EUR	Weitere Gespraeche fuer den Transfer Keil zu Heller, dann Besuch um alles Fix zu machen, Schulung ist vom Kunden angefordert.	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2411	excel-import-user	import@system.com	Martin Palme	105577	Mach Tools PH	Nancy. Kenneth & Karlo Yu	Tel., Mail, Messenger	2025-06-27	Erstes Quartal war sehr gut, im 2. Quartal sind die Zahlen ruecklaeufig, hat auch etwas damit zu tun, dass dort PM Wahlen waren. Hoffen, dass das 3. Quartal dann auch wieder in die Zahlen vom 1. Quartal gehen. Promotion 10/15K fuer 5/10% angeboten. AB 0K EUR wurden berechnet.	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2412	excel-import-user	import@system.com	Martin Palme	100501	CSH SIN	Eric	Mail, Messenger	2025-06-27	26.05.2025 Anfrage Trijet Ultimate 16 x 1200 x 1340 mm, nicht lieferbar bis Ende Juli. Eigenfertigung 8 Wochen Lieferzeit, Auftrag nicht bekommen, Kunde wird Zukauf beim Wettbewerber machen. Promotion 10/15K fuer 5/10% angeboten. AB 0K EUR	Im Juni/Juli Angebot fuer 10 % fuer 15K EUR Bestellwert	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2413	excel-import-user	import@system.com	Martin Palme	150267	UnionDay HK	Jason	Mail	2025-06-27	Promotion 10/15K fuer 5/10% angeboten.	evtl. In Kuerze Besuch planen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2414	excel-import-user	import@system.com	Martin Palme	100714	Sing Kee HK	Ric	Mail	2025-06-27	Kunde war bis 22.05.2025 im Urlaub. 23.05.2025 nachgefragt. Kunde wird nicht bestellen, da noch Lagerbestand. Der Kunde bestellt nur einmal im Jahr und wird bei einer naechsten Promotion im Juli/August bestellen. Promotion 10/15K fuer 5/10% angeboten.	Neue Promotion 10% fuer eine Bestellung im Juli, letzte Woche Juni anbieten.	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2415	excel-import-user	import@system.com	Pantaleo Stomeo	103138	Raiffeisen Waren GmbH	Herr Kühler	99974 Mühlhausen	2025-06-23	Allgemeiner Kundenbesuch, alles in Ordnung, Wand hatte paar Lücken aber DISPO war nicht gewünscht da diese ja über die Zentrale laufen muss. Katalog, Preisliste, aktuelle Aktion und Flyer vorgestellt und abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2416	excel-import-user	import@system.com	Pantaleo Stomeo	101205	Bauking Südwestfalen GmbH	Herr Andreas kapp	57518 Betzdorf	2025-06-24	Allgemeiner Kundenbesuch, Kunde wünschte ja alle 4-6 Wochen eine Dispo. Nachdem er aber bereits Ende Januar und Anfang März mich vertröstet hat, tat er es heute auch wieder. Wieder mal war die Begründung das man ja umlagern soll. Vor Ort waren knapp 25 Haken komplett leer und circa 20 Haken wo nur 1 Bohrer hing bei der vorhandenen 3m Präsentation. Er will sich angeblich die Tage drum kümmern. Hier ist das Thema Sortimentsbereinigung auch aktuell aber man will erstmal abwarten bis was von der zentrale kommt da man der Meinung ist das die 1zu1 Regel nicht eine einmalige Sache ist. Aktionen erneut vorgestellt aber kein Interesse	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2417	excel-import-user	import@system.com	Pantaleo Stomeo	101173	Bauking Südwestfalen GmbH	Herr Stefan Bottenberg	57290 Neunkirchen	2025-06-24	Allgemeiner Kundenbesuch, bei diesem Standort handelt es sich einen der wenigen Baukings wo wirklich alles in Ordnung ist. Die Wand ist gut gefüllt und man hat keine Reklamationen oder Beschwerden vorliegen. Aufgrunddessen das die Wand noch gut gefüllt ist, ist heute keine Dispo notwendig. Aktuelle Aktion erneut vorgestellt.	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2418	excel-import-user	import@system.com	Pantaleo Stomeo	102084	Langenbach GmbH	Herr Konstantin Leichner	57072 Siegen	2025-06-24	Allgemeiner Kundenbesuch, an der Tatsache das man mit Milwaukee und Bosch aufgestellt und damit auch sehr zufrieden ist hat sich nix geändert. Aktionen erneut vorgestellt aber aktuell kein Bedarf. Er glaubt auch nicht das eine Bestellung oder Umstellung auf Heller in naher Zukunft eine Option ist. Aktionen + Flyer vorgestellt und abgegeben	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2419	excel-import-user	import@system.com	Pantaleo Stomeo	107376	MONTTEC GmbH	Herr Contant	57072 Siegen	2025-06-24	Allgemeiner Kundenbesuch, Kunde war mir aufgefallen das er immer noch bei 0 € Umsatz ist obwohl er geplant war. Herr Contat teilte mir heute mit das es im letzten Jahr  ehrhebliche Beschwerden des Kundengab,  da er auf eine Gutschrift über 6 Monate warten musste und dementsprechend hat er sich nach alternativen Lieferanten umgeschaut wo es auch aktuell läuft und er daher nicht vor hat wieder bei Heller zu kaufen. Wie es in Zukunft aussieht kann er aktuell nicht sagen aber aktuell bleibt es so wie es ist. Katalog, Preisliste, Aktion und neue Flyer vorgestellt und abgegeben !	Immer mal wieder hinfahren wenn es neue Aktionen oder Neuheiten gibt und diese vorstellen	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2420	excel-import-user	import@system.com	Marcel Bornemann	100812	Mölders	Herr Dammann	Adendorf	2025-06-23	Gespräch über Umbau von Dewalt auf Heller besprechen der Penner Artikel und was zusätzlich Angeboten werden soll 4 Meter mit Sägen und Schleifen 	\N	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2421	excel-import-user	import@system.com	Marcel Bornemann	100541	Dübel & Bohrer 	Herr Sachau	Hamburg	2025-06-24	Auftrag Bohrer auftrag 1792,34 €	\N	B	1792.34	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2422	excel-import-user	import@system.com	Marcel Bornemann	100341	Kuroga 	Herr Reichen	Hamburg	2025-06-24	Aktion Bestseller und Stepstar vorgestellt 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2423	excel-import-user	import@system.com	Marcel Bornemann	100497	HIW	Herr Lange	Hamburg	2025-06-24	Aktion Bestseller und Stepstar vorgestellt 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2424	excel-import-user	import@system.com	Marcel Bornemann	100469	Friedrich Lange	Herr Clasen	Hamburg 	2025-06-24	Aktion Bestseller und Stepstar vorgestellt 	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2426	excel-import-user	import@system.com	Marcel Bornemann	102927	Hass & Hatje	Herr Möller 	Uetersen	2025-06-24	Trennen Schleifen wann Umstellung sattfindet , wird eingeschlichen immer wenn von Klingspoor leer wird Heller nachbestellt . 	\N	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2427	excel-import-user	import@system.com	Marcel Bornemann	100294	Hass & Hatje	Frau Hoffmann	Hitzhusen	2025-06-25	Nachfassen Umstellung Schleifen Trennen 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2428	excel-import-user	import@system.com	Marcel Bornemann	100293	Hass & Hatje	Herr Schrickel	Neumünster 	2025-06-25	Stepstar vorgestllt und Rekl Meißelbruch gesichtet . 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2429	excel-import-user	import@system.com	Marcel Bornemann	108113	C.G.Christiansen	Herr Dau	Mildstedt	2025-06-25	Aktuelle Unterlagen und Aktionen vorgestllt 	\N	A	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2430	excel-import-user	import@system.com	Marcel Bornemann	108228	Schlotfeld	Herr Melchers	Niebüll	2025-06-25	Angebot Trennen 11 Dose 100 STk. 10+1 und Bits Staepstar und Bestseller Aktion vorgestellt 	Angebot Nachfassen 	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2431	excel-import-user	import@system.com	Marcel Bornemann	104051	Bauxpert Christiansen	Herr Martensen	Niebüll	2025-06-26	Geplanter Umbau der Präsentation und ergänzung Trennen Schleifen s wie Bits von makita zu Heller .	Planung Umbau wenn Herr Petersen wirde im Hause ist 	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2432	excel-import-user	import@system.com	Marcel Bornemann	103099	C.G.Christiansen	Herr Agün	Flensburg	2025-06-26	2,5 D Schiene für Präsenattion Bits und Bohrkronen im Tresenbereich angebracht 	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2433	excel-import-user	import@system.com	Marcel Bornemann	101100	Detlef Paulsen	Herr Erzinger 	Flensburg	2025-06-26	Aktion Stepstar und Bestseller vorgestellt 	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2434	excel-import-user	import@system.com	Marcel Bornemann	108672	Jacob Cement 	Herr Agge/Thomsen	Flensburg	2025-06-26	Anlegen von Artikeln HKS Classic und Stepstar für die JC Gruppe gespräch über mögliche Umstellung Diamant ( EK verband Consortis ) GH 	Umstellung Trennen Schleifen bei einigen Niederlassungen fertigstellen .	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2435	excel-import-user	import@system.com	Marcel Bornemann	102422	Bauxpert Vierk	Herr Ehlers	Sörup	2025-06-26	Aktionen vorgestellt und Aktuelle unterlagen .	Nachfassen wann Umbau stattfindet 	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2436	excel-import-user	import@system.com	Marcel Bornemann	108776	Siemsen	Frau Ohlert 	Eckernförd 	2025-06-26	Standort wird umgebaut , Planung nihct fertig gespröche folgen neuer AP , Leiter Einzelhandel . Kauft momentan nicht um bestände zu reduziern für den Umzug des Fachhandels Gespräch mit Herrn Dabelstein HAGEBAU über die Situation ( Schwierig da die Nachfolge Frau Siemsen Junior angetretten ist ) aussage Herr Dabelstein .	Termin mit Leiter Einzelhandel zwecks Umbau beim nächtsen Besuch	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2437	excel-import-user	import@system.com	Marcel Bornemann	102750	Büro Hamburg	Herr Bornemann	Hamburg	2025-06-27	Teams, Berichte Planung Angebote Hotel buchen .	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2438	excel-import-user	import@system.com	Jörg Priebe	103073	Capital Baustoffe 	Herr Janosch	Berlin	2025-06-23	4872,03 Euro +Rest netto € 1033,32 – 5% = 984,11 ok./ doppelten Auftragswert ok Rücknahme 2.928,07netto € , Aktionsauftrag Juli ab 2500.- -10% kommt mit Lager und Aktikelneulistung Meisse, KS, Stich. und Säbelsäge	\N	A	\N	1033.32	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2439	excel-import-user	import@system.com	Jörg Priebe	101612	Linnenbecker GmbH & Co.KG 	Herr Wellnitz	Berlin	2025-06-24	Linnenbecker, Hellerwand PowerTower bauen	Abbruch, benötigen Tegowand 1m	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2440	excel-import-user	import@system.com	Jörg Priebe	101612	Linnenbecker GmbH & Co.KG 	Herr Wellnitz	Berlin	2025-06-26	Thekentag 8.0-12.0; Aufbau Tegowand, VK-Wand 1x2mx1mx0,47	Teilfertigstellung, div. Harware fehlt 7er Lochhaken, ….	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2441	excel-import-user	import@system.com	Jörg Priebe	109163	BHG Luckau Handelszentren	Herr Bunk	Lübben	2025-06-26	Schleifen Trenn, Option Diamant gegen Samedia	\N	B	\N	1937.28	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2442	excel-import-user	import@system.com	Jörg Priebe	101322	Possling HA	Herr Thomasn Hentrich	Berlin	2025-06-26	Listung, Bestellung Allmat Pro Modul, plus Lager, Rücknahme 3740 Allmatt doppelten Auftragswer ja, ohne Einlagerungsgeb. Laut G.H. ok.	\N	A	670.08	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2443	excel-import-user	import@system.com	Jörg Priebe	108954	Possling FOD	Herr Thomasn Hentrich	Berlin	2025-06-26	Listung, Bestellung Allmat Pro Modul, plus Lager, Rücknahme 3740 Allmatt doppelten Auftragswer ja, ohne Einlagerungsgeb. Laut G.H. ok.	\N	A	789.58	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2444	excel-import-user	import@system.com	Jörg Priebe	101323	Possling LA	Herr Thomasn Hentrich	Berlin	2025-06-26	Listung, Bestellung Allmat Pro Modul, plus Lager, Rücknahme 3740 Allmatt doppelten Auftragswer ja, ohne Einlagerungsgeb. Laut G.H. ok.	\N	A	572.54	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2445	excel-import-user	import@system.com	Yasir Angar	109894	Suomen Kiinnikekeskus OY	Jani Havukainen	FI	2025-06-26	Trijet 11er  Packs angeboten	10% Extrarabatt anbieten	A	\N	5000.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2446	excel-import-user	import@system.com	Yasir Angar	101468	HOMBERGER S.P.A.	Luca Boscarino	IT	2025-06-26	Sägeblätter 100 Stk Packs angeboten	Neues Angebot für OMNIA	A	\N	10000.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2447	excel-import-user	import@system.com	Yasir Angar	106912	G & T Imports Ltd.	Joanna Galea  	MT	2025-06-23	Umsatzrückstand zu Plan  -  Hat bestellt, Kunde besucht	Angebot Allmat Pro	B	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2448	excel-import-user	import@system.com	Yasir Angar	100852	ECONOMOTECHNIKI S.A.	Anne Laure	GR	2025-06-26	Umsatzrückstand zu Plan  - Angebot abgegeben	ggfs: 10% Extrarabatt anbieten	B	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2449	excel-import-user	import@system.com	Yasir Angar	150332	G. Vella & Sons Limited	Patrick Vella	MT	2025-06-23	Umsatzrückstand zu Plan  -  Hat bestellt, Kunde besucht	Angebot Allmat Platinum und HSS Bundle	B	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2450	excel-import-user	import@system.com	Andreas Stockbauer	107685	Bauzentrum Otto Zillinger	Hr. Hies	Osterhofen	2025-06-23	Aktionen und Frühbezug vorgestellt, wegen Fusion König/Schierer nachgefragt damit Sortiment auch safe ist, Umbau und Planung werden lt. Hr. Hies gerade koordiniert, Einladungen folgen. Lieferanten von denen man sich trennt werden aktuell zu Gesprächen eingeladen. Heller bleibt definitiv drin und wird vorraussichtlich im Baustein wachsen	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2451	excel-import-user	import@system.com	Andreas Stockbauer	100452	Auer Landshut	Hr. Schneidenbach	Landshut	2025-06-23	Modulwandpflege, Aktionen nach wie vor von der GL nicht gewünscht da immer noch altbestand aus der Berglehner Aktion da ist	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2452	excel-import-user	import@system.com	Andreas Stockbauer	102148	Auer Baustoffe GmbH & Co. KG	Hr. Moser	Dorfen	2025-06-23	Aktionen und Neuprodukte	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2453	excel-import-user	import@system.com	Andreas Stockbauer	150392	Josef Attenberger GmbH	Fr. Musielik	St. Wolfgang	2025-06-23	Fr. Musielik macht diese Bestellungen nicht mehr, gibt aber die Bedarfsprüfung an die Kollegin weiter. Frau Höcherl meldet sich	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2454	excel-import-user	import@system.com	Andreas Stockbauer	101347	Baustoff Union GmbH	Hr. Götz/ Hr. Heyn	Nürnberg Hafen	2025-06-24	Umbaubesprechung und festlegung der neuen Module, Erweiterung auf 3 Meter im Sichtbereich	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2455	excel-import-user	import@system.com	Andreas Stockbauer	101166	BAUSTOFF UNION GmbH	Hr. Brehm	Langenzenn	2025-06-24	Nachfassen Angebot, aktuell wir Artikelanlage gemacht, Bestellung sollte KW27 folgen, Umbau Ende Juli	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2456	excel-import-user	import@system.com	Andreas Stockbauer	101241	Eisenhandel Prell GmbH + Co.KG	\N	Schwabach	2025-06-24	Aktionen, Neuprodukte	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2457	excel-import-user	import@system.com	Andreas Stockbauer	108147	BU Ansbach	Hr. Lastinger	\N	2025-06-25	Neueinrichtung	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2458	excel-import-user	import@system.com	Andreas Stockbauer	150601	GIMA GmbH & Co. KG	Hr. von der Sitt	Herrieden	2025-06-25	möchte nicht zu Heller wechseln, druckt sich die Einleger der Keiltaschen selber mit eigenem Logo und macht so ein "Private Label Light", ist Eurobaustoffmitglied und hat deutschlandweit Niederlassungen, arbeitet aber auch mit Keil nur in Herrieden. Andere Standorte haben unterschiedlich grosse bzw. teilweise auch gar keine Fachmärkte. Hier wird mit HaWe als Sortimenter gearbeitet.	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2459	excel-import-user	import@system.com	Andreas Stockbauer	107859	Baustoff Union GmbH & Co.KG	Hr.Gsinn	Grafing	2025-06-26	Aktionen, Neuprodukte, Modulwandpflege, Dispo erfolgt durch Mitarbeiter	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2460	excel-import-user	import@system.com	Andreas Stockbauer	103072	Maschinen Stockert	\N	Hohenbrunn	2025-06-26	Aktuelle Aktionen, Neuprodukte, Unterlagen	\N	B	\N	\N	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2461	excel-import-user	import@system.com	Andreas Stockbauer	105922	Weha GmbH	Hr. Nagy, Frau Bassi	Königsbrunn	2025-06-26	Termin, Kunde möchte Angebotsflyer erstellen, Aktionen und Neuprodukte besprochen, hat Diamant in PL, Hr. Nagy bespricht es im ADM Kreis und meldet sich wegen Angebot	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2462	excel-import-user	import@system.com	Jens Werner	105533	Driltec, LLC.	Leslie Berch	\N	2025-06-23	nachhaken offene Zahlung	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2463	excel-import-user	import@system.com	Jens Werner	106994	wolfcraft GmbH	Manuel Kreuer, Thomas Deuster	\N	2025-06-27	Lieferrückstände besprechen	Lieferfähigkeit verbessern	A	10000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2464	excel-import-user	import@system.com	Jens Werner	107038	ABRABORO Kft	Markus Zimmermann	\N	2025-06-25	Abraboro hat einen neuen Großkunden gewonnen	Auftrag über 50k € erhalten	A	52000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2465	excel-import-user	import@system.com	Jens Werner	101358	CRETEC CO. LTD	Dongdal	\N	2025-06-27	Telefonmeeting mit Dongdal wegen 2. Auftrag	100k € Auftrag erwartet 	B	30000.00	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2466	excel-import-user	import@system.com	Jens Werner	151804	SAS Prodesca	Emmanuel Salomez	\N	2025-06-24	Angebot für Spanien	Warten auf Feedback	A	50000.00	50000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2467	excel-import-user	import@system.com	Jens Werner	150336	Van Roij Fasteners Europe B.V	Richard Munsters	\N	2025-06-24	Lieferrückstände besprechen	Lieferperformance verbessern	A	52000.00	50000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2468	excel-import-user	import@system.com	Jens Werner	109571	MÜLLER & CO.	Sebastian Henke	\N	2025-06-26	neues Angebot zugesendet, um Kunden zu halten	Warten auf Feedback	A	\N	30000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2469	excel-import-user	import@system.com	Jens Werner	100128	FE ZEVIJ BV, COOP GRHANDVER ZEVIJ	Roy van Gestel	\N	2025-06-27	Nachfassen 4 Schneider Projekt	Termin nach Test 4-Schneider vereinbaren	A	50000.00	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2470	excel-import-user	import@system.com	Jens Werner	100719	A.S.F. Fischer BV	Dominic Bravenboer	\N	2025-06-26	Termin vor Ort / Nächste Schritte besprochen	Ausarbeiten der Angebote	B	\N	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2471	excel-import-user	import@system.com	Jens Werner	151795	Seojeon MJ	Heekyung	\N	2025-06-24	Angebot über 230 + 180mm Trennscheiben	nachhaken	B	\N	100000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2472	excel-import-user	import@system.com	Jens Werner	151725	Unitech Isam Kabbani & Partners	Mohammad Al Najjar	\N	2025-06-26	Termin per Teams vereinbaren	nachfassen	A	\N	100000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2473	excel-import-user	import@system.com	Jens Werner	100848	IRONSIDE	Thomas Verdy	\N	2025-06-25	Gespräch anfangs positiv. Zusage 11 von 12 Miotgliedern für Wechsel von Diager zu TCG. Durch Aktivitäten mit Marke Heller beim Mitglied Tout Faire in Frankreich wird die Entscheidung auf Ende Mai vertagt. Ohne diese Aktivität hätten wir heute die Zusage für Erstbelieferung im Okt 2025 erhalten	nachfassen\n	A	\N	1200000.00	\N	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2474	excel-import-user	import@system.com	Jens Werner	106340	Hagebau Butler	Andreas Pellny	\N	2025-06-25	Butler Angebot versendet	Nachhaken 	A	\N	150000.00	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2475	excel-import-user	import@system.com	Jens Werner	100909	Hoffnung Korea	Jay Kim	\N	2025-06-24	Nachfassen offene Rechnungen	follow up	A	85000.00	30000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2476	excel-import-user	import@system.com	Egon Jesse	106552	Voskamp	\N	Almelo	2025-06-24	Angebot 4 Power und Prefix besprochen	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2477	excel-import-user	import@system.com	Egon Jesse	106825	Voskamp	\N	Enschede	2025-06-24	Besuch	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2478	excel-import-user	import@system.com	Egon Jesse	105797	Ottenhof	\N	Oldenzaal	2025-06-24	Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2479	excel-import-user	import@system.com	Egon Jesse	100029	Boerenhandel	\N	Boechout	2025-06-25	Auftfrag	Ehrste Auftrag folgt	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2480	excel-import-user	import@system.com	Egon Jesse	109307	Maldoy	\N	st Kathelijne	2025-06-25	Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2481	excel-import-user	import@system.com	Egon Jesse	109353	Marco	\N	Herselt	2025-06-25	Auftrag	\N	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2482	excel-import-user	import@system.com	Egon Jesse	107499	de Schuur	\N	Kootwijkerbroek	2025-06-26	Auftrag	\N	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2483	excel-import-user	import@system.com	Egon Jesse	103232	Isero 2x	\N	\N	2025-06-26	Besuch	\N	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2484	excel-import-user	import@system.com	Guido Hinken	Verband	EDE	Herr Platte	\N	2025-06-24	Werbung EDE Premium Glasfaser / Photovolttaik / Wärmepumpe	Vorschläge machen	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2485	excel-import-user	import@system.com	Guido Hinken	Verband	Nordwest Kuppeltreffen	Herr Neynaber	Dortmund	2025-06-25	Come together	\N	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2486	excel-import-user	import@system.com	Guido Hinken	Verband	Nordwest Kuppeltreffen	Herr Neynaber	Dortmund	2025-06-26	Messe	\N	A	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2488	excel-import-user	import@system.com	Gunter Diedrich	108915	Pol.Ind.Torrehierro - SINTAL	Sra.María	EL CASAR	2025-06-24	Erst, komplette Range, speziell HSS & Co	Angebot schicken	B	0.00	800.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2489	excel-import-user	import@system.com	Gunter Diedrich	108915	Würth	Pedro José	Talavera	2025-06-24	Erstbesuch, Sonderbohrer Tiefenanschlag & TriJET	Angebot erstellen	B	0.00	400.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2490	excel-import-user	import@system.com	Gunter Diedrich	108915	Sum.Ind.EBORA	JuanMa	Talavera	2025-06-24	SDS-plus & Max	Preisangebot	B	300.00	500.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2491	excel-import-user	import@system.com	Gunter Diedrich	108915	Ferr.Miriam Pérez Crespo	Miriam	Arenas de S	2025-06-24	SDS-plus & Säge+Kreissägeblätterprogramm	Stichsägeblätterangebot schicken	B	0.00	300.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2492	excel-import-user	import@system.com	Gunter Diedrich	108915	Bricolage Sánchez-Fuentes	Emilio Sánchez	Arenas	2025-06-24	Sägeblattmodul & Bit's	Angebot schicken	B	0.00	400.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2493	excel-import-user	import@system.com	Gunter Diedrich	108915	MARCAVEL	Antonio	Madrigal	2025-06-24	Meissel und SDS-max-Bohrer	Angebot erstellen	B	400.00	600.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2494	excel-import-user	import@system.com	Gunter Diedrich	108915	Ferr.Miriam Pérez Crespo	José "Hermano"	Madrigal	2025-06-24	Beton-Range	Angebot 10+1 GRATIS	B	0.00	0.00	4	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2495	excel-import-user	import@system.com	Gunter Diedrich	108915	SUALPE	Chimo	Madrid	2025-06-25	Konsilagerlieferscheine-Kontrolle-Refillorder	Fakturieren	A	14000.00	0.00	1	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2496	excel-import-user	import@system.com	Gunter Diedrich	108915	SHERMACON	Pepe	Villalba P29	2025-06-25	10+1 Gratis SDS-plus & max	\N	B	0.00	0.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2497	excel-import-user	import@system.com	Gunter Diedrich	108915	Hiperconstrucción RUIZ	Miguel-Angel	Villalba P29	2025-06-25	TriJET 10+2 GRATIS, Range Sägen	Angebot Sägen/Modul erstellen	C	0.00	2000.00	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2498	excel-import-user	import@system.com	Gunter Diedrich	109815	ALQUIMÁQUINAS-2002	MaríaJosé/Pepe	Villalba P29	2025-06-25	SDS-largas & ENDURO-max zum Vermieten Meissel	Rangeinfo und Angebot schicken	B	0.00	1500.00	2	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2499	excel-import-user	import@system.com	Steve Bell	1005575	Readyfix	Edward	Preston	2025-06-24	GAP report Rebate and market	4030 4040 price review	A	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2500	excel-import-user	import@system.com	Steve Bell	107751	Mark Up tools	\N	\N	2025-06-26	Return meeting for sds+	\N	A	1000.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2501	excel-import-user	import@system.com	Paulo Santos	100342	Total Diamond Products	Kim/John	Basildon	2025-06-23	Meeting, Turnover, 	Inform daily Stock available SDS MAX 	B	1160.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2502	excel-import-user	import@system.com	Paulo Santos	108862	Golz (UK) Limited	Laura Fold	Northfleet	2025-06-23	Meeting, order	Bt del keeps going slowly	B	700.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2503	excel-import-user	import@system.com	Paulo Santos	109151	Fixmart	Bradley 	Northfleet	2025-06-23	Meeting, Hole saws, Starret, Turnover Rebate	Prices of the Hole Saws	C	650.00	\N	3	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2504	excel-import-user	import@system.com	Paulo Santos	109480	Diamond Direct Supplies	Mac Han	Gravesend	2025-06-23	NMBS Member, Moving the account 	Emil confirming NMBS move 	A	850.00	\N	2	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2505	excel-import-user	import@system.com	Paulo Santos	109567	Thurrock Eng.	Luke Keenan	Grays	2025-06-23	Lapsed accounnt, Buying Bosch	Keep information sent	C	\N	\N	5	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2506	excel-import-user	import@system.com	Paulo Santos	100566	CMT Equipment Ltd	Bethany Collins	Dartford	2025-06-23	Meeting, Own Brand SDS Range, Some sizes Heller	Kee in touch, no need of visits	B	\N	\N	10	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2507	excel-import-user	import@system.com	Paulo Santos	101356	VC Materials Limited	Caetano 	London	2025-06-24	Meeting With Caetano	Regular Visit	B	\N	1500.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2508	excel-import-user	import@system.com	Paulo Santos	102934	APM Plumbing Ltd.	Sherif	London	2025-06-24	Meeting with Sherif, Order in July 	Price list in Excel	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2509	excel-import-user	import@system.com	Paulo Santos	109069	E.D.Elson Ltd.	Steve  	London	2025-06-24	Visit, Check Stock, NMBS Move 	Call in next week for order	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2510	excel-import-user	import@system.com	Paulo Santos	107771	London Plant Hire 	Finchley	London	2025-06-24	Meeting, Sabre saw Blades, Sds Plus 	Offer 10+1 	C	\N	1000.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2511	excel-import-user	import@system.com	Paulo Santos	103046	Focus Plant	Bradley Haigh	London 	2025-06-24	Meeting in Orpington, Close the Store in Cristal P.	Price List, prpeparing a stock order 	C	\N	1000.00	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2512	excel-import-user	import@system.com	Paulo Santos	100286	A Solutions UK Ltd	Sean Adams	Heathrow	2025-06-25	metting, NMBS, Bosch 200K, 	Offer for 24039 	A	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2513	excel-import-user	import@system.com	Paulo Santos	100056	Diamond Hire & Sales LLP	Nerys Jones	Farnborough	2025-06-25	Lapsed account, Duster drill Bits 	Send actual prices	C	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2514	excel-import-user	import@system.com	Paulo Santos	100742	Pegasus Kitchens	Bobby Vekaria	London	2025-06-25	Regular Visit, dril bits for Procelain	Samples approved, order 	C	\N	200.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2515	excel-import-user	import@system.com	Paulo Santos	100979	ETAG Fixings UK	Oana Dragu	Dagenham	2025-06-25	Meeting to see where we can improve turnover	Only buying requested end user	B	\N	350.00	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2516	excel-import-user	import@system.com	Paulo Santos	109793	Franklin Industrial 	Lisa	Kings	2025-06-26	Meet, regular visit, SDS Products 	Order SDS Max	A	500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2517	excel-import-user	import@system.com	Paulo Santos	109127	Finlex International Ltd	Alan Tang	Norwich	2025-06-26	Regular Visit, Turnover, Rebate	send prices for Sanding Discs	A	1500.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2518	excel-import-user	import@system.com	Paulo Santos	109743	Suffolk Fasteners UK	Emma Digby	Ipswich	2025-06-26	Visit, Blacksmiths, Mom/Wife passed away	Business strugeling/small orders	C	200.00	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2519	excel-import-user	import@system.com	Mark Smethurst	100888	Aerotech Abrasives	Nathan	Wetherby	2025-06-23	Meeting, discussed figures and promotions.	Quote for Cutting and Grinding business	C	360.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2520	excel-import-user	import@system.com	Mark Smethurst	prospect	GR Electrical	\N	Wetherby	2025-06-23	Prospect discust top 5 promotion.	Follow up with some Prices.	C	\N	\N	8	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2521	excel-import-user	import@system.com	Mark Smethurst	109757	Direct Building Products	Andy	Bradford	2025-06-23	Account to be transferred to NMBS account.	Transfer account to NMBS.	B	260.00	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2522	excel-import-user	import@system.com	Mark Smethurst	Prospect	Alpha Cash and Carry	Mahmood	Cleckheaton	2025-06-23	Cold call. Showed catalogue.	Follow up with some Prices.	C	\N	\N	8	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2523	excel-import-user	import@system.com	Mark Smethurst	109253	Top Gun Tools	Chris	Blackpool	2025-06-24	Meeting with Chris. Pricing and Deliveries. NMBS.	Transfer account to NMBS.	C	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2524	excel-import-user	import@system.com	Mark Smethurst	Admin	Steve Bell	Steve	Blackpool	2025-06-24	Follow up meeting with Steve.	\N	B	\N	\N	\N	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2525	excel-import-user	import@system.com	Mark Smethurst	107758	Harlequin Fixings	Scott	Kilmarnock	2025-06-24	NMBS Member account to be Transferred.	Transfer account to NMBS.	C	\N	\N	4	f	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2526	excel-import-user	import@system.com	Mark Smethurst	Prospect	Highland Industrial Supplies	Fraser	Inverness	2025-06-25	NMBS Member Introduction and Catalogue.	Follow up with some Prices.	B	\N	\N	8	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2527	excel-import-user	import@system.com	Mark Smethurst	Prospect	Macgregor Supplies	Lesley	Inverness	2025-06-25	NMBS Member Introduction and Catalogue.	Follow up with some Prices.	B	\N	\N	8	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2528	excel-import-user	import@system.com	Mark Smethurst	Prospect	Allans of Gillock Ltd	Jamie	Inverness	2025-06-25	NMBS Member Introduction and Catalogue.	Follow up with some Prices.	B	\N	\N	8	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2529	excel-import-user	import@system.com	Mark Smethurst	Prospect	Innes Pipes Ltd	Gordon	Inverness	2025-06-25	NMBS Member Introduction and Catalogue.	Follow up with some Prices.	C	\N	\N	8	t	t	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2530	excel-import-user	import@system.com	Mark Smethurst	108799	Premier Services	Stuart	Edinburgh	2025-06-26	Meeting. Offers and new products etc.	Quote for Cutting and Grinding business	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2531	excel-import-user	import@system.com	Mark Smethurst	108564	RJ Building Supplies	Ross	Bathgate	2025-06-26	Meeting with Ross. Discussed Promotions.	Quote for Trijet and Four cutter.	C	\N	\N	8	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2532	excel-import-user	import@system.com	Mark Smethurst	Prospect	C T S Supplies	Richard	Grangemouth	2025-06-26	NMBS Member Introduction and Catalogue.	Follow up, Prices and samples.	C	\N	\N	8	t	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2533	excel-import-user	import@system.com	Mark Smethurst	108272	Ace Fixings	Matt	Penrith	2025-06-26	Discussed promotions and pricing.	Quote for Cutting and Grinding business	C	\N	\N	4	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
2534	excel-import-user	import@system.com	Mark Smethurst	Admin	Admin Day	\N	Bolton	2025-06-27	Admin and Teams Meeting.	Admin.	B	\N	\N	\N	f	f	OFFICE	2025-08-18 13:39:05.324984+00	2025-08-18 13:39:05.324984+00
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vertrieb
--

SELECT pg_catalog.setval('public.customers_id_seq', 12846, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vertrieb
--

SELECT pg_catalog.setval('public.reports_id_seq', 2534, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: ix_customers_contact_person; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_customers_contact_person ON public.customers USING btree (contact_person);


--
-- Name: ix_customers_customer_name; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_customers_customer_name ON public.customers USING btree (customer_name);


--
-- Name: ix_customers_customer_no; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_customers_customer_no ON public.customers USING btree (customer_no);


--
-- Name: ix_customers_id; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_customers_id ON public.customers USING btree (id);


--
-- Name: ix_customers_place; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_customers_place ON public.customers USING btree (place);


--
-- Name: ix_reports_id; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_reports_id ON public.reports USING btree (id);


--
-- Name: ix_reports_owner_date; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_reports_owner_date ON public.reports USING btree (owner_oid, date);


--
-- Name: ix_reports_owner_oid; Type: INDEX; Schema: public; Owner: vertrieb
--

CREATE INDEX ix_reports_owner_oid ON public.reports USING btree (owner_oid);


--
-- PostgreSQL database dump complete
--

