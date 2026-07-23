<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="users" :columns="columns" row-key="id"
    class="user-table">

    <!-- NAME -->

    <template #body-cell-name="props">

      <q-td :props="props">

        <div class="user-name">
          {{ props.row.name }}
        </div>

      </q-td>

    </template>

    <!-- USERNAME -->

    <template #body-cell-username="props">

      <q-td :props="props">

        {{ props.row.username }}

      </q-td>

    </template>

    <!-- EMAIL -->

    <template #body-cell-email="props">

      <q-td :props="props">

        {{ props.row.email }}

      </q-td>

    </template>

    <!-- PHONE -->

    <template #body-cell-phone="props">

      <q-td :props="props">

        {{ props.row.phone }}

      </q-td>

    </template>

    <!-- REGISTERED -->

    <template #body-cell-created_at="props">

      <q-td :props="props">

        {{
          new Date(
            props.row.created_at
          ).toLocaleDateString('id-ID')
        }}

      </q-td>

    </template>

    <!-- ACTIONS -->

    <template #body-cell-actions="props">

      <q-td :props="props">

        <div class="action-buttons">

          <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)" />

          <q-btn flat round dense icon="edit" color="accent" @click="emit('update', props.row)" />

        </div>

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
        Tidak ada user ditemukan.
      </div>

    </template>

  </q-table>

</template>

<script setup>

defineProps({
  users: {
    type: Array,
    default: () => [],
  },
})

const emit = defineEmits([
  'details',
  'update',
])

const columns = [

  {
    name: 'name',
    label: 'Name',
    field: 'name',
    align: 'left',
    sortable: true,
  },

  {
    name: 'username',
    label: 'Username',
    field: 'username',
    align: 'left',
    sortable: true,
  },

  {
    name: 'email',
    label: 'Email',
    field: 'email',
    align: 'left',
    sortable: true,
  },

  {
    name: 'phone',
    label: 'Phone',
    field: 'phone',
    align: 'left',
  },

  {
    name: 'created_at',
    label: 'Registered',
    field: 'created_at',
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
.user-table {
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
| USER
|--------------------------------------------------------------------------
*/

.user-name {
  color: var(--app-text);

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
