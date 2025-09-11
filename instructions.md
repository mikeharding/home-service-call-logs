## Instructions for the SRP Call Log Challenge

- The `home_service_inbound` subfolder contains redacted call logs in multiple JSON files downloaded from Hugging Face
- I want to load the data in those files into a table in my Snowflake account.
- Use the `DEMO_DB` database.
- Create a schema called `HOME_SERVICE_CALL_LOGS`.
- Create an internal stage in that schema called `LOGS_STAGE`.
- Enable a directory table on the stage.
- Upload all the files using the Snowflake CLI.
- Create a single SQL file called `h-o-challenge.sql` that will store all statements required to complete all tasks.
- You are allowed to test your SQL statements using the Snowflake CLI. If you create permanent objects, delete them once you are done with your tests.
- Add a SQL statemtent to the SQL file that will inspect the content of one JSON file from the stage, showing the first 10 rows.
- Add another SQL statement to infer the schema from 100 of the json Files.  Hint: `INFER_SCHEMA`
- Add another SQL statement to create a table that will use the results of `INFER_SCHEMA` except that I only want the following columns in my table: `TEXT`, `CONFIDENCE`, `AUDIO_DURATION`.
- Add a `COPY INTO` statement to the SQL file that will load the required fields from the JSON files.  Load all the data from all JSON files.
- Use git to add all the new files you created. Don't add the files in `home_service_inbound`.
- Use git to commit the changes
- Use git to push the changes from origin to main
