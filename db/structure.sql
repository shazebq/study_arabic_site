--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: animals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE animals (
    id integer NOT NULL,
    name character varying(255),
    weight integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: animals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE animals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: animals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE animals_id_seq OWNED BY animals.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    content text,
    forum_post_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    votes_count integer DEFAULT 0
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category_parent_id integer
);


--
-- Name: categories_categorizables; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories_categorizables (
    id integer NOT NULL,
    category_id integer,
    categorizable_id integer,
    categorizable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_categorizables_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_categorizables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_categorizables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_categorizables_id_seq OWNED BY categories_categorizables.id;


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: forum_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forum_posts (
    id integer NOT NULL,
    title text,
    content text,
    views_count integer,
    votes_count integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    answers_count integer DEFAULT 0
);


--
-- Name: forum_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forum_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forum_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forum_posts_id_seq OWNED BY forum_posts.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resources (
    id integer NOT NULL,
    title text,
    description text,
    downloads_count integer,
    views_count integer,
    votes_count integer,
    difficulty_level integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    resource_file_file_name character varying(255),
    resource_file_content_type character varying(255),
    resource_file_file_size integer,
    resource_file_updated_at timestamp without time zone,
    reviews_count integer
);


--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resources_id_seq OWNED BY resources.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reviews (
    id integer NOT NULL,
    title text,
    content text,
    rating integer,
    user_id integer,
    reviewable_id integer,
    reviewable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE reviews_id_seq OWNED BY reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: views; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE views (
    id integer NOT NULL,
    viewable_id integer,
    viewable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    session_id character varying(255),
    ip_address character varying(255)
);


--
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE votes (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    voteable_id integer,
    voteable_type character varying(255)
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories_categorizables ALTER COLUMN id SET DEFAULT nextval('categories_categorizables_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forum_posts ALTER COLUMN id SET DEFAULT nextval('forum_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources ALTER COLUMN id SET DEFAULT nextval('resources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY reviews ALTER COLUMN id SET DEFAULT nextval('reviews_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Name: animals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: categories_categorizables_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories_categorizables
    ADD CONSTRAINT categories_categorizables_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: forum_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forum_posts
    ADD CONSTRAINT forum_posts_pkey PRIMARY KEY (id);


--
-- Name: resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130114012227');