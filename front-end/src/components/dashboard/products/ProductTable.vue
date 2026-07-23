<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="products" :columns="columns" row-key="id"
    class="product-table">

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

        <q-badge :color="props.row.is_active
          ? 'positive'
          : 'negative'
          ">
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

          <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)" />

          <q-btn flat round dense icon="edit" color="accent" @click="emit('update', props.row)" />

          <q-btn flat round dense icon="delete" color="negative" @click="emit('delete', props.row)" />

        </div>

      </q-td>

    </template>

    <template #no-data>

      <div class="
          full-width
          row
          flex-center
          q-pa-lg
        ">
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

<style scoped lang="scss">
.product-table {
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
| PRODUCT
|--------------------------------------------------------------------------
*/

.product-name {
  color: var(--app-text);

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| PRICE
|--------------------------------------------------------------------------
*/

.price {
  font-weight: 600;

  color: var(--app-text);
}

/*
|--------------------------------------------------------------------------
| STATUS
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  min-width: 72px;

  justify-content: center;

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| ACTIONS
|--------------------------------------------------------------------------
*/

.action-buttons {
  display: flex;

  justify-content: center;

  gap: 6px;
}

.action-buttons :deep(.q-btn) {
  border-radius: 10px;

  transition: background .2s ease;
}

.action-buttons :deep(.q-btn:hover) {
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

  .action-buttons {
    gap: 4px;
  }

}
</style>
