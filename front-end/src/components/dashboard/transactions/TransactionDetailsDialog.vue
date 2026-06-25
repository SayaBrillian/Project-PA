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
              <span> Status </span>

              <q-badge color="positive">
                {{ transaction.transaction_status || '-' }}
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

      <q-card-actions align="right">
        <q-btn flat label="Close" v-close-popup />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch } from 'vue'

import api from 'src/axios'

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
