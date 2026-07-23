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

    <AdminTable :admins="filteredAdmins" @details="openDetails" @update="openUpdate" @delete="openDelete" />

    <!-- DETAILS -->

    <AdminDetailsDialog v-model="showDetails" :admin="selectedAdmin" @update="openUpdate" />

    <!-- UPDATE -->

    <AdminUpdateDialog v-model="showUpdate" :admin="selectedAdmin" @updated="refreshAdmins" />

    <!-- CREATE -->

    <AdminCreateDialog v-model="showCreate" @created="refreshAdmins" />

    <!-- DELETE -->

    <AdminDeleteDialog v-model="showDelete" :admin="selectedAdmin" @deleted="refreshAdmins" />
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
import AdminDeleteDialog from 'src/components/dashboard/admin/AdminDeleteDialog.vue'

const admins = ref([])
const search = ref('')
const selectedAdmin = ref(null)
const showDetails = ref(false)
const showUpdate = ref(false)
const showCreate = ref(false)
const showDelete = ref(false)

/*
|--------------------------------------------------------------------------
| LOAD USERS
|--------------------------------------------------------------------------
*/
const loadAdmins = async () => {

  try {

    const response =
      await api.get('/api/admin')

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

  const keyword = search.value.toLowerCase()

  return admins.value.filter(admin =>

    admin.name?.toLowerCase().includes(keyword) ||

    admin.username?.toLowerCase().includes(keyword) ||

    admin.email?.toLowerCase().includes(keyword) ||

    admin.phone?.toLowerCase().includes(keyword) ||

    admin.role?.toLowerCase().includes(keyword)

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

const openDelete = (admin) => {

  selectedAdmin.value = admin

  showDelete.value = true

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

  gap: 28px;

}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {

  display: flex;
  flex-direction: column;

  gap: 8px;

}

.page-header h1 {

  margin: 0;

  color: var(--app-text);

  font-size: 2rem;
  font-weight: 700;

}

.page-header p {

  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.6;

}

/*
|--------------------------------------------------------------------------
| TOOLBAR
|--------------------------------------------------------------------------
*/

.toolbar-row {

  display: flex;

  align-items: center;

  gap: 16px;

}

.search-input {

  flex: 1;

}

.search-input :deep(.q-field__control) {

  border-radius: 14px;

}

.toolbar-row :deep(.q-btn) {

  height: 48px;

  padding: 0 20px;

  border-radius: 14px;

}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .admins-page {

    gap: 24px;

  }

  .page-header h1 {

    font-size: 1.8rem;

  }

  .toolbar-row {

    flex-direction: column;

    align-items: stretch;

  }

  .search-input {

    width: 100%;

  }

  .toolbar-row :deep(.q-btn) {

    width: 100%;

  }

}
</style>
