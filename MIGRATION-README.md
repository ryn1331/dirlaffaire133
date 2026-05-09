# Migration Supabase - Guide Complet

## 🎯 Objectif
Migrer toutes les données de l'ancien projet Supabase vers le nouveau projet.

## 📋 Méthodes disponibles

### Méthode 1: Script Automatique (Recommandé)
```bash
npm run migrate
```

**Avantages:**
- ✅ Migration automatique complète
- ✅ Gestion des erreurs
- ✅ Migration par lots (évite les timeouts)
- ✅ Progress tracking

**Prérequis:**
- Ancien projet encore accessible
- Nouvelles clés API configurées dans `.env`

### Méthode 2: Migration Manuelle SQL
1. Ouvrir le **SQL Editor** dans ton nouveau projet Supabase
2. Exécuter le contenu de `migrate-manual.sql`
3. Remplacer `YOUR_OLD_PASSWORD` par le mot de passe de l'ancien projet

**Pour obtenir l'ancien mot de passe:**
- Aller dans l'ancien projet Supabase
- Settings → Database → Connection Pooling
- Copier le mot de passe

## 🔄 Tables migrées
- `products` - Produits
- `packs` - Packs de produits
- `orders` - Commandes
- `order_items` - Articles des commandes
- `customers` - Clients
- `shipping_addresses` - Adresses de livraison
- `reviews` - Avis clients
- `categories` - Catégories
- `cart_items` - Articles du panier
- `user_profiles` - Profils utilisateurs

## ⚠️ Points importants

1. **Sauvegarde:** Faire un backup de l'ancien projet avant migration
2. **Test:** Tester l'application après migration
3. **Storage:** Les fichiers (images) devront être migrés séparément si nécessaire
4. **Auth:** Les utilisateurs devront se réinscrire ou être migrés via Auth

## 🚀 Après migration

1. Tester que l'application fonctionne avec le nouveau projet
2. Vérifier que toutes les données sont présentes
3. Mettre à jour les webhooks si utilisés
4. Configurer les fonctions Edge si nécessaire

## 🆘 En cas de problème

Si la migration échoue:
1. Vérifier les clés API dans `.env`
2. Vérifier que l'ancien projet est accessible
3. Essayer la méthode manuelle SQL
4. Contacter le support Supabase si nécessaire