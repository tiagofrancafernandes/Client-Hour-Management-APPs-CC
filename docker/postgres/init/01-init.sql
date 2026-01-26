-- Tiago Apps PostgreSQL Initialization Script
-- =======================================
-- This script runs automatically when the PostgreSQL container is first created.
-- It sets up the database with proper encoding and extensions.

-- Enable useful extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Grant permissions (the main database is already created by POSTGRES_DB env var)
-- Add any additional initialization here

-- Example: Create additional databases for testing
-- CREATE DATABASE mkpay_test;
-- GRANT ALL PRIVILEGES ON DATABASE mkpay_test TO tiagoapps;
