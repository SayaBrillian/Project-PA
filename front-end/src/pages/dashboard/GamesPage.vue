<template>

  <q-page class="games-page">

    <div class="page-content" :class="{
      blurred:
        showDetails ||
        showCreate ||
        showUpdate ||
        showDelete
    }">

      <!-- HEADER -->

      <div class="page-header">

        <div class="page-title">

          <h1>
            Games
          </h1>

          <p>
            Kelola daftar game yang tersedia di EI Gaming Store.
          </p>

        </div>

        <q-btn unelevated rounded color="accent" icon="add" label="Add Game" @click="openCreate" />

      </div>

      <!-- TABLE -->

      <GameTable :games="games" @details="openDetails" @update="openUpdate" @delete="openDelete" />

    </div>

    <!-- DETAILS -->

    <GameDetailsDialog v-model="showDetails" :game="selectedGame" @update="openUpdate" @delete="openDelete" />

    <!-- CREATE -->

    <GameCreateDialog v-model="showCreate" @created="loadGames" />

    <!-- UPDATE -->

    <GameUpdateDialog v-model="showUpdate" :game="selectedGame" @updated="loadGames" />

    <!-- DELETE -->

    <GameDeleteDialog v-model="showDelete" :game="selectedGame" @deleted="loadGames" />

  </q-page>

</template>

<script setup>
import {
  ref,
  onMounted,
} from 'vue'

import api from 'src/axios'

import GameTable from
  'src/components/dashboard/games/GameTable.vue'

import GameDetailsDialog from
  'src/components/dashboard/games/GameDetailsDialog.vue'

import GameCreateDialog from
  'src/components/dashboard/games/GameCreateDialog.vue'

import GameUpdateDialog from
  'src/components/dashboard/games/GameUpdateDialog.vue'

import GameDeleteDialog from
  'src/components/dashboard/games/GameDeleteDialog.vue'

const games = ref([])
const selectedGame =
  ref(null)

const showDetails =
  ref(false)

const showCreate =
  ref(false)

const showUpdate =
  ref(false)

const showDelete =
  ref(false)

/*
|--------------------------------------------------------------------------
| LOAD GAMES
|--------------------------------------------------------------------------
*/

const loadGames =
  async () => {

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

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

const openDetails =
  (game) => {

    selectedGame.value =
      game

    showDetails.value =
      true

  }

/*
|--------------------------------------------------------------------------
| CREATE
|--------------------------------------------------------------------------
*/

const openCreate =
  () => {

    showCreate.value =
      true

  }

/*
|--------------------------------------------------------------------------
| UPDATE
|--------------------------------------------------------------------------
*/

const openUpdate =
  (game) => {

    showDetails.value =
      false

    selectedGame.value =
      game

    showUpdate.value =
      true

  }

/*
|--------------------------------------------------------------------------
| DELETE
|--------------------------------------------------------------------------
*/

const openDelete =
  (game) => {

    showDetails.value =
      false

    selectedGame.value =
      game

    showDelete.value =
      true

  }

onMounted(() => {

  loadGames()

})

</script>

<style scoped lang="scss">
.games-page {
  padding: 16px;
}

.page-content {
  transition:
    filter .25s ease,
    opacity .25s ease;
}

.page-content.blurred {
  filter: blur(2px);

  opacity: .7;

  pointer-events: none;

  user-select: none;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {
  display: flex;

  justify-content: space-between;
  align-items: center;

  gap: 20px;

  margin-bottom: 20px;
}

.page-title h1 {
  margin: 0;

  color: var(--app-text);

  font-size: 1.9rem;
  font-weight: 700;
}

.page-title p {
  margin-top: 6px;

  color: var(--app-text-secondary);

  font-size: .95rem;
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (min-width: 1024px) {

  .games-page {
    padding: 24px;
  }

}

@media (max-width: 768px) {

  .games-page {
    padding: 12px;
  }

  .page-header {
    flex-direction: column;

    align-items: stretch;

    margin-bottom: 16px;
  }

  .page-title h1 {
    font-size: 1.5rem;
  }

  .page-title p {
    font-size: .85rem;
  }

  .page-header .q-btn {
    width: 100%;
  }

}
</style>
