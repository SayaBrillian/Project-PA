<template>
  <q-dialog v-model="modelValue" backdrop-filter="blur(8px)" transition-show="fade" transition-hide="fade">
    <q-card class="auth-card">

      <!-- PILIH ROLE -->
      <template v-if="step === 'role'">
        <q-card-section class="text-center q-pb-none">
          <div class="text-h5 text-weight-bold">
            Login as
          </div>
          <div class="text-grey-5 q-mt-sm">
            Pilih jenis akun yang akan digunakan
          </div>
        </q-card-section>

        <q-card-section class="role-grid">
          <div class="role-card" @click="step = 'login-user'">
            <q-icon name="person" size="60px" class="role-icon" />
            <div class="text-subtitle1 text-weight-medium">
              User
            </div>
          </div>
          <div class="role-card" @click="step = 'login-admin'">
            <q-icon name="admin_panel_settings" size="60px" class="role-icon" />
            <div class="text-subtitle1 text-weight-medium">
              Admin
            </div>
          </div>
        </q-card-section>
      </template>

      <!-- LOGIN USER -->
      <template v-else-if="step === 'login-user'">
        <q-card-section>
          <div class="text-h5">Login User</div>
        </q-card-section>

        <q-card-section class="column q-gutter-md">
          <q-input v-model="userEmail" dark outlined label="Email" />
          <q-input v-model="userPassword" dark outlined type="password" label="Password" />
        </q-card-section>

        <q-card-actions vertical class="q-pa-md">
          <q-btn unelevated color="accent" label="Login" class="full-width" @click="loginUser" />
          <q-btn flat color="white" label="Kembali" @click="step = 'role'" />
          <div class="auth-switch">
            <span>Belum punya akun?</span>
            <q-btn flat dense no-caps color="accent" label="Daftar" @click="step = 'register'" />
          </div>
        </q-card-actions>
      </template>

      <!-- LOGIN ADMIN -->
      <template v-else-if="step === 'login-admin'">
        <q-card-section>
          <div class="text-h5">Login Admin</div>
        </q-card-section>

        <q-card-section class="column q-gutter-md">
          <q-input v-model="adminEmail" dark outlined label="Email" />
          <q-input v-model="adminPassword" dark outlined type="password" label="Password" />
        </q-card-section>

        <q-card-actions vertical class="q-pa-md">
          <q-btn unelevated color="accent" label="Login" @click="loginAdmin" />
          <q-btn flat color="white" label="Kembali" @click="step = 'role'" />
        </q-card-actions>
      </template>

      <!-- REGISTER -->
      <template v-else-if="step === 'register'">
        <q-card-section>
          <div class="text-h5">Register</div>
        </q-card-section>

        <q-card-section class="column q-gutter-md">
          <q-input v-model="registerName" dark outlined label="Nama Lengkap" />
          <q-input v-model="registerEmail" dark outlined label="Email" />
          <q-input v-model="registerPassword" dark outlined type="password" label="Password" />
        </q-card-section>

        <q-card-actions vertical class="q-pa-md">
          <q-btn unelevated color="accent" label="Daftar" @click="registerUser" />
          <div class="auth-switch">
            <span>Sudah punya akun?</span>
            <q-btn flat dense no-caps color="accent" label="Masuk" @click="step = 'login-user'" />
          </div>
        </q-card-actions>
      </template>
    </q-card>
  </q-dialog>
</template>

<script setup>
import api from 'src/axios'
import { computed, ref, watch } from 'vue'

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
.auth-card {
  width: 100%;
  max-width: 420px;

  background: linear-gradient(135deg,
      rgba($dark, 0.95),
      rgba($secondary, 0.92));

  color: white;

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 24px;

  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.4),
    0 0 24px rgba($sakura, 0.08);
}

.role-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;

  padding: 24px;
}

.role-card {
  padding: 24px 16px;

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 20px;

  background: rgba(255, 255, 255, 0.03);

  text-align: center;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  text-align: center;
  transition:
    transform 0.25s ease,
    background-color 0.25s ease,
    border-color 0.25s ease;
}

.role-card:hover {
  transform: translateY(-4px);

  background: rgba($sakura, 0.08);
  border-color: rgba($sakura, 0.3);
}

.role-icon {
  display: block;
  margin-bottom: 12px;

  color: $sakura;
}

.auth-switch {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 4px;

  margin-top: 16px;

  color: rgba(255, 255, 255, 0.7);
  font-size: 14px;
}
</style>
