<template>

  <q-page class="products-page">

    <!-- HEADER -->

    <div class="page-header">

      <h1>
        Products
      </h1>

      <p>
        Kelola seluruh produk game.
      </p>

    </div>

    <!-- TOOLBAR -->

    <div class="toolbar-row">

      <q-select v-model="selectedGame" :options="games" label="Game" outlined dense emit-value map-options
        class="game-filter" />

      <q-input v-model="search" outlined dense clearable placeholder="Cari produk..." class="search-input">
        <template #prepend>

          <q-icon name="search" />

        </template>
      </q-input>

      <q-btn unelevated color="accent" icon="add" label="Add Product" @click="
        showCreate = true
        " />

    </div>

    <!-- TABLE -->

    <ProductTable :products="filteredProducts
      " @details="
        openDetails
      " @update="
        openUpdate
      " @delete="
        openDelete
      " />

    <!-- DETAILS -->

    <ProductDetailsDialog v-model="showDetails" :product="selectedProduct
      " @update="
        openUpdate
      " @delete="
        openDelete
      " />

    <!-- CREATE -->

    <ProductCreateDialog v-model="showCreate" @created="
      refreshProducts
    " />

    <!-- UPDATE -->

    <ProductUpdateDialog v-model="showUpdate" :product="selectedProduct
      " @updated="
        refreshProducts
      " />

    <!-- DELETE -->

    <ProductDeleteDialog v-model="showDelete" :product="selectedProduct
      " @deleted="
        refreshProducts
      " />

  </q-page>

</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
} from 'vue'

import api from 'src/axios'

import ProductTable from 'src/components/dashboard/products/ProductTable.vue'

import ProductDetailsDialog from 'src/components/dashboard/products/ProductDetailsDialog.vue'
import ProductCreateDialog from 'src/components/dashboard/products/ProductCreateDialog.vue'
import ProductUpdateDialog from 'src/components/dashboard/products/ProductUpdateDialog.vue'
import ProductDeleteDialog from 'src/components/dashboard/products/ProductDeleteDialog.vue'

const products = ref([])

const games = ref([])

const selectedGame = ref(null)

const search = ref('')

const selectedProduct =
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

const loadGames = async () => {

  try {

    const response =
      await api.get(
        '/api/games'
      )

    games.value = [
      {
        label: 'Semua Game',
        value: null,
      },

      ...response.data.games.map(
        (game) => ({
          label: game.name,
          value: game.id,
        })
      ),
    ]

  } catch (error) {

    console.error(
      'Load Games Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| LOAD PRODUCTS
|--------------------------------------------------------------------------
*/

const loadProducts =
  async () => {

    try {

      const response =
        await api.get(
          '/api/products'
        )

      products.value =
        response.data.products

    } catch (error) {

      console.error(
        'Load Products Error:',
        error
      )

    }

  }

/*
|--------------------------------------------------------------------------
| FILTERED PRODUCTS
|--------------------------------------------------------------------------
*/

const filteredProducts =
  computed(() => {

    let data =
      [...products.value]

    if (
      selectedGame.value
    ) {

      data = data.filter(
        (product) =>
          product.game_id ===
          selectedGame.value
      )

    }

    if (
      search.value
    ) {

      data = data.filter(
        (product) =>
          product.name
            .toLowerCase()
            .includes(
              search.value
                .toLowerCase()
            )
      )

    }

    return data

  })

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

const openDetails =
  (product) => {

    selectedProduct.value =
      product

    showDetails.value =
      true

  }

/*
|--------------------------------------------------------------------------
| UPDATE
|--------------------------------------------------------------------------
*/

const openUpdate =
  (product) => {

    showDetails.value =
      false

    selectedProduct.value =
      product

    showUpdate.value =
      true

  }

/*
|--------------------------------------------------------------------------
| DELETE
|--------------------------------------------------------------------------
*/

const openDelete =
  (product) => {

    showDetails.value =
      false

    selectedProduct.value =
      product

    showDelete.value =
      true

  }

/*
|--------------------------------------------------------------------------
| REFRESH
|--------------------------------------------------------------------------
*/

const refreshProducts =
  async () => {

    await loadProducts()

  }

/*
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadGames()

  loadProducts()

})

</script>

<style lang="scss" scoped>
.products-page {
  display: flex;
  flex-direction: column;

  gap: 24px;
}

.page-header h1 {
  margin: 0;

  color: $dark;

  font-size: 2rem;
  font-weight: 700;
}

.page-header p {
  margin-top: 8px;

  color: rgba(0,
      0,
      0,
      .55);
}

/*
|--------------------------------------------------------------------------
| TOOLBAR
|--------------------------------------------------------------------------
*/

.toolbar-row {
  display: flex;

  align-items: center;

  gap: 16px;
}

.game-filter {
  width: 240px;
}

.search-input {
  flex: 1;
}

/*
|--------------------------------------------------------------------------
| QUASAR OVERRIDE
|--------------------------------------------------------------------------
*/

:deep(.q-field--outlined .q-field__control) {
  border-radius: 14px;
}

:deep(.q-btn) {
  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .toolbar-row {
    flex-direction: column;

    align-items: stretch;
  }

  .game-filter {
    width: 100%;
  }

  .search-input {
    width: 100%;
  }

}
</style>
