import pandas as pd
from ingestion_scripts.extraction.extractor import extract
from ingestion_scripts.metadata.metadata import update_last_loaded_timestamp
from ingestion_scripts.validation.validator import validate
from ingestion_scripts.load.s3_loader import s3_upload
from ingestion_scripts.logs.logger import setup_logging
import logging

setup_logging()
logger = logging.getLogger(__name__)


SOURCE_TABLE = "erp.customers"
DATASET = "customers"

def customer_pipeline():
    
    try:
        logger.info("Customer pipeline started")
        
        # Extract
        df = extract(SOURCE_TABLE)

        if df.empty:
            logger.info(f"No new records found for {SOURCE_TABLE}.")
            return
        
        logger.info("Customer data extracted")
        
        
        # validate
        validate(df, SOURCE_TABLE)
        logger.info(f"{SOURCE_TABLE} validation passed.")
        logger.info(f"Extracted {len(df)} records from {SOURCE_TABLE}")
        
        # S3 Load
        s3_upload(df, DATASET)
        
        # last loaded timstamp metadata update
        update_last_loaded_timestamp(
            SOURCE_TABLE,
            df["updated_timestamp"].max()
        )
        logger.info("incremental timestamp updated")
        
        logger.info("Customer pipeline completed")
        
    except Exception:
        logger.exception("Customer pipeline failed")
        raise


if __name__ == "__main__":
    customer_pipeline()



            
            
            
