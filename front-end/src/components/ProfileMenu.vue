<template>
  <div class="profile-wrapper">
    <q-btn round flat icon="account_circle" class="profile-btn" @mouseenter="openMenu" />

    <q-menu v-model="showMenu" anchor="bottom right" self="top right" :offset="[0, 12]" no-focus no-refocus
      transition-show="jump-down" transition-hide="jump-up" persistent @mouseenter="openMenu" @mouseleave="closeMenu">
      <q-card class="profile-card">

        <!-- Kondisi belum login -->
        <template v-if="!isLoggedIn">
          <q-card-section class="text-center">

            <q-avatar size="64px" color="primary" text-color="white">
              ?
            </q-avatar>

            <div class="text-h6 q-mt-md">
              Selamat Datang
            </div>

            <div class="text-caption text-grey-5">
              Masuk untuk melanjutkan
            </div>

          </q-card-section>

          <q-card-actions vertical class="q-pa-md">

            <q-btn unelevated color="accent" label="Masuk" class="full-width"
              @click="authStep = 'role'; showAuth = true" />

            <q-btn flat color="white" label="Daftar" class="full-width q-mt-sm"
              @click="authStep = 'register'; showAuth = true" />

          </q-card-actions>
        </template>

        <!-- Kondisi sudah login -->
        <template v-else>
          <q-card-section class="row items-center no-wrap">

            <q-avatar size="48px">
              <img src="https://i.pravatar.cc/150?img=12">
            </q-avatar>

            <div class="q-ml-md">
              <div class="text-weight-medium">
                {{ user?.name }}
              </div>

              <div class="text-caption text-grey-5">
                {{ user?.email }}
              </div>
            </div>

          </q-card-section>

          <q-separator dark />

          <q-list padding>

            <q-item clickable v-close-popup to="/dashboard">
              <q-item-section avatar>
                <q-icon name="dashboard" />
              </q-item-section>

              <q-item-section>
                Dashboard
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup>
              <q-item-section avatar>
                <q-icon name="person" />
              </q-item-section>

              <q-item-section>
                Profil
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup @click="logout">
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
  </div>
  <AuthModal v-model="showAuth" :initial-step="authStep" @login-success="handleLoginSuccess" />
</template>

<script setup>
import api from 'src/axios'
import { ref, onMounted } from 'vue'
import AuthModal from './AuthModal.vue'

const showAuth = ref(false)
const authStep = ref('role')

const showMenu = ref(false)
const user = ref(null)
const isLoggedIn = ref(false)

async function loadAuth() {
  try {
    const auth = JSON.parse(
      localStorage.getItem('auth')
    )

    if (!auth?.token) {
      return
    }

    await api.get('/api/auth/me')

    user.value = auth.data
    isLoggedIn.value = true

  } catch (error) {
    console.error(error)

    localStorage.removeItem('auth')

    user.value = null
    isLoggedIn.value = false
  }
}

onMounted(() => {
  loadAuth()
})

function logout() {
  localStorage.removeItem('auth')

  user.value = null
  isLoggedIn.value = false
}

function handleLoginSuccess() {
  loadAuth()
}
// Nanti ganti dengan state dari Pinia atau API
let timeout

function openMenu() {
  clearTimeout(timeout)
  showMenu.value = true
}

function closeMenu() {
  timeout = setTimeout(() => {
    showMenu.value = false
  }, 150)
}


</script>

<style lang="scss" scoped>
.profile-wrapper {
  display: flex;
  align-items: center;
}

.profile-btn {
  color: rgba(255, 255, 255, 0.85);
  transition: all 0.25s ease;

  &:hover {
    color: $sakura;
    background: rgba($sakura, 0.08);
  }
}

.profile-card {
  width: 280px;

  background: linear-gradient(135deg,
      rgba($dark, 0.95),
      rgba($secondary, 0.92));

  backdrop-filter: blur(18px);

  color: white;

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 20px;

  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.35),
    0 0 24px rgba($sakura, 0.1);
}

:deep(.q-item) {
  border-radius: 12px;
  transition: background-color 0.2s ease;
}

:deep(.q-item:hover) {
  background: rgba($sakura, 0.08);
}
</style>
