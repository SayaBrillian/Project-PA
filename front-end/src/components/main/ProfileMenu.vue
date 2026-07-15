<template>

  <!-- Desktop -->
  <template v-if="$q.screen.gt.sm">

    <div class="profile-wrapper">

      <q-btn round flat class="profile-btn">
        <q-avatar size="38px" color="primary" text-color="white" class="profile-avatar">
          <template v-if="isLoggedIn">
            {{ avatarLetter }}
          </template>

          <template v-else>
            <q-icon name="person" />
          </template>
        </q-avatar>

        <q-menu v-model="showMenu" anchor="bottom right" self="top right" :offset="[0, 12]" transition-show="jump-down"
          transition-hide="jump-up">

          <q-card class="profile-card">

            <!-- Theme -->
            <q-item class="theme-item">

              <q-item-section avatar>

                <q-icon :name="$q.dark.isActive
                  ? 'dark_mode'
                  : 'light_mode'" />

              </q-item-section>

              <q-item-section>

                Dark Mode

              </q-item-section>

              <q-item-section side>

                <q-toggle color="primary" :model-value="$q.dark.isActive" @update:model-value="toggleTheme" />

              </q-item-section>

            </q-item>

            <q-separator />

            <!-- GUEST -->
            <template v-if="!isLoggedIn">

              <q-card-section class="guest-section">

                <q-avatar size="72px" color="accent" text-color="white">
                  <q-icon name="person" size="36px" />
                </q-avatar>

                <div class="guest-title">
                  Welcome!
                </div>

                <div class="guest-subtitle">
                  Masuk atau daftar untuk menikmati fitur
                  EI Gaming Store.
                </div>

              </q-card-section>

              <q-card-actions vertical class="guest-actions">

                <q-btn unelevated color="accent" label="Masuk" class="full-width" @click="
                  showMenu = false;
                authStep = 'role';
                showAuth = true;
                " />

                <q-btn flat label="Daftar" class="full-width q-mt-sm" @click="
                  showMenu = false;
                authStep = 'register';
                showAuth = true;
                " />

              </q-card-actions>

            </template>

            <!-- USER -->
            <template v-else>

              <!-- User Information -->
              <q-card-section class="profile-header">

                <q-avatar size="64px" color="primary" text-color="white" class="profile-avatar profile-avatar-lg">
                  {{ avatarLetter }}
                </q-avatar>

                <div class="profile-info">

                  <div class="profile-name">
                    {{ user?.name }}
                  </div>

                  <div class="profile-email">
                    {{ user?.email }}
                  </div>

                  <q-badge color="primary" class="role-badge">
                    {{ roleLabel }}
                  </q-badge>

                </div>

              </q-card-section>

              <q-separator />

              <!-- Menu -->
              <q-list class="menu-list">

                <q-item clickable v-close-popup :to="dashboardRoute">

                  <q-item-section avatar>
                    <q-icon name="dashboard" />
                  </q-item-section>

                  <q-item-section>
                    {{ dashboardLabel }}
                  </q-item-section>

                </q-item>

                <q-item clickable v-close-popup>

                  <q-item-section avatar>
                    <q-icon name="person" />
                  </q-item-section>

                  <q-item-section>
                    Profile
                  </q-item-section>

                </q-item>

                <q-separator inset />

                <q-item clickable v-close-popup class="logout-item" @click="logout">

                  <q-item-section avatar>
                    <q-icon name="logout" />
                  </q-item-section>

                  <q-item-section>
                    Logout
                  </q-item-section>

                </q-item>

              </q-list>

            </template>

          </q-card>

        </q-menu>

      </q-btn>

    </div>

  </template>

  <!-- Mobile -->
  <template v-else>

    <div class="profile-wrapper">

      <!-- Bottom Navigation Button -->
      <q-btn flat stack no-caps icon="account_circle" label="Profile" class="mobile-nav-link"
        @click="showDialog = true" />

      <!-- Dialog -->
      <q-dialog v-model="showDialog" position="bottom">

        <q-card class="mobile-profile-card">
          <!-- Theme -->
          <q-item class="theme-item">

            <q-item-section avatar>
              <q-icon :name="$q.dark.isActive
                ? 'dark_mode'
                : 'light_mode'" />
            </q-item-section>

            <q-item-section>
              Dark Mode
            </q-item-section>

            <q-item-section side>
              <q-toggle color="primary" :model-value="$q.dark.isActive" @update:model-value="toggleTheme" />
            </q-item-section>

          </q-item>

          <q-separator />

          <!-- GUEST -->
          <template v-if="!isLoggedIn">

            <q-card-section class="guest-section">

              <q-avatar size="72px" color="accent" text-color="white">
                <q-icon name="person" size="36px" />
              </q-avatar>

              <div class="guest-title">
                Welcome!
              </div>

              <div class="guest-subtitle">
                Masuk atau daftar untuk menikmati fitur
                EI Gaming Store.
              </div>

            </q-card-section>

            <q-card-actions vertical class="guest-actions">

              <q-btn unelevated color="accent" label="Masuk" class="full-width" @click="
                showDialog = false;
              authStep = 'role';
              showAuth = true;
              " />

              <q-btn flat label="Daftar" class="full-width q-mt-sm" @click="
                showDialog = false;
              authStep = 'register';
              showAuth = true;
              " />

            </q-card-actions>

            <q-separator />

            <!-- Mobile Menu -->

            <q-list class="menu-list">

              <q-item clickable :to="'/help'" @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="help" />
                </q-item-section>

                <q-item-section>
                  Help
                </q-item-section>

              </q-item>

              <q-item clickable :to="'/about'" @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="info" />
                </q-item-section>

                <q-item-section>
                  About Us
                </q-item-section>

              </q-item>

            </q-list>

          </template>

          <!-- User -->
          <!-- USER -->
          <template v-else>

            <!-- User Information -->
            <q-card-section class="profile-header">

              <q-avatar size="64px" color="primary" text-color="white" class="profile-avatar profile-avatar-lg">
                {{ avatarLetter }}
              </q-avatar>

              <div class="profile-info">

                <div class="profile-name">
                  {{ user?.name }}
                </div>

                <div class="profile-email">
                  {{ user?.email }}
                </div>

                <q-badge color="primary" class="role-badge">
                  {{ roleLabel }}
                </q-badge>

              </div>

            </q-card-section>

            <q-separator />

            <q-list class="menu-list">

              <!-- Dashboard -->

              <q-item clickable :to="dashboardRoute" @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="dashboard" />
                </q-item-section>

                <q-item-section>
                  {{ dashboardLabel }}
                </q-item-section>

              </q-item>

              <!-- Profile -->

              <q-item clickable @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="person" />
                </q-item-section>

                <q-item-section>
                  My Profile
                </q-item-section>

              </q-item>

              <q-separator inset />

              <!-- Help -->

              <q-item clickable to="/help" @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="help" />
                </q-item-section>

                <q-item-section>
                  Help
                </q-item-section>

              </q-item>

              <!-- About -->

              <q-item clickable to="/about" @click="showDialog = false">

                <q-item-section avatar>
                  <q-icon name="info" />
                </q-item-section>

                <q-item-section>
                  About Us
                </q-item-section>

              </q-item>

              <q-separator inset />

              <!-- Logout -->

              <q-item clickable class="logout-item" @click="
                showDialog = false;
              logout();
              ">

                <q-item-section avatar>
                  <q-icon name="logout" />
                </q-item-section>

                <q-item-section>
                  Logout
                </q-item-section>

              </q-item>

            </q-list>

          </template>

        </q-card>

      </q-dialog>

    </div>

  </template>

  <component :is="AuthModal" v-model="showAuth" :initial-step="authStep" @login-success="handleLoginSuccess" />

