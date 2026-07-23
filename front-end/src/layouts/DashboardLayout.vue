<template>

  <q-layout view="hHh Lpr lFf" class="dashboard-layout">

    <!-- HEADER -->

    <q-header class="dashboard-header">

      <q-toolbar>

        <q-btn flat round dense icon="menu" class="menu-button" @click="toggleDrawer" />

        <q-toolbar-title>

          {{ pageTitle }}

        </q-toolbar-title>

        <q-btn flat round dense :icon="$q.dark.isActive ? 'light_mode' : 'dark_mode'" @click="toggleTheme" />

      </q-toolbar>

    </q-header>

    <!-- DESKTOP DRAWER -->

    <DashboardDrawer v-if="$q.screen.gt.sm" :mini="drawerMini" :user="user" @logout="logout" />
    <!-- CONTENT -->

    <q-page-container>

      <div class="dashboard-content">

        <router-view />

      </div>

    </q-page-container>

    <!-- MOBILE NAVIGATION -->

    <DashboardBottomNavigation @overview="goOverview" @menu="showMenu = true" @profile="showProfile = true" />

    <!-- MENU -->

    <DashboardMenuDialog v-model="showMenu" :user="user" />

    <!-- PROFILE -->

    <DashboardProfileDialog v-model="showProfile" :user="user" @logout="logout" />

  </q-layout>

</template>

<script setup>
import { computed, ref } from 'vue'
import { useQuasar } from 'quasar'
import { useRoute, useRouter } from 'vue-router'

import DashboardDrawer from 'src/components/dashboard/DashboardDrawer.vue'
import DashboardBottomNavigation from 'src/components/dashboard/DashboardBottomNavigation.vue'
import DashboardMenuDialog from 'src/components/dashboard/DashboardMenuDialog.vue'
import DashboardProfileDialog from 'src/components/dashboard/DashboardProfileDialog.vue'

const $q = useQuasar()

const router = useRouter()

const route = useRoute()

/*
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const drawerMini = ref(false)

const showMenu = ref(false)

const showProfile = ref(false)

/*
|--------------------------------------------------------------------------
| USER
|--------------------------------------------------------------------------
*/

const auth = computed(() => {
  return JSON.parse(localStorage.getItem('auth') || '{}')
})

const user = computed(() => {
  return auth.value.data || {}
})
console.log('AUTH', auth.value)
console.log('USER', user.value)
/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

const pageTitle = computed(() => {

  switch (route.path) {

    case '/dashboard':
      return 'Overview'

    case '/dashboard/games':
      return 'Games'

    case '/dashboard/products':
      return 'Products'

    case '/dashboard/transactions':
      return 'Transactions'

    case '/dashboard/users':
      return 'Users'

    case '/dashboard/admins':
      return 'Admins'

    case '/dashboard/profile':
      return 'Profile'

    default:
      return 'Dashboard'

  }

})

/*
|--------------------------------------------------------------------------
| DRAWER
|--------------------------------------------------------------------------
*/

function toggleDrawer() {

  drawerMini.value = !drawerMini.value

}

/*
|--------------------------------------------------------------------------
| THEME
|--------------------------------------------------------------------------
*/

function toggleTheme() {

  $q.dark.toggle()

}

/*
|--------------------------------------------------------------------------
| NAVIGATION
|--------------------------------------------------------------------------
*/

function goOverview() {

  router.push('/dashboard')

}

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/

function logout() {

  localStorage.removeItem('user')

  localStorage.removeItem('auth')

  router.replace('/')

}

console.log($q.screen.width)
console.log($q.screen.gt.md)
console.log($q.screen.lt.md)
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| LAYOUT
|--------------------------------------------------------------------------
*/

.dashboard-layout {
  background: var(--app-bg);
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dashboard-header {
  background: var(--app-surface);

  color: var(--app-text);

  border-bottom: 1px solid var(--app-border);
}

:deep(.q-toolbar) {
  min-height: 64px;

  padding: 0 20px;
}

:deep(.q-toolbar__title) {
  color: var(--app-text);

  font-size: 1.15rem;
  font-weight: 600;
}

.menu-button {
  display: none;

  margin-right: 12px;
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dashboard-content {
  min-height: calc(100vh - 64px);

  padding: 24px;

  background: var(--app-bg);
}

/*
|--------------------------------------------------------------------------
| DESKTOP
|--------------------------------------------------------------------------
*/

@media (min-width: 1024px) {

  .menu-button {
    display: inline-flex;
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 1023px) {

  :deep(.q-toolbar) {
    padding: 0 16px;
  }

  :deep(.q-toolbar__title) {
    font-size: 1rem;
  }

  .dashboard-content {
    padding: 16px 16px 88px;
  }

}
</style>
