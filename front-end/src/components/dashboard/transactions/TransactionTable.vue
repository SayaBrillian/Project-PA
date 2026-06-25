<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="transactions" :columns="columns"
    row-key="id" class="transaction-table">

    <template #body-cell-total_price="props">

      <q-td :props="props">

        Rp
        {{
          Number(
            props.row.total_price
          ).toLocaleString(
            'id-ID'
          )
        }}

      </q-td>

    </template>

    <template #body-cell-transaction_status="props">

      <q-td :props="props">

        <q-badge :color="getStatusColor(
          props.row.transaction_status
        )
          ">
          {{
            props.row.transaction_status
          }}
        </q-badge>

      </q-td>

    </template>

    <template #body-cell-created_at="props">

      <q-td :props="props">

        {{
          formatDate(
            props.row.created_at
          )
        }}

      </q-td>

    </template>

    <template #body-cell-actions="props">

      <q-td :props="props">

        <q-btn flat round dense icon="visibility" color="info" @click="
          emit(
            'details',
            props.row
          )
          " />

      </q-td>

    </template>

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
    label: 'Status',
    field: 'transaction_status',
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

const formatDate =
  (date) => {

    return new Date(
      date
    ).toLocaleDateString(
      'id-ID'
    )

  }

</script>

<style lang="scss" scoped>
.transaction-table {
  background: white;

  border-radius: 20px;

  overflow: hidden;
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
      .04);
}
</style>
