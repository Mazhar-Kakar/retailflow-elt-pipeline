import yaml
import logging

logger = logging.getLogger(__name__)


def load_validation_config():
    with open("ingestion/validation/validate.yml", "r") as file:
        return yaml.safe_load(file)


def validate(df, table_name):

    rules = load_validation_config()[table_name]

    expected_columns = rules["columns"]

    for column in expected_columns:
        if column not in df.columns:
            logger.error(f"{table_name}: Missing column: {column}")
            raise ValueError(f"Missing column: {column}")
    