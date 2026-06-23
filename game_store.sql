--
-- PostgreSQL database dump
--

\restrict gjc48gFLp4p6n9RXTB33Qspf0Ht6fHTwe6DiyjT9Dcs7Zd7a0PlV0NdbmqXnd24

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
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
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
    currency_amount integer NOT NULL,
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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
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
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
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

COPY public.admins (id, name, email, password, created_at) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, name, slug, game_key, description, official_url, patchnote_url, latest_patch, latest_update, publisher, is_active, created_at, updated_at) FROM stdin;
1	Genshin Impact	genshin-impact	GI	Top up Genesis Crystal dan layanan Genshin Impact.	https://genshin.hoyoverse.com/en/	https://game8.co/games/Genshin-Impact/archives/594202	6.6	2026-05-20	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
2	Honkai: Star Rail	honkai-star-rail	HSR	Top up Oneiric Shard dan layanan Honkai: Star Rail.	https://hsr.hoyoverse.com/en-us/	https://game8.co/games/Honkai-Star-Rail/archives/404257	3.4	2026-05-31	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
3	Zenless Zone Zero	zenless-zone-zero	ZZZ	Top up Monochrome dan layanan Zenless Zone Zero.	https://zenless.hoyoverse.com/en-us/	https://game8.co/games/Zenless-Zone-Zero/archives/595942	3.0	2026-06-17	HoYoverse	t	2026-06-23 20:47:38.279666	2026-06-23 20:47:38.279666
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, game_id, name, slug, currency_amount, price, display_order, is_active, created_at, updated_at) FROM stdin;
1	1	60 Genesis Crystal	genesis-crystal	60	16000	1	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
2	1	300 Genesis Crystal	genesis-crystal	300	79000	2	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
3	1	980 Genesis Crystal	genesis-crystal	980	249000	3	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
4	1	1980 Genesis Crystal	genesis-crystal	1980	479000	4	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
5	1	3280 Genesis Crystal	genesis-crystal	3280	799000	5	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
6	1	6480 Genesis Crystal	genesis-crystal	6480	1599000	6	t	2026-06-23 21:12:56.136086	2026-06-23 21:12:56.136086
7	2	60 Oneiric Shard	oneiric-shard	60	16000	1	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
8	2	300 Oneiric Shard	oneiric-shard	300	79000	2	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
9	2	980 Oneiric Shard	oneiric-shard	980	249000	3	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
10	2	1980 Oneiric Shard	oneiric-shard	1980	479000	4	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
11	2	3280 Oneiric Shard	oneiric-shard	3280	799000	5	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
12	2	6480 Oneiric Shard	oneiric-shard	6480	1599000	6	t	2026-06-23 21:13:05.275326	2026-06-23 21:13:05.275326
13	3	60 Monochrome	monochrome	60	16000	1	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
14	3	300 Monochrome	monochrome	300	79000	2	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
15	3	980 Monochrome	monochrome	980	249000	3	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
16	3	1980 Monochrome	monochrome	1980	479000	4	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
17	3	3280 Monochrome	monochrome	3280	799000	5	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
18	3	6480 Monochrome	monochrome	6480	1599000	6	t	2026-06-23 21:13:23.369978	2026-06-23 21:13:23.369978
\.


--
-- Data for Name: transaction_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_details (id, transaction_id, game_uid, game_server, created_at) FROM stdin;
1	1	800111111	Asia	2026-06-23 22:58:09.525839
2	2	800222222	Asia	2026-06-23 22:58:09.525839
3	2	800333333	Asia	2026-06-23 22:58:09.525839
4	2	800444444	Asia	2026-06-23 22:58:09.525839
5	3	700555555	Asia	2026-06-23 22:58:09.525839
6	4	100666666	Asia	2026-06-23 22:58:09.525839
7	5	700777777	Europe	2026-06-23 22:58:09.525839
8	6	100111111	Asia	2026-06-23 22:58:09.525839
9	6	100222222	Asia	2026-06-23 22:58:09.525839
10	6	100333333	Asia	2026-06-23 22:58:09.525839
11	6	100444444	Asia	2026-06-23 22:58:09.525839
12	6	100555555	Asia	2026-06-23 22:58:09.525839
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, order_id, user_id, product_id, quantity, total_price, customer_email, customer_whatsapp, payment_type, snap_token, transaction_id_midtrans, transaction_status, fraud_status, transaction_time, settlement_time, expiry_time, paid_at, notes, created_at, updated_at) FROM stdin;
2	TRX-GI-20260623-0002	\N	6	3	4797000	giveaway@example.com	082222222222	qris	SNAP_TOKEN_002	MIDTRANS_TX_002	settlement	accept	2026-06-22 22:56:03.628905	2026-06-22 22:56:03.628905	2026-06-22 23:11:03.628905	2026-06-22 22:56:03.628905	Giveaway komunitas	2026-06-23 22:56:03.628905	2026-06-23 22:56:03.628905
3	TRX-HSR-20260623-0003	\N	9	1	249000	hsr@example.com	083333333333	gopay	SNAP_TOKEN_003	MIDTRANS_TX_003	pending	\N	2026-06-23 22:56:03.628905	\N	2026-06-23 23:11:03.628905	\N	Menunggu pembayaran	2026-06-23 22:56:03.628905	2026-06-23 22:56:03.628905
4	TRX-ZZZ-20260623-0004	\N	15	1	249000	zzz@example.com	084444444444	shopeepay	SNAP_TOKEN_004	MIDTRANS_TX_004	expire	\N	2026-06-23 19:56:03.628905	\N	2026-06-23 20:11:03.628905	\N	Pembayaran expired	2026-06-23 22:56:03.628905	2026-06-23 22:56:03.628905
5	TRX-HSR-20260623-0005	\N	12	1	1599000	trailblazer@example.com	085555555555	bank_transfer	SNAP_TOKEN_005	MIDTRANS_TX_005	cancel	\N	2026-06-23 17:56:03.628905	\N	2026-06-23 18:11:03.628905	\N	Dibatalkan user	2026-06-23 22:56:03.628905	2026-06-23 22:56:03.628905
6	TRX-ZZZ-20260623-0006	\N	13	5	80000	event@example.com	086666666666	qris	SNAP_TOKEN_006	MIDTRANS_TX_006	settlement	accept	2026-06-23 16:56:03.628905	2026-06-23 17:56:03.628905	2026-06-23 17:11:03.628905	2026-06-23 17:56:03.628905	Event komunitas	2026-06-23 22:56:03.628905	2026-06-23 22:56:03.628905
1	TRX-GI-20260623-0001	\N	1	1	15000	genshin1@example.com	081111111111	qris	4a211abc-ad18-48e2-8cbb-c35e9fca0fa3	MIDTEST123	settlement	accept	2026-06-21 22:56:03.628905	2026-06-24 10:00:00	2026-06-21 23:11:03.628905	2026-06-21 22:56:03.628905	Topup pribadi	2026-06-23 22:56:03.628905	2026-06-24 02:53:48.547549
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, created_at) FROM stdin;
1	Jane Doe	janedoe@test.id	janedoe1	2026-06-20 15:30:18.056393
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, false);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 3, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 18, true);


--
-- Name: transaction_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_details_id_seq', 12, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


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
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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

\unrestrict gjc48gFLp4p6n9RXTB33Qspf0Ht6fHTwe6DiyjT9Dcs7Zd7a0PlV0NdbmqXnd24

