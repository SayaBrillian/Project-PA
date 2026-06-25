<template>

  <div class="profile-wrapper">

    <q-btn
      round
      flat
      class="profile-btn"
      @mouseenter="openMenu"
    >

      <q-avatar
        size="38px"
        color="accent"
        text-color="white"
      >

        <template v-if="isLoggedIn">

          {{
            user?.name?.charAt(0)
          }}

        </template>

        <template v-else>

          <q-icon
            name="person"
          />

        </template>

      </q-avatar>

    </q-btn>

    <q-menu
      v-model="showMenu"
      anchor="bottom right"
      self="top right"
      :offset="[0,12]"
      no-focus
      no-refocus
      persistent
      transition-show="jump-down"
      transition-hide="jump-up"
      @mouseenter="openMenu"
      @mouseleave="closeMenu"
    >

      <q-card class="profile-card">

        <!-- GUEST -->

        <template v-if="!isLoggedIn">

          <q-card-section
            class="guest-section"
          >

            <q-avatar
              size="72px"
              color="accent"
              text-color="white"
            >
              ?
            </q-avatar>

            <div class="guest-title">
              Welcome
            </div>

            <div class="guest-subtitle">
              Login untuk melanjutkan
            </div>

          </q-card-section>

          <q-card-actions
            vertical
            class="q-pa-md"
          >

            <q-btn
              unelevated
              color="accent"
              label="Masuk"
              class="full-width"
              @click="
                authStep = 'role';
                showAuth = true
              "
            />

            <q-btn
              flat
              color="white"
              label="Daftar"
              class="full-width q-mt-sm"
              @click="
                authStep = 'register';
                showAuth = true
              "
            />

          </q-card-actions>

        </template>

        <!-- USER / ADMIN -->

        <template v-else>

          <q-card-section
            class="profile-header"
          >

            <q-avatar
              size="64px"
              color="accent"
              text-color="white"
            >
              {{
                user?.name?.charAt(0)
              }}
            </q-avatar>

            <div class="profile-info">

              <div class="profile-name">
                {{ user?.name }}
              </div>

              <div class="profile-email">
                {{ user?.email }}
              </div>

              <q-badge
                class="role-badge"
                color="primary"
              >
                {{ roleLabel }}
              </q-badge>

            </div>

          </q-card-section>

          <q-separator dark />

          <q-list class="menu-list">

            <q-item
              clickable
              v-close-popup
              :to="dashboardRoute"
            >

              <q-item-section avatar>
                <q-icon
                  name="dashboard"
                />
              </q-item-section>

              <q-item-section>
                {{ dashboardLabel }}
              </q-item-section>

            </q-item>

            <q-item
              clickable
              v-close-popup
            >

              <q-item-section avatar>
                <q-icon
                  name="person"
                />
              </q-item-section>

              <q-item-section>
                Profile
              </q-item-section>

            </q-item>

            <q-separator
              dark
              inset
            />

            <q-item
              clickable
              v-close-popup
              class="logout-item"
              @click="logout"
            >

              <q-item-section avatar>

                <q-icon
                  name="logout"
                />

              </q-item-section>

              <q-item-section>

                Logout

              </q-item-section>

            </q-item>

          </q-list>

        </template>

      </q-card>

    </q-menu>

  </div>

  <AuthModal
    v-model="showAuth"
    :initial-step="authStep"
    @login-success="handleLoginSuccess"
  />

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

import api from 'src/axios'

import AuthModal from './AuthModal.vue'

const router =
  useRouter()

const showAuth =
  ref(false)

const authStep =
  ref('role')

const showMenu =
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
| AUTH
|--------------------------------------------------------------------------
*/

async function loadAuth() {
  try {

    const auth = JSON.parse(
      localStorage.getItem('auth')
    )

    if (!auth?.token) {
      return
    }

    await api.get('/api/auth/me')

    user.value = {
      ...auth.data,
      type: auth.type,
    }

    isLoggedIn.value = true

  } catch (error) {

    console.error(error)

    localStorage.removeItem('auth')

    user.value = null

    isLoggedIn.value = false

  }
}

const logout =
  () => {

    localStorage.removeItem(
      'auth'
    )

    user.value =
      null

    isLoggedIn.value =
      false

    router.push('/')

  }

const handleLoginSuccess =
  () => {

    loadAuth()

  }

/*
|--------------------------------------------------------------------------
| MENU
|--------------------------------------------------------------------------
*/

let timeout

const openMenu =
  () => {

    clearTimeout(
      timeout
    )

    showMenu.value =
      true

  }

const closeMenu =
  () => {

    timeout =
      setTimeout(
        () => {

          showMenu.value =
            false

        },
        150
      )

  }

onMounted(() => {

  loadAuth()

})

</script>

<style lang="scss" scoped>

.profile-wrapper {
  display: flex;
  align-items: center;
}

/*
|--------------------------------------------------------------------------
| PROFILE BUTTON
|--------------------------------------------------------------------------
*/

.profile-btn {
  padding: 0;

  transition:
    transform .25s ease;
}

.profile-btn:hover {
  transform: scale(1.05);
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.profile-card {
  width: 340px;

  overflow: hidden;

  background:
    linear-gradient(
      135deg,
      rgba($dark,.97),
      rgba($secondary,.92)
    );

  backdrop-filter: blur(20px);

  border: 1px solid rgba(
    $sakura,
    .15
  );

  box-shadow:
    0 20px 50px rgba(
      0,
      0,
      0,
      .35
    );
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

  font-size: 1.25rem;
  font-weight: 700;

  color: white;
}

.guest-subtitle {
  margin-top: 8px;

  color: rgba(
    255,
    255,
    255,
    .65
  );

  font-size: .9rem;
}

/*
|--------------------------------------------------------------------------
| PROFILE HEADER
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

  color: white;
}

.profile-email {
  font-size: .85rem;

  color: rgba(
    255,
    255,
    255,
    .65
  );

  word-break: break-all;
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
  color: white;
}

:deep(.q-item) {
  min-height: 52px;

  border-radius: 14px;

  transition:
    background .2s ease,
    transform .2s ease;
}

:deep(.q-item:hover) {
  background: rgba(
    $sakura,
    .08
  );

  transform: translateX(4px);
}

:deep(.q-item__label) {
  color: white;
}

:deep(.q-item .q-icon) {
  color: rgba(
    255,
    255,
    255,
    .8
  );
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
  color: #ef4444;
}

/*
|--------------------------------------------------------------------------
| SCROLL FIX
|--------------------------------------------------------------------------
*/

:deep(.q-menu) {
  overflow: visible;
}

</style>