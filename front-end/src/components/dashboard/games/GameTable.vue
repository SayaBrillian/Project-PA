<template>

  <q-table
    flat
    bordered
    hide-pagination
    :rows-per-page-options="[0]"
    :rows="games"
    :columns="columns"
    row-key="id"
    class="game-table"
  >

    <!-- STATUS -->

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

    <!-- GAME KEY -->

    <template #body-cell-game_key="props">

      <q-td :props="props">

        <q-chip
          dense
          outline
          color="accent"
        >
          {{ props.row.game_key }}
        </q-chip>

      </q-td>

    </template>

    <!-- ACTIONS -->

    <template #body-cell-actions="props">

      <q-td :props="props">

        <div class="action-buttons">

          <q-btn
            flat
            round
            dense
            icon="visibility"
            color="info"
            @click="
              emit(
                'details',
                props.row
              )
            "
          />

          <q-btn
            flat
            round
            dense
            icon="edit"
            color="accent"
            @click="
              emit(
                'update',
                props.row
              )
            "
          />

          <q-btn
            flat
            round
            dense
            icon="delete"
            color="negative"
            @click="
              emit(
                'delete',
                props.row
              )
            "
          />

        </div>

      </q-td>

    </template>

    <!-- NO DATA -->

    <template #no-data>

      <div
        class="
          full-width
          row
          flex-center
          q-pa-lg
        "
      >
        Tidak ada game ditemukan.
      </div>

    </template>

  </q-table>

</template>

<script setup>

defineProps({
  games: {
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
    label: 'Game',
    field: 'name',
    align: 'left',
    sortable: true,
  },
  {
    name: 'publisher',
    label: 'Publisher',
    field: 'publisher',
    align: 'left',
    sortable: true,
  },
  {
    name: 'game_key',
    label: 'Game Key',
    field: 'game_key',
    align: 'center',
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

.game-table {
  background: white;

  border-radius: 20px;

  overflow: hidden;
}

.action-buttons {
  display: flex;

  justify-content: center;

  gap: 4px;
}

/*
|--------------------------------------------------------------------------
| TABLE HEADER
|--------------------------------------------------------------------------
*/

:deep(.q-table thead tr) {
  background: rgba(
    $sakura,
    .08
  );
}

:deep(.q-table th) {
  color: $dark;

  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| TABLE BODY
|--------------------------------------------------------------------------
*/

:deep(.q-table tbody tr:hover) {
  background: rgba(
    $sakura,
    .04
  );
}

/*
|--------------------------------------------------------------------------
| ACTION BUTTONS
|--------------------------------------------------------------------------
*/

.action-buttons :deep(.q-btn) {
  transition:
    transform .2s ease;
}

.action-buttons :deep(.q-btn:hover) {
  transform: scale(1.1);
}

/*
|--------------------------------------------------------------------------
| CHIP
|--------------------------------------------------------------------------
*/

:deep(.q-chip) {
  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  min-width: 70px;

  justify-content: center;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .action-buttons {
    gap: 2px;
  }

}

</style>