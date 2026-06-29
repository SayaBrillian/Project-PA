<template>

  <q-page class="users-page">

    <!-- HEADER -->

    <div class="page-header">

      <h1>
        Users
      </h1>

      <p>
        Kelola seluruh pengguna.
      </p>

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

    <UserTable :users="filteredUsers
      " @details="
        openDetails
      " @update="
        openUpdate
      " />

    <!-- DETAILS -->

    <UserDetailsDialog v-model="showDetails" :user="selectedUser
      " @update="
        openUpdate
      " />

    <!-- UPDATE -->

    <UserUpdateDialog v-model="showUpdate" :user="selectedUser
      " @updated="
        refreshUsers
      " />

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
          '/api/users'
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

<style lang="scss" scoped>
.users-page {
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
