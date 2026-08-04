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

    <DashboardDrawer v-if="$q.screen.gt.sm" :mini="drawerMini" :user="user" :role-label="roleLabel"
      :navigation-items="navigationItems" :profile-route="profileRoute" :store-route="storeRoute" @logout="logout" />

    <!-- CONTENT -->

    <q-page-container>

      <div class="dashboard-content">

        <router-view />

      </div>

    </q-page-container>

    <!-- MOBILE NAVIGATION -->

    <DashboardBottomNavigation @overview="goOverview" @menu="showMenu = true" @profile="showProfile = true" />

    <!-- MOBILE MENU -->

    <DashboardMenuDialog v-model="showMenu" :user="user" :navigation-items="navigationItems" />

    <!-- MOBILE PROFILE -->

    <DashboardProfileDialog v-model="showProfile" :user="user" :role-label="roleLabel" :profile-route="profileRoute"
      :store-route="storeRoute" @logout="logout" />

  </q-layout>

</template>

<script setup>
import {
  computed,
  ref
} from 'vue'

import {
  useQuasar
} from 'quasar'

import {
  useRoute,
  useRouter
} from 'vue-router'

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
| AUTH
|--------------------------------------------------------------------------
*/

const auth = computed(() => {

  return JSON.parse(
    localStorage.getItem('auth') || '{}'
  )

})

const user = computed(() => {

  return auth.value.data || {}

})

/*
|--------------------------------------------------------------------------
| NAVIGATION
|--------------------------------------------------------------------------
*/

const navigationItems = [

  {
    label: 'Overview',
    icon: 'dashboard',
    to: '/dashboard',
    roles: ['admin', 'super_admin'],
  },

  {
    label: 'Games',
    icon: 'sports_esports',
    to: '/dashboard/games',
    roles: ['admin', 'super_admin'],
  },

  {
    label: 'Products',
    icon: 'inventory_2',
    to: '/dashboard/products',
    roles: ['admin', 'super_admin'],
  },

  {
    label: 'Transactions',
    icon: 'receipt_long',
    to: '/dashboard/transactions',
    roles: ['admin', 'super_admin'],
  },

  {
    label: 'Users',
    icon: 'group',
    to: '/dashboard/users',
    roles: ['admin', 'super_admin'],
  },

  {
    label: 'Admins',
    icon: 'admin_panel_settings',
    to: '/dashboard/admins',
    roles: ['super_admin'],
  },

]

/*
|--------------------------------------------------------------------------
| PROFILE
|--------------------------------------------------------------------------
*/

const roleLabel = computed(() => {

  if (user.value.role === 'super_admin') {

    return 'Super Admin'

  }

  if (user.value.role === 'admin') {

    return 'Admin'

  }

  return 'Member'

})

const profileRoute =
  '/dashboard/profile'

const storeRoute =
  '/'

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
| LOGOUT
|--------------------------------------------------------------------------
*/

function logout() {

  localStorage.removeItem('auth')

  localStorage.removeItem('user')

  router.replace('/')

}
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
