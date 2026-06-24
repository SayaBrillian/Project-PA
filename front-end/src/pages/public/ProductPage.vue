<template>
  <q-page class="product-page">
    <div class="page-header">
      <span class="section-badge"> Semua Produk </span>
      <h1>Pilih Game Favoritmu</h1>
      <p>Cari game yang ingin kamu top up.</p>
    </div>
    <q-input
      v-model="search"
      outlined
      dark
      rounded
      clearable
      placeholder="Cari game..."
      class="search-bar"
    >
      <template #prepend> <q-icon name="search" /> </template>
    </q-input>
    <div v-if="filteredGames.length" class="game-grid">
      <GameCard v-for="game in filteredGames" :key="game.id" :game="game" />
    </div>
    <div v-else class="empty-state">
      <q-icon name="search_off" size="64px" />
      <div class="empty-title">Game tidak ditemukan</div>
      <div class="empty-subtitle">Coba gunakan kata kunci lain.</div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from 'src/axios'
import GameCard from 'src/components/game/GameCard.vue'

const search = ref('')

const games = ref([])

const loadGames = async () => {
  try {

    const response =
      await api.get('/api/games')

    games.value =
      response.data.games

  } catch (error) {

    console.error(
      'Load games error:',
      error
    )

  }
}

onMounted(() => {
  loadGames()
})

const filteredGames = computed(() => {

  const keyword =
    search.value.toLowerCase()

  return games.value.filter(
    game =>
      game.name
        .toLowerCase()
        .includes(keyword)
  )

})
</script>

<style lang="scss" scoped>
.product-page {
  max-width: 1280px;
  margin: 0 auto;
}

.section-badge {
  display: inline-block;
  padding: 6px 14px;
  color: $sakura;
  background: rgba($sakura, 0.08);
  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;
}

.page-header {
  text-align: center;
}

.page-header h1 {
  margin: 0;

  font-size: 2.25rem;
  font-weight: 700;

  color: rgba(255, 255, 255, 0.65);
}

.page-header p {
  margin-top: 12px;

  color: rgba(255, 255, 255, 0.65);

  line-height: 1.6;
}

.search-bar {
  max-width: 520px;
  margin: 0 auto 40px;
}

.game-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 24px;
}
</style>
