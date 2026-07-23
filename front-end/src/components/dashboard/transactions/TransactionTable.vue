<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="transactions" :columns="columns"
    row-key="id" class="transaction-table">

    <!-- INVOICE -->

    <template #body-cell-order_id="props">

      <q-td :props="props">

        <span class="invoice">
          {{ props.row.order_id }}
        </span>

      </q-td>

    </template>

    <!-- PRICE -->

    <template #body-cell-total_price="props">

      <q-td :props="props">

        <span class="price">
          Rp {{ Number(props.row.total_price).toLocaleString('id-ID') }}
        </span>

      </q-td>

    </template>

    <!-- PAYMENT STATUS -->

    <template #body-cell-transaction_status="props">

      <q-td :props="props">

        <q-badge :color="getStatusColor(props.row.transaction_status)">
          {{ props.row.transaction_status }}
        </q-badge>

      </q-td>

    </template>

    <!-- ORDER STATUS -->

    <template #body-cell-order_status="props">

      <q-td :props="props">

        <q-badge :color="getOrderStatusColor(props.row.order_status)">
          {{ props.row.order_status }}
        </q-badge>

      </q-td>

    </template>

    <!-- CREATED -->

    <template #body-cell-created_at="props">

      <q-td :props="props">

        {{ formatDate(props.row.created_at) }}

      </q-td>

    </template>

    <!-- ACTIONS -->

    <template #body-cell-actions="props">

      <q-td :props="props">

        <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)" />

      </q-td>

    </template>

    <!-- NO DATA -->

    <template #no-data>

      <div class="
          full-width
          row
          flex-center
          q-pa-lg
        ">
        Tidak ada transaksi.
      </div>

    </template>

  </q-table>

</template>

<script setup>

defineProps({
  transactions: {
    type: Array,
    default: () => [],
  },
})

const emit = defineEmits([
  'details',
])

const columns = [
  {
    name: 'order_id',
    label: 'Invoice',
    field: 'order_id',
    align: 'left',
    sortable: true,
  },
  {
    name: 'game_name',
    label: 'Game',
    field: 'game_name',
    align: 'left',
    sortable: true,
  },
  {
    name: 'product_name',
    label: 'Product',
    field: 'product_name',
    align: 'left',
    sortable: true,
  },
  {
    name: 'total_price',
    label: 'Total',
    field: 'total_price',
    align: 'right',
    sortable: true,
  },
  {
    name: 'transaction_status',
    label: 'Payment',
    field: 'transaction_status',
    align: 'center',
  },
  {
    name: 'order_status',
    label: 'Order',
    field: 'order_status',
    align: 'center',
  },
  {
    name: 'created_at',
    label: 'Created',
    field: 'created_at',
    align: 'center',
  },
  {
    name: 'actions',
    label: 'Actions',
    field: 'actions',
    align: 'center',
  },
]

const getStatusColor =
  (status) => {

    switch (
    status?.toLowerCase()
    ) {

      case 'settlement':
      case 'success':
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
const formatDate =
  (date) => {

    return new Date(
      date
    ).toLocaleDateString(
      'id-ID'
    )

  }

</script>

<style scoped lang="scss">
.transaction-table {
  background: var(--app-surface);

  border: 1px solid var(--app-border);

  border-radius: 18px;

  overflow: auto;
}

/*
|--------------------------------------------------------------------------
| TABLE
|--------------------------------------------------------------------------
*/

:deep(.q-table table) {
  border-collapse: separate;

  border-spacing: 0;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

:deep(.q-table thead th) {
  background: var(--app-surface);

  color: var(--app-text);

  font-weight: 700;

  white-space: nowrap;

  border-bottom: 1px solid var(--app-border);
}

/*
|--------------------------------------------------------------------------
| BODY
|--------------------------------------------------------------------------
*/

:deep(.q-table td) {
  color: var(--app-text);

  white-space: nowrap;
}

:deep(.q-table tbody tr) {
  transition: background .2s ease;
}

:deep(.q-table tbody tr:hover) {
  background: rgba($accent, .05);
}

/*
|--------------------------------------------------------------------------
| STICKY COLUMN
|--------------------------------------------------------------------------
*/

:deep(.q-table thead th:first-child),
:deep(.q-table tbody td:first-child) {
  position: sticky;

  left: 0;

  z-index: 10;

  background: var(--app-surface);
}

:deep(.q-table thead th:last-child),
:deep(.q-table tbody td:last-child) {
  position: sticky;

  right: 0;

  z-index: 10;

  background: var(--app-surface);
}

/*
|--------------------------------------------------------------------------
| INVOICE
|--------------------------------------------------------------------------
*/

.invoice {
  color: var(--app-text);

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| PRICE
|--------------------------------------------------------------------------
*/

.price {
  color: var(--app-text);

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  min-width: 76px;

  justify-content: center;

  font-weight: 600;

  text-transform: capitalize;
}

/*
|--------------------------------------------------------------------------
| ACTION
|--------------------------------------------------------------------------
*/

:deep(.q-btn) {
  border-radius: 10px;

  transition: background .2s ease;
}

:deep(.q-btn:hover) {
  background: rgba($accent, .08);
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  :deep(.q-table th),
  :deep(.q-table td) {
    padding: 10px 12px;
  }

}
</style>
