--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.vframesentencemaps DROP CONSTRAINT fk_vframesentencemaps_wordid;
ALTER TABLE ONLY public.vframesentencemaps DROP CONSTRAINT fk_vframesentencemaps_synsetid;
ALTER TABLE ONLY public.vframesentencemaps DROP CONSTRAINT fk_vframesentencemaps_sentenceid;
ALTER TABLE ONLY public.vframemaps DROP CONSTRAINT fk_vframemaps_wordid;
ALTER TABLE ONLY public.vframemaps DROP CONSTRAINT fk_vframemaps_synsetid;
ALTER TABLE ONLY public.vframemaps DROP CONSTRAINT fk_vframemaps_frameid;
ALTER TABLE ONLY public.synsets DROP CONSTRAINT fk_synsets_lexdomainid;
ALTER TABLE ONLY public.senses DROP CONSTRAINT fk_senses_wordid;
ALTER TABLE ONLY public.senses DROP CONSTRAINT fk_senses_synsetid;
ALTER TABLE ONLY public.semlinks DROP CONSTRAINT fk_semlinks_synset2id;
ALTER TABLE ONLY public.semlinks DROP CONSTRAINT fk_semlinks_synset1id;
ALTER TABLE ONLY public.semlinks DROP CONSTRAINT fk_semlinks_linkid;
ALTER TABLE ONLY public.samples DROP CONSTRAINT fk_samples_synsetid;
ALTER TABLE ONLY public.morphmaps DROP CONSTRAINT fk_morphmaps_wordid;
ALTER TABLE ONLY public.morphmaps DROP CONSTRAINT fk_morphmaps_morphid;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT fk_lexlinks_word2id;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT fk_lexlinks_word1id;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT fk_lexlinks_synset2id;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT fk_lexlinks_synset1id;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT fk_lexlinks_linkid;
ALTER TABLE ONLY public.casedwords DROP CONSTRAINT fk_casedwords_wordid;
ALTER TABLE ONLY public.adjpositions DROP CONSTRAINT fk_adjpositions_wordid;
ALTER TABLE ONLY public.adjpositions DROP CONSTRAINT fk_adjpositions_synsetid;
DROP INDEX public.unq_words_lemma;
DROP INDEX public.unq_senses_sensekey;
DROP INDEX public.unq_senses_senseid;
DROP INDEX public.unq_morphs_morph;
DROP INDEX public.unq_casedwords_cased;
DROP INDEX public.k_vframesentencemaps_wordid;
DROP INDEX public.k_vframesentencemaps_synsetid;
DROP INDEX public.k_vframesentencemaps_sentenceid;
DROP INDEX public.k_vframemaps_wordid;
DROP INDEX public.k_vframemaps_synsetid;
DROP INDEX public.k_vframemaps_frameid;
DROP INDEX public.k_synsets_lexdomainid;
DROP INDEX public.k_senses_wordid;
DROP INDEX public.k_senses_synsetid;
DROP INDEX public.k_semlinks_synset2id;
DROP INDEX public.k_semlinks_synset1id;
DROP INDEX public.k_semlinks_linkid;
DROP INDEX public.k_samples_synsetid;
DROP INDEX public.k_morphmaps_wordid;
DROP INDEX public.k_morphmaps_morphid;
DROP INDEX public.k_lexlinks_word2id;
DROP INDEX public.k_lexlinks_word1id;
DROP INDEX public.k_lexlinks_synset2id_word2id;
DROP INDEX public.k_lexlinks_synset2id;
DROP INDEX public.k_lexlinks_synset1id_word1id;
DROP INDEX public.k_lexlinks_synset1id;
DROP INDEX public.k_lexlinks_linkid;
DROP INDEX public.k_casedwords_wordid;
DROP INDEX public.k_adjpositions_wordid;
DROP INDEX public.k_adjpositions_synsetid;
ALTER TABLE ONLY public.words DROP CONSTRAINT pk_words;
ALTER TABLE ONLY public.vframesentences DROP CONSTRAINT pk_vframesentences;
ALTER TABLE ONLY public.vframesentencemaps DROP CONSTRAINT pk_vframesentencemaps;
ALTER TABLE ONLY public.vframes DROP CONSTRAINT pk_vframes;
ALTER TABLE ONLY public.vframemaps DROP CONSTRAINT pk_vframemaps;
ALTER TABLE ONLY public.synsets DROP CONSTRAINT pk_synsets;
ALTER TABLE ONLY public.senses DROP CONSTRAINT pk_senses;
ALTER TABLE ONLY public.semlinks DROP CONSTRAINT pk_semlinks;
ALTER TABLE ONLY public.samples DROP CONSTRAINT pk_samples;
ALTER TABLE ONLY public.postypes DROP CONSTRAINT pk_postypes;
ALTER TABLE ONLY public.morphs DROP CONSTRAINT pk_morphs;
ALTER TABLE ONLY public.morphmaps DROP CONSTRAINT pk_morphmaps;
ALTER TABLE ONLY public.linktypes DROP CONSTRAINT pk_linktypes;
ALTER TABLE ONLY public.lexlinks DROP CONSTRAINT pk_lexlinks;
ALTER TABLE ONLY public.lexdomains DROP CONSTRAINT pk_lexdomains;
ALTER TABLE ONLY public.casedwords DROP CONSTRAINT pk_casedwords;
ALTER TABLE ONLY public.adjpositiontypes DROP CONSTRAINT pk_adjpositiontypes;
ALTER TABLE ONLY public.adjpositions DROP CONSTRAINT pk_adjpositions;
DROP TABLE public.words;
DROP TABLE public.vframesentences;
DROP TABLE public.vframesentencemaps;
DROP TABLE public.vframes;
DROP TABLE public.vframemaps;
DROP TABLE public.synsets;
DROP TABLE public.senses;
DROP TABLE public.semlinks;
DROP TABLE public.samples;
DROP TABLE public.postypes;
DROP TABLE public.morphs;
DROP TABLE public.morphmaps;
DROP TABLE public.linktypes;
DROP TABLE public.lexlinks;
DROP TABLE public.lexdomains;
DROP TABLE public.casedwords;
DROP TABLE public.adjpositiontypes;
DROP TABLE public.adjpositions;
SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adjpositions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adjpositions (
    synsetid integer DEFAULT 0 NOT NULL,
    wordid integer DEFAULT 0 NOT NULL,
    "position" character(2) NOT NULL
);


