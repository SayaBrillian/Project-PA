<template>
  <q-dialog :model-value="modelValue" @update:model-value="emit('update:modelValue', $event)">
    <q-card class="dialog-card">
      <q-card-section>
        <div class="dialog-title">Transaction Details</div>
      </q-card-section>

      <q-separator />

      <q-card-section v-if="loading">
        <div class="loading-wrapper">
          <q-spinner color="accent" size="40px" />
        </div>
      </q-card-section>

      <template v-else>
        <!-- Invoice -->

        <q-card-section>
          <div class="section-title">Invoice Information</div>

          <div class="detail-grid">
            <div class="detail-item">
              <span> Order ID </span>

              <strong>
                {{ transaction.order_id }}
              </strong>
            </div>

            <div class="detail-item">

  <span> Payment Status </span>

  <q-badge
    :color="getPaymentStatusColor(transaction.transaction_status)"
  >
    {{ transaction.transaction_status || '-' }}
  </q-badge>

</div>
<div class="detail-item">

  <span> Order Status </span>

  <q-badge
    :color="getOrderStatusColor(transaction.order_status)"
  >
    {{ transaction.order_status || '-' }}
  </q-badge>

</div>

            <div class="detail-item">
              <span> Payment Type </span>

              <strong>
                {{ transaction.payment_type || '-' }}
              </strong>
            </div>

            <div class="detail-item">
              <span> Settlement Time </span>

              <strong>
                {{ transaction.settlement_time || '-' }}
              </strong>
            </div>
          </div>
        </q-card-section>

        <q-separator />

        <!-- Customer -->

        <q-card-section>
          <div class="section-title">Customer Information</div>

          <div class="detail-grid">
            <div class="detail-item">
              <span> Email </span>

              <strong>
                {{ transaction.customer_email }}
              </strong>
            </div>

            <div class="detail-item">
              <span> WhatsApp </span>

              <strong>
                {{ transaction.customer_whatsapp }}
              </strong>
            </div>
          </div>
        </q-card-section>

        <q-separator />

        <!-- Product -->

        <q-card-section>
          <div class="section-title">Product Information</div>

          <div class="detail-grid">
            <div class="detail-item">
              <span> Game </span>

              <strong>
                {{ transaction.game_name }}
              </strong>
            </div>

            <div class="detail-item">
              <span> Product </span>

              <strong>
                {{ transaction.product_name }}
              </strong>
            </div>

            <div class="detail-item">
              <span> Quantity </span>

              <strong>
                {{ transaction.quantity }}
              </strong>
            </div>

            <div class="detail-item">
              <span> Total Price </span>

              <strong>
                Rp
                {{ Number(transaction.total_price).toLocaleString('id-ID') }}
              </strong>
            </div>
          </div>
        </q-card-section>

        <q-separator />

        <!-- Targets -->

        <q-card-section>
          <div class="section-title">Game Targets</div>

          <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="details" :columns="targetColumns"
            row-key="game_uid" class="targets-table">

            <template #body-cell-index="props">

              <q-td :props="props">

                {{ props.pageIndex + 1 }}

              </q-td>

            </template>

          </q-table>
        </q-card-section>
      </template>
<q-separator />

<q-card-section
  v-if="transaction.transaction_status === 'pending'"
>

  <q-btn
    unelevated
    color="accent"
    icon="payments"
    label="Bayar Sekarang"
    class="full-width"
    :loading="paymentLoading"
    @click="payNow"
  />
<q-btn
  v-if="transaction.transaction_status === 'pending'"
  flat
  color="negative"
  icon="cancel"
  label="Batalkan Pesanan"
  class="full-width q-mt-sm"
  :loading="cancelLoading"
  @click="showCancelDialog = true"
/>
</q-card-section> 
      <q-card-actions align="right">
        <q-btn flat label="Close" v-close-popup />
      </q-card-actions>
    </q-card>
  </q-dialog>
  <q-dialog
  v-model="showCancelDialog"
  persistent
