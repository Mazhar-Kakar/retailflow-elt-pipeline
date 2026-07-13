import pandas as pd
from sqlalchemy import text
import logging
from ingestion_scripts.database.connection import engine
from ingestion_scripts.metadata.metadata import get_last_loaded_timestamp 
from ingestion_scripts.validation.validator import load_validation_config

logger = logging.getLogger(__name__)

# Extract
def extract(table_name):
    
    columns = ", ".join(
        load_validation_config()[table_name]["columns"]
    )
        
    last_loaded = get_last_loaded_timestamp(table_name)

    if last_loaded is None:

        query = f"""
        SELECT
            {columns}
        FROM {table_name} 
        ORDER BY updated_timestamp ASC
        """

        params = None

        logger.info("Full load")

    else:

        query = f"""
        SELECT
            {columns}
        FROM {table_name}
        WHERE updated_timestamp > :loaded_at
        ORDER BY updated_timestamp ASC 
        """

        params = {
            "loaded_at": last_loaded
        }

        logger.info("Incremental load")

    try:
        with engine.connect() as connection:

            return pd.read_sql(
                text(query),
                connection,
                params=params
            )

    except Exception as e:
        logger.error(f"Extraction failed: {e}")
        raise