--
-- Name: adjpositiontypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adjpositiontypes (
    "position" character(2) NOT NULL,
    positionname character varying(24) NOT NULL
);


--
-- Name: casedwords; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casedwords (
    casedwordid integer DEFAULT 0 NOT NULL,
    wordid integer DEFAULT 0 NOT NULL,
    cased character varying(80) NOT NULL
);


--
-- Name: lexdomains; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lexdomains (
    lexdomainid smallint DEFAULT 0::smallint NOT NULL,
    lexdomainname character varying(32) DEFAULT NULL::character varying,
    pos character(1) DEFAULT NULL::bpchar
);


--
-- Name: lexlinks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lexlinks (
    synset1id integer DEFAULT 0 NOT NULL,
    word1id integer DEFAULT 0 NOT NULL,
    synset2id integer DEFAULT 0 NOT NULL,
    word2id integer DEFAULT 0 NOT NULL,
    linkid smallint DEFAULT 0::smallint NOT NULL
);


--
-- Name: linktypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE linktypes (
    linkid smallint DEFAULT 0::smallint NOT NULL,
    link character varying(50) DEFAULT NULL::character varying,
    recurses boolean DEFAULT false NOT NULL
);


--
-- Name: morphmaps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE morphmaps (
    wordid integer DEFAULT 0 NOT NULL,
    pos character(1) DEFAULT NULL::bpchar NOT NULL,
    morphid integer DEFAULT 0 NOT NULL
);


--
-- Name: morphs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE morphs (
    morphid integer DEFAULT 0 NOT NULL,
    morph character varying(70) NOT NULL
);


--
-- Name: postypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE postypes (
    pos character(1) NOT NULL,
    posname character varying(20) NOT NULL
);


