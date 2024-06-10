--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    name_id integer NOT NULL,
    name character varying(22) NOT NULL,
    games integer,
    best_guess integer
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_name_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_name_id_seq OWNER TO freecodecamp;

--
-- Name: players_name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_name_id_seq OWNED BY public.players.name_id;


--
-- Name: players name_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN name_id SET DEFAULT nextval('public.players_name_id_seq'::regclass);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (1, 'Admin', 3, 3);
INSERT INTO public.players VALUES (3, 'user_1717998451922', 2, 133);
INSERT INTO public.players VALUES (2, 'user_1717998451923', 6, 204);
INSERT INTO public.players VALUES (5, 'user_1717998618811', 2, 199);
INSERT INTO public.players VALUES (4, 'user_1717998618812', 6, 613);
INSERT INTO public.players VALUES (7, 'user_1717998779316', 2, 205);
INSERT INTO public.players VALUES (6, 'user_1717998779317', 6, 343);
INSERT INTO public.players VALUES (9, 'user_1717998837312', 2, 490);
INSERT INTO public.players VALUES (8, 'user_1717998837313', 6, 17);


--
-- Name: players_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_name_id_seq', 1, true);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (name_id);


--
-- PostgreSQL database dump complete
--

