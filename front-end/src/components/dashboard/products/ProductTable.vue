<template>

  <q-table
    flat
    bordered
    hide-pagination
    :rows-per-page-options="[0]"
    :rows="products"
    :columns="columns"
    row-key="id"
    class="product-table"
  >

    <template #body-cell-name="props">

      <q-td :props="props">

        <div class="product-name">
          {{ props.row.name }}
        </div>

      </q-td>

    </template>

    <template #body-cell-price="props">

      <q-td :props="props">

        Rp
        {{
          Number(
            props.row.price
          ).toLocaleString(
            'id-ID'
          )
        }}

      </q-td>

    </template>

    <template #body-cell-status="props">

      <q-td :props="props">

        <q-badge
          :color="
            props.row.is_active
              ? 'positive'
              : 'negative'
          "
        >
          {{
            props.row.is_active
              ? 'Active'
              : 'Inactive'
          }}
        </q-badge>

      </q-td>

    </template>

    <template #body-cell-actions="props">

      <q-td :props="props">

        <div class="action-buttons">

          <q-btn
            flat
            round
            dense
            icon="visibility"
            color="info"
            @click="emit('details', props.row)"
          />

          <q-btn
            flat
            round
            dense
            icon="edit"
            color="accent"
            @click="emit('update', props.row)"
          />

          <q-btn
            flat
            round
            dense
            icon="delete"
            color="negative"
            @click="emit('delete', props.row)"
          />

        </div>

      </q-td>

    </template>

    <template #no-data>

      <div
        class="
          full-width
          row
          flex-center
          q-pa-lg
        "
      >
        Tidak ada produk ditemukan.
      </div>

    </template>

  </q-table>

</template>

<script setup>

defineProps({
  products: {
    type: Array,
    default: () => [],
  },
})

const emit = defineEmits([
  'details',
  'update',
  'delete',
])

const columns = [
  {
    name: 'name',
    label: 'Product',
    field: 'name',
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
    name: 'currency_amount',
    label: 'Amount',
    field: 'currency_amount',
    align: 'center',
    sortable: true,
  },
  {
    name: 'price',
    label: 'Price',
    field: 'price',
    align: 'right',
    sortable: true,
  },
  {
    name: 'status',
    label: 'Status',
    field: 'is_active',
    align: 'center',
  },
  {
    name: 'actions',
    label: 'Actions',
    field: 'actions',
    align: 'center',
  },
]

</script>

<style lang="scss" scoped>

.product-table {
  background: white;

  border-radius: 20px;

  overflow: hidden;
}

.action-buttons {
  display: flex;

  justify-content: center;

  gap: 4px;
}

:deep(.q-table thead tr) {
  background: rgba(
    $sakura,
    .08
  );
}

:deep(.q-table th) {
  font-weight: 700;

  color: $dark;
}

:deep(.q-table tbody tr:hover) {
  background: rgba(
    $sakura,
    .04
  );
}

</style>