-- SRP Call Log Challenge SQL Script
-- This script contains all SQL statements required to complete the challenge

-- 1. Create schema HOME_SERVICE_CALL_LOGS in DEMO_DB database
USE DATABASE DEMO_DB;
CREATE SCHEMA IF NOT EXISTS HOME_SERVICE_CALL_LOGS;
USE SCHEMA HOME_SERVICE_CALL_LOGS;

-- 2. Create internal stage LOGS_STAGE
CREATE OR REPLACE STAGE LOGS_STAGE;

-- NOTE: To upload JSON files to this stage, run the upload_files.sh script
-- This script contains the snow stage copy command to upload all files from home_service_inbound/

-- 3. Create JSON file format for parsing
CREATE OR REPLACE FILE FORMAT JSON_FORMAT TYPE = 'JSON';

-- 4. Inspect content of one JSON file from the stage (first 10 rows)
SELECT $1 FROM @LOGS_STAGE/0009951b3ce84588991ff4f71fb69c1b_transcript.json LIMIT 10;

-- 5. Infer schema from JSON files using INFER_SCHEMA function
SELECT * FROM TABLE(INFER_SCHEMA(LOCATION=>'@LOGS_STAGE', FILE_FORMAT=>'JSON_FORMAT'));

-- 6. Create table with TEXT, CONFIDENCE, AUDIO_DURATION columns
CREATE OR REPLACE TABLE CALL_LOGS (
    TEXT VARCHAR,
    CONFIDENCE FLOAT,
    AUDIO_DURATION FLOAT
);

-- 7. COPY INTO statement to load data from all JSON files
COPY INTO CALL_LOGS (TEXT, CONFIDENCE, AUDIO_DURATION)
FROM (
    SELECT 
        $1:text::VARCHAR,
        $1:confidence::FLOAT,
        $1:audio_duration::FLOAT
    FROM @LOGS_STAGE
)
FILE_FORMAT = (TYPE = 'JSON')
PATTERN = '.*_transcript\.json';
