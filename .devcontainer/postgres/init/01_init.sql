-- Create postgres user
CREATE USER postgres WITH PASSWORD 'postgres';

CREATE EXTENSION pg_stat_statements;
SELECT * FROM pg_available_extensions WHERE name = 'pg_stat_statements';

CREATE DATABASE templateJP TEMPLATE=template0 LC_COLLATE="ja_JP.UTF-8" LC_CTYPE="ja_JP.UTF-8" IS_TEMPLATE=true;

-- Create user
CREATE USER testuser WITH PASSWORD '<your-password-here>';
-- Create database
CREATE DATABASE testdb TEMPLATE=templateJP;
-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE testdb TO testuser;