--
-- Name: samples; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE samples (
    synsetid integer DEFAULT 0 NOT NULL,
    sampleid smallint DEFAULT 0::smallint NOT NULL,
    sample text NOT NULL
);


--
-- Name: semlinks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE semlinks (
    synset1id integer DEFAULT 0 NOT NULL,
    synset2id integer DEFAULT 0 NOT NULL,
    linkid smallint DEFAULT 0::smallint NOT NULL
);


--
-- Name: senses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE senses (
    wordid integer DEFAULT 0 NOT NULL,
    casedwordid integer,
    synsetid integer DEFAULT 0 NOT NULL,
    senseid integer,
    sensenum smallint DEFAULT 0::smallint NOT NULL,
    lexid smallint DEFAULT 0::smallint NOT NULL,
    tagcount integer,
    sensekey character varying(100) DEFAULT NULL::character varying
);


--
-- Name: synsets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE synsets (
    synsetid integer DEFAULT 0 NOT NULL,
    pos character(1) DEFAULT NULL::bpchar,
    lexdomainid smallint DEFAULT 0::smallint NOT NULL,
    definition text
);


--
-- Name: vframemaps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vframemaps (
    synsetid integer DEFAULT 0 NOT NULL,
    wordid integer NOT NULL,
    frameid smallint DEFAULT 0::smallint NOT NULL
);


--
-- Name: vframes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vframes (
    frameid smallint DEFAULT 0::smallint NOT NULL,
    frame character varying(50) DEFAULT NULL::character varying
);


--
-- Name: vframesentencemaps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vframesentencemaps (
    synsetid integer DEFAULT 0 NOT NULL,
    wordid integer DEFAULT 0 NOT NULL,
    sentenceid smallint DEFAULT 0::smallint NOT NULL
);


--
-- Name: vframesentences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vframesentences (
    sentenceid smallint DEFAULT 0::smallint NOT NULL,
    sentence text
);


--
-- Name: words; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE words (
    wordid integer DEFAULT 0 NOT NULL,
    lemma character varying(80) NOT NULL
);


--
-- Name: pk_adjpositions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adjpositions
    ADD CONSTRAINT pk_adjpositions PRIMARY KEY (synsetid, wordid);


--
-- Name: pk_adjpositiontypes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adjpositiontypes
    ADD CONSTRAINT pk_adjpositiontypes PRIMARY KEY ("position");


--
-- Name: pk_casedwords; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casedwords
    ADD CONSTRAINT pk_casedwords PRIMARY KEY (casedwordid);


--
-- Name: pk_lexdomains; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lexdomains
    ADD CONSTRAINT pk_lexdomains PRIMARY KEY (lexdomainid);


--
-- Name: pk_lexlinks; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lexlinks
    ADD CONSTRAINT pk_lexlinks PRIMARY KEY (word1id, synset1id, word2id, synset2id, linkid);


--
-- Name: pk_linktypes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY linktypes
    ADD CONSTRAINT pk_linktypes PRIMARY KEY (linkid);


--
-- Name: pk_morphmaps; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY morphmaps
    ADD CONSTRAINT pk_morphmaps PRIMARY KEY (morphid, pos, wordid);


--
-- Name: pk_morphs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY morphs
    ADD CONSTRAINT pk_morphs PRIMARY KEY (morphid);


--
-- Name: pk_postypes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY postypes
    ADD CONSTRAINT pk_postypes PRIMARY KEY (pos);


--
-- Name: pk_samples; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT pk_samples PRIMARY KEY (synsetid, sampleid);


--
-- Name: pk_semlinks; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY semlinks
    ADD CONSTRAINT pk_semlinks PRIMARY KEY (synset1id, synset2id, linkid);


--
-- Name: pk_senses; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY senses
    ADD CONSTRAINT pk_senses PRIMARY KEY (wordid, synsetid);


--
-- Name: pk_synsets; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY synsets
    ADD CONSTRAINT pk_synsets PRIMARY KEY (synsetid);


--
-- Name: pk_vframemaps; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vframemaps
    ADD CONSTRAINT pk_vframemaps PRIMARY KEY (synsetid, wordid, frameid);


