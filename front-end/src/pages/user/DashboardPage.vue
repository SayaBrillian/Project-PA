<template>
  <q-page class="dashboard-page">
    <div class="page-header">
      <h1>Welcome Back</h1>

<p>Ringkasan aktivitas akun Anda.</p>
    </div>

    <!-- STATS -->
    <div class="stats-grid">
      <div class="stats-card">
        <div class="stats-label">My Transactions</div>

        <div class="stats-value">
          {{ totalTransactions }}
        </div>
      </div>

      <div class="stats-card">
        <div class="stats-label">Completed Orders</div>

        <div class="stats-value">
          {{ completedOrders }}
        </div>
      </div>

      <div class="stats-card">
        <div class="stats-label">Processing Orders</div>

        <div class="stats-value">
          {{ processingOrders }}
        </div>
      </div>

      <div class="stats-card">
        <div class="stats-label">Total Spending</div>

        <div class="stats-value">
          Rp {{ totalSpending.toLocaleString('id-ID') }}
        </div>
      </div>
    </div>

    <!-- RECENT TRANSACTIONS -->
    <div class="recent-card">
      <div class="recent-header">Recent Transactions</div>

      <div v-for="transaction in recentTransactions" :key="transaction.id" class="transaction-row">
        <div>
          <div class="order-id">
            {{ transaction.order_id }}
          </div>

          <div class="product-name">
            {{ transaction.product_name }}
          </div>
        </div>

        <div class="transaction-right">
          <div class="transaction-status">
            {{ transaction.transaction_status }}
          </div>

          <div class="transaction-price">
            Rp
            {{ Number(transaction.total_price).toLocaleString('id-ID') }}
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, onMounted } from 'vue'

import api from 'src/axios'

const totalTransactions = ref(0)

const completedOrders = ref(0)

const processingOrders = ref(0)

const totalSpending = ref(0)

const recentTransactions = ref([])

const loadDashboard = async () => {
  try {

    const auth = JSON.parse(
      localStorage.getItem('auth')
    )

    const email = auth.data.email

const response = await api.get(
  `/api/transactions/customer/${email}`
)

console.log(response.data)

const transactions = response.data.transactions

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
        'delivering'
      ].includes(
        transaction.order_status
      )
  ).length

totalSpending.value =
  transactions.reduce(
    (total, transaction) =>
      total +
      Number(transaction.total_price || 0),
    0
  )

recentTransactions.value =
  transactions.slice(0, 5)
  } catch (error) {
    console.error('Dashboard Error:', error)
  }

}

onMounted(() => {
  loadDashboard()
})
</script>

<style lang="scss" scoped>
.dashboard-page {
  padding: 8px;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  margin: 0;

  font-size: 2rem;
  font-weight: 700;
}

.page-header p {
  margin-top: 6px;

  color: rgba(0, 0, 0, 0.55);
}

.stats-grid {
  display: grid;

  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));

  gap: 20px;
}

.stats-card {
  padding: 24px;

  background: white;

  border: 1px solid rgba($sakura, 0.12);

  border-radius: 20px;

  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
}

.stats-label {
  color: rgba(0, 0, 0, 0.55);

  font-size: 0.9rem;
}

.stats-value {
  margin-top: 12px;

  color: $sakura;

  font-size: 2rem;
  font-weight: 700;
}

.recent-card {
  margin-top: 24px;

  padding: 24px;

  background: white;

  border: 1px solid rgba($sakura, 0.12);

  border-radius: 20px;

  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
}

.recent-header {
  margin-bottom: 20px;

  font-size: 1.1rem;
  font-weight: 700;
}

.transaction-row {
  display: flex;

  justify-content: space-between;

  align-items: center;

  padding: 14px 0;

  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.transaction-row:last-child {
  border-bottom: none;
}

.order-id {
  font-weight: 600;
}

.product-name {
  margin-top: 4px;

  color: rgba(0, 0, 0, 0.55);

  font-size: 0.85rem;
}

.transaction-right {
  text-align: right;
}

.transaction-status {
  color: $sakura;

  font-size: 0.85rem;

  text-transform: capitalize;
}

.transaction-price {
  margin-top: 4px;

  font-weight: 700;
}
</style>
