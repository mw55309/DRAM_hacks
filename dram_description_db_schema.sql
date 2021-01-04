CREATE TABLE kegg_description (
        id VARCHAR(20) NOT NULL,
        description VARCHAR(100000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_kegg_description_id ON kegg_description (id);
CREATE TABLE uniref_description (
        id VARCHAR(40) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_uniref_description_id ON uniref_description (id);
CREATE TABLE pfam_description (
        id VARCHAR(12) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_pfam_description_id ON pfam_description (id);
CREATE TABLE dbcan_description (
        id VARCHAR(30) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_dbcan_description_id ON dbcan_description (id);
CREATE TABLE viral_description (
        id VARCHAR(14) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_viral_description_id ON viral_description (id);
CREATE TABLE peptidase_description (
        id VARCHAR(10) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_peptidase_description_id ON peptidase_description (id);
CREATE TABLE vogdb_description (
        id VARCHAR(10) NOT NULL,
        description VARCHAR(1000),
        PRIMARY KEY (id)
);
CREATE INDEX ix_vogdb_description_id ON vogdb_description (id);
