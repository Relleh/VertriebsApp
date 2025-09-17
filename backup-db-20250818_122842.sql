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
-- Name: oauth_states; Type: TABLE; Schema: public; Owner: vertrieb
--

CREATE TABLE public.oauth_states (
    state character varying NOT NULL,
    redirect_uri character varying NOT NULL,
    nonce character varying NOT NULL,
    created_at double precision NOT NULL,
    expires_at double precision NOT NULL
);


ALTER TABLE public.oauth_states OWNER TO vertrieb;

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
    contact_person character varying NOT NULL,
    place character varying NOT NULL,
    date date NOT NULL,
    short_report text NOT NULL,
    next_steps text NOT NULL,
    classification character varying NOT NULL,
    order_value_eur numeric(12,2) NOT NULL,
    offer_value_eur numeric(12,2) NOT NULL,
    next_visit_weeks integer NOT NULL,
    is_new_account boolean NOT NULL,
    overnight boolean NOT NULL,
    day_status character varying NOT NULL,
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
64231	100000	Ambiance sols & Murs SAS		Clermont
64232	100001	Powerplus Fixings Ltd	Unit K5	Warrington, Chesire
64233	100002	EUMACOP für Buchhaltung	BITTE NICHT LÖSCHEN	Dinklage
64234	100003	EDE Wuppertal Verbandskunde	nicht löschen	Wuppertal
64235	100004	Wiha Werkzeuge GmbH		Schonach
64236	100005	ALLTOOLS BVBA		LONDERZEEL
64237	100006	DE BRUYNE NV		HARELBEKE (HULSTE)
64238	100007	ISERO Ijzerhandel B.V.	Pijnenburg Bouw & Industrie	Tilburg
64239	100008	Nordwest		Dinklage
64240	100009	EIS Kunden für Buchhaltung nicht	löschen	Dinklage
64241	100010	Frankreich Preisliste F2		Dinklage
64242	100011	SOSACA GEDIMAT SA		La Seyne Sur Mer
64243	100012	SOSACA GEDIMAT		Toulon
64244	100013	Hornung Baushop GmbH & Co. KG		Blankenloch
64245	100014	Quincaillerie CAP AGRI SAS		Saulzet
64246	100015	WORKFORCE (UK) Ltd.	t/a Diamond Direct Supplies	Gravesend
64247	100016	Schönreiter Baustoffe GmbH		Essenbach b. Landshut
64248	100017	KINGFISHER SALES & MARKETING LLP		Bridgend
64249	100018	Raiffeisen Waren GmbH		Leinefelde-Worbis
64250	100019	BMJ 42 SAS		Feurs
64251	100020	Otto Röhrs GmbH		Hambergen
64252	100021	Neukunde_GB	KOPIERVORLAGE nicht überschreiben!	Muster Ort
64253	100022	Baustoff Renger GmbH		Zittau
64254	100023	Ruhland Kallenborn Ensdorf		Ensdorf
64255	100024	LAYER-Grosshandel GmbH & Co.KG		Tettnang
64256	100025	M&M Fixings		Cardiff
64257	100026	Kipp & Grünhoff GmbH & Co. KG		Köln
64258	100027	MERIT TOOL HIRE	AND SALES LTD	Carlton, Nottingham
64259	100028	STEYRO NV		Aalter
64260	100029	In de Boerenhandel bv		Boechout/Antwerpen
64261	100030	Voskamp Bouw en Industrie B.V.		Groningen
64262	100031	Heinrich August Mönkemöller	GmbH & Co KG	Herford
64263	100032	Dachdecker-Einkauf Ost eG	Zweigniederlassung Finowfurt	Schorfheide / OT Finowfurt
64264	100033	Dennis Wendt	Service & Vertrieb	Bremen
64265	100034	The Tools & Fixings Company		Chiselhurst, Kent
64266	100035	RapiTrade UK	Essex House	Great Bromley, Essex
64267	100036	Dachdecker-Einkauf Ost eG	Zweigniederlassung Hidesheim	Hildesheim
64268	100037	FNW Fixings North West	Unit 2 Gleblands Court	Sale, Chesire
64269	100038	Raiffeisen-Waren GmbH		Wetter
64270	100039	Peter Lafrentz GmbH & Co. KG	Stahlhandel	Brunsbüttel
64271	100040	CEULEMANS BVBA		Boechout
64272	100041	MAXIMA SpA		Poviglio (RE)
64273	100042	Dachdecker Einkauf Ost eG	Zweigniederlassung Goslar	Goslar
64274	100043	ABC Industriebedarf	Walter Zettler GmbH	Bremerhaven
64275	100044	GANNAZ MATÉRIAUX SAS		Sallanches
64276	100045	BAUKING Ostfalen GmbH	(Ndl. Garbsen)	Garbsen
64277	100046	Dachdecker-Einkauf Ost eG	Zweig-NL Fürstenwalde	Fürstenwalde
64278	100047	Athena EPI		Martigny Le Comte
64279	100048	Kean Tools		Danbury, Essex
64280	100049	Schmidt Maschinenhandel		Riedstadt-Goddelau
64281	100050	TEAM PRO INTERNATIONAL FZCO		Dubai, Jebel Ali Free Zone
64282	100051	Fastco Ltd	Unit 3a, Crewe Trade Park	Crewe
64283	100053	Knurbein Arbeitsschutz KG		Lindern - Garen
64284	100054	Union Bauzentrum Hornbach GmbH		Ettlingen
64285	100055	Caribbean Solutions	Hacienda San Jose	Caguas P.R. 00726
64286	100056	Diamond Hire & Sales LLP	Elles House	Hampshire
64287	100058	Theo Förch GmbH & Co.KG	Verkaufsniederlassung Magdeburg	Magdeburg
64288	100059	Paulo Santos		Ipswich, Suffolk
64289	100060	Will Eisen- und Sanitär	Großhandelsgesellschaft mbH	Mainz-Kastel
64290	100061	Toolstation Toussieu SAS		Toussieu
64291	100062	Neukunde_FR	KOPIERVORLAGE nicht überschreiben!	Muster Ort
64292	100064	Wiedemann GmbH		Burg
64293	100065	Dachdecker-Einkauf Ost eG	NL Berlin-Biesdorf	Berlin-Biesdorf
64294	100066	Neukunde_Export	KOPIERVORLAGE nicht überschreiben!	Muster Ort
64295	100067	East Coast Sales Ltd.	Unit 1a	Goole, East Yorkshire
64296	100068	Kopiervorlage		Stadt
64297	100069	Maran Atha Fasteners Ltd.		St. Helens, Merseyside
64298	100070	Heller Tools GmbH		Dinklage
64299	100071	Wiedemann GmbH & Co.KG		Bielefeld
64300	100072	deeg GmbH		Stuttgart-Wangen
64301	100073	FGR GmbH		Hagen
64302	100074	Wiedemann GmbH & Co.KG		Höxter
64303	100075	Wandrus Hardware Ltd.		Rochdale
64304	100076	FrimTec GmbH		Oberostendorf
64305	100077	Rimbaud Location		MONTPELLIER
64306	100078	Wiedemann GmbH & Co.KG		Barsinghausen
64307	100079	Raiffeisen Waren GmbH		Gotha
64308	100080	SA Echamat Kernst		Saint Pierre
64309	100081	PT Bahana Andalan Pasti	NPWP: 81.257.966.2-022.000	Jakarta Pusat DKI Jakarta
64310	100082	Zhen Jiang HTT Tool Co., Ltd.		Danyang City, Jiangsu Province
64311	100083	WP GmbH	Diamanttechnik Maschinen Zubehör	Celle
64312	100085	Normstark	Partner für Industrie und Handwerk	Lengerich
64313	100086	C.Adolph	Inh. Veronika Savary e.K.	Berlin
64314	100087	Wiedemann GmbH & Co.KG		Celle
64315	100088	Wiedemann GmbH & Co.KG		Göttingen
64316	100089	PENNY PLUS D.O.O. SARAJEVO		Vogosca
64317	100090	Wiedemann GmbH	NL Landsberg	Landsberg
64318	100091	Hammer-Baubedarf AG		Winterthur
64319	100092	Wiedemann GmbH	NL Tempelhof	Berlin-Tempelhof
64320	100093	Wiedemann Industie und Haustechnik	GmbH	Potsdam
64321	100094	GES	Handwerks- und Industriebedarf GmbH	Duisburg
64322	100095	COOPROVENCE	SA	Entraigues-sur-la-Sorgue
64323	100096	Wiedemann Industie- und Haustechnik	GmbH	Dessau-Roßlau
64324	100097	Union Bauzentrum Hornbach GmbH		Großeicholzheim
64325	100098	SARL Forestier Delchet		Le Mayet de Montagne
64326	100099	Friedrich Niemann GmbH & Co. KG	Niederlassung Hamburg	Hamburg
64327	100100	Wiedemann GmbH & Co.KG		Goslar
64328	100101	UBT (EU) Ltd	nur Einkaufsguppe für Rabatte	Warwick
64329	100102	edm GmbH & Co. KG		Fuldabrück
64330	100103	Wiedemann GmbH & Co.KG		Herzberg
64331	100106	Vlanip Design SRL		Chisinau Moldova
64332	100107	Wiedemann GmbH		Thyrow
64333	100108	Wiedemann GmbH		Brandenburg
64334	100109	Wiedemann GmbH		Berlin
64335	100110	Wiedemann GmbH		Nordhausen
64336	100111	Tool Co.	Irrgang, Marquardt oHG	Berlin
64337	100112	RJ Fixings Newcastle Ltd.	Unit C1 Bergen Close	North Shields
64338	100113	Dachdecker-Einkauf Ost eG	NL Dessau	Dessau
64339	100114	Waidzeit	Baumaschinen Vermietung	Lage
64340	100115	LuDz Mitte GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Barsinghausen
64341	100116	Gerhard Borchert	Baustoff - Fachhandel GmbH	Berlin
64342	100117	Siebert Oetzel OHG	Baustoffhandel	Berlin
64343	100118	Montageservice	Mario Alsleben	Oberhausen
64344	100119	EJOT SISTEMAS DE CONSTRUCCION	S.DE R.L. DE C.V	San Luis Potosi SLP Mexico
64345	100120	Gulf Diameter Est. for Trading		Dammam
64346	100121	Jomi - Profixings	Hautekeete Joachim	Deinze
64347	100122	Druse GmbH	Werkzeuge und Industriebedarf	Buchholz
64348	100123	Rotink Ijzerwaren	ZHA Heer Han ter Woorst	Hengevelde
64349	100124	SAS GTC RESEAUX		MARSEILLE
64350	100125	Wilhelm Lingsch GmbH	Inh. Christian Martin	Berlin
64351	100126	Der Baustoff-Mann Schneider KG		Bottrop
64352	100127	Outils Nord Sàrl	Tools	Derenbach
64353	100128	FE ZEVIJ BV, COOP GRHANDVER ZEVIJ		Oosterhout
64354	100129	KLAXON S.A.		Athen Greece
64355	100130	bauSpezi E. Marks GmbH		Jütrichau
64356	100131	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Bergen
64357	100132	SARL FIX'ON		SIX FOURS LES PLAGES
64358	100133	Hermann Bach GmbH & Co.KG		Salzkotten
64359	100134	Robert Neudorf	Inh. Christian Kruschel e.K.	Berlin (Spandau)
64360	100135	Philipp Einzel- u. Großhandels GmbH		Berlin-Wittenau
64361	100136	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Seebad Bansin
64362	100137	inha GmbH	Maschinen Werkzeuge Kugellager	Berlin
64363	100138	Walter Wesemeyer GmbH		Waren/Müritz
64364	100139	Walter Wesemeyer GmbH		Kiel
64365	100140	Walter Wesemeyer GmbH		Lübeck
64366	100141	Walter Wesemeyer GmbH		Bad Doberan
64367	100142	Vollmer Baustoffhandel		Bellheim
64368	100143	Walter Wesemeyer GmbH		Hamburg Altona
64369	100144	Walter Wesemeyer GmbH		Hamburg Osdorf
64370	100145	Walter Wesemeyer GmbH		Schwerin
64371	100146	Baku Engineering Supplies Ltd LLC		Baku
64372	100147	Walter Wesemeyer GmbH		Kaltenkirchen
64373	100148	Technische Werkstätten	Langengrassau GmbH	Heideblick
64374	100149	BTL Beton Transformation	Luxembourg S.A.	Horhausen
64375	100150	Walter Wesemeyer GmbH		Wismar
64376	100151	UIP Verbindungstechnik GmbH		Kriftel
64377	100152	Adolf Neuendorf GmbH		Berlin
64378	100153	M. u. F. Valentin Tischler-	bedarf GmbH & Co.KG	Berlin
64379	100154	Walter Wesemeyer GmbH		Pinneberg
64380	100155	Walter Wesemeyer GmbH		Schwarzenbek
64381	100156	Claus Hedemann GmbH & Co. KG		Bad Zwischenahn
64382	100157	Mastermate Zwager	van Ree Beverwijk	Beverwijk
64383	100158	Walter Wesemeyer GmbH		Buchholz i. d. Nordheide
64384	100159	Elektro Großhandel Union Neuss GmbH		Neuss
64385	100160	Mobau PRO GmbH & Co. KG		Bergheim
64386	100161	Wolfram Lochert	Maschinen-Werkzeuge	Wermsdorf/OT Liptitz
64387	100162	A&B Services (Liverpool) Ltd	Handyman's Corner	Liverpool
64388	100163	SASU Boute Yves SAS		Saint Juste Malmont
64389	100164	De Boer & Van Hout		Veldhoven
64390	100165	BMN IJzerwaren Tilburg		Tilburg
64391	100166	Eisen-Sommer e.K.	Inhaber Manfred Sommer	Berlin
64392	100167	Amlex GmbH & Co. KG		Essen
64393	100168	AB Matériel		VEDENE
64394	100169	Delmes Heitmann GmbH & Co. KG	(Ndl. Hummelsbüttel)	Hamburg
64395	100170	Follmann Baustoffe GmbH		Wittlich
64396	100171	Al-Majdud Company for General	Trading Ltd.	Al Salihiya Baghdad
64397	100172	Mrose GmbH	Technischer Handel-Indsutriebedarf	Forst
64398	100173	Kluwe Baufachhandelsges. mbH		Berlin
64399	100174	KÖSTER BAUCHEMIE AG		Aurich
64400	100175	Jacob Sönnichsen AG	Jacob Cement	Rostock
64401	100176	Ralf Koss	Industriebedarf	Berlin
64402	100177	BAUKING Südwestfalen GmbH	(Niederlassung Menden)	Menden
64403	100178	US Service GmbH		Lehmrade / Mölln
64404	100179	SAS AUVERGNE SERAMIK		CLERMONT FERRAND
64405	100180	AGWIS	Thomas Becker	Osterode am Harz
64406	100181	DGL Workshop Supplies LTD	Unit 2A (Lower Ground Floor)	Hertford, Herts
64407	100182	Power Tool Supplies (Cork) Ltd		Pouladuff, Cork
64408	100183	Dachdecker Einkauf Wesendorf		Wesendorf
64409	100184	Beyen	für´s Handwerk	Dinklage
64410	100185	Stang GmbH & Co. KG	NL München	München
64411	100186	Otto Jörgensen + Sohn GmbH	Industrietechnik	Flensburg
64412	100187	Albert Leymann GmbH & Co.KG	NL Bruchhausen-Vilsen	Bruchhausen-Vilsen
64413	100188	hagebaucentrum Bolay GmbH & Co. KG	(hagebaumarkt Rutesheim)	Rutesheim
64414	100189	EXTER DIFFUSION	SARL	ANTIBES
64415	100190	DFS Fixings Ltd.	Foundry Square	Leicester
64416	100191	Hoffmann GmbH		Achim
64417	100192	Friedrich Rohwedder GmbH		Berlin
64418	100193	VOIRON MATÉRIAUX SARL		MORZINE
64419	100194	Zeppelin Rental GmbH & Co.KG	Mietstation Wiesbaden	Wiesbaden
64420	100195	Kipp & Grünhoff GmbH & Co. KG		Köln - Eigelsteinviertel
64421	100196	DIGILEC	SARL	CHARLIEU
64422	100197	CARRELAGE DU SALEVE	SAS	Chênex
64423	100198	automac-zieher GmbH		Biberach
64424	100199	Richter Baustoffe GmbH	(Ndl. Roggentin)	Roggentin
64425	100200	SchraubenExpress.de	Inh. Stephan Lauterbach	Brieselang
64426	100201	Paul Swertz GmbH		Emmerich
64427	100202	Eisen Döring Charlottenburg	An der Kaiserdamm Brücke	Berlin-Charlottenburg
64428	100203	Fischer-J.W.Zander GmbH&Co.KG		Erlenbach
64429	100204	Vochtstore.be	Hans Peter Sulman	Antwerpen
64430	100205	Hamann Kaisersesch GmbH		Kaisersesch
64431	100206	Stow Agricultural Ltd		Longborough, Gloucestershire
64432	100207	DEG Dach-Fassade-Holz eG		Wuppertal
64433	100208	Max Schierer GmbH	Ndl. Bad Kötzting	Bad Kötzting
64434	100209	Max Schierer GmbH	Ndl. Regen	Regen
64435	100210	Max Schierer GmbH	Ndl. Niettenau	Nittenau
64436	100211	Max Schierer GmbH	Ndl. Viechtach	Viechtach
64437	100212	OX Group U.K.	Unit 2, Riverside	London
64438	100213	Pinsel-Wurm Malerwerkzeuge	GmbH & Co. KG	Mutterstadt
64439	100214	Profast Ltd	Unit 11, Western Ind. Estate	Dublin
64440	100215	ibg Technischer Handel GmbH		Hilden
64441	100216	Tools GmbH	Agentur für Qualitätswerkzeug	Neukirchen-Vluyn
64442	100217	Hans Sauer GmbH	Elektrowerkzeuge	Hamburg 63
64443	100218	Paul Swertz GmbH		Geldern-Veert
64444	100219	W. Hauck GmbH	Werkzeuge Maschinen Industriebed.	Schwegenheim
64445	100220	Paul Swertz GmbH		Viersen
64446	100221	Hermann Bach GmbH & Co. KG	(Ndl. Göttingen)	Göttingen
64447	100222	GmbH HartGruppService		Bolschewik, Minsk
64448	100223	Welch & Tidy Ltd	Wholesale Cash & Carry	Perivale, Middlesex
64449	100224	BAUKING GmbH		Dortmund
64450	100225	Schroers GmbH	Holzbearbeitungsmaschinen	Mönchengladbach
64451	100226	KORTEK	Lars Hoffmann	Arnsdorf
64452	100227	J.W. Zander GmbH & Co. KG		Recklinghausen
64453	100228	Bauwelt Plambeck	Delmes Heitmann GmbH & Co. KG	Kaltenkirchen
64454	100229	Voskamp Bouw en Industrie B.V.		Oud Gastel
64455	100230	Stadur Produktions GmbH & Co.KG		Hammah
64456	100231	BMN IJzerwaren DC Best		BEST
64457	100232	Raiffeisen Waren GmbH	Ndl. Nordhausen	Nordhausen-Nord
64458	100233	Dachdecker- und Baustoff-Einkauf	Zweigniederlassung Wittichenau	Wittichenau
64459	100234	BMN Ijzerwaren Arnhem		Arnhem
64460	100235	Blaricumsche IJzerhandel		Blaricum
64461	100236	Kilman	Osman Mora Retamal	Conceptión VIII  CHILE
64462	100237	DEG Dach-Fassade-Holz eG	ZNL Bottrop	Bottrop
64463	100238	M Maschinen	Inhaber Dieter Liemen	Gotha
64464	100239	ITW Construction Products Oy		VANTAA
64465	100240	Hippotools		Houthalen - Belgium
64466	100241	Elektrowerkzeuge GmbH Eibenstock		Eibenstock
64467	100242	Dachdecker-Einkauf Ost eG	Massen/Finsterwalde	Massen
64468	100243	OOO PROFITOOL (PROFITOOL LTD)		Kievskaya oblast, Boyarka
64469	100244	Dachdecker-Einkauf Ost eG	Zweigniederlassung Schaumburg	Lauenau
64470	100245	Veneberg BV		Hardenberg
64471	100246	Fleischhut GmbH		Cuxhaven
64472	100247	Ömer's Profi - Baumarkt		Herne
64473	100248	Schnittger Baustoffe GmbH & Co. KG		Lübbecke
64474	100249	G.W.J. van Lochem B.V.		Aalten
64475	100250	Schütte Baumarkt GmbH & Roggan KG		Lüchow
64476	100251	Dominik Menke	Restpostendomi	Langen
64477	100252	DD PRO	SAS	NICE
64478	100253	Bücheler & Martin	Fachhandel für Baustoffe	Stockach
64479	100254	Kurt Neidull e.K.		Kirchenthumbach
64480	100255	J. H. Niebuhr jr. Handelsges. mbH		Elmshorn
64481	100256	Schnittger Baustoffe GmbH & Co. KG		Lübbecke
64482	100257	Delmes Heitmann GmbH & Co. KG	(Niederlassung Glinde)	Glinde
64483	100258	BAUKING Ostfalen GmbH		Goslar
64484	100259	Guido Hinken		Nordhorn
64485	100260	Techprof Amsterdam BV		Amsterdam
64486	100261	Burkard Giegerich GmbH & Co KG		Großwallstadt
64487	100262	Belziger Baustoffhandel GmbH		Bad Belzig
64488	100263	Etges & Dächert Baustoffe	GmbH & Co. KG	Trier
64489	100264	Beckmann Haustechnik	eine Zweigniederlassung der	Flensburg
64490	100265	SIGF Manchester	Textilose Road	Manchester
64491	100266	Eisenwaren Diefenbach	Inh. Werner Diefenbach	Wiesbaden
64492	100267	Reisser Schraubentechnik GmbH		Ingelfingen-Criesbach
64493	100268	HEGO-Montagetechnik		Krautheim-Gommersdorf
64494	100269	Baustoffzentrum Wilhelm Harbecke Gm		Mülheim - Broich
64495	100270	Bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Winsen/Luhe
64496	100271	Rudolf Peters Landhandel	GmbH & Co. KG	Büchen
64497	100272	Adde Cassens KG		Esens
64498	100273	Ferroflex AG	c/o Ferroflex Group AG	Schaffhausen
64499	100274	Beacon Trade and Tool Ltd	Computer House	West Midlands, Oldbury
64500	100275	albin motzer	Inh. Albin Motzer	Eichberg
64501	100276	Müller & Janßen	Holz und Baustoffe	Hesel
64502	100277	LHG-Markt GmbH	Schneider Baucentrum	Bruckmühl
64503	100278	Seidler + Hentschel OHG	Bauzubehör	Bernburg
64504	100279	INTEC Industrie-	und Werkstattbedarf GmbH	Quedlinburg
64505	100280	GUHDO GmbH		Wermelskirchen
64506	100281	Pauly Elektrotechnik GmbH	Inh. Michael Pauly	Morbach
64507	100282	TFS Direct	Unit 11/12, Millbuck Way	Sandbach, Cheshire
64508	100283	BauKing Engelskirchen		Engelskirchen
64509	100284	BRANDT-Shop	Inh. E. Brandt	Eckental
64510	100285	Dominik Menke	Werkzeughandel	Langen
64511	100286	A Solutions UK Ltd		Ashford
64512	100287	Georg GmbH		Erfurt
64513	100289	Hermann Bach GmbH & Co. KG		Bernburg
64514	100290	Union Bauzentrum Hornbach GmbH		Wöllstein
64515	100291	Conrad Electronic	Filiale Essen	Essen OT. Weststadt
64516	100292	BMN Wijcks RDC Nijmegen		Nijmegen
64517	100293	Hass+Hatje GmbH		Neumünster
64518	100294	Hass + Hatje		Hitzhusen
64519	100295	Conrad Electronic SE	Cross-Docking	Hirschau
64520	100296	Hass + Hatje GmbH		Bordesholm
64521	100297	Werner K. Mayer GmbH	Baumaschinen - Baugeräte	Schwäbisch Gmünd
64522	100298	Laarmann u.Peez GmbH		Hamburg
64523	100299	Zeeman IJzerhandel		Schiedam
64524	100300	Stender Bautechnik	Vertrieb + Service	Ventschow
64525	100301	Conrad Electronic SE	Filiale Dortmund	Dortmund
64526	100302	Lars Heller		Sankt Augustin
64527	100303	Kunath Gewinde- und	Befestigungstechnik	Schwerin/Görries
64528	100304	EGG Elektrogroßhandel GmbH	Inh. Christoph Gemmecke	Arnsberg
64529	100305	OnSite Support		Crawley, West Sussex
64530	100306	Hoppe GmbH & Co. KG		Brilon
64531	100307	Theile & Wagner GmbH & Co. KG	Industriebedarf	Zittau
64532	100308	Conrad Electronic SE		Bonn - Weststadt
64533	100309	EH Hasselbring	Baustoffe & Holz	Bremervörde
64534	100310	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Crimmitschau
64535	100311	Coopérative Artisanale du Sanitaire	de l’Électricité et du Chauffage	FENAY
64536	100312	Der Neue Eisenhenkel GmbH		Kiel
64537	100313	PROFIX AG		Lausen
64538	100314	The Toolbox Supply Company		Hartlepool
64539	100315	R.P.A.Steenbakkers		Boxtel
64540	100316	Shopcore.nl		Doetinchem
64541	100317	HO Voets		Schijndel
64542	100318	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Lübeck
64543	100319	Johann Eberhard Ges.m.b.H		St. Josef
64544	100320	Friedrich Niemann GmbH & Co.KG	Werkzeughandel	Kronshagen
64545	100321	T. Bulten Bouwmaterieel		Zelhem
64546	100322	Conrad Electronic Stores	GmbH & Co.KG	Hamburg
64547	100323	Borchers & Speer	Handelsgesellschaft mbH	Kiel
64548	100324	BODIAM Diamantwerkzeuge		Plattenburg
64549	100325	Swiftfix Distributors Ltd		Sholing, Southampton
64550	100326	Josef Klinke Baustoffe	Inh. Anne Klinke e.K.	Wittmund / OT Ardorf
64551	100327	Wimberger Fachmarkt	Stefan Wimberger	Frontenhausen
64552	100328	Pioneer Agri		Lincoln
64553	100329	Pflüger Baustoffe GmbH		Marktbergel
64554	100330	Conax UG	Werkzeuge	Leipzig
64555	100331	Integra GmbH	Fachgroßhandel	Jahnsdorf
64556	100332	Trent Fasteners & Fixings Ltd.	Unit 5A Tern Valley Business Park	Shropshire
64557	100333	SORMAT OY	attn. Simo Lieskivi	RUSKO (FINNLAND)
64558	100334	B. Schlichter GmbH & Co.KG	Abt. Alu Bautechnik	Lathen
64559	100335	Optimum Trade Supplies Ltd.		Fenstanton Cambridgeshire
64560	100336	Bach & WESCO KG		Bergisch Gladbach
64561	100337	Beck Elektrogroßhandel e.K.		Bad Salzungen
64562	100338	Pantaleo Stomeo		Engelskirchen
64563	100339	Drögemüller Handels mbH	Maschinen-Werkzeuge	Lübeck
64564	100340	BMN Ijzerwaren		Amsterdam
64565	100341	KUROGA GmbH & Co.		Hamburg 76
64566	100342	Total Diamond Products	Husqvarna Construction UK Ltd	Basildon, Essex
64567	100343	BMN Ijzerwaren		Rotterdam
64568	100344	Dachdecker- und Baustoff-Eink.	Zweigniederl. Dresden/Moritzburg	Moritzburg/OT Boxdorf
64569	100345	Max Hufnagel GmbH		Dachau
64570	100346	Dachdecker- und Baustoff-Einkauf eG	Zweigniederlassung Dresden	Dresden
64571	100347	Union Bauzentrum Hornbach GmbH		Pirmasens
64572	100348	Kamoro GmbH		Roetgen
64573	100349	Josef Schwarz & Sohn GmbH & Co. KG		Dingolfing
64574	100350	Bauexpert GmbH & Co KG		Ottobeuren
64575	100351	Ercalux SA		Fischbach/Clervaux
64576	100352	Josef Schwarz & Sohn GmbH & Co. KG		Mainburg
64577	100353	Josef Schwarz & Sohn GmbH & Co. KG		Moosburg
64578	100354	Wilfried Uwe Koch	Industriebedarf	Bönningstedt
64579	100355	Dachdecker-Einkauf Ost eG	Niederlassung Hannover	Hannover
64580	100356	Aktiv	Baumaschinen & Industriebedarf GmbH	Linden
64581	100357	Josef Schwarz & Sohn GmbH & Co. KG		Traunstein
64582	100358	Josef Schwarz & Sohn GmbH		Edling
64583	100359	Leigh tools and accessories ltd		Leigh, Lancashire
64584	100360	Max Schön  GmbH		Lübeck
64585	100361	Hammer Markt Krahm GmbH		Müschenbach
64586	100362	UAB MEDVALDA	Mr. Vaidas Trinkunas	Utena
64587	100363	Peter Kasberger GmbH		Vilshofen-Pleinting
64588	100364	Raiffeisen Waren GmbH		Weimar
64589	100365	BOUWFIX NOORD HOOGEVEEN B.V.		Hoogeveen
64590	100366	Venanz Fischer	Baustoffzentrum	Ebersdorf
64591	100367	Joachim Meißner	Bohr- und Diamantwerkzeuge	Amelinghausen
64592	100368	Fr. Dähmlow GmbH & Co. KG	L80804	Neumünster
64593	100369	Neukunde_NL	KOPIERVORLAGE nicht überschreiben!	Ort
64594	100370	Hammer Markt Krahm GmbH		Waldbröl
64595	100371	NOLIEM SAS	Batiment Firm	SAINT FONS
64596	100372	Stieper GmbH & Co KG		Nortorf
64597	100373	Hermann Bach GmbH & Co. KG		Soest
64598	100374	Metall Markert GmbH		Crottendorf
64599	100375	Van Eyck BVBA		Kampenhout
64600	100376	Ernst Sander e.K.		Ratzeburg
64601	100377	Thiele Industriebedarf	Inh. Max Thiele	Zittau
64602	100378	Clever Diamond GmbH		Remscheid
64603	100379	Fist Baugeräte GmbH		Gau Algesheim
64604	100380	Richard Petersen	Inh. Stefan Jähde e.K.	Schleswig
64605	100381	Gebr. Hatebur Bau-Fachmarkt		Olfen
64606	100382	Eduard Roeseler	Ihn. Gerd Roeseler	Stade / Elbe
64607	100383	UAB "Bio raukstuva"	Company code: 302677908	Utena
64608	100384	Kemmler Baustoffe GmbH		Balingen
64609	100385	Dachdecker Einkauf West eG	Zweigniederlassung Dortmund	Dortmund
64610	100386	Hans Treiber	Werkzeuge-Maschinen GmbH	Henstedt-Ulzburg
64611	100387	Walter Prause	Inh. Ing. Arno Jeskulke	Luebeck
64612	100388	MADATEX s.r.o.		Púchov
64613	100389	Hermann Bach GmbH & Co. KG		Worbis
64614	100390	Matthias Lerche	Lerche Schweißtechnik	Mockrehna
64615	100391	Gebr. Honnens GmbH		Tarp
64616	100392	Jennings Engineering Supplies Ltd	Crosby Croft	Maldon, Essex
64617	100393	Dexis Belgium NV		Hasselt
64618	100394	Dachdecker Einkauf Ost eG	Zweigniederlassung Magdeburg	Magdeburg
64619	100395	Peter Hellmich KG		Berlin
64620	100396	Luhmann Holzhandel GmbH		Celle
64621	100397	Baustoffcenter Oschersleben	GmbH & Co. KG	Oschersleben
64622	100398	Mapeco Vilvoorde		Vilvoorde
64623	100399	TRENOIS DECAMPS		Wasquehal
64624	100400	Michael Bubolz	Zerspannungstechnik GmbH	Stuhr
64625	100401	SEDISA SAC		Surco - Lima
64626	100402	S & S Montagesysteme		Delmenhorst
64627	100403	Baucentrum Stewes GmbH & Co. KG		Gladbeck
64628	100404	W + B Wehling + Busert GmbH		Südlohn
64629	100405	Toolexpert Benelux BV	Toolstation Europe Ltd.	Bleiswijk
64630	100406	Bor Sag og Meiselteknikk AS		Lakseväg
64631	100407	MILO-Tec Vertriebs GmbH		Beringen
64632	100408	LAMET s.n.c.		Torino
64633	100409	Schröder Bauzentrum		Borstel-Hohenrade
64634	100410	Dachdecker-Einkauf Ost eG	Zweigniederlassung Berlin-	Berlin
64635	100411	Heinz Sanders GmbH		Meppen
64636	100412	JK Supplies Ltd	4 Hillside Cottages	Hemel Hempstead, Hertfordshire
64637	100413	Raiffeisen Waren GmbH		Kassel
64638	100414	Sleiderink Bouwmaterialen		Oldenzaal
64639	100415	Walter Wesemeyer GmbH		Bad Oldesloe
64640	100416	Brumberg	Werkstatt-Garten-Freizeit	Wehr
64641	100417	Müller & Schnigge		Herzberg
64642	100418	Hass+Hatje GmbH		Bornhöved
64643	100419	Bauwaren Mahler GmbH & Co. KG		Unterdießen
64644	100420	Bauwaren Mahler GmbH & Co. KG	Hagebaumarkt	Augsburg
64645	100421	August Landahl & Carl Mohns	Werkzeug Großhandels Ges. mbH	Hamburg
64646	100422	Kroon B.V.		Hoogezand
64647	100423	Emil Lüdemann GmbH & Co KG	Eisenwaren-Werkzeuge	Hamburg - Stellingen
64648	100424	Hillari Fliesen Center GmbH		Burgau
64649	100425	SVH Handels-GmbH		Dortmund
64650	100426	Würth Industrie Service		Bad Mergentheim
64651	100427	BMN Ijzerwaren		Katwijk
64652	100428	Raiffeisen Waren GmbH		Eschwege
64653	100429	BAUIGEMA-Siegfried GmbH		Geraberg
64654	100430	Trading House Trade Tools Ltd.		Moscow
64655	100431	Werkzeug- und Baugerätehandel	Bernd Evermann	Wittenburg
64656	100432	KMG Ltd.	Ivy House	Salford
64657	100433	Team Thaler GmbH	Diamantwerkzeuge	Oberau
64658	100434	SIGCA Ruislip		South Ruislip
64659	100435	Target Tools Supply Ltd		Hartlepool
64660	100436	Schäfer Baustoffe Vertriebs GmbH		Wartenberg-Rohrbach
64661	100437	Baustoff Netzband GmbH		Elbe-Parey OT Derben
64662	100438	Herm. Stocks & Co. (GmbH & Co.)		Hamburg
64663	100439	Ardling Asesoria Integral Eirl	AV. Parque De las Leyendas	Lima Peru
64664	100440	BT Brammer Distributiecentrum Venlo		Venlo
64665	100441	Otto Nilsson GmbH & Co. KG	Nilsson Meldorf	Meldorf
64666	100442	Huber & Riedel GmbH		Gunzenhausen
64667	100443	Zitzmann Baustoffe-Betonwerk		Schwarzenfeld
64668	100444	Raiffeisen Bezugs- u. Handels-	gesellschafft	Grünhainichen
64669	100445	hawo GmbH		Heppenheim
64670	100446	Heinz Schäfer GmbH	Schäfer Leverkusen	Leverkusen
64671	100447	Baustoffzentrum Tepker	Tepker Osterrönfeld	Osterrönfeld
64672	100448	Dachdecker-Einkauf Ost eG	Zweigniederlassung Spandau	Spandau
64673	100449	Kölner Bauzentrum	MOBAU Linden	Köln
64674	100450	SIGF Cambridge	Unit 1	Cambridge
64675	100451	Otto Röhrs GmbH	Röhrs Onlineshop Ruh	Scheeßel
64676	100452	Auer Landshut		Landshut
64677	100453	C. Wölfling KG	Beschlag Befestigung Elemente	Pirmasens
64678	100454	BAUKING Südwestfalen GmbH	FH Siegen-Geisweid	Siegen-Geisweid
64679	100455	Quadriga Gerüstbau GmbH	Quadriga Fachhandel für Gerüstbau	Berlin
64680	100456	FALANO GmbH	Warenvertriebsgesellschaft mbH	Vechta Langförden
64681	100457	Dobermann Baustoffhandelsges.		Münster
64682	100458	Leitermann GmbH & Co.	Fachmarkt KG	Lödla
64683	100459	Theodor Erich	Großhandels GmbH	Hamburg
64684	100460	Foxtool	Inh. Mirko Schweidler	Königsbrück
64685	100461	CEF Elektrofachgroßhandlung	Südwest GmbH	Möhringen
64686	100462	Eisen-Wolff GmbH		Hamburg
64687	100463	RIS Consulting- und Industrie-	service GmbH	Steinen
64688	100464	Gerhard Borchert		Velten
64689	100465	Handelshof Riesa GmbH	Niederlassung Glauchau	Glauchau
64690	100466	H.J. Bünder GmbH		Euskirchen
64691	100467	Henrich Baustoffzentrum	Siegburg	Siegburg
64692	100468	CEF Elektrogrosshandlung		Möhringen
64693	100469	Friedrich Lange GmbH		Hamburg
64694	100470	Friedrich Kabrinke	Raumausstatter- und Polstereibedarf	Altenholz
64695	100471	Elektromaschinen Wölke		Recklinghausen
64696	100472	Sleiderink Hout	& Bouwmaterialien B.V.	Denekamp
64697	100473	Beckmann Bauzentrum GmbH & Co. KG		Norderstedt
64698	100474	Borgers Baustoffe		Hamminkeln
64699	100475	I+M Bauzentrum Retagne GmbH		Dornburg
64700	100476	DEG Alles für das Dach eG		Koblenz
64701	100477	Theissen Bauzentrale KG		Rath-Anhoven
64702	100478	Quantum Group		Eglinton
64703	100479	PROFI Bedachungsmarkt Großenhain	Niederl. der ELG Bau Meissen eG	Großenhain
64704	100480	Holzkontor GmbH		Gardelegen
64705	100481	Orchard Fasteners Ltd.	Unit 38	Co Armagh
64706	100482	Baucenter Hans Widmann		Schwäbisch Gmünd
64707	100483	Tech-Mont	Spólka Jawna Z.Klimek	Krakow
64708	100484	SIG Tech Ins Portsmouth		Portsmouth
64709	100485	Baubedarf Berg und Mark eG		Solingen
64710	100486	Ute Orth GmbH & Co.KG	Bekleidung & Technik	Geesthacht
64711	100487	Giebels & Strack	Baumaschinen GmbH	Viersen
64712	100488	Konzept B Service GmbH		Wien
64713	100489	SAMEDIA GmbH		Denzlingen
64714	100490	Mobau Erft Frechen	Bauzentrum GmbH & Co. KG	Frechen
64715	100491	Kuhl & Jungbluth OHG		Wuppertal
64716	100492	Sanet J.A. Szostak Sp.J.		Gdánsk
64717	100493	ETM Elektrotechnik GmbH		Ludwigslust
64718	100494	Koehler Fachhandel e.K.	Inh. Nadine Koehler	Bärenstein
64719	100495	August Krämer GmbH		Kiel
64720	100496	Mobau Baustoff-Union GmbH		Aachen
64721	100497	HIW  Handwerker- u. Industrie	Werkzeuge Handelsgesellschaft mbH	Hamburg
64722	100498	A.Karstensen GmbH & Co.		Sylt / OT Keitum
64723	100499	Vosmerik Ltd.		Saint-Petersburg, Stepana
64724	100500	SAS LM Aciers Outillages F-I		Alixan
64725	100501	Secure Systems International (SSI)	Pte ltd.	Singapore
64726	100502	Werkzeug Hettich		Achstetten
64727	100503	PVR Direct Ltd	Olympia house	Brislington, Bristol
64728	100504	Werkzeugstore24 GmbH		Flörsheim
64729	100505	RAMO Handels GmbH		Zug
64730	100506	HKL Baumaschinen GmbH	Buchhaltung	Hamburg-Hummelsbüttel
64731	100507	Stammelbach Karl Krüger	GmbH & Co. KG	Hildesheim
64732	100508	MAKRO	Handels-GmbH u. Co. KG	Itzehoe
64733	100509	Iccons Pty Ltd		Dandenong South VIC 3175
64734	100510	TEAM PRO SAL	EDWAN BULDING	BEIRUT
64735	100511	AccurA Diamond Tools Ltd.	Unit 69, Accura House	Parkwest, Dublin 12
64736	100512	Northern Diamond Sales Ltd.	Unit 1A	Kendal
64737	100513	DrillBitsUK Ltd	Number One Industrial Estate	County Durham?????
64738	100514	ROMI-Technik GmbH		Lustadt
64739	100515	Baufuchs GmbH		Osterburken
64740	100516	Werkzeug Lorenz - Werlo24		Gerabronn
64741	100517	Rudolf Sievers GmbH	Partner für Technik	Seevetal-Hittfeld
64742	100518	Richter KG		Schleswig
64743	100519	SIGF London	Unit 6	London
64744	100520	SIG Insulation	Unit 4	Ruislip
64745	100521	Ernst Hasselbring GmbH & Co.KG		Cuxhaven
64746	100522	interNeo Technologie & Service GmbH		Berlin
64747	100523	Nadine Bartylla	Heller Tools GmbH	Dinklage
64748	100524	De Stalen Greep nv	tav. Dave	Tielt
64749	100525	Federn Oßwald	Fahrzeugteile	Zella Mehlis
64750	100526	Gebr. Dapprich GmbH		Wuppertal
64751	100527	Zweygart Fachhandelsgruppe GmbH	& Co. KG	Ehningen
64752	100528	Technische Bouwservice BV		IJsselstein
64753	100529	Plankunde Australien, Asien		Plankunde
64754	100530	UAB KESKO SENUKAI LITHUANIA		Kauno
64755	100531	Plankunde Ost-Europa		Plankunde
64756	100532	Plankunde ehem. Soviet Staaten		Plankunde
64757	100533	EURL Felix Materiaux		Vernoux En Vivarais
64758	100534	Plankunde Russland		Plankunde
64759	100535	Rohwein Export / Import		Dortmund
64760	100536	Mingau Baumaschinen GmbH		Senftenberg / Kleinkoschen
64761	100537	Schurmann Industriebedarf-	Handelsgesellschaft mbH	Reinbeck
64762	100538	Gedimat Montagnat	SA	Saint Jean De Bournay
64763	100539	Plankunde Mittlerer Osten, Afrika &	Indien	Plankunde
64764	100540	Plankunde Nord-Amerika		Plankunde
64765	100541	Dübel & Bohrer GmbH	Technische Beratung - Lager	Hamburg
64766	100542	Plankunde Iberia		Plankunde
64767	100543	Plankunde Nordic		Plankunde
64768	100544	Sermatec sàrl		Ehlerange
64769	100545	HG Bau- und Hobbymarkt GmbH		Rüsselsheim
64770	100546	Franz Schoppe GmbH & Co. KG	Industrie- u. Schiffsbedarf	Kiel
64771	100547	Plankunde Süd-Europa		Plankunde
64772	100548	Plankunde DACHL TCG		Plankunde
64773	100549	Plankunde Nordic TCG		Plankunde
64774	100550	Metzger Baustoffshop GmbH & Co. KG		Schwerte
64775	100551	AGEFA Werkzeug- und Maschinen-	Handelsges. mbH	Balingen
64776	100552	Ennens GmbH & Co.KG	Bau- und Industriebedarf	Heede
64777	100553	Handelsonderneming DIRKS B.V.		Beek
64778	100554	Gedimat Michel		St Pierre Du Regard
64779	100555	Eisen Trabandt GmbH		Stade
64780	100556	HSB Handels- u. Servicegesellschaft	für Baumaschinen mbH	Ensdorf
64781	100557	Jacobs-Handelsges. mbH		Hemmingstedt
64782	100558	Salchow & Berger Baubedarf GmbH		Essenbach-Altheim
64783	100559	Baumaschinen Hartmann		Holthusen
64784	100560	OT Facilities Ltd		West Sussex
64785	100561	Köhler GmbH Baumaschinen		Achern
64786	100562	Bauking Südwestfalen GmbH		Waldbröl
64787	100563	ESD Bricotech Bricopro		Beaurepaire
64788	100564	FPC Diffusion		Mommenheim
64789	100565	SAS Francois Perrin		Morestel
64790	100566	CMT Equipment Ltd	Dartford Works	Dartford
64791	100567	Raiffeisen Waren GmbH	NL Halle/Saale	Halle/Saale
64792	100569	Trade Fast Distribution	(Midlands) Ltd	Uttoxeter, Staffordshire
64793	100570	W. Renner GmbH		Weilheim
64794	100571	Röco GmbH		Dortmund
64795	100572	Union Bauzentrum Hornbach GmbH		Dahn
64796	100573	LOESCH shop GmbH		Quickborn
64797	100574	Baucentrum Stewes GmbH & Co. KG		Duisburg
64798	100575	Tout Faire Euromat	Zac Du Breuil	Messein
64799	100576	FIX2PRO		Charenton-le-Pont
64800	100577	Krapp Eisen GmbH & Co.KG		Schneverdingen
64801	100578	Würth HandelsgesmbH		Böheimkirchen
64802	100579	MOBAU Müller Baustoff-Kontor GmbH		Hänichen
64803	100580	MARWITZ Baumaschinenhandel	GmbH & Co.KG	Hamburg 20
64804	100581	WACK Builers Wholesale Ltd	Unit 1 Hawkshaw Farm Business Park	BLACKBURN
64805	100582	Gerätebau Wiedtal - Schützeichel	GmbH & Co. KG	Neustadt/Wied
64806	100583	Plankunde Holland & Belgien		Plankunde
64807	100584	Plankunde DACHL		Plankunde
64808	100585	Walter Gronemeyer KG		Norderstedt
64809	100586	Kinex Oy		Kuopie
64810	100587	J. Materiaux	Tout faire	Vigneulles Les Hattoncha
64811	100588	Tout Faire Sezanne Materiaux		Sezanne
64812	100589	Plankunde Frankreich		Plankunde
64813	100590	SARL Rigaud Materiaux	et Combustibles	Villeneuve De Berg
64814	100591	Tout Faire Mat Bois		Grandpre
64815	100592	Plankunde England		Plankunde
64816	100593	Plankunde England TCG		Plankunde
64817	100594	DEG Dach-Fassade-Holz eG		Rosdorf
64818	100595	BMN Wijcks Den Bosch		Hertogenbosch
64819	100596	Putzier GmbH	Werkzeuge und Eisenwaren	Lünen
64820	100597	UNITED EQUIPMENT & CONSTRUCTION CO	Mr. Usama Ibrahim A. Muathy	Heliopolis
64821	100598	CSH Industries (S) PTE LTD		Singapore
64822	100599	Baustoffe May GmbH		Bamberg
64823	100600	KSA Toolsystems GmbH		Bühl
64824	100601	Yenne Materiaux	Et Combustibles	Yenne
64825	100602	CMPM Folschviller	TMC	Folschviller
64826	100603	Werkzeug-Doering GmbH		Wuppertal
64827	100604	Support System (Nottm) Ltd	Fixings & Fabr.Building Services	Attenborough, Nottingham
64828	100605	Plumbers Choice DIY		Bradford
64829	100606	Teow Herramientas S.R.L.	Playa negra entrada pan dulce,	Puerto Viejo de Talamanca
64830	100607	Neukunden-Angebot DE		Dinklage
64831	100608	Neukunden-Angebot GB		Dinklage
64832	100609	Neukunden-Angebot ENG €		Dinklage
64833	100610	J.A. Sonntag	Inh. Horst Sonntag	Bonn
64834	100611	ElecMec Wholesale Ltd		Middlesex
64835	100612	Neukunden-Angebot NL		Dinklage
64836	100613	Neukunden-Angebot ES		Dinklage
64837	100614	Neukunden-Angebot FR		Dinklage
64838	100615	Midifix SAS		Avignon
64839	100616	HVS Scherer	Inh. Robeer Scherer	Frankfurt
64840	100617	W. Hartmann & Co. (GmbH & Co.KG)		Oststeinbek
64841	100618	Peter Mueller GmbH		Gummersbach
64842	100619	Dach-Fassade-Holz Mittelweser GmbH		Drakenburg
64843	100620	i&M-Bauzentrum Mobau Wechmar	Karl Gerlach & Sohn GmbH & Co.KG	Drei Gleichen
64844	100621	Brand - Cuse	Tout Faire Matériaux	Cuse Et Adrisans
64845	100622	Heinrich Becker Söhne GmbH & Co. KG		Bonn
64846	100623	Karl Birlenbach GmbH & Co.		Limburg
64847	100624	Manfred Klemm		Frechen
64848	100625	SAS Trieves Materiaux - Mens		Mens
64849	100626	Schweizer & Vom Hofe		Wuppertal
64850	100627	Bautreff Pawella GmbH		Bottrop
64851	100628	Tout Faire Girard - Sederon	Girard Bernard Eurl	Sederon
64852	100629	BUCH	Präzisionswerkzeuge GmbH	Hohen Neuendorf
64853	100630	Dieker & Voss GmbH		Gescher
64854	100631	Geveler GmbH & Co. KG		Gronau
64855	100632	Baustoff-Hoffmann GmbH		Kreuztal
64856	100633	Rudolf Graf GmbH & Co. KG		Nagold
64857	100634	Baustoffhandel Remde GmbH		Eisenberg
64858	100635	Qwikfast Trade + DIY Supplies Ltd.		Dorset
64859	100636	KRESS-elektrik GmbH & Co. KG	z.Hd. Frau Kathrin Fischer	Bisingen
64860	100637	Tout Faire Proximat	CAM 53 Pré en Pail	Pre en Pail
64861	100638	Bauzentrum Sandhack GmbH		Schenefeld
64862	100639	Bozel Materiaux		Bozel
64863	100640	T & D Supplies Ltd.	(TD Cladding)	Hull
64864	100641	GIOKAS MPETHANIS S.A		Athen
64865	100642	Meier-Baustoffe		Lauterhofen
64866	100643	Contact Industrial Supplies		Brynmenyn, Bridgend
64867	100644	Roof Business	Torsten Miege	Wutha-Farnroda
64868	100645	Vos Tools		BOOM
64869	100646	Bauzentrum Tönnes	GmbH & Co.KG	Wermelskirchen
64870	100647	Hagema AG		Bäriswil
64871	100648	Wentowsee Handelshaus GmbH	Baustoffhandel und Baumarkt	Gransee
64872	100649	SAS ASTU'PIEUX		Dingsheim
64873	100650	PT AKG Indonesia	Ariobimo Sentral Building 4th floor	Jakarta
64874	100651	Prodhomme - Athis	Prod' Homme B.T.P. S.A.R.L.	Athis De L'Orne
64875	100652	hagebau Profi Fachmarkt	Handelsg. f. Baustoffe mbH & Co.KG	Soltau
64876	100653	Walter Felden		Niederzissen
64877	100654	Achim Schomberg		Bad Wünnenberg
64878	100655	Lenpart Ltd.		London
64879	100656	Bygg Engros AS		Nestun
64880	100657	B. F. Weber	Verpackungs GmbH	Saarbrücken
64881	100658	SAS Comptoir de Materiaux du Port	de Met	Ennery
64882	100659	CMPM Boulay		Boulay
64883	100660	CMPM CREUTZWALD		Creutzwald
64884	100661	CMPM Metz		Metz
64885	100662	CMPM YUTZ		YUTZ
64886	100663	CMPM BETTING LES ST AVOLD		BETTING LES ST AVOLD
64887	100664	ACU Klebeband Rößler GmbH & Co.KG		Wermelskirchen
64888	100665	ENGA Schweißtechnik	Inh. Heinz Arntzen e.K	Salzbergen
64889	100666	Carl Claßen	Eisengrosshandlung	Eschweiler
64890	100667	Service Stock Van Iseghem BVBA		Ingelmunster
64891	100668	Robin Klautzsch	Eisenwaren	Derschen
64892	100669	ILL & CO UG		Wegberg
64893	100670	hagebau centrum	B. Frieling GmbH & Co.KG	Gronau-Epe
64894	100671	Schröder Bauzentrum GmbH Heide	& Co.KG	Heide
64895	100672	SAS Bonnet Matériaux		Chatillon-Saint-Jean
64896	100673	A. Karstensen GmbH & Co.KG		Niebüll
64897	100674	Danetre Workshop Supplies Limited	3 Baird Close	Daventry, Northamptonshire
64898	100675	Raab Karcher Breda		Breda
64899	100676	Hermann Bach GmbH & Co. KG		Paderborn
64900	100677	Schubert Tacke GmbH & Co.KG		Velbert
64901	100678	Kock Sägewerkstechnik OHG		Moorrege
64902	100679	Walter Nilsson GmbH & Co. KG	Baufachzentrum OS-Haste	Osnabrück
64903	100680	Heinrich Küpper e.K.		Gummersbach
64904	100681	Grenzland Baugeräte	Handels GmbH & Co.KG	Hückelhoven
64905	100682	Edmundson Electrical Ltd	Calder House	Blackpool
64906	100683	GAUDELAS		Chailles
64907	100684	NEGOFIX	NEUVIL DISTRIBUTION	Laval
64908	100685	E. Volz Werkzeughandels GmbH		Mayen
64909	100686	Runge-TSN	Technischer Service Nord GmbH	Kisdorf
64910	100687	Taktfest srl		Sat Rosu / Comuna chiajna
64911	100688	SB Tools ltd	Unit 8 Granby Court	Weymouth
64912	100689	Klaus Delvos GmbH		Düsseldorf
64913	100690	Bayrische Bohrerwerke GmbH		Buchlberg, Passau
64914	100691	UHUD TEKN?K HIRDVAT	SAN.VE T?C.LTD.?T?.	Kayseri
64915	100692	Mayrose Lingen GmbH & Co. KG		Lingen
64916	100693	SOSACA Draguignan		Draguignan
64917	100694	Segl Bauzentrum GmbH -	Hagebaumarkt Waldkirchen	Waldkirchen
64918	100695	MIGACUT		Moosburg/Isar
64919	100696	Mobau Dörr & Reiff GmbH		Schleiden
64920	100697	Technolit	Der Werkstattexperte	Großenlüder
64921	100698	Plankunde DACHL HB Gebiet 1		Plankunde
64922	100699	Plankunde DACHL HB Gebiet 9		Plankunde
64923	100700	Vakuum Technik GmbH Eibenstock		Eibenstock
64924	100701	Plankunde DACHL HB Gebiet 7		Plankunde
64925	100702	Plankunde DACHL HB Gebiet 5		Plankunde
64926	100703	Toolfast		Co Wicklow
64927	100704	SAS LAMBERT ET FILS		Marigny ST MARCEL
64928	100705	Plankunde DACHL HB Gebiet 3		Plankunde
64929	100706	Plankunde DACHL HB Gebiet 2		Plankunde
64930	100707	BMN Vlaardingen		Vlaardingen
64931	100708	Richter Baustoffe GmbH	(hagebau kompakt Heiligenhafen)	Heiligenhafen
64932	100709	Gebrüder Löffler GmbH - Baustoffe		Gera
64933	100710	HiKOKI Power Tools	Deutschland GmbH	Willich
64934	100711	BBK Baubedarf Konz GmbH & Co.KG		Wasserliesch
64935	100712	Karl Rother GmbH		Köln
64936	100713	Danhauser GmbH & Co KG		AMBERG
64937	100714	SING KEE METALWARE CO LTD		Tsuen Wan, N.T, Hong Kong
64938	100715	SAS DIAGER		Poligny
64939	100716	Seipel Industriebedarf KG		Hanau
64940	100717	FixMek Oy		Kerava
64941	100718	Wise Ltd		Redditch
64942	100719	A.S.F. Fischer BV		AN Lelystad
64943	100720	EURL VISSERIE ET TECHNOLOGIE	D'ASSEMBLAGE	Yutz
64944	100721	Würth Norge AS		Hagan
64945	100723	Gebrüder Löffler GmbH Baustoffe		Plauen
64946	100724	Raiffeisen Waren GmbH		Neustadt/Orla
64947	100725	BLASTRAC BV		Nieuwegein
64948	100726	Bauking Südwestfalen	FH Attendorn	Attendorn
64949	100727	Jiangsu Sanyeung Tools Co., Ltd.		Danyang City,Jiangsu Province
64950	100728	BMN Nelemans Breda		Breda
64951	100729	BRICOFER		Richwiller
64952	100730	??? "Benzinger Avto"		Tver
64953	100731	Lüttmann Werkzeugmaschinenv. GmbH		Rheine
64954	100732	BWI-Wahl GmbH	Inh. Lothar Wahl	Bonn
64955	100733	Raiffeisen Waren GmbH	Niederlassung DHT Stockstadt	Stockstadt am Rhein
64956	100734	Wocken Industriepartner	GmbH & Co.KG	Meppen-Ems/Nödike
64957	100735	Kull, Ritzert & Hofstetter GmbH		Bingen am Rhein
64958	100736	Hermann Bach GmbH & Co. KG		Nordhausen
64959	100737	Techro GmbH Industrietechnik	Maschinen-Werkzeuge	Roesrath
64960	100738	Arns + Römer  KG		Iserlohn
64961	100739	??? ”??????”	“TIREX” Ltd.	Moskau
64962	100740	Wocken Industriepartner	GmbH & Co. KG	Quakenbrück
64963	100741	Ströbl e.k. Landmaschinen	Fachmarkt	Beilngries
64964	100742	Pegasus Kitchens and Bathrooms		Harrow, Middlesex
64965	100743	Knorpp Baustoffe GmbH		Fellbach
64966	100744	Heribert Sohlmann GmbH	Industriebedarf	Emsdetten
64967	100745	H.-P. Krämer GmbH & Co. KG		Reich
64968	100746	Heykes GmbH	Diamantwerkzeuge	Wiesmoor
64969	100747	BMN Middelburg		Middelburg
64970	100748	hw Hortmann + Wolf GmbH		Siegen-Weidenau
64971	100749	BMN Oldenzaal		Oldenzaal
64972	100750	BMN Rijssen		Rijssen
64973	100751	VR PLUS Altmark Wendland eG		Osterburg
64974	100752	NL Raab Karcher Winnenden	STARK Deutschland GmbH	Winnenden
64975	100753	SAS AIR OUTIL ELECTRIC SERVICE	Z.I les Grandes Raies	Ludres
64976	100754	EURL DONAS PHILIPPE OUTILLAGE		CHATENOIS LES FORGES
64977	100755	Schönamsgruber	Ersatzteile GmbH	Burgbernheim
64978	100756	Gottfried Wiedmann GmbH		Alfdorf
64979	100757	FB Handel und Industrieservice		Torgelow
64980	100758	Express Electrical Distributors	Limited	Wigan
64981	100759	A+B Werkzeuge Maschinen Handels Gmb		Ahaus
64982	100760	Bauking Ostfalen GmbH		Leipzig
64983	100761	LEIGH TIMBER MERCHANTS	UNIT 14	Leigh
64984	100762	PROBEMAT	BigMat	Ste Reine de Bretagne
64985	100763	SOSACA		SAINT MAXIMIN
64986	100764	Kipp & Grünhoff GmbH & Co. KG		Monheim
64987	100766	Neukunde DE		Dinklage
64988	100767	BERGIN Werkzeugmärkte GmbH		Biedermannsdorf
64989	100768	Otto Frackenpohl GmbH & Co.KG		Gummersbach
64990	100769	Su-Re SAS		Pouilly-sur-Loire
64991	100770	Nordwest Handel AG Lager Heller		Dortmund
64992	100771	Nordwest Handel AG		Dortmund
64993	100772	AU FAITE 90 SA		Grandvillars
64994	100773	BVG Cementmüller Baustoffvertrieb	GmbH - hagebaumarkt Soltau	Soltau
64995	100774	MAAS Bauzentrum GmbH		Ilshofen
64996	100775	Baugeräte-Kreis	Nordwest Handel AG	Dortmund
64997	100776	Carl Hossfeld e. Kf.		Hagen
64998	100777	DELVA SHOPPING NV		VEURNE
64999	100778	Bausando GmbH		Bohmte
65000	100779	Nordwest Handel AG	Werkzeug-Kreis	Dortmund
65001	100780	Gebr.Herlitzius	Werkzeuge - Maschinen	Wadersloh
65002	100781	Heller Produktmanagement	Felix Penkhues	Dinklage
65003	100782	Thorsten Draeger Intern		Dinklage
65004	100783	Hubert Blechmann GmbH & Co. KG		Wipperfürth
65005	100784	Lanvers Materiaux	S.A.S.	Nernier
65006	100785	SIG Int Edmonton		Edmonton, London
65007	100786	W & M Urban	Werkzeuge, Maschinen, Eisenwaren	Korntal Münchingen
65008	100787	Toolstation (Daventry) Ltd	Unit 3, Parsons Road	Daventry
65009	100788	hagebaucentrum Bolay GmbH & Co. KG	(Baustoffhandel)	Rutesheim
65010	100789	TCG Allgemein		Dinklage
65011	100790	Mungo Italia S.r.l.		Padova (PD)
65012	100791	SIG Int Leeds Elland Road		Leeds
65013	100792	SIG Ins Witney		Witney
65014	100793	SIG Fixings	Intermezzo Drive	Leeds
65015	100794	Hommel Hercules	Werkzeughandel GmbH & Co. KG	Koeln/Ossendorf
65016	100795	Götz + Moriz GmbH	(Baustoffe)	Freiburg
65017	100796	SIG Int Glasgow Govan		Glasgow
65018	100797	Sievers GmbH		Rheda-Wiedenbrück
65019	100798	Röggi ehf	Mr. Arnar Hrólfsson	Reykjavik
65020	100799	DGS Supplies LTD.	Unit 1&3 Building 38	Dudley
65021	100800	Fortress Fasteners Ltd.	Unit 10, Twin Brook Business Park	Clitheroe
65022	100801	Rutenbeck GmbH & Co. KG		Kerpen-Türnich
65023	100802	One Stop Hire Ltd.		Wrightington
65024	100803	Steinrück GmbH & Co. KG		Wuppertal
65025	100804	Bauking Südwestfalen	Hagebau centrum Meschede	Meschede
65026	100805	Blumenbecker Industriebedarf GmbH		Soest
65027	100806	Heinrich Rießelmann GmbH		Dinklage
65028	100807	Thies & Co GmbH	Fachmarkt	Verden
65029	100808	hagebaucentrum Salzwedel GmbH	(Baustoffe)	Salzwedel
65030	100809	Gebrüder Löffler GmbH -Baustoffe	(Ndl. Weida)	Weida
65031	100810	SIG Int Twickenham		London
65032	100811	SIG Tech Ins Leicester		Leicester
65033	100812	Mölders Baucentrum GmbH	(Niederlassung Adendorf)	Adendorf
65034	100813	Hans Schuy Baustoffgesellschaft	mbH	Langenfeld
65035	100814	E. Wertheimer GmbH	(Baustoffe)	Baden-Baden
65036	100815	E. Wertheimer GmbH	(Baustoffe)	Karlsruhe
65037	100816	Rudolf Sievers GmbH	Partner für Technik	Geesthacht
65038	100817	SIG Ins Bristol Filton		Bristol
65039	100818	Pollin Electronic GmbH		Pförring
65040	100819	Karl Koerschulte GmbH		Lüdenscheid
65041	100820	SIG Ins Cardiff		Cardiff
65042	100821	SIGCA Tyneside		Dunston
65043	100822	Richard Schultheis	Werkzeuge-und Maschinen OHG	Menden
65044	100823	SIG Int Manchester KP		Manchester
65045	100824	Wilhelm Felden & Kaiser & Roth KG	Handels-GmbH & Co.	Marburg
65046	100825	Konrad Schmidt Diamanttechnik		Bensheim-Auerbach
65047	100826	FKR Baucentrum GmbH & Co. KG		Schwalmstadt
65048	100827	Rüschenschmidt & Tüllmann	GmbH & Co. KG	Münster
65049	100828	Consumables Solutions Limited	Unit 4 - Ignition Park	Swindon
65050	100829	Plankunde DACHL HB Gebiet 6		Plankunde
65051	100830	SEEFELDER GmbH	Niederlassung Hamburg	Hamburg
65052	100831	Plankunde Süd-Amerika		Plankunde
65053	100832	Anne-Laure Benveniste Gousis		Agia Paraskevi Athen
65054	100833	Mann Hire Ltd	Plot 4, Rural Industries Estate	Braddan
65055	100834	Giotopoulou Victoria Tools & Safety		Thessaloniki
65056	100835	Profi-Service OHG		Recklinghausen
65057	100836	BMN Den Haag - Zuid		Den Haag
65058	100837	Geco Verhuur en Verkoop		Wijk bij Duurstede
65059	100838	Central Fasteners (Staffs) Ltd		Stafford
65060	100839	NV J. TRENTELS-STEVENS		Mechelen
65061	100840	Denken Peru		Lima
65062	100841	Heller Innendienst		Dinklage
65063	100842	Andreas Seufert		Waldkirchen
65064	100843	KALOUMENOS I. GEORGE & SIA OE	Industrial & Electrical Supplies	Tauros
65065	100844	Muster Neukunden INT		Dinklage
65066	100845	Industrieservice Bauch GmbH		Alsdorf
65067	100846	MABI SARL		Botans
65068	100847	Ulf Neuhaus Industrieservice		Unna
65069	100848	Plankunde Frankreich TCG		Plankunde
65070	100849	Plankunde Holland & Belgien TCG		Plankunde
65071	100850	Ability Supplies UK Limited	5 Frontier Court	Sunderland
65072	100851	Plankunde Iberia TCG		Plankunde
65073	100852	ECONOMOTECHNIKI S.A.		Athens
65074	100853	FIC - Chalon Sur Saone	Fournitures Industr. Chalonnaises	Chalon Sur Saone
65075	100854	Plankunde Süd-Europa TCG		Plankunde
65076	100855	ARVALISCOM SRL		Chisinau Rep.of Moldova
65077	100856	Plankunde Russland TCG		Plankunde
65078	100857	IOANNIS K. DORZIS LTD		Limassol Cyprus
65079	100858	Becker-Jostes GmbH & Co KG		Sundern
65080	100859	Infinite Bargains	Unit 4A	County Durham
65081	100860	Plankunde Ost-Europa TCG		Plankunde
65082	100861	SARL SOC PABION		SOYONS
65083	100862	Plankunde ehem. Soviet Staaten TCG		Plankunde
65084	100863	Plankunde Australien, Asien TCG		Plankunde
65085	100864	August Ring GmbH	Beschläge & Werkzeuge	Velbert
65086	100865	Handelshof Bitterfeld GmbH	Partner für Technik	Bitterfeld-Wolfen
65087	100866	Plankunde Mittlerer Osten,  Afrika	& Indien TCG	Plankunde
65088	100867	OSC Sales Ltd.		Linton, Kent
65089	100868	SL Schraub- und Verbindungstechnik		Düren
65090	100869	SARL SYSCO-SARL		DINGSHEIM
65091	100870	Geert Grüppen GmbH & Co. KG	Baustoffhandel	Emlichheim
65092	100871	BIV Bau- und Industriegeräte	Vertriebs GmbH	Treuen
65093	100872	Plankunde North America TCG		Plankunde
65094	100873	Fra-Tools	J.P. Fracheboud AG	CH-Orpund
65095	100874	Scheins Eurofer Baubeschlag-	handel GmbH	Aachen
65096	100875	Plankunde South America TCG		Plankunde
65097	100876	Ahlborn & Co GmbH	Serienfertigung	Binau
65098	100877	VIOPER		Tavros
65099	100878	Ferd. Beleke	Eisenwaren Werkzeuge	Arnsberg
65100	100879	Orim Middle East FZC	Al Muhanad Tower - App 2704	Sharjah
65101	100880	IB-Norm GmbH		Seligenstadt
65102	100882	AS Jürgen Schnetter e. K.		Schöllkrippen
65103	100884	bewako		Herborn
65104	100885	SASU DACAU INDUSTRIES		Decines Charpieu
65105	100886	Ulrich Bunse		Remscheid
65106	100887	Tacke + Lindemann	Baubeschlag- u. Metallh. GmbH+Co KG	Dortmund
65107	100888	Aerotech Abrasives Group Ltd.	Unit 710, Street 3	Wetherby
65108	100889	Alexander Erasmus GmbH & Co	Eisenwaren-Werkzeuge	Düren
65109	100890	RMB Jäger + Höser GmbH		Neu-Anspach
65110	100891	RMB Jäger + Höser GmbH		Löhnberg
65111	100892	Würth AG		Arlesheim
65112	100893	Bau- und Heimwerkermarkt Müllenhoff	GmbH	Medebach
65113	100895	Franko	Werkstattechnik GmbH	Himmelkron
65114	100896	EURL ATOUTBAT		Angoisse
65115	100897	Profi Partner Sp. z o.o.	i Wspólnicy Sp.k.	Warszawa
65116	100898	Fröschke Spezialbaustoffe	Alexander Fröschke	Sonnewalde OT Münchhausen
65117	100899	Gustav Kampmann GmbH	Baumasch.-Baugeraete	Neuss 1
65118	100900	Watermann & Co	Eisenwaren - Werkzeuge	Hagen
65119	100901	Steinrück GmbH & Co. KG		Düsseldorf
65120	100902	RG5 SAS- ROUSSEAU QUINCAILLERIE		Albi
65121	100903	PROXIMAT	TOUT FAIRE VARADES	Varades
65122	100904	Erich Winkler GmbH		Luedenscheid
65123	100905	Blumenbecker Industriebedarf GmbH	Niederlassung Voss Hagen	Hagen
65124	100906	Alexandria Progress Trading Co.	Import license no 5052	Cairo
65125	100907	Van Wijngaarden Groothandel B.V.		Sliedrecht
65126	100908	SAS LORCAMAT		LEMUD
65127	100909	Hoffnung Korea		Haenameup, Haenamgun, Jeonnam
65128	100910	SARL P.S.D.		NORROY LE VENEUR
65129	100911	Neuberger GmbH - Werkzeugservice	CNC-Schleif-Service-Center	Villingen-Schwenningen
65130	100912	Wember GmbH		Hattingen
65131	100913	SA Sablemat		Montois La Montagne
65132	100914	D Macfarlane & Son Ltd		Gateshead, Tyne & Wear
65133	100915	Berndt Deubner GmbH & Co	Baumaschinen und Baugeräte	Aachen
65134	100916	BWM (Baugeräte Werkzeughandel	Minden) GmbH	Minden
65135	100917	Berkenhoff & Thiel GmbH & Co. KG		Hemer
65136	100918	Kleinlein Bauzentrum GmbH		Waltenhofen
65137	100919	BMN Apeldoorn - Zuid		Apeldoorn
65138	100920	BMN Arnhem - Oost		Arnhem
65139	100921	Einkaufsbüro Deutscher      FORMAT	Eisenhändler GmbH	Wuppertal
65140	100922	Universal Tool Hire & Supplies	Patrick William Cuss Christopher	Westbury, Wilts
65141	100923	BMN Assen - Noord		Assen
65142	100924	CMEM		CMEM
65143	100925	Einkaufsbüro Deutscher     HELLER	Eisenhändler GmbH	Wuppertal
65144	100926	BMN Ede		Ede
65145	100927	Dönges GmbH & Co KG		Wermelskirchen
65146	100928	BMN Emmeloord		Emmeloord
65147	100929	POMPAC	ehem. COMAFRANC	POMPAC
65148	100930	BMN Goor		Goor
65149	100931	E/D/E GmbH	Fachkreis Premium	Wuppertal
65150	100932	Nettelbeck GmbH		Wuppertal
65151	100933	Einkaufsbüro Deutscher	Eisenhändler GmbH	Wuppertal
65152	100934	ESPACE EMERAUDE		ESPACE EMERAUDE
65153	100935	BMN Groningen - Oost		Groningen
65154	100936	E/D/E GmbH	Fachkreis Union Werkzeug Handel	Wuppertal
65155	100937	E/D/E GmbH	Fachkreis Werkz./Masch.	Wuppertal
65156	100938	E/D/E GmbH	Fachkreis Handwerkstadt	Wuppertal
65157	100939	BMN Hengelo - Oost		Hengelo
65158	100940	GEDIMAT		GEDIMAT
65159	100941	SA SO SA CA		La Motte
65160	100942	Höynck&Spengler GmbH		Iserlohn
65161	100943	AUBERN		AUBERN
65162	100944	BMN Hillegom		Hillegom
65163	100945	Franzen Schweissbedarf GmbH		Düren
65164	100946	CMPM		CMPM
65165	100947	France Materiaux	SAS	Chambéry
65166	100948	Groupamat		Groupamat
65167	100949	EIS Kooperationszentrale GmbH		Köln
65168	100950	STARMAT		STARMAT
65169	100951	TOUT FAIRE		TOUT FAIRE
65170	100952	BIGMAT		BIGMAT
65171	100953	BMN Hilversum		Hilversum
65172	100954	BMN Kampen		Kampen
65173	100955	Hohoff GmbH	Fachh. f. Werkzeuge & Maschinen	Unna
65174	100956	E.D.E. GmbH Fachkreis Maschinen	für Holz- u. Kunststoffbearbeitung	Wuppertal
65175	100957	BMN Leeuwarden - Oost		Leeuwarden
65176	100958	E.D.E. GmbH	Fachkreis 6 Plus""	Wuppertal
65177	100959	BMN Nieuwleusen		Nieuwleusen
65178	100960	BMN Nijmegen		Nijmegen
65179	100961	Rommelmann GmbH		Münster
65180	100962	E.D.E. GmbH	Fachgruppe IMATEC""	Wuppertal
65181	100963	NOBEX s.r.l.		Siziano (PV)
65182	100964	BMN Raalte		Raalte
65183	100965	AC EMERAUDE SARL	ESPACE EMERAUDE - JETTIGEN	JETTINGEN
65184	100966	BMN Tiel		Tiel
65185	100967	die beschaffer ag	z.Hd. Herrn Martin Krebs	Zürich
65186	100968	BMN Vriezenveen		Vriezenveen
65187	100969	ABT - Allgemeine Befestigungs-	technik	Marl
65188	100970	SAP-Matériaux	SAS TRANSPORT ET MATERIAUX	ARDENTES
65189	100971	E/D/E GmbH	Fachkreis Plus 1	Wuppertal
65190	100972	BMN Waddinxveen		Waddinxveen
65191	100973	SOSACA HELLER - MONTAUROUX	SOSACA	MONTAUROUX
65192	100974	BMN Wolvega		Wolvega
65193	100975	BMN Zutphen		Zutphen
65194	100976	SARL DIAMPRO		WITTELSHEIM
65195	100977	LA CAISSE A OUTILS		EPINAL
65196	100978	BMN Zwolle - Zuid		Zwolle
65197	100979	ETAG Fixings UK	Unit 14E Thames Gateway Park	Dagenham, Essex
65198	100980	ZEUX GmbH & Co. KG		Eschelbronn
65199	100982	LANDMAXX BHG GmbH		Coswig
65200	100983	SOSACA - LES ARCS		LES ARCS
65201	100984	Quincaillerie Corrihons EURL		Saint Pierre du Mont
65202	100985	Roland Lünnemann GmbH		Leverkusen
65203	100987	Baustoffe Geulen GmbH & Co. KG	(Ndl. Würselen)	Würselen
65204	100988	SARL Anderson		ST FIEL
65205	100989	CMPM SARREGUEMINES		SARREGUEMINES
65206	100990	BAUKING Südwestfalen GmbH	(Ndl. Eslohe)	Eslohe
65207	100991	Allo Sales	C/O Kerry Plant & Toolhire Ltd.	Co Kerry
65208	100992	Gebhardt Bauzentrum GmbH		Erlangen
65209	100993	BHG Handelszentren GmbH	(Ndl. Leuthen Baustoffe)	Drebkau / OT Leuthen
65210	100994	Geveshausen - Technischer Handel		Hude-Altmoorhausen
65211	100995	PERRIN MATERIAUX - BOURGOIN	SAS PERRIN MATERIAUX	BOURGOIN JALLIEU
65212	100996	H. Schönenbröcher GmbH		Bergisch-Gladbach
65213	100997	FRANCOIS PERRIN - PORCIEU	MATERIAUX de CONSTRUCTION	PORCIEU-MONTALIEU
65214	100998	RFM Construction Products(M)Sdn.Bhd	No. 37 Jalan Serendah 26/41	Shah Alam - Selangor Darul Ehs
65215	100999	B. Friebertshäuser		Gladenbach
65216	101000	AMW Store		Bad Zwischenahn - Petersfehn
65217	101001	Gebhardt Bauzentrum GmbH	(Ndl. Karlstadt)	Karlstadt
65218	101002	Westfalia	Werkzeugcompany GmbH & Co.KG	Hagen
65219	101003	Gebhardt Bauzentrum GmbH	(Ndl. Fürth)	Fürth
65220	101004	Gebhardt Bauzentrum GmbH	(Ndl. Hammelburg)	Hammelburg
65221	101005	Ferney Group BV	BONUSABRECHNUNG	Heerhugowaard
65222	101006	Gebhardt Bauzentrum GmbH	(Ndl. Höchberg)	Höchberg
65223	101007	J. + F. Sorg GmbH		Düsseldorf
65224	101008	Guillaume Dufour	Tabac Presse Franck Saniard	Le Puy En Velay
65225	101009	Vantaan Kiinnike ja Rak Oy		Helsinki
65226	101010	Lentz & Schmahl GmbH & Co.KG		Koeln
65227	101011	EURL Mecahydrau		Sarralbe
65228	101012	PETITJEAN EIRL	Stéphane	RUESLISHEIM
65229	101013	Gödde GmbH		Köln
65230	101014	SAS ETABLISSEMENTS BONNEPART		Savigny
65231	101015	BVG Cementmüller Baustoffvertrieb	GmbH & Co. KG	Munster
65232	101016	GRUPO RECSA		Guatemala City
65233	101018	SARL Outils Nancy		Nancy
65234	101019	SAS SGE Energie		Saint-Paul-de-Varces
65235	101020	Delmes Heitmann GmbH & Co. KG	(Niederlassung Kirchwerder)	Hamburg
65236	101021	Schrauben Schmid GmbH		Dresden
65237	101022	Flynn Hardware Supplies Ltd.		Co Mayo
65238	101023	Carbide UK Limited	Rotary House, Bontoft Avenue	Hull, East Yorkshire
65239	101024	Biesheuvel Group BV		Eindhoven
65240	101025	Keilbach Befestigunssysteme		Mühlhausen
65241	101026	IZOSERVICE sp.z.o.o.		Marki Polen
65242	101027	Befestigungs-Technik-Reim	Inh. Sylvia Huber	Heichelheim
65243	101028	Kipp & Grünhoff GmbH & Co. KG	(Ndl. Sinzig)	Sinzig
65244	101029	S-IB Schütz Industriebedarf GmbH		Düsseldorf
65245	101030	Christian Steinbach	Werkzeug-Maschinen Eisenwaren	Köln-Nippes
65246	101031	Baucentrum Stewes GmbH & Co. KG	(Baustoffe)	Gladbeck
65247	101032	Van Buuren B.V.	Centraal Magazijn Rijssen	Rijssen
65248	101033	AMS SARL	Affutage Muhlousien & Sundgauvien	LUTTERBACH
65249	101034	NIKAMALI TRADE DOO		IN?IJA
65250	101035	Becker-Werkzeuge	Bernd Becker	Alsdorf
65251	101036	Au Faite 25		Mamirolle
65252	101037	Gerke & Grüger GmbH		Arnsberg
65253	101038	Zweck GmbH	Autoteile & Werkzeuge	Neuruppin
65254	101039	SAS OUTILLAGE 57		Saint Avold
65255	101040	Heinz Schieber Werkzeuge OHG		Weissach im Tal
65256	101041	Metallbau Franz-Peter Mülfarth e.K.		Brühl
65257	101042	B.K. Components		Omagh, Co. Tyrone
65258	101043	UBB S.R.L.		Cormano
65259	101044	Profdewalt		Minsk
65260	101045	JFJ MATERIEL - VERTOU SARL		VERTOU
65261	101046	Lingemann GmbH		Brühl
65262	101047	Krüger Hannover GmbH & Co. KG		Ronnenberg
65263	101048	Bohle AG		Haan
65264	101049	CREUZE MATERIAUX	TOUT FAIRE BESANCON	BESANCON
65265	101050	Dresen e. K.		Duesseldorf
65266	101051	Aug. Hülden GmbH & Co.KG	Groß- und Einzelhandel	Düren
65267	101052	OKOV d.o.o.		Podgorica Montenegro
65268	101053	Jacob GmbH		Uffenheim
65269	101054	MK TRADE FZE		Ras Al Khaimah
65270	101055	Marsilio Group Srl		Padova
65271	101056	Karl Westhelle + Sohn	Werkzeuge	Olsberg
65272	101057	Geißler & Kuper GmbH		Celle
65273	101058	Mobau Wirtz & Classen GmbH & Co. KG		Ratingen
65274	101059	Distrimat SARL		Pulnoy
65275	101060	Mobau Dörr & Reiff GmbH		Mechernich-Kommern
65276	101061	FIXECO - BAUDRICOURT	Tout Faire	BAUDRICOURT
65277	101062	Eisen-Busch GmbH		Rheine
65278	101063	Michael Feld Sales		Ennepetal
65279	101064	Delmes Heitmann GmbH & Co. KG	(Ndl. Schwarzenbek)	Schwarzenbek
65280	101065	MUL10 Metal A/S		Juelsminde
65281	101066	KENETA		Ferizai
65282	101067	Wocken Industriebedarf	GmbH & Co. KG	Salzbergen
65283	101068	AFG Technische Lagerhaltungs-	und Vertriebs GmbH	Wilhelmshaven
65284	101069	Heller UK Maximum Discounts		Test
65285	101070	BHG Handelszentren GmbH	(Ndl. Finowfurt Baustoffe)	Schorfheide / OT Finowfurt
65286	101071	Bauvista GmbH & Co. KG	Großhandel	Neuss
65287	101072	Bauking Ostfalen GmbH	(Ndl. Gardelegen)	Gardelegen
65288	101073	BAUKING Südwestfalen GmbH	(Bauzentrum Olpe)	Olpe
65289	101074	Schikorra GmbH		Dresden
65290	101075	EURL MCC PERNEY		Lure
65291	101076	Kutzner Befestigungssysteme		Demitz-Thumitz / OT Stacha
65292	101077	SIVA Baustoffhandel GmbH		Berlin
65293	101078	SARL JIM BRET		Plateau D'Hauteville
65294	101079	Eisen Ruland	Inh. Volker Nastaly e.K.	Bedburg/Erft
65295	101080	BMN Amsterdam - Zuidoost		Amsterdam
65296	101081	K. H. Flossbach GmbH		Wipperfuerth
65297	101082	N A Stenteknik AB		Åtorp
65298	101083	Dapetz Ltd.		London
65299	101084	Beck & Co.	Industriebedarf GmbH & Co.KG	Dortmund
65300	101085	Aufdemkamp GmbH	Elektrogrosshandel	Lippstadt
65301	101086	SIG Int Maidstone	Unit 5, Larkfield Mill	Maidstone, Kent
65302	101087	CVS TEKNIK YAPI LTD. STI		Istanbul
65303	101088	August Hülden GmbH & Co KG		Köln
65304	101089	Proximat		Laval Cedex 9
65305	101090	EURL QUINCAILLERIE FRANCOMTOISE		Vauvillers
65306	101091	I&M Bauzentrum Joachimmeyer	GmbH & Co. KG	Bohmte-Hunteburg
65307	101092	Hans Einhell	Vertriebsgesellschaft mbH	Landau-Isar
65308	101093	Matthias Bäßler	Befestigungssysteme	Geithain
65309	101094	Imperial House		Mamer
65310	101095	PRODEX- NELS NV		Hasselt
65311	101096	HBH GmbH & Co. KG		Lauda Königshofen
65312	101097	BMN IJzerwaren Eindhoven		Son en Breugel
65313	101098	Heuer GmbH & Co. KG		Timmendorfer Strand
65314	101099	Durand	Tout faire Materiaux	FOUG
65315	101100	Detlef Paulsen Betriebsbedarf	GmbH & Co. KG	Flensburg
65316	101101	Wilhelm Marx + Co. KG		Frankfurt am Main
65317	101102	Eisen-Schmidt GmbH & Co.	Eisenwaren	Amberg
65318	101103	Perrin Materiaux SAS		Rochetoirin
65319	101104	EJOT Schweiz AG	Baubefestigung	Dozwil
65320	101105	SAS RAO RHONE ALPES OUTILLAGE		Seyssins
65321	101106	BMN Eindhoven - West		Eindhoven
65322	101107	Horst Jourdan	Jourdan Hartwaren Handels GmbH	Mörfelden-Walldorf
65323	101108	IMA Industriemaschinen und	Geräte GmbH	Rednitzhembach
65324	101109	Maschinen & Werkzeuge Maik Schulz		Berlin
65325	101110	Linzmeier Baustoffe GmbH & Co. KG		Laichingen
65326	101111	ANJOU MAINE COUVERTURE SARL		SABLE SUR SARTHE
65327	101113	Danhauser GmbH & Co. KG Baustoffe	(Ndl. Regensburg)	Regensburg
65328	101114	Zapf GmbH	Baustoffe & Sanitär	Lichtenfels
65329	101115	Powertech Industrial LTD	Norwood Ind Estate	Sheffield
65330	101116	One Stop Hire Ltd.		Widnes
65331	101117	East Cornwall Trading	Unit 1 Enterprise Park	Saltash,Cornwall
65332	101118	SAS LANGON DISTRIBUTION	BATI LECLERC	Mazeres
65333	101119	GWS- Werkzeug	Peter Kratschmer	Badbergen
65334	101120	SA S A I P A SOCO		Serres-Castet
65335	101121	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
65336	101122	S&R Industriewerkzeuge GmbH		Gundelfingen
65337	101123	Süddeutsche Baumaschinen	Handels GmbH	Kempten
65338	101124	Conrad Electronic SE		Hirschau
65339	101125	Konak Handels &	Dienstleistungs GmbH	Berlin
65340	101126	Chaco GmbH		Dernbach
65341	101127	Michael Engelhardt	Handelsvertretung	Föritztal OT Neuhaus-Schiersch
65342	101128	Drill One Trading and Contracting	AL MUNTAZAH , AL ANDALUS PETROL	Doha
65343	101129	Lorraine Fixation		Sainte Marie aux Chenes
65344	101130	TRAVES MATERIAUX		Traves
65345	101131	Werkzeug Roloff GmbH	Werkzeug	Magdeburg
65346	101132	Mölders & Scharff	Bauzentrum GmbH & Co. KG	Hamburg
65347	101133	Eisen Würz GmbH		Furth im Wald
65348	101134	Werkzeug Pohl		Magdeburg
65349	101135	Gillet Baustoffe GmbH		Landau/Pfalz
65350	101136	TRUCHON S.A.		CHAPAREILLAN
65351	101137	SARL FI-LOG	VAL EUROMOSELLE SUD	Feves
65352	101138	Lormatem Big Mat		Velaines
65353	101139	SASU LIMABAT	ZONE INDUSTRIELLE	Hesingue
65354	101140	Insite Systems Inc.		Mentor
65355	101141	SAS APPROVISIONNEMENTS OUTILS	DIAMANTS	Barberaz
65356	101142	ASD		Illange
65357	101143	SPIELMAT BIG MAT	A l'attention de Christophe Delion	Colmar
65358	101144	HV-Michel techn. Großhandel		Rodalben
65359	101145	REVENDEUR SPÉCIALISÉ		REVENDEUR SPÉCIALISÉ
65360	101146	JF Equipment et Distribution		MONSWILLER
65361	101147	K&N Accesories LTD		Leigh
65362	101148	Van der Winkel Den Bosch		Den Bosch
65363	101149	SAS AXIMAT		Saint Genest Lerpt
65364	101150	H.D. Hunger GmbH		Kirchlengern
65365	101151	Vimafer LTDA		Bogota
65366	101152	BBH BauBedarf Hagedorn GmbH		Greußen
65367	101153	Superba S.A		San Jose
65368	101154	KVADRAT SYSTEMS LLC - Office 2002	Silver Towers, Business Bay	Dubai
65369	101155	TDH - GmbH	Technischer Dämmstoffhandel	Hamburg
65370	101156	Wolf Drucklufttechnik GmbH		Triptis
65371	101157	Paul Wünn GmbH & Co.KG		Coburg
65372	101158	1ASchrauben.de	kroboth & scharf GbR	Utzberg
65373	101159	DTS Baumanagement	Anton Sommer	Mainhausen
65374	101160	Gedimat Pochon		Montrevel-en-Bresse
65375	101161	Materiaux de l'Isac	BIGMAT	Blain
65376	101162	HAUT DOUBS BOIS	GEDIBOIS	COLLONGES LES PREMIERES
65377	101163	E&S Industriebedarf GmbH		Bruck/Opf.
65378	101164	Fa. Horst Häusler	Gewerbepark Mariatal	Ravensburg
65379	101165	Beal PH (BEAL)	Zone Industrielle	Cournon
65380	101166	BAUSTOFF UNION GmbH	(Ndl. Langenzenn)	Langenzenn
65381	101167	BMN IJzerwaren Rotterdam	Spaanse Polder	Rotterdam
65382	101168	Gohire Group Ltd		Hull
65383	101169	Bouwmarkt Groenen B.V.		Veldhoven
65384	101170	John Gibson Hire and Sales		Middlesbrough
65385	101171	A&G Stahlverarbeitungs- und	Vertriebs GmbH	Saalfeld
65386	101172	SAS AD HOC'LOC		St Etienne
65387	101173	BAUKING Südwestfalen GmbH	(Ndl. Neunkirchen)	Neunkirchen
65388	101174	J.N. Köbig GmbH	(Ndl. Friedberg-Ockstadt)	Friedberg-Ockstadt
65389	101175	COBA-Baustoffgesellschaft	für Dach + Wand GmbH & Co. KG	Osnabrück
65390	101176	Michael Aschenbrenner		Abensberg
65391	101177	MARKANT Handels und Industriewaren	Vermittlungs AG	Pfaeffikon / SZ
65392	101178	Lasaulec B.V.	001 Centraal Heerenveen	Heerenveen
65393	101179	PRECHTEL GmbH	c/o Richard Köstner AG	Forchheim
65394	101180	Die Werkzeugprofis	Werkzeughandels-GmbH	Regensburg
65395	101181	Gebr. Mayer GmbH & Co.KG		Fürth
65396	101182	Schwemmer & Dorn+ Co. GmbH	Qualitätswerkzeuge	Fürth
65397	101183	Höck-Jansen GmbH		Overath
65398	101184	Handelsunternehmen Dineiger GmbH		Berching OT Pollanten
65399	101185	Pro-Coop	-Rabattring-	Grobbendonk
65400	101186	Gerhard Hof GmbH		Mühlheim/Main
65401	101187	EGENITRO LTD. STI.		Izmir
65402	101188	SARL MTT		Soultz-Sous-Forets
65403	101189	Runser Matériaux		MICHELBACH-LE-HAUT
65404	101190	GHANCHI IBRAHIM NOORMOHD Y BROS	Fatemabai smailji Alibhoy	Karachi
65405	101191	Fikstek Baglanti Teknolojileri San.	ve Tic. LTD. STI.	Ümraniye / Istanbul
65406	101192	Lamberts Tools & Welding Supplies		Essex
65407	101193	StahlPartner Mitte GmbH		Weilburg
65408	101194	Fidel Schub GmbH & Co. KG	Filiale Sax	Schwandorf
65409	101196	Arthur Friedrichs Industriebedarf	GmbH	Bremerhaven
65410	101197	ECEF Srl		Peschiera Borromeo (MI)
65411	101198	Baustoffe Geulen GmbH & Co. KG		Aachen
65412	101199	Profi Geuder GmbH		Uffenheim
65413	101200	Schiffauer GmbH & Co. KG		Kronach/Bay.
65414	101201	Mobau Profi Zentrum	Wirtz & Classen GmbH & Co. KG	Mönchengladbach
65415	101202	Michel's Schraubenquelle	Technischer Groß- und Einzelhandel	Ladeburg
65416	101203	Impulse 24 Vertriebs GmbH		Plaidt
65417	101204	SAS ISOMAT		RICHWILLER
65418	101205	BAUKING Südwestfalen GmbH	(Ndl. Betzdorf)	Betzdorf
65419	101206	PROMAT	Société	Corbeil-Essonnes
65420	101207	BAUKING Ostfalen GmbH	(Ndl. TBZ Braunschweig)	Braunschweig
65421	101208	IK-Trading		Bochum
65422	101209	UNION Bauzentrum HORNBACH GmbH		Neuhofen
65423	101210	SOSACA Grimaud		Grimaud
65424	101211	Robert Dehnel	Inh. T. Helmholz	Krefeld
65425	101212	CRAMAT	France Matériaux	St. Denis les Bourgs
65426	101213	SASU Pro Appro		TOUL
65427	101214	A.J. Freialdenhoven GmbH & Co. KG		Inden
65428	101215	SAS MADIMAT		Marcillac St Quentin
65429	101216	Innotec Construction Supplies		Carlisle
65430	101217	G.F. Lotter GmbH	Werkzeuge Maschinen	Neutraubling
65431	101218	Floor and Wall Tiles Ltd.		Northampton
65432	101219	Holz Michelsen		Lübeck
65433	101220	ESD Bricotech Bricopro		Ruy
65434	101221	Segl Bauzentrum GmbH		Pfarrkirchen
65435	101222	NL Raab Karcher Rostock	STARK Deutschland GmbH	Rostock
65436	101223	Mayrose-Weener GmbH & Co. KG		Weener
65437	101224	COFAQ		COFAQ
65438	101225	BRICOPRO		BRIC0PRO
65439	101226	One Stop Hire		Chorley
65440	101227	SARL VIMES CELHAY		Preignac
65441	101228	Mark Smethurst		Blackrod, Bolton
65442	101229	Dachdecker-Einkauf Ost eG	Zweigniederlassung Leipzig	Leipzig
65443	101230	Chr. Forkel	Inh. Erich Forkel	Rödental
65444	101231	RAO - SPIT KUNDE	Rhone Alpes Outillage	Seyssins
65445	101232	SOCADA		SOCADA
65446	101233	Quincaillerie Bourbonnaise		Cusset
65447	101234	O.K. Werkzeugservice	Olaf Jentzsch	Langenweißbach
65448	101235	Eisen - Keitel		Rothenburg o.d.T.
65449	101236	Baustoff Netzband GmbH	Niederlassung Ziesar	Ziesar
65450	101237	Mapeco Turnhout N.V.		Turnhout
65451	101238	EURL ATELIER TP 47		Fauillet
65452	101239	bernaTech GmbH		Bern
65453	101240	Sollenberg S.	VERKTYGSAKTIEBOLAG	Hässleholm
65454	101241	Eisenhandel Prell GmbH + Co.KG		Schwabach
65455	101242	SASU CG2BCOM		La Rajasse
65456	101243	Sax GmbH	Werkzeuge-Autoteile	Schwandorf
65457	101244	EFCO Befestigungstechnik AG		Nänikon
65458	101245	Julius Friedr. Krönlein	Fachgroßhandel f. Baubedarf	Schweinfurt
65459	101246	P.S. Building Supplies Ltd.		Essex
65460	101247	DTH Diamant und Kernbohrtechnik	Reinhard Nelius	Lahnstein
65461	101248	OOO AstErabel		Grodno-Weisrussland
65462	101249	DRIFFIELD ELECTRICAL SUPPLIES LTD		Driffield
65463	101250	ELG Baustoffhandel Calau eG		Calau
65464	101251	LUSARO,s.r.o.		Košice
65465	101252	Obernberger Baumaschinen		Mannswörth
65466	101253	Eisen Knorr GmbH		Weiden
65467	101254	Mathias Jörling		Frankfurt am Main
65468	101255	Rogger Fasteners AG		Grossaffoltern
65469	101256	Profnorm Kampen B.V.		Kampen
65470	101257	Hanseatic Trade Company e.K.		Stuhr - Brinkum
65471	101258	Alubogencenter.de	Inh. Rolf Brendemühl	Buchholz
65472	101259	S Fixations system		Kingersheim
65473	101260	Ideas Civiles S. A.		Medellin
65474	101261	Gebr. Reinhard GmbH & Co.KG	Stahlhandel	Würzburg
65475	101262	SAS Foussier		Allonnes
65476	101263	Handelshof Stendal GmbH	Filiale Nowaweser	Brandenburg an der Havel
65477	101264	Fischer Austria G.m.B.H.		Möllersdorf / Traiskirchen
65478	101265	A SILVA FERRAGENS LTDA		Cricuima
65479	101266	Kurt König Baumaschinen GmbH		Sangerhausen
65480	101267	Schwing Fachgroßhandel GmbH		Röllbach
65481	101268	MAWETEC	Inh. Mirko Neundorf	Lauchhammer - West
65482	101269	M.I.T GmbH		Mühlheim/Main
65483	101270	Krüger & Scharnberg GmbH	(Standort Wentorf)	Wentorf
65484	101271	Aryan Enterprises Ltd.		Middlesex
65485	101272	Deqob		Cluses
65486	101273	Kanne Werkzeugtechnik GmbH		Northeim
65487	101274	Keizer & Cuvelier B.V.		Nieuw-Vennep
65488	101275	DOMPRO		DomPro
65489	101276	Amazon EU Sarl	Niederlassung Deutschland	München
65490	101277	AWIK International e.K.	Inh. Martin Moldenhauer	Celle
65491	101278	Amazon EU Sàrl / Amazon Media EU	Sàrl	Luxemburg
65492	101279	Engweld-A brand name of Energas Ltd		Birmingham, West Midlands
65493	101280	Raiffeisen Waren GmbH	(Ndl. Eichenzell-Welkers)	Eichenzell-Welkers
65494	101281	Ludwig International GmbH		Köln
65495	101282	Salzbrunn Werkzeuge		Langenfeld
65496	101283	Amazon Fulfillment Poland sp.z o.o.		Bielany Wroclawskie
65497	101284	Eisen - Jacob e.K.	Groß- und Einzelhandel	Aschaffenburg
65498	101285	Amazon EU SARL	Niederlassung Tschechien	Dobroviz
65499	101286	Raiffeisen Waren GmbH	(Ndl. Wolfhagen)	Wolfhagen
65500	101287	THS Tools Group	Salisbury House	Templeborough, Rotherham
65501	101288	Franz Jos. Then	Eisenhandlung	Dettelbach
65502	101289	Günther Fachhandel GmbH & Co.KG		Bad Neustadt/Saale
65503	101290	DMG Gustke GmbH		Leverkusen
65504	101291	Kurt Greiner GmbH	Neues & Bewährtes	Erlangen
65505	101292	SMB	Monsieur Jérémie	Beaurepaire
65506	101293	Quincaillerie Roy		Rives sur Fure
65507	101294	Davidi-Werkzeugtechnik	Handels GmbH	Erkrath
65508	101295	White Drive Motors and Steering	sp. z o.o	Kobierzyce
65509	101296	Raiffeisen Waren GmbH	(Ndl. Braunschweig)	Braunschweig
65510	101297	Dagar Tools Ltd.		Shropshire
65511	101298	Raiffeisen Waren GmbH	(Ndl. Keil Heuchelheim)	Heuchelheim
65512	101299	DIMU Dieter Muthmann GmbH		Berlin
65513	101300	Gannaz Matériaux		Sallanches
65514	101301	B+BTec	Boor- + Bevestigingstechniek BV	Zevenbergen
65515	101302	CQFB	Comptoir de Quincaillerie &	MARANGE SILVANGE
65516	101303	Otto Röhrs GmbH	NL Quelkhorn	Ottersberg
65517	101304	EURL EURL STDI		MARANGE SILVANGE
65518	101305	Technischer Handel Nienhagen		Nienhagen
65519	101306	Workshop Nagel e.K.	Christian Nagel	Berlin
65520	101307	Seifi David	Machine Engineering, Maschinenbau	Teheran Iran
65521	101308	Raiffeisen Waren GmbH	(Ndl. Keil Reiskirchen)	Reiskirchen
65522	101309	SAS QUEGUINER MATERIAUX		Landivisiau  cedex
65523	101310	SAS SCHARRENBERGER		Soultz sous forêts
65524	101311	Georg Altenburg GmbH & Co. KG		Bückeburg
65525	101312	JS Fournitures Sarl		Soultz sous Forets
65526	101313	MCD		MCD
65527	101314	SARL Outil-Loc		Hochfelden
65528	101315	Wittmann-Komet	Metal Cutting Saws GmbH & Co. KG	Weil am Rhein
65529	101316	Rudolf Martin	Handelsvertretung	Schnaittenbach
65530	101317	M. Lautwein	Haushaltswaren - Werkzeug	Bitburg
65531	101318	Rhino Plant Hire		Doddinghurst, Essex
65532	101319	Elite Fasteners Ltd.		West Midlands
65533	101320	Handelshof Stendal GmbH	Partner für Technik	Osterburg
65534	101321	Werkzeug Vertrieb GmbH		Aschaffenburg
65535	101322	Possling GmbH & Co.KG		Berlin
65536	101323	Possling GmbH & Co.KG		Berlin
65537	101324	SAN KEOKO TRADING CO., LTD		New Taipei City R.O.C
65538	101325	Andreas Dierken	Heller Tools GmbH	Dinklage
65539	101326	Batimance	Colorance	Vienne
65540	101327	SAS MAC HOM TER	Brico Pro	Chemillé
65541	101328	Quincaillerie DOUESSINE		Doue la Fontaine
65542	101329	Agimus KG		Mellingen
65543	101330	SARL Paris Nord Matériaux		St. Maur de Fosses
65544	101331	Ferrodo-Poznan Sp. zo.o.		Poznan
65545	101332	St.-Vitus-Werk Gesellschaft für	heilpädagogische Hilfe mbH	Meppen
65546	101333	Brielmaier Baumaschinen GmbH		Ravensburg
65547	101334	Fassadengrün e.K.	Inh. Sven Taraba	Leipzig
65548	101335	BONEKO LTD	Mr. Vladimir Nedelchev	Petrich Bulgaria
65549	101336	Viktor Maurer ViMa-Tech		Cloppenburg
65550	101337	Nikolaj Ljabach		Hildesheim
65551	101338	MAVIZ s.r.o.		Vrable
65552	101339	Oechsner GmbH & Co KG	Bauzentrum - Fliesen - Bauelemente	Freilassing
65553	101340	BAUKING Weser-Ems GmbH	Niederlassung Lohne	Lohne
65554	101341	CMPM HUNDLING		Hundling
65555	101342	Bauzentrum Rüppel GmbH		Florstadt
65556	101343	Zeppelin Rental GmbH & Co.KG	Zentrale - Profi Baushop	Freiburg
65557	101344	Tackit GmbH		Nürnberg
65558	101345	Tashev - Galving Ltd.	Marina Staykova	Sofia Bulgaria
65559	101346	Reiner Auge Bauwerkzeuge		Hennef-Söven
65560	101347	Baustoff Union GmbH		Nürnberg
65561	101348	Cofermeta Sa		Belo Horizonte
65562	101349	Ludwig International GmbH		Köln
65563	101350	FSS-FULL-SERVICE GESMBH		Wiener Neudorf
65564	101351	Isero - Regts Joure		Joure
65565	101352	SORETI COMERCIAL LTDA		BELO HORIZONTE
65566	101353	Bennewitzer Raiffeisen Handels GmbH	(Baustoffhandel)	Bennewitz
65567	101354	Thor Helical Deutschland	Heuer GmbH & Co. KG	Timmendorfer Strand
65568	101355	IP Berlov E.S.		Moskau
65569	101356	VC Materials Limited		London
65570	101357	EURL MFCS		Irigny
65571	101358	CRETEC CO. LTD		DAEGU
65572	101359	Geurts Machines BV		America
65573	101360	MAES EN ZONEN NV		Kasterlee
65574	101361	UPR Unter Profis GmbH		Hohen Neuendorf
65575	101362	Heinrich Meier GmbH		Mühlacker
65576	101363	Beton Kemmler GmbH		Tuebingen
65577	101364	Heller Tools Inc.		Chicago
65578	101365	Fetter Baumarkt GmbH	(Baustoffe)	Korneuburg
65579	101366	AE Handels GmbH		Bochum
65580	101367	EURL JOHAN LEDENT		CHATEAUNEUF DE GALAURE
65581	101368	Baucentrum Stewes GmbH & Co.KG		Duisburg
65582	101369	J K Supplies Ltd.	4 Hillside Cottages	Hertfordshire
65583	101370	FKR Baucentrum GmbH & Co. KG		Wabern
65584	101371	KARDE?LER GÜMRÜK MÜ?AV?RL???	LOJ?ST?K VE ULUS. TA?. LTD. ?T?.	FERHATPA?A-ATA?EH?R, Istanbul
65585	101372	albw Handels GmbH		Waghäusel-Kirrlach
65586	101373	Mayrose-Uelsen GmbH & Co. KG		Uelsen
65587	101374	SAS PROBALI		LABASTIDE MONREJEAU
65588	101375	PM Hardware Ltd.		Bury, Lancashire
65589	101376	Raiffeisen Waren GmbH	(Ndl. Strauch)	Limeshain-Rommelhausen
65590	101377	THEMIS GIANNAKIS S.A.		Athen
65591	101378	Baumaschinen Schmittinger GmbH		Köngen
65592	101379	VEHNS GROUP GmbH		München
65593	101380	Soroush / Mr. Abdulla Mohamad	Abdolmohamad Mob: +9647701531996	Sulaimanya Kurdistan Iraq
65594	101381	Villacross Corp.		Obarrio Urb of the City of Pan
65595	101382	Mastermate VBT Groep	Technische Groothandel	Vlaardingen
65596	101383	Cofaq		Poitiers
65597	101385	Friedrich Kicherer GmbH & Co. KG		Ellwangen/Jagst
65598	101386	Deeg GmbH	Werkzeuge	Crailsheim
65599	101387	Local Industrial Supplies	THS Tools Group	Rotherham
65600	101388	Werkzeug Jäger GmbH		Karlsruhe
65601	101389	HELLER TOOLS DO BRASIL COMÉRCIO	DE FERRAMENTAS LTDA	Cidade de Sao José dos Pinhais
65602	101390	Heinz Lindner GmbH		Fellbach
65603	101391	R2M		Vouille
65604	101392	HERI SARL		Vernoux-en-Vivarais
65605	101393	Keil Fördertechnik GmbH		Ruppach-Goldhausen
65606	101394	LOCATION		LOCATION
65607	101395	Baugeräte 24		Baden-Baden
65608	101396	Hoofdvestiging DESTIL BV		Tilburg
65609	101397	Horst Klever	Werkzeuge-Maschinen	Rastatt
65610	101398	Baumarkt Allianz West	hagebau	Herten
65611	101399	EDIPESA S.A.		Lima
65612	101400	Baumarkt-Allianz Nord	hagebau Fachhandel GmbH & Co. KG	Rellingen
65613	101401	SAS Perronet et Paillasson		Pannissieres
65614	101402	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
65615	101403	SARL BODIN		Langon
65616	101404	Plumbworkz Ltd		Rhuddlan
65617	101405	BMN Roosendaal - West		Roosendaal
65618	101406	Avantifix (Fixing Solutions) Ltd.	Heller Tools Logistics UK	Rothwell, Leeds
65619	101407	DANYANG ZHAONAN TOOLS CO., LTD		Danyang City, Jiangsu
65620	101408	Otto Wagner GmbH & Co KG	Stahllager-Fachmarkt	Freudenstadt
65621	101409	Spreyer Werkzeug Technik GmbH		Limburg/Lahn
65622	101410	Rettig & Köhler GmbH & Co KG	Eisenhandlung	Ettlingen
65623	101411	Karrer Werkstatt Technik Vertriebs	GmbH	Memmingen
65624	101412	RB Tools GmbH	Generalvertretung	Au-Wädenswil
65625	101413	fischerwerke GmbH & Co. KG		Waldachtal
65626	101414	Josef Stümper GmbH		Neunkirchen-Seelscheid
65627	101415	Gunters en Meuser Noord B.V.	Izerwaren - Gereedschappen	Amsterdam
65628	101416	Samples AMNORT		Washington
65629	101417	Zweygart GmbH & Co. KG	Fachhandelsgruppe	Gärtringen
65630	101418	Philipsen GmbH	Werkzeuge	Weingarten
65631	101419	Samples AMSOUT		Brasilia
65632	101420	Samples AUAS		Danyang City
65633	101421	Gienger Regensburg KG	Fachgroßhandel für Haustechnik	Regenstauf
65634	101422	Samples BENE		Amsterdam
65635	101423	Muster DACHL		Berlin
65636	101424	Samples BENE TCG		Amsterdam
65637	101425	Dibosa GmbH		Großefehn
65638	101426	Muster DACHL TCG		Berlin
65639	101427	Eisen-Bärle GmbH & Co.KG		Bruchsal
65640	101428	Van Eijk	Machines & Gereedschappen B.V.	Reusel
65641	101429	Samples EUEAST		Warschau
65642	101430	Otten GmbH & Co KG	Geb. 6352A	Mainz
65643	101431	Samples EUNORT		Kopenhagen
65644	101432	Samples EUSOUT		Rom
65645	101433	FLORIVAL MATERIAUX		Issenheim
65646	101434	Samples FRANCE		Paris
65647	101435	Samples IBERIA		Madrid
65648	101436	TECHNIMAT		Allevard-les-Bains
65649	101437	Samples MEAI		Cairo
65650	101438	ZEG - Zentraleinkauf	Holz + Kunststoff eG	Mannheim
65651	101439	Teknofix		Exeter, Devon
65652	101440	Samples UKIRL		London
65653	101441	Reca Norm GmbH		Kupferzell
65654	101442	BVBA IJZERWAREN NELIS	Vakhandel en Installatiebedrijf	Glabbeek
65655	101443	Bruno Cavalheiro		Curitiba
65656	101444	Didden NV		Dilsen-Stokkem
65657	101445	SAS LOCATION CAEN MATERIEL		Colombelles
65658	101446	Roth Baustoffe GmbH & Co. KG		Neckargemünd
65659	101447	Andreas Stockbauer		Waldkirchen
65660	101448	CCU Tool and Plant Hire LTD		Rochester, Kent
65661	101449	Zandvoort Draadindustrie BV		Doetinchem
65662	101450	Warnhill tool & fasteners ltd	Until 17A, Road One	Winsford, Cheshire
65663	101451	SARL MUTEC France		Lautenbach
65664	101452	SASU CASTE		Auch
65665	101453	Serafin Unternehmensgruppe GmbH		München
65666	101454	CMS-Dienstleistungs-GmbH		Ober-Ramstadt
65667	101455	GROUP2 MasterPro		GROUP2 MasterPro
65668	101456	Revert S.A.S		Versailles
65669	101457	SBN GmbH & Co. KG		Neuenkirchen
65670	101458	Proventure Solutions Ltd.	Lakeside Barn	Lathom, Ormskirk
65671	101459	Walth Hardware		Monterrey
65672	101460	REAL Matériaux	OPUS PLATEFORME	Trappes
65673	101461	INDEPENDANT		INDEPENDANT 3
65674	101462	ADA Fastfix	Unit 10 Merlin Centre	High Wycombe
65675	101463	KOVA TOOLS NV		GRÂCE-HOLLOGNE
65676	101464	MATERIEL ET MATERIAUX		Mornant
65677	101465	TD Projects		Pelt
65678	101466	FISCHER ARGENTINA SA		Buenos Aires
65679	101467	Contract Company Services	GmbH & Co. KG	Eckernförde
65680	101468	HOMBERGER S.P.A.		Buccinasco
65681	101469	J. Weber	Eisenwaren e.K.	Heidelberg
65682	101470	Walter + Schier GmbH	Werkzeug - Maschinen	Waiblingen
65683	101471	Martin Meier GmbH	Das Bauzentrum Gaimersheim	Gaimersheim
65684	101472	SARL ELMAT		Plérin
65685	101473	Stolle Tortechnik GmbH		Emstek
65686	101474	UNION Bauzentrum HORNBACH GmbH		Bobenheim-Roxheim
65687	101475	Albrecht-Werkzeuge + Maschinen	Handels GmbH	Freiburg
65688	101476	Karrer + Barth GmbH & Co		Karlsruhe
65689	101477	UNION Bauzentrum HORNBACH GmbH		Groß-Rohrheim
65690	101478	Utilisateur		Utilisateur
65691	101479	UNION Bauzentrum HORNBACH GmbH		Kaiserslautern
65692	101480	UNION Bauzentrum HORNBACH GmbH		Kirn
65693	101481	Indépendant		Indépendant
65694	101482	UNION Bauzentrum HORNBACH GmbH	Baustoffe	Saarbrücken-Gersweiler
65695	101483	Gerhard Sprügel GmbH	Befestigungstechnik	Ingelfingen
65696	101484	Baumarkt Lohhof GmbH		Unterschleißheim
65697	101485	UNION Bauzentrum HORNBACH GmbH	Ausbau / Fassade	Saarbrücken-Gersweiler
65698	101486	Waagen Wulff GmbH		Flensburg
65699	101487	Nagel Baumaschinen	Magdeburg GmbH	Glauchau
65700	101488	UNION Bauzentrum HORNBACH GmbH		Saarlouis
65701	101489	UNION Bauzentrum HORNBACH GmbH		Sinsheim
65702	101490	UNION Bauzentrum HORNBACH GmbH		Stuttgart-Weilimdorf
65703	101491	UNION Bauzentrum HORNBACH GmbH		Ulm
65704	101492	UNION Bauzentrum HORNBACH GmbH		Viernheim
65705	101493	UNION Bauzentrum HORNBACH GmbH		Wadern
65706	101494	UNION Bauzentrum HORNBACH GmbH		Worms
65707	101495	Robert Röhlinger GmbH		Neunkirchen
65708	101496	K. E. Karcher GmbH & Co.KG	Werkzeuge	Rheinau
65709	101497	BV STOCK VAN DE WALLE		Assenede
65710	101498	TIB Technischer Industriebedarf	GmbH Bernsbach	Lauter-Bernsbach
65711	101499	ESD Bricotech Bricopro		Chatte
65712	101500	FRÖWIS AG		Schaanwald / Lichtenstein
65713	101501	SAS ETCHALUS MATERIAUX		SAINT MARTIN DE SEIGNANX
65714	101502	Peter Trepke	Vertrieb von Verbindungselementen	Romrod/Ober-Breidenbach
65715	101503	Gerhard Scheifele GmbH	Befestigungstechnik	Pfedelbach
65716	101504	Otto Roller e.K.	Inh. Kersten Roller	Pirmasens
65717	101505	Gerd Kottmeier	Werkzeughandel + Reparatur	Vlotho
65718	101506	Haberstumpf und Winkler		Kulmbach
65719	101507	Dibotec Befestigungssysteme		Baindt
65720	101508	Segupro SAC		Lima - Lurigancho
65721	101509	Sonelec S.A.R.L		Sprinkange
65722	101510	HBH-Priotek GmbH		Grevenbroich
65723	101511	Zweygart GmbH & Co. KG	Fachmarkt	Hanau
65724	101512	DomPro		Dingsheim
65725	101513	DomPro (2,5)		Dingsheim
65726	101514	Werkzeughandel Möller	Inh.Thomas Möller	Königsee
65727	101515	Al Nahda Company		Misurata
65728	101516	LTD Energy		Tbilisi
65729	101517	K² GmbH & Co. KG		Pößneck
65730	101518	Erich Carlé GmbH & Co. KG	Bedachungsfachhandel	Gießen
65731	101519	Hermann Fatum GmbH & Co. KG	Bedachungsfachhandel	Hungen
65732	101520	Heitkamm GmbH	Dachbaustoffe	Ahlen
65733	101521	Rieber Werkzeugtechnik		Merzhausen / Frbg.
65734	101522	BHT GmbH	Bedachungshandel Tritschler	Sexau
65735	101523	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Eifel
65736	101524	TECTO Dachbaustoffe GmbH		Stolpen
65737	101525	Richter Baustoffe GmbH	(Baustoffe Burg)	Burg / Fehmarn
65738	101526	SAS MURESOL		LE PETIT QUEVILLY
65739	101527	SAS MURESOL		Gainneville
65740	101528	NBT Group Ltd.		Newcastle upon Tyne
65741	101529	Agir		Agir
65742	101530	Hagmeyer Handwerker- und	Industriebedarf GmbH	Geislingen/Steige
65743	101531	SARL CODINA QUINCAILLERIE		Soual
65744	101532	Depot Express SARL		Meyzieu
65745	101533	WOLDS ENGINEERING SERVICES LTD		Pocklington
65746	101534	Vélar & Verkfaeri ehf		REYKJAVIK
65747	101535	PAWLICZEK SARL		MERIGNAC
65748	101536	CENTRAL FASTENERS (STAFFS) LIMITED		HIXON, STAFFS
65749	101537	Heinrich Lütticken GmbH	Stahlhandel	Wittlich
65750	101538	Hamelin		Querétaro
65751	101539	DURI FAGPROFIL AS		Oslo
65752	101540	Felix Knümann	Inh. Christian Reuter e.K.	Selm
65753	101541	S.A. Quincaillerie Lallemand		Vielsalm
65754	101542	Phoenix Hire & Sales Ltd.		Cwmbran, Gwent
65755	101543	SAS LOPEZ FI		Portes les Valences
65756	101544	Slobel fixing BV		Haaltert
65757	101545	Handelsunternehmen Frank Niebergall		Weissenborn
65758	101546	FRANTOS GmbH & Co KG		Feldkirchen bei München
65759	101547	LAURENT  MATERIAUX		Port sur Soane
65760	101548	A. Papantonopoulos & SIA EE	tel. 2310-722425	THESSALONIKI
65761	101549	VMA		Baie-Mahault
65762	101550	“KURAL-ASTANA” LLC		Astana
65763	101551	Theo Förch GmbH & Co. KG		Neuenstadt
65764	101552	SARL MS FOURNITURES INDUSTRIELLES		Romaneches - Thorins
65765	101553	BAUKING Berlin-Brandenburg GmbH	FH Eichwalde	Eichwalde
65766	101554	HACKER GmbH	Holzbearbeitungsmaschinen	Rosenheim
65767	101555	Makita Corporation		Anjo, Aichi 8502 JAPAN
65768	101556	Stock & Trade		Helmond
65769	101557	SAS EUTALYA		Montmorency
65770	101558	Contorion GmbH		Berlin
65771	101559	Fastline Services Ltd		Doncaster
65772	101560	GB INGENIERIA EN FIJACIONES S.A.		SANTIAGO
65773	101561	Industrial Lifting Ltd		Stoke-on-Trent
65774	101562	Optimera Latvia SIA		Riga
65775	101563	NV O.M.C.T.		Averbode
65776	101564	LSK SUPPLIES LIMITED		Glasgow
65777	101565	Contorion GmbH		Berlin
65778	101566	J. König GmbH & Co	Werkzeugfabrik	Karlsruhe
65779	101567	Materiaux		Materiaux
65780	101568	Implementos y Herramientas, S.A.	(IHERSA)	Panama
65781	101569	Frankreich Preisliste F1		Dinklage
65782	101570	BRAUN GmbH		Geretsried
65783	101571	Diamanttechnik Wilsdruff	Inh. Robby Heimrich	Wilsdruff
65784	101572	SARL PERIGORD QUINCAILLERIE		Champcevinel
65785	101573	L'Etoile		Bruges
65786	101574	ADEO		ADEO
65787	101575	Maurer GmbH		Bad Saulgau
65788	101576	SAS DOMPRO		Roissy-en-France
65789	101577	MBA	Matériaux Bois Aquitaine	Mérignac
65790	101578	NEBOPAN		NEBOPAN
65791	101579	NBB Technischer Großhandel		Nordenham
65792	101580	Preisliste Tout Faire		Dinklage
65793	101581	Frankreich Preisliste F3		Dinklage
65794	101582	TDC	Toulouse Diffusion Coffrages	Grisolles
65795	101583	SARL GINESTET MATERIAUX		Mirandol
65796	101584	BAUEN+LEBEN Service GmbH & Co. KG		Krefeld
65797	101585	Hommel Hercules	Werkzeughandel GmbH & Co. KG	Viernheim
65798	101586	Brütsch-Rüegger Tools GmbH	Deutschland	Mannheim
65799	101587	SFS Group Schweiz AG		Heerbrugg
65800	101588	SAS XPERT		Avignon
65801	101589	Friedrich Kraft GmbH		Rendsburg
65802	101590	Hayley GROUP LIMITED		Redruth
65803	101591	Heller Tools RUS, Ltd.		Moscow
65804	101592	Häfele SE & Co KG	Beschlagtechnik	Nagold
65805	101593	C. Schrade GmbH		Neckarsulm
65806	101594	Thomas Rosenkranz	Werkzeuge, Maschinen, Handwerk-	Neunkhausen
65807	101595	Blacks Fasteners Limited		Christchurch
65808	101596	Hermann Asal GmbH	Eisenwaren	Offenburg
65809	101597	ASK Kloska GmbH		Leer
65810	101598	Eisen Jourdan	Eisenwarenhandels GmbH	Pforzheim
65811	101599	N.G. ELEKTRO TRADE, a.s.		Ostrov
65812	101600	Baillargeat	SA Quincaillerie	La Teste de Buch
65813	101601	SARL Pro Fourniture		Gueret
65814	101602	SARL Garonne Bricolage		La Réole
65815	101603	Quincaillerie		Quincaillerie
65816	101604	Paul Sommer Steinindustriebedarf	Inh. Tino Schönfeld	Löbau
65817	101605	Franz Heydt Fachhandels-GmbH		Rastatt
65818	101606	Thommel I&H GmbH		Ravensburg
65819	101607	Nortech Services Ltd		Hull
65820	101608	SAS EDTO		SAINT HERBLAIN
65821	101609	CFK - International e. K.		Gangelt
65822	101610	Köhle Kimyevi Maddeler	Hirdavat ve Tic. Ltd.Sti.	Istanbul-Cihangir
65823	101611	AK Industrie	Fournitures industrielles	Seingbouse
65824	101612	Wilhelm Linnenbecker GmbH & Co.		Berlin
65825	101613	Raiffeisen Waren GmbH	(Ndl. Korbach)	Korbach
65826	101614	Otto Röhrs GmbH	Baustoffe	Weyhe-Dreye
65827	101615	Ronix GmbH		Frankfurt am Main
65828	101616	Probeg B.V.		Haaksbergen
65829	101617	CENTRAL MANAGEMENT CATALOGUE	AGENCY (UK) LTD	Worcester
65830	101618	JFH Fixings Ltd.	C/O John F Hunt	Essex
65831	101619	Mega-Mat NV		Heusden- Zolder
65832	101620	“DIA–ELIT” Ltd.		Belgrade
65833	101621	WIMA Dröghoff-Boudon GmbH		Arnsberg
65834	101622	Nordic Tools AS		Hagan
65835	101623	Carl Pfeiffer GmbH & Co.KG		Stockach
65836	101624	Schade + Sohn GmbH		Wuppertal
65837	101625	Ferdinand Gross GmbH & Co		Leinfelden-Echterdingen
65838	101626	HAHN & KOLB	Werkzeuge GmbH	Ludwigsburg
65839	101627	BUSTECHNIC HAVACILIK OTOMOT?V VE	TA?IMACILIK SAN. T?C. LTD. ?T?.	ISTANBUL
65840	101628	Baustoff Verbund Süd GbR		Urbach
65841	101629	BME Group Sourcing BV		Schiphol
65842	101630	Baufachmarkt Schulz GmbH		Möckmühl
65843	101631	SMART TRADE ECUADOR		Zaruma
65844	101632	Georg Schmieder GmbH & Co	Handwerkerbedarf	Stuttgart (Degerloch)
65845	101633	NMBS Limited		Leicestershire
65846	101634	Sanitaire		Sanitaire
65847	101635	Rudolf Hug GmbH		Waldshut-Schmittenau
65848	101636	Point.P		PointP
65849	101637	KAISER Nachfolger Montagetechnik	und Industriebedarf GmbH	Blomberg
65850	101638	Electricité		Electricité
65851	101639	Lapeyre		Lapeyre
65852	101640	Nagel Werkzeug-Maschinen GmbH		Ulm
65853	101641	Baucenter Bermes GmbH		Bitburg
65854	101642	Raiffeisen Waren GmbH	Bayerischer Wald	Perlesreut
65855	101643	MAISON COURTOIS BV		VAUX-SUR-SÛRE
65856	101644	Saint Gobain		Saint Gobain
65857	101645	KWG Schwegler Elektrowerkzeuge	Inh. Hansjörg Schwegler e.K.	Fellbach
65858	101646	Paul Kuhn GmbH		Verl
65859	101647	Pold-Plast Systemy Dachowe Sp. z o.		Wo?owice
65860	101648	POWER TOOLS PERU SAC		Lima
65861	101649	Dell Baugroup		Soest
65862	101650	SARL Durousseau Outils Coupants		Cenon
65863	101651	SAS AGRI-BESSIN		ST MARTIN DES ENTREES
65864	101653	Algorel		Groupe Algorel
65865	101654	Betz & Co. GmbH	Eisenwaren Beschläge	Stuttgart
65866	101655	Gedex		Groupe Gedex
65867	101656	YESS		Groupe YESS
65868	101662	I&M Bauzentrum Lieder		Halver
65869	101664	Eisen-Schmid GmbH & Co.KG		Hausach
65870	101665	Märklen GmbH & Co. KG	Werkzeuge - Maschinen	Neckarsulm
65871	101666	AFAP	Aquitaine Fixation et Accastillage	La Teste-de-Buch
65872	101668	Beschläge Koch GmbH		Freiburg
65873	101669	Edelmann Fachmarkt GmbH		Bad Mergentheim
65874	101670	Hagebaumarkt Segl		Vilshofen
65875	101671	Eduard Lutz Schrauben-Werkz. GmbH		Weilheim
65876	101672	Eberle-Hald Handel- und Dienst-	leistungen Metzingen GmbH	Stuttgart
65877	101673	Vydra & Herr GmbH	Werkzeuge-Maschinen-Betriebseinr.	Leinfelden-Echterdingen/Stette
65878	101675	Iris		Iris
65879	101678	Eisen Auer GmbH		Singen
65880	101679	Willi Stober GmbH & Co KG		Karlsruhe-Neureut
65881	101680	Bleu Rouge		Bleu Rouge
65882	101686	VEESER Bauzentrum Freiburg	GmbH & Co. KG	Freiburg
65883	101687	J. Kessel GmbH & Co KG		Kehl-Kork
65884	101688	Careso		Careso
65885	101689	Doras		Doras
65886	101694	Samse		Samse
65887	101696	LPDB		LPBD
65888	101699	Brossette		Brossette
65889	101701	Cedeo		Cedeo
65890	101704	SFIC		SFIC
65891	101707	Accueil Négoce Bois Materiau		AccueilNegoceBoisMateriaux
65892	101711	Augier		Augier
65893	101712	VM Materiaux		VM Materiaux
65894	101713	MR SWISS AG		Wettingen
65895	101719	BATILAND		BATILAND
65896	101723	Stabilo Landtechnik GmbH	Werkzeuggrosshandel	Kupferzell-Mangoldsall
65897	101727	Bonifay		Bonifay
65898	101734	Noba Normteile	Handelsgesellschaft mbH	Bad Mergentheim
65899	101737	BVP		BVP
65900	101738	CARMAT		CARMAT
65901	101744	Reisser GmbH	Sanitaer + Heizung	Boeblingen
65902	101746	Eisenhandlung Butsch GmbH		Weinheim
65903	101747	CDE		CDE
65904	101748	Club Bois		Club Bois
65905	101749	DENIS MATERIAUX		DENIS MATERIAUX
65906	101753	Gabriel		Gabriel
65907	101755	Nibler GmbH & Co.KG		Walldorf
65908	101760	Guibout Matériaux		Guibout Matériaux
65909	101762	Lignac		Lignac
65910	101764	Lotz Frères		Lotz Frères
65911	101766	Ziegler Bad Friedrichshall GmbH		Leingarten
65912	101767	Mat +		Mat +
65913	101768	Matnor		Matnor
65914	101769	Pigeon Materiaux		Pigeon Materiaux
65915	101770	Provence Matériaux		Provence Matériaux
65916	101776	SFM		SFM
65917	101778	Sylvalliance		Sylvalliance
65918	101781	Valdeyron		Valdeyron
65919	101783	Moessner GmbH	Elektrogroßhandel	Schorndorf
65920	101786	Boie GmbH	Fachgrosshandel	Heilbronn
65921	101787	Walter Diebold GmbH		Ludwigsburg
65922	101788	SONEPAR		SONEPAR
65923	101789	CGE		CGE
65924	101792	AGIDIS		AGIDIS
65925	101793	Götz + Moriz GmbH	Baustoffe	Freiburg
65926	101800	REXEL		REXEL
65927	101804	GEDIBOIS		GEDIBOIS
65928	101805	Leroy Merlin		Leroy Merlin
65929	101810	Bricoman		Bricoman
65930	101813	Weldom		Weldom
65931	101815	KINGFISCHER		KINGFISCHER
65932	101818	Dr. Keller Maschinen GmbH		Freiburg
65933	101819	Dr. Keller Maschinen GmbH		Mannheim-Käfertal-Süd
65934	101822	CASTORAMA		CASTORAMA
65935	101823	Brico Dépot		Brico Dépot
65936	101824	Outillage		Outillage
65937	101826	Sécurité		Sécurité
65938	101827	Agricole		Agricole
65939	101830	Metabo-Werke GmbH & Co	z.Hd. Marcus Dengler	Nürtingen
65940	101831	Internet		Internet
65941	101832	MG TECHNOPLAN LTD	Limassol 1st Industrial Area	Limassol
65942	101833	Ernst Triebel Eisenwaren	Inh. D. Tägtmeyer	Achim
65943	101834	Alfa doo		Travnik
65944	101842	Block & Job		Block & Job
65945	101843	Siehr		Siehr
65946	101844	Pagot & Savoie		Pagot & Savoie
65947	101845	Comptoir des Fers		Comptoir des Fers
65948	101847	Andrez Brajon		Andrez Brajon
65949	101848	Malrieu		Malrieu
65950	101850	Rouenel		Rouenel
65951	101851	Moy		Moy
65952	101853	Maillard		Maillard
65953	101854	Herbert Pansch KG	Eisenwaren & Baubedarf	Bremen
65954	101855	Mestre		Mestre
65955	101856	Pompac		Pompac
65956	101857	Gommichon		Gommichon
65957	101858	Comet		Comet
65958	101862	Dupont Est		Dupont Est
65959	101863	Somatem		Somatem
65960	101864	Lüssumer Eisenwaren	Arnold Ficke e.K.	Schwanewede
65961	101865	Seca		Seca
65962	101866	Méquisa		Méquisa
65963	101871	Fritz Gabriel GmbH & Co. KG		Bielefeld
65964	101873	Sanisit		Sanisit
65965	101874	Groupe Région 1		Région 1
65966	101876	Oltrogge & Co.KG		Bielefeld
65967	101878	Henze + Bleck GmbH		Ronnenberg
65968	101879	Groupe Région 2		Région 2
65969	101880	Groupe Région 3		Région 3
65970	101881	Groupe Région 4		Région 4
65971	101882	Groupe Région 5		Région 5
65972	101883	Groupe Région 6		Région 6
65973	101884	SARL NEW TOOLS BEY	NIF: 000516097070617	EL-HAMIZ ALGER
65974	101888	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Amsterdam
65975	101889	Au Comptoir Graylois		ARC LES GRAY
65976	101890	OUTIFRAIX		Bordeaux
65977	101895	Heinrich Grotemeier GmbH & Co.KG		Buende
65978	101896	Peter Cibulka Werkzeugtechnik	Schleifservice und Werkzeughandel	Merzen
65979	101897	Dachdecker - Einkauf	Soltau EG	Soltau
65980	101898	A. Köhler Werkzeugtechnik		Leipzig
65981	101899	SARL Dimabois		Cernay
65982	101900	ALG Outillage Pro	Le Gousse André	Poullaouen
65983	101901	EURL Chabirand		Verrieres en Anjou
65984	101904	PARIS SAS		Luxeuil-Les-Bains
65985	101905	Brico Privé		L'union-Toulouse
65986	101906	P.H.M. Plant Services Ltd.		Gloucestershire
65987	101907	SWC	Unit 2 Clifford Park	Biddeford, North Devon
65988	101908	The General Tool Store Ltd.		Whitchurch
65989	101909	Travaux Publics		Travaux Publics
65990	101910	GEADIS		GEADIS
65991	101911	Union Bauzentrum Hornbach GmbH	Lager Börrstadt	Börrstadt
65992	101914	Abbot Fixings		Milton Keynes
65993	101915	Vidal Masterpro	ACT Fournitures industrielles	Ambarès
65994	101916	TIVOLY SA		Tours-En-Savoie
65995	101917	Bufab (UK) Ltd.	Unit F, Centurion Ind. Park	Southampton
65996	101919	Groupe MASTERPRO		GROUPE MASTERPRO
65997	101920	BK Fixings Ltd.		Gwent
65998	101921	Elektro Werk Inc.		Quezon City, Philippines
65999	101924	SARL ECOFIX		Villiers Le Bacle
66000	101925	Meerkötter GmbH		Borken
66001	101928	BNR Ltd.	Unit 516D	Rathcoole, Co. Dublin
66002	101930	Grainger Tubolt Ltd.	Units A&B Meyrick Owen Way	Pembrokeshire
66003	101931	WOCKEN Industriepartner	GmbH & Co.KG	Cloppenburg
66004	101933	Eduard Lutz Schrauben-Werkz. GmbH		Gersthofen
66005	101935	Rawlplug S.A.		Wroclaw
66006	101938	J.H. Jaeger & Eggers	Handelsges. mbH	Bremen
66007	101939	BHB pro Handwerk & Industrie	Inhaber: Armin Berwanger e.K.	Schmelz
66008	101944	Choices		London
66009	101945	Metro Fixings Ltd.	Unit 3 Tewin Court	Hertfordshire
66010	101946	Gedimat Charroin		Brignais
66011	101947	BVM GmbH	Kleinlein Vertriebsbüro Aschau	Aschau
66012	101949	Voskamp Bouw en Industrie B.V.		Assen
66013	101952	GR Fasteners & Engineering Supplies	Units A&B Brunel Court	Gloucestershire
66014	101953	ToolTeam August GmbH		Köln
66015	101954	FAIE Handelsgesellschaft mbH		Regau
66016	101956	SDM Toulouse Matériel		Portet sur Garonne
66017	101958	Bernhard Strunz GmbH		Delbrück
66018	101959	Layer Grosshandel GmbH & Co.KG	Fil. Liebenwalde	Liebenwalde
66019	101961	Peter Belousow GmbH	Elektromaschinenbau	Schrobenhausen
66020	101962	SAS AU FAITE 68		RICHWILLER
66021	101963	Isero IJzerwarengroep B.V.	Breur Ceintuurbaan	Rotterdam
66022	101965	EUROMA	s.a.s.	Bousse
66023	101967	S&P Baushop		Stolberg
66024	101972	Alfred Blöss	Baubeschlag-Bauelemente GmbH	Hannover
66025	101974	F30 Building Products		Clevedon
66026	101975	Betec GmbH	Werkzeuge	Chemnitz
66027	101976	Feldmann & Grever GmbH	Baumaschinen u. Baugeräte	Cloppenburg
66028	101977	P.H. Brauns GmbH & Co.KG	Partner für Technik	Hannover-Ricklingen
66029	101979	Trowbridge Power Tools Ltd.		Wiltshire
66030	101981	Benzi France		Vesoul
66031	101984	Wolfgang Haberzettl GmbH		Uttenreuth
66032	101986	PRETOT	Etablisements	Larians et Munans
66033	101987	HANDLOWA ERBO		Pruszkow
66034	101990	BayWa AG	Zentraler Rechnungseingang	München
66035	101992	BayWa AG Rain A.  Lech	Vertrieb Baustoffe	Rain
66036	101993	Novalution (N. Ireland)		Belfast
66037	101994	Marion	Aldo	Chimilin
66038	101996	Aux Docks de Clamart SA		Clamart
66039	101997	Boulonnerie Visserie Fixation Sàrl	BVF	Bègles
66040	101999	SARL Perfo Plus		Castres
66041	102000	DPR Retail Ltd.		Preston
66042	102002	P.V. Betonfertigteilwerke GmbH		Gersdorf
66043	102006	Centre D'Occasion de l'Est	CODE	Amoncourt
66044	102007	Gantois	Quincaillerie	Jussey
66045	102008	Wocken Industriebedarf	GmbH & Co.KG	Hildesheim - Bavenstedt
66046	102009	Unimet Zentrallager	Hildesheim GmbH&Co.KG	Hildesheim
66047	102011	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Zoetermeer
66048	102012	Vendée Fournitures Industrielles	VFI SARL	Talmont-St-Hilaire
66049	102013	Thies & Co GmbH	Fachhandel	Hoya/Weser
66050	102014	SEBA		SEBA
66051	102015	Comptoir Bordelais d'Exportation	CBE	Le Bouscat
66052	102016	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Haarlem
66053	102017	IBACOM PACA	Georges Albert	Aubagne
66054	102018	Portalet		Portalet
66055	102021	SAS Quincaillerie Portalet		Mont de Marsan
66056	102023	Wilhelm Cordes		Nienburg
66057	102026	C. E. Popken	Inh. Dirk Bünting e.K.	Norden
66058	102028	Wilhelm Linnenbecker GmbH & Co. KG		Bad Salzuflen
66059	102029	thiele & fendel	Oldenburg GmbH & Co.KG	Oldenburg
66060	102031	BMN Bouwmaterialen BV Zuid	Adresse für Rechnungsversand	Veghel
66061	102032	Meesenburg Großhandel KG	NL Oldenburg	Oldenburg
66062	102034	Erwin Beate GmbH & Co. KG	Dachbaustoffe	Solingen
66063	102036	Kötter + Siefker GmbH & Co KG	Fachgrosshandel	Lotte - Büren
66064	102037	MATECOLO		Tartas
66065	102038	Schürmann + Holtorf GmbH		Osnabrück
66066	102040	Ratering Bouw & Industrie B.V.		Ulft
66067	102042	John F Hunt Ltd.		Grays, Essex
66068	102043	Ullner u. Ullner GmbH	Werkzeuge / Maschine	Paderborn
66069	102048	Auer Baustoffe GmbH & Co. KG		Erding
66070	102050	EMA Spezialbaustoffe GmbH		Parsdorf
66071	102051	Baustoffhandel Landsberg Rieth		Landsberg am Lech
66072	102052	IHT Timme GmbH & Co KG		Stadthagen
66073	102053	Wassermann & Co GmbH		Memmingen
66074	102054	Otto Baubedarf		Wörblitz
66075	102055	Isero IJzerwarengroep B.V.	Breur Ceintuurbaan	Rotterdam
66076	102056	MRL Münchner Runde Leistungsverbund	Beteiligungs- Besitz- und	Olching
66077	102058	Dreps GmbH	Christian Dreps	Altshausen
66078	102060	Johannes Ohlendorf GmbH	Stahlgroßhandel-Schrauben-Werkzeuge	Gütersloh
66079	102063	Carrelage		Carrelage
66080	102066	Xibero matériaux		Tardets
66081	102068	Kurt Koenig	Baumaschinen GmbH	Einbeck
66082	102069	OPHIT'CARRELAGES	Centre URBEGI	Anglet
66083	102071	Peak Tools	Willow Brook	Derbyshire
66084	102072	SISCA		SISCA
66085	102073	SISCA	Centre d'achats	Semeac
66086	102074	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Wateringen
66087	102075	Bauzentrum Mayer GmbH & Co.KG		Neuburg
66088	102076	Baustoff Union GmbH & Co.KG		München
66089	102077	Baustoff Union GmbH & Co.KG		Hohenbrunn
66090	102078	Artinger + Ohneis GmbH & Co. KG		Neufahrn
66091	102081	Buchenrieder-Mühlhäusser	Baustoff- Fachhandel	Abensberg
66092	102082	Steinke KG		Perleberg
66093	102083	LANGE GMBH & CO. KG		Kassel
66094	102084	Langenbach GmbH		Siegen
66095	102086	Eisen-Hartmann GmbH		Bad Münder
66096	102087	Leipziger Handelsgesellschaft mbH		Leipzig
66097	102088	Plus 6		Köln
66098	102089	Hancock & Brown		Swansea
66099	102090	Kuhlmann GmbH & Co. KG		Lage-Lippe
66100	102091	Heinrich Dittmar GmbH & Co KG	Stahlhandel	Osterode/Harz
66101	102092	Hans Kiesling GmbH & Co.KG		Bremerhaven-Lehe
66102	102093	Langguth GmbH		Coburg
66103	102094	Jolf Bielefeld		Nordenham
66104	102095	ERPATECH BEATA PRAGA SP. Z O.O.		Mosciska (Warsawa)
66105	102096	MISAR TRADING CO. L.L.C.	Taher Barbhaya	DUBAI
66106	102097	Styl'outillage		Roye
66107	102099	Penlaw Fixings Ltd.	Unit 6, City Cross Business Park	Greenwich
66108	102101	Repmann Technischer Fachgroßhandel	GmbH	Rödelsee
66109	102102	Dieter Schmid	Werkzeuge GmbH	Berlin
66110	102106	Coutaud Manutention		Brem sur Mer
66111	102108	Nüßing GmbH		Verl
66112	102109	Bernd Robben		Meppen
66113	102110	H.H. Rohdenburg GmbH		Lilienthal
66114	102111	Eisen Vetter GmbH		Urbach
66115	102112	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Gorinchem
66116	102114	Druckluft Krapf GmbH & Co. KG		Weiden
66117	102117	Heinrich Holthausen		Bremen-Hemelingen
66118	102118	THS GmbH		Lünen
66119	102120	APIMAB		APIMAB
66120	102121	MAZEAU		MAZEAU
66121	102125	BHB Baubeschlag-	Handelsgesellschaft mbH	Bremerhaven-Lehe
66122	102126	OCLID		OCLID
66123	102127	Neumann-Handels GmbH		Dessau-Rosslau
66124	102128	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Mijdrecht
66125	102129	Werner Ditzinger GmbH		Braunschweig
66126	102130	Maag Technic GmbH		Göppingen
66127	102132	Rubix GmbH		Siegen-Weidenau
66128	102133	Motion Plus Ltd.	Unit 5	Milton Keynes
66129	102134	Böwe GmbH		Aurich
66130	102135	Niehaus GmbH		Melle
66131	102136	Power Tool Supplies		Newark
66132	102137	Friedrich Detering GmbH	Fachgrossh. Sanitär-Heizung	Emden
66133	102139	Isero IJzerwarengroep B.V.	Van der Winkel	Eindhoven
66134	102140	INOVMATERIAUX		Draveil
66135	102141	Industrial Gas & Welding Tools		Temse
66136	102142	Technische Handelsonderneming B.V.		Tynaarlo
66137	102143	Miter Industrial Supplies Ltd.	Unit 11	Newport, Gwent
66138	102146	BMN Bouwmaterialen BV West	Adresse für Rechnungsversand	Veghel
66139	102147	BMN Bouwmaterialen BV Noord	Adresse für Rechnungsversand	Veghel
66140	102148	Auer Baustoffe GmbH & Co. KG		Dorfen
66141	102149	Auer Baustoffe GmbH & Co. KG		Mintraching
66142	102150	Wolfgang Nieweg GmbH	Maschinen-Werkzeuge	Osnabrueck
66143	102151	Wocken Industriebedarf	GmbH & Co.KG	Papenburg 1
66144	102152	Unimet Zentrallager Nord	GmbH & Co Handels KG	Oyten
66145	102153	Auer Baustoffe GmbH & Co. KG		Wartenberg
66146	102155	Auer Baustoffe GmbH & Co. KG		Parsdorf
66147	102156	Baustoff- Zentrum Olching GmbH		Olching
66148	102157	Peter Kasberger Baustoff GmbH		Vilshofen/ Pleinting
66149	102158	Kraft Baustoffe GmbH	Der Dachspezialist	Mönchengladbach
66150	102159	Kraft Baustoffe GmbH	Der Dachspezialist	München
66151	102160	Kraft Baustoffe GmbH	Fassade	Höhenkirchen-Siegertsbrunn
66152	102161	Kraft Baustoffe GmbH		Höhenkirchen-Siegertsbrunn
66153	102163	Kraft Baustoffe GmbH		München
66154	102164	Kraft Baustoffe GmbH		Höhenkirchenen
66155	102165	A. Brickwedde GmbH & Co.KG	Technischer Handel	Osnabrück
66156	102166	Kraft Dienstleistungs GmbH		Heimstetten
66157	102169	Kreklau & Hagedorn	GmbH & Co KG	Seelze 1
66158	102170	Moser Agrar & Baufachzentrum	GmbH & Co.KG	Reichertshausen
66159	102171	Do it! Bau-Heimwerker-Garten-Center	Landsberg GmbH	Landsberg/Lech
66160	102172	Do it! BGM Bau-und Gartenmarkt	Bayreuth GmbH	Bayreuth
66161	102173	August Müller OHG	Schweißtechnik-Werkzeuge	Minden/Westf. 1
66162	102174	Aufträge über 9442 erfassen!	Stang GmbH & Co.KG	Miesbach
66163	102179	Stang GmbH & Co.KG		Rosenheim
66164	102180	Arthur Burkowski KG	Bau-u. Industriebed.	Georgsmarienhütte
66165	102181	Himper & Dreher GmbH		Weißenhorn
66166	102183	Isero IJzerwarengroep B.V.	Van der Winkel	Helmond
66167	102184	LuxTeam Eurasia GmbH		Lübeck
66168	102185	SARL MATERIAUX BRINGEL		Guewenheim
66169	102190	Viet Gia Investment Construction	Company Limited	TP.HCM (Ho Chi Minh)
66170	102193	Schreiber Baumaschinen	GmbH & Co. KG	Bremen
66171	102194	Nagel Baumaschinen	Erfurt GmbH	Erfurt
66172	102195	LLC LID MECH		Yerevan
66173	102196	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Woerden
66174	102198	Holz Herbst GmbH	Ndl. Lüneburg	Lüneburg
66175	102199	Werner Pigorsch GmbH		Bremerhaven
66176	102200	Honig Baustoffe e.Kfm	PFM/ Sanitär	Hameln
66177	102201	Krapp Eisen GmbH & Co.KG		Lohne
66178	102202	Krüger & Scharnberg GmbH	(Standort Eimsbüttel)	Hamburg
66179	102203	Mölders & Scharff Baucentrum	GmbH & Co. KG	Lüneburg-Rettmer
66180	102204	Seeger Baustoffe GmbH		Aichhalden
66181	102206	Hans Schug GmbH		Schuld
66182	102207	Heinz Sanders GmbH		Papenburg
66183	102208	Streich Schneider GmbH		Stein an der Traun
66184	102209	Jevith A/S		Roskilde
66185	102210	SARL Forestier Delchet		Le Mayet de Montagne
66186	102211	Hofmann Elektrotechnik		Schwabach
66187	102213	Isero IJzerwarengroep B.V.	Van der Winkel	S-Hertogenbosch
66188	102214	Kolster Nachf.	Inh. Bastian Grimm e.K.	Osterholz-Scharmbeck
66189	102215	BAUSTOFF UNION GmbH		Weißenburg
66190	102218	CHEMOFAST Anchoring GmbH		Willich
66191	102219	AVRIL		AVRIL
66192	102220	Meesenburg GmbH & Co.KG	Niederlassung Gütersloh	Guetersloh
66193	102223	KIRIEL		KIRIEL
66194	102224	Deluxe Diamond Products Ltd.	Unit 9, Barnfield House	Blackburn, Lancs
66195	102225	Johannes Lefeld	GmbH & Co. KG	Rietberg 1
66196	102227	Prewi Schneidwerkzeuge GmbH		Herford
66197	102228	Rentamin Werkzeugvermietung +	Service UG	Bruckmühl
66198	102229	B.W.L. Handels GmbH		Osnabrueck
66199	102230	WM- Befestigungstechnik	Inh. Tim Wochnik	Kaufbeuren
66200	102231	Karl Dengler GmbH		Frankfurt
66201	102233	My Lemon	Lemon Technologies GmbH	Feldbach
66202	102236	H.W.D -Autoteile		Hildesheim
66203	102237	kwb tools GmbH		Stuhr
66204	102238	Carl Westerhoff GmbH & Co.KG	Technischer Handel	Quakenbrück
66205	102239	Lonecke GmbH & Co. KG		Zetel
66206	102241	Disprotech SAS		Metz
66207	102244	Gebben & Heidemann UG	(haftungsbeschränkt) & Co. KG	Haren-Wesuwermoor
66208	102245	pgb-Europe nv	Logistic Centre	Melle
66209	102247	Baumaschinen Grünhage		Braunschweig
66210	102249	UAB Technosta		Kaunas
66211	102250	Paul Himmelmann GmbH		Großenlüder
66212	102251	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leiden
66213	102252	DALMEX AB		Fagelmara
66214	102253	ITM	International Tool Manufacturing	Plainview, NY 11803
66215	102254	Toolbozz Diamondtools		Soest
66216	102258	KEW Kunststofferzeugnisse	GmbH Wilthen	Wilthen
66217	102259	Gerhardt Bauzentrum GmbH & Co. KG		Butzbach
66218	102260	SOSACA Le Luc		Le Luc
66219	102261	Portafix Ltd.	16/17 Stephenson Close	Andover, Hampshire
66220	102262	Isopro Distribution		Saulxures les Nancy
66221	102263	STC-Trading Oy		Vantaa
66222	102265	BMN Bouwmaterialen BV Oost	Adresse für Rechnungsversand	Nijverdal
66223	102266	SMBL	Société de Matériaux et Bois Leman	Crozet
66224	102267	NV Kestens HFK		Tienen
66225	102268	SARL Serge Marchal Outillage	Marchal Bodin-Agence de Bordeaux	Bordeaux
66226	102269	Stefan Muth Werkzeuge	Handelsvertretung	Lüchow
66227	102271	H. J. Bergmann	Handelsges. mbH & Co.KG	Bremen
66228	102272	Wijck's Afbouwmaterialen BV	Adresse für Rechnungsversand	Veghel
66229	102274	Fricke GmbH & Co KG	Werkzeughandel	Flechtorf
66230	102276	Hans Humpenöder GmbH	Baustofffachhandel	Roth
66231	102279	Aug. Heseding GmbH	Maschinen - Werkzeuge	Lohne
66232	102280	Chiptuning & Teilehandel	Diana Uhrmann	Rinchnach
66233	102281	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ridderkerk
66234	102282	Roman Ridge Roofing & Building Ltd.		Wincobank, Sheffield
66235	102283	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Bodegraven
66236	102285	Isero IJzerwaren B.V.	Gerritse IJzerwaren	Alphen A/D Rijn
66237	102288	Groenhart Group B.V.		Grootebroek
66238	102289	Groenhart Group B.V.		Heemskerk
66239	102290	Groenhart Group B.V.		Heerhugowaard
66240	102291	Groenhart Group B.V.		Schagen
66241	102292	Groenhart Group B.V.		Volendam
66242	102295	Groenhart Group B.V.		Westzaan
66243	102296	Groenhart Group B.V.		Wormerveer
66244	102297	Industriebedarf Niemann-Laes GmbH		Lüneburg
66245	102298	Handelsagentur Thomas Rinke		Duesseldorf
66246	102300	Nuts Bolts Ltd.		Chorley, Lancashire
66247	102303	Hellweg Centrum Bremen GmbH		Bremen
66248	102304	Rüstwerk GmbH & Co. KG		Hamburg
66249	102306	De Bry SA		Ciney
66250	102309	H. Perschmann GmbH	Werkzeug-Grosshandlung	Braunschweig-Wenden
66251	102310	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ede
66252	102311	Carl Arnold Brill GmbH		Nordhorn
66253	102313	ETS DAUSSION		Cazeres
66254	102314	BMN Bouwmaterialen BV	Delft	Delft
66255	102318	BMN Bouwmaterialen BV	Emmen	Emmen
66256	102319	BMN Bouwmaterialen BV	Nijverdal	Nijverdal
66257	102321	AWEMA Ochs KG		Alsfeld
66258	102322	BMN Bouwmaterialen BV	Numansdorp	Numansdorp
66259	102323	BMN Bouwmaterialen BV	Hoorn	Hoorn
66260	102325	BMN Bouwmaterialen BV	Apeldoorn	Apeldoorn
66261	102326	BMN Bouwmaterialen BV	Barneveld	Barneveld
66262	102327	BMN Bouwmaterialen BV	Coevorden	Coevorden
66263	102328	BMN Bouwmaterialen BV		Appingedam
66264	102329	BMN Bouwmaterialen BV	Franeker	Franeker
66265	102331	BMN Bouwmaterialen BV	Groningen	Groningen
66266	102332	BMN Bouwmaterialen BV	Leeuwaren	Leeuwarden
66267	102334	BMN Bouwmaterialen BV	Muntendam	Muntendam
66268	102335	Fritz Weg GmbH & Co.KG	Werkzeuge-Maschinen	Eschenburg-Wissenbach
66269	102336	BMN Bouwmaterialen BV	Sneek	Sneek
66270	102337	BMN Bouwmaterialen BV	Winschoten	Winschoten
66271	102339	BMN Bouwmaterialen BV	Amersfoort	Amersfoort
66272	102340	BMN Bouwmaterialen BV	Den Bosch	Den Bosch
66273	102341	BMN Bouwmaterialen BV	Nieuwegein	Nieuwegein
66274	102342	Troglauer GmbH	Baumaschinen - Baugeräte	Bingen-Dietersheim
66275	102343	BMN Bouwmaterialen BV	Tilburg	Tilburg
66276	102344	BMN Bouwmaterialen BV	Veghel	Veghel
66277	102345	BMN Bouwmaterialen BV	Zaltbommel	Zaltbommel
66278	102346	BMN Bouwmaterialen BV	Cruquius	Cruquius
66279	102347	BMN Bouwmaterialen BV	Den Haag	Den Haag
66280	102348	A. L. Wehr	Inh. Jochen Jung	Haiger
66281	102349	BMN Bouwmaterialen BV	Den Helder	Den Helder
66282	102350	BMN Bouwmaterialen BV	Katwijk	Katwijk (ZH)
66283	102351	BMN Bouwmaterialen BV	Leiden	Leiden
66284	102353	Beli Beyer & Liessmann GmbH&Co.KG	Maschinen + Werkzeuge	Kriftel
66285	102354	BMN Bouwmaterialen BV	Purmerend	Purmerend
66286	102355	BMN Bouwmaterialen BV	Zwaag	Zwaag
66287	102356	BMN Bouwmaterialen BV	Deventer	Deventer
66288	102357	BMN Bouwmaterialen BV	Haaksbergen	Haaksbergen
66289	102358	Wijck's Afbouwmaterialen BV	Ede	Ede
66290	102360	BMN Bouwmaterialen BV	Leens	Leens
66291	102361	Theodor Wölpert GmbH & Co.		Blaichach-Bihlerdorf
66292	102362	Gebr. Ott GmbH	Werkzeuge	Hanau/Main
66293	102364	Lena Seelhorst		Dinklage
66294	102366	Christin Berding		Dinklage
66295	102367	Marcel Schlarmann	Heller Tools GmbH	Dinklage
66296	102368	Heller Tools GmbH		Dinklage
66297	102369	Heller Tools GmbH	Nicole Rottinghaus-Fiswick	Dinklage
66298	102372	MARKETING ABTEILUNG		Dinklage
66299	102373	Sandra Holzenkamp		Lohne
66300	102375	Aquaflo Ltd.	Unit 4 Palmerston Centre	Middlesex
66301	102377	BMN Bouwmaterialen BV	Medemblik	Medemblik
66302	102378	BMN Bouwmaterialen BV		Eindhoven
66303	102379	Hans- Peter Hecker	Elektromeister	Malgersdorf
66304	102380	Mr. Marc Jones		Mid Glamorgan
66305	102381	Mr. Cliff Staines		Blackhall, Co. Durham
66306	102382	Mr. Stephen Bell		West Yorkshire
66307	102384	BMN Bouwmaterialen BV		Oldekerk
66308	102385	BMN Bouwmaterialen BV		Hardenberg
66309	102386	bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Hollenstedt
66310	102388	Selkent Fastenings - SELKENT BRAND	Riverside House	London
66311	102390	SAS OUTIWEST		Bonchamp
66312	102391	SARL KRENOBAT Distribution		Corre
66313	102393	Theodor Wölpert GmbH & Co.		Kuchen
66314	102394	Agent		Agent
66315	102396	Matériaux		Matériaux 3
66316	102397	Quincaillerie		Quincaillerie 3
66317	102398	GSB		GSB 3
66318	102400	Holz-Richter GmbH		Lindlar
66319	102401	Lippetaler Baucenter GmbH	Claudia Mester- Jungeilges	Lippetal-Herzfeld
66320	102403	BMN Bouwmaterialen BV		Arnhem
66321	102404	BMN Bouwmaterialen BV		Winterswijk
66322	102405	BMN Bouwmaterialen BV		Assen
66323	102406	Raiffeisen Waren GmbH		Eisenach-Stregda
66324	102408	Werkzeug-Vogel	Inh. Kamila Vogel	Fronhausen/Lahn
66325	102409	BAUKING Weser-Ems GmbH	(Ndl. Sulingen)	Sulingen
66326	102410	Bauking GmbH Rabattring		.
66327	102412	PWK Knöbber GmbH & Co	Handels KG	Kassel
66328	102415	Wessmann Bauzentrum GmbH & Co. KG		Lingen (Ems)
66329	102418	Wessmann Bauzentrum GmbH & Co. KG	NL Bad Bentheim	Bad Bentheim
66330	102419	Wessmann Bauzentrum GmbH & Co. KG	NL Salzbergen	Salzbergen
66331	102422	Bauzentrum VIERCK GmbH & Co.KG		Sörup
66332	102424	Bauzentrum Seelmeyer		Neunkirchen
66333	102425	Baustoffe Landwehr GmbH		Friesoythe
66334	102426	KremerGlismann GmbH & Co.KG		Elmshorn
66335	102428	Gebhard Landhandel GmbH		Wilstedt
66336	102429	Gebhard Bauzentrum GmbH & Co.		Hagen
66337	102430	Lothar Herrmann	Baumaschinen GmbH	Hanau/Main
66338	102431	BBM Baustoffhandel GmbH & Co.KG		Barsinghausen
66339	102432	bauXpert Christiansen GmbH & Co KG		Wyk/Föhr
66340	102433	bauXpert Christiansen GmbH & Co KG		Achtrup
66341	102437	Voskamp Bouw en Industrie B.V.		Rotterdam
66342	102442	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Culemborg
66343	102444	BMN Bouwmaterialen BV		Woerden
66344	102445	BMN Bouwmaterialen BV		Hoogeveen
66345	102447	Götte GmbH	Baumaschinen - Baugeräte	Kassel
66346	102448	Miller GmbH & Co.KG		Aichstetten
66347	102449	Odörfer Seefelder GmbH		Graz
66348	102450	Zöscher & Söhne	Elektro-,HiFi-,TV- und Beleuch-	Graz
66349	102453	D-TACK Prdodukte für's Handwerk		Hüttlingen
66350	102455	BMN Bouwmaterialen BV		Heerenveen
66351	102456	Martin Freimuth	Inh. Gerd Schellhaas	Oestrich - Winkel
66352	102457	BMN Bouwmaterialen BV		Nunspeet
66353	102458	SP Suisse Profit GmbH		Bülach
66354	102459	BMN Bouwmaterialen BV		Ter Apel
66355	102461	SAS Acbat		Sarreguemines
66356	102462	i&m Bauzentrum Rykena	Berumfehner Holz- und	Großheide
66357	102463	Willi Kasper GmbH		Hilden
66358	102464	Alzmetall Werkzeugmaschinenfabrik	und Gießerei Friedrich GmbH & Co.KG	Altenmarkt
66359	102465	BMN Bouwmaterialen BV		Lelystad
66360	102466	LOCA FRANCE	SARL	Marbache
66361	102467	BMN Bouwmaterialen BV		Deurne
66362	102468	Baubeschlaghandel Schlesinger		Dahme/ Mark
66363	102469	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Gouda
66364	102470	Karl Illas GmbH		Bad Arolsen
66365	102471	Premier Render Supplies Ltd.	Unit 3 & 4	Leeds
66366	102472	Stelter GmbH	Niederlassung Bremen	Bremen
66367	102473	BMN Bouwmaterialen BV		Schagen
66368	102474	WEMAG GmbH & Co. KG		Fulda
66369	102475	Heinrich Meier GmbH		Ainet
66370	102476	BMN Bouwmaterialen BV		Hengelo
66371	102477	BMN Bouwmaterialen BV		Amsterdam
66372	102478	BMN Bouwmaterialen BV		Harderwijk
66373	102479	LandMAXX BHG GmbH	Filiale Radeburg	Radeburg
66374	102482	Construction Site Supplies Ltd.		Slough
66375	102483	Edgar Borrmann GmbH & Co KG		Fernwald
66376	102484	P.H. Brauns GmbH & Co.KG		Braunschweig
66377	102485	BMN Bouwmaterialen BV		Drachten
66378	102486	Eisen-Fischer GmbH & Co.KG		Limburg / Lahn
66379	102488	Atko Group Limited	Unit 29, Rathenraw Ind. Est.	County Antrim
66380	102491	South West Fasteners Ltd.	Unit 7-8 306 Industrial Estate	Brislington Bristol
66381	102492	BOHRER	Mr. Dmitriy Kalinin	Smolensk
66382	102493	Baustoffmarkt Gersthofen		Gersthofen
66383	102494	Joseph Dresselhaus GmbH & Co. KG		Maisach
66384	102497	MH-Vertrieb		Detmold
66385	102498	CENTAR ALATA OSIJEK	Visokokv Alitetni Alati 1 Oprema	Osijek
66386	102499	Rubix GmbH		Mainz
66387	102501	Mölders Baucentrum GmbH		Uelzen
66388	102502	Konrad GmbH		Euskirchen
66389	102503	BMN Zaandam		Westzaan
66390	102504	KOCSIK-TOOLS Werkz. u. Dienstl.	ZNL: Heinrich Meier GmbH	Dieburg
66391	102505	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Amersfoort
66392	102506	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Den Haag
66393	102507	bauzentrum Segl		Hauzenberg
66394	102510	AST Sommer	Akustik-,Stuck- und Trockenbau GmbH	Kirchdorf am Inn
66395	102511	Carter Engineering Supplies Ltd.	5-6 Woodston Business Centre	Peterborough
66396	102514	Denk GmbH & Co.KG	Werkzeuge + Maschinen	Calden
66397	102515	EJOT Baubefestigungen GmbH		Bad Laasphe
66398	102517	Baillet		Bailllet
66399	102518	Calipro		Calipro
66400	102519	BMN Bouwmaterialen BV		Alkmaar
66401	102520	HUF Der Mainzer Fachmarkt		Mainz
66402	102521	GTH GmbH		Fribourg
66403	102522	BMN Bouwmaterialen BV		Doetinchem
66404	102523	BMN Bouwmaterialen BV		Zeist
66405	102525	Eisen Kübel Höfels GmbH		Oberhausen
66406	102526	Carl Beutlhauser	Baumaschinen GmbH	Passau
66407	102527	BMN Bouwmaterialen BV		Ootmarsum
66408	102528	Haberkorn GmbH		Wolfurt
66409	102529	CMPM PONT A MOUSSON		PONT A MOUSSON
66410	102530	BMN Bouwmaterialen BV		Maastricht
66411	102531	BMN Bouwmaterialen BV		Rotterdam
66412	102532	LSDM Limited T/A Leyland		Wembley
66413	102535	Fa. Alexander Ziegler		Villingendorf
66414	102536	Fixfast Ltd.	Merlin House	Sevenoaks, Kent
66415	102537	BMN Bouwmaterialen BV		Dokkum
66416	102538	BMN Bouwmaterialen BV		Best
66417	102540	Schraubenmax		Quickborn
66418	102541	Conecto Ltd.	Alan 086 0217737	Co Meath
66419	102542	BMN Bouwmaterialen BV		Dordrecht
66420	102543	Prager GmbH		Tönisvorst
66421	102544	BMN Bouwmaterialen BV		Stadskanaal
66422	102545	M&H Diatools		Den Haag
66423	102546	Pomex GmbH		Spangenberg
66424	102547	Baustoffmarkt Uhingen		Uhingen
66425	102548	Bankers Gereedschappen BV		Deurne
66426	102549	Khusheim Company For Industrial	Equipments	Dammam  Kingdom of Saudi Arabi
66427	102550	Raiffeisen Waren GmbH		Kassel
66428	102551	BMN Bouwmaterialen BV		Culemborg
66429	102552	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Neukloster
66430	102553	BOIS		Bois
66431	102554	CONSTRUCTION		CONSTRUCTION
66432	102556	ORCAB		ORCAB
66433	102557	Wilh. Holland Letz GmbH & Co.KG		Bebra
66434	102558	Bossong S.p.A		Grassobbio BG
66435	102561	ScrewQuick Ltd.		Salford, Manchester
66436	102562	Bricowelt Quincaillerie Sàrl		Oberpallen
66437	102563	SWD A. Hock GmbH		Darmstadt
66438	102564	BMN Bouwmaterialen BV		Rhenen
66439	102565	BMN Bouwmaterialen BV		Zwolle
66440	102566	Danhauser GmbH & Co KG	Baustoffe	Schwandorf
66441	102569	Franz Schneider GmbH & Co.KG	Technischer Grosshandel	Offenbach am Main
66442	102570	SG-Toolbox GmbH		Linz
66443	102571	Isero IJzerwarengroep B.V.	Gerritse Wijchen	Wijchen
66444	102572	FILO	Filo Baumaterial-Support GmbH	Döttingen
66445	102573	tools & more Simon	Inhaber: Frank Simon	Halle/Saale
66446	102575	Johannes Karl Ritt	Technischer Industriebedarf	Zelking-Matzleinsdorf
66447	102577	BMN Bouwmaterialen BV		Weert
66448	102578	Christian Wittmann	Werkstattbedarf GmbH	Günding
66449	102579	Blasy GmbH		Insbruck/ Neu-Rum
66450	102580	Franz Heydt Fachhandels-GmbH		Rastatt
66451	102582	REDKO GmbH & Co.KG		Leverkusen
66452	102583	Rüger GmbH		Rüsselsheim
66453	102585	Quincaillerie Lapeyre	Denis	St. Girons
66454	102586	A. Sommer GmbH	Werkzeuge-Maschinen	Seligenstadt/Hessen
66455	102587	InDia - Thiemt		Bad Salzdetfurth
66456	102588	AMAZON mit BEILAGE		Vechta
66457	102589	Hermann Kastner GmbH		Zwettl
66458	102590	Kindlinger GmbH		Linz
66459	102591	Ploberger GmbH		Retz
66460	102592	Schmidt's Handelsges.m.b.H.		Bürs
66461	102598	Steyr-Werner	Technischer Handel GmbH	Pasching
66462	102599	Weyland Steiner	Handwerks- und Industriebedarf GmbH	Bergheim
66463	102601	Stahl & Krähe GmbH	Werkzeuge- u. Maschinenhandel	Zweibrücken
66464	102602	Theodor Wölpert GmbH & Co.KG	Baumarkt Murrhardt	Murrhardt
66465	102604	Theodor Wölpert GmbH & Co.KG	Niederlassung Mössingen	Mössingen
66466	102606	Theodor Wölpert GmbH & Co.KG	Niederlassung Bad Urach	Bad Urach
66467	102609	Theodor Wölpert GmbH & Co.KG		Engstingen-Kohlstetten
66468	102611	Köhnen handwerk-& industriebedarf		Polch
66469	102612	Theodor Wölpert GmbH & Co.KG	Niederlassung Göppingen	Göppingen
66470	102613	Theodor Wölpert GmbH & Co.KG	Niederlassung Ellwangen	Ellwangen
66471	102614	Theodor Wölpert GmbH & Co.KG	Niederlassung Kempten	Kempten
66472	102615	Theodor Wölpert GmbH & Co.KG	Niederlassung Meckenbeuren	Meckenbeuren
66473	102616	Theodor Wölpert GmbH & Co.KG	Niederlassung Bad Waldsee	Bad Waldsee
66474	102617	Theodor Wölpert GmbH & Co.KG	Niederlassung Warthausen	Warthausen
66475	102618	Theodor Wölpert GmbH & Co.KG	Niederlassung Ertingen	Ertingen
66476	102619	Theodor Wölpert GmbH & Co.KG	Niederlassung Illertissen	Illertissen
66477	102621	BMN Bouwmaterialen BV		Venray
66478	102622	BMN Bouwmaterialen BV		Enschede
66479	102623	BMN Bouwmaterialen BV		Lemmer
66480	102624	BMN Bouwmaterialen BV		Asten
66481	102625	BMN Bouwmaterialen BV		Haastrecht
66482	102627	BMN Bouwmaterialen BV		Nijmegen
66483	102628	BMN Bouwmaterialen BV		Soest
66484	102629	BMN Bouwmaterialen BV		Enkhuizen
66485	102630	BMN Bouwmaterialen BV Oost	Adresse für Rechnungsversand	Nijverdal
66486	102631	SC OMP SRL		Bacau
66487	102632	Manfred Raskob GmbH	Werkzeuge u. Maschinen	Wittlich
66488	102633	Werkstatt	Heller Tools GmbH	Dinklage
66489	102634	Fixings and Tools Ltd.	T/A Mr. Fixings	Salford, Manchester
66490	102635	C-Serve GmbH		Köln
66491	102636	PT ZI-TECHASIA	22nd Floor Menara Jamsostek Bld.	South Jakarta
66492	102637	Müthing GmbH & Co.KG	Langensteinach	Uffenheim-Langensteinach
66493	102638	Werkzeug Polster		Thallwitz OT Böhlitz
66494	102641	EDER WERKZEUGHANDEL	Christian Eder Walter	Zillingdorf-Bergwerk
66495	102642	E.W. Neu GmbH		Speyer
66496	102643	CD JUWEL GmbH	Andreas Hühn	Thyrnau / Passau
66497	102644	Homberg Eisenhandel GmbH	Josef Ruhland	Dingolfing
66498	102645	Festool GmbH		Wendlingen
66499	102646	Georg Pirrung GmbH		Bexbach
66500	102647	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Nieuw Vennep
66501	102649	Toolstation SAS		Saint Priest
66502	102650	Toolstation		Toolstation
66503	102651	Sealants and Tools Direct		Newton Abbot,Devon
66504	102653	Craven Eye PBG / HTG Suppliers Ltd.		Middlesex
66505	102654	Corefix Ltd	The Innovation Centre	Newport, Isle of Wight
66506	102657	Kruyt	Bouw en Industrie	Leiderdorp
66507	102659	Mölders Baucentrum GmbH		Tangermünde
66508	102660	Good Traders UG(Haftungsbeschränkt)		Bremen
66509	102663	Ladwein GmbH & Co. KG		Dierdorf
66510	102667	Schnellversand-Miller		Dinklage
66511	102671	Baillargeat	SA Quincaillerie	Andernos Les Bains
66512	102672	Piel GmbH		Eisenhüttenstadt
66513	102674	ZITEC Industrietechnik GmbH		Plattling
66514	102676	TP Location		Hoerdt
66515	102677	EJOT TEZMAK Baglanti Elem.Tekn.	San ve Tic. A.S.	Istanbul 34250
66516	102678	Waltraud Rothamel	Handelsvertretung für Werkzeuge	Barchfeld-Immelborn
66517	102680	LINK CZ, s.r.o.		Paskov
66518	102683	Eisenhof Liezen		Liezen
66519	102685	Felix Trautmann		Sulzbach am Main
66520	102687	DBZ Dinkelsbühler Baustoffzentrum	GmbH	Dinkelsbühl
66521	102688	Tecnaria S.p.A.		Bassano del Grappa (VI)
66522	102689	ParkerSteel Ltd		Kent
66523	102690	SIGD Manchester		Manchester, Lancashire
66524	102693	Huber GmbH		Tiefenbach
66525	102695	UNION Bauzentrum HORNBACH GMBH	Fil. Buchen	Buchen
66526	102696	Milwaukee		Brookfield WI 53005 USA
66527	102699	REVENDEUR SPECIALISE 3		REVENDEUR SPÉCIAL 3
66528	102700	E.W. Neu GmbH	Werkzeuge + Maschinen	Worms
66529	102701	Atala GmbH & Co.	Fliesen- und Sanitärhandel KG	Berlin
66530	102702	Smit Maassluis BV		Maassluis
66531	102705	GSB	Grande surface bricolage	GSB
66532	102706	LOCATION		LOCATION 3
66533	102707	Internet		WEB 3
66534	102708	Gillet Baustoffe GmbH		Neustadt
66535	102709	Fabricant		Fabricant
66536	102710	Würth Belux N.V.		Turnhout
66537	102711	Reitex GmbH		Ruderting
66538	102712	Chr. Ufer GmbH	Stahl- und Sanitärgroßhandel	Landau/Pfalz
66539	102713	Dinger & Voigt Werkz. GH und	Werkstattausr. Inh. T. Dinger e.K.	Plauen
66540	102714	Metallit GmbH	Thomas Kraemer	Bielefeld
66541	102715	Jardin		Jardin
66542	102716	ENTUZIAST		Belgrad
66543	102717	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren (Beukers)	Hilversum
66544	102718	STAMAG Ersatzteil- und	Industrievertrieb GmbH	Landsberg OT Queis
66545	102720	Lievertz Fachgroßhandel Haust.	Zweigniederl.J.W.Zander GmbH &Co.KG	Kleve
66546	102721	F. Schünke GmbH		Engen
66547	102722	Industrieterrein Remmerden		Rhenen
66548	102723	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Veenendaal
66549	102725	Macsalvors Ltd.		Redruth
66550	102726	TERWECO C.V.		OLDENZAAL
66551	102727	SSW Bedachungs- und Holzfachhandel		Heinsberg
66552	102728	Werkzeugtechnik Günter	Inh. Frank Günter	Castrop Rauxel
66553	102729	Hans Schmidt GmbH	Werkz.Masch.Industriebed.	Kaiserslautern
66554	102731	R. Holzschuh Baugeräte		Sulzbach
66555	102733	EDIL2000 SRL		Altamura BA
66556	102734	Scheiber GmbH	Befestigungselemente	Weilerbach
66557	102736	Robert Schlott Werkzeuge und	Maschinen	Geretsried
66558	102737	RM Diffusion	Mr. Mohammed Regui	Casablanca Marokko
66559	102738	Mobau Wirtz & Classen		Kempen
66560	102740	TECNOSERVICE DI MARTIN RENATO		Lugugnana Di Portogruaro
66561	102742	Leinad GmbH		Fernitz bei Graz
66562	102744	blizz-z Handwerk Direkt GmbH		Feuchtwangen
66563	102745	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Ijsselstein
66564	102746	Isero IJzerwarengroep B.V.	Van der Winkel	Venray
66565	102747	Markus Meisnitzer	MM industrie	Salzburg
66566	102748	G.Elsinghorst	Stahl und Technik GmbH	Bocholt
66567	102749	Andresen & Jochimsen GmbH& Co. KG		Hamburg
66568	102750	Marcel Bornemann		Hamburg
66569	102753	Pietsch Haustechnik GmbH		Leipzig
66570	102754	Uhlendorff GmbH & Co KG		Mönchengladbach
66571	102755	Grill Großhandels GmbH		Kapfenberg
66572	102756	helbig & bertholdt oHG	Werkzeug und Industriebedarf	Mönchengladbach
66573	102757	HYDROTECNO SRL		Ponte nelle Alpi
66574	102759	Werkzeuge & Maschinen	Neuber Präzisionswerkzeuge	Freilassing
66575	102760	Diamond Tool Supplies Ltd.		Shrewsbury
66576	102761	REMI- Baumaterialien GmbH		Wettingen AG
66577	102762	Zingen Fachmarkt	Inh. Martin Mertes	Speicher
66578	102763	B+M Baustoff+Metall Handels-GmbH		Heilbad Heiligenstadt
66579	102764	STI BV		Hengelo
66580	102765	Strobel Elektrotechnik		Rheinfelden
66581	102766	B. Schlichter GmbH & Co. KG	Ndl. Süd	Heppenheim
66582	102770	WS Weinmann & Schanz GmbH		Balingen
66583	102771	Bartsch & Feikes	Werkzeuge & Maschinen GmbH	Brüggen
66584	102772	Walter Nilsson GmbH & Co.KG		Osnabrück
66585	102773	B & S Werkstattbedarf e.K.		Mömlingen
66586	102774	Johann van Beusekom e.K.	Werkzeuge + Maschinen	Kleve
66587	102776	BAUKING Westfalen GmbH	FH Essen Ges.-Nr.144107	Essen
66588	102777	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
66589	102778	BEVER GmbH		Kirchhundem-Würdinghausen
66590	102779	Fournitures Industrielles Billet	SAS	Valserhone
66591	102780	Billet Fournier	SAS	Meythet
66592	102782	EDE FRANCE		EDE FR
66593	102783	BILLET FOURNIER		BILLET FOURNIER
66594	102784	BILLET FOURNIER 3		BILLET FOURNIER 3
66595	102785	schraubenkontor24	Inh. Steffen Kopke	Malschwitz
66596	102786	De Lentdecker Luc NV		Demdermonde
66597	102787	Christian Werzner	Baumaschinen	Olbernhau
66598	102788	GRAMA TRADE GmbH		Graz-Neuhart
66599	102789	Innovative Tools GmbH + Co. KG		Haan-Gruiten
66600	102790	Ballas GmbH		Aichach
66601	102791	BDW & Sauna	Matthias Rother	Suhl
66602	102792	HBiW Bernd Joest	Gewerbepark	Bad Berka
66603	102793	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Houten
66604	102794	C&J Direct GmbH & Co.KG		Verl
66605	102795	Comptoir d'Importation Bordelaise	CASAL SAS	Artigues-Près -Bordeaux
66606	102796	Industrie-Service-GmbH		Althengstett
66607	102797	Linzing & Dörr Heiz.-und	Sanitärgroßhdl. GmbH	Biebesheim
66608	102798	Lochter Industriebedarf	und Service GmbH	Oberhausen
66609	102799	HAKI Befestigungstechnik	Technischer Großhandel	Untersteinach
66610	102800	White Hinge Ltd.	C/O Dee Set Distribution Centre	Fenton, Stoke on Trent
66611	102801	Newton Hale & Sons Limited	Independence House, Cathcart Quay	Birkenhead, Merseyside
66612	102802	Heller Tools RUS, LTD		Moscow
66613	102803	GFB Handelsgesellschaft	Bef. Technik GmbH	Oberhausen
66614	102804	Bussemas & Pollmeier GmbH & Co.KG		Harsewinkel
66615	102805	Bussemas & Pollmeier GmbH & Co.KG		Gütersloh
66616	102806	Planet Plus Ltd.		Hampshire
66617	102808	Cornelisse	Hecht-Techniek B.V.	Woerden
66618	102809	Power Tools Plus Ltd.		Colwick, Nottingham
66619	102810	bau Spezi Handels GmbH Lauter		Lauter-Bernsbach
66620	102811	Peter Kasberger Baustoff GmbH		St. Florian am Inn
66621	102813	Eisen Schütz  Nachf. GmbH		Duisburg 12
66622	102814	Handelshof Vorpommern	Neubrandenburg	Neubrandenburg
66623	102819	BV C-Supply		Temse
66624	102820	Hansen Seest ApS	Herr Per Hansen	Kolding
66625	102822	Kadach & Rick GmbH		Sankt Augustin
66626	102824	NB Nürnberger Bund PVH  GmbH	Herr Verbiest	Hagen
66627	102825	NB Nürnberger Bund PVH GmbH	Fachgruppe Werkzeuge	Hagen
66628	102826	Karl Kemper GmbH & Co. KG		Gelsenkrichen
66629	102827	NV Hout-& Bouwcenter Van den Nest		Aalst
66630	102828	Wilhelm Fülling GmbH		Mülheim
66631	102829	Raiffeisen Waren GmbH		Erfurt
66632	102830	Reply d.o.o.		Podstrana
66633	102832	Fernholz & Gördes GmbH		Hagen
66634	102833	Rudolf Krämer	Eisenwaren GmbH	Duisburg 14/Rheinhausen
66635	102835	Baupart GmbH		Bottrop
66636	102836	Richter Baustoffe GmbH	(Baustoffe Hagenow)	Hagenow
66637	102837	Baustoff Union GmbH		Nürnberg
66638	102839	Mister Fasteners Ltd.		Bideford, Devon
66639	102840	Baumaschinen Grünhage GmbH		Hohe Börde OT Irxleben
66640	102842	H. Wollschläger GmbH & Co.KG		Bochum
66641	102843	East Engineering Components Ltd.	Unit 9	Milton Keynes
66642	102845	EURAFCO GmbH		Rellingen
66643	102846	Makita nv		Kortenberg
66644	102847	Wilhelm Linnenbecker GmbH & Co.KG		Hannover
66645	102848	JACOB CEMENT FLIESEN	Jacob Sönnichsen AG	Kritzmow OT Klein-Schwaß
66646	102849	TIB Technischer Industrie-Bedarf	Lackmann GmbH	Essen
66647	102850	J.W. Zander GmbH & Co.	PRIVATE LABEL ZA-TEC	Essen
66648	102851	F. LLI PUPPA SRL		LU
66649	102852	J.W. Zander GmbH & Co		Essen
66650	102853	Rudi Droxner	Baubeschläge und Eisenwaren	Bad Saulgau
66651	102854	GoldmannLindenberger GmbH & Co. KG		Pforzheim
66652	102855	Jens-Günther Hagelstein	WERKZEUGE HAMBURG	Hamburg
66653	102856	Bauzentrum Schulte GmbH & Co.KG	KG  NL BauXpert Brak	Rhede (Ems)
66654	102857	Van de Velde - Wilems NV		Eeklo
66655	102859	UK Building Products Ltd.	GripIt Fixings	Melksham, Wiltshire
66656	102860	Peter von Ohle GmbH		Essen
66657	102861	DER BAUSTOFF-MANN	Schneider KG	Oberhausen
66658	102862	Kipp & Grünhoff GmbH & Co. KG		Leverkusen
66659	102863	Kipp & Grünhoff GmbH & Co. KG		Ratingen
66660	102865	Kipp & Grünhoff GmbH & Co. KG		Bergisch Gladbach
66661	102868	Baustoff-Allianz Süd GmbH		Ingolstadt
66662	102870	Mahler Bayerische Bauwaren GmbH		Feldkirchen
66663	102871	Bauwaren Mahler GmbH		Augsburg
66664	102872	Isero IJzerwarengroep B.V.	Gerritse Amsterdam Noord	Amsterdam
66665	102873	Friedrich Delker GmbH & Co KG	Werkzeuge-Maschinen	Essen
66666	102874	Ahlsell Sverige AB		Hallsberg
66667	102877	Beratung Handel Werkzeuge	Inh. D.Kawka	Markersdorf
66668	102878	Richter Baustoffe GmbH	(Baustoffhandel)	Lübeck
66669	102879	Richter Baustoffe GmbH & Co. KGaA		Talkau
66670	102880	Richter Baustoffe GmbH		Barsbüttel
66671	102881	Bauzentrum Zerssen GmbH & Co. KG		Rendsburg
66672	102882	Hoofdzetel Central Auto		Antwerpen
66673	102883	IHS-Hofbauer GmbH		Cham-Chammünster
66674	102884	Baufachzentrum Falkenhagen GmbH		Holthusen
66675	102885	Richter Baustoffe GmbH & Co. KGaA		Bad Schwartau
66676	102886	WERKTOY GbR	Werkezeug & Mehr	Wildeshausen
66677	102887	Breur IJzerhandel		Den Haag
66678	102888	Troy (UK) Ltd. t/a THS Tools	Salisbury House	Templeborough, Rotherham
66679	102889	Baufachzentrum Falkenhagen GmbH	Niederlassung Wittenberge	Wittenberge
66680	102890	OOO ENERGOUSKUNATAMINOT		Taschkent
66681	102891	EisenRon.de	Inh. Ronny Sorgenfrei	Delitzsch
66682	102892	Toolendo GmbH & Co.KG		Erbendorf
66683	102893	Baufachzentrum Falkenhagen GmbH		Neuruppin
66684	102894	Nybra Maskin as		Oslo
66685	102895	Baufachzentrum Falkenhagen GmbH		Pritzwalk
66686	102899	SAS ARKEDIA		Turckheim
66687	102900	ADSOLS	Sarl	ANTIBES
66688	102901	HFM-Nordholz Handelsges. mbH		Luckenwalde
66689	102902	HFM-Nordholz Handelsges. mbH		Berlin
66690	102903	Richter Baustoffe GmbH	(Ndl. Wismar Baustoffe)	Dorf Mecklenburg OT Steffin
66691	102904	HIKOKI POWER TOOLS Netherlands B.V		Nieuwegein
66692	102905	Max Schierer GmbH		Cham
66693	102906	Ludwig Schierer GmbH		Cham
66694	102907	HFM-Nordholz Handelsges. mbH		Berlin
66695	102908	Mapeco Kalmthout-Nieuwmoer NV		Kalmthout-Nieuwmoer
66696	102909	Richter Baustoffe GmbH	(Ndl. Kiel)	Kiel
66697	102910	Berliner Schrauben GmbH & Co KG	Logistikzentrum	Dahlwitz-Hoppegarten
66698	102911	Mobau: Pegels Viersen		Viersen
66699	102912	Schrauben Jansen GmbH		Neuss
66700	102913	Chopshoptools Ltd.		Bridgend, Mid Glamorgan
66701	102914	EXPERTbeslag A/S		Glostrup
66702	102915	Toolstation (Middleton) Ltd.		Middleton, Manchester
66703	102916	ROTH ESPACE GRANIT	Sarl	NEUF BRISACH
66704	102917	Baucentrum Stewes GmbH & Co.KG		Dinslaken
66705	102918	ARTISANS		Artisans
66706	102919	MTB Marienthaler Baustoffhandel	GmbH	Zwickau
66707	102920	Raiffeisen-Waren GmbH		Gera
66708	102922	GLOBAL SOURCE MIDDLE EAST GENERAL	TRADING LLC	DEIRA DUBAI, UAE
66709	102923	Richter Baustoffe GmbH		Behl
66710	102924	BAUKING Südwestfalen GmbH		Finnentrop
66711	102925	Karl Gollinger	Werkzeuge + Maschinen	Augsburg
66712	102927	Hass + Hatje GmbH	Bauzentrum Uetersen	Uetersen
66713	102928	Alois Herrmann GmbH		Merchweiler
66714	102930	M & M Industrietechnik GmbH		Harrislee
66715	102931	Reisinger GmbH		Burghausen
66716	102932	Dachbaustoffe Rath GmbH & Co. KG	(Ndl. Schwerin)	Schwerin
66717	102933	Alexander Keller		Albstadt
66718	102934	APM Plumbing Ltd.		London
66719	102936	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren (Savannah)	Utrecht
66720	102938	Fischer-J.W. Zander GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Erlenbach
66721	102939	Wilhelm Rink GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Wetzlar
66722	102940	J.W. Zander GmbH & Co. KG		Freiburg
66723	102941	LuDz Mitte GmbH & Co. KG	Hermann Albert Bumke GmbH & Co. KG	Hannover
66724	102942	Leib Industrieausrüstungen GmbH		Wettenberg-Launsbach
66725	102943	Cl. Bergmann GmbH & Co. KG	PRIVATE LABEL ZA-TEC	Kassel
66726	102944	Heix GmbH & Co. KG		Geldern
66727	102945	UK-European Farm Supplies Ltd.		Montrose
66728	102946	BPG De Hillegomse	Hout & Bouwmaterialen	Hillegom
66729	102948	Penlaw Fixings North Ltd.		Warrington
66730	102950	ADSOLS	Sarl	ANTIBES
66731	102951	Baucentrum Stewes GmbH & Co.KG	(hagebaumarkt Wesel)	Wesel
66732	102953	Max Schierer GmbH		Straubing
66733	102954	Dachbaustoffe Rath GmbH & Co. KG		Rostock
66734	102955	DHZ joye - den baes BVBA		Lichtervelde
66735	102956	Dachbaustoffe Rath GmbH & Co. KG		Barsbüttel
66736	102958	Berger Bau- u. Industriebedarf GmbH		Traunstein
66737	102959	Werkzeug-Kontor Lübeck		Lübeck
66738	102961	BauKing GmbH	(Ndl. Iserlohn)	Iserlohn
66739	102963	Hotze Baucentrum GmbH & Co.KG		Köthen
66740	102964	Hotze Baucentrum GmbH & Co.KG		Staßfurt
66741	102965	Christian Knieß GmbH	Friedberger Eisenhandlung	Friedberg
66742	102966	Ludwig Falk	Inh. Clemens Drexlmeier	Frontenhausen
66743	102968	Godevaart Eyckermann BVBA		Brasschaat
66744	102970	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
66745	102971	GEDIMAT CORTELLONI	Sàrl	TOULON
66746	102973	BWM Baugeräte Werkzeughandel	Minden GmbH	Minden
66747	102974	BMN Wijcks Afbouwmaterialen Kampen		Kampen
66748	102977	Beuter Handelsvertretung		Lohmar
66749	102978	BHG Raiffeisen-Warengenossenschaft	Wittstock eG	Wittstock
66750	102979	Richter Baustoffe GmbH		Schneverdingen
66751	102980	STAHLGRUBER GmbH		Poing bei München
66752	102982	Keller & Kalmbach GmbH		Unterschleißheim
66753	102985	GEDIMAT CORTELLONI	Sàrl	La Seyne sur Mer
66754	102986	GEDIMAT CORTELLONI	Sàrl	Le Pradet
66755	102987	Klokow Industrietechnik GmbH		Lübeck
66756	102988	Deubler GmbH		Wertingen
66757	102989	Rudolf Sievers GmbH	Partner für Technik	Glinde
66758	102991	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Den Haag
66759	102992	Bandock	Alexis	Champillon
66760	102993	Lösch Schrauben GmbH		Nürnberg
66761	102994	Eisen Fischer GmbH		Nördlingen
66762	102995	Schurrer GmbH & Co.KG		Nördlingen
66763	102997	SOGEA EST BTP SASU	Etablissement MULLER THA	Pont-a-Mousson Cedex
66764	102998	IHL Industriebedarf Hoyer		Leipzig
66765	102999	Gassmann Industriebedarf GmbH		Heilbad Heiligenstadt
66766	103000	Baustoff Union GmbH		Forchheim
66767	103001	Danhauser GmbH & Co KG	Baustoffe	Weiden
66768	103002	Expo Drill & Tools		Tenby
66769	103003	Rompel Baustoffe GmbH	(Ndl. Biedenkopf)	Biedenkopf-Breidenstein
66770	103005	OOO AstErabel		Grodno-Weisrussland
66771	103006	Dilworth & Morris Engineers Ltd.		High Peak, Derbyshire
66772	103007	CEG-Central European Group s.r.o.		Zlaté Moravce
66773	103008	3D Tooling Limited		Bolton, Lancashire
66774	103009	Krüger & Scharnberg G.m.b.H.	(Standort Wandsbek)	Hamburg
66775	103010	J.N.Kreiller KG		Traunstein
66776	103011	Tim Service GmbH		Bad Saulgau
66777	103013	Rompel Baustoffe GmbH		Bad Berleburg
66778	103014	Flintnine Fasteners Limited		Manchester
66779	103015	Jacob Boer B.V.		Goes
66780	103016	DESBOIS	Claude	Plelan le Grand
66781	103017	BayWa AG Marktredwitz	Vertrieb Baustoffe	Marktredwitz
66782	103018	Mercer & Sons Ltd.		Blackburn
66783	103019	Sylvia Schwesig Werkzeuge	Eisenwaren	Crivitz
66784	103020	Krüger & Scharnberg GmbH	(Standort Winterhude)	Hamburg
66785	103021	Mosswood Industrial Supplies Ltd.		Cwmbran, Torfaen
66786	103023	Baucentrum Stewes GmbH & Co.KG	(Baustoffhandel Wesel)	Wesel
66787	103024	Follmann Baustoffe GmbH		Binsfeld
66788	103026	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Almere
66789	103027	TROY (UK) Ltd.	Roundswell Business Park	Barnstaple, Devon
66790	103028	Hüllinghorst Maschinenhandel		Bielefeld
66791	103029	Wensley Mini Market	t/a Premier Plumbing and DIY	Blackburn
66792	103030	T-Tec UG		Hildburghausen
66793	103031	Logistik- und Dienstleistungs-	zentrum	Bochum
66794	103032	BM Sondermaschinen	Werkzeuge und Montage	Nürnberg
66795	103033	HBV Holz-& Baustoff-Vertriebs GmbH	& Co.KG	Wilhelmshaven
66796	103034	Josef Thelen GmbH & Co.KG	Fachmarkt	Simmerath
66797	103035	Fritz Krieger GmbH & Co. KG		Longuich
66798	103037	eberle-hald Handel und Dienst-	leistungen Bühl GmbH	Bühl
66799	103038	W+R INDUSTRY GmbH		Metzingen
66800	103039	MS Distribution Sàrl		CREVIN
66801	103042	GROUPE MS Distribution		CREVIN
66802	103043	IBACOM - Jean Francois Rogue		Chappes
66803	103044	BMJ S.A.S.U		Celles sur Durolle
66804	103045	Andara Tools & Plant Hire Ltd.		Orpington
66805	103046	FOCUS PLANT HIRE		ORPINGTON, KENT
66806	103047	De Jong & Roos B.V.		Schagen
66807	103049	AD Fixings Ltd.		Newcastle upon Tyne
66808	103050	ISERO Ijzerhandel B.V.	Pijnenburg	Kaatsheuvel
66809	103051	SGS Industrial Services GmbH		Dorf an der Pram
66810	103052	Cl. Bergmann GmbH & Co. KG		Kassel
66811	103053	Isol-Rénov Habitat SAS		Bitche
66812	103055	Genissel ENP SARL	Vincent	Roussé-Vassé
66813	103056	BAUEN+LEBEN GmbH & Co.KG		Ottendorf-Okrilla
66814	103057	Europarts b.v.	Auto onderdelen & Hydraulische	Aalsmeer
66815	103058	SIG Technical Insulation - Swansea		Ammanford, Swansea
66816	103059	Friedrich Bauzentrum GmbH & Co. KG		Elz
66817	103060	Nagel Baumaschinen	Frankfurt GmbH	Frankfurt
66818	103061	Raiffeisen Waren GmbH	(Ndl. Fritzlar)	Fritzlar
66819	103062	Ecitec Toolbox Outlet		Assen
66820	103063	E.Raiss GmbH & Co. Baustoffhandel	KG	Thannhausen
66821	103068	Josef Sedlmayr e.k.	Inhaber Sedlmayr-Bekmann	Freyung
66822	103069	CRH		Amsterdam
66823	103070	David Harries & Co.		Whitland, Carmarthen
66824	103072	Maschinen Stockert	Großhandels-GmbH	Hohenbrunn / München
66825	103073	Capital Baustoffe GmbH		Berlin
66826	103074	BAUKING Südwestfalen GmbH	(Ndl. Siegen)	Siegen
66827	103075	Raiffeisen Waren GmbH	(Ndl. Hünfeld)	Hünfeld
66828	103076	YM FIX SARL		Le Pin
66829	103077	Baushop Express GmbH		München
66830	103078	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leiden
66831	103079	Smit-Commerce d.o.o.		Gornji Stupnik
66832	103080	Jens Scherzer	schrauben-dealer.com	Plauen
66833	103081	SFI SASU		Ennezat
66834	103082	Bohrstand	Heller Tools GmbH	Dinklage
66835	103083	ALFIS SARL		Chennevriéres sur Marne
66836	103084	HEIMWERK Baumarkt - Genthin		Genthin
66837	103086	HEIMWERK Baumarkt - Burg		Burg
66838	103088	OKOV INTERNATIONAL LLC		Belgrade-Novi
66839	103089	BMN IJzerwaren Den Helder		Den Helder
66840	103090	Falk Rauch Werkzeuge		Magdeburg
66841	103091	KRAFT Shpk		Tirana, Kashar
66842	103092	FDB Guardian GmbH		Neuenstein
66843	103093	BAUKING Westfalen GmbH	(Ndl. Hagen)	Hagen
66844	103094	Ruf Bauzentrum GmbH & Co.KG		Feuchtwangen
66845	103095	TSS Tools Supply - Import Company		Arnhem
66846	103096	BAUKING Ostfalen GmbH	Fachhandel Braunschweig	Braunschweig
66847	103097	Ems Schrauben GmbH		Werlte
66848	103099	C. G. Christiansen GmbH & Co.	(Baustoffe + Holz)	Flensburg
66849	103100	Handelshof Vorpommern GmbH	Partner für Technik	Grimmen
66850	103101	V Produkte GmbH	Falk Schönau	Plößberg
66851	103103	btb Rockermeier	Diamanttechnik	Reichertshofen/Hög
66852	103104	Rawlplug Co. Ltd.	Thornliebank Ind. Estate	Glasgow
66853	103105	Nawrot Groß- u. Einzelhandel		Ahlen (Westfalen)
66854	103106	Bauking Südwestfalen	(Ndl. Arnsberg)	Arnsberg
66855	103107	BAUKING Ostfalen GmbH	(Ndl. Halberstadt)	Halberstadt
66856	103108	Henselmann et Fils Sarl		Niderviller
66857	103112	Raiffeisen-Waren GmbH		Meiningen
66858	103114	Nouvelle Quincaillerie Bordelaise	Benedetti SARL	Eysines
66859	103115	DONCKERS ANTWERPEN		Antwerpen
66860	103116	Handwerkskammer für Oberfranken	Berufsbildungs- und Technologie-	Bayreuth
66861	103117	SSW Bedachungs- und Holzfachhandel	GmbH & Co. KG	Mönchengladbach
66862	103120	Dänus Baubedarf GmbH		Gebenstorf
66863	103121	Klokow Industrietechnik GmbH		Schwerin
66864	103122	SAS ILE DE FRANCE FIXATION		Saint Denis la Plaine
66865	103123	Gehelle	SAS	Varenne Saint Hilaire
66866	103124	Stanley Black & Decker GmbH		Idstein/Taunus
66867	103125	leikon metall & technik GmbH	Vertriebsgesellschaft mbH	Lienz
66868	103126	Quincaillerie Dubos	SARL	Noisy le Grand
66869	103127	BAUKING Südwestfalen GmbH	(Ndl. Meinerzhagen)	Meinerzhagen
66870	103128	LM Fixations Sarl		Bussy-Saint-Georges
66871	103129	Rabattring Frankreich Großhandel		.
66872	103130	Rabattring Frankreich Fachhandel		.
66873	103132	Laboureau	Sarl	Paris
66874	103133	Diamant Löttechnik Nord GmbH		Husby
66875	103134	Suchail	SAS	Saint Étienne
66876	103135	Alois Jakob Metall am Bau GmbH		Waldkirchen
66877	103136	Keil Profi-Werkzeuge GmbH		Engelskirchen-Loope
66878	103137	CPA-Werkzeuge		Aichach
66879	103138	Raiffeisen-Waren GmbH		Mühlhausen
66880	103139	BAUKING Ostfalen GmbH	(Ndl. Salzwedel / Brietz)	Salzwedel OT Brietz
66881	103140	Phoenix Industrial Supplies Ltd.	Cardiff Branch	Cardiff
66882	103141	Origo Distribution Ltd.		Dublin
66883	103142	Bauxpert Knipper GmbH & Co. KG		Werlte
66884	103143	Terratruck Distribution Serv. Ltd.		Leicester
66885	103144	Yorkshire Fixings Solutions Ltd.	Unit E3, Otley Mills	West Yorkshire
66886	103145	METALKA ZASTOPSTVA TORNA, D.O.O.		Ljubljana-Crnuce
66887	103146	Uždaroji akcin? bendrov? "Glomera"		Garliavos
66888	103147	REVERT SAS CARNOT SAS		Versailles
66889	103148	BAUKING Berlin-Brandenburg GmbH		Potsdam
66890	103149	BAUKING Berlin-Brandenburg GmbH		Königs Wusterhausen
66891	103150	BAUKING Berlin-Brandenburg GmbH		Brandenburg
66892	103152	BAUKING Berlin-Brandenburg GmbH		Hoppegarten
66893	103153	BAUKING Berlin-Brandenburg GmbH		Fürstenwalde
66894	103154	BAUKING Berlin-Brandenburg GmbH		Berlin Hohenschönhausen
66895	103155	BAUKING Berlin-Brandenburg GmbH		Berlin Schöneberg
66896	103156	High-Tech Sealants & Fixings Ltd.		Swindon, Wiltshire
66897	103157	Beilke GmbH		Soest
66898	103158	BAUKING Südwestfalen GmbH	(Ndl. Plettenberg)	Plettenberg
66899	103159	FRW	Falk Rauch	Magdeburg
66900	103160	Luschka & Wagenmann GmbH & Co.KG		Mannheim
66901	103161	Polvo B.V.	Holtgrefe Waalwijk	Waalwijk
66902	103163	J.W. Zander GmbH & Co. KG WEST	PRIVATE LABEL ZA-TEC	Bochum
66903	103165	BAUKING Ostfalen GmbH	(Ndl. Magdeburg)	Magdeburg
66904	103166	Bussemas & Pollmeier GmbH & Co.KG		Bielefeld
66905	103167	team baucenter GmbH & Co KG		Neustadt
66906	103168	BAUKING Südwestfalen GmbH	(Ndl. Lennestadt)	Lennestadt
66907	103169	Hubert Graf Technisches Geschäft	GmbH	Rheine
66908	103170	BAUKING Berlin-Brandenburg GmbH		Prenzlau
66909	103171	WTH Jens Lüdemann		Großenhain/ OT Strauch
66910	103172	BAUKING Weser-Ems GmbH	(Ndl. Melle)	Melle
66911	103173	Rabattring Frankreich Sosaca		.
66912	103174	Hermann Remmers GmbH		Lindern
66913	103175	BVG Cementmüller Baustoffvetrieb	GmbH & Co. KG	Tostedt
66914	103177	Karlhans Efinger Baustoff GmbH		Trossingen
66915	103178	Pribon BVBA		Kasterlee
66916	103179	Raiffeisen Waren GmbH		Jena
66917	103180	LuDz Mitte GmbH & Co. KG	Hermann Albert Bumke GmbH & Co.KG	Hannover
66918	103181	Dietmar Rauch	Alles für Haus & Garten	Leipzig
66919	103182	BMN Bouwmaterialen BV	Schiedam	Schiedam
66920	103183	Absolute Power Tools Ltd.		Bowerhill, Melksham
66921	103184	F.I. Services - Master PRO		Mitry Mory
66922	103185	BAUKING Westfalen GmbH	(Ndl. Bochum)	Bochum
66923	103186	Smart Solutions Suppliers		Lattakia
66924	103187	Mundfortz Baustoffe GmbH		Schwalmtal
66925	103188	TFix Polska Sp.z.o.o.	Piotr Malinowski	Sekocin Nowy
66926	103189	CC SuppliesLtd	Unit 4	Rochester, Kent
66927	103190	Raiffeisen Waren GmbH	(Ndl. Göttingen)	Göttingen
66928	103191	Brüning GmbH		Geldern
66929	103192	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Leerdam
66930	103193	Quincaillerie Portalet SARL		Boe
66931	103194	Multiquip Supplies	Unit 1 Glenmore Bus Park	Chippenham
66932	103195	Raiffeisen Waren GmbH	(Ndl. Hanau)	Hanau
66933	103196	FLOORMATEX AG		Hünenberg (ZG)
66934	103197	DURADOR ARGENTINA		Bahía Blanca
66935	103198	Quincaillerie Portalet SARL		Montauban
66936	103199	Befestigungshandel und	Dienstleistungen Frank Friedhoff	Marl
66937	103200	SAS SCORS		Rosny Sous Bois Cedex
66938	103201	PYLO SARL		Mougins
66939	103202	BEIJING JHF CONSTRUCTION HARDWARE	CO.LTD	Chaoyang District, Beijing
66940	103203	CAC DISTRIBUTION	Clément Charnaux	Chelles
66941	103204	Technisch Bureau Ouborg		Hoogblokland
66942	103205	maschinen+technik Sauerland GmbH	&Co. KG	Schmallenberg
66943	103206	Gerritse IJzerwaren Vestiging Zeist		Zeist
66944	103207	SAS NOLLINGER		TRAPPES CEDEX
66945	103208	BAUKING Westfalen GmbH	(Ndl. Wuppertal)	Wuppertal
66946	103209	2K Polymer Systems Ltd.		Alfreton, Derbyshire
66947	103210	bauCompany24 GmbH		Göppingen
66948	103211	Sarl Maison Jacques Séguin	SARL	Randan
66949	103212	Apprich-Baustoffe GmbH & Co KG		Essingen
66950	103213	Flie-San GmbH Großhandel		Kevelaer
66951	103214	ZI-TECHASIA SOLUTIONS LTD.	11/F-12/F,  Ploenchit Center	Bangkok
66952	103215	LS Chemie GmbH		Wuppertal
66953	103216	ASW GmbH & Co.KG		Attendorn
66954	103217	Decco Ltd.		Newbury
66955	103218	Elektromaschinenbau	Matthias Wendland	Sulingen
66956	103219	Toban Engineering Ltd.	T/A M B Trading	West Yorkshire
66957	103220	Amazon EU Sarl	Niederlassung Deutschland	München
66958	103221	Amazon EU Sàrl / Amazon Media EU	Sàrl	Luxemburg
66959	103222	Amazon EU SARL	Niederlassung Tschechien	Dobroviz
66960	103223	Amazon Fulfillment Poland sp.z o.o.		Bielany Wroclawskie
66961	103224	bauzentrum Röhrig GmbH	(hagebaumarkt)	Treis-Karden
66962	103225	AGP Bauzentrum GmbH	Fachhandel Wernigerode	Wernigerode
66963	103226	MIOR, d.o.o.		Maribor
66964	103227	G7 Industrial Supplies Ltd	Unit 7 Courtyard 3	Mapplewell, Barnsley
66965	103230	SARL AIMONETTO		Saint-Etienne de Saint-Geoirs
66966	103231	BIEVRE LOCATION SARL		Brion
66967	103232	Isero IJzerwarengroep B.V.	DC Waddinxveen	Waddinxveen
66968	103233	Quincaillerie Portalet SAS		Pau
66969	103234	Van der Winkel Eindhoven	Isero IJzerwarengroep	Eindhoven
66970	103235	Quincaillerie Donibane SARL		St Jean de luz
66971	103236	Villaret Energies Fioul SARL		Le Mazet St Voy
66972	103238	ÜHolz	Krämer STEIN FORMEN	Schleusingen OT Erlau
66973	103239	Nordwest Handel AG	FachWerk	Dortmund
66974	103240	Westfälische Gesenkschmiede GmbH		Breckerfeld
66975	103241	SPARKY Polska Spz.o.o.		Zielona Góra
66976	103242	Großhandel Mohr GmbH		Suhl-Sehmar
66977	103243	Ruwomat BVBA		Aalter
66978	103244	Adamantem Products Ltd.	Unit 1	Lancing, West Sussex
66979	103245	Isero IJzerwarengroep B.V.	Scholte en de Vries	Beverwijk
66980	103246	IQ Builders Merchant Ltd.	Unit 51,The Granary Rural Busin. C.	East Sussex
66981	103247	Plymouth Tools & Spares		PLymouth
66982	103248	Heller Tools RUS, Ltd.		Moscow
66983	103249	hagebau Handelsgesellschaft für	Baustoffe mbH & Co.KG	Soltau
66984	103250	E. Wertheimer GmbH	Baustoffe	Achern
66985	103251	Paul Swertz GmbH		Goch
66986	103252	Paul Swertz GmbH		Straelen
66987	103253	Paul Swertz GmbH		Alpen
66988	103255	C.C. Curtze GmbH & Co.KG		Korbach
66989	103256	Baustoff-Centrum Linnenbecker		Greifswald
66990	103258	Schwandorf GmbH & Co.KG		Schwandorf
66991	103259	Baustoff-Centrum Linnenbecker		Stralsund
66992	103260	Baustoff-Centrum Linnenbecker		Bielefeld
66993	103262	Baustoff-Centrum Linnenbecker		Rinteln
66994	103264	Baustoff-Centrum Linnenbecker		Minden
66995	103265	Jewson Limited	Saint Gobain House	Coventry
66996	103266	Baustoff-Centrum Linnenbecker		Lemgo
66997	103267	Baustoff-Centrum Linnenbecker		Bad Oeynhausen
66998	103268	Baustoff-Centrum Linnenbecker		Erwitte
66999	103269	Seeger Baustoffe GmbH		Zimmern o.R.
67000	103270	BAUKING Ostfalen GmbH		Helmstedt
67001	103271	Spit S.A. - SAS SOC PROSPECTION	INVENTIONS TECHNIQUE	Bourg-les-Valence
67002	103272	Minegishi Co., Ltd.	Mr. Yoshihiro Abe	103-0027 Tokyo-to
67003	103273	Jackdaw Tools Ltd.		Willenhall
67004	103274	Götz + Moriz GmbH	Baustoffe	Müllheim
67005	103275	Lecot - Biermans		Breda
67006	103278	Götz + Moriz GmbH	Baustoffe	Titisee-Neustadt
67007	103280	Götz + Moriz GmbH	Baustoffe	Lörrach
67008	103281	Fabory Nederland BV	Attn. Financial Shared Service	TILBURG
67009	103282	Apex UK		West Sussex
67010	103285	Rawlplug Ireland Limited		Drogheda / Co.Louth. Ireland
67011	103286	Nirolux NV Agrodieren		Hertsberge Oostkamp
67012	103287	Nagel Werkzeug-Maschinen GmbH		Freiburg
67013	103288	Götz + Moriz GmbH	Baustoffe	Bad Krozingen
67014	103289	Wales & West Building Products Ltd.		Wales
67015	103290	Wilh. Heunert GmbH & Co. KG	Inh. Anne Jansen, Marita Burmann	Soest
67016	103294	Shopbox 24	Elektro-Schölzel GmbH & Co. KG	Demnitz-Thumitz
67017	103295	Selmach Machinery Ltd.		Hereford
67018	103296	PROFIX AG		Lausen
67019	103297	Hans Schuy Baustoffgesellschaft	mbH	Köln
67020	103298	OVD Oberlausitzer Vertriebs- und	Dienstleistungs GmbH	Obergurig
67021	103302	Alfred Smit Fliesen- und	Baustoffhandel GmbH & Co. KG	Bad Zwischenahn
67022	103303	Uni Elektro Fachgroßhandel	GmbH & Co. KG	Eschborn
67023	103304	Prommersberger e.K.		Rattiszell
67024	103305	BEWENG s.a.		Luxembourg-Bonnevoie
67025	103306	Kistenpfennig S.ár.l Luxembourg	Francois Krier	Luxembourg
67026	103308	Steffen Schröder		Dinklage
67027	103309	Fast Mover Tools Ltd.		Dunstable
67028	103311	Revillard JEAN SAS		Cruseilles
67029	103312	Isero IJzerwarengroep B.V.		Dordrecht
67030	103313	SAS VISWOOD		Sury-le-Comtal
67031	103314	Kraftool I/E GmbH		Böblingen
67032	103315	Promabo GmbH		Oer-Erkenschwick
67033	103316	Josef Fahr GmbH & Co. KG		Moers
67034	103317	Euro Techno Com S.A.S		Eaubonne
67035	103318	L R M SAS		La Courneuve
67036	103319	D'CAT SAS		Bernes Sur Oise
67037	103321	Breger Freres et Fils S.A.R.L.		Luxembourg-Gasperich
67038	103323	BT Brammer B.V.		Enschede
67039	103324	Comat S.A.		LUXEMBOURG-HOWALD
67040	103325	COMPTOIR MATERIEL OUTILLAGE SARL	CMO	Montreuil
67041	103326	Lueb+Wolters GmbH & Co.KG		Borken
67042	103327	Otto Schulte		Wuppertal
67043	103328	BKW Hartmetall GmbH		Kaarst
67044	103329	IRIS FLOW.er SARL		Saint Chamond
67045	103330	SFI SASU		Ennezat
67046	103331	Quincaillerie Portalet	Zl de Beauregard  SARL	Brive la Gaillarde
67047	103332	Gebr. Fürstenberg GmbH	Baustoffhandel	Kyritz
67048	103334	team baucenter GmbH & Co KG		Eggebek
67049	103335	Kasnord GmbH		Sassenburg
67050	103336	Isero IJzerwarengroep B.V.	ISERO Breur Vlaardingen	Vlaardingen
67051	103337	BMN Wijcks Afbouwmaterialen	Volendam	Volendam
67052	103338	SOSACA HYERES		HYERES
67053	103340	Kalup doo		Hrvace
67054	103343	Markus Bornträger GmbH		Haan
67055	103344	Holz Braun GmbH & Co.KG		Reutlingen
67056	103345	Lusga Baumaschinen GmbH		Hamburg
67057	103347	CGS PRO	APC	Vichy
67058	103348	Verkatto sp.Z.o.o.		Opoczno
67059	103350	Formschluss	Umreifungstechnik & Zubehör	Dortmund
67060	103352	Caleffi Armaturen GmbH		Mühlheim/Main
67061	103354	b+z werkzeuge GmbH		Stuttgart
67062	103355	AH-Gartentechnik & Werkzeuge	Alexander Heeb	Mainz
67063	103356	D.E.S.BVBA		Roeselare
67064	103357	Quincaillerie Portalet		Feytiat
67065	103358	SAŠA KRANJEC		Zagreb
67066	103359	CREUSOT EQUIPEMENTS SAS		LE CREUSOT
67067	103361	TilePal Ltd.	Target House	Perth
67068	103362	Remmers Gruppe AG		Löningen
67069	103366	Freund Eisenwaren Öfen & Kamine		Waldkirchen
67070	103367	Isero IJzerwarengroep B.V.		Soest
67071	103369	Edwin Benischke	Werksvertretungen	Altdorf
67072	103370	Hotze GmbH & Co.KG	Baustoffe Leese	Laatzen-Gleidingen
67073	103371	LuDZ Mitte GmbH & Co.KG		Barsinghausen
67074	103372	Quincaillerie Portalet SAS		Merignac
67075	103373	BAUKING Westfalen GmbH	Ndl. Recklinghausen	Recklinghausen
67076	103374	ALLARD - Tanguy Allard		Fouenant
67077	103375	AMS - Frédéric Mayet		St Cyr sur Loire
67078	103376	ACL Lefebvre - Aude Campion	Bureaux 216/217	Bondus
67079	103377	Rajko Schade	Leiter-Sicherheitssysteme	Göda
67080	103378	Radius		Dublin
67081	103379	Scott Safety Supplies Ltd.		Sunderland
67082	103380	BAUKING Weser-Ems GmbH	(Ndl. Lorup)	Lorup
67083	103381	SIMURO Baubedarf AG		Urdorf
67084	103382	EUROPE DIAMOND		Cuijk
67085	103384	Panorama24 GmbH		Isernhagen
67086	103386	PermaRock Products Ltd.		Loughborough, Leicestershire
67087	103387	Produebel GmbH	Der Befestingsspeziallist	Leipzig-Engelsdorf
67088	103388	Der Baustoff-Mann Schneider KG		Gladbeck
67089	103389	Bohrerdepot	Namfon Wolschke	Oranienburg
67090	103390	Soc.IT Commerciale	Utensili S.P.A.	MILANO
67091	103391	bauwelt Delmes Heitmann	GmbH & Co. KG	Norderstedt
67092	103393	KLJENSEN	Rabattring Norwegen Großhandel	Tananger
67093	103394	KL JENSEN	Rabattring Norwegen Fachhandel	Tananger
67094	103395	Hermann Bach GmbH & Co. KG		Lippstadt
67095	103396	WMH e.K. Werkzeug-	und Maschinenhandel Freiburg	Freiburg
67096	103397	Bauzentrum Pelzer GmbH		Hürth
67097	103398	SAS BAGGIO		Carvin Cedex
67098	103400	Polvo Moerdijk CM		Zevenbergen
67099	103401	Paul Swertz GmbH		Kleve
67100	103404	Paul Swertz GmbH		Moers
67101	103406	MMR Fixing Specialists	Unit 3, Priestley Point	Worsley, Manchester
67102	103407	Atrumpa	Neumann, Florian	Kolkwitz
67103	103408	Sorbo Industribeslag AS		Trondheim
67104	103409	Carl Beutlhauser	Baumaschinen GmbH	Rednitzhembach
67105	103410	Industrieofen Bader & Scheffer GmbH		Denkendorf
67106	103411	gme GmbH & Co. KG		Offenburg
67107	103412	QUINCAILLERIE MOREL EURL		DAX
67108	103413	W. Renner GmbH		Landsberg am Lech
67109	103415	Holländer Bedachungszentrum GmbH		Speyer
67110	103416	Becker Baustoffe GmbH & Co.KG		Rietberg
67111	103417	UNIPRO LIMITED	Behind Vision Plaza	Nairobi
67112	103418	HS Handelsagentur Hans Schlüter		Hörnerkirchen
67113	103419	Hein GmbH & Co.KG		Mitwitz
67114	103420	BauXpert Knipper GmbH & Co. KG	Niederlassung Werlte	Werlte
67115	103451	Black & Decker Limited		County Durham
67116	103473	Wenzel Präzisionswerkzeuge e.U.		Wien
67117	103506	Höller GmbH	Innov. Warenbewirtschaftung	Wals
67118	103517	Spiral Reihs & Co. KG	Werkzeug- und Maschinenhandel	Wien
67119	103579	Dubick & Stehr	Baumaschinen GmbH	Hamburg
67120	103584	Thomann GmbH	Handwerker- u. Industriebedarf	Lindau
67121	103586	Berliner Schrauben GmbH & Co KG		Berlin
67122	103590	Eisen-Schneider	Inh. Christoph Hassenbach e. K.	Wiesbaden
67123	103602	Black & Decker (US) Inc.		Towson, MD 21286
67124	103607	Karl Grabenhorst	EISENWAREN	Dahlenburg
67125	103624	Albert Berner Deutschland GmbH		Künzelsau - Garnberg
67126	103661	WIB Werler	Industrie-Bedarf-Handels-GmbH	Werl
67127	103680	Lorenz Drucklufttechnik	Vertiebs GmbH	Grub Am Forst
67128	103702	Franz Kerstin Hausbau GmbH & Co.KG		Soest
67129	103727	Elektron Berlin GmbH		Berlin
67130	103747	Hans Daniels GmbH	Baugeraete	Dortmund
67131	103760	Eisen Krug	Inh. Erich Jeschke	Kassel
67132	103766	Richter Baustoffe GmbH	(Ndl. Falkenstraße Baustoffe)	Lübeck
67133	103773	Karl Binder		Schönaich
67134	103779	E.+E. Boss GmbH		Albstadt
67135	103790	W. Herr GmbH	Werkzeuge - Maschinen	Kelkheim-Fischbach/Ts.
67136	103810	Fehrs Baustoffe GmbH		Vaale
67137	103831	Heinrich Murjahn GmbH & Co KG	Fachgroßhandel für Haustechnik	Mölln
67138	103834	Stürmer Werkzeuge Maschinen KG		Hallstadt
67139	103858	Hocke - Baubedarf GmbH		Wiesbaden
67140	103860	Guntelmann	Werkzeug GmbH	Bielefeld
67141	103867	Ludden GmbH		Lingen 1
67142	103868	Diamant-Technik-Wesel		Wesel
67143	103897	Wilhelm Kleeberg GmbH & Co.KG	Elektromaschinenbau	Flensburg
67144	103926	BML Baumaschinen AG		Koenigsbach-Stein
67145	103936	Bielemeyer GmbH & Co.KG		Menden
67146	103945	Baustoffe FRAJO GmbH	Baubedarf	Garmisch-Partenkirchen
67147	103948	Heinz Hesse KG		Wuppertal
67148	103968	Hans Peter Ehler		Schopfloch
67149	103975	Hans Eisele GmbH		Glatten
67150	104001	Geilert & Kanstein oHG	Schrauben u. Verbindungselem.	Lohfelden
67151	104045	KremerGlismann GmbH & Co. KG		Barmstedt
67152	104049	Egon Haupthoff GmbH & Co.KG		Heiligenstedten
67153	104051	bauXpert Christiansen GmbH & Co KG		Niebüll
67154	104052	bauXpert Dittmer GmbH & Co. KG		Lütjenburg
67155	104055	Heinr.Köhn	Holz-und Baustoffe GmbH	Suederbrarup
67156	104056	Seemann Baustoff-Fachmarkt GmbH		Hürup
67157	104058	Jacob Sönnichsen AG		Klein Roennau
67158	104062	Bauzentrum Struve GmbH		Hamweddel
67159	104063	HZF Bauzentrum Fehmarn GmbH		Burg/Fehmarn
67160	104092	Weigel Werkzeuge OHG	Inh. Jens & Michael Weigel	Burbach
67161	104100	G.F.Lotter GmbH	Grosshandel Werkzeuge	Neutraubling
67162	104104	F. Brüggemann Nachf. GmbH.		Lemgo
67163	104105	Hefele GmbH & Co KG		Plattling
67164	104107	Anton Mayer	Befestigungstechnik	Illertissen
67165	104112	Uwe Kloska GmbH		Bremen
67166	104121	Eisen Mülfarth KG	Inh. F.P. Mülfarth	Bruehl
67167	104155	Antonius Venker GmbH & Co. KG	Werkzeug-Service	Salzbergen
67168	104163	Anton Kreitz &	W.H. Ostermann GmbH	Herne
67169	104164	Fritzen & Co. Baustoffe GmbH		Emden
67170	104165	Tegral GmbH & Co. KG		Überherrn-Altforweiler
67171	104181	H.Engert GmbH & Co. KG		Kreuztal
67172	104182	Melle Dachbaustoffe GmbH	Betriebsbedarf	Osterode/Harz
67173	104185	Hoba-Schrauben	Großhandelsgesellschaft mbh	Olfen
67174	104197	Gass GmbH		Speyer
67175	104203	Meier Handwerkerbedarf	GmbH & Co. KG	Ansbach
67176	104217	W. Klatt GmbH		Celle
67177	104221	Max Schön AG	Niederlassung Rostock	Rostock
67178	104229	Eduard Lutz Schrauben-Werkz. GmbH		Neubrandenburg
67179	104236	S & W Metall + Werkzeug GmbH		Alfeld
67180	104260	Smalcalda Handels-GmbH		Schmalkalden
67181	104261	Einkaufs- U.Liefergenossensch.	D.Metallverarb.Handwerks Egmbh	Apolda
67182	104264	Werkzeug - Maschinenhandel	Uwe Neidhard	Zella-Mehlis
67183	104286	AS Verbindungsteile	Inh. Helmut Antwerber	Koeln
67184	104296	Edwin Sperling	Eisenwaren + Werkzeuge	Zerbst
67185	104302	Hans Lüttke	Haus der Technik GmbH	Nordenham
67186	104306	GENIATEC GmbH	NL Rostock	Rostock-Kavelstorf
67187	104315	Fachmarkt Görlacher GmbH		Villingen
67188	104322	Baumarkt Wismar GmbH & Co.KG		Wismar Haffeld
67189	104348	Werkzeug Schultze GmbH	Gewerbegebiet Nord-West	Schoenebeck
67190	104356	Baumarkt Röbel GmbH & Co.KG		Röbel/Müritz
67191	104358	M. Meesenburg GmbH		Wolgast
67192	104362	Ackrutat GmbH & Co. KG		Neumünster
67193	104368	Handelshof Vorpommern GmbH	Partner für Technik	Grimmen
67194	104383	TTH Technikhandel GmbH	Erfurt	Erfurt
67195	104384	Bama Werkzeug + Maschinen-	Handel GmbH	Stralsund
67196	104386	Hilbertz GmbH		Wallenhorst
67197	104388	Lutz Lippold	Eisenwaren	Wilkau-Haßlau
67198	104404	Handelshof Riesa GmbH	Partner für Technik	Riesa
67199	104411	Fachmarkt Twyhues GmbH		Loitz
67200	104428	Werkzeugprofi GmbH		Lutherstadt Wittenberg
67201	104442	Paul Seidler	WZ und Maschinen	Bautzen
67202	104444	Steffen Klaus GmbH i.L.	Baumaschinen + Baugeräte	Herzberg
67203	104445	Handelshof Stendal GmbH	Partner für Technik	Stendal
67204	104450	Friedrich Niemann GmbH & Co.KG		Bentwisch/Rostock
67205	104456	Elgora GmbH		Oranienburg
67206	104461	Wocken Industriebedarf	GmbH & Co.KG AH-Nr. 10185	Bautzen
67207	104471	Raab Karcher Baustoffe GmbH		Schleusingen
67208	104474	Eylert GmbH & Co.KG	Werkzeuge	Chemnitz
67209	104479	Blumenbecker Industriebedarf GmbH	Heinz-Wilhelm Hoffmann	Beckum
67210	104484	Baumarkt Gramzow GmbH		Gramzow
67211	104490	THG Technische Handelsges. mbH		Brake
67212	104505	Diamasa Diamanttechnik GmbH & Co KG		Grimma
67213	104509	Messinger Schrauben GmbH		Frankfurt
67214	104510	Teuchert Bau- und Industriebedarf	GmbH	Großschirma
67215	104519	Krehahn & Krehahn Bauservice GbR		Naumburg
67216	104531	Rühr GmbH	Werkzeuge-Maschinen	Oberasbach
67217	104534	Kühl Qualitätswerkzeuge	Andreas Kühl	Eisenberg/Thür.
67218	104536	Tools Werkzeug-	Fachhandels GmbH	Großenhain
67219	104545	Binzer Baumarkt Bernd Schwartz KG		Ostseebad Binz
67220	104551	Nüßing Baubeschlag GmbH	Dortmund	Dortmund
67221	104554	Schnelle & Co	Erfurter Bau- u. Industrieb. GmbH	Erfurt
67222	104555	Leitermann GmbH & Co.	Fachmarkt KG	Göpfersdorf
67223	104562	Lotter Metall GmbH & Co KG	WZ und Sanitärhandel	Borna/OT Zedtlitz
67224	104565	DTH Kesselsdorf GmbH		Kesselsdorf
67225	104571	Richter	Bau- und Industriebedarf	Friedersdorf
67226	104587	EMB Elektromaschinenbau	Service GmbH	Chemnitz
67227	104600	Theodor Kiessling Fachgroßhandel KG	für Industrie und Handwerk	Auerbach
67228	104603	Ungering GmbH		Kleve
67229	104604	Bruno Zachenbacher	Werkzeugvermietung + Verkauf	Duesseldorf
67230	104605	Mothes Baumarkt Jens Mothes		Malchin
67231	104620	Firma Karl Briesemeister	Inh. Ralf Briesemeister	Eisenhuettenstadt
67232	104625	Werner Kirschke	Eisenwarenfachgeschaeft	Greiz/Thür.
67233	104627	Handelshof Bitterfeld GmbH	Partner für Technik	Bitterfeld-Wolfen
67234	104630	Bach GmbH	Fachmarkt für Industrie u. Profis	Marienberg
67235	104632	Handelshof Bautzen GmbH	Partner Für Technik	Bautzen
67236	104633	Handelshof Cottbus GmbH	Partner für Technik	Massen
67237	104636	Otto Pauling Nachf. e.K.	Inh. Christel Weber	Leipzig
67238	104647	BMH Löcknitz GmbH	Baustoffe	Löcknitz
67239	104651	Achimer Baustoffmarkt GmbH		Achim
67240	104655	Gierth & Herklotz OHG	Bau- und Industriebedarf	Bernau/Rehberge
67241	104661	Kadow	Handel und Services e.K.	Greifswald
67242	104662	Silvia Steinke	Der Fachgroßhandel	Perleberg
67243	104666	Carl Daum	Inh. Ingrid Pocher	Eisenberg/Thür.
67244	104668	Kemnitz Werkzeuge-Maschinen-	Befestigungstechnik  Kahlert GmbH	Korbußen
67245	104673	Eltrik	Elektrotechnik GmbH	Limbach - Oberfrohna
67246	104678	Raiffeisen-Warengenossenschaft	Hildburghausen EG	Hildburghausen
67247	104681	EGN Baustoffmarkt		Kröpelin
67248	104682	Leiwema Ochs KG	Eisenwaren/Werkzeuge	Markkleeberg
67249	104684	Prüßner Werkzeuge, Maschinen,	Industriebedarf, Handel GmbH	Aschersleben
67250	104688	Heribert Sohlmann GmbH		Hörstel-Riesenbeck
67251	104689	Gübe Werkzeuge GmbH	Wolfgang Kaudelka	Dessau
67252	104707	Baumarkt Gnoien GmbH & Co.KG		Gnoien
67253	104710	Martin Koeberlein GmbH	WZ und Industriebedarf	Neumark
67254	104715	Rülke OHG		Glauchau
67255	104724	ELG Holzhandwerk Dippoldiswalde eG		Dippoldiswalde/OT Obercarsdorf
67256	104725	THL Thomas Lipfert	Diamant u. Vermessungstechnik	Frankfurt / Oder
67257	104732	Werner Ditzinger GmbH	TTH-Technikhandel	Zella-Mehlis
67258	104737	T. Wurbs u. Co GmbH	Kompaktmarkt	Karstädt
67259	104743	Ruko GmbH	Präzisionswerkzeuge	Holzgerlingen
67260	104746	Otto Holländer GmbH	Inh. Dieter und Arne Petersen	Trittau
67261	104747	Peter Heinemann	Gartentechnik und Werkzeuge	Bitterfeld-Wolfen
67262	104751	Jaschinsky Werkzeuge	GmbH & Co.KG	Magdeburg
67263	104756	Paufler Werkzeugfachhandel	Ralf Paufler	Radebeul
67264	104771	Wermas Werkzeughandels GmbH	Werkzeuge Maschinen	Lohfelden
67265	104772	Werkzeug Hajek		Döbeln
67266	104774	Ernst Winterhoff GmbH & Co.KG		Remscheid
67267	104781	Werkzeughandel Holger Marlow e.K.	Inh. Andreas Holtz	Neubrandenburg
67268	104784	illgen Fachgroßhandel GmbH	Werkzeuge, Reinigungsmittel und	Neustrelitz
67269	104788	HNT GmbH	WZ und Service	Riesa
67270	104790	H. und H. Industriehandel	GmbH & Co.KG	Olpe
67271	104796	dth Diamant- und Befestigungst.	Günter Aust	Templin/Hammelspring
67272	104797	Lindenthaler Metallwaren		Gera
67273	104798	Manfred Hüllinghorst	Maschinenhandel GmbH & Co KG	Prenzlau
67274	104799	Gebr. Löffler GmbH Baustoffe		Greiz
67275	104800	Baumarkt u. Baustoffhandel	Buttstädt	Buttstädt
67276	104805	Baumaschinen Haase + Scherf GmbH		Sömmerda
67277	104810	Werkzeughandel Weber	Wismar GmbH	Wismar
67278	104816	LHG Leipziger Handelsgesellschaft	Verbindungstechn. u. Betriebsb. mbH	Leipzig
67279	104823	Manderscheid	Handelsgesellschaft mbH	Hoyerswerda
67280	104826	G. Wurth GmbH		Niederfischbach
67281	104828	May Fixation Sarl.	Befestigungstechnik	Pratz-Preizerdaul
67282	104829	DVS-Werkzeug-Service GmbH		Thalheim
67283	104839	Hoenicke Werkzeuge		Jueterbog
67284	104842	Jörg Deutsch		Lenzen
67285	104843	Drögemeier Industriebedarf	Inh. Dirk Drögemeier e.K.	Bückeburg
67286	104848	Beeck + Koch	Inh. Henrik Pflugmacher e.K.	Braunsbedra
67287	104850	Bauzentrum Schnepf GmbH & Co.KG		Teterow
67288	104851	EKF Klein GmbH & Co KG	Baumaschinen	Kuerten-Biesfeld
67289	104852	Werkzeug Roloff GmbH	Werkzeug	Stendal
67290	104862	Unifur Industriebedarf	Reinhard Fümel	Bergwitz
67291	104867	Stock B.I.G. GmbH		Siek
67292	104873	Westfalia Werkzeug Company		Halle/Saale
67293	104877	Henri Benthack GmbH & Co. KG		Grevesmühlen
67294	104878	Freitag Werkzeuge und	Industriebedarf GmbH	Neuenkirchen
67295	104879	Irrgang Werkzeuge GmbH		Eberswalde
67296	104882	K u. B GmbH	Fachgroß- u. Einzelh.f. Handwerk	Zerbst
67297	104887	Baumarkt Ueckermünde GmbH & Co. KG		Ueckermünde
67298	104898	STZ  Klingner GmbH		Poelzig
67299	104903	Rudolf Pöppel GmbH & Co.KG	Maschinen + Werkzeuge	Memmingen
67300	104904	HH Baugeräte GmbH	Baugerätehandel	Plauen
67301	104910	Franz Sieland GmbH	Industriebedarf	Arnsberg-Neheim
67302	104917	Baustoffmarkt Bützow GmbH & Co. KG		Bützow
67303	104920	Baumarkt Teterow GmbH & Co KG		Teterow
67304	104921	AGON Werkzeuge und Wälzlager GmbH		Bochum
67305	104924	Schmitt Elektrogroßhandel GmbH		Erfurt
67306	104925	Lüneburger Eisenhandlung	W.L. Schröder GmbH & Co KG	Lüneburg
67307	104926	Hartmetall- und	Diamantwerkzeuge	Fambach
67308	104929	Hantel Montagetechnik	Grosshandelsgesellschaft	Renzow
67309	104938	Klaus-Dieter Gratz	Elektro Maschinen Bau	Struth-Helmershof
67310	104939	Anke & Söhne	Industrievertretung	Plauen
67311	104940	Nienhaus, Thielkes & Co. GmbH		Coswig
67312	104954	Kirsch	Bau- und Industriebedarf GmbH	Belgershain
67313	104957	Andreas Schreiner	Werkzeugfachhandel	Jessnitz
67314	104962	E M A - Kalberlah GmbH	Fachhandel	Bernburg
67315	104967	Werktec GmbH		Dingelstädt
67316	104968	B V A  Ingolf Müller GmbH		Windischleuba
67317	104969	Ernst Meyer GmbH	Steinindustriebedarf	Nürnberg
67318	104973	Adolf Schween GmbH	NL Sangerhausen	Sangerhausen
67319	104975	Blumenbecker	Industriebedarf GmbH	Iserlohn
67320	104986	MF Manfred Faske GmbH & Co.KG		Vechta - Calveslage
67321	104988	Odenwaelder Baumaschinen	GmbH & Co.KG	Merseburg
67322	104996	Bodo Küster	Werkzeuge und Maschinen	Mellingen
67323	104999	Egon Jesse		Simonshaven
67324	105000	Danfoss Power Solutions ApS		Nordborg
67325	105010	Oliver Fischer	Werkzeugdienst	Waldesruh
67326	105011	Gase Center Calau		Calau
67327	105013	Werner Frick GmbH		Korntal-Münchingen
67328	105015	Raab Karcher Baustoffe GmbH		Gotha
67329	105017	WMB Walther GmbH	Werkzeuge Maschinen Baubeschl.	Arnstadt
67330	105018	Hans Humpenöder GmbH	Baustofffachhandel	Schwabach
67331	105024	Bohr- u. Sägetechnik GmbH	WZ und Service	Radeberg
67332	105025	Jäckel Baubedarf GmbH		Bühl/Baden
67333	105028	Nagel Baumaschinen	Magdeburg GmbH	Barleben
67334	105037	Gulden Elektrowerkzeuge	Diamant. u. Befestigungstechnik	Zemmer Schleidweiler
67335	105044	M.Wolpert	Schlüsseldienst	Köln
67336	105046	Jürgen Hauschild GmbH	Fachgroßhandel	Wünschensuhl
67337	105047	BauPunkt Hain   Masch.Verm.-	und Baubedarf Handels GmbH	Lutherstadt Eisleben
67338	105051	Van Ree B.V.		Alkmaar
67339	105053	dth Wandura Ltd.	Diamant- u. Befestigungst.	Cunewalde
67340	105058	Timmerman's IJzerhandel b.v.		Alkmaar
67341	105065	Max Pohlhaus	Inh. Jörg Priebe e. K.	Borkwalde
67342	105066	Selectequip Ltd.	Unit 7, Britannia Enterprise Park	Lichfield, Staffs.
67343	105070	BAUKING Berlin-Brandenburg GmbH	Niederlassung Spandau	Berlin
67344	105075	MJM Werkzeug-Vertriebs GmbH & Co.KG		Rendsburg
67345	105086	Nienhaus & Thielkes GmbH		Rhede
67346	105090	Hemmersbach	Industriebedarf GmbH	Berlin
67347	105098	Keller & Kalmbach GmbH		Regensburg
67348	105104	Firma Plat		St. Annaparochie
67349	105116	Wocken Industriebedarf	GmbH & Co.KG AH-Nr. 10184	Magdeburg
67350	105118	Machine Mart Ltd.	Head Office	Nottingham
67351	105126	Unimet Zentrallager Ost	GmbH & Co KG	Neuruppin
67352	105130	OREN s.r.o.		Udlice
67353	105131	Raab Karcher Baustoffe GmbH		Erfurt
67354	105140	Industriebedarf Mütschard e.K.	Inh. Andy Hunhold	Rathenow
67355	105141	Patzer Technische Fachhandels-	gesellschaft GmbH	Saalfeld
67356	105143	Gebr. Wurster GbR		Woltersdorf
67357	105153	Augustin GmbH		Gunzenhausen
67358	105159	D. Dummert	Werkzeughandel	Berlin
67359	105163	IHR Werkzeughandel	Holger Antonijevic	Schwedt/Oder
67360	105169	Georg GmbH	Ihr Partner f. Sicherheit + Technik	Breitscheid
67361	105170	Siegfried Jakob		Dessau
67362	105190	Sächsische Handelsagentur	Holger Gutseel	Leipzig
67363	105191	SIG First Fix M&E (Kem Edwards)	Unit 4	Ruislip
67364	105193	SSV-Kroschke GmbH		Wutha-Farnroda
67365	105208	Hillmann & Ploog Waren GmbH		Waren (Müritz)
67366	105218	Zuid IJzerhandel V.O.F		Amsterdam
67367	105219	Raiffeisen Warengen. E. G.		Eisfeld
67368	105220	Kopprasch Industrie- u. Baubedarf		Dohna/OT Meusegast
67369	105225	Quauck GmbH	Baumaschinen u. Baubedarf	Gerichshain
67370	105226	Joseph Peters	Beschläge-Garderoben	Konstanz
67371	105229	HIWESO GmbH	Werkzeuge u. Maschinenh.	Gotha
67372	105242	P. Hendriks Uden B.V.		Uden
67373	105244	Jecor Professioneel B.V		Putten
67374	105248	Auke Rauwerda B.V.		Leeuwarden
67375	105252	EWL Elektrowerkzeuge	Bau- u. Gartentechnik	Chemnitz
67376	105253	Reinhold Werkzeuge GmbH		Stollberg
67377	105254	M.H.W. Horbach	Werkzeuge	Alsdorf
67378	105263	Bauzentrum Schnepf GmbH & Co.KG		Malchin
67379	105278	Herwig Bohrtechnik	Schmalkalden GmbH	Schmalkalden
67380	105284	Udo Wendelmuth	Handelsvertretung	Schwansee
67381	105287	O.J. Keller		Berlin
67382	105291	Hoza Holding B.V		Wenum Wiesel
67383	105296	Deinzer U. Weyland U. Co GmbH		Altlandsberg
67384	105302	Bernhard Menge	Werkzeug-Werkzeug-Maschinen	Recklinghausen
67385	105304	Adolf Christel		Schwarzenfeld
67386	105306	Gnoth Tischlereibedarf		Salzwedel
67387	105308	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Neuruppin
67388	105311	Kelterborn Schweißtechnik GbR		Saalfeld
67389	105314	Römhild Fachhandel		Naumburg/Saale
67390	105321	Huke Verbindungstechnik GmbH	Niederlassung/Lager, Kerspleben	Erfurt
67391	105324	Neustrelitzer Industriebedarf	Beilke GmbH	Neuruppin
67392	105329	Heiko Knop	Industriebedarf	Elze
67393	105335	M Donnelly & Co Ltd	Dublin Industrial Estate	Glasnevin Dublin
67394	105343	Döhle	Eisenwaren/Werkzeuge	Sömmerda
67395	105352	Barm Werkzeughandel		Ganderkesee
67396	105356	Prenzlauer Baubedarf GmbH		Prenzlau
67397	105361	PRIVATVERKAUF		Dinklage
67398	105364	Schär Werkzeug-Maschinenhandel	und Industriebedarf GmbH	Crimmitschau
67399	105365	EUROBAUSTOFF Handelsgesellschaft	mbH & Co. KG	Karlsruhe
67400	105374	Eurobaustoff Regionaler Einkauf	Rheinland	Euskirchen
67401	105375	Wildenhayn  - Wachholz		Blankenfelde
67402	105383	Schiffsversorgung (SVR)	Rostock GmbH	Rostock
67403	105385	Johannes Schmidt	Schweißtechnik	Lauchhammer Ost
67404	105389	Dieter Haufe	Elektrowerkzeuge	Großröhrsdorf
67405	105391	DSS Diamant-Säge-Service GmbH		Duisburg
67406	105392	Deutschmann & Söhne GbR		Bernau
67407	105393	Grischke   Baustellenbedarf GmbH		Goslar
67408	105395	eltric GmbH		Bayreuth
67409	105400	Elektromaschinen-Service Klähr	Inhaber Matthias Bär	Frankfurt/Oder - Markendorf
67410	105402	Mehlhorn Baumaschinen		Erfurt
67411	105407	Wilkens Baustoffe GmbH		Groß Wokern
67412	105417	V.O.F. R & B TOOLS		Zutphen
67413	105421	Rehmet u. Hessel GmbH	Fachhandels- u. Reparatur-Service	Wurzen Ot Dehnitz
67414	105425	Gassmann Industriebedarf GmbH		Heiligenstadt
67415	105430	WIB Weimarer Industriebedarf GmbH		Weimar
67416	105441	T.E.A.M. GmbH	Industriebedarf	Kall
67417	105442	Michael Ullrich	Elektromaschinenbau & Werkzeuge	Floh-Seligenthal OT Hohleborn
67418	105443	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Schwerin
67419	105445	Lex Beschläge- und Baubedarf	Handels GmbH	Arnstorf
67420	105455	B M V	Baumaschinenvertrieb	Roedenstal
67421	105471	Friedrich Delker GmbH	Werkzeuge - Maschinen	Halle/Saale
67422	105473	Roland Gessner	Inh. Christina Gessner e.K.	Eisenhüttenstadt
67423	105476	Raiffeisenbank eG	Büchen Crivitz Hagenow Plate	Hagenow
67424	105477	Klaus Naguschewski	Betriebsausrüster	Stralsund
67425	105487	Klokow Industrietechnik GmbH		Parchim
67426	105491	Provak Amsterdam B.V.		Amsterdam
67427	105493	Paul Gröne GmbH	z.Hd. Herrn Marcel Dreyer	Dinklage
67428	105497	Van Smeden Harlingen B.V.		Harlingen
67429	105498	De Beer Professioneel B.V.		Zutphen
67430	105499	BEROLINA Werkzeug-Fachhandel GmbH		Berlin
67431	105508	J. Wilson (Power Tools) Ltd.		Glasgow, Strathclyde
67432	105509	Fixings Direct	Unit C, Castle Court	Coventry, West Midlands
67433	105513	Scheller und Partner	Handels und Service Center	Hildburghausen
67434	105515	Te Koppele B.V.		Eibergen
67435	105516	Suckfüll Handels GmbH		München
67436	105533	Driltec, LLC.		Byram, MS 39272
67437	105534	HV Baugeräte GmbH		Zwickau
67438	105543	Jürgen Drescher	Schweißt., Arbeitssch., Profiwerkz.	Neustrelitz
67439	105551	HEMMINK B.V.		Zwolle
67440	105552	König & Landl GmbH		WIEN
67441	105556	Martin GmbH & Co. KG	Bauzentrum	Reinsdorf
67442	105558	Breur	IJzerhandel Rivium B.V.	Capelle a/d IJSSEL
67443	105559	Drebo	Werkzeugfabrik GmbH	Altshausen
67444	105568	Bücheler & Martin GmbH	Fachhandel für Baustoffe	Singen
67445	105574	Wessex Fixings Ltd.		Andover, Hampshire
67446	105575	Readyfix Ltd.		Preston
67447	105577	Mach Tools Incorporated		Quezon City  1115 Metro Manila
67448	105586	Eisen Fendt GmbH		Marktoberdorf
67449	105599	Samitech AG	Befestigungstechnik	ST. MARGRETHEN/ SG
67450	105600	SAS CHARLES BONNET ET FILS	MANUFACTURE A	Monswiller
67451	105619	Willers	Nachf. Fischer + Koenig oHG	Oldenburg
67452	105626	CBS	Colditzer-Bau-Service GmbH	Colditz
67453	105641	Scheja Werkzeuge		Heygendorf
67454	105642	Detlef Paulsen	Betriebsausrüster GmbH	Pampow
67455	105649	Rokossa GmbH		Melle
67456	105650	Fachmarkt R. Brand GmbH		Meppen-Nödike
67457	105651	Ziesmann	Baugeräte GmbH	Torgau
67458	105655	Midland Fixings Ltd.	The Parrs	Nottinghamshire
67459	105658	Werkzeug-Schlitt	Groß-u. Einzelhandel	Maxdorf
67460	105665	SSK Schrauben Schmid GmbH		Kirchheim/Teck
67461	105672	H + W Diamantwerkzeuge	Inh. Roland Bolze	Jena-Löbstedt
67462	105675	Werkzeug Adler	WZ und Industriebedarf	Werdau
67463	105676	W. Burger en Zonen		Amsterdam
67464	105684	Manfred Häussler GmbH		Winnenden
67465	105695	H + K Baustoffe GmbH		Kamenz
67466	105710	BASTIAN GmbH	Werkzeuge und Arbeitsschutz	Mühlhausen
67467	105719	Wittig GmbH		Jessen
67468	105722	Bus' Handelmij B.V.		Zwolle
67469	105723	Holzhauser GmbH	Baumaschinen	Kirn
67470	105740	SSG Schrauben Scholz GmbH		Berlin
67471	105750	Gebhardt Bauzentrum GmbH		Goldbach
67472	105757	Werkzeug-Weber GmbH & Co. KG		Aschaffenburg
67473	105760	HolzLand	H. Wulf GmbH	Ahrensburg
67474	105763	Diethold Schweißtechnik		Sömmerda
67475	105766	Eisen Heinrich GmbH		Egling
67476	105772	Louis Scheuch GmbH	Stammhaus Kassel	Kassel
67477	105775	WELU GmbH		Salzweg
67478	105777	ELG des Bau- und Baunebenhandw. eG		Meissen
67479	105785	Action Fixings		Colchester Essex
67480	105786	Worcester Tools & Fixings		Worcester, Worcestershire
67481	105790	Pietzschmann Baumaschinen GmbH		Großweitzschen
67482	105794	WMMG GmbH	Werkzeug,Maschinen,Messgeräte	Berlin
67483	105797	IJzerhandel A.Ottenhof B.V.	Afd. Bouw en Industrie	Oldenzaal
67484	105809	Stubbe & Beck GmbH		Dinslaken
67485	105811	Deterding GmbH		Pennigsehl
67486	105817	Omega Spares Ltd.	Unit 7, Cabot Business Village	Dorset
67487	105824	Eisen-Fackler		München
67488	105827	Christian Wimschneider GmbH	Maschinen-und Werkzeuge Großhandel	Untermitterdorf
67489	105835	Anchor Fixings Ltd.	Rathenraw Industrial Estate Unit 30	Antrim
67490	105836	Kernow Fixings		St. Austell, Cornwall
67491	105841	Martin Wimmer	Baumaschinen - Landtechnik	Oberflossing
67492	105845	Meesenburg Großhandel KG	NL Greifswald	Greifswald
67493	105847	Werkzeug & Maschinen für Handwerk	& Industrie - Inh. R. Wedel	Pommersfelden
67494	105849	Fixings & Powertool Center Ltd.		Redhill, Surrey
67495	105855	Mietpark Großklos	Baugeräte und Minibagger	Kusel
67496	105856	BVD Bautechnik-Handels-	gesellschaft mbh	Ueckermünde
67497	105860	Vernhold GmbH		Osnabrück
67498	105873	König Baustoffe GmbH & Co.KG		Regen
67499	105876	Rumpf + Schuppe GmbH	Baumaschinen - Baugeräte	Zittau
67500	105885	KAYSER GmbH	Systemlieferant f.Ind.,Bau,Dienstl.	Koblenz
67501	105886	Kaufhaus Janßen		Nordenham
67502	105890	Peter M. Börsch KG		Remscheid
67503	105892	Neele Bouw & Techniek B.V.		Hardenberg
67504	105893	BMT - Baumaschinen-	gesellschaft Thallwitz mbh	Thallwitz
67505	105907	Dieter Kurth Bedachungs-Fach-	handel GmbH	Burscheid-Dürscheid
67506	105908	Gbr. Swinkels Bouwmaterialen B.V		Lieshout
67507	105911	Eder GmbH	Profi Fachmarkt	Tuntenhausen
67508	105915	Heinrich Rießelmann	Holz und Baustoffe GmbH	Damme
67509	105922	Weha GmbH		Königsbrunn
67510	105934	Garrison Dales Ltd. (G110)	Unit 1, Wassage Court	Droitwich, Worcs
67511	105936	Partnerverbund	Pyramide GmbH	Karlsruhe
67512	105937	Raab Karcher Baustoffe GmbH		Stralsund
67513	105942	KGV - Geräteverkauf	Helmut Kanzinger	Bötzingen
67514	105949	SIG Fixings Wolverhampton		Oldbury
67515	105951	B & L  Schweißtechnik GbR		Büttstedt
67516	105952	Werkzeug Prüver GmbH		Bautzen
67517	105954	Metalleinkauf e.G.	Nürnberg	Nürnberg
67518	105960	Fritz Brinkmann	Bedachungsgroßhandel GmbH	Herford-Diebrock
67519	105961	BAUKING Weser-Ems GmbH	Niederlassung Bramsche	Bramsche
67520	105964	Krapp Objekte GmbH & Co. KG		Gelsenkirchen
67521	105973	Ace Fixings Ltd.	Woodside Industrial Estate	Ballymena, Co. Antrim
67522	105977	Blackpool Power Tool Company	GEBR002	Huddersfield HD1 4WQ
67523	105980	Himmler Bauzentrum GmbH & Co. KG		Höver
67524	105986	Elektrowerkzeuge Winter	Inh. Steffi Winter	Schwielowsee / OT Geltow
67525	105989	Jürgen Schmieder	Baumaschinen, Baugeräte	Troisdorf-Spich
67526	105992	OLYMPIA EMPRESAS UNIDAS C.A.	RIF: J-00102871-4	Caracas  Venezuela
67527	106000	Brun & Böhm Baustoffe GmbH		Potsdam
67528	106007	J. W. Zander GmbH & Co		Dortmund
67529	106016	Interfix Supplies Ltd.	Shaw Lane Industrial Estate	Doncaster
67530	106019	FLB-Direct Handelsunternehmen UG		Herbolzheim
67531	106026	Dieter Truckenbrodt	Maschinen u. Werkzeuge	Grümpen
67532	106036	NL Raab Karcher Meißen	STARK Deutschland GmbH	Meißen
67533	106038	Heiko Grohnert	Baubedarf	Emleben
67534	106039	Schrauben-Fleischer	Inh. Frank Fleischer	Freital
67535	106053	Gerhard Küster GmbH	Sanitär & Heizungs-Fachhandel	Hannover
67536	106062	Standard Power Tools		Lewisham, London
67537	106069	WSM Werkzeuge GmbH		Mühlacker
67538	106072	Steinrück GmbH & Co. KG		Bergisch Gladbach
67539	106074	Feilen-Pieper GmbH & Co. KG		Wagenfeld
67540	106078	VHI Vollmer	Handel für Industrieausrüstung	Groitzsch
67541	106085	Leitermann GmbH & Co. Fachmarkt KG		Schmölln
67542	106086	Marree Technische Groothandel B.V.		Harderwijk
67543	106091	Klauser GmbH		WIESELBURG
67544	106097	Fresemann  GmbH	Schraubengroßhandlung	Dörpen
67545	106099	Rubix GmbH		Celle
67546	106103	Infix Ltd.		Bristol
67547	106104	BEV Baugeräte GmbH		Mönchengladbach
67548	106109	Boiten Techniek BV		Stadskanaal
67549	106111	Werner Schweißtechnik GmbH & Co. KG		Görlitz
67550	106119	W. Bohnsack	Handelsvertretung für Werkzeuge	Greifswald
67551	106121	Schaebbicke Präzisions-Werkzeuge		Berlin
67552	106124	Herbert Müllner	Werkzeuggroßhandel GmbH	EUGENDORF
67553	106128	KSA	Kubben + Steinemer GmbH + Co.KG	Aachen
67554	106135	BAUKING Weser-Ems GmbH	Niederlassung Bremen	Bremen
67555	106142	Buchberger	Baugeräte Handel GmbH	Ingolstadt
67556	106145	Wilhelm Drescher	Eisenwaren GmbH	Lahnau
67557	106147	Tetenborg Befestigungstechnik		Saerbeck
67558	106152	Holtzmann & Sohn GmbH		Ronnenberg-Empelde
67559	106153	Perfekter Halt GmbH & Co. KG		Remscheid
67560	106156	Eulenstein Baustoffe	Inh. Peter Metzner	Pössneck
67561	106159	Wiegand Fuchs	Industrie- u. Handwerkerbedarf	Neuensalz
67562	106166	ARTEC	Maler- und Baubedarf	Erfurt
67563	106168	Hotze GmbH & Co KG Baustoffe Leese	Niederlassung Rahden	Rahden
67564	106177	Industrie-Bedarf Meyer KG		Gütersloh
67565	106187	August Kuhfuß GmbH	Nachf. Ohlendorf GmbH	Dessau-Roßlau
67566	106194	Industrial Supplies (NI) Ltd	Unit 27-29 Mallusk Enterprise Park	Newtonabbey, Co.Antrim
67567	106202	WEWO Schrauben-	Befestigungsteile GmbH	Straelen
67568	106207	Schmidt Kfz- u.Baumaschinenteile	Vertriebs GmbH	Aachen
67569	106208	Wilhelm Hoffschulte	Nachf. Kassens GmbH & Co KG	Meppen
67570	106213	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
67571	106214	EVB BauPunkt Einkaufs- und	Handelsgemeinschaft GmbH & Co KG	Göppingen
67572	106228	Gebr. Fürstenberg GmbH	Baustoffhandel	Rathenow
67573	106233	Hobex Fachhandel GmbH		Berlin
67574	106236	Wolf Baumaschinen und Baugeräte	Handels-GmbH	Bad Mergentheim
67575	106238	IuG Industrie- und Gewerbe-	fachgroßhandel GmbH	Chemnitz
67576	106243	KTG Baumaschinen GmbH		Berlin
67577	106245	Groenhart Group B.V.	Centraal Magazijn	Purmerend
67578	106247	JGV GmbH		Grafenhausen
67579	106257	L P K Lothar Philipps	Präzi.-Werkzeuge + Maschinen	Korschenbroich
67580	106265	Adolf Würth GmbH & Co. KG		Künzelsau
67581	106267	BBN Bouwmaterialen BV		te Alkmaar
67582	106268	Wolfgang Schulz EWI	Groß- und Einzelhandel	Lutherstadt Wittenberg /OT Str
67583	106269	Panno GmbH	Fachgroßhandel für Haustechnik	Bornheim/Hersel
67584	106270	BAUKING Weser-Ems GmbH	Niederlassung Nienburg	Nienburg
67585	106274	Manfred Binz	Diamant- u. Bautechnik e.K.	Lahnau
67586	106277	Baer GmbH	Präzisionswerkzeuge	Weinheim - West
67587	106278	Friedrich Kessel GmbH		Mainz
67588	106280	Baustoffmarkt Dargun GmbH & Co.KG		Dargun
67589	106281	Kaiser & Stuckert	Industrie- und Baubedarf GmbH	Kiel
67590	106284	HBV  Hermsdorfer Beschlag	Vertrieb GmbH	Hermsdorf/Thür.
67591	106285	Wöhlk GmbH	Holz und Baustoffe	Grosspostwitz OT Ebendörfel
67592	106287	i&M Mobau Baustoffzentren	Bauer GmbH	Saalfeld
67593	106289	Reerink IJzerwaren		Vaassen
67594	106295	Maurus BauPunkt	Baubedarf GmbH	Biberach / Riß
67595	106296	Nüßing GmbH	Niederlassung Grimma	Grimma
67596	106302	Hänig Bauzentrum GmbH & Co. KG		Limbach - Oberfrohna
67597	106307	UAB "TERONIS"		Vilnius
67598	106316	Dachdeckermaschinen und Baugeräte	Inh. Lutz Mäder	Olbersleben
67599	106318	Gedema GmbH		Hagen
67600	106319	Mac Panther GmbH	Airport-Stadt Mitte	Bremen
67601	106326	Nozar GmbH & co KG		Ascheberg
67602	106334	beko GmbH		Monheim
67603	106336	W. Tebbenjohanns Nachf. GmbH		Oldenburg
67604	106340	hagebau Handelsges. für Baust.	mbH & Co. KG	Soltau
67605	106346	FESTA  Handels- und Dienst-	leistungsgesellschaft mbH	Leipzig
67606	106347	Fröhle Dachbaustoffe GmbH		Lohne
67607	106352	Profi-Baubedarf Czentarra GmbH		Cottbus
67608	106368	Jacob Sönnichsen AG	Jacob Cement Baustoffe	Ribnitz-Damgarten
67609	106374	Adolf Neuendorf GmbH		Berlin
67610	106378	Schone Baustoffhandel GmbH		Aschersleben
67611	106381	V.J. Technology Ltd.	Technology House	Ashford, Kent
67612	106386	Service Dobritsch Comerce GmbH		DOBRITSCH
67613	106387	LWS Loske Werkzeug Service		Wolfenbüttel
67614	106393	DTS Diamanttechnik	Swen Schiebel	München
67615	106396	Multi-Fix (Pty) Ltd	M.B.Distributors	Cape Town
67616	106398	Hornung GmbH & Co.KG	Fachhandel für Natur-Baustoffe	Stutensee-Blankenloch
67617	106399	AGO Durckluft	Miete-Verkauf-Service GmbH	Velten
67618	106406	RIAG	Baubedarf GmbH & Co.KG	Rudolstadt
67619	106416	Roland Lehmann	Baubedarf	Grünewald
67620	106417	ALPEN-MAYKESTAG GMBH		PUCH
67621	106418	Optimal Versand	Istvan Horogh	Worbis
67622	106419	Baustoffmarkt Wolgast GmbH & Co.KG		Wolgast
67623	106422	Macey Industrial Fixings	Unit 9, The Martlets	Hailsham, East Sussex
67624	106424	Mod-Fix Ltd.		Cardiff
67625	106432	BAUKING Weser-Ems GmbH	Niederlassung Bad Essen	Bad Essen
67626	106433	R.v.Beekveld	Technische Groothandel b.v.	Heeswijk-Dinther
67627	106439	Hantschel Werkzeuge		Lüdenscheid
67628	106448	Makita (UK) Ltd.		Milton Keynes Bucks
67629	106449	eberle-hald Handel und	Dienstleistungen Metzingen GmbH	Metzingen
67630	106459	Handelshof Cottbus GmbH	Partner für Technik	Cottbus
67631	106461	BAUKING Weser-Ems GmbH	Niederlassung Löningen	Löningen
67632	106463	Voskamp Bouw en Industrie B.V.		Amsterdam
67633	106464	Ferney Group BV		Heerhugowaard
67634	106510	Vanguard Fixings Ltd.		West Midlands
67635	106511	IJzerhandel Knoef B.V.		Hengelo
67636	106512	Donath Baumaschinen & Geräte GmbH	Baumaschinenhandel	Mülsen
67637	106513	Meyer-BHS-Eisenach e.K.		Eisenach
67638	106516	Buijtendijk B.V.		Den Helder
67639	106519	Artmann GmbH	Werkzeuge und Maschinen	Ahaus
67640	106520	Hartjenstein Werkzeuge GmbH	Baubedarf Industriebedarf	Wilhelmshaven
67641	106526	Wilhelm Linnenbecker GmbH & Co. KG		Versmold
67642	106528	Joseph Gleave & Son Ltd.	International Tool Distributors	Stretford, Manchester
67643	106537	EGN Baustoffmarkt Neustrelitz	GmbH & Co.KG	Neustrelitz
67644	106539	IHR Rabenstein Handels GmbH		Bersenbrück
67645	106540	HAUPA GmbH		Remscheid
67646	106541	MUNGO	Befestigungstechnik AG	OLTEN
67647	106545	WMZ Werkzeug- u. Maschinenhandel	Zwönitz Troll & Konopka GbR	Zwönitz
67648	106547	Werkzeughandel Clauß		Plauen
67649	106552	Voskamp Bouw en Industrie B.V.		ALMELO
67650	106556	BLT GmbH Herzberg	Profi Baubedarf	Herzberg
67651	106557	Profi Power Plus Diamant- u.	Bohrtechnik Weßelburg	Beesten
67652	106560	Post B.V.	Technische groothandel	Kampen
67653	106561	L + L Lisowski GmbH & Co KG		Herford
67654	106567	Meesenburg GmbH & Co. KG	NL Oldenburg	Flensburg
67655	106572	HNT Riesa GmbH	NL Leipzig Handel und Service	Leipzig
67656	106578	Uwe Kloska GmbH	Technischer Ausrüster	Bremerhaven
67657	106579	Schrauben-Listner	Inh. Stephan Listner	Brand-Erbisdorf
67658	106581	Müller Bohrtechnik GmbH		Lutherstadt Wittenberg
67659	106592	MP Industrie- u. Handwerksbedarf	GBR	Oschersleben
67660	106596	Rudolf Sievers GmbH	Partner für Technik	Winsen
67661	106597	Josef Hansen GmbH & Co.KG		Solingen
67662	106600	Josef Kurz		St. Wolfgang
67663	106604	Industrieberatung + Verkauf	H.-G. Krähwinkel	Rinteln
67664	106605	Hartmut Jänsch	Druckluftanlagen/Werkzeuge	Pößneck
67665	106606	Montec GmbH		Albstadt/Laufen
67666	106612	Werner Schönweiß GmbH	Werkzeuge-Maschinen	Schwarzenbruck-Pfeifferhütte
67667	106624	Batifixing Sàrl		Fischbach
67668	106626	MZW Elsterwerda UG	Werkzeuge-Industriebedarf	Elsterwerda
67669	106628	M A W Werkzeuge GmbH		Wipperfürth
67670	106639	Jürgen Neydorff	Werkzeuge-Maschinen-Industriebed.	Weiterstadt
67671	106640	Mearaj Gulf General Trading Co W.LL	Branch #6: Ez Al Deira Carpentry	Shuwaikh, Code 70651
67672	106642	Northern Power Tools and Acces.Ltd.	Unit 1A	Kendal
67673	106648	Longdia GmbH		Celle
67674	106654	Otto Röhrs GmbH	Baustoffe	Scheeßel
67675	106655	WE-MA-TEC	Technischer Handel GmbH	Limburg/Lahn
67676	106658	V. Kluge GmbH	Motorgeräte - Baumaschinen -	Frankenberg
67677	106661	Interhire Power Tool Service Ltd.		Ilkeston, Derbyshire
67678	106662	Jakob NOE Nachfolger - Stuttgarter	Baugeräte Industrie GmbH & CO.KG	Möglingen
67679	106663	Pröbster GmbH	Werkzeuge-Elektromotoren-	Hilpoltstein
67680	106664	A. Vergeer B.V.		Benschop
67681	106676	Strautmann Werkzeuge GmbH		Bad Laer
67682	106680	Udo Dömer Technik		Nordwalde
67683	106681	Handelshof Bautzen GmbH	Filiale Bernbruch/Kamenz	Kamenz OT Bernbruch
67684	106686	Rex Crystal Fixings Ltd.		Wakefield, West Yorkshire
67685	106687	Knoke Kaubanduse OÜ	Knoke Trading LLC	TALLINN
67686	106688	Ortjohann & Kraft	Wkz.- u. Masch.hd. GmbH	Rietberg-Mastholte
67687	106695	Josef Gebhardt	Elektromotoren GmbH	Nabburg
67688	106696	COBALT Sh.p.k		TIRANA
67689	106702	Alexander Holstein	Diamantwerkzeuge	Rieste
67690	106704	Walter Schlötterer	Werkzeuge	Dinkelsbühl
67691	106712	Leitermann GmbH & Co.	Fachmarkt KG	Oelsnitz/Erzg.
67692	106714	Robert Mann	Werkzeuge	Ebsdorfergrund-Hachborn
67693	106715	BEDO Innenausbausysteme	Baustoffe GmbH & Co KG	Berlin
67694	106721	STAMA GbR	Baumaschinen-Baugeräte	Erfurt
67695	106722	Bautenschutz Eilenburg GmbH		Thallwitz-Böhlitz
67696	106726	Power Fixings Ltd.		Brislington, Bristol
67697	106736	Roger W. Jones Ltd.		Rhyl, Denbighshire
67698	106760	Technipoint b.V.		Coevorden
67699	106761	SPAX International GmbH & Co.KG		Ennepetal
67700	106763	Wöhlk GmbH	Holz- u. Baustoffhandel	Markersdorf OT Holtendorf
67701	106767	Roskam B.V.		Amsterdam
67702	106771	NABOTEC GmbH	Nagel-, Bohr- und Trenntechnik	Rotenburg/F.
67703	106773	Janetschek	Schweißtechnik-Vertriebs GmbH	Cham
67704	106775	INTERPARES-MOBAU-Zentrallager	Rheinland GmbH & Co. KG	Euskirchen
67705	106777	HKL Baumaschinen GmbH	Gewerbegebiet Fichtenweg	Erfurt Kerspleben
67706	106778	M A H -Werkzeuge	Hans Hofmann	Eggolzheim
67707	106783	Dunkel - Bau Technik		Aichwald
67708	106787	Dach Walter GmbH		Großschwabhausen
67709	106788	Denis Büchner	Werkstattausrüstungen	Weimar
67710	106795	Meisl GmbH	Elektro-Mechanik	Berchtesgaden
67711	106801	NICHT LIEFERN! KUNDE IST INSOLVENT	Rouweler Vakzaak	Goor
67712	106803	Werkzeug Schade GmbH		Göda
67713	106817	Mobau Profi Zentrum	Wirtz & Classen	Heinsberg
67714	106823	Voskamp	Industrie + Techniek BV	Hengelo OV
67715	106824	Voskamp Bouw en Industrie B.V.		Rijssen
67716	106825	Voskamp Bouw en Industrie B.V.		Enschede
67717	106826	Achtermann GmbH		Troisdorf
67718	106827	Schrauben Weiß	Inhaber André Weiß	Aue
67719	106828	Werkzeug Werner		Gotha
67720	106835	Michael Baldino	Eisenwaren und Werkzeuge	Sprendlingen
67721	106837	Bude GmbH		Roßleben-Wiehe
67722	106842	Händel GmbH	Baugeräte	Ingolstadt
67723	106853	Stang GmbH & Co.KG		Gmund-Moosrain
67724	106854	GfB Handelsgesellschaft	Bef. Technik GmbH	Treuen
67725	106858	Vernhold GmbH		Münster-Hiltrup
67726	106862	NBP Nürnberger Bund PVH GmbH		Hagen
67727	106864	Schuebo GmbH		Kreuztal
67728	106867	Adolf Richter GmbH		Kiel
67729	106873	team baucenter GmbH & Co KG		Eggesin
67730	106874	Reca Norm GmbH		Ingolstadt
67731	106881	Dozon Bouwtechniek B.V.		Doetinchem
67732	106886	Walter Gmelch e. K.	Inh. Lenz Gmelch	Geisenfeld
67733	106889	Nüßing GmbH		Siegen
67734	106891	Böhm GmbH & Co KG		Potsdam
67735	106892	AMTHOR	Fachgroßhandel	Rudolstadt
67736	106904	Leeuwbouw B.V.		Zwolle
67737	106911	Pumpen & Maschinen	Inh. D. Weise	Ronneburg
67738	106912	G & T Imports Ltd.		Birkirkara
67739	106913	dth	Arnold Jank	Kolkwitz-Milkersdorf
67740	106920	ABsys SA		Kleinbösingen
67741	106927	Brema GmbH		Hohenlinden
67742	106929	Gutmann Fachmarkt GmbH		Haslach im Kinzigtal
67743	106937	Raiffeisen-Handelsgenossenschaft	Schöneck eG	Schöneck
67744	106938	GEITH & NIGGL GmbH & Co. KG	Baugeräte Baustoffe Mietpark	München
67745	106945	Andrea Holdgrün	Technischer Außendiensthandel	Buchen/Hainstadt
67746	106950	Ingo Weber	Techn. Fachgroßhandel	Reichshof-Denklingen
67747	106951	WEO Werkzeughandel GmbH		Essen/Oldenburg
67748	106952	BSB Service f.d. Baugewerbe		Taufkirchen
67749	106958	HAWIB Handwerks- u. Industrie-	bedarf GmbH	Chemnitz
67750	106963	Groothandel Delftechniek B.V.		Delfzijl
67751	106965	Buttinoni Giuseppe E Figli SNC		ALBINO (BG)
67752	106966	BBF Baumaschinen GmbH		Grimma
67753	106970	Ernst Granzow GmbH & Co.		Leonberg
67754	106971	HEUGER Cottbus GmbH		Cottbus
67755	106976	Throm GmbH		Büdingen
67756	106978	Woldt Bau- und Industrie-Service		Eberswalde
67757	106982	Baustoff Union GmbH & Co.KG		München
67758	106986	Bauzentrum	Bad Langensalza	Bad Langensalza
67759	106994	wolfcraft GmbH		Kempenich
67760	106998	Rüde Bau- und Industriebedarf GmbH		Meiningen
67761	107000	Markus Schwarz	Handwerkerbedarf	Ravensburg
67762	107002	Artur Beglau	WZ und Industriebedarf	Taucha
67763	107003	EGN Baustoffhandel Grimmen	GmbH & Co.KG	Grimmen
67764	107004	dts Manfred Quandt		Stutensee-Blankenloch
67765	107007	Maier + Kaufmann GmbH		Steinach
67766	107010	Bilawsky	Maschinen u. Werkzeuge	Murg-Niederhof
67767	107016	Eichsfeld Holz GmbH	Holz & Beschlagfachhandel	Leinefelde
67768	107021	MMS Mario Ludolph	Miet u. Maschinenservice	Borken
67769	107027	Piel-DIE TECHNISCHE Großhandlung	GmbH	Soest
67770	107034	Achim Schwandt	Elektrotechnik	Deensen
67771	107036	Industriebedarf Ohmert GmbH		Euskirchen
67772	107038	ABRABORO Kft		Szentendre
67773	107039	Schunke Werkzeughandel		Berlin
67774	107040	BSG Baugeräte Schünke GmbH		Heideland OT Koenigshofen
67775	107043	K & K Elektrotechnik GmbH		Luckenwalde
67776	107044	Achhammer GmbH & Co.KG	Werkzeuge Maschinen Montageartikel	Nittendorf
67777	107045	Berliner Schrauben GmbH & Co KG		Oer-Erkenschwick
67778	107059	Buckmann Bauzentrum GmbH & Co.KG		Bremen
67779	107060	PROFESS	Horst Jochen Wieprecht	St. Leon-Rot
67780	107062	Niklaus Baugeräte GmbH		Singen
67781	107066	Flügel Handwerkerbedarf GmbH		Lautertal
67782	107067	Holzzentrum Wöhlk Dresen	GmbH & Co. KGtoffe	Dresden
67783	107076	padre- Paul Dreiner	Verwaltungs UG & Co. KG	Wermelskirchen
67784	107080	Wiedemann Werkzeuge		Kaufering
67785	107084	ATTERER Stahlcenter GmbH		Marktoberdorf
67786	107089	Odenwälder Baumaschinen GmbH		Mörlenbach
67787	107090	Busse Technischer Handel	GmbH & Co. KG	Emden
67788	107093	Niklaus Baugeräte GmbH		Gomaringen
67789	107097	EBV Werkzeug- u. Verbindungs-	elemente-Vertriebs-GmbH	Bleialf
67790	107098	Ulmener Werkzeuge Gehl GmbH		Ulmen
67791	107100	SPH Straacher Produktions- und	Handelsges. mbH	Straach
67792	107101	Baumgärtel GmbH		Neuwied-Oberbieber
67793	107104	Saeed Mohamed Basuliman Est for Tra	Building 3118  Unit No. 6	Riyadh, Kingdom of Saudi Arabi
67794	107106	WMS Vertriebs- GmbH		Schwaigern
67795	107108	Einkaufs- und Liefergenossenschaft	Metall e.G. GroßHdl. San. Heiz	Lübben
67796	107109	HeimwerkerZentrum Wagner GmbH		Elz
67797	107111	Nüssing GmbH	Niederlassung Sonnenwalde	Sonnewalde
67798	107120	BHG AG - BFH Bayreuth		Bayreuth
67799	107125	Wilh. Jansen - Eisenjansen	GmbH & Co. KG	Geilenkirchen
67800	107126	FEGA & Schmitt GmbH	Elektrogroßhandel	Hanau
67801	107132	Stabilo - Landtechnik	Berthold Kieninger e. K.	Aalen Waldhausen
67802	107135	EGRO Warenhandel	Hagen Helmig	Mülheim
67803	107138	Schrauben - Heidig	Normteilhandel	Zittau - Pethau
67804	107145	Fritz Schlund	Elektromotoren	Coburg
67805	107151	Berliner Schrauben GmbH & Co KG		Münster
67806	107153	CEF Elektrofachgroßhandlung	Nord  GmbH	Karslruhe
67807	107156	Nüßing GmbH		Emleben
67808	107157	Brigitte Schröder	Werkzeughandel	Lahnstein
67809	107159	Thomas Leis	Werkzeuge - Service	Calbe/Saale
67810	107160	KARACA MAKINA Ltd.	Persembe Pazari Cad. Cesme sok.	Karakoy-ISTANBUL
67811	107180	Bauzentrum Pfaffenhofen GmbH&Co.KG		Pfaffenhofen
67812	107185	Boogaard		Haarlem
67813	107187	Regts Holding BV I.O.		Sneek
67814	107193	Groenhart Group B.V.		Zwaag
67815	107194	Groenhart Group B.V.		Alkmaar
67816	107196	Wijngo Holland B.V.		Gouda
67817	107199	Hans Möller & Sohn GmbH		Kelkheim
67818	107200	MSM-Wälzlager und	Industriebedarf GmbH	Troisdorf-Oberlar
67819	107210	Hornung GmbH & Co. KG		Stutensee - Friedrichstal
67820	107213	Baustoff Union GmbH & Co.KG	NL BU West	München
67821	107214	FEGA & Schmitt Elektrogroßh. GmbH	NL Fulda	Fulda
67822	107216	E + B Stahlhandel GmbH & Co KG		Bendorf
67823	107217	Ronald Brauer	Motorgeräte	Landsberg/OT Queis
67824	107228	MARKANT Handels und Service GmbH	Inkasso/Zentralregulierung	Offenburg
67825	107235	WEHAMA Magdeburg GmbH		Magdeburg
67826	107237	ELG des metallverarb. Handwerks	Meißen eG	Meissen
67827	107246	Isero IJzerwarengroep B.V.	Gerritse IJzerwaren	Woerden
67828	107252	Holthöwer GmbH	Fachzentrum	Dülmen
67829	107254	BMN Van Keulen I Amsterdam		Amsterdam
67830	107256	Baustoff-Union Neuenhagen GmbH		Neuenhagen
67831	107259	Schulz Baubedarf GmbH	Ludwigsfelde	Ludwigsfelde
67832	107260	A & R Koch	Druckluft- und Befestigungstechnik	Schlotheim
67833	107268	SEEFELDER GmbH	Baubeschläge-Werkzeuge	Landshut
67834	107283	Albert Leymann GmbH & Co.	Baustoffe	Sulingen
67835	107287	B & W Befestigungstechnik	Werkzeuge	Ludwigslust
67836	107291	Pelzl Elektrogrosshandels GmbH		Glauburg
67837	107293	Eberle Hald Handel&Dienstleistungen	Dresden GmbH	Coswig
67838	107294	Staubach & Christiani GmbH		Gelsenkirchen
67839	107295	Jura-Schrauben GmbH & Co. KG		Nürnberg
67840	107296	Häder GmbH		Melle
67841	107300	Gradl Befestigungstechnik		Kümmersbruck
67842	107305	Bau Team Röther		Ahrensbök
67843	107307	August Bischoff GmbH & Co. KG		Bad Dürkheim
67844	107310	Klaus Braun GmbH		Kastellaun
67845	107315	Elektromaschinenbau Gärtner GbR		Elsterwerda
67846	107319	Govers B.V.		Den Helder
67847	107320	Schweißtechnik Becker	Inh. Barbara Stanke	Erfurt/Urbich
67848	107325	Mann Diamanttechnik GmbH & Co.KG		Bochum
67849	107326	Jörg Bergander e. K.	Inh. Jörg Bergander	Schipkau
67850	107329	A. Selzer	Industriebedarf-Großhandel GmbH	Schmelz-Hüttersdorf
67851	107332	Appelhagen & Kolberg Handelsver-	tretungen Inh. Erwin Kolberg	Neubrandenburg
67852	107340	Leuther Schleifmittel und Diamant-	werkzeuge	Panketal
67853	107344	Befestigung & Technik Witten	Reinhard Ikenmeyer	Witten
67854	107345	JÄGER DIREKT	Jäger-Fischer GmbH & Co. KG	Reichelsheim
67855	107349	Strehlaer Baumaschinen GmbH	Baugerätehandel	Strehla
67856	107350	Verbindungstechnik & Baustoffhandel	Jürgen Schiffer GmbH	Isseroda
67857	107352	Werkzeug Partner	Jörg Noack	Lauchhammer - Mitte
67858	107353	EW-präsent GmbH		Witten-Annen
67859	107354	BBI Beck Befestigungstechnik	Industriebedarf GmbH & Co.KG	Hameln
67860	107361	Heiratec GmbH	Industrie + Haustechnik	Stadtoldendorf
67861	107364	Mathias Peter Cakó	Werkzeuge u. Maschinen	Neuching
67862	107365	GROSS-Werkzeuge KG		Osthofen
67863	107368	BAUKING Weser-Ems GmbH	Niederlassung Osnabrück-Fledder	Osnabrück
67864	107376	MONTTEC GmbH		Siegen
67865	107381	S & S Elektro-Fachgroßhandlung GmbH	Schmidt + Schneider	Dillenburg - Manderbach
67866	107384	IHW Koch	Inhaber Frank Lutze	Nordhausen
67867	107393	Meier Vertriebs GmbH & Co.KG		Pr. Oldendorf-Holzhausen
67868	107397	Gierth & Herklotz GmbH	Mietgeräte	Bernau/Rehberge
67869	107398	Zwager IJzerhandel BV		Den Haag
67870	107400	Otto Roth GmbH & Co KG		Stuttgart
67871	107404	CS-SECUTEC GmbH		Speicher
67872	107406	Reidl GmbH & Co.KG		Hutthurm
67873	107408	Werkzeuge Dietrich	GmbH & Co.KG	Burgdorf
67874	107410	J. Pfefferl	Breitfeld	Aholming
67875	107413	Keller & Kalmbach GmbH	Filiale Würzburg	Würzburg
67876	107416	Otto Röhrs GmbH	NL Rotenburg	Rotenburg/Wuemme
67877	107418	Rudolf Sievers GmbH	Partner für Technik	Hagenow
67878	107423	F. Schünke GmbH		Lauchringen
67879	107425	Armin Braun GmbH		Offenburg-Zunsweier
67880	107427	Hass + Hatje GmbH	Baustoffzentrum	Rellingen
67881	107433	Walter Wesemeyer GmbH		Greifswald
67882	107436	Handelsunternehmen Sebastian Ehlert		Hallungen
67883	107437	Baubedarf Rentz GmbH		Neukirchen-Vluyn
67884	107440	Berger Bau- + Industriebedarf GmbH		Eggenfelden
67885	107443	EUROPART Materials GmbH	Abt. Rechnungsprüfung	Hagen
67886	107444	hagebaucentrum Bolay GmbH & Co KG	Abt. Mietpark	Rutesheim
67887	107448	WMT GmbH	Werkzeuge Maschinen	Hildesheim
67888	107459	TYÖKALUTUONTI OY	Professional Tools	HELSINKI
67889	107460	Wille GmbH	Baugeräte-Schalungstechnik	Neubrandenburg
67890	107468	S & L	Fachgroßhandel f. d. Raumausstatter	Balve-Garbeck
67891	107471	Machens Industriebedarf GmbH		Hohenhameln OT Clausen
67892	107474	Tom Tritschler GmbH		Erftstadt
67893	107475	A-Z Baumaschinenhandel	Hattingen GmbH	Krefeld
67894	107481	Schleyer	Sicherheit & Technik	Wetter
67895	107484	Mobau Klein GmbH		Niederkassel-Mondorf
67896	107497	Elektrowerkzeuge Hoffmann e.K.	Inhaber Daniel Hoffmann	Lüdenscheid
67897	107499	De Schuur B.V.		Kootwijkerbroek
67898	107503	HEMÜ Werkzeuge GmbH		Linsengericht
67899	107504	Torsten Pischko		Kaltensundheim
67900	107505	Krüger & Scharnberg GmbH	FH Schwarzenbek	Schwarzenbek
67901	107507	Hass + Hatje Baustoffzentrum		Ratzeburg
67902	107508	Walter Wesemeyer GmbH		Siek
67903	107509	Bergsma Leek	Gereedschappen	Leek
67904	107510	Carl Beutlhauser	Baumaschinen GmbH	Regensburg
67905	107515	BTE Bauteile Ergenzinger GmbH	Hauptverwaltung Düsseldorf/Germany	Düsseldorf
67906	107517	Schweißfachhandel	R. Lerch	Wachstedt
67907	107520	Bauwelt Delmes Heitmann GmbH & Co.	Profi-Fachmarkt	Buchholz
67908	107523	NL Raab Karcher Waiblingen	Stark Deutschland GmbH	Waiblingen
67909	107531	Oliver Grund	Elektrowerkzeuge	Duisburg
67910	107536	Eisen Thielen GmbH & Co		Daun/Eifel
67911	107544	Provak Drachten		Drachten
67912	107545	Krüger & Scharnberg G.m.b.H.		Hamburg
67913	107549	KaDo GmbH	Baumaschinen & Baugeräte	Neunkirchen
67914	107553	Bauer Baugeräte		Düren
67915	107554	MTA Schleif- u. Befestigungst.	Vertriebs-GmbH	Dasing
67916	107558	Boogaard		Heemskerk
67917	107562	Piller Maschinenhandel OHG		Kollnburg
67918	107564	STUKK ABE	Einkaufsg. f. das Stuckgewerbe eG	Nürnberg
67919	107576	W. Grün GmbH & Co. KG		Gießen
67920	107581	Klaus Meier GmbH	Werkzeug + Maschinenhandel	Trier
67921	107582	Carl Beutlhauser GmbH	Baumaschinen	Dresden
67922	107585	OOO Toolfor		Moscow, Russia
67923	107586	Strobel Diamant GmbH		Pforzheim
67924	107588	Baupunkt Flügel GmbH	Masch. Verm.- u. Baubedarf	Wismar
67925	107589	Hass + Hatje GmbH		Bad Oldesloe
67926	107590	PROFESS	Bauprodukte Handels GmbH	Ahrensburg
67927	107591	MANAL doo		Zagreb
67928	107592	KREBS Baubeschlag GmbH		Berlin
67929	107595	Theodor Wölpert GmbH & Co.	Baustoffe Fliesen	Neu-Ulm
67930	107602	BePe Befestigungstechnik GmbH		Waldbröl
67931	107604	UNION Bauzentrum HORNBACH GmbH		Annweiler
67932	107610	BHG Bau-Heimwerker-Garten-Markt	GmbH & Co.KG	Altentreptow
67933	107611	Krabbes Dienstleistungscenter	Inh. J. Stoye	Leipzig
67934	107615	Michaelis Fachgroßhandel		BERLIN TEMPELHOF
67935	107617	UNION Bauzentrum HORNBACH GmbH		Billigheim
67936	107621	MULTITOOLINDO SEJAHTERA	Komplek Pertokoan	Jakarta / INDONESIA
67937	107622	Häsele Baucentrum		Schwäbisch Hall
67938	107623	Hass + Hatje GmbH	Baustoffzentrum	Bad Segeberg
67939	107627	Baumaschinen und Nutzfahrzeuge	Wolfgang Trinks	Frohburg
67940	107628	Dubick & Stehr	Baugeräte GmbH	Schwerin
67941	107638	BAUKING Weser-Ems GmbH	Niederlassung Osnabrück-Atter	Osnabrück/Atter
67942	107641	UNION Bauzentrum HORNBACH GmbH		Germersheim
67943	107645	Heinrich Knobloch GmbH		Rhauderfehn
67944	107649	HKN Handelskontor Nord	GmbH & Co. KG	Wilhelmshaven
67945	107650	Verpa Senco B.V.		Lelystad
67946	107655	IMG		Wenum-Wiesel
67947	107658	Hockertz Baumaschinen		Bitburg - Flughafen
67948	107664	Leitermann GmbH & Co.	Fachmarkt KG	Rochlitz
67949	107665	Theodor Wölpert GmbH & Co.	Baustoffe - Fliesen	Herbrechtingen-Bolheim
67950	107670	Apprich-Baustoffe GmbH & Co KG		Böbingen
67951	107672	ankox GmbH		Magstadt
67952	107674	Restemeyer GbR		Westerkappeln
67953	107675	Optimera Estonia AS		TALLINN
67954	107677	BGN Gleichauf Haustechnik	GmbH & Co. KG	Neumarkt
67955	107679	Bianca Hitzler GmbH	Diamantwerkzeuge	Dillingen/Donau
67956	107680	Lorenz	Baubedarf	Malchin
67957	107684	Nordhäuser Stahl GmbH		Nordhausen
67958	107685	Bauzentrum Otto Zillinger	GmbH & Co.KG	Osterhofen
67959	107687	C.F. Janus GmbH & Co.KG	Baustoffhandel Hagebau 118501	Wismar
67960	107688	Felbick Werkzeuge	Inh. Karl Ernst Felbick	Remscheid
67961	107689	Werkzeugfachhandel	Dieter Erdmann	Neuenhagen
67962	107690	HK-Industriebedarf GmbH		Mönchengladbach
67963	107691	team baucenter GmbH & Co KG		Bentwisch/Rostock
67964	107694	Heinrich Thorwesten KG	Baustoff-u. Bedachung	Balve
67965	107695	ELEKTROWERKZEUGE	Volker Lauche	Wohlmirstedt
67966	107703	Meus Maschinen		Lichtenhagen/Dorf
67967	107706	Maschinen-Gruber GmbH		Falkenberg
67968	107709	Teuchert Dichte Bauwerke GmbH		Großschirma
67969	107710	B.S.H. GmbH	Bau- u. Sanitärhandel	Breidenbach-Biedenkopf
67970	107713	GEORGES ZAKA & CO. S.A.R.L.	Rbeiz Bldg.	BEIRUT / LEBANON
67971	107714	Schrader Handel GmbH & Co. KG		Northeim
67972	107715	Schotte Verbindungstechnik	GmbH & Co.KG	Wuppertal (Barmen)
67973	107716	Deterding Fachmarkt GmbH		Nienburg
67974	107718	UNION Bauzentrum HORNBACH GmbH		Kandel-Mindersloh
67975	107721	HÜBNER WERKZEUGE GMBH		Großröhrsdorf
67976	107730	Ernst Noeke GmbH & Co.KG		Meschede
67977	107732	Querfurter Fahrzeugteile	und Industriebedarf GmbH	Querfurt
67978	107745	Premier Fixings	Unit 1	Aberdeen
67979	107747	C.D.F. Supplies Ltd.		Chorley
67980	107750	Martindale Industrial Fasteners	Unit 3D	Longridge, Lancashire
67981	107751	Mark Up Tools Ltd.		Manchester
67982	107752	Avantifix (Fixing Solutions) Ltd.	Bridge Works	Rothwell, Leeds
67983	107754	Lloyd & Jones Engineers Ltd.	Langton House	Bootle, Merseyside
67984	107758	Harlequin Fixings	Unit D Block 2	Kilmarnock
67985	107759	Northfield International Ltd.		Billingham,Stockton-on-Tees
67986	107761	Crown Tools & Fixings Ltd.	Unit 49, Grace Business Centre	Mitcham, Surrey
67987	107762	Fast Pak Ltd.		Stourbridge, West Midlands
67988	107763	Herts Tool Co	T/A HTC Fastenings Ltd.	St. Albans, Herts.
67989	107771	London Plant Hire (Dermamoss Ltd)	Tool Hire & Sales	Finchley, London
67990	107773	S & S Elektro-Fachgroßhandlung GmbH	Schmidt & Schneider	Overath-Untereschbach
67991	107775	Biebrach C. H. Morgenstern GmbH		Dresden
67992	107777	Eurotools International Ltd.	Brent House, 3rd floor, Suite A14	Harrow, Middlesex
67993	107780	Western Bolt & Eng. Supplies Ltd.		Taunton
67994	107781	EBB Erfurter Baumaschinen und	Baugeräte GmbH	Erfurt
67995	107785	P.E.T Hire Centre Ltd.		CREWE, CHESHIRE
67996	107790	Lawson H.I.S. Ltd.	Unit 1, Itchen House	Southampton, Hampshire
67997	107792	Bauwelt Delmes Heitmann	Profi-Fachmarkt	Seevetal
67998	107796	IFI Limited	Units 1,2,3	Peterborough, Cambridgesh.
67999	107801	Specialist Contractors Supplies Ltd	Unit 29	Wolverhampton
68000	107808	Rajkovic Handels GmbH		WIEN
68001	107809	Feucht GmbH	Baustoffe + Fliesen	Backnang
68002	107811	Cable Ties Direct		Sheffield, South Yorkshire
68003	107815	Schreier Maschinenhandel	Inh. Doris Collrep	Erfurt
68004	107817	Invicta Tools & Fixings Ltd.	Wincheap Industrial Estate	Canterbury, Kent
68005	107826	Edge Building Products		Horsham
68006	107828	Brabbin & Rudd	Industrial Supplies & Engineers M.	Bolton, Lancashire
68007	107829	hagebau Centrum Köthen GmbH & Co.KG	Baustoffhandel	Köthen
68008	107834	Berriman & Chapman		Scarborough, N.-Yorkshire
68009	107836	VIJAK d.o.o.	trgovsko podjetje	Trzin
68010	107839	Mur-fix Ltd.	The JM Centre	Swinton, Manchester
68011	107847	BAUKING Westfalen GmbH	Niedl. Gladbeck	Gladbeck
68012	107854	dth Ingo u. Olaf Hartmann GbR	Fachgeschäft	Chemnitz
68013	107859	Baustoff Union GmbH & Co.KG	Baustoff Großhandlung	Grafing
68014	107863	EUROBAUSTOFF Zentrallager OST	GmbH & Co KG	Petersberg OT Wallwitz
68015	107866	Bachar & Elias Taoutel		Aleppo Syria
68016	107871	Brianson Electrical		Croydon, Surrey
68017	107878	MECHANICAL World S.A.C.	RUC 20506591431	Lima 32, PERU
68018	107879	Technischer Handel u. Service	Inh: Vera Sauer	Görlitz
68019	107883	Swansea Fasteners & Eng. Sup. Ltd.	Units 7 & 8 Horizon Park	Swansea
68020	107888	Kellner & Kunz AG	Schrauben - Werkzeuge - Normteile	WELS
68021	107890	Mobau Dörr & Reiff GmbH		Eschweiler
68022	107891	Kohrmann Baumaschinen	GmbH	Renchen
68023	107892	TK Baumaschinen GmbH		Detmold
68024	107894	Gerhardt GmbH	Hagebau Profi	Dreieich
68025	107902	Fastfix Tools Ltd.		Southampton, Hampshire
68026	107904	Martin Meier AG		Eichstätt
68027	107906	Bauzentrum Sievert GmbH & Co.KG		Marktredwitz
68028	107907	Kneissl Industriebedarf GmbH		Lauda-Königshofen
68029	107913	Wolfgang Knabe GmbH		Damme
68030	107918	Eisen Krapp GmbH & Co.KG		Bad Laer
68031	107928	Stainless Steel Centre		Cattedown, Plymouth
68032	107930	Makita Australia Pty Ltd		Pemulwuy
68033	107934	B & P GbR Fachhandel für Werkzeug	Inh. Klaus Panasik & Olaf Barnewitz	Nauen
68034	107936	Mobau Döör & Reiff GmbH		Stolberg-Mausbach
68035	107939	Mayer + Ruppert GmbH	I & M Bauzentrum	Hochdorf-Assenheim
68036	107941	FWB South West Ltd.		Truro, Cornwall
68037	107950	Hans Koll	Landtechnik	Meggerdorf
68038	107954	IJzerhandel Zwaard B.V.		Delft
68039	107955	M & F Werkzeughandel GmbH		Windeck
68040	107957	Arbeitsschutz- & Baugerätehandel	Gerd Wald	Mansfeld / OT Großörner
68041	107964	Duchy Fasteners Ltd.	Units 1 to 4	Perranporth, Cornwall
68042	107966	CEF Elektrofachgroßhandlung	Norderstedt GmbH	Norderstedt
68043	107968	UNION Bauzentrum HORNBACH GmbH		Münchweiler
68044	107971	Hermann-Josef Stoffels	Werkzeuge u. Maschinenhandel	Dierscheid
68045	107972	Tobias Hipp	Fa. Hipp	Lechbruck am See
68046	107974	Bauzentrum Seyfarth GmbH		Potsdam
68047	107977	SAS ALSAFIX		GRIES (Strasbourg)
68048	107978	Hattemleeuw B.V.		Hattem
68049	107987	Bau- und Heimwerkershop	Inh. Ines Machalett	Obergebra
68050	107988	Bauzentrum Schnepf GmbH & Co.KG	Interpares-Mobau	Güstrow
68051	107992	TOCAFIX AG		Spreitenbach
68052	107994	BBS Bur Baumaschinen Service GmbH		Rochlitz
68053	107999	Peter Seiwert GmbH	Elektrotechn. Großhandlung	Illingen
68054	108001	reichelt elektronik GmbH		Sande
68055	108007	KHANDAKER MILL STORES	VAT Registrat. Number: 21281033487	DHAKA-1100, BANGLADESH
68056	108009	Tobias Ebeling	Werkzeugfachhandel	Alsleben
68057	108011	H & W Eisenwarenhandelsges. mbH		Hamm
68058	108019	Henrich-Gerolstein Zweig-NL	Henrich BZ GmbH & Co.KG	Gerolstein
68059	108024	EURL OUTILSEC	Equipements Industrielles	EL-HAMIZ  ALGER
68060	108028	Mobau Dörr & Reiff GmbH		Düren-Gürzenich
68061	108031	Fegime Deutschland GmbH & Co.KG		Nürnberg
68062	108035	Albert Leymann	Baustoffe GmbH & Co.	Twistringen
68063	108036	Jewema Werkzeuge + Maschinen GmbH		Jena
68064	108037	H.W. Meyer sen. Wwe. GmbH + Co.KG		Soltau
68065	108039	Rohse & Lipfert GmbH		Unterwellenborn
68066	108041	First Fix	Unit 1 B	North Yorkshire
68067	108045	Strauch & Böttcher GmbH & Co.KG	i&m Bauzentrum	Gröden
68068	108046	Berry Clark & Co. Ltd.	Berry House, Gypsy Lane	Staffordshire
68069	108048	Steinacker Stalleinrichtungen	Inh. Thomas Steinacker	Dinkelsbühl
68070	108049	IBT Ingold & Burgert GmbH		Freiburg
68071	108053	EUROBAUSTOFF Zentrallager Bayern	GmbH & Co.KG	Rohr
68072	108054	Wesco KG	Fachgrosshandel für Gebäudetechnik	Wenden-Hünsborn
68073	108058	Kellerðs IJzerhandel B.V.	Goederenontvangst (2ee roldeur)	Rotterdam
68074	108062	Pawils Elektromaschinenbau GmbH		Peine
68075	108063	Elias Illgen	Werkzeuge u. Bautechnik	Oelsnitz OT Neuwürschnitz
68076	108064	Bauzentrum Spies GmbH		Geseke
68077	108072	ALARM Werkzeuge GmbH		Remscheid
68078	108080	Fachmarkt Krethe		Cadenberge
68079	108082	Wabners Bautechnik GmbH		Velten
68080	108083	PROMATECH Trading GmbH	z.Hd. Herrn Schlickum	Hamburg
68081	108089	Peter Gieraths GmbH & Co. KG		Remagen
68082	108091	Ter Laare B.V.		Maassluis
68083	108093	profibau	Handel Logistik Service GmbH	Göppingen
68084	108096	Ruhland-Kallenborn GmbH	Baustoffhandel	Blieskastel
68085	108100	Diamant Technik	Jakob Schmidt	Bad Dürkheim
68086	108108	Lindner Werkzeuge		Bad Gottleuba
68087	108111	Bakker de Houthandel		Hoogkarspel
68088	108112	L.J. Machine Tools Ltd.		Lurgan, Co.Armagh, N.-IRL.
68089	108113	C. G. Christiansen GmbH & Co.	Holz- und Baustoffzentrum	Mildstedt
68090	108116	Eurofasteners Ltd.		Weymouth, Dorset
68091	108117	Moog GmbH		Paderborn
68092	108118	Stupp Baustoffe GmbH		Bad Soden-Salmünster
68093	108122	Grampian Fasteners		Dyce, Aberdeen, SCOTLAND
68094	108123	OOO YASTA""		Kyiv / Ukraine
68095	108126	P.A.M. Ties Ltd.	Electric House	Tyldesley, Manchester
68096	108128	UNION Bauzentrum HORNBACH GMBH		Kaiserslautern-Einsiedlerhof
68097	108130	Bolt & Bearing (London) Ltd.	Unit B5, Valley Link Estate	Enfield
68098	108131	Stefan Balleis Industrie- und	Werksbedarf e.K. - Inhaber	Baar
68099	108133	1st Fix Systems Ltd.	Unit 3 Abercorn House,	Newcastle-upon-Tyne
68100	108135	mkw Fachhandel	Klaus Mayer	Wachenroth
68101	108136	AER SIA		Marupes nov
68102	108141	Bauzentrum Zeiß GmbH & Co KG		Fürth/Odenwald
68103	108142	Hurter Elektromaschinenbau GmbH		Leutkirch/Allgäu
68104	108143	Stelter GmbH		Verl
68105	108146	Gebr. Kinzer oHG	Vermietung-Verkauf-Wartung	Altenstadt/H.
68106	108147	Baustoffunion GmbH & Co.KG		Ansbach
68107	108151	dth Martin Henke		Hagen
68108	108152	Schäfer	Werkzeuge Baumaschinen	St. Ingbert
68109	108154	BHG Handelszentren GmbH		Luckau
68110	108156	Mainline Products Ltd.	Unit 3b Aspect Court	Silverdale, Newcastle u. Ly.
68111	108158	Workwear Center		Glenrothes, Fife/Scotland
68112	108160	Bauvista GmbH & Co. KG	Einzelhandel	Lage
68113	108161	GAAC Commerz GmbH		Mittenwalde
68114	108163	Strukta Ltd.	T/A Advance Fixings	Andover, Hampshire
68115	108165	bauXpert Gebhard GmbH & Co. KG		Zeven
68116	108173	M+V Bauservice OHG		Waren (Müritz)
68117	108179	DMB Baumaschinen		Embsen
68118	108184	RapierStar Imports Ltd.	Star Business Park	Macclesfield, Cheshire
68119	108186	Jan Fr. Gehlsen GmbH & Co. KG	Holzland	Rendsburg
68120	108188	W-tec Waidhofer & Winkler GmbH	Techn. Industriebedarf	KEMMELBACH
68121	108192	ITW Construction Products		Middelfart
68122	108193	Werner Industriebedarf		Barnstorf
68123	108195	Adams Bausysteme	Bauelemente + Industriebedarf	Acht
68124	108197	Fierro Vignoli S.A.		Montevideo
68125	108198	Ahrens Fachmarkt GmbH & Co.		Lügde
68126	108200	bauwelt Geesthacht		Geesthacht
68127	108203	HORNBACH Baustoff UNION GmbH	Zentrale	Neustadt
68128	108209	Robert Röhlinger GmbH		Schiffweiler-Heiligenwald
68129	108213	Celo GmbH		Wilnsdorf
68130	108216	Georg C. Hansen GmbH & Co.KG		Husum
68131	108217	Stahlhandel Haug	GmbH & Co.KG	Bad Friedrichshall
68132	108218	INTERNATIONAL GROUP AP SUALPE		Madrid
68133	108224	BETO		Oud-Beijerland
68134	108225	IHB Industrie- und Handwerksbedarf	Inh. Thomas Schwotzer	Lauter-Bernsbach
68135	108226	Toplicht GmbH		Hamburg
68136	108227	H. gr. Beilage GmbH & Co.KG	Holz - u. Baufachhandel	Vechta
68137	108228	Wilhelm Schlotfeldt	Stahl- & Sanitärfachgroßhandel	Niebüll
68138	108232	Hans Koll	Landtechnik Ndl. Rendsburg	Rendsburg
68139	108235	CCD Diamanttechnik		Bremen
68140	108236	ITW Construction Products U.K.		Glenrothes
68141	108238	Bauzentrum Schrobenhausen		Schrobenhausen
68142	108239	Bauzentrum Mayer GmbH & Co.KG		Ingolstadt
68143	108240	Marshall Industrial Supplies Ltd.	Unit E Acorn Park	Nottingham
68144	108241	Herzog Stahlhandel GmbH		Calw-Heumaden
68145	108242	DB Industriewaren		Halle
68146	108243	Sommer Gas-, Löt- u. Schweiss-	technische Handels GmbH	Pirna
68147	108244	Centro Logistico Heller		Madrid
68148	108247	I & M Mobau Baustoffzentrum	Bauer GmbH	Rudolstadt
68149	108248	Zeppelin Rental GmbH & Co.KG		Schwerin
68150	108250	Hamann GmbH		Bad Neuenahr-Ahrweiler
68151	108255	ELAWI	Eisenwaren + Werkzeuge	Wildeshausen
68152	108259	Bauzentrum Schulte GmbH & Co.KG		Papenburg
68153	108260	Bauzentrum Schulte GmbH & Co.KG		Rhede (Ems)
68154	108267	Van Deursen Diamanttechnieken B.V.		Helmond
68155	108272	Ace Fixings (Cumbria) Ltd.	Unit 34, Gilwilly Road	Penrith, Cumbria
68156	108274	elbe-tools GmbH		Wittenberge
68157	108279	Werner Schmitt	Spezialwerkzeuge	Kestert/Rhein
68158	108281	Apparatebau Jürgen Schmitz GmbH		Koblenz
68159	108282	Hannelore Rehbein	Dachzubehör Befestigungstechnik	Furth im Wald
68160	108284	BerCo d.o.o.		Maribor
68161	108288	Mietpark - Pößneck	Baumaschinen u. Werkzeug Verleih	Pößneck
68162	108297	Toolstation (Bridgwater) Ltd.	Express Park	Bridgwater, Somerset
68163	108301	ELG des Bauhandwerks e.G.		Leipzig
68164	108302	Bauzentrum Pelzer GmbH		Wesseling
68165	108305	Biehringer GmbH	Zerspanungswerkzeuge und Maschinen	Georgensgmünd
68166	108307	Heinrich Mehring GmbH & Co.KG		Dinslaken
68167	108311	BMK GmbH	Baubedarf Mietpark Kundendienst	Dresden
68168	108312	Rudolf Sievers GmbH	Partner für Technik	Schwerin-Görries
68169	108313	EUROBAUSTOFF Handelsges.mbH & Co KG		Bad Nauheim
68170	108315	Künkel Baugeräte	Fachhandel & Vermietung	Nauen
68171	108318	Weber Diamantwerkzeuge	Inh. Ulrich Weber	Kasbach-Ohlenberg
68172	108324	Quick Sharp Services	Signal Hill	Gawcott Buckinghamshire
68173	108326	Hamblin Watermains Ltd.	The Old Bam	Winnersh, Berkshire
68174	108327	K.S.V. Srl		ORTONA (CH)
68175	108330	Dalhoff GmbH & Co.KG	Baustoffzentrum	Frankfurt/Oder
68176	108332	HBA Handels und Dienstleistung GmbH		Velten
68177	108333	Scholte & De Vries - Estoppey B.V.		Diemen
68178	108336	TIS Techn.Industriebedarf Schorr		Nonnweiler-Otzenhausen
68179	108337	Georg Weber GmbH		Bad Pyrmont
68180	108338	Schönig + Würz GmbH	Elektro-Großhandlung	Groß-Zimmern
68181	108341	Guillet S.A.	B.P. 5	Villebois
68182	108342	HBK Dethleffsen GmbH		Flensburg
68183	108343	HBK Dethleffsen GmbH		Treia
68184	108347	W. Tebbenjohanns Nachf. GmbH		Vechta
68185	108349	HESS Diamantwerkzeuge GmbH		Herne
68186	108366	S + W GmbH	Schrauben + Werkzeuggroßhandel	Karlstadt
68187	108370	hego-Oldenburg NL der	WeGo Systembaustoffe GmbH & Co oHG	Oldenburg
68188	108378	Heinz Fälschle	Werkzeuge & Maschinen	Deiningen
68189	108379	HBT Hydraulik-und BauTechnik GmbH		Pirna
68190	108380	Wolfgang Lötzke	Bautechnik	Osnabrück
68191	108381	PRETEC	Pre Cast Technology AB	Kungälv
68192	108384	F. Reyher Nchfg. GmbH & Co.KG		Hamburg
68193	108386	Paul van Benthem IJzerwaren		Losser
68194	108387	W & Z  Befestigungssysteme	Inh. Oliver Zembsch	Schweinfurt
68195	108393	Ennens GmbH & Co.KG	Bau- und Industrietechnik	Ostrhauderfehn
68196	108401	SureFix Industrial Supplies		Cheltenham
68197	108403	ELG - Holz Naumburg e.G.		Naumburg
68198	108407	Gruber Diamantwerkzeuge		Idar-Oberstein
68199	108409	Peter Kasberger Baustoff GmbH		Neuötting
68200	108410	Peter Kasberger Baustoff GmbH		Pfarrkirchen
68201	108411	Peter Kasberger Baustoff GmbH		Pocking
68202	108412	Peter Kasberger Baustoff GmbH		Freyung
68203	108413	Peter Kasberger Baustoff GmbH		Passau
68204	108416	Wrayway & Co. Ltd.	Wholesale Ironmongery and Hardware	Harrogate, Nort Yorkshire
68205	108421	Bauzentrum Bühler KG		Schramberg
68206	108424	Frank Bauer	Werkzeughandel	Berlin
68207	108428	bauXpert Knipper GmbH & Co. KG		Sögel
68208	108431	Multifix Supply Company Ltd.	Pinnacle House	Boxley, Maidstone
68209	108435	Engineering Agencies Ltd.	Atholl Works	Dunfermline, Fife
68210	108436	L. Andrees GmbH	Elektro- & Baubedarf	Lotte-Büren
68211	108439	SIG Fixings	Park 26, Unit E	Bradford
68212	108440	A1 Fixings Ltd.		Sheffield, South Yorkshire
68213	108444	Krebeck Technischer Handel e.K.		Damme
68214	108447	Taktfest S.R.L. Romania	J22/117/2003	Iasi
68215	108449	Safeline GmbH		Dortmund
68216	108451	Wilhelm Fricke SE		Heeslingen
68217	108452	Rothkegel Baufachhandel GmbH	ZEK	Leipzig/Lindenthal
68218	108459	Rothkegel Baufachhandel GmbH		Merseburg/OT Beuna
68219	108460	F. & K. Paulich GmbH	Baustoffhandel	Glaubitz
68220	108462	HBK Dethleffsen GmbH		Bredstedt
68221	108465	BHG Freital	Inh. Dirk Mühle	Freital
68222	108471	The Hireman (London) Ltd.		London
68223	108476	DEG Dach-Fassade-Holz eG		Hamm-Rhynern
68224	108478	GOTOOLS GmbH		Bad Aibling
68225	108480	E.D.E. GmbH	Format" Baugeräte Arbeitskreis"	Wuppertal
68226	108488	CEF Elektrofachgroßh. Nord GmbH	Gruppenbüro Hamburg	Hamburg
68227	108490	Udo Lang	Elektrowerkzeuge	Eschau
68228	108491	Hein GmbH	Baumaschinen und Nutzfahrzeuge	Annaberg-Buchholz
68229	108493	Baustoff-Zentrum GmbH		Finsterwalde
68230	108494	AToS GmbH	Allgäuer-Tool-Service	Memmingen
68231	108498	Steffen Eisenkolb S+E	Werkzeughandel	Aschersleben
68232	108499	Tramann & Sohn GmbH & Co.KG		Oldenburg
68233	108500	MS Tools	Inhaber Markus Stolle	Allersberg
68234	108501	Wehle Werkzeuge + Maschinen		Ühlingen
68235	108503	Rothkegel Baufachhandel GmbH	NL Wolfen	Wolfen
68236	108504	Rothkegel Baufachhandel Dessau GmbH		Dessau-Roßlau
68237	108506	Fastfix Bristol Ltd. t/a Fastfix	Unit 4, Circuit 32	Bristol
68238	108508	South Western Tool Supplies Ltd.	Bell Tools	Horfield, Bristol
68239	108511	Bergmann & Franz Nachf. GmbH & CoKG		Berlin
68240	108521	Makita (New Zealand) Ltd.		Auckland
68241	108549	HTZ Handel-Technik-Zubehör	Burkhard Brede	Lippetal
68242	108551	Dachdecker-Einkauf West eG	Zweigniederlassung Lage	Lage
68243	108554	Dachdecker-Einkauf West eG	Zweigniederlassung Hagen	Hagen
68244	108556	Dachdecker-Einkauf West eG	Zweigniederlassung Krefeld	Krefeld
68245	108557	Dachdecker-Einkauf West eG	Zweigniederlassung Wesel	Wesel
68246	108558	Dachdecker-Einkauf West eG	Zweigniederlassung Solingen	Solingen
68247	108559	Dachdecker-Einkauf West eG	Zweigniederlassung Düsseldorf	Düsseldorf
68248	108560	Dachdecker-Einkauf West eG	Zweigniederlassung Fuldabrück	Fuldabrück
68249	108561	Dachdecker-Einkauf West eG	Zweigniederlassung Mülheim	Mülheim
68250	108562	Dachdecker-Einkauf West eG	Zweigniederlassung Meschede	Meschede
68251	108563	BeRo GmbH  & Co.KG		Gütersloh
68252	108564	RJ Fixings Ltd.	Unit 36C,  Inchmuir Road	Bathgate, West Lothian
68253	108572	Data Powertools Ltd.		Cardiff, WALES
68254	108573	Power Point (Northern) Ltd.	Thirsk Industrial Park	Thirsk, N.-Yorkshire
68255	108576	S & S Elektro-Fachgroßhandlung GmbH	Schmidt + Schneider	Wenden-Gerlingen
68256	108577	Voskamp Bouw en Industrie B.V.		Utrecht
68257	108578	Voskamp Bouw en Industrie B.V.		Eindhoven
68258	108579	Hofmann	Schleiftechnik	Emmerthal
68259	108581	Barnitts Ltd.		York
68260	108582	Krause GmbH	Baumaschinen - Baugeräte	Dollern
68261	108583	Arreche GmbH	Baugeräte, Industrie & Baumaschinen	Münchweiler
68262	108585	SPITZNAS Maschinenfabrik GmbH		Velbert-Langenberg
68263	108590	Baustoffzentrum Lauchhammer GmbH		Lauchhammer-West
68264	108593	Baustoff-Zentrum GmbH		Herzberg
68265	108596	Origo Distribution Ltd	C/O Masonry Fixings LTD	Dublin
68266	108599	SJ Andrew & Sons	Steel Stockholding & Eng. Supplies	Redruth, Cornwall
68267	108601	Heger GmbH		Heitersheim
68268	108602	Moser Agrar & Baufachzentrum e.K.		Schweitenkirchen
68269	108603	RKW Richard Knöchlein	Werkstatt-Technik	Deining
68270	108605	Emil Fohrer GmbH & Co.KG		Wuppertal
68271	108610	Tool & Fix Ltd.		Leigh, Lancashire
68272	108621	Phoenix Tools & Diamonds	Unit 1 Sandygate Business Park	Kingsteignton, Devon
68273	108622	Friedbert Schilke	Baustoffe - Werkzeuge	Heusweiler
68274	108626	Jürgen Rauscher	Werkzeughandlung	Eichenbühl
68275	108629	Gnädig GmbH		Lahr
68276	108632	Völkers Baustoffhandel GmbH		Kalkar
68277	108633	The Fixing Company	Unit 3 Coolmine Central	Dublin 15, IRELAND
68278	108638	Bauzentrum Szonn	Andreas Szonn GmbH	Kolkwitz
68279	108641	HG - Technik	Harald Gröger	Allmenhausen
68280	108642	CEF Elektrofachgroßhandlung Nord	GmbH Gruppenbüro Niederrhein/	Aachen
68281	108671	Bauzentrum Sommer GmbH		Eggersdorf
68282	108672	Jacob Sönnichsen AG	Baustoffe	Flensburg
68283	108674	MS Baubedarf Mario Steiner		Großfahner
68284	108678	Jacob Sönnichsen AG	Baustoffe	Neubrandenburg
68285	108682	SIG plc	Head Office	Wolverhamptom
68286	108686	Janssen Elektromaschinen GmbH		Emden
68287	108687	Pehavo - OSS		Oss
68288	108690	Jacob Sönnichsen AG	Baustoffe	Greifswald
68289	108691	Hans Papenbrook GmbH & Co.	Holztechnik	Lübz
68290	108693	Jacob Sönnichsen AG	Baustoffe	Neustrelitz
68291	108698	Carl Hinrichs e.K.	Inh. Kai Hinrichs	Augustfehn
68292	108705	Schumann Kfz-Werkstatt-Technik	Inh. Mirko Schumann	Penig OT Tauscha
68293	108708	Schrauben- & Normteile- Service	Susann Friedrich	Wurzen
68294	108711	Meyer	Schrauben & Industriebedarf e.K.	Papenburg
68295	108713	Sitebox Ltd.	Unit 19	Redhill, Surrey
68296	108717	Bussemas & Pollmeier GmbH & Co.KG		Verl
68297	108718	DCS Construction Products Ltd	Unit 6 Ebbsfleet Industrial Estate	Northfleet, Kent
68298	108720	NSB Nord-Süd Baustoffhandelsge-	sellschaft mbH & Co. KG	Bad Bramstedt
68299	108721	C Fixings Ltd.		Chadderton, Oldham
68300	108733	Petry Bauzentrum GmbH & Co.KG		Herborn/b. Idar Oberstein
68301	108734	Gebhardt Bauzentrum GmbH		Marktheidenfeld
68302	108735	Josef Thelen GmbH & Co.KG	Baumarkt und Baustoffe	Simmerath
68303	108741	Deeg GmbH	Werkzeuge-Maschinen	Velten
68304	108743	normax R. Max Radke	Technischer Bedarf u. Service	Radebeul
68305	108747	MEKOPA Diamanttechnik	Inh. Klaus Meise	Bad Zwesten
68306	108748	Thomas Rieger		Regensburg
68307	108750	A C Fixings Ltd.	Unit 8, Dukes Park Ind. Estate	Chelmsford, Essex
68308	108751	Worminghaus Baustoffh. GmbH & Co.KG	Bauzentrum	Husum
68309	108754	Ramset	A Division of ITW Australia PTY LTD	VIC 3116
68310	108758	Rollwitzer Heizung-Sanitär- und	Baustoffhandel GmbH	Rollwitz
68311	108767	Bus Handelmaatschappij B.V.		Zwolle
68312	108768	Ferdinand Wieland Großhandlung	Holz-Baustoffe-Kunststoffe	Leichlingen
68313	108770	Elektromechanik GmbH Garz	EMG	Garz/Rügen
68314	108772	Albert Leymann GmbH & Co.		Stuhr-Brinkum
68315	108773	J.N. Köbig GmbH	Bauzentrum	Eisenberg
68316	108776	Wilhelm Siemsen GmbH & Co. KG	Baustoffhandel	Eckernförde
68317	108777	Eisen Lautner e.K.		Kemnath
68318	108779	Gematecs Befestigungs- u. Montage-	technik	Hohentengen
68319	108780	Baustoff Brandes GmbH		Magdeburg
68320	108781	Te Flierhaar Sanitair B.V.		Nunspeet
68321	108782	MK Baubedarf Nord GmbH		Neumuenster
68322	108783	Black & Decker Limited S.a.r.L.		Luxembourg
68323	108785	Black & Decker  Limited BVBA	UK BRANCH	Slough, Berkshire, SL1 4DX
68324	108792	Gebrüder Löffler GmbH Baustoffe		Reichenbach
68325	108793	MSR GmbH	Baustoffhandel	Berga
68326	108796	T.P. Handel und Vertrieb	Torsten Plaul	Dresden
68327	108797	Meboldt Isolier- u.	Befestigungstechnik	Leidringen
68328	108799	Premier Services (Scotland) Ltd.		Granton, Edinburgh
68329	108800	Union Bauzentrum Hornbach GmbH		Karlsbad-Ittersbach
68330	108801	F.X. Ruch KG	Baustoffe	Messkirch
68331	108803	Hertools Werkstattservice	Inh. Mario Herold	Auerbach
68332	108810	Craighead Building Supplies	Clydesmill Grove Ind. Estate	Glasgow, SCOTLAND
68333	108811	Mobau Selbach GmbH		Rösrath
68334	108818	Portatools	Eastwood Industrial Estate	Leigh-on-Sea, Essex
68335	108822	WMS Erdmann Team GmbH		Garzau
68336	108827	Mechanical & Electrical Fixings Ltd	Bilston Glen Industrial Estate	Loanhead, Midlothian
68337	108836	Hardware & Fastener Supplies Ltd.	Unit 12, The Grange Ind. Park	Goole, East Yorkshire
68338	108840	Rudolf Krämer Eisenwaren GmbH		Duisburg
68339	108844	SIG Fixings	Federation Business Park	Dunston, Tyne and Wear
68340	108845	Bryson Products		Coulsdon, Surrey
68341	108848	Kosel GmbH	Werkzeugfabrik	Altshausen
68342	108851	WEWO Frank Wosnitza		Aalen
68343	108854	UNION Bauzentrum HORNBACH GmbH		Hauenstein
68344	108859	Erwin Hellmuth		Heilsbronn
68345	108862	Golz (UK) Limited	Unit A5	Northfleet, Kent
68346	108863	Baustoffmarkt Günding		Bergkirchen OT Günding
68347	108865	Werkzeugschleiferei M&R GmbH		Bernau
68348	108870	Direct Construction & Tunneling	Supplies Ltd.	Basildon, Essex
68349	108874	Bau-Center Neustadt-Glewe	GmbH & Co. KG	Kaliss
68350	108875	Jochen Krupp	BIT-Baufachmarkt	Waldmohr
68351	108876	Enorm IJzerhandel tðAmbachtsplein		Hazerswoude-Dorp
68352	108879	hwg-vertrieb	tools and more	Mirskofen/Essenbach
68353	108880	Hadwiger	Großhandel für Gebäudetechnik	Gersthofen
68354	108881	Eberle-Hald Handel- und Dienst-	leistungen Metzingen GmbH	Deisslingen
68355	108882	Eberle-Hald Handel&Dienstleistungen	Metzingen GmbH	Rainau-Goldshöfe
68356	108883	Eberle-Hald Handel&Dienstleistungen	Metzingen GmbH	Meckenbeuren
68357	108884	Lecot N.V. 51791		Kortrijk-Heule
68358	108886	Rocbo Boortechniek B.V.		Ruurlo
68359	108892	RB Handelsvertretungen	Ralf Baldauf	Marienberg
68360	108893	SIG Fixings Glasgow	95 Westburn Drive	Cambuslang,Glasgow, SCOTLAND
68361	108896	Faitsch OHG		Trossingen
68362	108897	A.P. Hjortso A/S		Ballerup
68363	108898	Pro Scheich	Eisenwaren	Fulda
68364	108899	Alltools Ltd.	Woodburn House	Sheffield, South Yorkshire
68365	108901	Mutzbauer GmbH & Co.KG	Befestigungstechnik	Weiden
68366	108910	Agroma GmbH & Co. KG		Uffenheim-Langensteinach
68367	108911	Saint-Gobain Building Distribution	Deutschland GmbH	Magdeburg
68368	108912	Raab Karcher Baustoffe GmbH		Stuttgart
68369	108913	Sundmäker GmbH & Co.KG		Bohmte
68370	108915	Florencio Augusto Chagas, S.A.	CHAGAS	Torres Vedras
68371	108922	Hofacker GmbH		Gelnhausen - Meerholz
68372	108925	Goldbacher Bauelemente GmbH		Goldbach
68373	108928	Metallgeno GmbH		Pasewalk
68374	108940	Zeppelin Rental GmbH & Co.KG	Zentraler Rechnungseingang	Berlin
68375	108943	Lücking Baustoffe GmbH & Co.		Bad Driburg
68376	108945	MS-Profiwerkzeuge e.K.	Matthias Schumacher	Tholey
68377	108946	Eduard Lutz Schrauben-Werkzeuge	Neuburg GmbH	Neuburg
68378	108948	Handwerks- und Industriebedarf	Hans-Otto Kuhl	Papenburg
68379	108951	Toolexpert Benelux BV	Toolstation Europe Ltd.	Bleiswijk
68380	108953	Hotze GmbH & Co.KG	Baustoffe Leese	Leese
68381	108954	Possling GmbH & Co.KG		Berlin
68382	108958	Möbius Diamanttechnik		Diesbar-Seußlitz
68383	108963	Technical Supplies Int.Co. LLC		Sohar, Sultanate of Oman
68384	108965	Rothkegel Baufachhandel	Wittenberg GmbH	Jüterbog
68385	108975	Cord Jürgen Bruns		Wardenburg
68386	108976	Kentec Tool Hire	Unit 2 Riverdale Estate	Tonbridge, Kent
68387	108978	Stanze & Kuhlmann GmbH		Peine
68388	108980	MSR Bauzentrum Berka		Berka
68389	108981	Andre Köhler	Werkzeughandel + Schärfdienst	Erfweiler
68390	108982	Wocken Industriepartner	GmbH & Co.KG	Emden
68391	108984	Stockbrink & Offermanns GmbH	Werkzeuge & Maschinen	Niederkrüchten
68392	108986	BB-Technik s.r.o.		Banská Bystrica
68393	108987	Essex Fasteners	Division of Orbital H.S. Ltd.	Wickford, Essex
68394	108989	UNION Bauzentrum HORNBACH GmbH		Kapellen-Drusweiler
68395	108990	Schachenmeier GmbH		Efringen-Kirchen
68396	108998	Staufen Baumaschinen GmbH		Göppingen
68397	109000	Bell Tools		Gloucester
68398	109001	Krapp Eisen GmbH & Co.KG		Aurich Sandhorst
68399	109002	Krapp Eisen GmbH & Co.KG		Westerstede
68400	109015	Stephan Heinitz		Kleinheubach
68401	109017	Schultz Bauzentrum GmbH & Co. KG		Speyer
68402	109022	Bauzentrum Teichmann GmbH		Geithain
68403	109026	Ramset New Zealand		GLENFIELD - AUCKLAND 1330
68404	109028	Steelrex Limited		Moskau
68405	109045	Heß - Hydraulik		Roding
68406	109046	Garms Baustoffe GmbH & Co.KG		Dötlingen-Aschenstedt
68407	109051	Garms Baustoffe GmbH & Co.KG		Ganderkesee
68408	109053	MP Building Supplies Co Ltd.	Rail Arch	Bethnal Green, London
68409	109054	Wilhelm Siemsen GmbH & Co.KG		Schleswig
68410	109055	Bauzentrum Gebr. Löffler GmbH		Reinsdorf b. Zwickau
68411	109058	VON DER HEYDT GMBH		Speyer
68412	109065	BAUKING Weser-Ems GmbH	Niederlassung Quakenbrück	Quakenbrück
68413	109066	Raiffeisenhandelsgesellschaft	Strasburg m.b.H.	Strasburg
68414	109069	E.D.Elson Ltd.	Builders & Timber Merchants	St. Albans
68415	109071	Wilhelm Kruel e.K.	Autoteile - Industriebedarf	Idar-Oberstein
68416	109074	Fourmost Fixing Ltd.		Rochester
68417	109078	Werkzeug Nord		Rhauderfehn
68418	109080	ERIKS Deutschland GmbH		Bielefeld
68419	109084	Zeppelin Rental GmbH & Co.KG	Mietstation Rostock West	Rostock
68420	109085	Zeppelin Rental GmbH & Co.KG	Mietstation Greifswald	Greifswald
68421	109087	Zeppelin Rental GmbH		Neubrandenburg
68422	109088	Martin Bauservice Ltd.		Sinn Fleisbach
68423	109089	Chas. Lowe & Sons	(Builders Merchant) Ltd	Knebworth, Herts.
68424	109091	Heinrich Deeken	Eisenwaren Baubeschläge Werkzeuge	Cloppenburg
68425	109093	Fixings Tyne Tees	Fixings Group	Hartlepool
68426	109094	Bury Fixings Group	Premier House, Telford Way	Colchester, Essex
68427	109095	Breur Ijzerhandel Gouda B.V.		Moordrecht
68428	109102	MCP Group Ltd.		Northfield, Aberdeen
68429	109105	Armagrip	Advance House	Ferryhill, Co Durham
68430	109107	FEGA & Schmitt Elektrogroßhandel	GmbH	Ansbach
68431	109108	Baugema Baumaschinen GmbH		Rostock-Pastow
68432	109110	Bison Industrial Limited		Botley
68433	109112	Handelshof Bautzen GmbH	Filiale Görlitz	Görlitz
68434	109113	Handelshof Bitterfeld GmbH		Halle
68435	109114	Handelshof Chemnitz GmbH	Partner für Technik	Chemnitz
68436	109115	Handelshof Riesa GmbH	Filiale Döbeln	Döbeln
68437	109116	Handelshof Riesa GmbH		Dresden
68438	109117	Handelshof Riesa GmbH	Filiale Großenhain	Großenhain
68439	109118	Handelshof Riesa GmbH	Partner für Technik	Oschatz
68440	109119	Handelshof Stendal GmbH		Pritzwalk
68441	109120	Handelshof Vorpommern GmbH		Greifswald
68442	109121	Handelshof Vorpommern GmbH	Filiale Stralsund	Stralsund
68443	109122	Rudolf Sievers GmbH	Partner für Technik	Buxtehude
68444	109123	Rudolf Sievers GmbH	Partner für Technik	Hamburg-Eidelstedt
68445	109124	Formed Group Ltd.	Unit 2 Crofton Road	Lincoln
68446	109127	Finlex International Ltd	Bunkell Road	Norwich
68447	109135	bhv quattro	die passende Lösung	Saarbrücken
68448	109137	Karl-Hermann Eichfelder		Bamberg
68449	109138	i & M Mietservice &	Containerdienst GmbH & Co.KG	Simmerath
68450	109141	Dröge + Leifert GmbH & Co.KG		Werl
68451	109143	Gerwens Fachcenter GmbH		Gronau
68452	109145	Fidel Schub GmbH & Co.KG		Viechtach
68453	109148	Weber Stahlhandel GmbH		Bad Kreuznach
68454	109149	Millcot Tools	The Mill	Danbury, Essex
68455	109151	Fixmart		Kent
68456	109153	Welfix		Shrewsbury
68457	109163	BHG Handelszentren GmbH		Luckau
68458	109166	Fixfirm		Lincoln
68459	109167	Handwerks- u. Industriebedarf GmbH		Schwarzheide
68460	109169	Henrich Baustoffzentrum		Kastellaun
68461	109171	Fixfast Ltd.	Teal House, 23A Greenbank Ind. Est.	Co Down Northern Ireland
68462	109173	Search Workshop Supplies LTD		Londonderry
68463	109177	Dörfelt GmbH		Zwickau
68464	109178	Joachim Kaltwasser	Montagetechnik	Nordhausen
68465	109179	Bison Machinery Ltd.		Stafford
68466	109182	SANPROFI	Fliesen-Sanitärfachhandel	Saalfeld
68467	109183	OOMS IJzerwaren NV		BALEN
68468	109185	Stabilo-Wetterauer GmbH		Sinsheim
68469	109186	Asamco CV		Bornem
68470	109188	Iliaens NV		Alken
68471	109191	Galler Metalen NV		Antwerpen
68472	109192	Baustoffzentrum Modernes Bauen GmbH	Oelsitz	Riesa
68473	109193	ERIKS NV		Mol
68474	109194	De Draaiboom Gereedschappen NV		Antwerpen
68475	109199	Mapeco Wommelgem N.V.		Wommelgem
68476	109200	Zeppelin Rental GmbH	Mietstation Magdeburg	Magdeburg
68477	109201	Stahlwille	Eduard Wille GmbH & Co.KG	Wuppertal
68478	109202	VAN SPIJK B.V.		Oirschot
68479	109205	Ets JEAN LOBET sprl		Marche-en-Famenne
68480	109206	Baufachzentrum Wittenberge	Zwgndl.d.Baufachz.Falkenhagen GmbH	Wittenberge
68481	109207	H. Rießelmann GmbH		Molbergen
68482	109209	Saxonia Baustoffe GmbH	c/o Raab Karcher Baustoffe GmbH	Magdeburg
68483	109210	ITT-Bulgaria LLC		Stara Zagora
68484	109211	BV DEMA-SHOP	Declerco Marc N.V.	Roeselare
68485	109216	NV Gebroeders Van Den Abbeele		Lokeren
68486	109220	REWORKS bvba		Peer
68487	109221	Jacob Sönnichsen AG	Baustoffe	Pasewalk
68488	109225	E.I.S. PVH GmbH & Co. KG		Köln-Ossendorf
68489	109228	Steenhoff Baugeräte GmbH & Co. KG		Rhauderfehn
68490	109230	Beoman Oy		Espoo
68491	109232	De Kinder Hardware BVBA		Buggenhout
68492	109237	Unimet Zentrallager Süd	GmbH & Co. Handels KG	Burgthann / Ezelsdorf
68493	109238	EKV-Nord GmbH & Co.KG		Nordhorn
68494	109239	Bau-Maschinen und - Geräte GmbH	Ing. Herbert Dressler	Güstrow
68495	109243	Selkent Fastenings Ltd.	Osprey House	Orpington, London
68496	109244	THEUNISSEN N.V.		GENK
68497	109246	Ruhland-Kallenborn & Co. GmbH	Baustoffhandel	Gersheim
68498	109248	PWP Industrial	Jaguar House	Bedford
68499	109250	MOORS N.V.		Hasselt
68500	109253	Top Gun Tools & Fixings	Trident Business Park	Blackpool
68501	109255	LIETAR OUTILLAGE SA	SA LIMA PROJECTS	La Louvière
68502	109258	Brans Gereedschappen		Lommel
68503	109259	SA Etablissements Jean Collas		Büllingen
68504	109266	GROCO C.V.B.A.		LOCHRISTI
68505	109270	Gillet Baumarkt GmbH	Fil. Herxheim	Herxheim
68506	109276	Wilkhas nv		GRIMBERGEN (BEIGEM)
68507	109277	Frank Rieger	DIAMANT am BAU	Hamburg
68508	109278	VSA Belgium NV		Geel
68509	109281	Bau- & Handwerkerbedarf GmbH		Weyhe
68510	109285	Bauexpert GmbH & Co. KG		Babenhausen
68511	109291	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Bamberg
68512	109295	Seven Day Tools	Abercynon	Mid Glam , South Wales
68513	109300	Otto Röhrs GmbH	NL Soltau	Soltau
68514	109301	Karch Maschinen- und Befestigungs-	technik GbR	Dietfurt
68515	109303	RS Machine Tools	DenmoreIndustrial Estate	Aberdeen , Scotland
68516	109305	Pro-Fix CP Ltd.		Horley, Surrey
68517	109306	Compania Distribuidora de Pernos	y Afines S.R.L.	La Molina, Lima
68518	109307	NV Maldoy		SINT KATELIJNE WAVER
68519	109308	Ruf Baustoffe GmbH	Beton und Fertigbau	Wilburgstetten
68520	109310	Synergy	Electrical & Mechanical Products	Hoddeston
68521	109312	Jakob Küng AG	Befestigungstechnik	Bad Ragaz
68522	109313	Neo-Select A/S	Postboks 45	Lierskogen
68523	109314	E. G. Kistenmacher GmbH & Co. KG		Hamburg
68524	109320	Emmson Supplies Ltd.		Staffordshire
68525	109321	Diatech Scotland	Apex House	Perth
68526	109323	Brockhaus Baubedarf GbmH		Rheda-Wiedenbrück
68527	109325	MAG 45 B.V.		Eindhoven
68528	109327	PELZER TOOLS SA	Werkzeug & Zubehör	Eupen
68529	109329	Normteile Ehret GmbH	KFZ-Werkzeuge	Breisach
68530	109330	Otto Röhrs GmbH	NL Verden/Aller	Verden
68531	109331	Toolfix Joinery & Construction	Supplies Limited	Peterborough, Cambridgeshire
68532	109332	AES Industrial Supplies Limited		Didcot
68533	109334	STARK Building Materials UK Ltd	Binley Business Park,Merchant House	Coventry
68534	109336	HTI Thüringen Handel KG	Fachgroßhandel	Erfurt
68535	109337	HTI Thüringen Handel KG	Niederlassung Mossbach	Triptis
68536	109338	Hopster Bau GmbH & Co.KG		Fürstenau
68537	109341	Baumaschinen und Geräte-	vermietung OHG	Groß Lüdershagen
68538	109342	Wilhelm Stark	Baustoffe GmbH	Tuttlingen
68539	109343	Westendorf & Oppermann	Tessiner Baustoffhandel GmbH	Tessin
68540	109345	DESAIR N.V. GEREEDSCHAPPEN		OVERPELT
68541	109346	Wertheimer Betonfertigteile GmbH	Baustoffe	Baden-Baden
68542	109347	Kraft Baustoffe GmbH		München
68543	109348	Voskamp Bouw en Industrie B.V.		Apeldoorn
68544	109350	GefA Stahl- und Metallbau GmbH		Wilhelmshaven
68545	109353	MARCO BV		Herselt
68546	109356	WS-Norm	Inh. Ralph Brüderlein	Georgensgmünd
68547	109357	Ernst Blanke Baustoffe GmbH & CoKG		Wunstorf
68548	109359	Schneider & Rüseler	Technischer Handel GmbH	Hagen
68549	109362	AGO Druckluft MVS GmbH		Berlin
68550	109371	Ehning Baustoffhandel GmbH		Borken-Weseke
68551	109373	KOCKELBERGH NV	GEREEDSCHAPPEN	TEMSE
68552	109377	Lerou ijzerwaren N.V.		BRUGGE
68553	109378	Toolspot BVBA	Celine Dewulf	OOSTENDE
68554	109381	EWM Menschel GmbH		Gifhorn
68555	109382	WE-Di-Ma	Inh. Olaf Braunsdorf	Riesa
68556	109383	MietTeufel		Oldenburg
68557	109384	C. u. D. Bargen	Holz u. Baustoff GmbH	Jever
68558	109386	Jacob Sönnichsen AG	Baustoffe	Kölpinsee
68559	109388	Hornbach Union Bauzentrum		Baumholder
68560	109390	Tornado Fixings Ltd.	c/o Woodside Ind. Estate	Ballymena, Co Antrim
68561	109400	RuW Industriebedarf oHG		Köln
68562	109401	Van den Broeck-Beenckens NV	tav. Rob Adams	Herenthout
68563	109402	Handelshof Stendal GmbH	Partner für Technik	Magdeburg
68564	109411	Karl Sommer	Maschinen & Werkzeug Fachhandel	Söchau
68565	109412	Manfred Papperitz	Werkzeug und Industriebedarf	Bannewitz
68566	109414	Schmahl GmbH	Eisenwaren - Werkzeuge	Koblenz
68567	109416	HBS Technische Groothandel B.V.		DIEMEN
68568	109417	Frank Papperitz	Industrievertretungen	Pirna
68569	109418	Benz GmbH & Co.KG	Baustoffe	Neckarbischofsheim
68570	109419	HWV	Werkzeugvertrieb Hamburg GmbH	Hamburg
68571	109425	ITS Fischer UG		Parchim
68572	109427	Baufachmarkt Bracher GmbH & Co. KG		Monheim
68573	109428	Gebrüder Löffler GmbH Baustoffe	Filiale Petersberg	Petersberg
68574	109430	Gebr. Schweder Baustoffhandels GbR		Plau am See
68575	109432	Lorenz Innecken	Eisenwaren - Werkzeuge - Beschläge	Wismar
68576	109434	Böhm GmbH Brandenburg & Co.	Fliesen- und Baustoffhandel KG	Kloster Lehnin OT Rietz
68577	109436	Otto Röhrs GmbH		Sottrum-Hassendorf
68578	109437	Einkaufsbüro Deutscher      CIRCUM	Eisenhändler GmbH	Wuppertal
68579	109438	City Tool Hire Ltd.	Laurie Bedford 020 8574 3523	Southall, Middlesex
68580	109442	Stang GmbH & Co. KG		Miesbach
68581	109446	Meier Baustoffe GmbH		Amberg
68582	109447	SRL QUINCAILLERIE DENIS		Saint-Ghislain
68583	109450	Hogenhout Bouw Service		Badhoevedorp
68584	109451	A WIJNANT NV		Geraardsbergen
68585	109458	Direct Tool Company	Castle Hill Farm	Southampton, Hampshire
68586	109459	Toolman Yardley		Yardley, Birmingham
68587	109461	ASK Kloska GmbH	Techn. Ausrüster/Arbeitsschutz	Wilhelmshaven
68588	109462	Zeppelin Rental GmbH & Co.KG	Shop Lübeck	Lübeck
68589	109463	Woodcraft 82		Pyle, NR Bridgend
68590	109472	Bruno Heinen AG		Bütgenbach
68591	109473	Zeppelin Rental GmbH & Co.KG	Shop Wuppertal	Wuppertal
68592	109480	Diamond Direct Supplies		Gravesend, Kent
68593	109481	Stabilo GmbH		Empfingen
68594	109482	BMF HOLLAND b.v.		OOSTERHOUT
68595	109485	Outillage Nourisson Claude	RISS	Montbrison Cedex
68596	109488	Lauer GmbH		Herbrechtingen
68597	109498	BBT	Bohr-+ Befestigungssysteme AG	Bösingen
68598	109500	MBB Hensch + Spindler GmbH		Göppingen-Ursenwang
68599	109503	NL Raab Karcher Che.-Röhrsdorf	STARK Deutschland GmbH	Chemnitz Röhrsdorf
68600	109505	Toolexpert OY		Helsinki
68601	109512	Aichinger GmbH		A-Pasching
68602	109515	ERIKS bv		Rotterdam
68603	109518	Zeppelin Rental GmbH & Co.KG	PROFI-BauSHOP Dortmund	Dortmund
68604	109519	Tukkumyynti Mikko Keskinen OY		Tuuri   FINLAND
68605	109522	Handelsonderneming	P.Visser en Zonen B.V.	Raamsdonksveer
68606	109524	Dymatec Ltd.		Houghton Regis,Bedfordshire
68607	109526	Elektro Lörler GmbH		Mainz
68608	109531	Blumenstock	Inh. W. Joas e.K.	Fellbach-Schmiden
68609	109533	Frantos GmbH & Co. KG		Heubach
68610	109536	Weldi		Wyry (Katowice) POLEN
68611	109539	Jacob Cement Baustoffe		Harrislee
68612	109540	Reifenberg Service verbindet e.K.		Hüblingen
68613	109542	Seiler Baustoffhandel GmbH		Thonhausen
68614	109545	Rothkegel Baufachhandel	Wittenberg GmbH	Luth. Wittenberg
68615	109548	Prinz Deutschland GmbH	Maschinen und Werkzeuge	Haselbachtal
68616	109549	Thomschke Baumaschinen		Pulsnitz
68617	109550	StaBe Baubedarf		Anger
68618	109551	A. Leymann GmbH & Co		Porta Westfalica
68619	109552	Carl-Arnold Brill GmbH	c/o Hild- Löbbecke GmbH	Bottrop-Kirchhellen
68620	109553	Armafix Ltd.	Units 3-4	Leeds
68621	109555	August Büssing GmbH		Emstek
68622	109557	Palmaers Vakhandel NV		Bilzen
68623	109559	Kraft Baustoffe GmbH	NL Höhenkirchen	Höhenkirchen
68624	109562	Precisia Metior s.r.o.		Mohelnice
68625	109567	Thurrock Engineering Supplies LTD	Unit 1,	Grays, Essex
68626	109569	TrendHaus	Reiner Bromm	Brackenheim
68627	109571	MÜLLER & CO.	Werkzeug-Handelsgesellschaft mbH	REMSCHEID
68628	109572	NG Werkzeughandel GmbH		Neuss
68629	109573	E/D/E GmbH	Fachkreis Baugeräte	Wuppertal
68630	109574	Eredi Franchi - Idea3 SRL		Pasiano di Pordenone (PN)
68631	109575	RBB Baustoffe & Baumaschinen GmbH		Dresden
68632	109578	Bernd Stünn GmbH & Co. KG	Baustoffhandel	Herdorf/Sieg
68633	109584	Der Schraubenladen	Inh. Margarete Schulz e.K.	VS-Villingen
68634	109585	Castle Brooke Tools (UK) Ltd.		Sheffield
68635	109587	Marks GmbH & Co.KG		Schleswig
68636	109588	Theisen + Kahl OHG	Oberflächen Partner	Andernach
68637	109590	Zeppelin Rental GmbH & Co.KG	Zentrale - Profi Baushop	Garching
68638	109591	Kraft Baustoffe GmbH	NL Wolfratshausen	Höhenkirchen
68639	109592	RHG Mittelsachsen eG	RHG Baustoffe	Rossau
68640	109595	Baufachhandel Podlaha		Großschirma
68641	109599	Matuszyk Wies?aw Eugeniusz		Wien
68642	109600	Kammer & C SRL		Vimodrone, Italy
68643	109601	PRO - LINE S.A.		Petange
68644	109603	Gebr. Fürstenberg GmbH	NL Friesack	Friesack
68645	109605	J&M Supplies & Construction LTD	Unit 3	Crayford, Kent
68646	109610	MICHEL	Schweisstechnik- Technische Gase	Bad Frankenhausen - OT Ringleb
68647	109612	Wizner Building & Fencing Supp Ltd		Kibbutz Usha ISRAEL
68648	109615	SIGF Wolverhampton		Wolverhampton, West Midlands
68649	109618	Baumaschinen van der Walle GmbH		Bocholt
68650	109621	Freeway Tools and Fixings Ltd.		Burgess Hill, West Sussex
68651	109622	Zentraleinkauf Baubedarf	ZEB GmbH & Co KG	Paderborn
68652	109624	Meier Baustoffe GmbH		Lauf a.d. Pegnitz
68653	109625	Meier Baustoffe GmbH		Schnaittenbach
68654	109626	Meier Baustoffe GmbH		Sulzbach-Rosenberg
68655	109627	bauXpert GmbH		Bad Bramstedt
68656	109630	Dullaert-Steenhout BVBA		Ninove
68657	109631	Eurobaustoff Handelsges.mbH & Co.KG	Einkauf Regional Ost	Petersberg OT Wallwitz
68658	109632	Nüßing GmbH	Niederlassung Berlin	Berlin
68659	109635	Meier Baustoffe GmbH		Weiden
68660	109640	Bauzentrum	Wiek & Co.GmbH	Erwitte
68661	109641	Meier Baustoffe GmbH		Neumarkt
68662	109643	HEKA THOMAS HENTSCHEL		Crimmitschau
68663	109645	MKT Metall-Kunststoff-Technik	GmbH & Co. KG	Weilerbach
68664	109646	TWH Trierer Werkzeughandel GmbH		Trier
68665	109647	Smiths Equipment Hire Ltd		Avroe Crescent,Blackpool
68666	109648	Zeppelin Rental GmbH & Co.KG	Shop Hamburg-Harburg	Hamburg
68667	109650	F. X. Ruch KG		Stühlingen
68668	109653	Union Bauzentrum Hornbach GmbH		Merzig
68669	109656	Rite-Fix Ltd.	Unit 29,  Highlands Road	Solihull
68670	109657	Schneebecke & Dorn + Co. GmbH		Kolbermoor
68671	109658	Witschel GmbH	Baustoffhandel	Großenhain
68672	109659	Lapwing UK Ltd	Unit 3	Pershore
68673	109661	ETACO	ENG. AND TRADING COMP.	6 OF OCTOBER CITY-GIZA EGYPT
68674	109663	SGBD Deutschland GmbH	NL Raab Karcher	Bingen Sponsheim
68675	109664	Klaassen GmbH		Uplengen-Hollen
68676	109667	Zeppelin Rental GmbH & Co.KG		Stuttgart
68677	109674	Wilhelm Gienger KG	Fachgroßhandel für Haustechnik	Tiefenbach
68678	109675	Hans Bohner GmbH & Co.Kg	Eisen- und Sanitärgroßhandel	Oettingen i.Bay.
68679	109678	BBS Matthias Landgraf		Dresden
68680	109682	Maier + Kaufmann GmbH		Offenburg
68681	109684	Issler + Pütz		Grenzach-Wyhlen
68682	109688	Mesatec S. Meerpohl	Werkzeug- & Maschinenhandel	Friesoythe-Kampe
68683	109692	Peter Herr	Werkzeuge & Maschinen	Baden-Baden
68684	109697	Lahrmann tech. Handel	GmbH & Co.KG	Dinklage
68685	109701	Lampfix		Hertfordshire
68686	109702	Zeppelin Rental GmbH	miete.chemnitz-roehrsdorf(at)	Chemnitz-Röhrsdorf
68687	109703	Thomas Bührmann	Allgemeiner Handel und Vertrieb	Bakum
68688	109706	Union Bauzentrum Hornbach GmbH		Losheim
68689	109707	Handelskontor Seevetal GmbH	Partner für Technik	Seevetal-Maschen
68690	109708	RSW Handels GmbH	LIMITED LIABILITY COMPANIES	Bautzen
68691	109710	Strut Direct Ltd.		West Midlands
68692	109713	Huis A. Suys IJzerwaren		Menen-Lauwe
68693	109714	Wassink b.v.		VAASSEN
68694	109716	Och GmbH		Nürnberg
68695	109722	Andreas Galler	Diamanttechnik & Spezialwerkz.	Waldhufen / OT Jänkendorf
68696	109723	wolfcraft SK s.r.o.		MALÉ DVORNÍKY
68697	109724	Holzzentrum Wöhlk Cottbus	GmbH & Co. KG	Cottbus
68698	109725	Alliance Fixings Systems Ltd.	Unit 6D Glover Ind. Estate	Washington, Tyne & Wear
68699	109726	Erika Luxem Handelsgesellschaft	mbH	Elsenfeld
68700	109731	Powers Peruana SAC	RUC 20511082219	Lima
68701	109733	TOX-Dübel Technik GmbH		Krauchenwies-Ablach
68702	109735	Channel Commercials PLC		Kent
68703	109739	Diaquip		Bredbury, Stockport
68704	109740	W & F Baustudio	Wilken & Fedtke OHG	Güstrow
68705	109743	Suffolk Fasteners UK	Unit 38	Ipswich, Suffolk
68706	109747	Riverside Hardware & Eng. Supplies	Unit 3c North Road	Bridgend
68707	109749	BAUKING Weser-Ems GmbH	Niederlassung Natrup-Hagen	Natrup-Hagen
68708	109750	GEN NEXT TOOLS		Mumbai
68709	109753	Lehmeier Sandra e.K.	Baumaschinen	Ludwigshafen
68710	109755	Blank & Seegers KG		Nohra
68711	109756	De Bouwhof B.V.		Zoetermeer
68712	109757	Direct Building Products Ltd.		Bradford
68713	109758	Technical Fixings Solutions LTD	Unit E2, LOC8 Business Park	Hollingbourne, Kent
68714	109759	Landmaxx BHG GmbH		Radebeul
68715	109761	Bau- & Kommunalservice Wegner		Waren
68716	109765	Oßwald Fahrzeugteile & Technischer	Handel GmbH & Co. KG	Mühlhausen
68717	109766	SPIT SAS	Division RED HEAD	PARIS
68718	109768	FERRINET SAS		Santafe do Bogota, DC Bogota
68719	109772	OBAS UK	Chappel Hill Ind. Estate	Preston, Longridge
68720	109774	Sheffield Windows		Sheffield
68721	109776	Mawill S.a.r.l.		Diekirch
68722	109781	Zimmer & Söhne GmbH		Erkelenz
68723	109782	Leitermann GmbH & Co.	Fachmarkt KG Niederl. Glauchau	Remse / OT Weidensdorf
68724	109783	Deuschle Industriebedarf GmbH	Partner für Industrie & Gewerbe	Uhingen
68725	109788	Handelshof Riesa GmbH	Partner für Technik	Meißen
68726	109791	SUALPE                  TRYUN BRAND	Suministros Alonso Pellicer, S.L.	Madrid
68727	109793	Franklin Industrial Supplies Ltd.	Unit 11	Kings Lynn, Norfolk
68728	109794	Schneider	Handelsvertretung	Pyrbaum-Seligenporten
68729	109795	Onesite	Unit 9, South Lowerstoft Ind. Est.	Lowerstoft, Suffolk
68730	109796	Mobau Wirtz & Classen	Baufachhandel GMbH & Co.KG	Hückelhoven
68731	109801	KraSaTec GmbH		Oettersdorf
68732	109802	ZEUS Zentrale für Einkauf u.	Service GmbH & Co.KG	Soltau
68733	109805	Specht Betriebsausstattung GmbH		Rotenburg ( Wümme)
68734	109809	EGU Elektro Großhandels Union	Rhein-Ruhr GmbH & Co.KG	Dortmund
68735	109811	Alpha Wholesale	Orchard Business Park	Tonbridge, Kent
68736	109813	Austinat Werkstattbedarf		Rudolstadt
68737	109815	Unimet Zentrallager West	GmbH & Co. Handels-KG	Hachenburg
68738	109816	Makita Africa	Zone Franche Logistique Port Tanger	wilaya de Tanger
68739	109820	BIV Bau- u. Industriegeräte	Vertriebs GmbH	Bindlach
68740	109821	Müller + Schnigge		Schleiden-Gemünd
68741	109823	U.K. Fixings Limited	Unit 5-6	Sheffield
68742	109824	Sandach Befestigungstechnik GmbH		Essen
68743	109826	Jepsen Handel e.K.		Flensburg
68744	109827	Eelen BV		Kasterlee
68745	109828	Wack Builders Wholesale LTD		Cramlington,Northumberland
68746	109829	Wocken Industriepartner	GmbH & Co. KG	Braunschweig
68747	109830	Bau- & Brennstoffe Bender	Inh. Echard Bender e.K.	Morsbach
68748	109831	BMG Baustoffe		Coburg
68749	109835	NV SERCOMAT		Arendonk
68750	109839	RAAHEN PULTTI OY		Raahe
68751	109840	Baustoff Netzband GmbH		Genthin
68752	109842	HEPT Co., LTD		Nowon-gu, Seoul
68753	109846	Maier + Kaufmann		Lahr
68754	109848	Schröder Bauzentrum GmbH & Co.KG		Itzehoe
68755	109852	Kajaanin Konekymppi		Kajaani
68756	109855	Union Bauzentrum Hornbach GmbH		Landstuhl
68757	109857	Internet Logistical Solutions Ltd	Little Bramleys	East Sussex
68758	109859	Gebr. Mayer GmbH & Co.KG	Niederlassung Sachsen	Chemnitz
68759	109863	Technischer Handel	Raymund Pfeiffer	Leipzig
68760	109868	Beate Schaitanow		Markkleberg
68761	109875	Hans Bohner GmbH & Co.	Eisengroßhandel	Treuchtlingen
68762	109876	Norbert Förster	Betreutes Bohren	Dinkelsbühl
68763	109879	SIG Fixings Leeds		Leeds, West Yorkshire
68764	109883	Veens Techniek B.V.		Druten
68765	109890	VD Gereedschappen		Zwalm
68766	109892	DEG Dach-Fassade-Holz eG	Essen	Essen-Frillendorf
68767	109893	Lahden Työkalupiste Oy	TOOLPOINT	Lahti
68768	109894	Suomen Kiinnikekeskus OY		Pori
68769	109895	Praetner GmbH & Co. Handels-KG		Freising
68770	109899	ZEDEV Einkauf und Service AG	MARKE HELLER	ZÜRICH
68771	109901	Weniger GmbH	Elektrogroßhandel	Cunewalde
68772	109906	SPIRA Baugeräte- und Schalungs-	logistik GmbH	Speyer
68773	109908	Chr. Seraphim (Agencies) LTD	Mr. Chrysostomos Chrysostomou	Alambra Cyprus
68774	109909	Siebels GmbH & Co. KG		Norden
68775	109912	Martin Palme (Privat)	The Winnetka Unit 5B	Bangkok
68776	109915	PTG Präzisionstechnik	Handelsgesellschaft mbH	Hagen
68777	109917	CID Group	CID House,Peckfield Business Park	Leeds
68778	109919	John Murphy (Castlerea) Ltd	IDA Business Park	Castlerea, Co. Roscommon
68779	109920	Novasolv Ltd		Loughgall
68780	109924	GS-TOOLS	Elektrowerkzeuge u. Industriebedarf	Dresden
68781	109925	Power Tool Warehouse		Royton, Oldham
68782	109926	Gebr. Fürstenberg GmbH	Niederlassung Rhinow	Rhinow
68783	109927	Schrauben Seidel	Inh. Steffen Seidel	Schönheide
68784	109930	W&S Werkzeug und Schrauben GmbH		Rödermark
68785	109932	ITA Overseas Pte Ltd		Singapore 408938
68786	109935	Straufhainer Schraubenhandel	Petri GmbH	Straufhain
68787	109937	SteelRex Georgia LLC		Tbilisi Georgia
68788	109938	Raiffeisen-Handelsgenossenschaft	Mittelsachsen eG	Leisnig
68789	109941	Dachdecker-Einkauf Ost eG	Zentrale	Braunschweig
68790	109942	Dachdecker-Einkauf Braunschweig		Braunschweig
68791	109944	Achenbach & Gauer GmbH		Rockenhausen
68792	109947	AVANTI Svenska försäljnings AB	Mats Ahlberg	Vallentuna
68793	109948	Venanz Fischer Baustoffzentrum	Inh. Alois Fischer e.K.	Kronach-Friesen
68794	109950	SCP Building Products Ltd.		Totnes, Devon
68795	109951	OWI Sargans AG	c/o Stierlin AG	Schaffhausen
68796	109955	Rothenburger Bauzentrum Pehl GmbH		Rothenburg o.d.T.
68797	109958	ZEDACH eG		Hamm-Rhynern
68798	109962	Eder GmbH	Profi Fachmarkt	Bad Endorf
68799	109963	Profi-Eder Fachmarkt		Wasserburg
68800	109964	Theo Förch GmbH & Co. KG		Schwerin
68801	109967	JIT Industrial Consumables	Unit 5, Manorcrest Court	Lincolnshire (GB)
68802	109970	Dachdecker- und Baustoff-Eink.	Zweigniederlassung Fehrbellin	Fehrbellin
68803	109971	Joachim Hochberger	Maschinen u. Werkzeuge	Bad Endorf
68804	109972	Toolstation (Redditch) Ltd	Arrow 3, Arrow Valley	Redditch
68805	109975	Express Fixings & Fittings Ltd.	Unit 32k & 33k	Isle of Man
68806	109978	CMS Consumables Ltd.	29 St. George Hill	Perranport, Cornwall
68807	109979	INTERNATIONAL GROUP AP SUALPE	MÖVE-DÜBEL  phone: 34 676 360612	Madrid
68808	109980	Nordwest Handel AG	Lager Promat	Dortmund
68809	109982	Müller & Schnigge OHG		Jüterbog
68810	109985	Fixings Plus		Aston, Birmingham
68811	109986	V.J. Technology Ltd.- VJT BRAND	Technology House	Ashford, Kent
68812	109987	Gustav Herbstreuter GmbH & Co. KG		Simmern (Hunsrück)
68813	109988	HOBTEC Industrievertretungen	Inh. Frank Hoberg	Bremen
68814	109990	Wiedemann GmbH & Co.KG		Sarstedt
68815	109994	VOS TOOLS BVBA		Brecht
68816	109996	KGS Winter GmbH		Dortmund
68817	109998	DE IJZERWINKEL		Aarschot
68818	109999	TCG Allgemein Intern	Samira Merino	Dinklage
68819	120001	DEWITT TOOL CO INC		Miami
68820	150000	Quimica Peruana sac	Ruc: 20481388610	Aranjuez, Trujillo
68821	150001	A. Aivazoglou P. Dalaglis A.E.		Thessaloniki
68822	150002	Amanav Marketing Ltd.		San Fernando
68823	150003	A S P	Abrasives & Screw Products Limited	Merseyside, L37 4AQ
68824	150004	ALLMEDIA spol. s. r. o.		Bratislava
68825	150005	Auro - Befestigungssysteme GmbH		Wels
68826	150006	Uždaroji akcin? bendrov? "Anjes?"		Kauno
68827	150007	Abcon Industrial Products Limited	attn. Mr. Paul Gilsenan	Cootehill, Co Cavan
68828	150008	Hirtenfellner GmbH		Premstätten
68829	150009	SAS ALPHA COUPE FRANCE		SCHWEIGHOUSE SUR MODER
68830	150010	AROA, S.A.	Phone 1 809 241-1689	Santiago República Dominicana
68831	150011	Armacell Austria GmbH		Gödersdorf
68832	150012	Gerontis E. & Sons Ltd.		Rhodos
68833	150013	Al Daaem Est.	Hardware Tools	Jeddah 21532
68834	150014	A.V.V. Management BV		VA Gemert
68835	150015	Serracon Limited	DART Tool Group	Kirkcaldy
68836	150016	ANDREAS THEOPHILOU	COMMISSION AGENT	NICOSIA
68837	150017	SERCO	attn. Mr. Hatem El Gamal	Cairo
68838	150018	AURORA	Magdalena Caputa	Paczków
68839	150019	APEX OILFILD SUPPLIES	Tel.: (+20)2-27 04 65 00-2518 04 97	New Maad Cairo, Egypt
68840	150020	Andimar OÜ		Tartu
68841	150021	Ets. TECH Electric		BEIRUT
68842	150022	Ajetikarosserieteile	Arben Ajeti	Mägenwill
68843	150023	High Force	Engineering Solutions Ltd.	Amman
68844	150024	Alrokey For Industrial Marketing	Attn. Nabil	CAIRO
68845	150025	Amos Industries Australia		Parkinson 4115 Brisbane, Queen
68846	150026	Jassim Mohammed Abdulrehman	Al-Bahar Industries W.L.L.	Safat - 13020 Kuwait
68847	150027	Thomas Baumgartner	Meinrad	Bad Mitterndorf
68848	150028	Baccina 2004 s.r.l.		Roma
68849	150029	Bader Maschinen GmbH		Vomp
68850	150030	Bata Trading & Contracting Co.		AMMAN
68851	150031	SASU BATI DIAM	Christophe THIEVENAZ	DOLOMIEU
68852	150032	SIA "B-BALTIC"		Riga
68853	150033	Exacon Group		Broadmeadows VIC 3047
68854	150034	AAP Group Scandinavia AB		LJUNGBY
68855	150035	ABC Tools S.p.A.		Cologno Monzese (Mi)
68856	150036	Borgh B.V.		Almere
68857	150037	Ludwig Bruder	Warenhandel	Wien
68858	150038	Braccio di Ferramenta		Rovigo
68859	150039	Bordo International Pty. Ltd.		Scoresby, Vic. 3179
68860	150040	BD - Werkzeugtechnik AG		ZÜRICH
68861	150041	BO RYUNG TRADING AND	MFG.CO. ,L TD.	SEOUL
68862	150042	LA. BELL. SAS	DI COSTANTINI VIVIANO & C.	POLPET DI PONTE NELLE ALPI (BL
68863	150043	Industrietechnik	Buchhauser GmbH	Voitsberg
68864	150044	Boon Koon Hardwae PTE LTD		Singapore 209520
68865	150045	BOESSO s.n.c. di Masciotta N. &	Colaiacovo E.	ROMA
68866	150046	BTX TOOLS	attn. Mr. Patrice BATOUX	JUZENNECOURT
68867	150047	S.C. EJOT ROMANIA SRL		Bradu, Geamana village distric
68868	150048	BI-Produkter as		Billingstad
68869	150049	Boomerang Tools Inc.		Longueuil  QC  J4G 1L902
68870	150050	Baltic Project Group SIA		Riga
68871	150051	Bratja Petrovi  GmbH		Lowetsch
68872	150052	Blacks Fasteners Limited		Christchurch
68873	150053	BINÉTA KER. SZOLG. BT		Budapest
68874	150054	Antonio Capaldo Spa		Manocalzati/Avellino
68875	150055	Cominvest CZ s.r.o.		Brno - Líše?
68876	150056	Fox & Gunn Limited		Pakuranga, Auckland
68877	150057	CAVEDIL NEW SAS DI V. SALSANO & C.		CAVA DEI TIRRENI
68878	150058	Choy Chan Wah Enterprises Pte.Ltd.	Mr. Choy Meng Chun, Manag.Director	Singapore 914033
68879	150059	D.M.P. STEEL s.r.o.		Bratislava
68880	150060	Lietuvos ir Suomijos uždaroji	akcin? bendrov? "DR?TSRAIGTIS"	Kauno
68881	150061	AB FASTEX FÄSSTTEKNIK		Vinslöv
68882	150062	EUR SECURITY CENTER s.a.s. di	C.Novelli	Roma
68883	150063	D'AMICO S.r.l.	Forniture & Servizi	Roma
68884	150064	EJOT AUSTRIA GmbH & Co. KG		Voitsberg
68885	150065	Cash Ferretero las Quemadas, C.B.		Cordoba
68886	150066	Century Fasteners Limited	Unit D10	DUBLIN
68887	150067	ESAN EXPRESS PERU, S.A.C		Lima
68888	150068	FIME SRL		BELFIORE (VR)
68889	150069	C.C.E.C. Distributors		DUBLIN 22
68890	150070	Foka Saz Choob	Seifi, David	Teheran
68891	150071	Fakhry Hardware & Tools		Beirut
68892	150072	MARIO FORCONI s.n.c.		ROMA
68893	150073	EJOT Benelux bvba		Bornem
68894	150074	ESAN SRL, Bolivia	Contact: Luis Felipe Espinoza Corte	Barrio Nueva Jerusalen UV 0063
68895	150075	EUROPA FERRAMENTA s.r.l.		ROMA
68896	150076	Folkestone Fixings LTD Dyna House		KENT
68897	150077	1001 Dribnytsya LLC		Lviv
68898	150078	EJOT S.A.S.	di EJOT Tecnologie di fissagio S.R.	CAMPODARSEGO (PD)
68899	150079	Coimapor Qjusa , S.L.		Vigo / Ponteverda
68900	150080	J.A.C. Suministros Industriales S.L		Segovia
68901	150081	Eurobit Co. Srl - Tools Group	attn.  Mr. Maggioni	BARZANO (LC)
68902	150082	JUAN FERNANDO GALUSSO PENA	IMPORTACIONES	MONTEVIDEO
68903	150083	SIA "CKM"		Riga
68904	150084	Thürmer Tools ApS.	DANSKE VAERKTOEJ ApS	Gilleleje
68905	150085	J.K. Enterprises	Phone : 91 9820803630	Mumbai 400 055
68906	150086	APOLO FIJACIONES Y HERRAMIENTAS,	S.L.	Castellar del Valles (Barcelon
68907	150087	Ferrometal Oy		Nurmijärvi
68908	150088	GFC Fasters & Consstruction Product		Penrose, Auckland 1061
68909	150089	J-P. Fracheboud AG	FRA-TOOLS	Orpund
68910	150090	Agro Green Investments	Engineering & Agricultural	CAIRO
68911	150091	Ferramenta FE.PI s.a.s.	di F. Piscitelli & S. Romano	Napoli
68912	150092	MetriaTools S.R.L	RNC 131-16286-1	San Francisco de Macorís Provi
68913	150093	Metritools	attn. Mr. Luis Pacheco	GRENOBLE
68914	150094	F.lli di Donato srl.		Marina di Città Sant' Angelo (
68915	150095	UAB DIKTUM		Kaunas
68916	150096	DIMPFLMEIER RAPPRESENTANZE		Roma
68917	150097	Doukas A.E.B.E		Athen
68918	150098	DELVE 2 SIA		RIGA
68919	150099	L'Aquilotto di M. Martini		Roma
68920	150100	LOBOMATIC AB		Helsingborg
68921	150101	LE TOOLS	Emmerich Litzko	Kirchbichl
68922	150102	Lindqvist AS		Bergen
68923	150103	482 LLC		Kyiv
68924	150104	Importadora ECO S.A.,		VALPARAISO,
68925	150105	SAS SA ATELIERS LR ETANCO		LE PECQ
68926	150106	Przedsiebiorstwo Handlowo Uslugowe	ELWIERT	Gdansk
68927	150107	Ferreteria El Barato, S.L.		Cardona Barcelona
68928	150108	Eurimex International	attn. Mr. John Horne	CLEVEDON, SOMERSET
68929	150109	Equipa Quatro Lda	Comércio e construcones Lda.	São Bartolomeu de Messines
68930	150110	Envotec - Umwelt & Sanierung GmbH		Pinkafeld
68931	150111	Maja-L ltd.		JURMALA
68932	150112	PREMIER RENDER SUPPLIES Ltd	Phil Gilpin	LEEDS
68933	150113	Pecol, SA	Sistemas de Fixcao	Agueda
68934	150114	ProMart Oy		Laskutus
68935	150115	Diamond Tech AS		Hamresanden
68936	150116	Palmieri Francesco E Luca S.N.C		Sassari
68937	150117	F A C I  di Cacace e.C.		Roma
68938	150118	Profi-Tool-Center e.U.	Stefan Böckl	Hollabrunn
68939	150119	Phoenix Distribution	Mr. Gerard Jenkins	Finglas Dublin 11
68940	150120	SARL FIX 2 PRO	Fixer - Percer	CHARENTON LE PONT
68941	150121	Festool s.r.o.		Ceská Lípa
68942	150122	Bischetti s.r.l.		ROMA
68943	150123	PROFMET GRUP SRL		Chisinau Moldova
68944	150124	PASSEPARTOUT DI ANDREA BIANCONCINI	E C. S.A.S.	ROMA
68945	150125	Greenmill Supply Company Ltd	attn. Mr. Bruce Miller, Director	Colchester
68946	150126	Güney Hirdavat A.S.		BAGCILAR   ISTANBUL
68947	150127	Gehco Fixing BVBA		Houthalen
68948	150128	RUKU GmbH	Schraubengrosshandel &	Feldbach
68949	150129	Grupo 15, S.L.		Don Benito - Badajoz
68950	150130	Mafisa Oy	Ruuvikeskus	Helsinki
68951	150131	SNC GEFIX SNC		PORTES LES VALENCE
68952	150132	Granidisco, S.L.		Caldas de Reis Ponevedra
68953	150133	Gottfred Petersen AS		Middelfart
68954	150134	S.C. Gross Technik S.R.L.		Bukarest
68955	150135	Evropeiskii Instrument LLC		Bila Cerkva Kiivska Oblast
68956	150136	Mauceri Professional S.R.L		Roma
68957	150137	GES Global Engineering systems	att. Mr. Eng. A. Mansour	CAIRO
68958	150138	Hashahal Trad. House Ltd		Rishon Lezion
68959	150139	Herman Slovakia Production s.r.o.		Kosice
68960	150140	Hausken Tekniske AS		Stavanger
68961	150141	Horváth Csapágy Kft.	Horváth Csaba	Zalaegerszeg
68962	150142	Trent Industrial Supplies Ltd	attn. Mr. Alan Cunningham	Staffordshire
68963	150143	Schrauben Heckele GmbH		Markt Hartmannsdorf
68964	150144	Imcoinsa 1985, S.L.		Abadiño (Bizkaia)
68965	150145	JAATA OÜ		Tallinn
68966	150146	Izzo Domenico		Maddaloni (Caserta)
68967	150147	BE-KA Teknik Hirdavat Dis.	Ticaret ve Sanayi Ltd Sti	Okmeydani - Istanbul
68968	150148	Imexa d.o.o.		Ljubljana
68969	150149	INSTRO  SIA		Riga
68970	150150	Naka Ltda.		Montevideo
68971	150151	ITALCHIAVI s.r.l.		ROMA
68972	150152	Suministros BEYMA, S.L.		LORCA (MURCIA)
68973	150153	Hei Trading Oy	OTV 003728344278	Docuscan
68974	150154	IMCOMINER S.A.S.	John Julian Y Samara Guerrero	CALI - VALLE
68975	150155	Ets. JADIR	attn.: Mr. Serge Jamourian	BEIRUT
68976	150156	Isauro Neves Ferreira, Ltda.		S. Bernardo - Aveiro
68977	150157	Jayce Industries		Jungwon-gu, Seongnam-si, Gyeon
68978	150158	Joma AB		Gnosjö
68979	150159	POE IMPORT	attn. Mr. Lachhar, Manager	Papeete, Tahiti
68980	150160	Industrial Tooling Products (UK) Lt	attn.: Mr. Andy Bagshaw	Chesterfield, Derbyshire
68981	150161	Jaybro Group PTY Ltd.		SEVEN HILLS, NSW 1730
68982	150162	PAESANO ALDO		ROMA
68983	150163	Inter-Prima SRL	Loc. Valea Lupului	Iasi
68984	150164	MK Trade FZE		Ras AL Khaimah
68985	150165	ZUJER TRADING Co. (LLC)	Tel.: +971 4 224 9422	Dubai, U.A.E.
68986	150166	KNO Werkzeughandel GmbH		Kirchbichl
68987	150167	Kamlesh Trading Co. LLC		Dubai
68988	150168	Krebs Baumaterial AG		Hünenberg
68989	150169	KROMAC LAMANNA FRANCESCO s.r.l.		CROTONE
68990	150170	Magi. Adrian Kawan		Stainz
68991	150171	BRADOS LP		Edinburgh
68992	150172	Kress-elektrik Bulgarien GmbH		Lowetsch
68993	150173	OX GROUP UK	Myles Woodcock, R& D Manager	LONDON
68994	150174	Kärkikiinnike Oy		Helsinki
68995	150175	Kale Hirdavat ve Makina A.S.	contact: Mr. Ali Özkara	Edirnekapi-Eyup ISTANBUL
68996	150176	KNIPEX Tools Middle East FZE		Jebel Ali Dubai, U.A.E
68997	150177	HEE Photonics Labs Ltd.		Riga
68998	150178	KNAUF Fibre		Ungersheim
68999	150179	Kiinnike-Kolmio Oy		Tampere
69000	150180	INTEGRATED STORES FOR GENERAL	SUPPLIES	Amman
69001	150181	George Katsafados Ltd	phone No. 00357-22467686	Latsia
69002	150182	La Chiusura S.r.l.		Casapulla (Caserta)
69003	150183	Labor-International B.V.		Ede
69004	150184	Loconsole Michele s.r.l.		Bari
69005	150185	Lekr - Ing. Marián Krsák		Bratislava
69006	150186	LABO EPE		Peristeri/Athen
69007	150187	NorDiaTek AS		Kviteseid
69008	150188	Latina Supply Solutins Company	VAT: 608 030 2886	Bostanci/Kadikoy/Istanbul Tel.
69009	150189	Mitropoulos M.IKE		Patra/GR
69010	150190	GIUSEPPE MALVESTIO		Zero Branco (TV)
69011	150191	Oy Maanterä Ab		Vantaa
69012	150192	Mak Fastener Specialists Ltd	Unit A	Tallaght, Dublin 24
69013	150193	2 M di Ciani Massimo & C. s.a.s.		Todi (Perugia)
69014	150194	Friedrich Marzolf	Technischer Großhandel	Kuchl an der Salzach
69015	150195	V. Meyer A/S		Brøndby
69016	150196	Mijama A/S		Greve
69017	150197	Jordan Medows for Ind. Supplies	Tel +962 6 4767272	Amman
69018	150198	MDM Group Sp.z.o.o.S.k.		Ostrzeszow
69019	150199	PT Multi Baja Fastindo		Tangerang
69020	150200	ARKO LTD.		PATRA
69021	150201	MidWest Ports		Geraldton WA 6530
69022	150202	MAG-KRAK sp.z.o.o.		Krakow
69023	150203	Masonry Hardware PTY. Ltd.		Ringwood, VIC 3134
69024	150204	Mark-Up Tools Ltd	attn. Mr. Sheikh	Strangeways Manchester
69025	150205	K. Mitropoulos EPE		Athen
69026	150206	Mascoutech Inc.		Longueuil, QC J4G 2M1
69027	150207	TH. Methanis & Sia OE		Athen
69028	150208	MAGHIDRA JM EIRL	contact: Mr. Juan Mercedes Esquivel	SANTO DOMINGUITO   TRUJILLO
69029	150209	MCM Construction Materials	Supply Co. Ltd.	N.T., Hong Kong.
69030	150210	Adolf Würth GmbH & Co. KG		Künzelsau
69031	150211	NOVOMET KG Ltd.		SOFIA
69032	150212	Nagy & Nagy Kft.	Zoltán Nagy	Budapest
69033	150213	NOVATOOLS, S.L.		OIARTZUN (GUIPUZCOA)
69034	150214	NOVATOOLS, S.L.		OIARTZUN (GUIPUZCOA)
69035	150215	Nazar K. Al Dilijan& Sons Co.		Dammam 31481
69036	150216	A.D. NIKOLOPOULOI BROS O.E		TAYROS ATHEN
69037	150217	NAREX S.R.O.		Ceska Lipa
69038	150218	Ortner GmbH		Loosdorf/Melk
69039	150219	Oto Oskar Osicka	IMPORT - EXPORT - DISTRIBUTION	TEMICE
69040	150220	Brammer Iberia, S.A.		Galdakao (Bizkaia)
69041	150221	Oil Supply Limited Liability Compan		Baku
69042	150222	Odörfer Haustechnik KG		Graz
69043	150223	Dach Klinkier Grzegorz Kasiura	(Member of Siec Budowlana Trade)	Krapkowice
69044	150224	Przedsi?biorstwo Us?ugowo Handlowe	Marbet Beata Grygorowicz	Opole
69045	150225	Multi-form II Sp. z o.o.	(Member of SIEC BUDOWLANA Trade)	Tychy
69046	150226	Uni-Dach  Kozub Zbigniew, Kozub El?	Spó?ka Jawna	Olkusz
69047	150227	El-Stan Firma Handlowo-Us?ugowa Fro	Stanis?aw	Gryfów ?l?ski
69048	150228	Lubar S. A.	(Member of SIEC BUDOWLANA)	Rybnik
69049	150229	PAOLUCCI GIANCARLO E SANTE	SOCIETA' IN ACCOMANDITA	Roma
69050	150230	K.S.PAPADOPOULOS & CO	? ? ???????????? ??? ??? ?? ||K S P	Thessaloniki / ?????????
69051	150231	A. Papantonopoulos & SIA EE	tel. 2310-722425	THESSALONIKI
69052	150232	Powerluck 8 Pilippines, Inc.		Las Pinas City Philippines
69053	150233	JURMIR J.M.W. Rudzinscy	Sp. Jawna	BRODNICA
69054	150234	KARLI EFSTATHIA		ATHENS
69055	150235	Agila Global Stone, S.L.U.		Murcia
69056	150236	Plieger B.V.		Zaltbommel
69057	150237	Plumbers Choice		Bayswater, Vic 3153
69058	150238	Gienger Spol.s r.o.		Napajedla
69059	150239	GIENGER CENTRON s.r.o.		Praha
69060	150240	GIENGER BOHEMIA, s.r.o.		Otovice
69061	150241	GIENGER Tábor spol. s r.o.		Tábor
69062	150242	GIENGER Granit s.r.o.		Prešov
69063	150243	PechaSan spol.s r.o.		STRAKONICE 1
69064	150244	S.PAPATHEODOSIOU SPAP A.E		ATHEN
69065	150245	RHINOS CO., LTD.	phone: 81 667667770	Osaka 543-0018
69066	150246	REI Tools		Croydon VIC 3136
69067	150247	Repuestos Paniagua, S.A.		Badajoz
69068	150248	Fa. Bauservice Rindler GmbH		Klagenfurt
69069	150249	RB Tools GmbH	Generalvertretung	Au-Wädenswil
69070	150250	RK - HPD e.U.	Richard Kraßnitzer	Zweinitz/Weitensfeld
69071	150251	Rosenstatter Vertriebs GmbH		St. Pantaleon
69072	150252	R.E.I.T.  S.p.A.	attn. Mr. A. Zanon	SAN GIORGIO IN BOSCO (PD)
69073	150253	RAME,S.L.	SUMINISTROS INDUSTRIALES	Cadiz
69074	150254	RAWL FRANCE SA		MITRY MORY CEDEX
69075	150255	OOO "Technotorg"		Krasnojarsk
69076	150256	Sollenberg S.	VERKTYGSAKTIEBOLAG	Hässleholm
69077	150257	SVB BVBA		EL ERP
69078	150258	SPITTEX ITALIA S.R.L.		Bari
69079	150259	Ulemj LLC International Trading	Schüco Office	Ulaanbaatar
69080	150260	SESA TOOLS, S.A.		Hernani (Guipúzcoa)
69081	150261	Soc. It. Commerciale Utensili SpA		Milano
69082	150262	Sibilio S.r.l.		Frattamaggiore (Na)
69083	150263	BV UFTTOOLS - UFTLAS		Deinze
69084	150264	SCANDEX		Kaunas
69085	150265	Suministros Industriales Teymo S.L.		Motril (Granada)
69086	150266	Ali Dawood Al Shamary	Project Manager	Baghdad / Al Karadah
69087	150267	Union Day Limited	Room C	KOWLOON, HONG KONG
69088	150268	Jesus Salamero, S.L.	Ferreteria Salamero	(Monzon) Huesca
69089	150269	TMAX Corporation Co., Ltd.	Attn: Ms Wena Tangthavorn	Wangthonglang Bangkok 10310
69090	150270	Scell-it S.A.S.	attn. Franck DEBRUYNE	LESQUIN
69091	150271	Siu Industry Company Limited	Attn.Mr. Nguyen Caole	Ho Chi Minh City
69092	150272	Soroush / Mr. Abdulla Mohamad	Abdolmonhamad Mob:+ 9647701431996	Sulaimany Kurdistan Iraq
69093	150273	Safe-Entry. co.	Andrew Pearcy	LUTON
69094	150274	KREP-TEHNO		Ekaterinburg City
69095	150275	Santco Trading Inc.	Mr. Shayan Sadeghian	ONTARIO
69096	150276	Sanistal A/S		Silkeborg
69097	150277	Sheffield Group		Cardiff NSW 2285
69098	150278	Karim Al Shamary Store		Baghdad
69099	150279	Trucut		Warkworth 0910 Auckland
69100	150280	PROF. PRAXIS N. V.		Herne
69101	150281	UNITED HARDWARE	attn. Mr. Niall O'Neill	Dublin 24
69102	150282	SCE-SINGFA SDN. BHD.		Kajang Selangor Darul Ehsan
69103	150283	Skagen Trådindustri		Aalborg SV
69104	150284	United Equipment Co.	Eng. Usama Ibrahim A. Moathy	Sarai El Koba CAIRO
69105	150285	Radio Thomas Soder	Elektro u. Fernsehtechnik	Bad Aussee
69106	150286	TFA Solutions Limited	attn.  Mr. Tommy Forest	BRAEHEAD
69107	150287	MB Svajok		Klevines village
69108	150288	SOLMAT Hanusiak sp.k.		Kraków
69109	150289	Simuro Baubedarf AG		Baar
69110	150290	SEDISA	Mr. Gustavo Gaiarin Coronel	SURCO - LIMA 33
69111	150291	KERN-DEUDIAM	Building Hardware & Tools Trading L	DUBAI
69112	150292	Tomisa Herramientas S.L.		Alhaurín de la Torre  - Málaga
69113	150293	Josef Steinberg	Industrie u. Werkstattbedarf	Satteins
69114	150294	SPIRAL Reihs & Co. KG		Wien
69115	150295	INTERCONSULT	di SALICE EMANUELE	TREVISO
69116	150296	Sandtech, Inc.		Morton Grove, Illinois 60053
69117	150297	Ferramenta San Cesareo		San Cesareo (Roma)
69118	150298	Mahle Metal Leve S/A		Mogi Guaçu / SP
69119	150299	StrongArm Drills Inc.		So. San Francisco, CA 94080
69120	150300	SAMAR di Savino Mariangela		Fasano
69121	150301	SWIT		Bangalore
69122	150302	Spojmat	Stanislav Janik	Bratislava
69123	150303	Stemax LLC		Kiev
69124	150304	Stuart Trading as Infinite Bargains		Peterlee, Durham
69125	150305	STS Ltd	attn. Mr. Ryan Lumb	LEEDS
69126	150306	MAJER		Mszana Dolna
69127	150307	ITALIA STYLE SRL		ROMA
69128	150308	TILE EZE, INC.	Abi Michailidis  (FIN 47-2304520)	Naples,Florida 34108-0124
69129	150309	TAKAGI CO., LTD.	THE THIRD DEPARTMENT	NIIGATA
69130	150310	THEOTHRIDIS IOANNIS & SOHN OE	?????????? ??????? ??? ???? ??	Thessaloniki
69131	150311	VINCENT srl		THIENE VI
69132	150312	TOPFAST	Engineering Supplies	Paarden Eiland, Cape Town
69133	150313	TORREGIANI MELE	di Felci Lucilla	VELLETRI
69134	150314	BV Stock Americain G. Vermeersch		Diksmuide
69135	150315	TECNOSTYLE s.a.s.	di Pesce Antonia & c.	Noicattaro (Bari)
69136	150316	VITEKNO di Eraldo Vagnozzi		Teramo
69137	150317	VKP STEEL, s.r.o.		Banska Bystirica
69138	150318	Torgovaya Kompaniya Intek	(Joint stock companie)	Moscow
69139	150319	Torex Handels AG		Villmergen
69140	150320	INVOICE	Arsenal-Stroy Lmt	St. Petersburg
69141	150321	Tecnologías Metal Mecánicas	Avanzadas Limitada	SANTIAGO
69142	150322	VHS Unipessoal, Lda		Touguinho-Vila do Conde
69143	150323	Técniques de Clima i Sanitari, S.L.	CALLE CUBELLES, 7	Barcelona
69144	150324	Teclisa Levante, S.L.U		Paterna
69145	150325	Torgra Mayan, S.L.		Cordoba
69146	150326	Twistfix Ltd., KKM Buildings	attn. David J Chadwick	Portsmouth
69147	150327	Grupo Teclisa Illes Baleares Delega		Palma de Mallorca Islas Balear
69148	150328	TECNO S.R.L.	Ufficio Commerciale	Roma
69149	150329	Guido Hinken	Vertriebsleiter	Nordhorn
69150	150330	David Quinn	QnC Enterprises \\ Team-Tough.com	Canon City Co. 81212
69151	150331	Entegral Endustriyel Urunler San.ve	Tic.Ltd.Sti.	Erenkoy - Kadikoy-?stanbul
69152	150332	G. Vella & Sons Limited		Marsa MRS1912
69153	150333	Vartec S.R.L.		Anagni-Frosinone
69154	150334	VANZO SAS di Vanzo S. & C.		CAMPO SAN MARTINO (PD)
69155	150335	Vorpa s.r.l.		Riccione (FC)
69156	150336	Van Roij Fasteners Europe B.V		Deurne
69157	150337	Schalbau Vitzthum GmbH		Unken
69158	150338	Suministros Industriales Val-Sur, S		Albal (Valencia)
69159	150339	VIX AS		FREDRIKSTAD
69160	150340	Van Roij Fasteners Hungária Kft.		Dunaharaszti
69161	150341	A.EMS	Baumaterial GmbH	Gebenstorf
69162	150342	Industrietechnik Vallant		St. Andrä im Lavanttal
69163	150343	Suministros Industriales Valdeorras		Orense
69164	150344	S. A. S. VACO		MONTBRISON
69165	150345	WILMART SAS		LIBERCOURT
69166	150346	WING ON CHEUNG & CO (S) PTE LTD		Singapore 415928
69167	150347	Widmer AG	Eisenwaren-Werkzeuge	Muellheim TG
69168	150348	Wakai Holdings CO., LTD.		Higashi Osaka City Osaka Pref.
69169	150349	WÜRTH Bulgarien EOOD	????-???????? - ????	German
69170	150350	MAY Fixation Sarl.		Pratz-Préizerdaul
69171	150351	Würth-Portugal	Técnica de Montagem, Lda.	Sintra
69172	150352	Wera Werk s.r.o.		Bystrice nad Pernstejnem
69173	150353	Winkler Schulbedarf GmbH		Karlstetten
69174	150354	WEKO Tools Kft.		Vác
69175	150355	WENO Technika Mocowa? Czaika Sp.k.		RE?SKA WIE?
69176	150356	WRZECIONO SPÓ?KA Z OGRANICZON?	ODPOWIEDZIALNO?CI?	OPOLE
69177	150357	Werka AG		Opfikon
69178	150358	HSK Werksvertretung	Nikolaus Wagner	Payerbach
69179	150359	Wielitsch KG		Maria Saal
69180	150360	Yildiz Demir Hirdavat	Yomtov Bensason	Okmeydani - Istanbul
69181	150361	Zgonc Handel GmbH		Wien
69182	150362	MCM Hirdavat ITHALAT IHRACAT	MAKINA SAN. TIC. LTD. STI.	Karaköy Istanbul
69183	150363	Yun Chan Ind. Co. Ltd.		Dali district Taichung City 41
69184	150364	ZANOTTI  FABIO  S.A.S.	di Zanotti Fabio E C.	GHEDI (BS)
69185	150365	mbi	matérial bâtiment industrie	CHAMPIGNY SUR MARNE
69186	150366	YH-UY Marketing Inc.		Quezon City
69187	150367	Lackner & Urnitsch GmbH	Präzisionsmaschinen und Werkzeuge	GRAZ
69188	150368	BMI Monier B.V.		GP Montfoort
69189	150369	MONROVIA SUMINISTROS	INDUSTRIALES, S.L.	GURIEZO (CANTABRIA)
69190	150370	Ulrich Harms GmbH	Maschinen + Werkzeuge	Wieren
69191	150371	G.U.T. SONNTAG Sonntag KG	Fachgroßhandel f.	Münster
69192	150372	Meissel-Discount	Susanne Andrae	Upgant-Schott
69193	150373	Anatol Reiswich	Gebäudetrocknung	Wipperfürth
69194	150374	PAV e.K.	Handel, Dienstleistung, Consulting	Langenhagen
69195	150375	Dachbaustoffhandel	Reiswich GmbH	Wipperfürth
69196	150376	ABS Handelsgesellschaft mbH		Hamburg
69197	150377	Schlüssel 40	Inh. Ioannis Aidinaoglou	Düsseldorf
69198	150378	Schwahn	Beschlag- und Holzhandel	Halberstadt
69199	150379	Adam GmbH		Kempen
69200	150380	Aulmann,Kruener & Co.	Inh. Th. Teichmüller	Hamburg
69201	150381	Bezug + Absatzgenossen-	schaft	Neunkirchen
69202	150382	A - Z Mietservice	Klaus Geißler	Springe
69203	150383	Daniel Arnold		Overath
69204	150384	ARGU Ihr Holzfachmarkt	Stefan Gutting	Neustadt/Weinstrasse
69205	150385	Erich Abram GmbH		Hemmingen/OT Arnum
69206	150386	Adam GmbH		Kaiserslautern
69207	150387	Werkzeug 1x1	Tilo Frisch	Braunsbedra/ OT Roßbach
69208	150388	A.L.B. Aluminiumhandels- und	Industriebau GmbH	Bad Honnef
69209	150389	A+B Werkzeuge u. Maschinen	GmbH	Ahaus
69210	150390	Adolphs-Bautenschutz GmbH		Engelskirchen
69211	150391	WSM Walter Solbach Metallbau GmbH		Waldbröl
69212	150392	Josef Attenberger GmbH		St. Wolfgang
69213	150393	A - Z	Holz - und Bedachungshandel GmbH	Wuppertal
69214	150394	Der Baustoff Mann	Schneider KG 700506	Oberhausen
69215	150395	Jörg Johann	Industrievertretungen	Wermelskirchen
69216	150396	LLC “Abron”	Inhaber: Oleksandr Abrosimov	Kyiv
69217	150397	Baumgarten Geräte GmbH		Hannover
69218	150398	kwb Germany GmbH		Stuhr
69219	150399	BZN Herm. Meyer & Sohn GmbH & Co.	KG	Oldenburg
69220	150400	BÖ-LO Werkzeug & Maschinen	Inh. Matthias Schütze	Quakenbrück
69221	150401	Heinrich Biesang OHG		Bad Oeynhausen
69222	150402	Adam Berkel GmbH		Fulda
69223	150403	Eska	Maschinentechnik e.K.	Rudolstadt
69224	150404	IHB GmbH	Industrie- und Heimbedarf	Krefeld
69225	150405	Burghardt S.	Diamant Schleifwerkzeuge	Quickborn
69226	150406	Bohrcraft Werkzeuge	GmbH & Co. KG	Remscheid
69227	150407	Udo Brucksch	Werkzeugschärfbetrieb	Dommitzsch
69228	150408	BWG Bauteam Profi Produkte	Vertriebs & Logistik GmbH	Steinbach-Hallenberg
69229	150409	Nordwest Handel AG	Wilhelm E. Beckmann GmbH & Co. KG	Hagen
69230	150410	Dahlhäuser GmbH	Qualitätsprodukte	Nümbrecht
69231	150411	BHT	Baustoffe Handel & Transport GmbH	Bachra
69232	150412	DeMi-Befestigung Köln	Michels GmbH	Köln
69233	150413	Demo GmbH & Co. KG		Norderstedt
69234	150414	RIAG Baubedarf GmbH & Co. KG	(EVB Nr. 11806)	Rudolstadt
69235	150415	MECHANIK - ECK BUSCH	Inh. Monika Busch	Freiberg
69236	150416	Lothar Baier	Werkzeuge und Schleifmittel	Ispringen
69237	150417	Gartenpaul Brands Inh. Andre Blöchl		Wedemark
69238	150418	Industrieberatung	Thomas Bünting	Jeddeloh 1
69239	150419	BTS Bautechnik-Service GmbH		Waren
69240	150420	Melle Gallhöfer Dach GmbH		Großschweidnitz
69241	150421	Dahlmann GmbH		Großefehn
69242	150422	Begra Befestigungstechnik Gramm	GmbH	Gedern
69243	150423	WHV GmbH	Werkzeug-Handel-Vermietung	Bernburg
69244	150424	Wolf Burkhardt	Spezialwerkzeuge	Zweibrücken
69245	150425	Industriebedarf Insel	Andreas Insel	Sinzig
69246	150426	Friedrich Bormann OHG	Eisenwaren, Sanitär, Heizung, Bauar	Bad Harzburg-Harlingerode
69247	150427	Alexander Belloth Service	Elektro- und Schweißgeräte · Techni	Hallbergmoos
69248	150428	Bonn Stahl GmbH	Verwaltung	Bonn
69249	150429	Eichfelder-Werkzeuge		Bamberg
69250	150430	Eichenberg Werkzeuge	Inh. Andreas Grothe	Aerzen / OT Heckendorf
69251	150431	Baumgarten Betonbearbeitung GmbH		Hannover
69252	150432	Hans Becker	Handwerk + Haus + Garten	Kleinblittersdorf
69253	150433	Begra Befestigungstechnik	Behr GmbH	Gedern
69254	150434	BERG TECTOOL GmbH		Köln
69255	150435	BURG-WÄCHTER KG		Wetter
69256	150436	Luttmann & Co. GmbH		Lippstadt
69257	150437	Industrie und Werkstatttechnik-Nord	GmbH (NW 8921)	Nienburg/Weser
69258	150438	Boehl-Weissenfeld GmbH & Co. KG		Remscheid
69259	150439	Braun Reiner		Rodenbach
69260	150440	Erwin Kauth	ERKA Schleifen	Blankenheim
69261	150441	G.U.T. Bergmann KG		Großdubrau OT Sdier
69262	150442	Burgzem GmbH		Bad Münder
69263	150443	BHV Kiefer	Baudienstleistung Handel & Vermietu	Zell-Atzenbach
69264	150444	EFG Hanse KG	Elektro-Fachgroßhandel	Barsbüttel
69265	150445	A. Brickwedde	Technischer Handel GmbH & Co. KG	Osnabrück
69266	150446	Peter Belousow  GmbH		Aichach
69267	150447	BTS Bau Technische Systeme GmbH & C	KG	Waltrop
69268	150448	BSW-Schrauben-Werkzeughandels-GmbH		Bruchsal
69269	150449	ROKA	Sebastian Clausen Großhandel e.K.	Hamburg
69270	150450	EAS Elektro-Ausrüstungs-	Service GmbH	Rheinberg
69271	150451	Cordes & Graefe Emden KG	Fachgroßhandel für Haustechnik	Emden
69272	150452	Erich Carlé GmbH & Co. KG	Bedachungsfachhandel	Gießen
69273	150453	Weishaupt Werkzeuge		Krumbach
69274	150454	Pasquale Cantatore	Industrievertretungen	Friedberg/Haberskirch
69275	150455	Carlé + Fatum	Bedachungsfachhandel	Kriftel
69276	150456	Dereh - Bedachnung GmbH	Zimmerer & Dachdeckermeisterbetrieb	Beerfelden
69277	150457	Dienes Werke	GmbH & Co. KG	Overath
69278	150458	Dörrenberg	Edelstahl GmbH	Engelskirchen
69279	150459	KERN-DEUDIAM	Diamantwerkzeuge und Maschinen	Hövelhof
69280	150460	WEGA Handels Gbr.	Bodo Kaiser, Wolfgang Kaiser	Burscheid
69281	150461	Werkzeug-Döring GmbH	(NW 6110)	Wuppertal
69282	150462	DÜNA	Befestigungstechnik GmbH	Meschede-Freienohl
69283	150463	Reinhard Eck	Werkzeugfachhandel und	Zella-Mehlis
69284	150464	DO IT 5479	Silberspeer GmbH	Wehr
69285	150465	BÖRNER-WERKZEUGE		Uslar
69286	150466	Opitec Handel GmbH		Giebelstadt-Sulzdorf
69287	150467	Daniel Gruppe GmbH		Lübbecke
69288	150468	Ecker Eisenwaren GmbH		Stolberg
69289	150469	Dieter Irmscher	Handel & Service von Bautechnik	Chemnitz
69290	150470	Dunken Verbindungselemente GmbH		Braunschweig
69291	150471	Dach-Hartwig GmbH		Bickenbach
69292	150472	Dachkauf GmbH	Dachbaustoffe	Hattorf am Harz
69293	150473	AK Industrie- u.Montageteile	Renate Antwerber	Flammersfeld
69294	150474	Diederichsen Tresoröffnung		Hamburg
69295	150475	Friedrich Duss	Maschinenfabrik GmbH & Co. KG	Neubulach
69296	150476	Peter Drösser GmbH	(NW 6134)	Köln
69297	150477	Werkzeugprofi	Inhaber: Stefan Schrapers	Mülheim / Ruhr
69298	150478	3 Chem GmbH	Chemisch-technische Spezialprodukte	Geislingen / Steige
69299	150479	Erich Drescher	Handel und Service	Au / Bad Feilnbach
69300	150480	Baufachzentrum Dörries GmbH		Delligsen
69301	150481	Ralph Penther		Kisdorf
69302	150482	Werkzeugvertrieb	Michael Jungen	Heilbronn
69303	150483	Dobermann GmbH & Co. KG	Baustoffhandelsgesellschaft	Münster
69304	150484	Diversio GmbH & Co. KG	(NW 9351)	Sohren
69305	150485	Eggers H.J.	Eisenwaren	Braunschweig
69306	150486	Ebnet Josef		Patersdorf
69307	150487	Engel GmbH		Hamburg
69308	150488	Diewe GmbH		Kissing
69309	150489	EJOT GmbH & Co. KG		Bad Berleburg
69310	150490	Hopert & Klinzmann		Haldensleben
69311	150491	Holz Leipzig		Leipzig
69312	150492	Eyssler Arthur GmbH & Co. KG	Fachgroßhandel	Neustadt/Sa.
69313	150493	Dornis Dach- und	Wandbaustoffe GmbH	Kölleda
69314	150494	Uwe Eißmann GmbH	Fachhandel für Dach und Fassade	Wilkau-Haßlau
69315	150495	Eisen-Schlitt	Ortwin Herbst	Frankenthal/Pfalz
69316	150496	Esser Großhandels- und	Dienstleistungs GmbH	Essen
69317	150497	Emder Schiffsausrüstung GmbH		Emden
69318	150498	Michael Engelhardt	Handelsvertretung	Föritztal OT Neuhaus-Schiersch
69319	150499	Rolf Dammers OHG		Hamburg
69320	150500	Heitkamm GmbH	Dachbaustoffe	Chemnitz
69321	150501	SK-Work-Wear	Inh.Stefanie Kehl	Grassellenbach
69322	150502	Etanco GmbH		Wilnsdorf-Wilden
69323	150503	Druse GmbH	Werkzeuge & Industriebedarf	Buchholz
69324	150504	BreGu e.K.	Inhaber Stefan Bremm	Krummhörn-Greetsiel
69325	150505	Shopbox24	elektro-schölzel GmbH & Co. KG	Demitz-Thumitz
69326	150506	H. W. Meyer sen. Wwe GmbH & Co. KG		Soltau
69327	150507	Engel 4.0 GmbH		Hamburg
69328	150508	Peter Hermann Biertz e.k.		Losheim am See
69329	150509	rud. entenmann gmbh	(NW 8234)	Heidelberg
69330	150510	Deutsche Everlite GmbH		Wertheim
69331	150511	Hermann Fatum GmbH & Co. KG	Bedachungsfachhandel	Hungen
69332	150512	Fahrzeugteile-Handelsgesellschaft	Carl F. Müller mbH	Hamburg
69333	150513	Frank + Warnecke	Industriebedarf GmbH	Braunschweig
69334	150514	Reinhold Feltes	Inhaber Rainer Feltes	Trier
69335	150515	FAMEX - Werkzeuge	Lühdorff R. GmbH	Remscheid
69336	150516	Erich Frank	Schrauben, Metall- und Normteile Gm	Aachen
69337	150517	Krapp Eisen GmbH & Co. KG		Lohne
69338	150518	Theo Förch GmbH & Co. KG		Neuenstadt
69339	150519	FTH	Fredenbecker Technik & Handels	Stade
69340	150520	Herm. Fichtner Hof GmbH		Hof
69341	150521	P.F.Freund & Cie. GmbH		Wuppertal
69342	150522	Uwe Fischer	Holzbau	Coburg
69343	150523	Werner Flosbach GmbH & Co.KG		Remscheid
69344	150524	PRIMIUM	Lager und Liefergesellschaft	Wuppertal
69345	150525	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69346	150526	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69347	150527	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69348	150528	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69349	150529	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69350	150530	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69351	150531	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69352	150532	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69353	150533	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69354	150534	FREDIAM	Johann Frenka	Germering
69355	150535	DER Fuchs GmbH		Kirchlinteln
69356	150536	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69357	150537	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69358	150538	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69359	150539	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69360	150540	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69361	150541	fortuna Sportgeräte GmbH		Gehlert
69362	150542	Fritsche & Perleberg GmbH	Elektro- und Sicherheitstechnik	Schönebeck
69363	150543	ISAHO Versand e. K.		Hohndorf
69364	150544	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69365	150545	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69366	150546	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69367	150547	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69368	150548	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69369	150549	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69370	150550	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69371	150551	G. Felber Handwerker-Zubehör		Ahaus
69372	150552	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69373	150553	Freialdenhoven Baumaschinen	Inh. Ralf Freialdenhoven	Eschweiler
69374	150554	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69375	150555	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69376	150556	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69377	150557	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69378	150558	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69379	150559	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69380	150560	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69381	150561	Festool GmbH		Wendlingen
69382	150562	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69383	150563	FAMOS GmbH & Co. KG		Neu-Ulm
69384	150564	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69385	150565	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69386	150566	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69387	150567	Fritz Tresor Transporte GmbH		Maintal
69388	150568	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69389	150569	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69390	150570	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69391	150571	FEKATEC GmbH		Aurich
69392	150572	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69393	150573	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69394	150574	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69395	150575	FAKTUM Bauprodukte GmbH		Wilnsdorf
69396	150576	Foxx Gmbh		Wittenberge
69397	150577	PRIMIUM Lager und	Liefergesellschaft GmbH & Co. KG	Wuppertal
69398	150578	Werkstatttechnik Marcus Fronober		Bennewitz
69399	150579	Fillbach Dach-Handel GmbH	(AH.-Nr.438215)	Heistenbach
69400	150580	Bernd Müller - Hausmeisterservice &	Trockenbau	Selm
69401	150581	Grießbach Stefan	Elektromaschinenbau	Auerbach-Rebesgrün
69402	150582	Gaishauser Erwin		Tiefenbach
69403	150583	G + K Schrauben-Befestigung-	Vertriebs GmbH	Pfungstadt
69404	150584	Uwe Grimm	Treppenbaubedarf	Groß Wokern
69405	150585	Holz Loddenkemper GbR		Marienfeld
69406	150586	G + M Geräte- und Maschinen-	handlungs GmbH	Marktredwitz
69407	150587	Häuslein	Werkzeuge - Maschinen	Marktheidenfeld-Glasofen
69408	150588	Glashandel Pritz GmbH		Engelskirchen
69409	150589	GOJ Werkzeug GmbH	(NW 8772)	Nürnberg
69410	150590	GS Maschinenhandel	Diamantwerkzeuge	Ahausen-Eversen
69411	150591	Globus Türen & Fenster	Handels GmbH	Hamburg
69412	150592	Anton Gallhöfer Dach und Fassade	GmbH	Oberhausen
69413	150593	EGU Elektro Grosshandels Union Rhei	Ruhr GmbH & Co. KG	Dortmund
69414	150594	Hülsewig Karl	Steinindustriebedarf	Witten
69415	150595	Georg Geiger	Inh. Alfons Reitberger	Kempten/Allgäu
69416	150596	Garden-Tec Rothe		Zeitz
69417	150597	DiTec GmbH & Co. KG		Haiger
69418	150598	Gundlach Diamantwerkzeuge		Schwalmstadt
69419	150599	GERICON Consulting & Connecting	Gerd Riethmüller	Balingen
69420	150600	Anton Gallhöfer Dach + Fassade GmbH		Birkenfeld
69421	150601	GIMA GmbH & Co. KG		Herrieden-Neunstetten
69422	150602	Gründl Bedachungsfachhandel GmbH		Sömmerda
69423	150603	Burkhard Giegerich GmbH & Co. KG		Großwallstadt
69424	150604	Melle Gallhöfer Dach GmbH		Stuttgart
69425	150605	Melle Gallhöfer Dach GmbH	Niederlassung Döbern	Döbern
69426	150606	EXPORTA GmbH		Bremen
69427	150607	GFE - Gesellschaft für Fertigungste	und Entwicklung Schmalkalden e.V.	Schmalkalden
69428	150608	GV Montageprodukte GmbH		Landshut
69429	150609	Melle Gallhöfer Dach GmbH		Dingelstädt
69430	150610	GERICON GmbH		Balingen
69431	150611	GC24-Express KG		Unna
69432	150612	Emil Holzmann GmbH		Radevormwald
69433	150613	Goecke GmbH & Co. KG		Schwelm
69434	150614	Gerhard Hof GmbH		Mühlheim/Main
69435	150615	Hoffmann GmbH	Qualitätswerkzeuge	München
69436	150616	TeHa Attendorn GmbH	Technischer Handel	Attendorn
69437	150617	HAUPA GmbH		Remscheid
69438	150618	Hinst	Eisenwaren GmbH	Kellinghusen
69439	150619	Holtegel GmbH		Flensburg
69440	150620	TIB Hydraulik GmbH		Göttingen
69441	150621	Hörhammer	Werkzeuge & Maschinen	Moosburg
69442	150622	BSD Bildungs-	und Servicezentrum GmbH	Großröhrsdorf
69443	150623	HOHA Holzhandel	Norbert Stern	Rudolstadt
69444	150624	Detlev Heyert	Diamant-Technik	Harsdorf
69445	150625	Heitkamm GmbH	Dachbaustoffe	Ahlen
69446	150626	Ferdinand Horstmann GmbH & Co. KG		Bad Oeynhausen
69447	150627	Höck-Jansen GmbH		Overath
69448	150628	Hoppe GmbH & Co. KG		Brilon
69449	150629	Arnold Houben GmbH		Köln
69450	150630	Huber	Werkzeuge & Maschinen	Oberviechtach
69451	150631	BHT GmbH	Bedachungshandel Tritschler	Sexau
69452	150632	Hampel Bedachungs GmbH	Bedachungen Dachbaustoffe	Göttingen
69453	150633	HABA Bauhandwerksbedarf	Inh. Stephanie Heinrich	Idar-Oberstein
69454	150634	Hendriks Werkzeuge		Goch
69455	150635	Peter Hartmann	Werkzeuge und Maschinen	Bielefeld
69456	150636	HABO Handelsgesellschaft für	Werkzeugbedarf mbH	Varel
69457	150637	HOME TEC GmbH		Weyhe
69458	150638	HWG - Vertrieb tools and more	Heinz-Werner-Gabriel e.K	Ergolding
69459	150639	H.R. Tempel	GmbH & Co. KG	Nürnberg
69460	150640	Wilhelm Huber GmbH	Fachgroßhandel f. Ökologische	Burgberg i. Allgäu
69461	150641	W.Hägele	Rohrisolierungen Befestigungen	Ottenbach
69462	150642	Hecker`s Sohn e.K.	(NW 4820)	Dresden
69463	150643	DRAGON	Verkaufsgesellschaft mbH	Fischerbach/Schwarzwald
69464	150644	Hübner Werkzeuge GmbH		Großröhrsdorf
69465	150645	Hyland- Baugeräte GmbH		Hannover
69466	150646	Hartlmaier	Technische Handels GmbH	München
69467	150647	Fliesenmarkt Herberhold		Lippstadt
69468	150648	Hyland-Baugeräte GmbH		Großröhrsdorf-Bretnig
69469	150649	Höhne	Werkzeug und Maschinentechnik	Bönningstedt
69470	150650	Hartmut Richter Industriebedarf Gmb		Bochum
69471	150651	Volker Heß	Bau- und Gerüstbaubedarf	Oberlungwitz
69472	150652	HWV Werkzeugvertrieb Hamburg GmbH	(NW7836)	Hamburg
69473	150653	Hartmann Werkzeuge e.K.		Gemmrigheim
69474	150654	WBV Werkzeug- &	Baumaschinenvermietungsgesellschaft	Wermelskirchen
69475	150655	TIB Technischer Industriebedarf	GmbH Bernsbach	Lauter-Bernsbach
69476	150656	heima24 GmbH & Co. KG		Wehingen
69477	150657	HIK Systems GmbH		Heidenheim
69478	150658	HSK	Handels Scheune Kirchner	Rüdershausen
69479	150659	Häcker Eisenwaren GmbH & Co. KG		Geislingen
69480	150660	Hessberger GmbH Baustellentechnik		Frankfurt am Main
69481	150661	HEYCO Qualitätswerkzeuge GmbH & Co.	KG	Remscheid
69482	150662	Herwig-Bohrtechnik	Schmalkalden GmbH	Schmalkalden
69483	150663	Päffgen Dachbaustoffe		Kaarst
69484	150664	Hesselkamp GmbH & Co. KG		Norderstedt
69485	150665	Andreas Pabst Handelsvertretung		Lohmar-Birk
69486	150666	HIFI Components GmbH		München
69487	150667	Herrlinger KG	Fachgroßhandel für Haustechnik	Eislingen
69488	150668	Harzig Kleb- und Dichtstoffe GmbH		Augsburg
69489	150669	Holzfachmarkt Gerschwitz GmbH		Rottenburg an der Laaber
69490	150670	TIB	Technischer Industrie-Bedarf Lackma	Essen
69491	150671	BPH-Tools	Inh. Uwe Bruder	Bietingheim-Bissingen
69492	150672	Heilna Trade GmbH		Neu-Isenburg
69493	150673	ISH Hoffmann Industrieservice		Enger
69494	150674	Jehle Stefan GmbH	Werkzeuge + Maschinen	Landsberg a. L.
69495	150675	Irrgang-Werkzeughandel	GmbH	Eberswalde
69496	150676	J + K GmbH	Janßen + Klinkebiel	Apen - Augustfehn
69497	150677	H. Isik GmbH	Diamantwerkzeuge	Bochum
69498	150678	Thomas Jilg	Industrieberatung	Schauenstein
69499	150679	INTEK	Leyh und Gulden OHG	Ingolstadt
69500	150680	IMPEX	Eduard Schuffenhauer	Kaufbeuren
69501	150681	imBau GmbH	Werkzeuge & Maschinen	Künzell
69502	150682	INTRA-TEC GmbH	Schrauben-Hammer	Bergisch Gladbach
69503	150683	Heinrich Jensen e.K.		Bredstedt
69504	150684	innofixx equipment GmbH		Berlin
69505	150685	Innofixx Vertriebs GmbH		Hamburg
69506	150686	Norbert Junk	Präzisionswerkzeuge	Sulzbach
69507	150687	Jäger-Plastik GmbH & Co. KG	Kunststoffspritzgußwerk	Engelskirchen-Loope
69508	150688	Hermann Jaeger GmbH		Hamburg
69509	150689	Kahrl + Wiemann GmbH	Industrievertretungen	Wermelskirchen
69510	150690	Keiper GmbH	Großhandel	Taunusstein
69511	150691	Redko GmbH	Niederlassung Kiel	Kiel
69512	150692	KALM	Befestigungssysteme GmbH	Kaiserslautern
69513	150693	Kerschgens Werkstoffe und Mehr	GmbH	Stolberg / Rhld.
69514	150694	BK Elmar Knobling	GmbH & Co. KG	Wassenberg-Ophoven
69515	150695	Kämper Werkzeuge		Radevormwald
69516	150696	Karl Jöcker	GmbH & Co. KG	Singen
69517	150697	Walter Cordbarlag GmbH & Co.		Bielefeld
69518	150698	JRB Handelsvertretungs GmbH	DER HEIMWERKER	Falkensee
69519	150699	Konnex - IT GmbH		Hameln
69520	150700	KBM	Handelsgesellschaft mbH	Salzatal OT Schiepzig
69521	150701	E. Werner Koch	techn. Groß- und Einzelhandel	Gummersbach
69522	150702	Rolf King	Werkzeuge	Rickenbach
69523	150703	Kinker GmbH		Peiting
69524	150704	Baufachmarkt Knöpfle GbR	Inh. Achim Langenbacher	Blumberg
69525	150705	Uwe Kloska GmbH	Technischer Ausrüster	Bremen
69526	150706	KB - Fenster GmbH		Kruft
69527	150707	Fritz Kruse	Baumaschinen GmbH	Hagen
69528	150708	Kaiser GmbH & Co. KG		Schalksmühle
69529	150709	Kasprick Diamantwerkzeuge GmbH		Köln
69530	150710	Carl Kürle e.K.	Techn. Großhandlung	Lübeck
69531	150711	Käsbeitzer J.	Werkzeuge	Hengersberg
69532	150712	Heinz Baustoffe	Fachmarkt - Fliesen- Werkzeuge	Ingolstadt/Donau
69533	150713	Krapp Eisen GmbH & Co.KG		Dinklage
69534	150714	Eisen-Kehrer	Thomas Kehrer	Großostheim
69535	150715	Volker Klein	Werkzeuge für Bauhandwerk + Industr	Quierschied
69536	150716	Kroboth Baumaschinen GmbH		Seligenstadt-Froschhausen
69537	150717	Sicherheitstechnik Krauße GmbH		Saalfeld
69538	150718	Kühn Sicherheit GmbH	Haus für Sicherheit	Hannover
69539	150719	Erich Viohl KG		Bremen
69540	150720	KTS GmbH	Kunststoff-Technik Service	Werne
69541	150721	Gerd Kottmeier	Werkzeughandel + Reparatur	Vlotho
69542	150722	Kuhlmann GmbH & Co. KG		Borken
69543	150723	Klamor GmbH	Baumaschinenhandel & Vermietung	Dortmund
69544	150724	HEINZ GmbH		Rodewisch/V.
69545	150725	Küne + Sehringer GmbH	Bedachungs-Fachgroßhandel	Phillipsburg (Rheinsheim)
69546	150726	Kaiser GmbH	Holzbearbeitungsmaschinen	Wuppertal
69547	150727	P. Kilbinger KG		Neuss
69548	150728	KHS Haustechnik GmbH		Schneverdingen
69549	150729	Arno Koch	Großhandel	Neunkirchen
69550	150730	W. Schweisfurth	Eisenwaren und Industriebedarf	Kreuztal
69551	150731	DESOI GmbH		Kalbach / Rhön
69552	150732	Kunkel GmbH	Befestigungssysteme	Saarbrücken
69553	150733	Kress-elektrik GmbH	& Co. KG, LKZ 811088	Bisingen
69554	150734	Stefan Kuhnen GmbH		Trier
69555	150735	Franz Kerstin Hausbau GmbH & Co. KG	(AH.-Nr. 10115 VL 77336 ZR-Nr.0135)	Soest
69556	150736	MH - Montagen, Schweißtechnik und	Handel	Mainz - Kostheim
69557	150737	Oliver Lehmann KDO Marine Service		Hamburg
69558	150738	Klein Baubeschläge GmbH		Wiehl
69559	150739	km GbR		Neustadt
69560	150740	Heinrich Küpper e.K.		Gummersbach
69561	150741	Hermann Kemper GmbH & Co. KG		Remscheid
69562	150742	Johann Kirschner Werkzeug- und	Maschinenhandel	Eichstätt
69563	150743	Heinrich KUPER GmbH & Co. KG		Korbußen
69564	150744	Kaprotex GmbH		Marktredwitz
69565	150745	Kirsch BioPharm GmbH		Wedemark OT Bissendorf
69566	150746	Kühl-Qualitätswerkzeuge-Baugeräte-	Baumaschinen und Vermietungs GmbH	Eisenberg
69567	150747	Kapeller Solar - Heizung - Sanitär		Wolfsburg
69568	150748	Tischlerei Markus Köser GmbH		Wipperfürth
69569	150749	Robin Klautzsch	Eisenwaren	Derschen
69570	150750	Lindenthaler Metallwaren	Matthias Lotz	Gera
69571	150751	Lahm & Halpaus Ges. für	Befestigungstechnik GmbH	Mannheim
69572	150752	Heinz Werner Lang	Werkzeughandel	Remscheid
69573	150753	Heinrich Lütticken GmbH	Stahlhandel	Wittlich
69574	150754	Lössl Wolfgang	Schreinereibedarf	Rosenheim
69575	150755	A. Leistner	Werkzeugtechnik GmbH & Co. KG	Stützengrün
69576	150756	LB-Werkzeugtechnik GmbH		Mulda
69577	150757	Emil Lux  GmbH & Co. KG	Werkzeughandel	Wermelskirchen
69578	150758	Lauerer GmbH		Zachenberg
69579	150759	Lukas Erzett	Vereinigte Schleif- und Fräswerkzeu	Engelskirchen
69580	150760	Leipziger Kisten- und	Leistenfabrik GmbH	Leipzig
69581	150761	KEIL Befestigungstechnik GmbH		Engelskirchen
69582	150762	LH Haustechnik	SANITÄR/Heizung/Elektrik	Leichlingen
69583	150763	Lidac Deutschland GmbH		Dortmund
69584	150764	Maik Jansen		Engelskirchen
69585	150765	LUDIS Handel Spezial		Bornheim
69586	150766	Leysser Sanitär Heizung Fliesen Gmb	(NW 30071)	Idar-Oberstein
69587	150767	Lutz Eduard	Schrauben-Werkzeuge GmbH	Weilheim
69588	150768	Liesk Baustoffe GmbH		Schwarzheide
69589	150769	LEOLO Trailerzubehör	Inh. C. Rommersbach	Saerbeck
69590	150770	LK-Werkzeuge		Mandelbachtal
69591	150771	Schweißtechnik Thöne GmbH	Linde Gas & More	Aachen
69592	150772	Laubrock KG		Havixbeck
69593	150773	Klaus Meier GmbH	Werkzeuge & Maschinenhandel	Trier
69594	150774	IFP Ihr Fachhandelspartner	Werkzeug + Ausstattung GmbH	Berlin
69595	150775	Martens Dieter	Baudienstleistungen	Engelskirchen
69596	150776	Michlbauer -Baugeräte		München
69597	150777	Rabied Biedron Diamanttechnik GmbH		Bad Liebenzell
69598	150778	Melle Gallhöfer Dach GmbH	Niederlassung Betriebsbedarf	Osterode/Harz
69599	150779	Mayer Anton	Befestigungstechnik	Illertissen
69600	150780	Muskat GmbH		Hamburg
69601	150781	Müller Horst GmbH		Ratingen
69602	150782	Schwirten GmbH & Co.KG	Metallwarenfabrik	Marienheide
69603	150783	Mann & Magar GmbH     HB-Nr.628830	Baugeräte/ Baumaschinen	Merzig/Saar
69604	150784	Ulrich Manzke	Stahlbau & Handel GmbH Teterow	Teterow
69605	150785	Miersch & Stephan GmbH	Fachh. f. Dach & Fassade	Dresden
69606	150786	Michels Schraubenquelle GmbH		Ladeburg
69607	150787	Migacut		Moosburg/Isar
69608	150788	Mack GmbH		Burgheim
69609	150789	Melle Gallhöfer Dach GmbH	Niederlassung Osterode	Osterode am Harz
69610	150790	Melle Gallhöfer Dach GmbH	Niederlassung Nordhausen	Nordhausen
69611	150791	Melle Gallhöfer Dach GmbH		Landsberg/OT Gütz
69612	150792	Melle Gallhöfer Dach GmbH		Amt Wachsenburg
69613	150793	Melle Gallhöfer Dach GmbH		Emersleben
69614	150794	Melle Gallhöfer Dach GmbH		Lohfelden
69615	150795	Melle Gallhöfer Dach GmbH	Niederlassung Biebesheim	Biebesheim
69616	150796	Bernard Menge	Inh. Wilhelm Menge	Recklinghausen
69617	150797	Josef Dietl	Autoteile & Werkzeuge	Neukirchen
69618	150798	Montage Service direkt		Kreßberg-Marktlustenau
69619	150799	UDITEC Diamantwerkzeuge	Inh. Rainer Ufer	Lindlar
69620	150800	Maja Industriebedarf		Remscheid
69621	150801	M & F Werkzeughandel GmbH		Windeck
69622	150802	Hoffmann Diamant Technik	Diamantwerkzeuge Erdraketen,Baum.	Niederkassel-Ranzel
69623	150803	W. Markmiller oHG	Eisen-Heizung-Sanitär-Küchen	Rennertshofen
69624	150804	Werkzeughandel Möller	Inh.Thomas Möller	Königsee
69625	150805	MBM Maschinen-& Werkzeughandel	Wolfgang Rieß	Mauschbach
69626	150806	Moser Industrieposten	Siegfried Moser	Haag i. OB.
69627	150807	Stefan Meyer	Industrie- und Werkstattprodukte	Bad Schwartau
69628	150808	Dieter Ueberberg	Inh. Daniel Ueberberg	Engelskirchen
69629	150809	MK Montagetechnik GmbH		Pirmasens
69630	150810	GT Gerätetechnik GmbH		Wels
69631	150811	Rosemarie Reiser		Kirchhaslach
69632	150812	H.Marx GmbH & Co.      L-Nr.70910	Schreinerei-Bedarfsartikel KG	Limburg -Staffel
69633	150813	Melle Gallhöfer Dach GmbH	Niederlassung MVG Genthin	Genthin
69634	150814	Multipick Direct GmbH		Bonn
69635	150815	Metz Diamant- und Schleiftechnik		Herxheim
69636	150816	Mabau-Handel GmbH		Konz
69637	150817	Johann Moissl	Metall- und Balkonbau	Kröning
69638	150818	Dobler-MBM GmbH		Möckmühl
69639	150819	Elektro-Mechanik Meisl GmbH		Berchtesgaden
69640	150820	Sascha Meerpohl Metallbau	Meisterbetrieb	Apen
69641	150821	Fachmarkt Ewald Mayer		Engen
69642	150822	Neumann GmbH	Vertretungen	Laatzen
69643	150823	Nedschroef Altena GmbH		Altena
69644	150824	N.E.S. GmbH		Lüdenscheid
69645	150825	R. Pöppel GmbH & Co. KG	Maschinen u. Werkzeuge	Memmingen
69646	150826	Netzband Bauzentrum GmbH		Neu Isenburg
69647	150827	Fachhaus Andreas Nickel (e.K.)	Inh. Andreas Gromeier	Salzwedel
69648	150828	Natursteinservice	Inh. Carsten Zieschang	Vierkirchen
69649	150829	Nicolay	Fachgroßhandel für Dach- und	Wuppertal
69650	150830	Wolfgang Nieweg GmbH		Osnabrück
69651	150831	Mohr Steffen Dachbaustoffe GmbH		Stade-Wiepenkathen
69652	150832	Elektro-Pönicke GmbH		Zeulenroda-Triebes
69653	150833	Primero-Schiefer GmbH		Wipperfürth
69654	150834	Effektiv-Werkzeuge	und Maschinen	Remscheid
69655	150835	NV Technische Waren	Inhaber: Tomislav Vrdoljak	Frankfurt am Main
69656	150836	Alfred Oberhofer Werkzeuge Gartenbe		Langquaid
69657	150837	Andreas Nölling	Handelsvertretung	Morsbach
69658	150838	Metabau Reinsdorf	Inh. Tom Gottschall	Wittenberg
69659	150839	Ostendorp Frank	Schrauben und Dübel	Leverkusen
69660	150840	OTEC - Olaf Otto		Freudenberg
69661	150841	Oeben Werkzeugmaschinen	Inh. Ulrich Oeben	Mönchengladbach
69662	150842	Ostermann Inh. Garnreiter	Bau- und Möbelbeschläge	Rosenheim
69663	150843	Martin Geus	Meisterbetrieb	Kürten
69664	150844	Pirson GmbH		Nauheim
69665	150845	Orbis Will GmbH + Co. KG		Ahaus
69666	150846	Detlef Paulsen Betriebsausrüstung G	& Co. KG	Kiel
69667	150847	Auto Nagel A33 GmbH & Co. KG		Borgholzhausen
69668	150848	Parzinger Baustoffe		Altenmarkt
69669	150849	BVS - Tagewerben GmbH	Baumaschinen	Weißenfels/ OT Tagewerben
69670	150850	Plastoform GmbH		Waldachtal-Salzstetten
69671	150851	Friedhelm Seidler		Wesel
69672	150852	Päpke Mario	Arbeitsschutz von A-Z	Teltow
69673	150853	Putsch Wilhelm GmbH & Co. KG		Remscheid-Hasten
69674	150854	Reca Norm GmbH & Co. KG		Ingolstadt
69675	150855	Pfeiffer, August GmbH		Stetten
69676	150856	MPS-Sägen GmbH		Wasserliesch
69677	150857	Plegge + Bauer	Baubeschläge GmbH	Kaiserslautern
69678	150858	Han Miet-Service GmbH		Offenbach/Main
69679	150859	Werkstattservice Roland Peldßus	Inh. Cornelia Wachsmuth	Neubrandenburg
69680	150860	Picard GmbH		Wuppertal
69681	150861	Nikolas Papendorf	Baustoffe, Holzbau, Bauservice	Gifhorn
69682	150862	diaX Diamantwerkzeuge		Malsch
69683	150863	Lars Jelonnek	Der Tresorchirurg	Köln
69684	150864	ProKilo GmbH & Co.KG		Engelskirchen
69685	150865	ProKilo GmbH Co. KG		Köln
69686	150866	Polizeipräsidium Einsatz	Direktion Spezialeinheiten -	Göppingen
69687	150867	Peters Eisenwaren		Friesenheim
69688	150868	August Richter Eisen-,	Röhren- und Eisenwaren	Geseke
69689	150869	Relma GmbH		Zwickau
69690	150870	rictools Innovative Werkzeuge	Inh. Christian Richter	Ingelheim
69691	150871	Theodor Riewer	Handelsgesellschaft mbH	Bitburg
69692	150872	Riedelsche Dachbaustoffe GmbH		Stralsund
69693	150873	Riedelsche Dachbaustoffe GmbH		Rostock
69694	150874	Gerh. Rottländer GmbH & Co. KG		Overath
69695	150875	Runge-TSN	Technischer Service Nord GmbH	Kisdorf
69696	150876	Rettenberger GmbH &Co KG	Holz-und Heimwerkermarkt	Ottobrunn
69697	150877	ZTR Rossmanek GmbH	Werkzeuge und Maschinen	Balve
69698	150878	Jörg Rauh Handelsvertretung		Schönheide
69699	150879	Robbers Industriebedarf GmbH		Sögel
69700	150880	Otto Roller e.K.	Inh. Kersten Roller	Pirmasens
69701	150881	BMI Deutschland GmbH	Zentraler Rechnungseingang	Oberursel
69702	150882	Riedt GmbH	Beschlag-Systeme	Mosbach
69703	150883	Alexander Rillmann		Annweiler am Trifels
69704	150884	Frank Rohde	Handelsvertreter für Tischlerei-	Greifswald
69705	150885	DWB	Dach- und Wandbaustoffe	Minden
69706	150886	F. Walter Roth KG	Eisen- und Sanitär-Großhandel	Salzgitter-Lebenstedt
69707	150887	RVS Streit Schrauben		Ried
69708	150888	RBV	Ravensberger Baustoff-Vertrieb	Bielefeld
69709	150889	Ludwig Meister GmbH & Co. KG		Mainz
69710	150890	Rentas	Mietgeräte	Essen
69711	150891	Rentas	Mietgeräte	Gelsenkirchen-Schalke
69712	150892	Rentas	Mietgeräte	Recklinghausen
69713	150893	Rentas Mietgeräte	Inh. S. Krokor	Kreuztal
69714	150894	Rentas Mietgeräte	Inh. Thomas Danker	Wetzlar
69715	150895	Rentas Mietgeräte	Inh. Hans-Thomas Papsdorf	Hamm
69716	150896	Rentas Mietgeräte		Neubrandenburg
69717	150897	Christoph Röwekamp	Werkzeug und Maschinen	Wallenhorst
69718	150898	Rentas	Mietgeräte	Berlin
69719	150899	Bau- und Heimwerkermarkt	Sailer GmbH	Landsberg/ Lech
69720	150900	RENTAS	Mietgeräte	Köln-Dellbrück
69721	150901	RENTAS GmbH	Herr Markus Blachut	Duisburg-Meiderich
69722	150902	DWF Baustoff-Fachhandel GmbH		Berlin
69723	150903	Manfred Raskob	Werkzeuge-Maschinen GmbH	Wittlich
69724	150904	I&M Baustoffhandel	Bruchhof GmbH & Co. KG	Bendorf
69725	150905	RENTAS Mietgeräte		Euskirchen
69726	150906	RANIT Befestigungssysteme GmbH		Herten
69727	150907	Rentas Mietgeräte	(im toom-Baumarkt)	Duisburg-Rheinhausen
69728	150908	RKD Diamantwerkzeuge		Lutherstadt Eisleben
69729	150909	Röselers Werkzeuge	Inh. Marc Schütt	Ecklak
69730	150910	Rentas Mietgeräte	Inh. David Helbig	Falkensee
69731	150911	DBS Dachbaustoffe GmbH		Lübeck
69732	150912	Seipel	Industriebedarf	Hanau
69733	150913	Sommer Handelsgesell-	schaft mbH	Pirna
69734	150914	SBB Baumaschinenhandel GmbH		Schneverdingen
69735	150915	Sartorius Werkzeuge GmbH & Co.KG		Ratingen
69736	150916	Sauerwein & Dilcher	Liefer. Nr.74508	Bad Hersfeld
69737	150917	Seelbach International GmbH		Rennerod
69738	150918	Sindele Richard		Spaichingen
69739	150919	Sarris GmbH	Werkzeuge Maschinen	Remshalden
69740	150920	Sievering GmbH & Co. KG		Steinheim
69741	150921	Südmetall Otto Leonhard GmbH		Maisach
69742	150922	G. Sachs Eisenwaren GmbH		Kulmbach
69743	150923	SAKO Maschinen-Handels GmbH		Dinslaken
69744	150924	sauter GmbH		Herrsching
69745	150925	Süd-Metall	Beschläge GmbH	Ainring-Hammerau
69746	150926	Paul Seidler	Werkzeuge und Industriebedarf	Bautzen
69747	150927	Troglauer GmbH	(AH.-Nr. 10383, VL 77336, ZR-Nr.013	Bingen
69748	150928	PROFISHOP GmbH		Bremen
69749	150929	Sprödhuber & Sprödhuber GmbH	Holzbearbeitungsmaschinen, Service	Barbing
69750	150930	SFT-Bauelemente		Frankfurt am Main
69751	150931	Gerd Seitz GmbH		Dürrwangen
69752	150932	SANPRO® GmbH		Wermelskirchen
69753	150933	Schindler Eisenhandel GmbH		Landsberg/Lech
69754	150934	Scharpf E. GmbH	Holzbau Zimmerei	Esslingen
69755	150935	Raiffeisen Baumarkt GmbH		Willich
69756	150936	Schönberger + Weiss GmbH	Holztechnik	Nürnberg
69757	150937	Schirmer Elektromaschinenbau		Stendal
69758	150938	Hans Schmidt GmbH	Werkzeuge-Maschinen	Kaiserslautern
69759	150939	H. Schallenberg GmbH & Co.KG		Lengerich
69760	150940	Schützeichel GmbH & Co. KG	Gerätebau Wiedtal	Neustadt/Wied
69761	150941	Schär Tools GmbH & Co.KG		Crimmitschau
69762	150942	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Eifel
69763	150943	Stitz Hermann & Co.	Fachgroßhandel für Haustechnik	Barsbüttel
69764	150944	Präzisionswerkzeuge Wurzen	Dipl.-Ing. (FH) Uwe Schmidt	Wurzen
69765	150945	Schäpers GmbH		Essen
69766	150946	Schüller Dachbaustoffe GmbH & Co.KG		Laubach/Mayen
69767	150947	HDL Industrievertretung GmbH	-Gewerbegebiet Hommerich-	Lindlar / Hommerich
69768	150948	Schrauben Schneider Dortmund	Norbert Schneider	Dortmund
69769	150949	Dieter Schmidtke	Werkzeuge und Maschinen	Overath
69770	150950	Franz Scheitler	Baugeräte Werkzeuge	Taufkirchen-Potzham
69771	150951	Schleyer Sicherheit + Technik	Inh. R. Schramm	Wetter
69772	150952	Michael Schlittmeier GmbH		Vilsbiburg
69773	150953	Florian Schmideder	Eisenwaren - Werkzeuge - Normteile	Landshut
69774	150954	Klaus Schäffer	Handelsvertretung	Gommersheim
69775	150955	Schröder GmbH		Saarbrücken / Gersweiler
69776	150956	SCHLEMER GmbH	Baustoffhandel,Agrarhandel	Au bei Bad Aibling
69777	150957	M. Schulte Söhne GmbH & Co. KG		Linz
69778	150958	BAUFIX Bau - und Werkzeugbedarf	Reinhard Schermutzki	Waren (Müritz)
69779	150959	Schroeder GmbH	Das Elektrohaus	Friedberg
69780	150960	Klaus Schindler GmbH		Engelskirchen
69781	150961	Schedler KG	Fachgroßhandel für Haustechnik	Siegen
69782	150962	Gase-Center Schürmann	Holger Schürmann	Meinerzhagen
69783	150963	BSG Schünke		Heideland/ OT Königshofen
69784	150964	Schuster KG		Weingarten
69785	150965	XXL-Automotive GmbH & Co. KG		Haßfurt
69786	150966	BE-Vertrieb	Burkhard Schulze	Königstein
69787	150967	Peter Schmid Technischer Bedarf e.	Inh. Holger Schmid	Villingen-Schwenningen
69788	150968	Christian Schallenberg GmbH		Köln
69789	150969	Mario Schierlinger		Sinzing - Viehhausen
69790	150970	Schlesinger Elektrofachmarkt		Klipphausen
69791	150971	Stock  B.I.G. GmbH	(AH-Nr. 10090, VL 77336 ZR-Nr. 0135	Siek
69792	150972	Stiegeler	Eisenwaren und Brennstoffe e.K.	Kirchheim / Schw.
69793	150973	Stock  B.I.G. GmbH		Siek
69794	150974	Stinner GmbH	Baustoffe	Morsbach
69795	150975	Straacher Produktions- u. Handels-	GmbH	Lutherstadt Wittenberg
69796	150976	Steinbach Horst	Titan-Werkzeuge	Hude
69797	150977	Günter Steffan	Werkzeugvertretung	Harsewinkel
69798	150978	Peter Stolz Baustoffe		Bergweiler
69799	150979	Steiko GmbH		Hilpoltstein
69800	150980	Grabmale Strässer GmbH		Engelskirchen
69801	150981	Sikur	Chemische Produkte GmbH	Heinsberg
69802	150982	ASR-Rollen		Selters
69803	150983	MTW Tools UG		Wiesbaden
69804	150984	Stümpel GmbH & Co. KG	Dachzubehör - Werkzeuge -	Bad Wünneberg - Haaren
69805	150985	Süd Tech Handelsges. mbH		Köln
69806	150986	Lechner GmbH & Co. KG	Zerspanungstechnik	Leverkusen
69807	150987	SUCHY Montagetechnik GmbH		Bayreuth
69808	150988	Sikora Werkzeuge	Bruno Sikora	Dreieich
69809	150989	Steiner Haustechnik KG	Fachgroßhandel für Haustechnik	Bergheim bei Salzburg
69810	150990	TAUTZ Druckluft- und	Sandstrahltechnik GmbH	Mannheim
69811	150991	Tox-Duebel-Technik GmbH		Krauchenwies-Ablach
69812	150992	Techro GmbH		Rösrath
69813	150993	Thote-Industriebedarf GmbH		Henstedt-Ulzburg
69814	150994	Elektro-Walk	Werkzeuge Motoren	Salzwedel
69815	150995	Witte-Metallwaren GmbH+Co.KG		Beckum
69816	150996	trobatec GmbH	Dachbaustoffe	Niedernhall
69817	150997	Toge Dübel GmbH & Co. KG		Nürnberg
69818	150998	Thüringer Handels-GmbH	Forst- und Gartentechnik	Zella-Mehlis
69819	150999	THG Technik Handel Götze GmbH		Heinsberg
69820	151000	Thüringer Handels-GmbH	Forst- & Gartentechnik	Zellla-Mehlis
69821	151001	Thumm & Co.		Nürtingen
69822	151002	TecNet	FachGroßHandel für Elektro-	Köln-Dellbrück
69823	151003	witec GmbH	Werkzeug- und Industrietechnik	Rödermark
69824	151004	Baufachmarkt Wittmann GmbH	Baustoffe - Fliesen	Wendelstein- Gsl.
69825	151005	Baubedarf Thiele		Erfurt
69826	151006	Tools - Vertrieb & Service	Karsten Siegismund	Lossatal Ortsteil: Falkenhain
69827	151007	TRP Beschläge GmbH	Michael Thode	Lübeck
69828	151008	Tools Rent 24 GmbH		Ratingen
69829	151009	Peter Trepke	Vertrieb von Verbindungselementen	Romrod/Ober-Breidenbach
69830	151010	TRP Beschläge GmbH		Berlin
69831	151011	Coenen UG (Haftungsbeschränkt)		Kranenburg
69832	151012	Technikhandel	Inh. Mario Keith	Arnstadt
69833	151013	AMG HAUSTECHNIK KG		Niederzier
69834	151014	ARENS & STITZ HAUSTECHNIK		Pinneberg
69835	151015	Meier KG		Urmitz
69836	151016	Cordes & Graefe Osnabrück KG	Fachgroßhandel für Haustechnik	Osnabrück
69837	151017	Hermann Stitz & Co. Rostock KG	Fachgroßhandel für Haustechnik	Dummerstorf
69838	151018	Sächsische Haustechnik Dresden KG		Klipphausen
69839	151019	Cordes & Graefe Bremen KG	Haustechnik	Stuhr
69840	151020	HS-C. Hempelmann Schönebeck KG	Fachgroßhandel für Haustechnik	Schönebeck
69841	151021	Seegers KG	Fachgroßhandel für Haustechnik	Altenstadt
69842	151022	HS-C.Hempelmann KG	Fachgroßhandel für Haustechnik	Hildesheim
69843	151023	Gottschall & Sohn KG	Fachgroßhandel für Haustechnik	Grevenbroich
69844	151024	HS-C.Hempelmann Kassel KG	Fachgroßhandel für Gebäudetechnik	Kassel
69845	151025	Karl Brand KG	Fachgroßhandel für Gebäudetechnik	Gütersloh
69846	151026	Vollbrecht + Pohl KG	Fachgroßhandel für Haustechnik	Rendsburg
69847	151027	Cordes & Graefe Stade KG	Fachgroßhandel für Haustechnik	Stade
69848	151028	Wilhelm Gienger Mannheim KG	Fachgroßhandel Für Haustechnik	Mannheim
69849	151029	Gienger & Renz KG		Öhringen
69850	151030	Sächsische Haustechnik Edki KG	Fachgroßhandel für Haustechnik	Hartenstein/OT Thierfeld
69851	151031	Heldt Sauerland KG	Gebäudetechnik	Meschede
69852	151032	Sächsische Haustechnik Leipzig KG	Fachgroßhandel für Haustechnik	Markranstädt
69853	151033	Franz Silberhorn KG	Fachgroßhandel für Haustechnik	Friedberg
69854	151034	Eisenvater & Stitz KG	Haustechnik	Lüneburg
69855	151035	Rath KG	Fachgroßhandel für Haustechnik	Hochheim
69856	151036	Gienger & Funk KG Haustechnik		Wendelstein
69857	151037	Gienger München KG Haustechnik		Markt Schwaben
69858	151038	Hassmann KG	Fachgrosshandel f. Haustechnik	Hof
69859	151039	Gienger Erlstätt KG	Fachgroßhandel für Haustechnik	Grabenstätt
69860	151040	Karl Endrich KG	Fachgroßhandel für Haustechnik	Würzburg
69861	151041	Holzhauer KG		Merzig
69862	151042	Haustechnikhandel Halle-Dessau KG	Diemitz	Halle
69863	151043	G.U.T. Feldtmann KG		Lübeck
69864	151044	Birk KG		Nürtingen
69865	151045	Gienger Memmingen KG	Fachgroßhandel für Haustechnik	Memmingen
69866	151046	Kemmerling KG	Fachgroßhandel für Haustechnik	Köln
69867	151047	Gienger KG	Fachgroßhandel Haustechnik	Ettlingen
69868	151048	Rhein Ruhr Collin KG	Fachgroßhandel für Haustechnik	Duisburg
69869	151049	Bucher KG		Zimmern
69870	151050	Neugart KG	Fachgroßhandel für Haustechnik	Hennef
69871	151051	Max Carl KG	Fachgroßhandel für Haustechnik	Großheirath
69872	151052	Eisenvater KG	Fachgroßhandel für Haustechnik	Schwülper
69873	151053	Bär & Ollenroth KG	FGH für Haustechnik und Industriebe	Berlin
69874	151054	Fendel KG		Dessau-Roßlau
69875	151055	Friedrich Wüst KG	Fachgroßhandel Haustechnik	Stuttgart
69876	151056	Franz Scheuerle Ulm KG		Ulm
69877	151057	Heuer GmbH & Co. KG		Timmendorfer Strand
69878	151058	COBE Bauspezialartikel	Inh. Tiemo Fischer	Cottbus
69879	151059	Wilhelm Gienger KG	Fachgroßhandel für Haustechnik	Kornwestheim
69880	151060	August Brötje KG	Fachgroßhandel für Haustechnik	Bremen
69881	151061	Herbert Heldt KG	Gebäudetechnik	Bergkamen
69882	151062	G.U.T. Emmel KG		Leimen
69883	151063	August Brötje Handel KG	Fachgroßhandel für Haustechnik	Rastede
69884	151064	HS-C. Hempelmann KG Hannover	Fachdgroßhandel für Haustechnik	Langenhagen
69885	151065	Conmetall Meister GmbH		Wuppertal
69886	151066	TAG - Technische Anlagen Wagner	Inhaber: Frank Altenburg	Karsdorf
69887	151067	Bucher KG	Fachgroßhandel für Haustechnik	Freiburg im Breisgau
69888	151068	TECTO Dachbaustoffe GmbH		Stolpen
69889	151069	WITTE Werkzeuge	KIRCHHOFF Witte GmbH	Hagen-Fley
69890	151070	G.U.T. Feldtmann Gebäudetechnik KG	Barmbek-Nord	Hamburg
69891	151071	HTI Collin & Schulten KG	Zentrale Rechnungsprüfung	Duisburg
69892	151072	Meiler GmbH		Erkheim
69893	151073	HS-C.Hempelmann KG	Fachgroßhandel für Haustechnik	Hildesheim
69894	151074	Thewa GmbH	Bereich Shop	Wessling Neuhochstadt
69895	151075	ELPRON GmbH		Zossen
69896	151076	Max Pohlhaus	Inh. Jörg Priebe e. K.	Borkwalde
69897	151077	US-Service GmbH		Lehmrade
69898	151078	Philipps + Sturm GmbH & Co. KG	Gerüstbaubedarf	Niedernhall-Waldzimmern
69899	151079	Marcel Bornemann		Hamburg
69900	151080	B. VOMBERG GmbH & Co. KG		Schlüchtern
69901	151081	Vogt	Industrievertretungen GmbH	Bielefeld
69902	151082	Viessmann Modelltechnik GmbH		Hatzfeld-Reddighausen
69903	151083	Volk Sicherheitstechnik e.K.	Nikolaus Siegel	Ravensburg- Oberzell
69904	151084	Andreas Vollmert		Porta Westfalica
69905	151085	Peter von Ohle GmbH		Essen
69906	151086	Werkzeug-Kontor Lübeck	Inh. Thomas Hinz e.K	Lübeck
69907	151087	Vahldiek Verbindungs- und	Befestigungstechnik GmbH	Braunschweig
69908	151088	Westfalia Werkzeugcompany	GmbH & Co. KG	Hagen
69909	151089	WHS Werkzeughandel GmbH		Stutensee
69910	151090	Fachzentrum Wepler		Kirchhain
69911	151091	Weimeister Christian	Die Eisenkrämerei GmbH	Hamburg
69912	151092	Wakai GmbH		Frankfurt
69913	151093	Winte Klaus		Stuhr
69914	151094	Dieter Wich GmbH & Co. KG	Werkzeuge	Lentföhrden
69915	151095	Wartner Uwe	Werkzeuge	Bogen
69916	151096	Greiner tools & technics	Inh. Robert Greiner	Suhl-Wichtshausen
69917	151097	Michael Grenz		Hannover
69918	151098	WSH GmbH & Co. KG	Sanitär- & Heizungsgroßhandel	Warendorf
69919	151099	Wera Werkzeuge Gmbh		Wuppertal
69920	151100	gwk-Befestigungstechnik GmbH		Kitzingen
69921	151101	WEBU Werkzeugtechnik	Andreas Withoeft e.K.	Schneverdingen/Insel
69922	151102	Willig Werkzeuge		Delitzsch / OT Schenkenberg
69923	151103	Athlet-Qualitätswerkzeuge	WURO Wilhelm Uebach GmbH & Co. KG	Freudenberg-Niederndorf
69924	151104	WWB Dachbaustoffe GmbH & Co. KG		Köthen (Anhalt)
69925	151105	Otto Weirich GmbH + Co KG	Baustoff - Sanitärhandel	Breidenbach-Achenbach
69926	151106	Winkelmann GmbH & Co. KG	Harald Winkelmann	Lübbecke
69927	151107	Wüst Fernmeldetechnik	Michael Wüst	Ludwigshafen
69928	151108	WEBA Schulausstattung GmbH		Hirschhorn
69929	151109	Walther Baumaschinen und Geräte Gmb		Eisenberg
69930	151110	WEDA	Roland Werner GmbH	Reutlingen
69931	151111	WADO	Partner von Handel, Handwerk und	Riederich
69932	151112	Schrauben Schwarz	Heinz-Wolfgang Schwarz	Köln
69933	151113	Wohlhüter GmbH		Ravensburg
69934	151114	Celo	Befestigungssysteme GmbH	Aichach
69935	151115	Richard Weber	Groß- und Einzelhandel	Euskirchen
69936	151116	Wetec GmbH & Co. KG		Remscheid
69937	151117	Andreß	Industrie- & Handelsvertretung	Kleinostheim
69938	151118	FHS - Freie Handelsvertretung	Udo Weyrauch	Monzingen
69939	151119	WEPO GmbH		Leverkusen
69940	151120	Georg Friedr. Wiechard GmbH & Co. K		Lauterbach
69941	151121	Wegertseder GmbH		Ortenburg
69942	151122	Heinrich Wacker e.K.		Lüdenscheid
69943	151123	Alexander Klippenstein		Hannover
69944	151124	W & S Werkzeug und Schrauben GmbH		Rödermark
69945	151125	Die Werkkiste	Krautwald & Trölsch GmbH	Hamburg
69946	151126	Hans Willibald	Maschinenbau + Industrieservice	Gaißach Obergries
69947	151127	Handelsagentur	Elke Wohlleb	Reutlingen
69948	151128	Elting KG		Dülmen
69949	151129	WUNEX Einkaufs- GmbH & Co. KG		Trier
69950	151130	Rudolf Krämer Eisenwaren GmbH		Duisburg
69951	151131	WS GmbH	Bau & Handel	Krefeld
69952	151132	BZN Bauzentrum Esens	GmbH & Co. KG	Esens
69953	151133	Stefan Weiss	Werkzeughandel	Friedberg
69954	151134	Zinnkann GmbH	Eisenwaren-Schließanlagen	Worms
69955	151135	Zwiener GmbH & Co. KG		Laer
69956	151136	Hans Zellmer GmbH		Seeshaupt
69957	151137	Michael Zinsmeister	-Metallbaumeisterbetrieb-	Bad Feilnbach
69958	151138	Metallbau Denzer		Overath
69959	151139	Stefan Stuht GmbH		Ribnitz - Damgarten
69960	151140	Schwarzt GmbH		Lahmspringe
69961	151141	4 POWERPAC GROUP LTD.		Wellington 5240
69962	151142	COBA-Baustoffgesellschaft	für Dach + Wand GmbH & Co. KG	Osnabrück
69963	151143	RENTAS Mietgeräte	Inhaber: Jürgen Heyduck	Hattingen
69964	151144	Imexa d.o.o.		Ljubljana, Slowenien
69965	151145	Tile EZE	Abi Michailidis	Naples, Florida 34108-0124 USA
69966	151146	Borgh B.V.		AD Almere
69967	151147	Gebr. Huth KG		Bremerhaven
69968	151148	Pantaleo Stomeo		Engelskirchen
69969	151149	Cordes & Graefe KG		Bremen
69970	151150	EK/servicegroup		Bielefeld
69971	151151	Nordwest Handel AG		Dortmund
69972	151152	KEM	Krämer Einkauf + Marketing Gruppe	Duisburg
69973	151153	Kasprick Diamantwerkzeuge GmbH		Köln
69974	151154	Gerätebau Wiedtal - Schützeichel	GmbH & Co. KG	Neustadt/Wied
69975	151155	FDF-Dienstleistungsgesellschaft mbH	Cooperation für Einkauf, Logistik	Wilnsdorf
69976	151156	Hülsewig Karl	Steinindustriebedarf	Witten
69977	151157	Andreas Stockbauer		Waldkirchen
69978	151158	Interpares Mobau (Zentrale)	GmbH & Co. KG	Karlsruhe
69979	151159	HS Handelsagentur Import + Export	Hans Schlüter	Brande-Hörnerkichen
69980	151160	VIKING Tools Inc.		Gyeonggi-do 13017 South KOREA.
69981	151161	LLC Speceurotools	Office 2	Minsk
69982	151162	Löhle KG		Grolsheim
69983	151163	Weber Werkzeuge		83365 Nußdorf (Oberbayern)
69984	151164	DRILTEC, LLC		Byram, MS  39272
69985	151165	Heller Tools GmbH		Dinklage
69986	151166	UAB Kesko Senukai Lithuania		KAUNAS
69987	151167	EJOT Baubefestigungen GmbH		Bad Laasphe
69988	151168	wolfcraft SK s.r.o.		Male Dvorniky
69989	151169	wolfcraft GmbH	Warenlieferung	Kempenich
69990	151170	Adolf Würth GmbH & Co. KG		Künzelsau
69991	151171	VISWOOD		Sury Le Comtal
69992	151172	LYSI SAS		La Charité sur Loire
69993	151173	CD Juwel GmbH		Thyrnau
69994	151174	Dönges GmbH & Co. KG		Wermelskirchen
69995	151175	Franz Schoppe	Industrie- und Schiffsbedarf	Kiel
69996	151176	Madatex s.r.o.		Púchov
69997	151177	Josef Hansen GmbH & Co. KG		Solingen
69998	151178	Jäger Direkt Jäger Fischer GmbH & C	KG	Reichelsheim
69999	151179	MJM Werkzeugvertriebsgesellschaft	mbH & Co. KG	Rendsburg
70000	151180	NL Raab Karcher Meißen	STARK Deutschland GmbH	Meißen
70001	151181	Berliner Schrauben	GmbH & Co. KG	Berlin
70002	151182	Peter Belousow  GmbH		Schrobenhausen
70003	151183	Baustoff-Zentrum GmbH		Finsterwalde
70004	151184	Ernst Winterhoff GmbH & Co. KG		Remscheid
70005	151185	Schrauben-Listner	Inh.Stephan Listner	Brand-Erbisdorf
70006	151186	Dübel & Bohrer GmbH	Befestigungstechnik	Hamburg
70007	151187	JEVITH A/S		Roskilde
70008	151188	Beijing Jiu He Feng Construction	Hardware Co.,Ltd	Daxing district Beijing
70009	151189	Dachdecker-Einkauf	Soltau e.G.	Soltau
70010	151190	Holstein Alexander	Diamantwerkzeuge	Rieste
70011	151191	Bohle AG		Haan
70012	151192	Höynck & Spengler GmbH		Iserlohn
70013	151193	B.Schlichter GmbH & Co. KG		Lathen/Ems
70014	151194	MTA Schleif- und Befestigungs-	technik Vertriebs GmbH	Dasing
70015	151195	Rogger Fasteners AG		Grossaffoltern
70016	151196	Hans Möller & Sohn GmbH		Kelkheim
70017	151197	Marlow Holger	Werkzeughandel	Neubrandenburg
70018	151198	Thommel GmbH & Co. KG		Ravensburg
70019	151199	Carl Pfeiffer GmbH & Co. KG	Werkzeuge - Maschinen	Stockach
70020	151200	W. Holland-Letz GmbH & Co. KG		Bebra
70021	151201	HSB Handels- & Servicegesellschaft	für Baumaschinen mbH	Ensdorf
70022	151202	J. & F. Sorg GmbH		Düsseldorf
70023	151203	Schmieder Baumaschinen	Inh. Frank Bergerhausen	Troisdorf-Spich
70024	151204	Reinhard Wedel		Pommersfelden
70025	151205	Andreas Galler	Diamanttechnik & Spezialwerkzeuge	Waldhufen / OT Jänkendorf
70026	151206	Hahn + Kolb  Group	Werkzeuge GmbH	Ludwigsburg
70027	151207	Rülke OHG		Glauchau
70028	151208	AS Verbindungsteile	Inh. H. Antwerber	Köln
70029	151209	Oliver Grund Elektrowerkzeuge-	Handel- und Reparaturserivce	Duisburg
70030	151210	albw Handels GmbH	AH-Nr. 10162 VL-Nr. 77336 ZR-Nr. 01	Waghäusel-Kirrlach
70031	151211	Michael Baldino	Eisenwaren- und Werkzeuge	Sprendlingen
70032	151212	Eisen-Schmid GmbH & Co. KG		Hausach-Baden
70033	151213	Bau- & Kommunalservice Wegner		Waren/Müritz
70034	151214	MS Profiwerkzeuge		Sotzweiler
70035	151215	Hahn + Kolb  Group	Werkzeuge GmbH	Ludwigsburg
70036	151216	H&W Diamantwerkzeuge	Inh. Roland Bolze	Jena
70037	151217	Peter Herr	Werkzeuge und Maschinen	Baden-Baden
70038	151218	August Ring GmbH		Velbert
70039	151219	Pro Scheich		Fulda
70040	151220	O.K. Werkzeugservice	Olaf Jentzsch	Langenweißbach
70041	151221	Karcher K.E.	GmbH & Co. KG	Rheinau-Freistett
70042	151222	Herm. Stocks & Co.	(GmbH & Co)	Hamburg
70043	151223	Ingo Weber	Techn. Fachgroßhandel	Reichshof
70044	151224	Rüger GmbH	(NW 7696)	Rüsselsheim
70045	151225	Eduard Lutz Schrauben-Werkzeuge	Neuburg GmbH	Neuburg / Donau
70046	151226	Loesch shop GmbH		Quickborn
70047	151227	Rohse & Lipfert GmbH		Unterwellenborn
70048	151228	A & R Koch	Druckluft- und	Schlotheim
70049	151229	Achtermann GmbH		Troisdorf
70050	151230	TWH Trierer Werkzeughandel GmbH	(NW 7002)	Trier
70051	151231	Dachbaustoffe Rath GmbH u. Co. KG		Rostock
70052	151232	Alexander Erasmus GmbH + Co.		Düren
70053	151233	Kaiser & Stuckert	Industrie- und Baubedarf GmbH	Kiel
70054	151234	Chr. Ufer GmbH	Sanitär- und Stahlgroßhandlung	Landau
70055	151235	Karl Gollinger	Werkzeuge + Maschinen	Augsburg
70056	151236	Zwickert Eisenwaren GmbH		Emden
70057	151237	Ullner u. Ullner GmbH		Paderborn
70058	151238	Bertsch Natursteine	Rainer Bertsch	Dormettingen
70059	151239	Fendel Gebäudetechnik KG		Schwarzheide
70060	151240	Cord Jürgen Bruns		Wardenburg
70061	151241	SSG Schrauben Scholz GmbH		Berlin
70062	151242	PT. Majjatra Eizoku Indonesia		Bekasi - Jawa Barat
70063	151243	Schwan Werkzeuge	Hermann Schwandt e.K.	Remscheid
70064	151244	Stephan Heinitz		Kleinheubach
70065	151245	Lamello AG	Verbindungstechnik	Bubendorf
70066	151246	ILG GmbH	Elektrogroßhandel	Bonn
70067	151247	H.M. Lemke Handelsagentur e.K.		Königswinter
70068	151248	GEMAX Werkzeuge GmbH & Co. KG		Trier
70069	151249	BJC Tools Erp		EL Erp
70070	151250	Keil Fördertechnik GmbH		Ruppach-Goldhausen
70071	151251	G.U.T. Offenburg KG	Goldscheuer	Kehl
70072	151252	Alu Leitl GmbH		München
70073	151253	Frank Papperitz		Pirna
70074	151254	Rhodius Abrasives GmbH		Burgbrohl
70075	151255	Stronghold	steel products & engineering CO.,LT	Pathumthani
70076	151256	KnopBau GmbH	Alexander Knop	Bergneustadt
70077	151257	BAD & Duschmontagen	Michael Pöllmann	Marschacht
70078	151258	UrSprung GmbH		Miltenberg
70079	151259	ATS-Antriebstechnik	Angelo Sciannimanica	Solingen
70080	151260	MIG BALTIC SIA		Marupes nov.
70081	151261	S.C. Reisser Tehnic S.R.L.		Cluj-Napoca
70082	151262	ASW GmbH & Co. KG		Attendorn
70083	151263	Daex GmbH	Bedachungs- und Holzfachhandel	Hürth
70084	151264	Helmuth Ferlings Elektro - Großhand		Mainburg
70085	151265	Layer-Großhandel GmbH & Co. KG	Inh.: Jürgen Layer	Tettnang
70086	151266	H.A. Mönkemöller GmbH	Technischer Großhandel	Herford
70087	151267	Wiedemann Industrie- und	Haustechnik GmbH	Burg
70088	151268	Adolph C. Eisenwarenhandel		Berlin
70089	151269	TOOL-CO Irrgang Marquardt Werk-	zeug OHG	Berlin
70090	151270	Druse Handelsges. mbH	Eisen	Buchholz-Nordheide
70091	151271	Lingsch Werkzeuge		Berlin
70092	151272	Philipp GmbH		Berlin-Wittenau
70093	151273	INHA GmbH		Berlin
70094	151274	Wolfram Lochert	Befestigungstechnik	Wermsdorf
70095	151275	AMLEX Handels GmbH & Co. KG		Essen
70096	151276	Hauck W. GmbH		Schwegenheim
70097	151277	Seidler & Hentschel oHG	Bauzubehör	Bernburg
70098	151278	Stender Bautechnik	Vertrieb + Service	Ventschow
70099	151279	DER NEUE EISENHENKEL GmbH	(NW 5202)	Kiel
70100	151280	Friedrich Niemann GmbH & Co. KG		Kiel
70101	151281	Borchers & Speer	Handelsgesellschaft mbH.	Kiel
70102	151282	Pflüger - Baustoffe GmbH		Marktbergel
70103	151283	Conax UG	Axel Graneist	Leipzig
70104	151284	Sormat Oy		Rusko
70105	151285	Bach & Wesco KG		Bergisch Gladbach
70106	151286	Kuroga Montagebedarf GmbH & Co. KG		Hamburg-Eilbek
70107	151287	Wilfried Uwe Koch	Handelsvertretung	Bönningstedt
70108	151288	Meißner Bohr- und	Diamantwerkzeuge	Amelinghausen
70109	151289	Richard Petersen	Inh. Stefan Jähde e.K. Eisenwaren	Schleswig
70110	151290	Eduard Röseler	Inh. Gerd Röseler	Stade
70111	151291	Keil Innendienst		Dinklage
70112	151292	BAUIGEMA-Siegfried GmbH		Geraberg
70113	151293	Team Thaler GmbH	Diamantwerkzeuge	Oberau
70114	151294	Wölfling KG, C.		Pirmasens
70115	151295	Theodor Erich Großhandels Gmbh	Frau Gisela Karin Erich	Hamburg
70116	151296	FOXTOOL	Inh. Mirko Schweidler	Königsbrück
70117	151297	Eisen-Wolff	Uwe Wolff	Hamburg
70118	151298	DEG Koblenz	Alles für das Dach eG	Koblenz
70119	151299	HKL BAUMASCHINEN GmbH		Hamburg
70120	151300	MAKRO-STAHL	Max Krohn & Sohn Handels. GmbH & Co	Itzehoe
70121	151301	De Stalen Greep NV		Tielt
70122	151302	Schurmann Industriebedarf-	Handelsgesellschaft mbH	Reinbek
70123	151303	HG Bau- u.Hobby-	markt GmbH	Rüsselsheim
70124	151304	Eisen Trabandt GmbH		Stade
70125	151305	Salchow & Berger Baubedarf GmbH	(NW36270)	Essenbach
70126	151306	Maschinen Kaul GmbH & Co. KG		Düsseldorf
70127	151307	Würth HandelsgesmbH	Sonderartikel	Böheimkirchen
70128	151308	MARWITZ Baumaschinenhandel	GmbH & Co. KG	Hamburg
70129	151309	W. Hartmann GmbH & Co. KG	Werkzeugmarkt	Oststeinbek
70130	151310	Grenzland Baugeräte		Hückelhoven
70131	151311	E. Volz Werkzeughandels GmbH		Mayen
70132	151312	Karl Rother GmbH	Baumaschinen-Baugeräte	Köln
70133	151313	Lüttmann GmbH	Werkzeugmaschinenvertr.	Rheine
70134	151314	BWI Wahl GmbH	Gewerbegebiet "Mühlenbruch"	Königswinter
70135	151315	Heykes Diamantwerkzeuge GmbH		Wiesmoor
70136	151316	Nordwest Handel AG		Dortmund
70137	151317	Steel and Tube Holdings Ltd		Avondale, Auckland
70138	151318	Egon Jesse		Ouderkerk ad Amstel
70139	151319	Becker-Jostes GmbH & Co. KG		Sundern
70140	151320	Franko Werkstatt-Technik GmbH		Himmelkron
70141	151321	Einkaufsbüro Deutscher	Eisenhändler GmbH	Wuppertal
70142	151322	E.I.S. Kooperationszentrale für	Eisenwaren- und Hausratfach-	Köln (Ossendorf)
70143	151323	ABT-Allgemeine Befestigungstechnik	Inh.: Thomas Wlodyka e.K.	Marl
70144	151324	Gödde GmbH		Köln
70145	151325	SSK Schrauben Schmid GmbH		Dresden
70146	151326	Keilbach Befestigungssysteme GmbH		Mühlhausen
70147	151327	Befestigungs-Technik Reim	Inhaber Sylvia Huber	Am Ettersberg OT Heichelheim
70148	151328	Zweck GmbH	Werkzeuge-Autoersatzteile-Zubehör	Neuruppin
70149	151329	Dresen e.K.	Lutz Hans	Düsseldorf
70150	151330	Karl Westhelle & Sohn	SKF Kugellager, Werkzeuge, Maschine	Olsberg
70151	151331	Bäßler Befestigungstechnik	Matthias Bäßler	Geithain
70152	151332	Wilhelm Marx GmbH & Co. KG		Frankfurt am Main
70153	151333	Eisen-Schmidt GmbH & Co.	Groß- und Einzelhandel	Amberg
70154	151334	Conrad Electronic GmbH		Hirschau
70155	151335	Gillet Baustoffe		Landau
70156	151336	HV - Michel GmbH		Rodalben
70157	151337	1aSchrauben.de	Inh. Ronny Scharf	Grammetal, Utzberg
70158	151338	Gebr. Mayer GmbH & Co. KG	(EVB-Nr. 11303)	Fürth
70159	151339	Christian Forkel		Rödental
70160	151340	Krönlein GmbH + Co. KG		Schweinfurt
70161	151341	Eisen- Knorr GmbH		Weiden
70162	151342	Eisen-Jacob e.K.	Inh. Peter Weiß	Aschaffenburg
70163	151343	Davidi-Werkzeugtechnik	GmbH	Erkrath
70164	151344	Dimu Dieter Muthmann	GmbH	Berlin
70165	151345	Technischer Handel Nienhagen	Sergej Brauer OHG	Nienhagen
70166	151346	Workshop Nagel e. K.	Inh. Christian Nagel	Berlin
70167	151347	Agimus KG		Mellingen
70168	151348	Beton Kemmler GmbH		Tübingen
70169	151349	Friedrich Kicherer KG		Ellwangen
70170	151350	Klever Horst	Werkz.Masch.Schärfdienst	Rastatt
70171	151351	EVB BauPunkt	Einkauf- und Handelsgemeinschaft	Göppingen
70172	151352	fischerwerke GmbH & Co. KG		Waldachtal
70173	151353	Zweygart Fachhandelsgruppe	GmbH & Co. KG	Gärtringen
70174	151354	Gienger Regensburg KG	Fachgroßhandel für Haustechnik	Regenstauf
70175	151355	Fa. Otten OHG		Mainz
70176	151356	ZEG Zentraleinkauf	Holz u. Kunststoff e.G.	Mannheim
70177	151357	RECA NORM GmbH		Kupferzell
70178	151358	Weber Josef	Eisenwaren	Heidelberg
70179	151359	Gerhard Scheifele GmbH	Befestigungstechnik	Pfedelbach
70180	151360	DIBOTEC Befestigungstechnik	Klaus Dietrich	Baindt
70181	151361	HAGMEYER GmbH		Geislingen
70182	151362	Hacker GmbH	Holzbearbeitungsmasch.	Rosenheim
70183	151363	König J. GmbH & Co.	Maschinen-Center	Karlsruhe-Durlach
70184	151364	Hommel-Hercules-	Werkzeughandel GmbH&CoKG	Viernheim
70185	151365	Brütsch-Rüegger Tools GmbH	Deutschland	Mannheim
70186	151366	C. Schrade GmbH	Handel + Dienstleistungen	Neckarsulm
70187	151367	Thomas Rosenkranz	Technischer Handel	Neunkhausen
70188	151368	Franz Heydt Fachhandels-GmbH	(AH.-Nr. 10071, VL 77336, ZR.-Nr.01	Rastatt
70189	151369	Georg Schmieder GmbH & Co. KG	Steinindustrie und Handwerker-	Stuttgart
70190	151370	Hug Rudolf GmbH	Werkzeuge	Waldshut-Tiengen
70191	151371	Eduard Lutz Schrauben-Werkzeuge Gmb		Weilheim
70192	151372	Eberle-Hald Handel und Dienstleistu	Metzingen GmbH	Stuttgart
70193	151373	Wilhelm Nibler GmbH & Co.KG		Walldorf
70194	151374	Dr. Keller Maschinen GmbH		Freiburg
70195	151375	Ernst Triebel	Inh. Dieter Tägmeyer	Achim
70196	151376	Fritz Gabriel GmbH & Co. KG	Präzions-Werkzeuge	Bielefeld
70197	151377	Oltrogge & Co.		Bielefeld
70198	151378	Henze & Bleck GmbH		Ronneberg
70199	151379	Lutz Eduard	Schrauben-Werkzeuge GmbH	Gersthofen
70200	151380	J.H. Jaeger & Eggers	Handelsgesellschaft m.b.H	Bremen
70201	151381	BHB pro Handwerk & Industrie		Schmelz
70202	151382	ToolTeam	(NW 8547)	Köln
70203	151383	Layer-Großhandel GmbH & Co. KG	Inh. Jürgen Layer	Liebenwalde
70204	151384	TFIX POLSKA Sp. Z o.o.		Sekocin Nowy
70205	151385	Feldmann + Grever GmbH	Baumaschinen Baugeräte	Cloppenburg
70206	151386	P.H.Brauns GmbH & Co. KG	Partner für Technik	Hannover
70207	151387	BayWa AG	Baustoffe	Sonthofen
70208	151388	eFIB GmbH	Elektrotechnischer Fachgroßhandel	Gersdorf
70209	151389	Thies + Co. GmbH	Baustoffgroßhandlung	Hoya
70210	151390	EXACT GmbH & Co. KG	Präzisionswerkzeuge	Remscheid
70211	151391	Carl Wilh. Meyer GmbH & Co.	Großhandel GmbH	Oldenburg
70212	151392	Kötter + Siefker	GmbH + Co KG	Lotte-Büren
70213	151393	Lange & Co. KG	(AH.-Nr. 10019)	Kassel
70214	151394	Verrechnung der Verschmelzung	Heller / KEIL	x
70215	151395	Hans Kiesling GmbH & Co. KG	Werkzeuge, Maschinen, Schrauben,	Bremerhaven-Lehe
70216	151396	Repmann GmbH		Rödelsee-Fröhstockheim
70217	151397	Rohdenburg H. H. GmbH		Lilienthal
70218	151398	Eisen Vetter GmbH		Urbach
70219	151399	GB-Breidenstein	Diamantwerkzeuge	Dillenburg
70220	151400	Lerbs AG		Stuhr
70221	151401	Böwe GmbH		Aurich
70222	151402	Friedrich Detering GmbH		Emden
70223	151403	Schreiber Baumaschinen	GmbH & Co. KG	Bremen
70224	151404	Werner Pigorsch GmbH	Werkzeuge - Maschinen	Bremerhaven
70225	151405	Kolster	Inh. Bastian Grimm e.K.	Osterholz-Scharmbeck
70226	151406	Johannes Lefeld GmbH		Rietberg
70227	151407	Rentamin Werkzeugvermietung u. -	service UG	Bruckmühl
70228	151408	TIM Service GmbH		Bad Saulgau
70229	151409	Gebben & Heidemann UG & Co. KG	Agrar- & Industriebedarf	Haren-Wesuwermoor
70230	151410	UAB "Technosta"		Kauno
70231	151411	H.J. Bergmann	Handelsges. mbH & Co. KG	Bremen
70232	151412	Fricke GmbH & Co. KG	Werkzeughandel	Flechtorf
70233	151413	Aug. Heseding GmbH		Lohne
70234	151414	Industriebedarf  Niemann-Laes GmbH		Lüneburg
70235	151415	Perschmann Hch. GmbH	Werkzeuge und Beratung	Braunschweig
70236	151416	Carl-Arnold Brill GmbH	Baubeschläge   Industriebedarf	Nordhorn
70237	151417	Fritz Weg GmbH & Co. KG	(NW 7938)	Eschenburg-Wissenbach
70238	151418	Beli	Beyer + Liessmann KG	Kriftel
70239	151419	Mr. Clifford Staines	Phone: +44 7526 702200	Blackhall, Co. Durham
70240	151420	Werkzeug-Vogel	Inh. Kamila Vogel	Fronhausen/Lahn
70241	151421	Wilhelm Götte GmbH	Baumaschinen Baugeräte	Kassel
70242	151422	D-Tack Klebeband GmbH		Hüttlingen
70243	151423	Martin Freimuth Baumaschinen	Inh. Gerd Schellhaas	Oestrich-Winkel
70244	151424	Borrmann Edgar GmbH & Co. KG	Hausger.-Eisenw.-Werkzge	Fernwald
70245	151425	Eisen-Fischer GmbH & Co. KG	(NW 7229)	Limburg
70246	151426	FILO Baumaterial-Support GmbH		Döttingen
70247	151427	tools & more Industriebedarf	Frank Simon	Halle / Saale
70248	151428	Wittmann Werkstattbedarf GmbH		Günding
70249	151429	InDia Thiemt	Industriebedarf & Diamanttechnik	Bad Salzdetfurth
70250	151430	Stahl & Krähe GmbH	Werkzeug- u. Maschinenhandel	Zweibrücken
70251	151431	Wölpert Theodor GmbH & Co.	z.Hd. Herrn Barth	Bad Waldsee
70252	151432	SC OMP SRL		Bacau
70253	151433	Homberg Eisenhandel	GmbH	Dingolfing
70254	151434	I.S.M. Industrieservice GmbH		Babenhausen
70255	151435	Ladwein GmbH & Co. KG		Dierdorf
70256	151436	Kloy GmbH		Neustadt/Weinstraße
70257	151437	SCHEIBER GmbH		Weilerbach
70258	151438	Robert Schlott	Werkzeuge und Maschinen	Geretsried/Gelting
70259	151439	blizz-z Handwerk Direkt GmbH		Feuchtwangen
70260	151440	Andresen & Jochimsen	Exportpak GmbH & Co. KG	Hamburg
70261	151441	Uhlendorff, Gerhard	GmbH & Co. KG	Mönchengladbach
70262	151442	BEVER GmbH		Kirchhundem
70263	151443	GFB Handelsgesellschaft für Befesti		Oberhausen
70264	151444	Baustoff-Union	GmbH	Nürnberg
70265	151445	Grünhage Baumaschinen	Verkauf - Vermietung - Reparatur	Irxleben b. Magdeburg
70266	151446	Wollschläger GmbH & Co. KG		Bochum
70267	151447	Goldmann Roland	Fassadenbauer	Pforzheim
70268	151448	Peter von Ohle GmbH		Essen
70269	151449	Bauwaren Mahler GmbH		Augsburg
70270	151450	Herrmann Alois GmbH	Eisenwaren	Merchweiler
70271	151451	Profixings Pribon BV		Kasterlee
70272	151452	Berger Bau- und Industriebedarf Gmb		Traunstein
70273	151453	Friedberger Eisenhandl.	Chrisitan Knieß GmbH	Friedberg
70274	151454	GMS Bautechnik GmbH		Klagenfurt am Wörthersee
70275	151455	Keller + Kalmbach GmbH	(AH.-Nr.10031, VL 77336, ZR.-Nr.013	Unterschleißheim
70276	151456	Eisen Fischer		Nördlingen
70277	151457	ChemTechniek Nederland		Veenendaal
70278	151458	Hüllinghorst Maschinenhandel	GmbH & Co. KG	Bielefeld
70279	151459	Stockert Großhandels-	GmbH	Hohenbrunn/M.
70280	151460	Rockermeier btb	Diamanttechnik	Reichertshofen/Hög
70281	151461	Neustrelitzer Industriebedarf	Beilke GmbH	Neustrelitz
70282	151462	TRUTEK Fasteners Polska SP z.o.o.		Raszyn, Warszawy
70283	151463	Otto Schulte	Inh. Klaus Grünewald e. K.	Wuppertal
70284	151464	team baucenter GmbH	Niederlassung Eggebek	Eggebek
70285	151465	Produebel GmbH	Der Befestigungsspezialist	Leipzig
70286	151466	WMH e.k.	Werkzeug- und Maschinenhandel	Freiburg
70287	151467	IBS Industrieofenbau GmbH		Denkendorf
70288	151468	Dubick & Stehr	Baumschinen GmbH  (EVB Nr. 10402)	Hamburg
70289	151469	Eisen-Schneider	Inhaber Christoph Hassenbach e.K.	Wiesbaden-Schierstein
70290	151470	Albert Berner GmbH		Künzelsau
70291	151471	Lorenz Drucklufttechnik		Grub am Forst
70292	151472	Hans Daniels GmbH   (HB-Nr.336639)		Dortmund
70293	151473	W. Herr GmbH	Baumaschinen / Baugeräte	Kelkheim / Fischbach
70294	151474	Fehrs Baustoffe GmbH		Vaale
70295	151475	Hocke Baubedarf GmbH(HB-Nr.692778)		Wiesbaden
70296	151476	Weigel Werkzeuge OHG	Inh. Jens & Michael Weigel	Burbach
70297	151477	Lotter G.F. GmbH	(AH.-Nr. 10195, VL 77336, ZR.-Nr.01	Neutraubling
70298	151478	Tegral GmbH & Co. KG		Überherrn
70299	151479	Scholly Montagezubehör GmbH		Perchtoldsdorf
70300	151480	Lutz	Schrauben und Werkzeuge	Neubrandenburg
70301	151481	S&W Metall und Werkzeug GmbH		Alfeld
70302	151482	Görlacher GmbH	Handwerkstadt	Villingen-Schwenningen
70303	151483	Schultze GmbH	Werkzeuge	Schönebeck
70304	151484	Ackrutat GmbH & Co. KG		Neumünster
70305	151485	Industrial Technologies	Bielefeld GmbH	Bielefeld
70306	151486	Hilbertz GmbH & Co. KG		Wallenhorst
70307	151487	WERKZEUGPROFI KG		Lutherstadt Wittenberg
70308	151488	Niemann Friedrich	GmbH & Co. K.G.	Bentwisch/Rostock
70309	151489	Blumenbecker Industriebedarf GmbH		Beckum
70310	151490	THG Technische	Handelsgesellschaft mbH	Brake
70311	151491	Krehahn Bauservice GmbH	Gewerbeg. Steinkreuzweg	Naumburg
70312	151492	TOOLS	Werkzeughandel GmbH	Großenhain
70313	151493	LEITERMANN GmbH & Co. Fachmarkt KG		Göpfersdorf
70314	151494	Lotter Metall GmbH & Co. KG	Stammhaus Zedtlitz	Borna / OT Zedtlitz
70315	151495	dth	Kleber + Krumbiegel GmbH	Kesselsdorf
70316	151496	Richter	Bau-und Industriebedarf	Friedersdorf
70317	151497	Bruno Zachenbacher	Werkzeugvermietung	Düsseldorf
70318	151498	Bach GmbH Fachmarkt für	Industrie und Profis	Marienberg
70319	151499	Pauling Eisenwaren	Werkzeuge & Arbeitsschutz	Leipzig
70320	151500	Gierth & Herklotz	Mietgeräte GmbH	Bernau
70321	151501	Kadow	Handel und Service e.K.	Greifswald
70322	151502	Leiwema Ochs KG	Werkzeuge - Eisenwaren	Markkleeberg
70323	151503	Jaschinsky Werkzeuge GmbH & Co. KG		Magdeburg
70324	151504	Ralf Paufler	Werkzeugfachhandel	Radebeul
70325	151505	Illgen Frank	Werkzeuge	Neustrelitz
70326	151506	Hüllinghorst Maschinenhandel	GmbH & Co. KG	Prenzlau
70327	151507	LHG Leipziger Handeslgesellschaft m	AH-Nr. 10304, VL 77336, ZR-Nr.0135	Leipzig
70328	151508	Manderscheid	Werkz.,Masch.,Ind.bedarf	Hoyerswerda
70329	151509	G. Wurth GmbH	Schrauben-Werkzeuge-Normteile	Niederfischbach
70330	151510	Thalheimer Werkzeughandel	Inh. Rüdiger Zilly	Thalheim
70331	151511	PRIVATVERKAUF KEIL		Dinklage
70332	151512	Beeck & Koch	Inh. Henrik Pflugmacher e. K.	Braunsbedra
70333	151513	Stock  B.I.G. GmbH		Siek
70334	151514	Krämer & Feldmann GmbH		Hamburg
70335	151515	Freitag	Werkzeuge und Industriebedarf GmbH	Neuenkirchen
70336	151516	STZ Klingner GmbH	(NW 4863)	Pölzig
70337	151517	Hantel Montagetechnik	Großhandelsges. b.R.	Renzow
70338	151518	Nienhaus, Thielkes & Co. GmbH		Coswig-Dresden
70339	151519	Kirsch	Bau- und Industriebedarf GmbH	Belgershain
70340	151520	Manfred Faske GmbH & Co. KG	(AH.-Nr.10066)	Vechta
70341	151521	WMB-Walther GmbH Fachhandel	Werkzeuge-Maschinen-Baubeschläge	Arnstadt
70342	151522	Hans Humpenöder GmbH		Schwabach
70343	151523	Nagel Baumaschinen	Magdeburg GmbH	Barleben-Magdeburg
70344	151524	Hauschild Jürgen GmbH		Berka/Wera - OT Wünschensuhl
70345	151525	Wurster Gebr.	Werkzeugfachhandel	Woltersdorf
70346	151526	Augustin GmbH		Gunzenhausen
70347	151527	Detlef Dummert	Gewerbebetrieb	Berlin
70348	151528	Ihr Werkzeughandel	Inh.  Holger Antonijevic	Schwedt
70349	151529	Georg GmbH	Grosshandel	Breitscheid
70350	151530	Reinhold Werkzeuge		Stollberg/Erzgeb.
70351	151531	Kelterborn Schweißtechnik GbR		Saalfeld
70352	151532	Barm Werkzeughandel		Ganderkesee/Heide
70353	151533	Wildenhayn + Wachholz OHG		Blankenfelde
70354	151534	SVR GmbH	Kloska-Technik	Rostock
70355	151535	Mehlhorn GmbH	Baumaschinen Baubedarf	Erfurt
70356	151536	Gassmann Industriebedarf GmbH		Heiligenstadt
70357	151537	T.E.A.M Industriebedarf GmbH		Kall
70358	151538	Ullrich Ralf		Hohleborn / Floh -Seligenthal
70359	151539	Wiemann GmbH	Elektrogroßhandel	Bünde
70360	151540	BEROLINA	Werkzeug-Fachhandel GmbH	Berlin
70361	151541	Schweißtechnik - Industriebedarf	Drescher	Neustrelitz
70362	151542	DreBo	Werkzeugfabrik GmbH	Altshausen
70363	151543	Ch. Bonnet & Fils S.A.R.L.	ZA de la Weidmatt	Monswiller
70364	151544	Willers Nachf. OHG	Inh. Fischer + König	Oldenburg
70365	151545	Raimund Scheja	Werkzeug Maschinen Schweißtechnik	Heygendorf
70366	151546	Paulsen Detlef	Betriebsausrüster GmbH	Pampow/Schwerin
70367	151547	Rokossa GmbH	Elektromaschinen	Melle
70368	151548	SSK Schrauben Schmid GmbH		Kirchheim/Teck
70369	151549	Holzhauser GmbH	Baumaschinen-Schalung-Baugeräte	Kirn
70370	151550	WELU Germany GmbH		Hutthurm
70371	151551	Einkaufs- und Liefergenossenschaft	des Bau- und Baunebenhandwerks	Meißen
70372	151552	BVD Bautechnik	Handelsgesellschaft mbH	Ueckermünde
70373	151553	Dieter Kurth GmbH	Fachhandel für Dach und Fassade	Burscheid - Dürscheid
70374	151554	MOURITS TOOLS & TECHNIQUES B.V.		Barendrecht
70375	151555	BEV Baugeräte GmbH		Mönchengladbach
70376	151556	Werner Schweißtechnik GmbH & Co.KG	(NW 4869)	Görlitz
70377	151557	Bohnsack Wilhelm	Werkzeuge + Schweißtech.	Greifswald
70378	151558	Schaebbicke-Präzisionswerkzeuge	Inh. Manfred Schaebbicke	Berlin
70379	151559	BUCHBERGER	Baugeräte Handel GmbH	Ingolstadt
70380	151560	Perfekter Halt oHG	Ralf Postler - Jutta Hämmerling -	Remscheid
70381	151561	Wiegand Fuchs		Neuensalz
70382	151562	ARTEC	Arbeitstechnik, Maler & Baubedarf	Erfurt
70383	151563	industrie-bedarf MEYER KG		Gütersloh
70384	151564	Kuhfuss August	Nachf. Ohlendorf GmbH	Dessau
70385	151565	Hobex Fachhandels GmbH	Partner für Licht und Handwerk	Berlin-Charlottenburg
70386	151566	IuG Industrie- u. Gewerbe-	Fachgroßhandels GmbH	Chemnitz
70387	151567	KTG Baumaschinen	(EVB Nr. 11145)	Berlin
70388	151568	JGV GmbH		Grafenhausen
70389	151569	Peter Belousow GmbH		Neuburg/Donau
70390	151570	Manfred Binz	Diamant & Bautechnik	Gießen
70391	151571	Baer Ultra Präzisionswerkzeuge		Weinheim
70392	151572	HBV Hermsdorfer Beschlag	Vertrieb GmbH	Hermsdorf
70393	151573	Mac Panther GmbH	Maschinenbau	Bremen
70394	151574	Eberle-Hald Handel und Dienstleistu	Metzingen GmbH	Metzingen
70395	151575	Artmann Werkzeug- und	Maschinenvertriebs GmbH	Ahaus-Wüllen
70396	151576	Hartjenstein	Schrauben & Industriebedarf	Wilhelmshaven
70397	151577	Montec GmbH		Albstadt
70398	151578	WE-MA-TEC	Techn. Handel GmbH	Limburg
70399	151579	Pröbster Ludwig		Hilpoltstein
70400	151580	Robert Mann	Maschinen Werkzeuge Schweißtechnik	Ebsdorfergrund OT Hachborn
70401	151581	FWS GmbH & Co.KG		Hagen
70402	151582	MAH Werkzeuge		Eggolsheim
70403	151583	Schrauben Weiß	Normteile	Aue
70404	151584	Bude GmbH		Roßleben
70405	151585	Händel Baugeräte	GmbH	Ingolstadt
70406	151586	Schuebo GmbH		Kreuztal
70407	151587	Brema Baugerätehandel GmbH		Hohenlinden
70408	151588	WEO Werkzeughandel	Essen-Oldenburg GmbH	Essen-Oldenburg
70409	151589	BSB Service für das Baugewerbe GmbH		München
70410	151590	Markus Schwarz	Diamantwerkzeugtechnik	Ravensburg - Schmalegg
70411	151591	Artur Beglau	Werkzeug-Fachhandel	Taucha
70412	151592	DTS Diamanttechnik	Manfred Quandt	Stutensee
70413	151593	Maier + Kaufmann GmbH	Baustoffe	Steinach
70414	151594	Bilawsky Leopold	Maschinen - Werkzeuge	Murg - Niederhof
70415	151595	PIEL DIE TECHNISCHE	GROSSHANDLUNG GmbH	Soest
70416	151596	Industriebedarf Ohmert GmbH		Euskirchen
70417	151597	ABRABORO KFT.		Budapest
70418	151598	BSG Baugeräte	Schünke GmbH	Heideland/OT Königshofen
70419	151599	Berliner Schrauben GmbH & Co. KG	Niederlassung Oer-Erkenschwick	Oer-Erkenschwick
70420	151600	Buckmann Bauzentrum	GmbH & Co. KG	Bremen
70421	151601	PROFESS	Baubedarf und Diamanttechnik	St. Leon-Rot
70422	151602	Padre-Paul Dreiner	Verwaltungs UG & Co. KG	Wermelskirchen
70423	151603	ATTERER Stahlcenter GmbH		Marktoberdorf
70424	151604	Odenwälder Baumaschinen GmbH	(AH.-Nr. 10374,VL 77336, ZR.-Nr.013	Mörlenbach
70425	151605	Busse Technischer Großhandel GmbH	& Co KG	Emden
70426	151606	Niklaus Baugeräte GmbH	(AH.-Nr. 10378)	Gomaringen
70427	151607	EBV Werkzeug- und Verbindungs-	elemente Vertriebs GmbH	Bleialf
70428	151608	Wilh. Jansen-Eisenjansen	GmbH & Co. KG	Geilenkirchen
70429	151609	Berliner Schrauben GmbH & Co. KG	Zweigniederlassung Münster	Münster
70430	151610	Bauzentrum Pfaffenhofen GmbH & Co.K	(EVB Nr. 11326)	Pfaffenhofen
70431	151611	Baustoff Union GmbH & Co KG	Baugeräte/Werkzeuge 174504	München
70432	151612	E&B Stahlhandel GmbH & Co. KG	L-Nr.558	Bendorf
70433	151613	Ronald Brauer	Vertrieb-Service-Vermietung	Landsberg
70434	151614	Seefelder GmbH	Baubeschläge - Werkzeuge	Landshut
70435	151615	Leymann Albert GmbH & Co	Bau - Zentrum	Sulingen
70436	151616	B & W Befestigungstechnik	Werkzeuge	Ludwigslust
70437	151617	Staubach & Christiani GmbH		Gelsenkirchen
70438	151618	Bergander KG Jörg	Werkzeuggroßhandel	Schipkau
70439	151619	Neptun Werkzeuge AG		Däniken
70440	151620	VBS Verbindungstechnik &	Baustoffhandel	Grammetal OT Isseroda
70441	151621	BBI Befestigungstechnik	GmbH & Co.KG	Hameln
70442	151622	IHW Koch	Inh. Frank Lutze	Nordhausen
70443	151623	Otto Roth GmbH & Co. KG	Schrauben- Rohrleitungsartikel	Stuttgart
70444	151624	CS Secutec	Handelsgesellschaft mbH	Speicher
70445	151625	WEYLAND HAUSTECHNIK KG		St. Florian am Inn
70446	151626	Berger GmbH     (EVB Nr.10202)	Bau und Industriebedarf	Eggenfelden
70447	151627	Machens Industriebedarf GmbH		Hohenhameln/Clauen
70448	151628	A-Z Baumaschinenhandel Hattingen	GmbH (EVB Nr. 10120)	Hattingen
70449	151629	HEMÜ Werkzeuge GmbH		Linsengericht-Altenhaßlau
70450	151630	Beutlhauser WaGro		Regensburg
70451	151631	KaDo Baumaschinen	Baugeräte GmbH	Neunkirchen
70452	151632	Alois Piller	Maschinenhandel	Kollnburg
70453	151633	Carl Beutlhauser	Baumaschinen GmbH	Rednitzhembach
70454	151634	BauPunkt Flügel GmbH	(EVB Nr. 10606)	Wismar
70455	151635	Be Pe	Befestigungstechnik Penz	Waldbröl
70456	151636	BHG Bau Heimwerker	Gartenmarkt GmbH & Co.KG	Altentreptow
70457	151637	Janus C.F. GmbH & Co. KG	Gewerbegebiet Hoher Damm	Wismar
70458	151638	Christian Wilhelm Plattner		Eitweg
70459	151639	Biebrach - C.H. Morgenstern GmbH		Dresden
70460	151640	EBB Erfurter	Baumaschinen & Baugeräte	Erfurt
70461	151641	Feucht Baustoffe Fliesen	GmbH	Backnang
70462	151642	dth Fachgeschäft	Ingo & Olaf Hartmann GbR	Chemnitz
70463	151643	Tobias Ebeling	Werkzeugfachhandel	Alsleben
70464	151644	WESCO KG		Wenden
70465	151645	Illgen Werkzeuge und Bautechnik		Oelsnitz
70466	151646	PROMATECH	Trading GmbH	Hamburg
70467	151647	Stefan Balleis e.K.	(NW9006)	Baar
70468	151648	mkw Werkzeuge & Maschinenfachhandel	Inh. Klaus Mayer	Schlüsselfeld
70469	151649	Matthias Schäfer	Elektrowerkzeuge	St. Ingbert
70470	151650	M+V Bauservice OHG.		Waren (Müritz)
70471	151651	Werner Uwe	Industriebedarf	Barnstorf
70472	151652	H. Gr. Beilage GmbH & Co. KG		Vechta
70473	151653	CCD Diamanttechnik	Inh. Uwe Gerecke	Bremen
70474	151654	Bauzentrum Pfaffenhofen	GmbH & Co. KG	Schrobenhausen
70475	151655	Bauzentrum Pelzer GmbH	L-Nr. 720034	Köln
70476	151656	K.S.V. Srl	Gianfranco Forciniti	ORTONA (CH)
70477	151657	TIS	Technischer Industriebedarf Schorr	Nonnweiler
70478	151658	GUILLET SAS		VILLEBOIS
70479	151659	Hess Germany		Herne
70480	151660	Fälschle Werkzeuge & Maschinen	Industriebedarf	Deiningen
70481	151661	Kasberger Baustoffe GmbH	z.Hd. Herrn Erze	Neuötting
70482	151662	Bühler - Bauzentrum		Schramberg
70483	151663	Krebeck Technischer Handel e.K.		Damme
70484	151664	Wilhelm Fricke SE		Zeven/Heeslingen
70485	151665	Dachdecker Einkauf Hamm	H. Lütke Harmann	Hamm
70486	151666	ATOS GmbH		Memmingen
70487	151667	Dachdecker-Einkauf eG		Lage / Lippe
70488	151668	Krause	Baumaschinen - Baugeräte GmbH	Dollern
70489	151669	Arreche GmbH		Münchweiler
70490	151670	Baustoff-Zentrum GmbH	Lauchhammer	Lauchhammer
70491	151671	Baustoff-Zentrum GmbH	Herzberg	Herzberg
70492	151672	Leigh tools & accessories Limited		Leigh Lancashire WN7 1SH
70493	151673	Gnädig GmbH	Fachmarkt	Lahr
70494	151674	MS Baubedarf	Mario Steiner	Großfahner
70495	151675	Carl Hinrichs oHG	Eisenwaren	Augustfehn-Apen
70496	151676	MK Baubedarf Nord GmbH		Neumünster
70497	151677	Black & Decker	European Accessories Business	Slough, Berks SL1 3YD
70498	151678	Erwin Hellmuth	Maschinen und Diamantwerkzeuge	Heilsbronn
70499	151679	Eberle-Hald Handel u. Dienst-	leistungen Metzingen GmbH	Meckenbeuren
70500	151680	Faitsch OHG		Trossingen
70501	151681	Metallgeno GmbH		Pasewalk
70502	151682	Von der Heydt		Speyer
70503	151683	Baugema Baumaschinen	GmbH	Pastow
70504	151684	bhv quattro GmbH	(ADRESSE NICHT MEHR AKTUELL)	Saarbrücken
70505	151685	Fidel Schub GmbH & Co. KG		Viechtach
70506	151686	ASAMCO CV		Bornem
70507	151687	E.G. Kistenmacher GmbH & Co. KG		Hamburg
70508	151688	Wertheimer Betonfertigteile GmbH		Baden-Baden
70509	151689	Ernst Blanke Baustoffe	GmbH & Co. KG	Wunstorf
70510	151690	We-Di-Ma	Inh. Olaf Braunsdorf	Riesa
70511	151691	ITS GmbH (NW 4824)	Industrie Technik und	Parchim
70512	151692	Innecken Lorenz	(HB 580958)	Wismar
70513	151693	ASK Kloska GmbH		Wilhelmshaven
70514	151694	ProBau Chemnitz GmbH	Baustoff - Fachhandel	Chemnitz-Röhrsdorf
70515	151695	Dymatec		Luton Bedforedshire LU4 8NU
70516	151696	Oberflächen-Partner	Theisen + Kahl OHG	Andernach/Rhein
70517	151697	MVS Zeppelin GmbH & Co. KG		Garching b. München
70518	151698	MKT Metall-Kunststoff-	Technik GmbH & Co. KG	Weilerbach
70519	151699	Witschel GmbH	Baustoffhandel	Großenhain
70520	151700	Gienger Passau KG	Fachgroßhandel Haustechnik	Tiefenbach
70521	151701	Hans Bohner GmbH & Co. KG	Eisen-und Sanitärgroßhandel	Oettingen i.Bay
70522	151702	RSW Handelsgesellschaft mbH	LIMITED LIABILITY COMPANIES	Bautzen
70523	151703	Erika Luxem	Handelsgesellschaft mbH	Elsenfeld
70524	151704	Blank & Seegers KG	Thüringer Fachgroßhandel für	Grammetal
70525	151705	MAWILL sarl.	Materiel de Batiment	Diekirch
70526	151706	INTERNATIONAL GROUP AP SUALPE		Madrid
70527	151707	BIV GmbH  (EVB-Nr.10232)		Bindlach
70528	151708	SPIRA Baugeräte- und	Schalungslogistik GmbH	Speyer
70529	151709	CID Products LLP /  CID House	attn. Mr. Jeff Soulsby	LEEDS
70530	151710	SSH Straufhainer Schraubenhandel	Petri GmbH	Straufhain
70531	151711	Dachdecker-Einkauf Ost eG		Braunschweig
70532	151712	ZEDACH eG	Zentralgenossenschaft des	Hamm
70533	151713	Fa. Joachim Hochberger	Maschinen, Werkzeuge	Bad Endorf- Hemhof
70534	151714	Gustav Herbstreuter GmbH & Co. KG		Simmern (Hunsrück)
70535	151715	DBS Diamantbohren- und Sägen GmbH		Durmersheim
70536	151716	Sichtermann Montagebedarf		Unna
70537	151717	AccurA Diamond Tools Ltd.	Accura House	Dublin 12
70538	151718	Etanco Benelux NV - SA		Wommelgem
70539	151719	Vorpa s.r.l.		Riccione (FC)
70540	151720	Firma Ebeling	Inh. Karsten Genthe	Wolfsburg
70541	151721	HausFux GmbH		Feuchtwangen
70542	151722	Mühl Product & Service **konkurs**	Berlin/Brandenburg GmbH	Neuruppin
70543	151723	Schellberg Befestigungs-	technik-Vertriebs GmbH	Bornheim-Walberberg
70544	151724	Manuela Schneider		Engelskirchen
70545	151725	Unitech Isam Kabbani & Partners	for Building &Construction Material	Jeddah
70546	151726	Galler Hans	Werkzeuge	Geisenfeld
70547	151727	Mietzentrum Reul	Bau- und Gartengeräte GmbH	Offenbach
70548	151728	Angelo Papeo Ferramenta		Binetto (Bari)
70549	151730	Optimal-Versand	Istvan Horogh	Worbis
70550	151731	Bau- und Industriebedarf	Kai Uwe Szombach	Lüdenscheid
70551	151732	Berkele Industriebedarf &	Dienstleistungen GmbH	Bergheim
70552	151733	Faitsch Inh. Peter Ulmschneider e.K		Trossingen
70553	151734	Cut & Break Diamond Products, Inc.		Quezon City, Philippines 1105
70554	151735	Ida GmbH	Industriedachabdichtungen	Bad Marienberg
70555	151736	Europeiskie Instrumenty LLC	Office 15 (Office 315) on 3rd Floor	Minsk
70556	151737	Wovar		Groningen
70557	151738	Melle Gallhöfer Dach GmbH	NL Osterode Betriebsbedarf 0889	Neuss
70558	151739	TSR-ELSITE Oy	Attn: M.Niittymäki toimisto	Turku
70559	151740	Sousa Solutions Ltda		Rio das Ostras
70560	151741	Vydra & Herr GmbH	Werkzeuge-Maschinen-Betriebseinr.	Leinfelden-Echterdingen/Stette
70561	151742	Tobias Hölker	Heller Tools GmbH	Dinklage
70562	151743	WILMART SAS	PA Portes du Nord	LIBERCOURT
70563	151744	Plankunde Australien, Asien		Plankunde
70564	151745	Plankunde Ost-Europa		Plankunde
70565	151746	Plankunde ehem. Soviet Staaten		Plankunde
70566	151747	Plankunde Russland		Plankunde
70567	151748	Plankunde Mittlerer Osten, Afrika &	Indien	Plankunde
70568	151749	Plankunde Nord-Amerika		Plankunde
70569	151750	Plankunde Nordic		Plankunde
70570	151751	Plankunde Holland & Belgien		Plankunde
70571	151752	Plankunde DACHL		Plankunde
70572	151753	Plankunde Frankreich		Plankunde
70573	151754	Plankunde Iberia		Plankunde
70574	151755	Plankunde Süd-Europa		Plankunde
70575	151756	Plankunde England		Plankunde
70576	151757	Unifix Systems Pte Ltd	Att. Tan Puay Leng (Annie)	Singapore
70577	151758	Melle Gallhöfer Dach GmbH	Niederlassung Zittau	Zittau
70578	151759	Hans Wilms GmbH & Co. KG		Mönchengladbach
70579	151760	Kanca Makine Pazarlama ve Ticaret A		Karakoy, Istanbul
70580	151761	Neukunden-Angebot DE		Dinklage
70581	151762	Neukunden-Angebot GB		Dinklage
70582	151763	Neukunden-Angebot ENG €		Dinklage
70583	151764	Neukunden-Angebot NL		Dinklage
70584	151765	Neukunden-Angebot ES		Dinklage
70585	151766	Neukunden-Angebot FR		Dinklage
70586	151767	Elektro Brisch GmbH & Co. KG	Elektro Großhandel	Bochum
70587	151768	Adamas België NV		Herentals
70588	151769	RM Tools, UAB (LTD)		Vilnius
70589	151770	Kadach & Rick GmbH		Sankt Augustin
70590	151771	BEG GmbH		Föhren
70591	151772	FERRAMENTA PORTO DI RIPETTA S.R.L.		Roma
70592	151773	G.S.T. Griesch GmbH		Geestland-Langen
70593	151775	W. Schermuly GmbH		Villmar
70594	151776	Linde GmbH	Befestigungstechnik	Braunschweig
70595	151777	Plankunde DACHL KB Gebiet 9		Plankunde
70596	151778	Plankunde DACHL KB Gebiet 7		Plankunde
70597	151779	Plankunde DACHL KB Gebiet 5		Plankunde
70598	151780	Plankunde DACHL KB Gebiet 3		Plankunde
70599	151781	Plankunde DACHL KB Gebiet 2		Plankunde
70600	151782	Plankunde DACHL KB Gebiet 1		Plankunde
70601	151783	Schmidt's Haustechnik KG		Bürs
70602	151784	Harbor Freight Tools		Calabasas
70603	151785	Sicherheitstechnik Michael Mayer		Dachau
70604	151786	TFG Lipp KG		Zella-Mehlis
70605	151787	Bauzentrum Mayer GmbH & Co. KG		Ingolstadt
70606	151788	MAQUIMAX.PE EIRL		Trujillo
70607	151789	Reisser Csavar Kft		Szar
70608	151790	LSB Manufaktur GmbH		Engelskirchen
70609	151791	Plankunde DACHL KB Gebiet 6		Plankunde
70610	151792	Plankunde Süd-Amerika		Plankunde
70611	151793	Muster Abwicklung DE		Dinklage
70612	151794	Muster Abwicklung INT		Dinklage
70613	151795	Seojeon MJ		Hanam
70614	151796	Eelen BV		Kasterlee
70615	151797	Groenhart Group B.V.	Centraal Magazijn	Purmerend
70616	151798	SA Etablissements Jean Collas		Büllingen
70617	151799	In de Boerenhandel bv		Boechout/Antwerpen
70618	151800	Diatool BVBA		Turnhout
70619	151801	A.T.E.P.I.R. DI GUALDAMBRINI	ALESSANDRO E C. SAS	Roma
70620	151802	Di MASTROMATTEO ALESSANDRO		ROMA
70621	151803	ISF Constructions & Trade		Athen
70622	151804	SAS Prodesca		Pont d'Ain
70623	151805	Dachbaustoffe Rath GmbH & Co. KG	(Ndl. Schwerin)	Schwerin
70624	151806	JRB Handelsvertretungs GmbH	Der Heimwerker	Falkensee
70625	151807	TSSP Distribution		Astana
70626	151808	THEMIS GIANNAKIS S.A.		Athen
70627	151809	GC Linz Haustechnik KG		Linz
70628	151810	WMS - Werkzeuge + Maschinen	Inh. Uwe Sedlmaier	Bruckberg
70629	151811	4MORE	Inh. Felix Schorstädt	Kuchen
70630	151812	GIENGER spol.s r.o.		Nitra
70631	151813	BVBA IJZERWAREN NELIS	Vakhandel en Installatiebedrijf	Glabbeek
70632	151814	EURO NARCIS S.R.L.		Targu Mures, Jud. Mures
70633	151815	JEUS KOREA		GYEONGGI-DO
70634	151816	NV SERCOMAT		Arendonk
70635	151817	Lecot N.V. 51791		Kortrijk-Heule
70636	151818	NV O.M.C.T.		Averbode
70637	151819	Brico Massart		Tienen
70638	151820	Kerkstoel Profi & Sanicenter NV		Heist-op-den-Berg
70639	151821	De Sutter W&S bv		Aalter
70640	151822	BV De Sutter & Zonen		Oudenaarde
70641	151823	Bax IJzerwaren NV		Hamont-Achel
70642	151824	TD Projects		Pelt
70643	151825	Pro-Coop	-Rabattring-	Grobbendonk
70644	151826	BV STOCK VAN DE WALLE		Assenede
70645	151827	SCHRAMM KG		Landau
70646	151828	Richter Baustoffe GmbH		Barsbüttel
70647	151829	Schlüsseldienst Sandmann Münster eK		Münster
70648	151830	WMS Vertriebs- GmbH		Schwaigern
70649	151831	REWORKS bvba		Peer
70650	151832	NV Etn. ALDERS		Pelt
70651	151833	Hemmersbach	Industriebedarf GmbH	Berlin
70652	151860	Spray-Tech Kft		Budapest
70653	151872	E.W. Neu GmbH		Speyer
\.


--
-- Data for Name: oauth_states; Type: TABLE DATA; Schema: public; Owner: vertrieb
--

COPY public.oauth_states (state, redirect_uri, nonce, created_at, expires_at) FROM stdin;
VTbOOS98fDgZgZsNxBP9If7oaN2a51hdKNC1ArSFCqw	https://reportapp.hellertools.com/auth/callback	_RrKOWm2Wc-Y9G4wCUi5IQ	1755516731.5582325	1755517331.5582325
lXKiwB9CfexzlNQ-TORl5IBu3dgtiYlUjf7euSXizpM	https://reportapp.hellertools.com/auth/callback	3doF30cenJ_SGzDtKHDIvg	1755516769.8014092	1755517369.8014092
kMPOZ4wXw2-sF-VdHhz8qegOKenEaWT3U0gofZJuWOU	https://reportapp.hellertools.com/auth/callback	kco6bPHa6TdeG9Uf2tMDrQ	1755516809.9938505	1755517409.9938505
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: vertrieb
--

COPY public.reports (id, owner_oid, owner_email, owner_name, customer_no, customer_name, contact_person, place, date, short_report, next_steps, classification, order_value_eur, offer_value_eur, next_visit_weeks, is_new_account, overnight, day_status, created_at, updated_at) FROM stdin;
1	0d682275-df53-4078-a65d-73f947a320c4	kkaluza@hellertools.com	Kaluza Kenneth - Heller Tools GmbH	444	444	44	Dilsen-Stokkem	2025-08-18	44444	44444	C	444.00	444.00	444	f	f	VACATION	2025-08-18 12:20:56.458285+00	2025-08-18 12:20:56.458285+00
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vertrieb
--

SELECT pg_catalog.setval('public.customers_id_seq', 70653, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vertrieb
--

SELECT pg_catalog.setval('public.reports_id_seq', 1, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: oauth_states oauth_states_pkey; Type: CONSTRAINT; Schema: public; Owner: vertrieb
--

ALTER TABLE ONLY public.oauth_states
    ADD CONSTRAINT oauth_states_pkey PRIMARY KEY (state);


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

