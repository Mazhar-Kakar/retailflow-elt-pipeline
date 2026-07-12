# ingestion/logger.py
import logging

def setup_logging():
    logging.basicConfig(
        level=logging.INFO,
        filename="ingestion/logs/logs.log",
        filemode="a",
        format="%(asctime)s | %(levelname)s | %(message)s"
    )