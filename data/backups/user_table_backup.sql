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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: user; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, lastname, firstname, pseudo, birthdate, address, zip_code, city, phone_number, email, password, role_id, created_at, updated_at) FROM stdin;
1	Monkey	D. Luffy	luffy	1994-05-05	1 Rue de la Plage	93200	Saint-Denis	111222333	luffy@email.com	hashed_password	1	2023-12-06 16:43:25.328904+00	\N
2	Light	Yagami	kira	1992-12-21	2 Rue des Ombres	93270	Sevran	444555666	kira@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
3	Naruto	Uzumaki	naruto	1997-10-10	3 Rue des Hokages	93370	Montfermeil	777888999	naruto@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
4	Sasuke	Uchiha	sasuke	1994-07-23	9 Rue des Vengeurs	93370	Montfermeil	666555444	sasuke@email.com	hashed_password	2	2023-12-06 16:43:25.328904+00	\N
9	\N	\N	YsT	\N	\N	\N	\N	\N	tanguy.huart@oclock.school	coucou	1	2023-12-06 22:43:29.061945+00	\N
10	Anthony	Trujillo	anthony_theversus	1901-05-10			dunkerque		qsdqsdqsd@ilqdqsdfa.com	jmEsLint<3	1	2023-12-07 02:04:25.910611+00	\N
13	Olivier	Séné	Olivier_Fan2Rock	1941-05-10			London		qsdqsqsdqsdfsdqsd@ilqdqsdfa.com	TelegraphRoad	1	2023-12-07 02:06:30.491988+00	\N
11	Houd	Alami	HoudChef2projet	2001-05-10			Konoha		qsdqsqsdqsdqsd@ilqdqsdfa.com	Liveshare	1	2023-12-07 02:05:33.483537+00	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 13, true);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_pseudo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pseudo_key UNIQUE (pseudo);


--
-- Name: user user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

