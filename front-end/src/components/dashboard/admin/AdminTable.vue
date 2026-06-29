<template>

  <q-table flat bordered hide-pagination :rows-per-page-options="[0]" :rows="admins" :columns="columns" row-key="id"
    class="admin-table">

    <template #body-cell-name="props">

      <q-td :props="props">

        <div class="admin-name">
          {{ props.row.name }}
        </div>

      </q-td>

    </template>

    <template #body-cell-email="props">

      <q-td :props="props">

        {{ props.row.email }}

      </q-td>

    </template>

    <template #body-cell-level="props">

      <q-td :props="props">

        <q-badge color="accent">
          {{ props.row.level }}
        </q-badge>

      </q-td>

    </template>

    <template #body-cell-created_at="props">

      <q-td :props="props">

        {{
          new Date(
            props.row.created_at
          ).toLocaleDateString('id-ID')
        }}

      </q-td>

    </template>

    <template #body-cell-actions="props">

      <q-td :props="props">

        <div class="action-buttons">

          <q-btn flat round dense icon="visibility" color="info" @click="emit('details', props.row)" />

          <q-btn flat round dense icon="edit" color="accent" @click="emit('update', props.row)" />

        </div>

      </q-td>

    </template>

    <template #no-data>

      <div class="full-width row flex-center q-pa-lg">
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
    name: 'email',
    label: 'Email',
    field: 'email',
    align: 'left',
    sortable: true,
  },

  {
    name: 'level',
    label: 'Level',
    field: 'level',
    align: 'center',
    sortable: true,
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

<style lang="scss" scoped>
.admin-table {
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
