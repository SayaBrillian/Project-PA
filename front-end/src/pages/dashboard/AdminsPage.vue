<template>

  <q-page class="admins-page">

    <!-- HEADER -->

    <div class="page-header">

      <h1>
        Admins
      </h1>

      <p>
        Kelola seluruh administrator.
      </p>

    </div>

    <!-- TOOLBAR -->

    <div class="toolbar-row">

      <q-input v-model="search" outlined dense clearable placeholder="Cari admin..." class="search-input">

        <template #prepend>

          <q-icon name="search" />

        </template>

      </q-input>

      <q-btn unelevated color="accent" icon="add" label="Add Admin" @click="showCreate = true" />

    </div>

    <!-- TABLE -->

    <AdminTable :admins="filteredAdmins" @details="openDetails" @update="openUpdate" />

    <!-- DETAILS -->

    <AdminDetailsDialog v-model="showDetails" :admin="selectedAdmin" @update="openUpdate" />

    <!-- UPDATE -->

    <AdminUpdateDialog v-model="showUpdate" :admin="selectedAdmin" @updated="refreshAdmins" />

    <!-- CREATE -->

    <AdminCreateDialog v-model="showCreate" @created="refreshAdmins" />

  </q-page>

</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
} from 'vue'

import api from 'src/axios'

import AdminTable from 'src/components/dashboard/admin/AdminTable.vue'

import AdminDetailsDialog from 'src/components/dashboard/admin/AdminDetailsDialog.vue'

import AdminUpdateDialog from 'src/components/dashboard/admin/AdminUpdateDialog.vue'

import AdminCreateDialog from 'src/components/dashboard/admin/AdminCreateDialog.vue'

const admins = ref([])

const search = ref('')

const selectedAdmin = ref(null)

const showDetails = ref(false)

const showUpdate = ref(false)

const showCreate = ref(false)

/*
|--------------------------------------------------------------------------
| LOAD USERS
|--------------------------------------------------------------------------
*/
const loadAdmins = async () => {

  try {

    const response =
      await api.get('/api/admins')

    admins.value =
      response.data.admins

  } catch (error) {

    console.error(
      'Load Admins Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| FILTERED USERS
|--------------------------------------------------------------------------
*/
const filteredAdmins = computed(() => {

  if (!search.value)
    return admins.value

  const keyword =
    search.value.toLowerCase()

  return admins.value.filter(
    admin =>

      admin.name
        ?.toLowerCase()
        .includes(keyword)

      ||

      admin.email
        ?.toLowerCase()
        .includes(keyword)

  )

})
/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/
const openDetails = (admin) => {

  selectedAdmin.value =
    admin

  showDetails.value =
    true

}

/*
|--------------------------------------------------------------------------
| UPDATE
|--------------------------------------------------------------------------
*/
const openUpdate = (admin) => {

  showDetails.value =
    false

  selectedAdmin.value =
    admin

  showUpdate.value =
    true

}

/*
|--------------------------------------------------------------------------
| REFRESH
|--------------------------------------------------------------------------
*/
const refreshAdmins = async () => {

  await loadAdmins()

}

/*
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/
onMounted(() => {

  loadAdmins()

})
</script>

<style lang="scss" scoped>
.admins-page {
  display: flex;
  flex-direction: column;

  gap: 24px;
}

.page-header h1 {
  margin: 0;

  color: $dark;

  font-size: 2rem;
  font-weight: 700;
}

.page-header p {
  margin-top: 8px;

  color: rgba(0,
      0,
      0,
      .55);
}

.toolbar-row {
  display: flex;

  align-items: center;

  gap: 16px;
}

.search-input {
  flex: 1;
}

:deep(.q-field--outlined .q-field__control) {
  border-radius: 14px;
}

:deep(.q-btn) {
  border-radius: 14px;
}

@media (max-width: 768px) {

  .toolbar-row {
    flex-direction: column;

    align-items: stretch;
  }

  .search-input {
    width: 100%;
  }

}
</style>
