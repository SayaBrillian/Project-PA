<template>
  <q-page class="check-page">
    <div class="check-container">
      <div class="page-header">
        <h1>
          Check Transaction
        </h1>
        <p>
          Cari riwayat transaksi menggunakan
          email atau nomor WhatsApp.
        </p>
      </div>
      <div class="search-bar">
        <q-input v-model="keyword" filled sakura class="search-input" label="Email atau WhatsApp"
          placeholder="example@gmail.com" @keyup.enter="searchTransactions" />
        <q-btn unelevated color="accent" icon="search" label="Check" :loading="loading" @click="searchTransactions" />
      </div>
      <div v-if="transactions.length" class="debug-result">

        Ditemukan
        {{ transactions.length }}
        transaksi

      </div>
      <TransactionTable v-if="transactions.length" :transactions="transactions" @details="openDetails" />
      <TransactionDetailsDialog v-model="showDetails" :transaction-id="selectedTransactionId" />
    </div>
  </q-page>
</template>

<script setup>
import { ref } from 'vue'
import api from 'src/axios'

import TransactionDetailsDialog from 'src/components/dashboard/transactions/TransactionDetailsDialog.vue'
import TransactionTable from 'src/components/dashboard/transactions/TransactionTable.vue'

const keyword = ref('')
const loading = ref(false)
const transactions = ref([])

const searchTransactions = async () => {
  if (!keyword.value.trim()) {
    return
  }
  try {
    loading.value = true
    const response =
      await api.get(
        `/api/transactions/customer/${keyword.value}`
      )
    transactions.value =
      response.data.transactions
    console.log(
      'Transactions:',
      transactions.value
    )
  } catch (error) {
    console.error(
      'Search Transaction Error:',
      error
    )
    transactions.value = []
  } finally {
    loading.value = false
  }
}

const selectedTransaction =
  ref(null)
const selectedTransactionId = ref(null)
const showDetails =
  ref(false)

const openDetails =
  (transaction) => {

    selectedTransaction.value =
      transaction

    showDetails.value =
      true

    selectedTransactionId.value =
      transaction.id

    showDetails.value = true

  }
</script>

<style lang="scss" scoped>
.check-page {
  padding: 56px 24px;
}

.check-container {
  max-width: 1200px;

  margin: 0 auto;
}

/*
|--------------------------------------------------------------------------
| Header
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
| Search
|--------------------------------------------------------------------------
*/

.search-bar {
  display: flex;

  justify-content: center;

  align-items: center;

  gap: 16px;

  margin-bottom: 20px;

  padding: 20px;

  background: rgba(255,
      255,
      255,
      .06);

  backdrop-filter: blur(12px);

  border: 1px solid rgba($sakura,
      .15);

  border-radius: 10px;
}

.search-input {
  flex: 1;
}

:deep(.search-input .q-field__control) {
  background: white !important;

  border-radius: 14px;
}

:deep(.search-input .q-field__native) {
  color: $dark;
}

:deep(.search-input .q-field__label) {
  color: rgba(0,
      0,
      0,
      .6);
}

/*
|--------------------------------------------------------------------------
| Transaction Table
|--------------------------------------------------------------------------
*/
.debug-result{
text-align: center;
 color: rgba(255, 255, 255, 0.65);

  line-height: 1.6;
}
.transaction-table {
  margin-top: 24px;

  background: white;

  border-radius: 20px;

  overflow: hidden;

  box-shadow:
    0 10px 35px rgba(0,
      0,
      0,
      .12);
}

:deep(.q-table thead tr) {
  background: rgba($sakura,
      .08);
}

:deep(.q-table th) {
  font-weight: 700;

  color: $dark;
}

:deep(.q-table tbody tr:hover) {
  background: rgba($sakura,
      .05);
}
</style>
