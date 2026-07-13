--
-- PostgreSQL database dump
--

\restrict dIuFVLTwG2XiyhcXyIaxhbqSBbtIiKLtG4GNQ1FudbYOERfIVv1Iv6HTAfEAe8j

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
    CONSTRAINT admins_role_check CHECK (((role)::text = ANY ((ARRAY['super_admin'::character varying, 'admin'::character varying])::text[])))
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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    order_status character varying(30) DEFAULT 'waiting'::character varying,
    CONSTRAINT chk_order_status CHECK (((order_status)::text = ANY ((ARRAY['waiting'::character varying, 'processing'::character varying, 'done'::character varying, 'cancelled'::character varying])::text[]))),
    CONSTRAINT chk_transaction_status CHECK (((transaction_status)::text = ANY ((ARRAY['pending'::character varying, 'settlement'::character varying, 'capture'::character varying, 'deny'::character varying, 'cancel'::character varying, 'expire'::character varying, 'failure'::character varying])::text[])))
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
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, order_id, user_id, product_id, quantity, total_price, customer_email, customer_whatsapp, payment_type, snap_token, transaction_id_midtrans, transaction_status, fraud_status, transaction_time, settlement_time, expiry_time, paid_at, notes, created_at, updated_at, order_status) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, birth_date, email, phone, password, created_at, updated_at) FROM stdin;
1	Lian	lian	2004-03-25	lian@gmail.com	081234567890	$2b$10$lPY96W3ghCYKAWU7/xqREOoCISSbEOKZv.Aks0HS02vlG/WWzYwvm	2026-07-13 19:46:51.116639	2026-07-13 19:46:51.116639
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, true);


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

SELECT pg_catalog.setval('public.transaction_details_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


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

\unrestrict dIuFVLTwG2XiyhcXyIaxhbqSBbtIiKLtG4GNQ1FudbYOERfIVv1Iv6HTAfEAe8j

