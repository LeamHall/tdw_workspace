/* people_1416_ddl.sql

*/

DROP TABLE if EXISTS people_1416;

CREATE TABLE if NOT EXISTS people_1416(
  id            INTEGER PRIMARY KEY,
  first_name    varchar[20],
  last_name     varchar[20],
  upp           varchar[6],
  psr           varchar[1],
  gender        varchar[6],
  species       varchar[10],
  morale        INTEGER,
  organization  varchar[20],
  allegiance    varchar[20],
  location      varchar[20],
  home          varchar[20],
  career        varchar[30],
  skills        text,
  gear          text,
  description   text,
  notes         text 
);

