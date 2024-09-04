-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY, 
    customer_name VARCHAR(100) NOT NULL, 
    email_address VARCHAR(100) UNIQUE NOT NULL, 
    country VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) 
);

-- This table normalizes customer data, separating it from transaction information.
-- The SERIAL PRIMARY KEY ensures efficient indexing and quick lookups.
-- The UNIQUE constraint on email_address prevents duplicate email registrations.

-- Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY, 
    product_name VARCHAR(100) NOT NULL, 
    price DECIMAL(10, 2) NOT NULL, 
    category VARCHAR(50) NOT NULL, 
    description TEXT, 
    stock_quantity INT NOT NULL
);

-- This table separates product information from sales data, normalizing the database.
-- The DECIMAL type for price ensures accurate monetary values.
-- Including stock_quantity allows for inventory tracking.

-- Sales Transactions Table
CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY, 
    customer_id INT NOT NULL, 
    product_id INT NOT NULL, 
    purchase_date DATE NOT NULL, 
    quantity_purchased INT NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- This table represents the many-to-many relationship between customers and products.
-- Foreign keys ensure data integrity and establish relationships between tables.
-- Separating transactions from customer and product details normalizes the data structure.

-- Shipping Details Table
CREATE TABLE shipping_details (
    shipping_id SERIAL PRIMARY KEY, 
    transaction_id INT NOT NULL, 
    shipping_date DATE NOT NULL, 
    shipping_address VARCHAR(200) NOT NULL, 
    city VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES sales_transactions (transaction_id)
);

-- This table further normalizes the data by separating shipping information from transactions.
-- The foreign key to sales_transactions ensures each shipping record is tied to a valid transaction.
-- Splitting address components (city, country, postal_code) allows for more flexible querying and reporting.