import { createClient } from '@supabase/supabase-js';

// Configuration ancienne (source)
const OLD_SUPABASE_URL = 'https://ekpxjyofprjaewoxwoag.supabase.co';
const OLD_SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVrcHhqeW9mcHJqYWV3b3h3b2FnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU0NjU5NjIsImV4cCI6MjA5MTA0MTk2Mn0.CAn-8e89gteJ04BKeFRijBERYMf6diH-Qusdu7niwgE';

// Configuration nouvelle (destination)
const NEW_SUPABASE_URL = 'https://fkukfqtszwaxflzfwabg.supabase.co';
const NEW_SUPABASE_SERVICE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZrdWtmcXRzendheGZsemZ3YWJnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3ODE3MDU2MywiZXhwIjoyMDkzNzQ2NTYzfQ.qOAdGG6hHYmRqJ8MZhucShVVzqx5ZNxCnAVnrJf2kug';

const oldSupabase = createClient(OLD_SUPABASE_URL, OLD_SUPABASE_ANON_KEY);
const newSupabase = createClient(NEW_SUPABASE_URL, NEW_SUPABASE_SERVICE_KEY);

async function migrateTable(tableName: string, batchSize = 1000) {
  console.log(`🚀 Migration de la table: ${tableName}`);

  try {
    // Récupérer le nombre total d'enregistrements
    const { count, error: countError } = await oldSupabase
      .from(tableName)
      .select('*', { count: 'exact', head: true });

    if (countError) {
      console.error(`❌ Erreur lors du comptage pour ${tableName}:`, countError);
      return;
    }

    console.log(`📊 ${count} enregistrements à migrer dans ${tableName}`);

    let migrated = 0;

    // Migrer par lots
    for (let offset = 0; offset < count!; offset += batchSize) {
      const { data, error } = await oldSupabase
        .from(tableName)
        .select('*')
        .range(offset, offset + batchSize - 1);

      if (error) {
        console.error(`❌ Erreur lors de la récupération des données ${tableName}:`, error);
        continue;
      }

      if (data && data.length > 0) {
        const { error: insertError } = await newSupabase
          .from(tableName)
          .insert(data);

        if (insertError) {
          console.error(`❌ Erreur lors de l'insertion dans ${tableName}:`, insertError);
          continue;
        }

        migrated += data.length;
        console.log(`✅ ${migrated}/${count} migrés pour ${tableName}`);
      }
    }

    console.log(`🎉 Migration terminée pour ${tableName}: ${migrated} enregistrements`);
  } catch (error) {
    console.error(`💥 Erreur générale pour ${tableName}:`, error);
  }
}

async function migrateAllData() {
  console.log('🚀 Début de la migration complète des données');

  // Liste des tables à migrer (dans l'ordre des dépendances)
  const tables = [
    'products',
    'packs',
    'orders',
    'order_items',
    'customers',
    'shipping_addresses',
    'reviews',
    'categories',
    'cart_items',
    'user_profiles'
  ];

  for (const table of tables) {
    await migrateTable(table);
    // Petite pause entre les tables
    await new Promise(resolve => setTimeout(resolve, 1000));
  }

  console.log('🎉 Migration complète terminée !');
}

// Exécuter la migration
migrateAllData().catch(console.error);