</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
} from 'vue'

import {
  useRouter,
} from 'vue-router'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

import AuthModalDesktop from './AuthModalDesktop.vue'
import AuthModalMobile from './AuthModalMobile.vue'

const AuthModal =
  computed(() =>

    $q.screen.gt.sm
      ? AuthModalDesktop
      : AuthModalMobile

  )

const router =
  useRouter()

const $q =
  useQuasar()

const showAuth =
  ref(false)

const authStep =
  ref('role')

const showMenu =
  ref(false)

const showDialog =
  ref(false)

const user =
  ref(null)

const isLoggedIn =
  ref(false)

/*
|--------------------------------------------------------------------------
| ROLE
|--------------------------------------------------------------------------
*/

const roleLabel =
  computed(() => {

    if (
      user.value?.type === 'admin'
    ) {

      return 'ADMIN'

    }

    return 'USER'

  })

const dashboardLabel =
  computed(() => {

    if (
      user.value?.type === 'admin'
    ) {

      return 'Admin Dashboard'

    }

    return 'Dashboard'

  })

const dashboardRoute =
  computed(() => {

    if (
      user.value?.type === 'admin'
    ) {

      return '/dashboard'

    }

    return '/user'

  })

/*
|--------------------------------------------------------------------------
| THEME
|--------------------------------------------------------------------------
*/

const loadTheme =
  () => {

    const theme =
      localStorage.getItem(
        'theme'
      )

    if (
      theme === 'dark'
    ) {

      $q.dark.set(true)

    } else if (
      theme === 'light'
    ) {

      $q.dark.set(false)

    }

  }

const toggleTheme =
  (value) => {

    $q.dark.set(
      value
    )

    localStorage.setItem(
      'theme',
      value
        ? 'dark'
        : 'light'
    )

  }

const avatarLetter =
  computed(() => {

    const text =

      user.value?.name ||

      user.value?.username ||

      user.value?.email ||

      ''

    return text
      ? text.charAt(0).toUpperCase()
      : 'P'

  })

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/

