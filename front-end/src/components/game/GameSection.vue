<template>
  <section class="game-section">
    <div class="section-header">

      <div class="section-title">

        <h2>{{ title }}</h2>

        <p class="section-description">
          {{ description }}
        </p>
      </div>

      <GameFilters v-if="filters.length" v-model="selectedFilter" :items="filters" />

    </div>

    <div class="section-divider" />

    <div class="games-grid">
      <GameCard v-for="game in games" :key="game.id" :game="game" />
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

import GameCard from './GameCard.vue'
import GameFilters from './GameFilters.vue'

defineProps({
  title: {
    type: String,
    required: true
  },

  description: {
    type: String,
    default: ''
  },

  games: {
    type: Array,
    required: true
  },

  filters: {
    type: Array,
    default: () => []
  }
})

const selectedFilter = ref('All Time')
</script>

<style lang="scss" scoped>
.game-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 24px;
}

.section-title {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.section-title h2 {
  margin: 0;

  font-size: clamp(1.75rem, 3vw, 2.25rem);
  font-weight: 700;
  color: $sakura;
}

.section-description {
  margin: 0;

  color: rgba(255, 255, 255, 0.65);
  font-size: 0.95rem;
}

.section-divider {
  width: 100%;
  height: 1px;

  background: linear-gradient(90deg,
      rgba($sakura, 0.25),
      rgba(255, 255, 255, 0.06));
}

.games-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

@media (max-width: 1024px) {
  .games-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .games-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .section-header {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
