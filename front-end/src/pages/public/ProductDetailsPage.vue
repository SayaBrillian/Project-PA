<template>
  <q-page class="product-details-page">
    <!-- GAME SELECTOR -->
    <section class="game-selector-section">
      <div class="section-label">Pilih Game</div>

      <q-select
        v-model="selectedGame"
        :options="games"
        option-label="name"
        option-value="slug"
        dark
        outlined
        emit-value
        map-options
        class="game-select"
      >
        <template #prepend>
          <q-icon name="sports_esports" />
        </template>
      </q-select>
    </section>

    <!-- GAME INFO -->
    <section class="game-info-card">
      <div class="game-banner">
        <div class="game-banner-image">
          <img :src="gameImages[selectedGame]" :alt="currentGame.name" class="game-banner-image" />
        </div>

        <div class="game-banner-content">
          <h2>
            {{ currentGame.name }}
          </h2>

          <div class="publisher">
            {{ currentGame.publisher }}
          </div>

          <p class="game-description">
            {{ currentGame.description }}
          </p>

          <div class="game-meta">
            <div class="meta-item">
              <span class="meta-label"> Versi Terbaru </span>

              <span class="meta-value">
                {{ currentGame.version }}
              </span>
            </div>

            <div class="meta-item">
              <span class="meta-label"> Update Terakhir </span>

              <span class="meta-value">
                {{ currentGame.lastUpdate }}
              </span>
            </div>
          </div>

          <div class="game-links">
            <q-btn outline color="accent" icon="description" label="Patch Notes" />

            <q-btn unelevated color="accent" icon="public" label="Official Website" />
          </div>
        </div>
      </div>
    </section>
    <!-- PRODUCT SECTION -->
<section class="product-section">

  <div class="section-header">
    <h2>Pilih Produk</h2>

    <p>
      Pilih nominal atau paket yang ingin dibeli.
    </p>
  </div>

  <div class="product-grid">

    <div
      v-for="product in products"
      :key="product.id"
      class="product-card"
      :class="{
        selected: selectedProduct?.id === product.id
      }"
      @click="selectedProduct = product"
    >
      <div class="product-name">
        {{ product.name }}
      </div>

      <div class="product-price">
        Rp {{ product.price.toLocaleString('id-ID') }}
      </div>
    </div>

  </div>

</section>
  </q-page>
</template>

<script setup>
import { computed, ref } from 'vue'
import gameImages from 'src/assets/images'

const games = [
  {
    name: 'Genshin Impact',
    slug: 'genshin-impact',
  },
  {
    name: 'Honkai: Star Rail',
    slug: 'honkai-star-rail',
  },
  {
    name: 'Zenless Zone Zero',
    slug: 'zenless-zone-zero',
  },
]

const selectedGame = ref('genshin-impact')

const gameData = {
  'genshin-impact': {
    name: 'Genshin Impact',
    publisher: 'HoYoverse',
    version: '5.8',
    lastUpdate: '30 Mei 2026',
    description:
      'Top up Genesis Crystal dan Blessing of the Welkin Moon dengan proses cepat dan aman.',
  },

  'honkai-star-rail': {
    name: 'Honkai: Star Rail',
    publisher: 'HoYoverse',
    version: '3.6',
    lastUpdate: '10 Juni 2026',
    description: 'Top up Oneiric Shard dan Express Supply Pass dengan proses instan.',
  },

  'zenless-zone-zero': {
    name: 'Zenless Zone Zero',
    publisher: 'HoYoverse',
    version: '2.0',
    lastUpdate: '5 Juni 2026',
    description: 'Top up Monochrome dan Membership dengan aman.',
  },
}

const currentGame = computed(() => {
  return gameData[selectedGame.value]
})

const products = [
  {
    id: 1,
    name: '60 Genesis Crystal',
    price: 16000
  },
  {
    id: 2,
    name: '300 + 30 Genesis Crystal',
    price: 79000
  },
  {
    id: 3,
    name: '980 + 110 Genesis Crystal',
    price: 249000
  },
  {
    id: 4,
    name: 'Blessing of the Welkin Moon',
    price: 79000
  }
]

const selectedProduct = ref(null)
</script>

<style lang="scss" scoped>
.product-details-page {
  max-width: 1280px;
  margin: 0 auto;
}

.game-selector-section {
  margin-bottom: 24px;
}

.section-label {
  margin-bottom: 10px;

  font-size: 0.9rem;
  font-weight: 600;

  color: rgba(255, 255, 255, 0.7);
}

.game-select {
  max-width: 420px;
}

.game-info-card {
  padding: 32px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 24px;
}

.game-header {
  margin-bottom: 12px;
}

.game-header h1 {
  margin: 0;

  font-size: 2rem;
  font-weight: 700;
}

.game-banner {
  display: flex;
  gap: 32px;
}

.game-banner-image {
  width: 240px;
  flex-shrink: 0;
}

.game-banner-image img {
  width: 100%;
  display: block;

  border-radius: 20px;
  object-fit: cover;
}

.game-banner-content {
  flex: 1;
}

.game-banner-content h2 {
  margin-top: 0;
  margin-bottom: 8px;
  color: $sakura;
}

.publisher {
  margin-bottom: 20px;

  color: rgba(255, 255, 255, 0.65);
}

.game-meta {
  display: flex;
  gap: 32px;

  margin: 24px 0;
}

.meta-item {
  display: flex;
  flex-direction: column;
}

.meta-label {
  font-size: 0.8rem;
  color: rgba(255, 255, 255, 0.5);
}

.meta-value {
  margin-top: 4px;
  font-weight: 600;
}

.game-links {
  display: flex;
  gap: 12px;

  margin-top: 28px;
}

.product-section {
  margin-top: 48px;
}

.section-header {
  margin-bottom: 24px;
}

.product-grid {
  display: grid;

  grid-template-columns: repeat(
    auto-fill,
    minmax(220px, 1fr)
  );

  gap: 16px;
}

.product-card {
  padding: 18px;

  cursor: pointer;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 16px;

  transition: all 0.2s ease;
}

.product-card:hover {
  border-color: rgba($sakura, 0.3);
}

.product-card.selected {
  border-color: $sakura;

  background: rgba($sakura, 0.08);
}

.product-name {
  font-weight: 600;
}

.product-price {
  margin-top: 8px;

  color: $sakura;
  font-weight: 700;
}
@media (max-width: 768px) {
  .game-meta {
    flex-direction: column;
    gap: 12px;
  }

  .game-links {
    flex-direction: column;
  }
}
</style>
