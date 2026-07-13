import boto3
from dotenv import load_dotenv
import os
from datetime import datetime ,date
import pandas as pd
import logging

logger = logging.getLogger(__name__)

load_dotenv()


def s3_upload(df, table_name):
    
    try:
        s3_client = boto3.client(
            's3',
            region_name='eu-north-1',
            aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
            aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY")
        )
        
        df["created_timestamp"] = pd.to_datetime(df["created_timestamp"], errors="coerce")
        df["updated_timestamp"] = pd.to_datetime(df["updated_timestamp"], errors="coerce")
        
        file_name = f"{table_name}.parquet"
        
        df.to_parquet(file_name, index=False)

        now = datetime.now()

        key = (
            f"raw/{table_name}/"
            f"load_date={now.strftime('%Y%m%d')}/"
            f"{file_name}_{now.strftime('%Y%m%d%H%M%S')}.parquet"
        )
        
        s3_client.upload_file(
            file_name,
            "retailflowproject",
            key
        )
        
        os.remove(file_name)
        
        logger.info(f"{file_name} is uploaded at: {key}")
        
    except Exception:
        logger.exception("S3 upload failed")
        raise
    
    


