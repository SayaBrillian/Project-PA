<template>

  <q-page class="dashboard-page">

    <!-- HEADER -->

    <div class="page-header">

      <h1>
        Welcome Back 👋
      </h1>

      <p>
        Ringkasan aktivitas akun EI Gaming Store Anda.
      </p>

    </div>

    <!-- STATS -->

    <div class="stats-grid">

      <div class="stats-card">

        <q-icon name="receipt_long" class="stats-icon" />

        <div class="stats-label">
          My Transactions
        </div>

        <div class="stats-value">
          {{ totalTransactions }}
        </div>

      </div>

      <div class="stats-card">

        <q-icon name="task_alt" class="stats-icon" />

        <div class="stats-label">
          Completed Orders
        </div>

        <div class="stats-value">
          {{ completedOrders }}
        </div>

      </div>

      <div class="stats-card">

        <q-icon name="hourglass_top" class="stats-icon" />

        <div class="stats-label">
          Processing Orders
        </div>

        <div class="stats-value">
          {{ processingOrders }}
        </div>

      </div>

      <div class="stats-card">

        <q-icon name="payments" class="stats-icon" />

        <div class="stats-label">
          Total Spending
        </div>

        <div class="stats-value">
          Rp {{ totalSpending.toLocaleString('id-ID') }}
        </div>

      </div>

    </div>

    <!-- RECENT TRANSACTIONS -->

    <div class="recent-card">

      <div class="recent-header">

        <h2>
          Recent Transactions
        </h2>

      </div>

      <template v-if="recentTransactions.length">

        <div v-for="transaction in recentTransactions" :key="transaction.id" class="transaction-row">

          <div class="transaction-left">

            <div class="order-id">
              {{ transaction.order_id }}
            </div>

            <div class="product-name">
              {{ transaction.product_name }}
            </div>

          </div>

          <div class="transaction-right">

            <q-badge :color="getStatusColor(transaction.order_status)" class="status-badge">
              {{ transaction.order_status }}
            </q-badge>

            <div class="transaction-price">
              Rp
              {{
                Number(
                  transaction.total_price
                ).toLocaleString('id-ID')
              }}
            </div>

          </div>

        </div>

      </template>

      <div v-else class="empty-state">

        <q-icon name="receipt_long" size="40px" />

        <p>
          Belum ada transaksi.
        </p>

      </div>

    </div>

  </q-page>

</template>

<script setup>
import {
  ref,
  onMounted,
} from 'vue'

import api from 'src/axios'

/*
|--------------------------------------------------------------------------
| DASHBOARD DATA
|--------------------------------------------------------------------------
*/

const totalTransactions = ref(0)

const completedOrders = ref(0)

const processingOrders = ref(0)

const totalSpending = ref(0)

const recentTransactions = ref([])

/*
|--------------------------------------------------------------------------
| STATUS COLOR
|--------------------------------------------------------------------------
*/

const getStatusColor = (status) => {

  switch ((status || '').toLowerCase()) {

    case 'done':
      return 'positive'

    case 'waiting':
      return 'warning'

    case 'processing':
      return 'info'

    case 'cancel':
      return 'negative'

    default:
      return 'grey'

  }

}

/*
|--------------------------------------------------------------------------
| LOAD DASHBOARD
|--------------------------------------------------------------------------
*/

const loadDashboard = async () => {

  try {

    const auth = JSON.parse(
      localStorage.getItem('auth') || '{}'
    )

    const email =
      auth?.data?.email

    if (!email) {

      return

    }

    const response =
      await api.get(
        `/api/transactions/customer/${email}`
      )

    const transactions =
      response.data.transactions || []

    totalTransactions.value =
      transactions.length

    completedOrders.value =
      transactions.filter(
        transaction =>
          transaction.order_status === 'done'
      ).length

    processingOrders.value =
      transactions.filter(
        transaction =>
          [
            'waiting',
            'processing',
            'sending',
          ].includes(
            transaction.order_status
          )
      ).length

    totalSpending.value =
      transactions.reduce(

        (total, transaction) =>
          total +
          Number(transaction.total_price || 0),

        0,

      )

    recentTransactions.value =
      transactions.slice(0, 5)

  } catch (error) {

    console.error(
      'Dashboard Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadDashboard()

})
</script>

<style scoped lang="scss">
.dashboard-page {
  padding: 16px;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  margin: 0;

  color: var(--app-text);

  font-size: 1.9rem;
  font-weight: 700;
}

.page-header p {
  margin-top: 6px;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| STATS
|--------------------------------------------------------------------------
*/

.stats-grid {
  display: grid;

  grid-template-columns: repeat(4, 1fr);

  gap: 20px;
}

.stats-card {
  padding: 20px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);

  border-radius: 18px;

  transition: .2s ease;
}

.stats-card:hover {
  transform: translateY(-2px);
}

.stats-icon {
  margin-bottom: 14px;

  color: $accent;

  font-size: 34px;
}

.stats-label {
  color: var(--app-text-secondary);

  font-size: .9rem;
}

.stats-value {
  margin-top: 10px;

  color: $accent;

  font-size: 2rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| RECENT
|--------------------------------------------------------------------------
*/

.recent-card {
  margin-top: 24px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);

  border-radius: 18px;

  overflow: hidden;
}

.recent-header {
  padding: 20px 24px;

  border-bottom: 1px solid var(--app-border);
}

.recent-header h2 {
  margin: 0;

  font-size: 1.15rem;
  font-weight: 700;
}

.transaction-row {
  display: flex;

  justify-content: space-between;

  align-items: center;

  gap: 16px;

  padding: 18px 24px;

  border-bottom: 1px solid var(--app-border);
}

.transaction-row:last-child {
  border-bottom: none;
}

.transaction-left {
  flex: 1;
}

.order-id {
  color: var(--app-text);

  font-weight: 600;
}

.product-name {
  margin-top: 4px;

  color: var(--app-text-secondary);

  font-size: .85rem;
}

.transaction-right {
  display: flex;
  flex-direction: column;

  align-items: flex-end;

  gap: 8px;
}

.status-badge {
  text-transform: capitalize;
}

.transaction-price {
  color: var(--app-text);

  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| EMPTY
|--------------------------------------------------------------------------
*/

.empty-state {
  display: flex;
  flex-direction: column;

  align-items: center;

  gap: 12px;

  padding: 48px 24px;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 1023px) {

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

}

@media (max-width: 600px) {

  .dashboard-page {
    padding: 12px;
  }

  .page-header {
    margin-bottom: 16px;
  }

  .page-header h1 {
    font-size: 1.5rem;
  }

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }

  .stats-card {
    padding: 14px;
    border-radius: 14px;
  }

  .stats-icon {
    margin-bottom: 8px;
    font-size: 24px;
  }

  .stats-label {
    font-size: .75rem;
  }

  .stats-value {
    margin-top: 6px;
    font-size: 1.35rem;
  }

  .recent-card {
    margin-top: 16px;
  }

  .recent-header {
    padding: 16px;
  }

  .transaction-row {
    padding: 14px 16px;
  }

  .order-id {
    font-size: .9rem;
  }

  .product-name {
    font-size: .75rem;
  }

  .transaction-price {
    font-size: .9rem;
  }

}
</style>
