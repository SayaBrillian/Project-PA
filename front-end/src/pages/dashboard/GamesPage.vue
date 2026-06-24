<template>
  <q-page class="games-page">

  <div
    class="page-content"
    :class="{
      blurred:
        showDetails ||
        showCreate ||
        showUpdate ||
        showDelete
    }"
  >
    <div class="page-header">

      <h1>
        Games
      </h1>

      <p>
        Kelola daftar game yang tersedia.
      </p>

    </div>

    <div class="games-grid">

      <GameCard
        v-for="game in games"
        :key="game.id"
        :game="game"
        @details="openDetails"
      />

      <AddGameCard
        @click="openCreate"
      />

    </div>

    <GameDetailsDialog
  v-model="showDetails"
  :game="selectedGame"
  @update="openUpdate"
  @delete="openDelete"
/>

    <GameCreateDialog
      v-model="showCreate"
      @created="loadGames"
    />
<GameUpdateDialog
  v-model="showUpdate"
  :game="selectedGame"
  @updated="loadGames"
/>

<GameDeleteDialog
  v-model="showDelete"
  :game="selectedGame"
  @deleted="loadGames"
/>
  </div>
  </q-page>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from 'src/axios'

import GameCard from 'src/components/dashboard/games/GameCard.vue'
import AddGameCard from 'src/components/dashboard/games/AddGameCard.vue'
import GameDetailsDialog from 'src/components/dashboard/games/GameDetailsDialog.vue'
import GameCreateDialog from 'src/components/dashboard/games/GameCreateDialog.vue'
import GameUpdateDialog from 'src/components/dashboard/games/GameUpdateDialog.vue'
import GameDeleteDialog from 'src/components/dashboard/games/GameDeleteDialog.vue'

const showUpdate = ref(false)
const showDelete = ref(false)
const games = ref([])
const selectedGame = ref(null)
const showDetails = ref(false)
const showCreate = ref(false)

const loadGames = async () => {

  try {

    const response =
      await api.get(
        '/api/games'
      )

    games.value =
      response.data.games

  } catch (error) {

    console.error(
      'Load Games Error:',
      error
    )

  }

}

const openDetails =
  (game) => {

    selectedGame.value =
      game

    showDetails.value =
      true

  }

const openCreate =
  () => {

    showCreate.value =
      true

  }

  const openUpdate = (game) => {

  showDetails.value = false

  selectedGame.value = game

  showUpdate.value = true

}

const openDelete = (game) => {

  showDetails.value = false

  selectedGame.value = game

  showDelete.value = true

}
onMounted(() => {
  loadGames()
})
</script>

<style lang="scss" scoped>

.games-page {
  display: flex;
  flex-direction: column;

  gap: 24px;
}
.blurred {
  filter: blur(4px);

  pointer-events: none;

  user-select: none;
}
.page-header h1 {
  margin: 0;

  color: $dark;

  font-size: 2rem;
  font-weight: 700;
}

.page-header p {
  margin-top: 8px;

  color:
    rgba(
      0,
      0,
      0,
      .55
    );
}

.games-grid {
  display: grid;

  grid-template-columns:
    repeat(
      auto-fill,
      minmax(
        280px,
        1fr
      )
    );

  gap: 20px;
}

@media (
  max-width: 768px
) {

  .games-grid {

    grid-template-columns:
      1fr;

  }

}

</style>