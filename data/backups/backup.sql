--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.1 (Ubuntu 16.1-1.pgdg22.04+1)

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: Amine03824
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "Amine03824";

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: Amine03824
--

COMMENT ON SCHEMA public IS '';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: birthdate_domain; Type: DOMAIN; Schema: public; Owner: Amine03824
--

CREATE DOMAIN public.birthdate_domain AS character varying(15);


ALTER DOMAIN public.birthdate_domain OWNER TO "Amine03824";

--
-- Name: email_domain; Type: DOMAIN; Schema: public; Owner: Amine03824
--

CREATE DOMAIN public.email_domain AS character varying(255);


ALTER DOMAIN public.email_domain OWNER TO "Amine03824";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: article; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.article (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    price integer,
    transaction_id character varying(36),
    date_transaction date,
    state_completion character varying(30),
    image_url character varying(255),
    condition_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.article OWNER TO "Amine03824";

--
-- Name: article_id_seq; Type: SEQUENCE; Schema: public; Owner: Amine03824
--

ALTER TABLE public.article ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.category (
    id integer NOT NULL,
    category_name character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.category OWNER TO "Amine03824";

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: Amine03824
--

ALTER TABLE public.category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: condition; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.condition (
    id integer NOT NULL,
    condition_name character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.condition OWNER TO "Amine03824";

--
-- Name: condition_id_seq; Type: SEQUENCE; Schema: public; Owner: Amine03824
--

ALTER TABLE public.condition ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: manga; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.manga (
    code_isbn character varying(30) NOT NULL,
    title character varying(255) NOT NULL,
    volume integer NOT NULL,
    year_publication integer NOT NULL,
    author character varying(30) NOT NULL,
    description text NOT NULL,
    cover_url text,
    category_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.manga OWNER TO "Amine03824";

--
-- Name: manga_has_article; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.manga_has_article (
    manga_code_isbn character varying(16) NOT NULL,
    article_id integer NOT NULL
);


ALTER TABLE public.manga_has_article OWNER TO "Amine03824";

--
-- Name: role; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.role (
    id integer NOT NULL,
    role_name character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.role OWNER TO "Amine03824";

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: Amine03824
--

ALTER TABLE public.role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    lastname character varying(30),
    firstname character varying(30),
    pseudo character varying(30) NOT NULL,
    birthdate public.birthdate_domain,
    address text,
    zip_code text,
    city text,
    phone_number character varying(15),
    email public.email_domain NOT NULL,
    password character varying(255) NOT NULL,
    role_id integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT user_birthdate_check CHECK (((birthdate IS NULL) OR ((birthdate)::text = ''::text) OR ((birthdate)::text ~* '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'::text))),
    CONSTRAINT user_email_check CHECK (((email)::text ~* '^[A-Za-z0-9._+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text))
);


ALTER TABLE public."user" OWNER TO "Amine03824";

--
-- Name: user_has_article; Type: TABLE; Schema: public; Owner: Amine03824
--

CREATE TABLE public.user_has_article (
    user_id integer NOT NULL,
    article_id integer NOT NULL
);


ALTER TABLE public.user_has_article OWNER TO "Amine03824";

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: Amine03824
--

ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.article (id, title, description, price, transaction_id, date_transaction, state_completion, image_url, condition_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.category (id, category_name, created_at, updated_at) FROM stdin;
1	Shōnen	2023-12-06 16:43:25.175453+00	\N
2	Seinen	2023-12-06 16:43:25.175453+00	\N
3	Shōjo	2023-12-06 16:43:25.175453+00	\N
4	Josei	2023-12-06 16:43:25.175453+00	\N
5	Kodomo	2023-12-06 16:43:25.175453+00	\N
6	Seijin	2023-12-06 16:43:25.175453+00	\N
\.


--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.condition (id, condition_name, created_at, updated_at) FROM stdin;
1	Acceptable	2023-12-06 16:43:25.175453+00	\N
2	Bon	2023-12-06 16:43:25.175453+00	\N
3	Parfait	2023-12-06 16:43:25.175453+00	\N
\.


--
-- Data for Name: manga; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.manga (code_isbn, title, volume, year_publication, author, description, cover_url, category_id, created_at, updated_at) FROM stdin;
9782368529904	Fullmetal Alchemist Perfect Tome 1	1	2020	Hiromu Arakawa	Avec son subtil mélange d'action, d'humour, de suspense et de tragédie, Fullmetal Alchemist est le titre incontournable pour toute mangathèque ! Découvrez ou redécouvrez cette série culte dans une nouvelle édition de luxe entièrement remasterisée avec une nouvelle couverture, des pages couleurs, des croquis des personnages, une traduction mise à jour et un nouveau lettrage. Une occasion unique de partir à l'aventure aux côtés des frères Elric pour ceux qui ne connaissent pas encore ce manga de légende ! En voulant ressusciter leur mère, Edward et Alphonse Elric utilisent une technique alchimique interdite : la transmutation humaine. Seulement, l'expérience tourne mal : Edward perd un bras et une jambe et Alphonse, son corps, son esprit se retrouvant prisonnier d'une armure. Devenu un alchimiste d'Etat, Edward, surnommé le Fullmetal Alchemist, se lance, avec l'aide de son frère, à la recherche de la pierre philosophale, seule chance de retrouver leurs corps. Les deux frères commencent à enquêter sur un homme étrange, "le fondateur", qui passe pour un faiseur de miracles...	http://localhost:3000/images/9782368529904	1	2023-12-06 18:26:38.13109+00	\N
9782871294146	Naruto Tome 1	1	2002	Masashi Kishimoto	Naruto est un garçon un peu spécial. Il est toujours tout seul et son caractère fougueux ne l'aide pas vraiment à se faire apprécier dans son village. Malgré cela, il garde au fond de lui une ambition : celle de devenir un maître Hokage, la plus haute distinction dans l'ordre des ninjas, et ainsi obtenir la reconnaissance de ses pairs.	http://localhost:3000/images/9782871294146	1	2023-12-06 18:36:26.663483+00	\N
9782871294177	Naruto Tome 2	2	2002	Masashi Kishimoto	Sasuke, Sakura et Naruto passent un test dont le but est de s'emparer de clochettes que détient le professeur Kakashi. Il leur fait bien réaliser leur infériorité et leur manque d'expérience et finit par leur annoncer qu'ils n'ont aucune chance de devenir ninjas...	http://localhost:3000/images/9782871294177	1	2023-12-06 18:37:33.044962+00	\N
9782871294276	Naruto Tome 3	3	2002	Masashi Kishimoto	En compagnie de Sasuke et de Sakura, Naruto, le pire garnement de l'école des ninjas du village caché de Konoha, réussit avec brio le test de survie imposé par maître Kakashi. A présent, les trois jeunes gens forment une vraie équipe, mais ils ne sont encore que des ninjas de rang inférieur.	http://localhost:3000/images/9782871294276	1	2023-12-06 18:38:09.126115+00	\N
9782871294412	Naruto Tome 4	4	2002	Masashi Kishimoto	Sasuke s'effondre après avoir voulu protéger Naruto... !! Déclenché à la fois par la rage et la tristesse, un étrange bouleversement se produit en Naruto. Haku est alors subitement balayé par le point rageur de Naruto... ! ?	http://localhost:3000/images/9782871294412	1	2023-12-06 18:38:25.987421+00	\N
9782871294917	Naruto Tome 5	5	2003	Masashi Kishimoto	Un groupe d'aspirants ninjas venus d'un autre village sont venus à Konoha pour passer l'examen de sélection des ninjas de "moyenne classe". Kakashi propose à ses élèves de se présenter, eux aussi, à cet examen. Et c'est partagés entre l'excitation et l'appréhension, que Naruto, Sasuke et Sakura vont déposer leur formulaire de candidature. Qui sait ce que les épreuves leur réservent... ?	http://localhost:3000/images/9782871294917	1	2023-12-06 18:38:37.555219+00	\N
9782871292661	Hunter X Hunter Tome 1	1	2000	Yoshihiro Togashi	Dans les pas de son père, Gon quitte son village pour se présenter au difficile examen des hunters. En chemin, Gon se fera des amis. Mais survivront-ils à la première épreuve face à des participants particulièrement dangereux... ? ! Si quelques adversaires se montrent impitoyables dès le début, d'autres comme Hisoka le magicien font preuve d'un cruauté pour le moins inquiétante...	http://localhost:3000/images/9782871292661	1	2023-12-06 18:42:22.498405+00	\N
9782871292678	Hunter X Hunter Tome 2	2	2000	Yoshihiro Togashi	Le récit s'étoffe au fur et à mesure qu'apparaissent de nouveaux personnages secondaires. On notera surtout le mystérieux Hisoka dont la puissance semble sans limites et les motivations, inattendues.	http://localhost:3000/images/9782871292678	1	2023-12-06 18:42:37.382854+00	\N
9782871292685	Hunter X Hunter Tome 3	3	2000	Yoshihiro Togashi	Les épreuves qui, les unes après les autres, se dressent devant les candidats au titre de Hunter, nous permettent de découvrir le caractère et le passé souvent trouble de chacun. On apprend ainsi que Kirua est vraiment issu d'une famille de tueurs professionnels et qu'il peut se montrer aussi fort que cruel !	http://localhost:3000/images/9782871292685	1	2023-12-06 18:42:50.484008+00	\N
9782871292692	Hunter X Hunter Tome 4	4	2000	Yoshihiro Togashi		http://localhost:3000/images/9782871292692	1	2023-12-06 18:43:01.120813+00	\N
9782871292708	Hunter X Hunter Tome 5	5	2000	Yoshihiro Togashi		http://localhost:3000/images/9782871292708	1	2023-12-06 18:43:13.624908+00	\N
9782505000327	Death Note Tome 1	1	2007	Tsugumi Ohba, Takeshi Obata	Light Yagami ramasse un étrange carnet oublié dans la cour de son lycée. Selon les instructions du carnet, la personne dont le nom est écrit dans les pages du Death Note mourra dans les 40 secondes !! Quelques jours plus tard, Light fait la connaissance de l'ancien propriétaire du carnet : Ryûk, un dieu de la mort ! Poussé par l'ennui, il a fait entrer le carnet sur terre. Ryûk découvre alors que Light a déjà commencé à remplir son carnet...	http://localhost:3000/images/9782505000327	2	2023-12-06 18:45:28.309458+00	\N
9782915513585	Ubel Blatt Tome 0	0	2007	Etorouji Shiono	La légende raconte que pour lutter contre une terrifiante armée des ténèbres, l'empereur missionna 14 vaillants guerriers à qui il confia 14 lances sacrées. 3 d'entre eux, " les glorieux guerriers sans retour " périrent au combat. 4 autres, surnommés " les lances de la trahison ", furent exécutés par leur compagnons pour félonie. Les 7 derniers accomplirent leur mission et furent accueillis en héros à leur retour. Mais 20 ans plus tard, des rebelles baptisés eux aussi " les lances de la trahison " défient de nouveau l'autorité de l'empire... Sombre, vénéneux, épique... Découvrez Ubel Blatt, une incroyable saga de Dark Fantasy !	http://localhost:3001/images/9782915513585	2	2023-12-06 22:41:02.00121+00	\N
9782723455862	Reborn !	1	2006	Akira Amano	Quand les bébés mafieux prennent le pouvoir ! Reborn, qui a l'apparence d'un bébé, est un tueur envoyé par le boss de la famille Vongola, une puissante organisation mafieuse, en quête de successeur. Il se rend au Japon pour devenir le tuteur de Tsunayoshi Sawada, un lycéen malchanceux, loser et minable, amoureux transi de la belle Kyoko, une camarade classe. Lorsque Tsuna découvre que Reborn a été engagé par sa mère pour le faire entrer à l'université, il est scandalisé ! Mais Reborn sort un revolver et appuie sur la gâchette ! Abattu d'une balle en plein front, Tsuna s'écroule en regrettant de ne pas s'être déclaré à Kyoko avant de mourir. C'est alors que... Série à succès du Shônen Jump, Reborn a permis à son autrice, Akira Amano, de faire partie des mangaka avec lesquels compter. Partant sur un humour délirant proche de Dragon Ball, elle s'en émancipe rapidement pour devenir un pur shônen lorsque se révèlent enfin les rivaux charismatiques.	http://localhost:3000/images/9782723455862	2	2023-12-07 00:21:01.661045+00	\N
9782505009993	Monster Intégrale	1	2010	Naoki Urasawa	La vie quotidienne de chacun est parsemée d'embûches. Celle du prometteur docteur Tenma ne fait pas exception à la règle. Mais comment aurait-il pu imaginer qu'en remplissant sa mission de médecin, en sauvant une vie humaine plutôt que de courir après la gloire, il donnerait naissance à une telle créature ! ? Ou se situe le bien, où se situe le mal ? ! Dans une Allemagne en pleine confusion depuis la réunification, des couples d'âge moyen, sans enfant, sont tués les uns après les autres. Le tueur en série a pour nom Johann ! Mais pourquoi s'en prend-il à ces couples ? Kenzô Tenma parcourt l'Allemagne pour retrouver la soeur jumelle du jeune homme. Celle-ci pourrait bien détenir des informations afin de percer le secret du " Monstre ".	http://localhost:3000/images/9782505009993	2	2023-12-07 00:27:38.38979+00	\N
9782811679811	L'attaque des titans	1	2023	Hajime Isayama	Le monde appartient désormais aux Titans, des êtres gigantesques qui ont presque décimé l'Humanité... Un tome anniversaire avec des pages couleur et l'épisode 0, le one-shot inédit à l'origine de la série !	http://localhost:3000/images/9782811679811	2	2023-12-07 00:28:52.227401+00	\N
9782344020685	Berserk	1	2017	Kentaro Miura	"Vous qui entrez ici, abandonnez toute espérance. " Guts est un guerrier solitaire à l'épée démesurée. Marqué par un terrible passé, il parcourt le monde en semant la mort sur son passage. Un jour, il vient en aide à Puck, un elfe facétieux et volubile qui décide de l'accompagner dans son voyage. Traqué par des forces obscures, Guts tente de devenir maître de son destin pour regagner sa liberté et accomplir sa vengeance... Berserk, rare manga de dark fantasy, marque avant tout par son univers graphique travaillé et apocalyptique, mais aussi par sa violence et la gravité de ses thématiques. Une oeuvre qui n'a rien à envier à des sagas emblématiques telles que Game of Thrones, Conan le Cimmérien ou encore Le Cycle d'Elric.	http://localhost:3000/images/9782344020685	2	2023-12-07 00:29:36.565223+00	\N
9782380710243	Spy X Family	1	2020	Tatsuya Endo	Twilight, le plus grand espion du monde, doit pour sa nouvelle mission créer une famille de toutes pièces afin de pouvoir s'introduire dans la plus prestigieuse école de l'aristocratie. Totalement dépourvu d'expérience familiale, il va adopter une petite fille en ignorant qu'elle est télépathe, et s'associer à une jeune femme timide, sans se douter qu'elle est une redoutable tueuse à gages. Ce trio atypique va devoir composer pour passer inaperçu, tout en découvrant les vraies valeurs d'une famille unie et aimante.	http://localhost:3000/images/9782380710243	1	2023-12-07 00:31:54.126432+00	\N
\.


--
-- Data for Name: manga_has_article; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.manga_has_article (manga_code_isbn, article_id) FROM stdin;
2222333344445	4
5555666677778	5
8888999900001	6
1234123412345	7
1234567890123	1
9876543210987	2
1111222233334	3
1111111111111	1
2222222222222	2
3333333333333	3
4444444444444	4
5555555555555	5
6666666666666	6
7777777777777	7
8888888888888	8
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.role (id, role_name, created_at, updated_at) FROM stdin;
1	Admin	2023-12-06 16:43:25.175453+00	\N
2	User	2023-12-06 16:43:25.175453+00	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public."user" (id, lastname, firstname, pseudo, birthdate, address, zip_code, city, phone_number, email, password, role_id, created_at, updated_at) FROM stdin;
1	Monkey	D. Luffy	luffy	1994-05-05	1 Rue de la Plage	93200	Saint-Denis	111222333	luffy@email.com	hashed_password	1	2023-12-06 16:43:25.328904+00	\N
2	Light	Yagami	kira	1992-12-21	2 Rue des Ombres	93270	Sevran	444555666	kira@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
3	Naruto	Uzumaki	naruto	1997-10-10	3 Rue des Hokages	93370	Montfermeil	777888999	naruto@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
4	Sasuke	Uchiha	sasuke	1994-07-23	9 Rue des Vengeurs	93370	Montfermeil	666555444	sasuke@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
9	\N	\N	YsT	\N	\N	\N	\N	\N	tanguy.huart@oclock.school	coucou	1	2023-12-06 22:43:29.061945+00	\N
\.


--
-- Data for Name: user_has_article; Type: TABLE DATA; Schema: public; Owner: Amine03824
--

COPY public.user_has_article (user_id, article_id) FROM stdin;
2	4
3	5
4	6
1	7
1	1
3	2
4	3
\.


--
-- Name: article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Amine03824
--

SELECT pg_catalog.setval('public.article_id_seq', 8, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Amine03824
--

SELECT pg_catalog.setval('public.category_id_seq', 6, true);


--
-- Name: condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Amine03824
--

SELECT pg_catalog.setval('public.condition_id_seq', 3, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Amine03824
--

SELECT pg_catalog.setval('public.role_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Amine03824
--

SELECT pg_catalog.setval('public.user_id_seq', 9, true);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (id);


--
-- Name: manga_has_article manga_has_article_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.manga_has_article
    ADD CONSTRAINT manga_has_article_pkey PRIMARY KEY (manga_code_isbn, article_id);


--
-- Name: manga manga_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT manga_pkey PRIMARY KEY (code_isbn);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_has_article user_has_article_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.user_has_article
    ADD CONSTRAINT user_has_article_pkey PRIMARY KEY (user_id, article_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_pseudo_key; Type: CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pseudo_key UNIQUE (pseudo);


--
-- Name: article article_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_condition_id_fkey FOREIGN KEY (condition_id) REFERENCES public.condition(id) ON DELETE CASCADE;


--
-- Name: manga manga_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT manga_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE CASCADE;


--
-- Name: user user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Amine03824
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: Amine03824
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

