<template>

  <q-page class="check-page">

    <div class="check-container">

      <!-- HEADER -->

      <div class="page-header">

        <h1>
          Check Transaction
        </h1>

        <p>
          Cari riwayat transaksi menggunakan
          email atau nomor WhatsApp.
        </p>

      </div>

      <!-- SEARCH -->

      <div class="search-bar">

        <q-input
          v-model="keyword"
          filled
          dark
          class="search-input"
          label="Email atau WhatsApp"
          placeholder="example@gmail.com"
          @keyup.enter="searchTransactions"
        />

        <q-btn
          unelevated
          color="accent"
          icon="search"
          label="Check"
          :loading="loading"
          @click="searchTransactions"
        />

      </div>

      <!-- RESULT TABLE -->

      <q-table
  v-if="transactions.length"
  flat
  bordered
  :rows="transactions"
  :columns="columns"
  row-key="id"
  class="transaction-table"
/>

      <!-- EMPTY STATE -->

      <div
        v-if="
          searched &&
          transactions.length === 0
        "
        class="empty-state"
      >

        Tidak ada transaksi ditemukan.

      </div>

    </div>

  </q-page>

</template>

<script setup>
import { ref } from 'vue'
import api from 'src/axios'

const keyword = ref('')

const loading = ref(false)

const searched = ref(false)

const transactions = ref([])

const columns = [
  {
    name: 'order_id',
    label: 'Order ID',
    field: 'order_id',
    align: 'left',
  },
  {
    name: 'game_name',
    label: 'Game',
    field: 'game_name',
    align: 'left',
  },
  {
    name: 'product_name',
    label: 'Product',
    field: 'product_name',
    align: 'left',
  },
  {
    name: 'transaction_status',
    label: 'Status',
    field: 'transaction_status',
    align: 'center',
  },
  {
    name: 'total_price',
    label: 'Total',
    field: 'total_price',
    align: 'right',
  },
]

const searchTransactions =
  async () => {

    if (!keyword.value) {
      return
    }

    try {

      loading.value = true

      const response =
  await api.get(
    `/api/transactions/customer/${keyword.value}`
  )

console.log(
  'FULL RESPONSE:',
  response.data
)

console.log(
  'TRANSACTIONS:',
  response.data.transactions
)

transactions.value =
  response.data.transactions

    } catch (error) {

      console.error(
        'Search Transaction Error:',
        error
      )

      transactions.value = []

      searched.value = true

    } finally {

      loading.value = false

    }

  }

</script>

<style lang="scss" scoped>
.check-page {
  padding: 64px 24px;
}

.check-container {
  max-width: 1100px;

  margin: 0 auto;

  display: flex;
  flex-direction: column;

  gap: 32px;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

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

/*
|--------------------------------------------------------------------------
| SEARCH
|--------------------------------------------------------------------------
*/

.search-bar {
  display: flex;

  justify-content: center;

  gap: 12px;
}

.search-input {
  width: 500px;

  max-width: 100%;
}

:deep(.search-input .q-field__control) {
  background: rgba(
    255,
    255,
    255,
    .05
  ) !important;

  border: 1px solid rgba(
    $sakura,
    .15
  );

  border-radius: 16px;
}

:deep(.search-input .q-field__native) {
  color: white;
}

:deep(.search-input .q-field__label) {
  color: rgba(
    255,
    255,
    255,
    .7
  );
}

/*
|--------------------------------------------------------------------------
| TABLE
|--------------------------------------------------------------------------
*/

.transaction-table {
  margin-top: 16px;

  background: rgba(
    255,
    255,
    255,
    .04
  );

  border-radius: 20px;

  overflow: hidden;
}

:deep(.q-table thead tr) {
  background: rgba(
    $sakura,
    .08
  );
}

:deep(.q-table th) {
  font-weight: 700;

  color: white;
}

:deep(.q-table td) {
  color: white;
}

:deep(.q-table tbody tr:hover) {
  background: rgba(
    $sakura,
    .04
  );
}

/*
|--------------------------------------------------------------------------
| EMPTY
|--------------------------------------------------------------------------
*/

.empty-state {
  margin-top: 32px;

  padding: 24px;

  text-align: center;

  color: rgba(
    255,
    255,
    255,
    .65
  );

  background: rgba(
    255,
    255,
    255,
    .03
  );

  border-radius: 16px;
}
</style>

