--
-- PostgreSQL database dump
--

\restrict HVuIPdphmqKRn0WfINLqumDiyqQuSzjHGGCJVYRmqg6GRd9LrPKBzRwR8fMKkWr

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birth_date date NOT NULL,
    phone character varying(20) NOT NULL,
    CONSTRAINT admins_role_check CHECK (((role)::text = ANY (ARRAY[('super_admin'::character varying)::text, ('admin'::character varying)::text])))
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: game_servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_servers (
    id integer NOT NULL,
    game_id integer NOT NULL,
    server_name character varying(100) NOT NULL,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.game_servers OWNER TO postgres;

--
-- Name: game_servers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_servers_id_seq OWNER TO postgres;

--
-- Name: game_servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_servers_id_seq OWNED BY public.game_servers.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    game_key character varying(20) NOT NULL,
    description text,
    official_url text,
    patchnote_url text,
    latest_patch character varying(50),
    latest_update date,
    publisher character varying(100),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    game_id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    price integer NOT NULL,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: transaction_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_details (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    game_uid character varying(100) NOT NULL,
    game_server character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transaction_details OWNER TO postgres;

--
-- Name: transaction_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_details_id_seq OWNER TO postgres;

--
-- Name: transaction_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_details_id_seq OWNED BY public.transaction_details.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    order_id character varying(100) NOT NULL,
    user_id integer,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    total_price integer NOT NULL,
    customer_email character varying(255),
    customer_whatsapp character varying(50),
    payment_type character varying(50),
    snap_token text,
    transaction_id_midtrans character varying(255),
    transaction_status character varying(30) DEFAULT 'pending'::character varying,
    fraud_status character varying(30),
    transaction_time timestamp without time zone,
    settlement_time timestamp without time zone,
    expiry_time timestamp without time zone,
    paid_at timestamp without time zone,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    order_status character varying(30) DEFAULT 'waiting'::character varying,
    CONSTRAINT chk_order_status CHECK (((order_status)::text = ANY (ARRAY[('waiting'::character varying)::text, ('processing'::character varying)::text, ('done'::character varying)::text, ('cancelled'::character varying)::text]))),
    CONSTRAINT chk_transaction_status CHECK (((transaction_status)::text = ANY (ARRAY[('pending'::character varying)::text, ('settlement'::character varying)::text, ('capture'::character varying)::text, ('deny'::character varying)::text, ('cancel'::character varying)::text, ('expire'::character varying)::text, ('failure'::character varying)::text])))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    birth_date date NOT NULL,
    email character varying(100),
    phone character varying(20),
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: game_servers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_servers ALTER COLUMN id SET DEFAULT nextval('public.game_servers_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: transaction_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_details ALTER COLUMN id SET DEFAULT nextval('public.transaction_details_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, name, username, email, password, role, created_at, updated_at, birth_date, phone) FROM stdin;
1	Super Admin	superadmin	superadmin@eigaming.com	$2b$10$MXgPMnUOl.pVqPZWkPfGbeKwTvy5mmtHUqvzV8otlA/A4faSZbX2e	super_admin	2026-07-13 19:54:28.337089	2026-07-13 19:54:28.337089	2000-01-01	081111111111
2	Admin Biasa	admin1	admin1@eigaming.com	$2b$10$sR5edh18MdKWTSUDRcxM0eOmRfab4IryoVv2/hfQxhh02tdVIfyvO	admin	2026-07-13 22:04:22.945549	2026-07-13 22:04:22.945549	2002-01-01	081111111112
\.


--
-- Data for Name: game_servers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_servers (id, game_id, server_name, display_order, created_at) FROM stdin;
1	1	Asia	1	2026-06-24 11:13:59.79124
2	1	America	2	2026-06-24 11:13:59.79124
3	1	Europe	3	2026-06-24 11:13:59.79124
4	1	TW, HK, MO	4	2026-06-24 11:13:59.79124
5	2	Asia	1	2026-06-24 11:14:05.79907
6	2	America	2	2026-06-24 11:14:05.79907
7	2	Europe	3	2026-06-24 11:14:05.79907
8	2	TW, HK, MO	4	2026-06-24 11:14:05.79907
9	3	Asia	1	2026-06-24 11:14:10.471047
10	3	America	2	2026-06-24 11:14:10.471047
11	3	Europe	3	2026-06-24 11:14:10.471047
12	3	TW, HK, MO	4	2026-06-24 11:14:10.471047
13	4	SEA	1	2026-06-24 11:14:16.838979
14	4	America	2	2026-06-24 11:14:16.838979
15	4	Europe	3	2026-06-24 11:14:16.838979
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, name, slug, game_key, description, official_url, patchnote_url, latest_patch, latest_update, publisher, is_active, created_at, updated_at) FROM stdin;
1	Genshin Impact	genshin-impact	GI	Top up Genesis Crystal dan layanan Genshin Impact.	https://genshin.hoyoverse.com/en/	https://game8.co/games/Genshin-Impact/archives/594202	6.6	2026-05-20	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
2	Honkai: Star Rail	honkai-star-rail	HSR	Top up Oneiric Shard dan layanan Honkai: Star Rail.	https://hsr.hoyoverse.com/en-us/	https://game8.co/games/Honkai-Star-Rail/archives/404257	3.4	2026-05-31	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
3	Zenless Zone Zero	zenless-zone-zero	ZZZ	Top up Monochrome dan layanan Zenless Zone Zero.	https://zenless.hoyoverse.com/en-us/	https://game8.co/games/Zenless-Zone-Zero/archives/595942	3.0	2026-06-17	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
4	Honkai Impact 3rd	honkai-impact-3	HI3	Top up Crystal dan layanan Honkai Impact 3rd.	https://honkaiimpact3.hoyoverse.com/global/en-us/home	https://honkaiimpact3.hoyoverse.com/global/en-us/news	8.3	2026-06-24	HoYoverse	t	2026-06-24 10:55:59.272167	2026-06-24 10:55:59.272167
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, game_id, name, slug, price, display_order, is_active, created_at, updated_at) FROM stdin;
1	1	60 Genesis Crystal	genesis-crystal	16000	1	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
2	1	300 Genesis Crystal	genesis-crystal	79000	2	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
3	1	980 Genesis Crystal	genesis-crystal	249000	3	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
4	1	1980 Genesis Crystal	genesis-crystal	479000	4	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
5	1	3280 Genesis Crystal	genesis-crystal	799000	5	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
6	1	6480 Genesis Crystal	genesis-crystal	1599000	6	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
7	2	60 Oneiric Shard	oneiric-shard	16000	1	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
8	2	300 Oneiric Shard	oneiric-shard	79000	2	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
9	2	980 Oneiric Shard	oneiric-shard	249000	3	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
10	2	1980 Oneiric Shard	oneiric-shard	479000	4	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
11	2	3280 Oneiric Shard	oneiric-shard	799000	5	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
12	2	6480 Oneiric Shard	oneiric-shard	1599000	6	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
13	3	60 Monochrome	monochrome	16000	1	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
14	3	300 Monochrome	monochrome	79000	2	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
15	3	980 Monochrome	monochrome	249000	3	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
16	3	1980 Monochrome	monochrome	479000	4	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
17	3	3280 Monochrome	monochrome	799000	5	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
18	3	6480 Monochrome	monochrome	1599000	6	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
\.


