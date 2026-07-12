import pandas as pd
import logging
from ingestion.extraction.extractor import extract
from ingestion.metadata.metadata import update_last_loaded_timestamp
from ingestion.validation.validator import validate
from ingestion.load.s3_loader import s3_upload
import sys

logging.basicConfig(
    level=logging.INFO,
    filename="ingestion/logs/logs.log",
    filemode="a",
    format="%(asctime)s | %(levelname)s | %(message)s"
)
    
logger = logging.getLogger(__name__)


SOURCE_TABLE = "erp.stores"
DATASET = "stores"

def store_pipeline():

    try:
        logger.info("Store pipeline started")
        
        # Extract
        df = extract(SOURCE_TABLE)

        if df.empty:
            logger.info(f"No new records found for {SOURCE_TABLE}.")
            sys.exit(0)
        
        logger.info("Store data extracted")
        
        
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
        
        logger.info("Store pipeline completed")
        
    except Exception:
        logger.exception("Store pipeline failed")
        raise


if __name__ == "__main__":
    store_pipeline()


            
            
            
