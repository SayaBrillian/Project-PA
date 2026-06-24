<template>

  <q-page class="transactions-page">

    <div class="page-header">

      <h1>
        Transactions
      </h1>

      <p>
        Kelola dan pantau seluruh transaksi.
      </p>

    </div>

    <!-- FILTER -->

    <div class="toolbar-row">

      <q-select
        v-model="selectedGame"
        :options="gameOptions"
        label="Game"
        outlined
        dense
        emit-value
        map-options
        class="game-filter"
      />

      <q-select
        v-model="selectedStatus"
        :options="statusOptions"
        label="Status"
        outlined
        dense
        emit-value
        map-options
        class="status-filter"
      />

      <q-input
        v-model="search"
        outlined
        dense
        clearable
        placeholder="Cari transaksi..."
        class="search-input"
      >

        <template #prepend>

          <q-icon
            name="search"
          />

        </template>

      </q-input>

    </div>

    <!-- TABLE -->

    <TransactionTable
      :transactions="
        filteredTransactions
      "
      @details="
        openDetails
      "
    />

    <!-- DETAILS -->

    <TransactionDetailsDialog
      v-model="showDetails"
      :transaction-id="
        selectedTransaction?.id
      "
    />

  </q-page>

</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
} from 'vue'

import api from 'src/axios'

import TransactionTable from
'src/components/dashboard/transactions/TransactionTable.vue'

import TransactionDetailsDialog from
'src/components/dashboard/transactions/TransactionDetailsDialog.vue'

const transactions = ref([])

const selectedTransaction =
  ref(null)

const showDetails =
  ref(false)

const selectedGame =
  ref(null)

const selectedStatus =
  ref(null)

const search = ref('')

const gameOptions =
  ref([])

const statusOptions = [
  {
    label: 'Semua Status',
    value: null,
  },
  {
    label: 'Settlement',
    value: 'settlement',
  },
  {
    label: 'Pending',
    value: 'pending',
  },
  {
    label: 'Failed',
    value: 'failed',
  },
  {
    label: 'Cancel',
    value: 'cancel',
  },
]

const loadTransactions =
  async () => {

    try {

      const response =
        await api.get(
          '/api/transactions'
        )

      transactions.value =
        response.data.transactions

      const uniqueGames =
        [
          ...new Set(
            response.data.transactions.map(
              (item) =>
                item.game_name
            )
          )
        ]

      gameOptions.value = [
        {
          label:
            'Semua Game',
          value: null,
        },

        ...uniqueGames.map(
          (game) => ({
            label: game,
            value: game,
          })
        )
      ]

    } catch (error) {

      console.error(
        'Load Transactions Error:',
        error
      )

    }

  }

const filteredTransactions =
  computed(() => {

    let data =
      [...transactions.value]

    if (
      selectedGame.value
    ) {

      data = data.filter(
        (transaction) =>
          transaction.game_name ===
          selectedGame.value
      )

    }

    if (
      selectedStatus.value
    ) {

      data = data.filter(
        (transaction) =>
          transaction.transaction_status ===
          selectedStatus.value
      )

    }

    if (
      search.value
    ) {

      const keyword =
        search.value.toLowerCase()

      data = data.filter(
        (transaction) =>
          transaction.order_id
            ?.toLowerCase()
            .includes(keyword)
          ||
          transaction.product_name
            ?.toLowerCase()
            .includes(keyword)
          ||
          transaction.customer_email
            ?.toLowerCase()
            .includes(keyword)
      )

    }

    return data

  })

const openDetails =
  (transaction) => {

    selectedTransaction.value =
      transaction

    showDetails.value =
      true

  }

onMounted(() => {

  loadTransactions()

})

</script>

<style lang="scss" scoped>

.transactions-page {
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

  color: rgba(
    0,
    0,
    0,
    .55
  );
}

.toolbar-row {
  display: flex;

  gap: 16px;

  align-items: center;
}

.game-filter {
  width: 220px;
}

.status-filter {
  width: 220px;
}

.search-input {
  flex: 1;
}

@media (max-width: 768px) {

  .toolbar-row {
    flex-direction: column;
  }

  .game-filter,
  .status-filter,
  .search-input {
    width: 100%;
  }

}

</style>