>

  <q-card class="cancel-dialog">

    <q-card-section class="cancel-header">

      <q-icon
        name="warning"
        size="56px"
        class="cancel-icon"
      />

      <div class="cancel-title">

        Batalkan Pesanan

      </div>

    </q-card-section>

    <q-card-section class="cancel-message">

      Apakah Anda yakin ingin membatalkan pesanan ini?

      <br><br>

      Pesanan yang sudah dibatalkan tidak dapat dipulihkan.

    </q-card-section>

    <q-card-actions
      align="right"
      class="cancel-actions"
    >

      <q-btn
        flat
        color="grey"
        label="Tidak"
        v-close-popup
      />

      <q-btn
        unelevated
        color="negative"
        label="Ya, Batalkan"
        :loading="cancelLoading"
        @click="cancelOrder"
      />

    </q-card-actions>

  </q-card>

</q-dialog>
</template>

<script setup>
import { ref, watch } from 'vue'
import api from 'src/axios'

const paymentLoading = ref(false)
const cancelLoading = ref(false)
const showCancelDialog = ref(false) 

const props = defineProps({
  modelValue: Boolean,

  transactionId: {
    type: Number,
    default: null,
  },
})

const emit = defineEmits(['update:modelValue'])

const loading = ref(false)

const transaction = ref({})

const details = ref([])


/*
|--------------------------------------------------------------------------
| LOAD TRANSACTION
|--------------------------------------------------------------------------
*/

const loadTransaction = async () => {
  if (!props.transactionId) return

  try {
    loading.value = true

    const response = await api.get(`/api/transactions/${props.transactionId}`)

    transaction.value = response.data.transaction

    details.value = response.data.details
  } catch (error) {
    console.error('Load Transaction Error:', error)
  } finally {
    loading.value = false
  }
}

/*
|--------------------------------------------------------------------------
| WATCH DIALOG
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

const cancelOrder = async () => {

  try {

    cancelLoading.value = true

    await api.put(
      `/api/transactions/order/${transaction.value.order_id}`,
      {
        transaction_status: 'cancel',
        order_status: 'cancel',
      }
    )

    showCancelDialog.value = false

    await loadTransaction()

  } catch (error) {

    console.error(error)

  } finally {

    cancelLoading.value = false

  }

}
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

        }

      }
    )

  } catch (error) {

    console.error(error)

  } finally {

    paymentLoading.value = false

  }

}

watch(
  () => props.modelValue,
  (value) => {
    if (value && props.transactionId) {
      loadTransaction()
    }
  },
)
</script>

<style lang="scss" scoped>
.dialog-card {
  width: 900px;
  max-width: 95vw;

  border-radius: 24px;

  overflow-y: auto;
}

.dialog-title {
  color: $dark;

  font-size: 1.4rem;
  font-weight: 700;
}

.loading-wrapper {
  display: flex;

  justify-content: center;
  align-items: center;

  padding: 40px;
}

/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.section-title {
  margin-bottom: 16px;

  color: $dark;

  font-size: 1rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

.detail-grid {
  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 16px;
}

.detail-item {
  display: flex;

  flex-direction: column;
}

.detail-item span {
  margin-bottom: 4px;

  color: rgba(0, 0, 0, 0.5);

  font-size: 0.85rem;
}

.detail-item strong {
  color: $dark;

  font-weight: 600;

  word-break: break-word;
}

/*
|--------------------------------------------------------------------------
| TARGET CARD
|--------------------------------------------------------------------------
*/

.targets-table {
  border-radius: 16px;

  overflow: hidden;
}

:deep(.targets-table thead tr) {
  background: rgba($sakura,
      .08);
}

:deep(.targets-table th) {
  color: $dark;

  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  width: fit-content;
}

/*
|--------------------------------------------------------------------------
| CANCEL DIALOG
|--------------------------------------------------------------------------
*/

.cancel-dialog {

  width: 420px;

  max-width: 90vw;

  border-radius: 24px;

  overflow: hidden;

}

.cancel-header {

  display: flex;

  flex-direction: column;

  align-items: center;

  text-align: center;

  gap: 12px;

  padding: 28px 24px 12px;

}

.cancel-title {

  color: $dark;

  font-size: 1.25rem;

  font-weight: 700;

}

.cancel-message {

  padding: 0 24px 24px;

  color: rgba(0, 0, 0, .65);

  text-align: center;

  line-height: 1.6;

}

.cancel-icon {

  color: #ff6b81;

}

.cancel-actions {

  padding: 16px 24px 24px;

}
/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {
  .dialog-card {
    width: 100%;
  }

  .detail-grid {
    grid-template-columns: 1fr;
  }
}
</style>
