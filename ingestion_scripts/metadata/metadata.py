import pandas as pd
from sqlalchemy import text
from ingestion_scripts.database.connection import engine
import logging

logger = logging.getLogger(__name__)


def update_last_loaded_timestamp(table_name, updated_timestamp):
    try:
        with engine.begin() as connection:
            connection.execute(
                text("""
                    INSERT INTO metadata.ingestion_metadata (table_name, last_loaded_at)
                    VALUES (:table_name, :updated_timestamp)
                    ON CONFLICT (table_name) 
                    DO UPDATE SET last_loaded_at = EXCLUDED.last_loaded_at;
                """),
                {
                    "updated_timestamp": updated_timestamp,
                    "table_name": table_name
                }
            )

    except Exception as e:
        logger.error(f"Metadata update failed: {e}")
        raise



def get_last_loaded_timestamp(table_name):
    try:
        with engine.connect() as connection:

            df = pd.read_sql(
                text("""
                    SELECT last_loaded_at
                    FROM metadata.ingestion_metadata
                    WHERE table_name = :table_name
                """),
                connection,
                params={"table_name": table_name}
            )

            if df.empty:
                return None

            return df.iloc[0]["last_loaded_at"]

    except Exception as e:
        logger.error(f"Metadata extraction failed: {e}")
        raise     
            
