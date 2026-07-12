import boto3
from dotenv import load_dotenv
import os
from datetime import date
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
        
        file_name = f"{table_name}.parquet"
        
        df.to_parquet(file_name, index=False)
        
        key = (
            f"raw/{table_name}/"
            f"load_date={date.today()}/{file_name}"
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
    