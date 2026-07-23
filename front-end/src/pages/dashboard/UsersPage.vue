<template>

  <q-page class="users-page">

    <!-- HEADER -->

    <div class="page-header">

      <div class="page-title">

        <h1>
          Users
        </h1>

        <p>
          Kelola seluruh pengguna EI Gaming Store.
        </p>

      </div>

    </div>

    <!-- TOOLBAR -->

    <div class="toolbar-row">

      <q-input v-model="search" outlined dense clearable placeholder="Cari user..." class="search-input">

        <template #prepend>

          <q-icon name="search" />

        </template>

      </q-input>

    </div>

    <!-- TABLE -->

    <UserTable :users="filteredUsers" @details="openDetails" @update="openUpdate" />

    <!-- DETAILS -->

    <UserDetailsDialog v-model="showDetails" :user="selectedUser" @update="openUpdate" />

    <!-- UPDATE -->

    <UserUpdateDialog v-model="showUpdate" :user="selectedUser" @updated="refreshUsers" />

  </q-page>

</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
} from 'vue'

import api from 'src/axios'

import UserTable from 'src/components/dashboard/users/UserTable.vue'

import UserDetailsDialog from 'src/components/dashboard/users/UserDetailsDialog.vue'

import UserUpdateDialog from 'src/components/dashboard/users/UserUpdateDialog.vue'

const users = ref([])

const search = ref('')

const selectedUser =
  ref(null)

const showDetails =
  ref(false)

const showUpdate =
  ref(false)

/*
|--------------------------------------------------------------------------
| LOAD USERS
|--------------------------------------------------------------------------
*/

const loadUsers =
  async () => {

    try {

      const response =
        await api.get(
          '/api/user'
        )

      users.value =
        response.data.users

    } catch (error) {

      console.error(
        'Load Users Error:',
        error
      )

    }

  }

/*
|--------------------------------------------------------------------------
| FILTERED USERS
|--------------------------------------------------------------------------
*/

const filteredUsers =
  computed(() => {

    if (
      !search.value
    ) {

      return users.value

    }

    const keyword =
      search.value.toLowerCase()

    return users.value.filter(
      (user) =>

        user.name
          ?.toLowerCase()
          .includes(keyword)

        ||

        user.email
          ?.toLowerCase()
          .includes(keyword)

    )

  })

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

const openDetails =
  (user) => {

    selectedUser.value =
      user

    showDetails.value =
      true

  }

/*
|--------------------------------------------------------------------------
| UPDATE
|--------------------------------------------------------------------------
*/

const openUpdate =
  (user) => {

    showDetails.value =
      false

    selectedUser.value =
      user

    showUpdate.value =
      true

  }

/*
|--------------------------------------------------------------------------
| REFRESH
|--------------------------------------------------------------------------
*/

const refreshUsers =
  async () => {

    await loadUsers()

  }

/*
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadUsers()

})
</script>

<style scoped lang="scss">
.users-page {
  padding: 16px;
}

.page-header {
  display: flex;

  justify-content: space-between;
  align-items: center;

  gap: 20px;

  margin-bottom: 20px;
}

.page-title h1 {
  margin: 0;

  color: var(--app-text);

  font-size: 1.9rem;
  font-weight: 700;
}

.page-title p {
  margin-top: 6px;

  color: var(--app-text-secondary);

  font-size: .95rem;
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

  margin-bottom: 20px;
}

.search-input {
  flex: 1;
}

/*
|--------------------------------------------------------------------------
| QUASAR
|--------------------------------------------------------------------------
*/

:deep(.q-field--outlined .q-field__control) {
  border-radius: 14px;

  background: var(--app-surface);

  border-color: var(--app-border);
}

:deep(.q-btn) {
  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (min-width:1024px) {

  .users-page {
    padding: 24px;
  }

}

@media (max-width:768px) {

  .users-page {
    padding: 12px;
  }

  .page-header {
    margin-bottom: 16px;
  }

  .page-title h1 {
    font-size: 1.5rem;
  }

  .page-title p {
    font-size: .85rem;
  }

  .toolbar-row {
    flex-direction: column;

    align-items: stretch;

    gap: 12px;
  }

  .search-input {
    width: 100%;
  }

}
</style>