--
-- Name: pk_vframes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vframes
    ADD CONSTRAINT pk_vframes PRIMARY KEY (frameid);


--
-- Name: pk_vframesentencemaps; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vframesentencemaps
    ADD CONSTRAINT pk_vframesentencemaps PRIMARY KEY (synsetid, wordid, sentenceid);


--
-- Name: pk_vframesentences; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vframesentences
    ADD CONSTRAINT pk_vframesentences PRIMARY KEY (sentenceid);


--
-- Name: pk_words; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY words
    ADD CONSTRAINT pk_words PRIMARY KEY (wordid);


--
-- Name: k_adjpositions_synsetid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_adjpositions_synsetid ON adjpositions USING btree (synsetid);


--
-- Name: k_adjpositions_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_adjpositions_wordid ON adjpositions USING btree (wordid);


--
-- Name: k_casedwords_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_casedwords_wordid ON casedwords USING btree (wordid);


--
-- Name: k_lexlinks_linkid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_linkid ON lexlinks USING btree (linkid);


--
-- Name: k_lexlinks_synset1id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_synset1id ON lexlinks USING btree (synset1id);


--
-- Name: k_lexlinks_synset1id_word1id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_synset1id_word1id ON lexlinks USING btree (synset1id, word1id);


--
-- Name: k_lexlinks_synset2id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_synset2id ON lexlinks USING btree (synset2id);


--
-- Name: k_lexlinks_synset2id_word2id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_synset2id_word2id ON lexlinks USING btree (synset2id, word2id);


--
-- Name: k_lexlinks_word1id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_word1id ON lexlinks USING btree (word1id);


--
-- Name: k_lexlinks_word2id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_lexlinks_word2id ON lexlinks USING btree (word2id);


--
-- Name: k_morphmaps_morphid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_morphmaps_morphid ON morphmaps USING btree (morphid);


--
-- Name: k_morphmaps_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_morphmaps_wordid ON morphmaps USING btree (wordid);


--
-- Name: k_samples_synsetid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_samples_synsetid ON samples USING btree (synsetid);


--
-- Name: k_semlinks_linkid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_semlinks_linkid ON semlinks USING btree (linkid);


--
-- Name: k_semlinks_synset1id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_semlinks_synset1id ON semlinks USING btree (synset1id);


--
-- Name: k_semlinks_synset2id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_semlinks_synset2id ON semlinks USING btree (synset2id);


--
-- Name: k_senses_synsetid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_senses_synsetid ON senses USING btree (synsetid);


--
-- Name: k_senses_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_senses_wordid ON senses USING btree (wordid);


--
-- Name: k_synsets_lexdomainid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_synsets_lexdomainid ON synsets USING btree (lexdomainid);


--
-- Name: k_vframemaps_frameid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframemaps_frameid ON vframemaps USING btree (frameid);


--
-- Name: k_vframemaps_synsetid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframemaps_synsetid ON vframemaps USING btree (synsetid);


--
-- Name: k_vframemaps_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframemaps_wordid ON vframemaps USING btree (wordid);


--
-- Name: k_vframesentencemaps_sentenceid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframesentencemaps_sentenceid ON vframesentencemaps USING btree (sentenceid);


--
-- Name: k_vframesentencemaps_synsetid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframesentencemaps_synsetid ON vframesentencemaps USING btree (synsetid);


--
-- Name: k_vframesentencemaps_wordid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX k_vframesentencemaps_wordid ON vframesentencemaps USING btree (wordid);


--
-- Name: unq_casedwords_cased; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unq_casedwords_cased ON casedwords USING btree (cased);


--
-- Name: unq_morphs_morph; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unq_morphs_morph ON morphs USING btree (morph);


--
-- Name: unq_senses_senseid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unq_senses_senseid ON senses USING btree (senseid);


--
-- Name: unq_senses_sensekey; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unq_senses_sensekey ON senses USING btree (sensekey);


--
-- Name: unq_words_lemma; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unq_words_lemma ON words USING btree (lemma);


--
-- PostgreSQL database dump complete
--

