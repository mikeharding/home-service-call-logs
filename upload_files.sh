#!/bin/bash

# Script to upload JSON files to Snowflake internal stage
# This script uploads all JSON transcript files from the home_service_inbound directory
# to the LOGS_STAGE in the HOME_SERVICE_CALL_LOGS schema

echo "Uploading JSON files to Snowflake stage..."
snow stage copy home_service_inbound/ @DEMO_DB.HOME_SERVICE_CALL_LOGS.LOGS_STAGE

echo "Upload completed. Files are now available in the LOGS_STAGE."
