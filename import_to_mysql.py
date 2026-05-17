import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

# MySQL connection
username = "root"
password = quote_plus("mari@123")
host = "localhost"
database = "ecommerce_analysis"

engine = create_engine(
    f"mysql+pymysql://{username}:{password}@{host}/{database}"
)

files = {
    "orders": "data/olist_orders_dataset.csv",
    "order_items": "data/olist_order_items_dataset.csv",
    "customers": "data/olist_customers_dataset.csv",
    "products": "data/olist_products_dataset.csv"
}

for table_name, file_path in files.items():
    print(f"Importing {table_name}...")

    df = pd.read_csv(file_path)

    df.to_sql(
        name=table_name,
        con=engine,
        if_exists="replace",
        index=False
    )

    print(f"{table_name} imported successfully")

print("All files imported successfully")