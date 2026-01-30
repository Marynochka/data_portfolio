-- =====================================================
-- LOAD OLIST DATA
-- =====================================================


---\copy customers FROM 'PATH/olist-ecommerce/data/raw/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy sellers FROM 'PATH/olist-ecommerce/data/raw/olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy products FROM 'PATH/olist-ecommerce/data/raw/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy orders FROM 'PATH/olist-ecommerce/data/raw/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy order_items FROM 'PATH/olist-ecommerce/data/raw/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy payments FROM 'PATH/olist-ecommerce/data/raw/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy reviews FROM 'PATH/olist-ecommerce/data/raw/olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy geolocation FROM 'PATH/olist-ecommerce/data/raw/olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;

--\copy product_category_translation FROM 'PATH/olist-ecommerce/data/raw/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;