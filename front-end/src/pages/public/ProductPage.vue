<template>
  <q-page class="product-page">

    <!-- HEADER -->
    <div class="page-header">

      <h1>
        Pilih Game Favoritmu
      </h1>

      <p>
        Temukan game yang ingin kamu top up dengan cepat dan aman.
      </p>

    </div>

    <!-- SEARCH -->
    <q-input v-model="search" outlined rounded clearable class="search-bar" placeholder="Cari game...">

      <template #prepend>

        <q-icon name="search" />

      </template>

    </q-input>

    <!-- GAME LIST -->
    <div v-if="filteredGames.length" class="game-grid">

      <router-link v-for="game in filteredGames" :key="game.id" :to="`/products/${game.slug}`" class="game-link">

        <q-card flat class="game-card">

          <div class="game-image-wrapper">

            <img :src="gameImages[game.slug] || gameImages.placeholder" :alt="game.name" class="game-image">

            <div v-if="!game.is_active" class="coming-soon">
              Coming Soon
            </div>

          </div>

          <q-card-section class="game-content">

            <div class="game-name">

              {{ game.name }}

            </div>

            <div class="game-action">

              Lihat Produk

              <q-icon name="arrow_forward" size="16px" />

            </div>

          </q-card-section>

        </q-card>

      </router-link>

    </div>

    <!-- EMPTY -->
    <div v-else class="empty-state">

      <q-icon name="search_off" class="empty-icon" />

      <div class="empty-title">

        Game tidak ditemukan

      </div>

      <div class="empty-subtitle">

        Coba gunakan kata kunci yang berbeda.

      </div>

    </div>

  </q-page>
</template>

<script setup>
import {
  computed,
  onMounted,
  ref,
} from 'vue'

import api from 'src/axios'
import gameImages from 'src/assets/images'

/*
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const search =
  ref('')

const games =
  ref([])

/*
|--------------------------------------------------------------------------
| LOAD
|--------------------------------------------------------------------------
*/

async function loadGames() {

  try {

    const response =
      await api.get(
        '/api/games',
      )

    games.value =
      response.data.games

  } catch (error) {

    console.error(
      'Load games error:',
      error,
    )

  }

}

onMounted(
  loadGames,
)

/*
|--------------------------------------------------------------------------
| FILTER
|--------------------------------------------------------------------------
*/

const filteredGames =
  computed(() => {

    const keyword =
      search.value
        .trim()
        .toLowerCase()

    if (!keyword) {
      return games.value
    }

    return games.value.filter(

      game =>

        game.name
          .toLowerCase()
          .includes(keyword),

    )

  })
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PAGE
|--------------------------------------------------------------------------
*/

.product-page {
  display: flex;
  flex-direction: column;

  gap: 36px;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {
  max-width: 640px;

  margin: 0 auto;

  text-align: center;
}


.page-header h1 {
  margin: 16px 0 12px;

  color: var(--app-text);

  font-size: clamp(2rem, 4vw, 2.5rem);
  font-weight: 700;
}

.page-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| SEARCH
|--------------------------------------------------------------------------
*/

.search-bar {
  max-width: 520px;

  width: 100%;

  margin: 0 auto;
}

:deep(.search-bar .q-field__control) {
  border-radius: 16px;
}

/*
|--------------------------------------------------------------------------
| GRID
|--------------------------------------------------------------------------
*/

.game-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));

  gap: 20px;
}

/*
|--------------------------------------------------------------------------
| LINK
|--------------------------------------------------------------------------
*/

.game-link {
  text-decoration: none;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.game-card {
  overflow: hidden;

  height: 100%;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease,
    box-shadow .2s ease;
}

.game-card:hover {
  transform: translateY(-5px);

  background: var(--app-hover);

  border-color: var(--app-primary);

  box-shadow: 0 12px 28px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| IMAGE
|--------------------------------------------------------------------------
*/

.game-image-wrapper {
  position: relative;

  aspect-ratio: 16 / 9;

  overflow: hidden;
}

.game-image {
  width: 100%;
  height: 100%;

  display: block;

  object-fit: cover;

  transition: transform .3s ease;
}

.game-card:hover .game-image {
  transform: scale(1.05);
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

.coming-soon {
  position: absolute;

  top: 12px;
  right: 12px;

  padding: 6px 12px;

  border-radius: 999px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);

  color: var(--app-primary);

  font-size: .75rem;
  font-weight: 600;

  backdrop-filter: blur(8px);
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.game-content {
  display: flex;
  flex-direction: column;

  gap: 10px;

  padding: 18px;
}

.game-name {
  color: var(--app-text);

  text-align: center;

  font-size: 1rem;
  font-weight: 700;
}

.game-action {
  display: flex;
  justify-content: center;
  align-items: center;

  gap: 6px;

  color: var(--app-primary);

  font-size: .9rem;
  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| EMPTY
|--------------------------------------------------------------------------
*/

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;

  padding: 80px 20px;

  text-align: center;
}

.empty-icon {
  font-size: 72px;

  color: var(--app-primary);
}

.empty-title {
  margin-top: 18px;

  color: var(--app-text);

  font-size: 1.2rem;
  font-weight: 700;
}

.empty-subtitle {
  margin-top: 8px;

  color: var(--app-text-secondary);

  line-height: 1.6;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .game-grid {
    grid-template-columns: repeat(3, 1fr);
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .product-page {
    gap: 28px;

    padding-inline: 16px;
  }

  .page-header h1 {
    font-size: 1.7rem;
  }

  .page-header p {
    font-size: .9rem;
  }

  .game-grid {
    grid-template-columns: repeat(2, 1fr);

    gap: 14px;
  }

  .game-card {
    border-radius: 18px;
  }

  .game-content {
    padding: 14px;
  }

  .game-name {
    font-size: .9rem;
  }

  .game-action {
    font-size: .82rem;
  }

  .coming-soon {
    top: 8px;
    right: 8px;

    padding: 4px 8px;

    font-size: .65rem;
  }

  .empty-state {
    padding: 60px 20px;
  }

  .empty-icon {
    font-size: 60px;
  }

}
</style>
