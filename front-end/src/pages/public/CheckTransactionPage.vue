<template>

  <q-page class="check-page">

    <div class="check-container">

      <!-- HEADER -->

      <div class="page-header">

        <h1>
          Cek Transaksi
        </h1>

        <p>
          Cari riwayat transaksi menggunakan email atau nomor WhatsApp.
        </p>

      </div>

      <!-- SEARCH -->

      <div class="search-bar">

        <q-input v-model="keyword" filled sakura class="search-input" label="Email atau WhatsApp"
          placeholder="example@gmail.com" @keyup.enter="searchTransactions" />

        <q-btn unelevated color="accent" icon="search" label="Cari" :loading="loading" @click="searchTransactions" />

      </div>

      <!-- RESULT -->

      <div v-if="transactions.length" class="result-info">

        Ditemukan
        {{ transactions.length }}
        transaksi

      </div>

      <!-- TABLE -->

      <TransactionTable v-if="transactions.length" :transactions="transactions" @details="openDetails" />

      <!-- DETAILS DIALOG -->

      <TransactionDetailsDialog v-model="showDetails" :transaction-id="selectedTransactionId" />

    </div>

  </q-page>

</template>

<script setup>
import { ref } from 'vue'
import api from 'src/axios'

import TransactionTable from 'src/components/dashboard/transactions/TransactionTable.vue'
import TransactionDetailsDialog from 'src/components/dashboard/transactions/TransactionDetailsDialog.vue'

/*
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const keyword = ref('')

const loading = ref(false)

const transactions = ref([])

const showDetails = ref(false)

const selectedTransactionId = ref(null)

/*
|--------------------------------------------------------------------------
| SEARCH
|--------------------------------------------------------------------------
*/

async function searchTransactions() {

  if (!keyword.value.trim()) {

    return

  }

  try {

    loading.value = true

    const response = await api.get(
      `/api/transactions/customer/${keyword.value}`,
    )

    transactions.value =
      response.data.transactions

    console.log(
      'Transactions:',
      transactions.value,
    )

  } catch (error) {

    console.error(
      'Search Transaction Error:',
      error,
    )

    transactions.value = []

  } finally {

    loading.value = false

  }

}

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

function openDetails(transaction) {

  selectedTransactionId.value =
    transaction.id

  showDetails.value = true

}
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PAGE
|--------------------------------------------------------------------------
*/

.check-page {
  padding: 48px 20px;
}

.check-container {
  max-width: 1100px;

  margin: 0 auto;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {
  display: flex;
  flex-direction: column;

  gap: 12px;

  margin-bottom: 32px;

  text-align: center;
}

.page-header h1 {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(2.2rem, 5vw, 3rem);
  font-weight: 700;
}

.page-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| SEARCH
|--------------------------------------------------------------------------
*/

.search-bar {
  display: flex;
  align-items: center;

  gap: 16px;

  margin-bottom: 24px;

  padding: 20px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;
}

.search-input {
  flex: 1;
}

.search-input :deep(.q-field__control) {
  border-radius: 16px;
}

/*
|--------------------------------------------------------------------------
| RESULT
|--------------------------------------------------------------------------
*/

.result-info {
  margin-bottom: 24px;

  text-align: center;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .check-page {
    padding: 32px 16px;
  }

  .page-header h1 {
    font-size: 2rem;
  }

  .page-header p {
    font-size: .9rem;
  }

  .search-bar {
    flex-direction: column;

    align-items: stretch;
  }

  .search-input {
    width: 100%;
  }

  .search-bar :deep(.q-btn) {
    width: 100%;
  }

}
</style>
