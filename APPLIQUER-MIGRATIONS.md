# 🚀 APPLICATION DES MIGRATIONS - GUIDE FINAL

## ⚡ Méthode la plus simple :

### Étape 1 : Ouvrir SQL Editor
1. Va dans ton **nouveau projet Supabase**
2. Clique sur **SQL Editor** dans le menu de gauche

### Étape 2 : Appliquer les migrations
1. Copie **TOUT** le contenu du fichier `apply-migrations.sql`
2. Colle-le dans le SQL Editor
3. Clique sur **Run** (ou **▶️**)

### Étape 3 : Vérifier
Tu devrais voir le message : **"Migration completed successfully!"**

## 📊 Ce qui sera créé :

✅ **11 Tables principales :**
- `products` - Produits avec politiques RLS
- `packs` - Packs de produits
- `categories` - Catégories
- `customers` - Clients
- `shipping_addresses` - Adresses de livraison
- `orders` - Commandes
- `order_items` - Articles des commandes
- `reviews` - Avis clients
- `cart_items` - Panier
- `user_profiles` - Profils utilisateurs

✅ **Sécurité complète :**
- Row Level Security (RLS) activé
- Politiques d'accès appropriées
- Triggers de mise à jour automatique

## 🚨 CORRECTION IMPORTANTE :
Si tu as une erreur **"cannot drop table products because other objects depend on it"**, utilise le fichier **`apply-migrations.sql`** corrigé qui supprime les tables dans le bon ordre avec CASCADE.

## 🎯 Après application :

Ton application sera **100% fonctionnelle** avec :
- ✅ Structure de base complète
- ✅ Sécurité configurée
- ✅ Relations entre tables
- ✅ Interface admin prête

## 🆘 Si problème :
- Vérifie que tu es dans le bon projet Supabase
- Essaie d'exécuter par blocs si ça échoue
- Les erreurs sont normales si des tables existent déjà

**C'est tout !** 🎉