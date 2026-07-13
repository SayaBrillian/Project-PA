<template>
  <q-dialog v-model="modelValue" backdrop-filter="blur(8px)" transition-show="fade" transition-hide="fade">
    <q-card class="auth-card">

      <!-- Close -->
      <q-btn flat round dense icon="close" class="close-btn" @click="modelValue = false" />

      <!-- ROLE -->
      <template v-if="step === 'role'">

        <q-card-section class="auth-header">

          <div class="auth-title">
            Login as
          </div>

          <div class="auth-subtitle">
            Pilih jenis akun yang akan digunakan
          </div>

        </q-card-section>

        <q-card-section class="role-grid">

          <div class="role-card" @click="step = 'login-user'">

            <q-icon name="person" class="role-icon" />

            <div class="role-title">
              User
            </div>

          </div>

          <div class="role-card" @click="step = 'login-admin'">

            <q-icon name="admin_panel_settings" class="role-icon" />

            <div class="role-title">
              Admin
            </div>

          </div>

        </q-card-section>

      </template>

      <!-- LOGIN USER -->
      <template v-else-if="step === 'login-user'">

        <q-card-section class="auth-header">

          <div class="auth-title">
            Login User
          </div>

        </q-card-section>

        <q-card-section class="auth-form">

          <q-input v-model="userEmail" outlined label="Email" />

          <q-input v-model="userPassword" outlined type="password" label="Password" />

        </q-card-section>

        <q-card-actions vertical class="auth-actions">

          <q-btn unelevated color="primary" label="Login" class="full-width" :loading="loadingUser"
            :disable="loadingUser" @click="loginUser" />

          <q-btn flat label="Kembali" class="auth-back-btn" @click="step = 'role'" />

          <div class="auth-switch">

            <span>
              Belum punya akun?
            </span>

            <q-btn flat dense no-caps color="primary" label="Daftar" @click="step = 'register'" />

          </div>

        </q-card-actions>

      </template>

      <!-- LOGIN ADMIN -->
      <template v-else-if="step === 'login-admin'">

        <q-card-section class="auth-header">

          <div class="auth-title">
            Login Admin
          </div>

        </q-card-section>

        <q-card-section class="auth-form">

          <q-input v-model="adminEmail" outlined label="Email" />

          <q-input v-model="adminPassword" outlined type="password" label="Password" />

        </q-card-section>

        <q-card-actions vertical class="auth-actions">

          <q-btn unelevated color="primary" label="Login" class="full-width" :loading="loadingAdmin"
            :disable="loadingAdmin" @click="loginAdmin" />

          <q-btn flat label="Kembali" class="auth-back-btn" @click="step = 'role'" />

        </q-card-actions>

      </template>

      <!-- REGISTER -->
      <template v-else-if="step === 'register'">

        <q-card-section class="auth-header">

          <div class="auth-title">
            Register
          </div>

        </q-card-section>

        <q-card-section class="auth-form">

          <q-input v-model="registerName" outlined label="Nama Lengkap" />

          <q-input v-model="registerEmail" outlined label="Email" />

          <q-input v-model="registerPassword" outlined type="password" label="Password" />

        </q-card-section>

        <q-card-actions vertical class="auth-actions">

          <q-btn unelevated color="primary" label="Daftar" class="full-width" :loading="loadingRegister"
            :disable="loadingRegister" @click="registerUser" />

          <q-btn flat label="Kembali" class="auth-back-btn" @click="step = 'role'" />

          <div class="auth-switch">

            <span>
              Sudah punya akun?
            </span>

            <q-btn flat dense no-caps color="primary" label="Masuk" @click="step = 'login-user'" />

          </div>

        </q-card-actions>

      </template>

    </q-card>
  </q-dialog>
</template>

<script setup>
import api from 'src/axios'
import { computed, ref, watch } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const props = defineProps({
  modelValue: Boolean,
  initialStep: {
    type: String,
    default: 'role'
  }
})

const emit = defineEmits([
  'update:modelValue',
  'login-success'
])

const modelValue = computed({
  get: () => props.modelValue,
  set: value => emit('update:modelValue', value)
})

const step = ref(props.initialStep)

watch(
  () => props.initialStep,
  value => {
    step.value = value
  }
)

watch(
  () => props.modelValue,
  value => {
    if (value) {
      step.value = props.initialStep
    }
  }
)

const userEmail = ref('')
const userPassword = ref('')

const adminEmail = ref('')
const adminPassword = ref('')