--
-- Data for Name: transaction_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_details (id, transaction_id, game_uid, game_server, created_at) FROM stdin;
1	1	1800080555	Asia	2026-07-14 05:58:42.333037
2	2	18008055	Asia	2026-07-16 07:49:10.452099
3	2	862595069	Asia	2026-07-16 07:49:10.468347
4	3	18008055	Asia	2026-07-16 07:50:43.074392
5	3	862595069	Asia	2026-07-16 07:50:43.083609
6	4	18008055	Asia	2026-07-16 07:50:55.759192
7	4	862595069	Asia	2026-07-16 07:50:55.769825
8	5	1800080555	Asia	2026-07-19 20:32:14.456204
9	6	180080555	Asia	2026-07-19 20:44:16.792989
10	7	1800080555	Asia	2026-08-05 01:42:33.088488
11	7	862595069	Asia	2026-08-05 01:42:33.103528
12	8	180008055	Asia	2026-08-05 01:48:09.932468
13	9	180008055	Asia	2026-08-05 01:52:31.865709
14	10	888888888	Asia	2026-08-05 01:54:04.062742
15	11	888888888	Asia	2026-08-05 01:54:15.396481
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, order_id, user_id, product_id, quantity, total_price, customer_email, customer_whatsapp, payment_type, snap_token, transaction_id_midtrans, transaction_status, fraud_status, transaction_time, settlement_time, expiry_time, paid_at, notes, created_at, updated_at, order_status) FROM stdin;
8	TRX-1785869289683	\N	6	1	1599000	brillianbagusajisasongko@gmail.com	085162566346	qris	dac0ddd5-1133-46dd-a620-4ecf4d51b6a7	fbcb411e-c217-4293-92cf-6b8e21fe1227	settlement	accept	\N	2026-08-05 01:49:41	\N	\N	\N	2026-08-05 01:48:09.912982	2026-08-05 01:50:27.382939	done
1	TRX-1783983522092	\N	1	1	16000	brillianbagusajisasongko@gmail.com	085162566346	gopay	391cf5a4-299e-469a-8ebb-20b4b7838470	918175ac-1993-46bd-b3ea-d1e48e6e730d	pending	accept	\N	\N	\N	\N	\N	2026-07-14 05:58:42.30457	2026-07-14 22:17:04.154598	done
2	TRX-1784162950130	\N	1	2	32000	brillianbagusajisasongko@gmail.com	085162566346	\N	8d665106-8d74-4d62-82d0-b7b8a09d1ccf	\N	pending	\N	\N	\N	\N	\N	\N	2026-07-16 07:49:10.308846	2026-07-16 07:49:10.308846	waiting
3	TRX-1784163042783	\N	1	2	32000	brillianbagusajisasongko@gmail.com	085162566346	\N	520fdc8e-c6c1-431f-a061-58050d36bc9c	\N	pending	\N	\N	\N	\N	\N	\N	2026-07-16 07:50:43.04886	2026-07-16 07:50:43.04886	waiting
4	TRX-1784163055343	\N	1	2	32000	brillianbagusajisasongko@gmail.com	085162566346	\N	61e62647-fd6c-43f4-8dda-4646923d1a4b	\N	pending	\N	\N	\N	\N	\N	\N	2026-07-16 07:50:55.712344	2026-07-16 07:50:55.712344	waiting
10	TRX-1785869643902	\N	1	1	16000	brillianbagusajisasongko@gmail.com	085162566346	\N	\N	\N	pending	\N	\N	\N	\N	\N	\N	2026-08-05 01:54:04.047923	2026-08-05 01:54:04.047923	waiting
5	TRX-1784467934234	\N	3	1	249000	brillianbagusajisasongko@gmail.com	085162566346	gopay	0ba93f6c-83a8-4bec-982e-abeb1d4d45da	f2ee8653-54e6-4413-af4d-68bac752f4c0	settlement	accept	\N	2026-07-19 20:32:25	\N	\N	\N	2026-07-19 20:32:14.377328	2026-07-19 20:33:10.963401	done
11	TRX-1785869655196	\N	1	1	16000	brillianbagusajisasongko@gmail.com	085162566346	qris	9c0972ac-9624-4bac-8e3e-7988f912b018	8a0fb491-bf57-4b5b-bab4-848b4a5700a4	settlement	accept	\N	2026-08-05 01:54:34	\N	\N	\N	2026-08-05 01:54:15.376388	2026-08-05 01:55:20.505111	done
6	TRX-1784468656342	\N	6	1	1599000	brillianbagusajisasongko@gmail.com	085162566346	qris	b72e08c5-2863-4060-a920-bcefb9cd37b1	0b8dd1a8-ddfa-4ccc-8523-53f83d723852	settlement	accept	\N	2026-07-19 20:45:45	\N	\N	\N	2026-07-19 20:44:16.776161	2026-07-19 20:46:32.411548	done
9	TRX-1785869551589	\N	6	1	1599000	brillianbagusajisasongko@gmail.com	085162566346	qris	957174a1-8dab-4e62-b0bf-e9e8e9db772d	871022b1-ad74-4366-85af-fd6128d07f6f	settlement	accept	\N	2026-08-05 01:55:06	\N	\N	\N	2026-08-05 01:52:31.847659	2026-08-05 01:55:52.512574	done
7	TRX-1785868952900	\N	6	2	3198000	mikamelatika@test.com	085162566346	qris	638f4ff1-abbc-493a-babb-fb07a5c7ef5e	55085477-4c75-4939-a719-1301743c3fe4	settlement	accept	\N	2026-08-05 01:43:13	\N	\N	\N	2026-08-05 01:42:33.045131	2026-08-05 01:43:58.645452	done
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, birth_date, email, phone, password, created_at, updated_at) FROM stdin;
1	Lian	lian	2004-03-25	lian@gmail.com	081234567890	$2b$10$lPY96W3ghCYKAWU7/xqREOoCISSbEOKZv.Aks0HS02vlG/WWzYwvm	2026-07-13 19:46:51.116639	2026-07-13 19:46:51.116639
2	Jane Doe	janedoe	2004-03-25	janedoe@gmail.com	081111111111	$2b$10$0u0cuUp74oTn/1awVP7Qoe6VDwgdmnIianbXTr0pO7S5i4u7M5072	2026-07-13 21:47:40.488151	2026-07-13 21:47:40.488151
3	Mika Melatika	mikamelatika	2001-07-18	mikamelatika@test.com	089123456789	$2b$10$BYU6JjlnuGAduQsZ07stTu62aGb4QiuMJyWE2nlqZ896TbOVVkbqC	2026-07-14 06:15:01.066044	2026-07-14 06:15:01.066044
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 2, true);


--
-- Name: game_servers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_servers_id_seq', 15, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 4, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 18, true);


--
-- Name: transaction_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_details_id_seq', 15, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- Name: admins admins_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_phone_key UNIQUE (phone);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- Name: game_servers game_servers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_servers
    ADD CONSTRAINT game_servers_pkey PRIMARY KEY (id);


--
-- Name: games games_game_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_game_key_key UNIQUE (game_key);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: games games_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_slug_key UNIQUE (slug);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: transaction_details transaction_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_details
    ADD CONSTRAINT transaction_details_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_order_id_key UNIQUE (order_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: game_servers game_servers_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_servers
    ADD CONSTRAINT game_servers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id) ON DELETE CASCADE;


--
-- Name: products products_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id) ON DELETE CASCADE;


--
-- Name: transaction_details transaction_details_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_details
    ADD CONSTRAINT transaction_details_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict HVuIPdphmqKRn0WfINLqumDiyqQuSzjHGGCJVYRmqg6GRd9LrPKBzRwR8fMKkWr

