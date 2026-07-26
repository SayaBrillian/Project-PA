<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="games" :columns="columns" row-key="id"
    class="game-table">

    <!-- GAME -->

    <template #body-cell-name="props">

      <q-td :props="props">

        <div class="game-name">

          {{ props.row.name }}

        </div>

        <div class="game-slug">

          {{ props.row.slug }}

        </div>

      </q-td>

    </template>

    <!-- PUBLISHER -->

    <template #body-cell-publisher="props">

      <q-td :props="props">

        {{ props.row.publisher || '-' }}

      </q-td>

    </template>

    <!-- GAME KEY -->

    <template #body-cell-game_key="props">

      <q-td :props="props">

        <span class="game-key">

          {{ props.row.game_key }}

        </span>

      </q-td>

    </template>

    <!-- PATCH -->

    <template #body-cell-latest_patch="props">

      <q-td :props="props">

        {{ props.row.latest_patch || '-' }}

      </q-td>

    </template>

    <!-- UPDATED -->

    <template #body-cell-latest_update="props">

      <q-td :props="props">

        {{

          props.row.latest_update

            ? new Date(
              props.row.latest_update
            ).toLocaleDateString('id-ID')

            : '-'

        }}

      </q-td>

    </template>

    <!-- STATUS -->

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

    <!-- ACTIONS -->

    <template #body-cell-actions="props">

      <q-td :props="props">

        <div class="action-buttons">

          <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)" />

          <q-btn flat round dense icon="edit" color="accent" @click="emit('update', props.row)" />

          <q-btn flat round dense icon="delete" color="negative" @click="emit('delete', props.row)" />

        </div>

      </q-td>

    </template>

    <!-- NO DATA -->

    <template #no-data>

      <div class="
          full-width
          row
          flex-center
          q-pa-xl
        ">

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

    name: 'latest_patch',

    label: 'Latest Patch',

    field: 'latest_patch',

    align: 'center',

    sortable: true,

  },

  {

    name: 'latest_update',

    label: 'Updated',

    field: 'latest_update',

    align: 'center',

    sortable: true,

  },

  {

    name: 'status',

    label: 'Status',

    field: 'is_active',

    align: 'center',

    sortable: true,

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
.game-table {

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

  background: rgba(255, 255, 255, .03);

}

/*
|--------------------------------------------------------------------------
| STICKY
|--------------------------------------------------------------------------
*/

:deep(.q-table thead th:first-child),
:deep(.q-table tbody td:first-child) {

  position: sticky;

  left: 0;

  z-index: 20;

  background: var(--app-surface);

}

:deep(.q-table thead th:last-child),
:deep(.q-table tbody td:last-child) {

  position: sticky;

  right: 0;

  z-index: 20;

  background: var(--app-surface);

}

/*
|--------------------------------------------------------------------------
| GAME
|--------------------------------------------------------------------------
*/

.game-name {

  font-weight: 700;

  color: var(--app-text);

}

.game-slug {

  margin-top: 4px;

  color: var(--app-text-secondary);

  font-size: .82rem;

}

/*
|--------------------------------------------------------------------------
| GAME KEY
|--------------------------------------------------------------------------
*/

.game-key {

  color: var(--app-text-secondary);

  font-weight: 600;

  font-size: .9rem;

}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {

  min-width: 78px;

  justify-content: center;

  border-radius: 999px;

  padding: 6px 12px;

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

  transition: background .2s;

}

.action-buttons :deep(.q-btn:hover) {

  background: rgba(255, 255, 255, .05);

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