const registerName = ref('')
const registerEmail = ref('')
const registerPassword = ref('')

async function registerUser() {
  try {
    const response = await api.post(
      '/api/auth/register',
      {
        name: registerName.value,
        email: registerEmail.value,
        password: registerPassword.value,
      }
    )

    console.log(response.data)

    alert('Registrasi berhasil')

    registerName.value = ''
    registerEmail.value = ''
    registerPassword.value = ''

    step.value = 'login-user'

  } catch (error) {
    console.error(error)

    alert(
      error.response?.data?.message ||
      'Registrasi gagal'
    )
  }
}

async function loginUser() {
  try {
    const response = await api.post(
      '/api/auth/login-user',
      {
        email: userEmail.value,
        password: userPassword.value,
      }
    )

    localStorage.setItem(
      'auth',
      JSON.stringify({
        type: 'user',
        token: response.data.token,
        data: response.data.user
      })
    )

    emit('login-success')
    userEmail.value = ''
    userPassword.value = ''
    modelValue.value = false

    router.push('/user')

  } catch (error) {
    console.error(error)

    alert(
      error.response?.data?.message ||
      'Login gagal'
    )
  }
}

async function loginAdmin() {
  try {
    const response = await api.post(
      '/api/auth/login-admin',
      {
        email: adminEmail.value,
        password: adminPassword.value,
      }
    )

    localStorage.setItem(
      'auth',
      JSON.stringify({
        type: 'admin',
        token: response.data.token,
        data: response.data.admin
      })
    )

    emit('login-success')
    adminEmail.value = ''
    adminPassword.value = ''
    modelValue.value = false

    router.push('/dashboard')

  } catch (error) {
    console.error(error)

    alert(
      error.response?.data?.message ||
      'Login admin gagal'
    )
  }
}
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| AUTH CARD
|--------------------------------------------------------------------------
*/

.auth-card {
  position: relative;

  width: 100%;
  max-width: 420px;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  box-shadow: 0 12px 32px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| CLOSE BUTTON
|--------------------------------------------------------------------------
*/

.close-btn {
  position: absolute;

  top: 12px;
  right: 12px;

  z-index: 10;

  color: var(--app-text-secondary);

  transition:
    background-color .2s ease,
    color .2s ease;
}

.close-btn:hover {
  background: var(--app-hover);

  color: var(--app-text);
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.auth-header {
  padding: 28px 24px 8px;

  text-align: center;
}

.auth-title {
  font-size: 1.5rem;
  font-weight: 700;

  color: var(--app-text);
}

.auth-subtitle {
  margin-top: 8px;

  font-size: .9rem;
  line-height: 1.5;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| ROLE
|--------------------------------------------------------------------------
*/

.role-grid {
  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 16px;

  padding: 24px;
}

.role-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  gap: 12px;

  padding: 24px 16px;

  cursor: pointer;

  background: var(--app-background);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  transition:
    background-color .2s ease,
    border-color .2s ease,
    transform .2s ease;
}

.role-card:hover {
  background: var(--app-hover);

  transform: translateY(-3px);
}

.role-card:active {
  background: var(--app-active);

  transform: scale(.98);
}

.role-icon {
  font-size: 56px;

  color: var(--app-primary);
}

.role-title {
  font-size: 1rem;
  font-weight: 600;

  color: var(--app-text);
}

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

.auth-form {
  display: flex;
  flex-direction: column;

  gap: 16px;

  padding: 20px 24px;
}

/*
|--------------------------------------------------------------------------
| ACTIONS
|--------------------------------------------------------------------------
*/

.auth-actions {
  padding: 20px 24px 24px;
}

.auth-back-btn {
  margin-top: 8px;
}

/*
|--------------------------------------------------------------------------
| SWITCH
|--------------------------------------------------------------------------
*/

.auth-switch {
  display: flex;
  justify-content: center;
  align-items: center;

  gap: 4px;

  margin-top: 16px;

  font-size: .9rem;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| INPUT
|--------------------------------------------------------------------------
*/

:deep(.q-field) {
  border-radius: 14px;
}

:deep(.q-field__control) {
  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

:deep(.q-btn) {
  border-radius: 12px;

  transition:
    transform .2s ease,
    background-color .2s ease;
}

:deep(.q-btn:active) {
  transform: scale(.98);
}

/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

:deep(.q-dialog__backdrop) {
  backdrop-filter: blur(8px);
}
</style>
