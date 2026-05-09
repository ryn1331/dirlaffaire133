# 🚀 MIGRATION SUPABASE - GUIDE RAPIDE

## ⚡ Méthode la plus simple : Migration SQL Manuelle

### Étape 1 : Obtenir le mot de passe de l'ancien projet
1. Va dans ton **ancien projet Supabase**
2. **Settings** → **Database** → **Connection Pooling**
3. Copie le **mot de passe** (password)

### Étape 2 : Exécuter la migration
1. Va dans ton **nouveau projet Supabase**
2. Ouvre le **SQL Editor**
3. Copie-colle le contenu de `migrate-complete.sql`
4. **Remplace** `YOUR_OLD_DB_PASSWORD` par le vrai mot de passe
5. Clique sur **Run**

### Étape 3 : Vérifier
Le script affiche automatiquement le nombre d'enregistrements migrés dans chaque table.

## 📊 Tables migrées :
- ✅ **products** - Produits
- ✅ **packs** - Packs
- ✅ **orders** - Commandes
- ✅ **order_items** - Articles des commandes
- ✅ **customers** - Clients
- ✅ **shipping_addresses** - Adresses
- ✅ **reviews** - Avis
- ✅ **categories** - Catégories
- ✅ **cart_items** - Panier
- ✅ **user_profiles** - Profils

## 🎯 Configuration déjà faite :
- ✅ `.env` mis à jour
- ✅ `supabase/config.toml` mis à jour
- ✅ Application prête pour le nouveau projet

## 🆘 Si problème :
- Vérifie que l'ancien projet est accessible
- Vérifie le mot de passe
- Essaie table par table si nécessaire

**C'est tout !** Ta migration sera terminée en 2 minutes ! 🎉