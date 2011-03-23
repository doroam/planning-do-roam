-- RENAME AS PER V1 - posgresql

-- ##################################################
--	word			words
--		wordid			wordid
--		lemma			lemma
ALTER TABLE words RENAME TO word;

-- ##################################################
--	casedword		casedwords
--		wordid			casedwordid
--		lemma			cased
--					wordid
ALTER TABLE casedwords RENAME TO casedword,
	DROP COLUMN wordid,
	RENAME COLUMN casedwordid TO wordid,
	RENAME COLUMN cased TO lemma,
	DROP INDEX k_casedwords_wordid,
	DROP INDEX unq_casedwords_cased,
	ADD UNIQUE INDEX unq_casedwords_lemma (lemma);

-- ##################################################
--	sense			senses
--		wordid			wordid
--		casedwordid		casedwordid
--		synsetid		synsetid
--		rank			sensenum
--		lexid			lexid
--		tagcount		tagcount
--					senseid
--					sensekey
ALTER TABLE senses RENAME TO sense,
	RENAME COLUMN sensenum TO rank;

-- ##################################################
--	synset			synsets
--		synsetid		synsetid
--		pos			pos
--		categoryid		lexdomainid
--		definition		definition
ALTER TABLE synsets RENAME TO synset,
	RENAME COLUMN lexdomainid TO categoryid;

-- ##################################################
--	linkdef			linktypes
--		linkid			linkid
--		name			link
--		recurses		recurses
ALTER TABLE linktypes RENAME TO linkdef
	RENAME COLUMN link TO name;

-- ##################################################
--	lexlinkref		lexlinks
--		synset1id		synset1id
--		word1id			word1id
--		synset2id		synset2id
--		word2id			word2id
--		linkid			linkid
ALTER TABLE lexlinks RENAME TO lexlinkref;

-- ##################################################
--	semlinkref		semlinks
--		synset1id		synset1id
--		synset2id		synset2id
--		linkid			linkid
ALTER TABLE semlinks RENAME TO semlinkref;

-- ##################################################
--	sample			samples
--		synsetid		synsetid
--		sampleid		sampleid
--		sample			sample
ALTER TABLE samples RENAME TO sample;

-- ##################################################
--	categorydef		lexdomains
--		categoryid		lexdomainid
--		name			lexdomainname
--		pos			pos
ALTER TABLE lexdomains RENAME TO categorydef,
	RENAME COLUMN lexdomainid TO categoryid;
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (lexdomainid);

-- ##################################################
--	morphdef		morphs
--		morphid			morphid
--		lemma			morph
ALTER TABLE morphs RENAME TO morphdef,
	RENAME COLUMN morph TO lemma,
	DROP INDEX unq_morphs_morph,
	ADD UNIQUE INDEX unq_morphs_lemma (lemma);

-- ##################################################
--	morphref		morphmaps
--		wordid			wordid
--		pos			pos
--		morphid			morphid
ALTER TABLE morphmaps RENAME TO morphref;

-- ##################################################
--	sentencedef		vframesentences
--		sentenceid		sentenceid
--		sentence		sentence
ALTER TABLE vframesentences RENAME TO sentencedef;

-- ##################################################
--	sentenceref		vframesentencemaps
--		synsetid		synsetid
--		wordid			wordid
--		sentenceid		sentenceid
ALTER TABLE vframesentencemaps RENAME TO sentenceref;

-- ##################################################
--	wordposition		adjpositions
--		synsetid		synsetid
--		wordid			wordid
--		positionid		position
ALTER TABLE adjpositions RENAME TO wordposition,
	RENAME COLUMN position TO positionid;

-- ##################################################
--	framedef		vframes
--		frameid			frameid
--		frame			frame
ALTER TABLE vframes RENAME TO framedef;

-- ##################################################
--	frameref		vframemaps
--		synsetid		synsetid
--		wordid			wordid
--		frameid			frameid
ALTER TABLE vframemaps RENAME TO frameref;

