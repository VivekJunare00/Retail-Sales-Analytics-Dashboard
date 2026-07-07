import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
#from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# ==========================
# DATABASE CONFIGURATION
# ==========================

USERNAME = "root"
PASSWORD = "Vivek@06"   # <-- Replace with your MySQL password
HOST = "localhost"
DATABASE = "retail_analytics"

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=USERNAME,
    password=PASSWORD,
    host=HOST,
    database=DATABASE,
)

engine = create_engine(connection_url)
# ==========================
# DATASET LOCATION
# ==========================

DATA_FOLDER = r"D:\Data Analysis Project\Retail Data Analytics Project\Data"

# ==========================
# FILES TO IMPORT
# ==========================

datasets = {
    "customers": "olist_customers_dataset.csv",
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "payments": "olist_order_payments_dataset.csv",
    "products": "olist_products_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "reviews": "olist_order_reviews_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "category_translation": "product_category_name_translation.csv"
}

print("=" * 60)
print("Retail Analytics Data Import")
print("=" * 60)

for table_name, file_name in datasets.items():

    try:

        file_path = os.path.join(DATA_FOLDER, file_name)

        print(f"\nImporting {table_name}...")

        df = pd.read_csv(file_path)

        df.to_sql(
            table_name,
            con=engine,
            if_exists="replace",
            index=False,
            chunksize=5000
        )

        print(f"SUCCESS: {table_name} ({len(df):,} rows)")

    except Exception as e:
        print(f"FAILED: {table_name}")
        print(e)

print("\nAll imports completed.")