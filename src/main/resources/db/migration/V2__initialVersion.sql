DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS certificate;
DROP TABLE IF EXISTS confirmation;

DROP TABLE IF EXISTS construction_object;
DROP TABLE IF EXISTS project_partition;
DROP TABLE IF EXISTS project_document;
DROP TABLE IF EXISTS documentation_sheet;
DROP TABLE IF EXISTS kind_of_work;
DROP TABLE IF EXISTS work_certificate;
DROP TABLE IF EXISTS work_confirmation;
DROP TABLE IF EXISTS work_employee;

CREATE TABLE organization (
  id                       BIGINT NOT NULL AUTO_INCREMENT,
  address                  VARCHAR(255),
  fax_number               VARCHAR(255),
  inn                      VARCHAR(255),
  name                     VARCHAR(255),
  ogrn                     VARCHAR(255),
  organization_issuing_sro VARCHAR(255),
  phone_number             VARCHAR(255),
  sro_issued_date          TIMESTAMP,
  sro_number               VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE person (
  id          BIGINT NOT NULL AUTO_INCREMENT,
  middle_name VARCHAR(255),
  name        VARCHAR(255),
  surname     VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE employee (
  id              BIGINT NOT NULL AUTO_INCREMENT,
  order_date      TIMESTAMP,
  order_number    VARCHAR(255),
  position        VARCHAR(255),
  organization_id BIGINT,
  person_id       BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT e_organization_id FOREIGN KEY (organization_id) REFERENCES organization(id),
  CONSTRAINT e_person_id FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE SET NULL
);

CREATE TABLE certificate (
  id                BIGINT NOT NULL AUTO_INCREMENT,
  document_copy     VARCHAR(255),
  document_date     TIMESTAMP,
  document_end_date TIMESTAMP,
  document_kind     VARCHAR(255),
  document_number   VARCHAR(255),
  material          VARCHAR(255),
  material_volume   DOUBLE,
  measure_unit      VARCHAR(255),
  standard_document VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE confirmation (
  id         BIGINT NOT NULL AUTO_INCREMENT,
  copy       VARCHAR(255),
  issue_date TIMESTAMP,
  name       VARCHAR(255),
  number     VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE construction_object (
  id           BIGINT NOT NULL AUTO_INCREMENT,
  code         VARCHAR(255),
  copies       BIGINT,
  name         VARCHAR(255),
  customer_id  BIGINT,
  developer_id BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT co_customer_id FOREIGN KEY (customer_id) REFERENCES organization(id) ON DELETE SET NULL,
  CONSTRAINT co_developer_id FOREIGN KEY (developer_id) REFERENCES organization(id) ON DELETE SET NULL
);

CREATE TABLE project_partition (
  id                     BIGINT NOT NULL AUTO_INCREMENT,
  code                   VARCHAR(255),
  name                   VARCHAR(255),
  construction_object_id BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT pp_construction_object_id FOREIGN KEY (construction_object_id) REFERENCES construction_object(id)
);

CREATE TABLE project_document (
  id                          BIGINT NOT NULL AUTO_INCREMENT,
  code                        VARCHAR(255),
  name                        VARCHAR(255),
  phase                       VARCHAR(255),
  author_id                   BIGINT,
  customer_representative_id  BIGINT,
  developer_representative_id BIGINT,
  project_partition_id        BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT pd_author_id FOREIGN KEY (author_id) REFERENCES employee(id) ON DELETE SET NULL,
  CONSTRAINT pd_customer_representative_id FOREIGN KEY (customer_representative_id) REFERENCES employee(id) ON DELETE SET NULL,
  CONSTRAINT pd_developer_representative_id FOREIGN KEY (developer_representative_id) REFERENCES employee(id) ON DELETE SET NULL,
  CONSTRAINT pd_project_partition_id FOREIGN KEY (project_partition_id) REFERENCES project_partition(id)
);

CREATE TABLE documentation_sheet (
  id                  BIGINT NOT NULL AUTO_INCREMENT,
  change_number        BIGINT,
  name                VARCHAR(255),
  number              BIGINT,
  project_document_id BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT ds_project_document_id FOREIGN KEY (project_document_id) REFERENCES project_document(id)
);

CREATE TABLE kind_of_work (
  id                         BIGINT NOT NULL AUTO_INCREMENT,
  additional_reason          VARCHAR(255),
  amount_of_work             VARCHAR(255),
  begin_date                 timestamp,
  end_date                   timestamp,
  measure_unit               VARCHAR(255),
  name                       VARCHAR(255),
  presentation_date          timestamp,
  documentation_sheet_id     BIGINT,
  executor_id                BIGINT,
  executor_representative_id BIGINT,
  PRIMARY KEY (id),
  CONSTRAINT kow_documentation_sheet_id FOREIGN KEY (documentation_sheet_id) REFERENCES documentation_sheet(id),
  CONSTRAINT kow_executor_id FOREIGN KEY (executor_id) REFERENCES organization(id),
  CONSTRAINT kow_executor_representative_id FOREIGN KEY (executor_representative_id) REFERENCES employee(id) ON DELETE SET NULL
);

CREATE TABLE work_certificate (
  work_id        BIGINT NOT NULL,
  certificate_id BIGINT NOT NULL,
  PRIMARY KEY (work_id, certificate_id),
  CONSTRAINT wcer_work_id FOREIGN KEY (work_id) REFERENCES kind_of_work(id),
  CONSTRAINT wcer_certificate_id FOREIGN KEY (certificate_id) REFERENCES certificate(id) ON DELETE CASCADE
);

CREATE TABLE work_confirmation (
  work_id         BIGINT NOT NULL,
  confirmation_id BIGINT NOT NULL,
  PRIMARY KEY (work_id, confirmation_id),
  CONSTRAINT wcon_work_id FOREIGN KEY (work_id) REFERENCES kind_of_work(id),
  CONSTRAINT wcon_confirmation_id FOREIGN KEY (confirmation_id) REFERENCES confirmation(id) ON DELETE CASCADE
);

CREATE TABLE work_employee (
  work_id     BIGINT NOT NULL,
  employee_id BIGINT NOT NULL,
  PRIMARY KEY (work_id, employee_id),
  CONSTRAINT we_work_id FOREIGN KEY (work_id) REFERENCES kind_of_work(id),
  CONSTRAINT we_employee_id FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE
);