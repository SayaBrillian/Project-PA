<template>
  <section class="game-section">

    <!-- HEADER -->
    <div class="section-header">

      <span class="section-badge">
        Pilih Game
      </span>

      <h2>
        {{ currentGame?.name || 'Pilih Game Favoritmu' }}
      </h2>

      <p>
        Pilih game yang ingin kamu top up untuk melihat informasi dan produk yang tersedia.
      </p>

    </div>

    <!-- SELECT -->
    <q-select v-model="selectedGame" :options="games" option-label="name" option-value="id" emit-value map-options
      outlined class="game-select">
      <template #prepend>
        <q-icon name="sports_esports" />
      </template>
    </q-select>

    <!-- GAME INFO -->
    <div v-if="currentGame" class="game-card">

      <div class="game-banner">

        <img :src="gameImages[currentGame.slug]" :alt="currentGame.name" class="game-image">

      </div>

      <div class="game-content">

        <h3 class="game-title">
          {{ currentGame.name }}
        </h3>

        <div class="game-publisher">
          {{ currentGame.publisher }}
        </div>

        <p class="game-description">
          {{ currentGame.description }}
        </p>

        <div class="game-meta">

          <div class="meta-card">

            <div class="meta-label">
              Versi Terbaru
            </div>

            <div class="meta-value">
              {{ currentGame.latest_patch }}
            </div>

          </div>

          <div class="meta-card">

            <div class="meta-label">
              Update Terakhir
            </div>

            <div class="meta-value">
              {{ currentGame.latest_update }}
            </div>

          </div>

        </div>

        <div class="game-actions">

          <q-btn outline no-caps icon="description" label="Patch Notes" :href="currentGame.patchnote_url"
            target="_blank" />

          <q-btn unelevated no-caps color="primary" icon="public" label="Website Resmi" :href="currentGame.official_url"
            target="_blank" />

        </div>

      </div>

    </div>

  </section>
</template>

<script setup>
import { computed } from 'vue'

/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props = defineProps({

  games: {
    type: Array,
    default: () => [],
  },

  selectedGame: {
    type: Number,
    default: null,
  },

  currentGame: {
    type: Object,
    default: null,
  },

  gameImages: {
    type: Object,
    required: true,
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'update:selectedGame',
])

/*
|--------------------------------------------------------------------------
| V-MODEL
|--------------------------------------------------------------------------
*/

const selectedGame = computed({

  get: () => props.selectedGame,

  set: value =>

    emit(
      'update:selectedGame',
      value,
    ),

})
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.game-section {
  display: flex;
  flex-direction: column;

  gap: 24px;
}

/*
|--------------------------------------------------------------------------
| STEP
|--------------------------------------------------------------------------
*/

.step-header {
  display: flex;
  flex-direction: column;

  gap: 10px;
}

.step-badge {
  display: inline-flex;
  align-items: center;

  width: fit-content;

  padding: 8px 16px;

  border-radius: 999px;

  background: var(--app-hover);

  border: 1px solid var(--app-border);

  color: var(--app-primary);

  font-size: .8rem;
  font-weight: 600;
}

.step-title {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(1.8rem, 4vw, 2.3rem);
  font-weight: 700;
}

.step-subtitle {
  margin-top: 8px;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| SELECT
|--------------------------------------------------------------------------
*/

.game-select {
  max-width: 420px;
}

:deep(.game-select .q-field__control) {
  border-radius: 16px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.game-card {
  display: grid;

  grid-template-columns: 300px 1fr;

  gap: 32px;

  padding: 28px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  transition:
    background-color .2s ease,
    border-color .2s ease,
    transform .2s ease;
}

.game-card:hover {
  transform: translateY(-2px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| IMAGE
|--------------------------------------------------------------------------
*/

.game-banner {
  overflow: hidden;

  border-radius: 20px;
}

.game-image {
  width: 100%;
  height: 100%;

  display: block;

  object-fit: cover;

  transition: transform .3s ease;
}

.game-card:hover .game-image {
  transform: scale(1.03);
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.game-content {
  display: flex;
  flex-direction: column;
}

.game-title {
  color: var(--app-text);

  font-size: 2rem;
  font-weight: 700;
}

.game-publisher {
  margin-top: 8px;

  color: var(--app-primary);

  font-weight: 600;
}

.game-description {
  margin-top: 20px;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| META
|--------------------------------------------------------------------------
*/

.game-meta {
  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 16px;

  margin-top: 28px;
}

.meta-card {
  padding: 18px;

  background: var(--app-bg);

  border: 1px solid var(--app-border);
  border-radius: 16px;
}

.meta-label {
  color: var(--app-text-secondary);

  font-size: .8rem;
}

.meta-value {
  margin-top: 6px;

  color: var(--app-text);

  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| ACTION
|--------------------------------------------------------------------------
*/

.game-actions {
  display: flex;
  flex-wrap: wrap;

  gap: 12px;

  margin-top: 28px;
}

.game-actions :deep(.q-btn) {
  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .game-card {
    grid-template-columns: 220px 1fr;
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .game-section {
    gap: 20px;

    padding-inline: 16px;
  }

  .step-title {
    font-size: 1.6rem;
  }

  .step-subtitle {
    font-size: .9rem;
  }

  .game-select {
    max-width: 100%;
  }

  .game-card {
    grid-template-columns: 1fr;

    gap: 20px;

    padding: 20px;
  }

  .game-banner {
    max-width: 260px;

    margin: 0 auto;
  }

  .game-title {
    text-align: center;

    font-size: 1.6rem;
  }

  .game-publisher {
    text-align: center;
  }

  .game-description {
    text-align: center;

    font-size: .92rem;
  }

  .game-meta {
    grid-template-columns: 1fr;

    gap: 12px;
  }

  .game-actions {
    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 12px;
  }

  .game-actions :deep(.q-btn) {
    width: 100%;
  }

}
</style>