async function loadAuth() {

  try {

    const auth =
      JSON.parse(
        localStorage.getItem('auth')
      )

    if (!auth?.token) {

      user.value = null

      isLoggedIn.value = false

      return

    }

    let response

    if (auth.type === 'user') {

      response =
        await api.get('/api/user/me')

      user.value = response.data.user

    } else if (auth.type === 'admin') {

      response =
        await api.get('/api/admin/me')

      user.value = response.data.admin

    } else {

      throw new Error('Tipe akun tidak valid')

    }

    isLoggedIn.value = true

  } catch (error) {

    console.error(error)

    localStorage.removeItem('auth')

    user.value = null

    isLoggedIn.value = false

  }

}

/*
|--------------------------------------------------------------------------
| LOGOUT
|--------------------------------------------------------------------------
*/

function logout() {

  localStorage.removeItem('auth')

  user.value = null

  isLoggedIn.value = false

  showMenu.value = false

  showDialog.value = false

  authStep.value = 'role'

  showAuth.value = false

  router.replace('/')

}

const handleLoginSuccess =
  () => {

    loadAuth()

  }

/*
|--------------------------------------------------------------------------
| LIFECYCLE
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadTheme()

  loadAuth()

})
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| PROFILE BUTTON
|--------------------------------------------------------------------------
*/

.profile-wrapper {
  display: flex;
  align-items: center;
}

.profile-btn {
  padding: 0;

  color: var(--app-text);

  border-radius: 50%;

  transition:
    background-color .2s ease,
    color .2s ease;
}

.profile-btn:hover {
  background: var(--app-hover);
}

.profile-btn:active {
  background: var(--app-active);
}

.mobile-nav-link {
  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| PROFILE AVATAR
|--------------------------------------------------------------------------
*/

.profile-avatar {
  font-weight: 700;

  user-select: none;
}

.profile-avatar-lg {
  font-size: 1.5rem;
}

/*
|--------------------------------------------------------------------------
| DESKTOP PROFILE CARD
|--------------------------------------------------------------------------
*/

.profile-card {
  width: 340px;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  box-shadow: 0 12px 32px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| MOBILE PROFILE CARD
|--------------------------------------------------------------------------
*/

.mobile-profile-card {
  width: 100%;

  max-height: 85vh;

  overflow-y: auto;

  padding-bottom: env(safe-area-inset-bottom);

  background: var(--app-surface);
  color: var(--app-text);

  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
}

.mobile-profile-card::-webkit-scrollbar {
  display: none;
}

.mobile-profile-card {
  scrollbar-width: none;
}

:deep(.q-dialog__inner--bottom) {
  padding: 0;
}

/*
|--------------------------------------------------------------------------
| THEME
|--------------------------------------------------------------------------
*/

.theme-item {
  min-height: 58px;
}

.theme-item :deep(.q-icon) {
  color: var(--app-primary);
}

.theme-item :deep(.q-toggle) {
  margin-right: 4px;
}

/*
|--------------------------------------------------------------------------
| GUEST
|--------------------------------------------------------------------------
*/

.guest-section {
  display: flex;
  flex-direction: column;
  align-items: center;

  padding: 32px 24px;

  text-align: center;
}

.guest-title {
  margin-top: 16px;

  font-size: 1.2rem;
  font-weight: 700;

  color: var(--app-text);
}

.guest-subtitle {
  margin-top: 8px;

  line-height: 1.5;

  font-size: .9rem;

  color: var(--app-text-secondary);
}

.guest-actions {
  padding: 20px;
}

/*
|--------------------------------------------------------------------------
| USER
|--------------------------------------------------------------------------
*/

.profile-header {
  display: flex;
  align-items: center;

  gap: 16px;

  padding: 24px;
}

.profile-info {
  flex: 1;

  display: flex;
  flex-direction: column;

  gap: 4px;
}

.profile-name {
  font-size: 1rem;
  font-weight: 700;

  color: var(--app-text);
}

.profile-email {
  font-size: .85rem;

  color: var(--app-text-secondary);

  word-break: break-word;
}

.role-badge {
  width: fit-content;

  margin-top: 6px;

  font-weight: 700;

  letter-spacing: .5px;
}

/*
|--------------------------------------------------------------------------
| MENU
|--------------------------------------------------------------------------
*/

.menu-list {
  padding: 8px;
}

:deep(.q-item) {
  min-height: 52px;

  border-radius: 14px;

  transition:
    background-color .2s ease,
    transform .2s ease;
}

:deep(.q-item:hover) {
  background: var(--app-hover);

  transform: translateX(4px);
}

:deep(.q-item:active) {
  background: var(--app-active);
}

:deep(.q-item__label) {
  color: var(--app-text);
}

:deep(.q-item .q-icon) {
  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| LOGOUT
|--------------------------------------------------------------------------
*/

.logout-item {
  margin-top: 4px;
}

.logout-item :deep(.q-icon) {
  color: var(--q-negative);
}

/*
|--------------------------------------------------------------------------
| SEPARATOR
|--------------------------------------------------------------------------
*/

:deep(.q-separator) {
  background: var(--app-border);
}
</style>
