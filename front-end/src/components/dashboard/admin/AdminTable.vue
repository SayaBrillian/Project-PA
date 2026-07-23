  <template>

    <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="admins" :columns="columns" row-key="id"
      class="admin-table">

      <!-- ROLE -->

      <template #body-cell-role="props">

        <q-td :props="props">

          {{ props.row.role }}

        </q-td>

      </template>

      <!-- PHONE -->

      <template #body-cell-phone="props">

        <q-td :props="props">

          {{ props.row.phone || '-' }}

        </q-td>

      </template>

      <!-- REGISTERED -->

      <template #body-cell-created_at="props">

        <q-td :props="props">

          {{

            new Date(props.row.created_at)
              .toLocaleDateString('id-ID')

          }}

        </q-td>

      </template>

      <!-- ACTIONS -->

      <template #body-cell-actions="props">

        <q-td :props="props">

          <div class="action-buttons">

            <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)">

              <q-tooltip>

                Details

              </q-tooltip>

            </q-btn>

            <q-btn flat round dense icon="edit" color="accent" @click="emit('update', props.row)">

              <q-tooltip>

                Update

              </q-tooltip>

            </q-btn>

            <q-btn flat round dense icon="delete" color="negative" @click="emit('delete', props.row)">

              <q-tooltip>

                Delete

              </q-tooltip>

            </q-btn>

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

          Tidak ada admin ditemukan.

        </div>

      </template>

    </q-table>

  </template>

<script setup>

defineProps({

  admins: {

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
    name: 'role',
    label: 'Role',
    field: 'role',
    align: 'center',
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
    align: 'center',
  },
]

</script>

<style scoped lang="scss">
.admin-table {

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

  position: sticky;

  top: 0;

  z-index: 30;

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

:deep(.q-table tbody tr:not(:last-child) td) {

  border-bottom: 1px solid var(--app-border);

}

/*
  |--------------------------------------------------------------------------
  | STICKY LEFT
  |--------------------------------------------------------------------------
  */

:deep(.q-table thead th:first-child),
:deep(.q-table tbody td:first-child) {

  position: sticky;

  left: 0;

  z-index: 25;

  background: var(--app-surface);

}

/*
  |--------------------------------------------------------------------------
  | STICKY RIGHT
  |--------------------------------------------------------------------------
  */

:deep(.q-table thead th:last-child),
:deep(.q-table tbody td:last-child) {

  position: sticky;

  right: 0;

  z-index: 25;

  background: var(--app-surface);

}

/*
  |--------------------------------------------------------------------------
  | USERNAME
  |--------------------------------------------------------------------------
  */

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

  width: 34px;

  height: 34px;

  border-radius: 12px;

  transition: background .2s ease;

}

.action-buttons :deep(.q-btn:hover) {

  background: rgba($accent, .08);

}

/*
  |--------------------------------------------------------------------------
  | SCROLLBAR
  |--------------------------------------------------------------------------
  */

.admin-table::-webkit-scrollbar {

  height: 8px;

}

.admin-table::-webkit-scrollbar-thumb {

  background: var(--app-border);

  border-radius: 999px;

}

/*
  |--------------------------------------------------------------------------
  | MOBILE
  |--------------------------------------------------------------------------
  */

@media (max-width:768px) {

  :deep(.q-table) {

    font-size: .9rem;

  }

  :deep(.q-table th),
  :deep(.q-table td) {

    padding: 10px 12px;

  }

  .username {

    font-size: .85rem;

  }

  .action-buttons {

    gap: 2px;

  }

  .action-buttons :deep(.q-btn) {

    width: 30px;

    height: 30px;

  }

}
</style>
