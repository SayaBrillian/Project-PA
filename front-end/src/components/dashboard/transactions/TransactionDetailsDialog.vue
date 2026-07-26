<template>
  <q-dialog seamless :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined"
    @update:model-value="emit('update:modelValue', $event)">
    <q-card class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle" />

        <div class="header-content">

          <div>

            <h2 class="dialog-title">
              Transaction Details
            </h2>

            <p class="dialog-subtitle">
              Detail pembayaran dan transaksi pelanggan.
            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- LOADING -->

      <div v-if="loading" class="loading-wrapper">

        <q-spinner color="accent" size="44px" />

        <div class="loading-text">
          Loading transaction...
        </div>

      </div>

      <!-- CONTENT -->

      <div v-else class="dialog-content">

        <!-- ORDER -->

        <div class="dialog-section">

          <h3 class="section-title">
            Order Summary
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Order ID</span>

              <strong>
                {{ transaction.order_id }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Game</span>

              <strong>
                {{ transaction.game_name }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Product</span>

              <strong>
                {{ transaction.product_name }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Quantity</span>

              <strong>
                {{ transaction.quantity }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Total Payment</span>

              <strong>
                Rp {{ Number(transaction.total_price).toLocaleString('id-ID') }}
              </strong>

            </div>

          </div>

        </div>

        <!-- PAYMENT -->

        <div class="dialog-section">

          <h3 class="section-title">
            Payment Information
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Payment Status</span>

              <q-badge :color="getPaymentStatusColor(transaction.transaction_status)">
                {{ transaction.transaction_status || '-' }}
              </q-badge>

            </div>

            <div class="detail-item">

              <span>Order Status</span>

              <q-badge :color="getOrderStatusColor(transaction.order_status)">
                {{ transaction.order_status || '-' }}
              </q-badge>

            </div>

            <div class="detail-item">

              <span>Payment Type</span>

              <strong>
                {{ transaction.payment_type || '-' }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Settlement Time</span>

              <strong>
                {{ transaction.settlement_time || '-' }}
              </strong>

            </div>

          </div>

        </div>

        <!-- CUSTOMER -->

        <div class="dialog-section">

          <h3 class="section-title">
            Customer Information
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Email</span>

              <strong>
                {{ transaction.customer_email }}
              </strong>

            </div>

            <div class="detail-item">

              <span>WhatsApp</span>

              <strong>
                {{ transaction.customer_whatsapp }}
              </strong>

            </div>

          </div>

        </div>

        <!-- TARGET -->

        <div class="dialog-section">

          <h3 class="section-title">
            Game Targets
          </h3>

          <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="details" :columns="targetColumns"
            row-key="game_uid" class="targets-table">

            <template #body-cell-index="props">

              <q-td :props="props">

                {{ props.pageIndex + 1 }}

              </q-td>

            </template>

          </q-table>

        </div>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <!-- FOOTER -->

      <div v-if="transaction.transaction_status === 'pending'" class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" icon="payments" label="Continue Payment" :loading="paymentLoading"
            @click="payNow" />

        </div>

      </div>

    </q-card>

  </q-dialog>
</template>

<script setup>
import {
  ref,
  watch,
} from 'vue'

import api from 'src/axios'

const props = defineProps({
  modelValue: Boolean,

  transactionId: {
    type: Number,
    default: null,
  },
})

const emit = defineEmits([
  'update:modelValue',
])

const loading = ref(false)

const paymentLoading = ref(false)

const transaction = ref({})

const details = ref([])

/*
|--------------------------------------------------------------------------
| TARGET TABLE
|--------------------------------------------------------------------------
*/

const targetColumns = [
  {
    name: 'index',
    label: '#',
    field: 'index',
    align: 'center',
  },
  {
    name: 'game_uid',
    label: 'UID',
    field: 'game_uid',
    align: 'left',
  },
  {
    name: 'game_server',
    label: 'Server',
    field: 'game_server',
    align: 'left',
  },
]

/*
|--------------------------------------------------------------------------
| LOAD TRANSACTION
|--------------------------------------------------------------------------
*/

const loadTransaction = async () => {

  if (!props.transactionId)
    return

  try {

    loading.value = true

    const response =
      await api.get(
        `/api/transactions/${props.transactionId}`
      )

    transaction.value =
      response.data.transaction

    details.value =
      response.data.details

  } catch (error) {

    console.error(
      'Load Transaction Error:',
      error
    )

  } finally {

    loading.value = false

  }

}

/*
|--------------------------------------------------------------------------
| PAY NOW
|--------------------------------------------------------------------------
*/

const payNow = async () => {

  try {

    paymentLoading.value = true

    const response =
      await api.get(
        `/api/payments/snap/${transaction.value.order_id}`
      )

    window.snap.pay(
      response.data.token,
      {

        onSuccess() {

          loadTransaction()

        },

        onPending() {

          loadTransaction()

        },

        onClose() {

          paymentLoading.value = false

        },

      }
    )

  } catch (error) {

    console.error(
      'Pay Transaction Error:',
      error
    )

  } finally {

    paymentLoading.value = false

  }

}

/*
|--------------------------------------------------------------------------
| PAYMENT STATUS COLOR
|--------------------------------------------------------------------------
*/

const getPaymentStatusColor = (status) => {

  switch (status?.toLowerCase()) {

    case 'settlement':
      return 'positive'

    case 'pending':
      return 'warning'

    case 'expire':
    case 'cancel':
    case 'failed':
      return 'negative'

    default:
      return 'grey'

  }

}

/*
|--------------------------------------------------------------------------
| ORDER STATUS COLOR
|--------------------------------------------------------------------------
*/

const getOrderStatusColor = (status) => {

  switch (status?.toLowerCase()) {

    case 'waiting':
      return 'warning'

    case 'processing':
      return 'info'

    case 'sending':
      return 'primary'

    case 'done':
      return 'positive'

    default:
      return 'grey'

  }

}

/*
|--------------------------------------------------------------------------
| WATCH DIALOG
|--------------------------------------------------------------------------
*/

watch(

  () => props.modelValue,

  (opened) => {

    if (
      opened &&
      props.transactionId
    ) {

      loadTransaction()

    }

  }

)
</script>

<style lang="scss" scoped>
.dialog-card {
  width: 920px;
  max-width: 96vw;
  max-height: 90vh;

  display: flex;
  flex-direction: column;

  border-radius: 24px;

  overflow: hidden;

  background: var(--app-surface);
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {
  padding: 22px 24px 18px;
}

.dialog-handle {
  width: 52px;
  height: 5px;

  margin: 0 auto 18px;

  border-radius: 999px;

  background: var(--app-border);
}

.header-content {
  display: flex;

  justify-content: space-between;
  align-items: flex-start;

  gap: 20px;
}

.dialog-title {
  margin: 0;

  color: var(--app-text);

  font-size: 1.45rem;
  font-weight: 700;
}

.dialog-subtitle {
  margin: 6px 0 0;

  color: var(--app-text-secondary);

  font-size: .92rem;
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {
  flex: 1;

  overflow-y: auto;

  padding: 24px;

  display: flex;
  flex-direction: column;

  gap: 28px;
}

/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.dialog-section {
  display: flex;
  flex-direction: column;

  gap: 18px;
}

.section-title {
  margin: 0;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| DETAIL GRID
|--------------------------------------------------------------------------
*/

.detail-grid {
  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;
}

.detail-item {
  display: flex;
  flex-direction: column;

  gap: 6px;
}

.detail-item span {
  color: var(--app-text-secondary);

  font-size: .82rem;
}

.detail-item strong {
  color: var(--app-text);

  font-size: .96rem;
  font-weight: 600;

  word-break: break-word;
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  width: fit-content;

  min-width: 78px;

  justify-content: center;

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| TARGET TABLE
|--------------------------------------------------------------------------
*/

.targets-table {
  background: var(--app-surface);

  border: 1px solid var(--app-border);

  border-radius: 16px;

  overflow: hidden;
}

:deep(.targets-table thead th) {
  background: var(--app-surface);

  color: var(--app-text);

  font-weight: 700;

  border-bottom: 1px solid var(--app-border);
}

:deep(.targets-table td) {
  color: var(--app-text);
}

:deep(.targets-table tbody tr:hover) {
  background: rgba($accent, .05);
}

/*
|--------------------------------------------------------------------------
| LOADING
|--------------------------------------------------------------------------
*/

.loading-wrapper {
  padding: 56px 24px;

  display: flex;
  flex-direction: column;

  align-items: center;

  gap: 18px;
}

.loading-text {
  color: var(--app-text-secondary);

  font-size: .92rem;
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/
.dialog-footer {
  padding: 18px 24px;

  border-top: 1px solid var(--app-border);

  background: var(--app-surface);
}

.footer-actions {
  display: flex;

  justify-content: flex-end;
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

:deep(.q-btn) {
  border-radius: 12px;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .dialog-card {
    width: 100%;
    max-width: 100vw;
    max-height: 92vh;

    border-radius: 24px 24px 0 0;
  }

  .dialog-header {
    padding: 18px;
  }

  .dialog-content {
    padding: 18px;
  }

  .dialog-footer {
    padding: 18px;
  }

  .detail-grid {
    grid-template-columns: 1fr;
  }

  .footer-actions {
    flex-direction: column-reverse;
  }

  .footer-actions .q-btn {
    width: 100%;
  }

}
</style>
