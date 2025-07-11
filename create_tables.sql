-- Dimension: Customer
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    city VARCHAR(100),
    postal_code VARCHAR(50),
    country VARCHAR(100),
    region VARCHAR(100)
);

-- Dimension: Product
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    plain_category VARCHAR(255),
    category VARCHAR(255),
    sub_category VARCHAR(255)
);

-- Dimension: Date
CREATE TABLE dim_date (
    order_date DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);

-- Fact Table: Sales
CREATE TABLE fact_sales (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    order_mode VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    sales FLOAT,
    cost_price FLOAT,
    quantity INT,
    discount_percent FLOAT NULL, -- Nulls handled
    final_sales_per_unit FLOAT,
    total_sales_disc_inc FLOAT,
    total_sales_disc_not_inc FLOAT,
    final_cost FLOAT,
    total_revenue FLOAT,
    profit_per_unit FLOAT,
    margin_percent FLOAT,
    FOREIGN KEY (order_date) REFERENCES dim_date(order_date),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
