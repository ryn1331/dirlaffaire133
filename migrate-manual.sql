-- Script SQL pour migrer manuellement les données
-- À exécuter dans le SQL Editor de Supabase (nouveau projet)

-- 1. D'abord, créer les tables avec les migrations (fait automatiquement par Supabase)
-- Les migrations sont dans le dossier supabase/migrations/

-- 2. Ensuite, migrer les données depuis l'ancien projet
-- Remplacer OLD_PROJECT_ID par l'ancien project ID

-- IMPORTANT: Exécuter une table à la fois pour éviter les timeouts

-- Migration des produits
INSERT INTO products (id, name, brand, category, objectives, price, old_price, image_url, flavors, weights, description, nutrition_facts, in_stock, is_top_sale, is_promo, rating, reviews_count, created_at, updated_at)
SELECT id, name, brand, category, objectives, price, old_price, image_url, flavors, weights, description, nutrition_facts, in_stock, is_top_sale, is_promo, rating, reviews_count, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres.password=YOUR_OLD_PASSWORD dbname=postgres',
           'SELECT * FROM products')
AS t(id UUID, name TEXT, brand TEXT, category TEXT, objectives TEXT[], price INTEGER, old_price INTEGER, image_url TEXT, flavors TEXT[], weights TEXT[], description TEXT, nutrition_facts JSONB, in_stock BOOLEAN, is_top_sale BOOLEAN, is_promo BOOLEAN, rating NUMERIC, reviews_count INTEGER, created_at TIMESTAMP, updated_at TIMESTAMP);

-- Migration des packs
INSERT INTO packs (id, name, description, price, old_price, image_url, active, created_at, updated_at)
SELECT id, name, description, price, old_price, image_url, active, created_at, updated_at
FROM dblink('host=aws-0-eu-central-1.pooler.supabase.com port=5432 user=postgres.password=YOUR_OLD_PASSWORD dbname=postgres',
           'SELECT * FROM packs')
AS t(id UUID, name TEXT, description TEXT, price INTEGER, old_price INTEGER, image_url TEXT, active BOOLEAN, created_at TIMESTAMP, updated_at TIMESTAMP);

-- Note: Remplacer YOUR_OLD_PASSWORD par le mot de passe de l'ancien projet
-- Pour obtenir le mot de passe, aller dans Settings > Database > Connection Pooling