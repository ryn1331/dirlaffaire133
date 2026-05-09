-- Migration complète des données vers le nouveau projet Supabase
-- À exécuter dans le SQL Editor du NOUVEAU projet Supabase

-- IMPORTANT: Remplacer YOUR_OLD_DB_PASSWORD par le mot de passe de l'ancien projet
-- Pour l'obtenir: Ancien projet → Settings → Database → Connection Pooling → Password

-- Activer dblink extension si nécessaire
CREATE EXTENSION IF NOT EXISTS dblink;

-- Migration des produits
INSERT INTO products (id, name, brand, category, objectives, price, old_price, image_url, flavors, weights, description, nutrition_facts, in_stock, is_top_sale, is_promo, rating, reviews_count, created_at, updated_at)
SELECT id, name, brand, category, objectives, price, old_price, image_url, flavors, weights, description, nutrition_facts, in_stock, is_top_sale, is_promo, rating, reviews_count, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM products')
AS t(id UUID, name TEXT, brand TEXT, category TEXT, objectives TEXT[], price INTEGER, old_price INTEGER, image_url TEXT, flavors TEXT[], weights TEXT[], description TEXT, nutrition_facts JSONB, in_stock BOOLEAN, is_top_sale BOOLEAN, is_promo BOOLEAN, rating NUMERIC, reviews_count INTEGER, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des packs
INSERT INTO packs (id, name, description, price, old_price, image_url, active, created_at, updated_at)
SELECT id, name, description, price, old_price, image_url, active, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM packs')
AS t(id UUID, name TEXT, description TEXT, price INTEGER, old_price INTEGER, image_url TEXT, active BOOLEAN, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des commandes
INSERT INTO orders (id, customer_id, total_amount, status, shipping_address_id, payment_method, payment_status, created_at, updated_at)
SELECT id, customer_id, total_amount, status, shipping_address_id, payment_method, payment_status, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM orders')
AS t(id UUID, customer_id UUID, total_amount INTEGER, status TEXT, shipping_address_id UUID, payment_method TEXT, payment_status TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des articles de commande
INSERT INTO order_items (id, order_id, product_id, quantity, price, created_at, updated_at)
SELECT id, order_id, product_id, quantity, price, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM order_items')
AS t(id UUID, order_id UUID, product_id UUID, quantity INTEGER, price INTEGER, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des clients
INSERT INTO customers (id, email, first_name, last_name, phone, created_at, updated_at)
SELECT id, email, first_name, last_name, phone, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM customers')
AS t(id UUID, email TEXT, first_name TEXT, last_name TEXT, phone TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des adresses de livraison
INSERT INTO shipping_addresses (id, customer_id, address_line_1, address_line_2, city, state, postal_code, country, created_at, updated_at)
SELECT id, customer_id, address_line_1, address_line_2, city, state, postal_code, country, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM shipping_addresses')
AS t(id UUID, customer_id UUID, address_line_1 TEXT, address_line_2 TEXT, city TEXT, state TEXT, postal_code TEXT, country TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des avis
INSERT INTO reviews (id, product_id, customer_id, rating, comment, created_at, updated_at)
SELECT id, product_id, customer_id, rating, comment, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM reviews')
AS t(id UUID, product_id UUID, customer_id UUID, rating INTEGER, comment TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des catégories
INSERT INTO categories (id, name, description, image_url, created_at, updated_at)
SELECT id, name, description, image_url, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM categories')
AS t(id UUID, name TEXT, description TEXT, image_url TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des articles du panier
INSERT INTO cart_items (id, customer_id, product_id, quantity, created_at, updated_at)
SELECT id, customer_id, product_id, quantity, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM cart_items')
AS t(id UUID, customer_id UUID, product_id UUID, quantity INTEGER, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Migration des profils utilisateurs
INSERT INTO user_profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at)
SELECT id, user_id, first_name, last_name, avatar_url, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres password=YOUR_OLD_DB_PASSWORD dbname=postgres',
           'SELECT * FROM user_profiles')
AS t(id UUID, user_id UUID, first_name TEXT, last_name TEXT, avatar_url TEXT, created_at TIMESTAMP, updated_at TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- Vérification des données migrées
SELECT 'products' as table_name, COUNT(*) as count FROM products
UNION ALL
SELECT 'packs', COUNT(*) FROM packs
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'shipping_addresses', COUNT(*) FROM shipping_addresses
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'cart_items', COUNT(*) FROM cart_items
UNION ALL
SELECT 'user_profiles', COUNT(*) FROM user_profiles;