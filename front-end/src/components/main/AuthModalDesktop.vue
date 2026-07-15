<template>
  <q-dialog v-model="modelValue" backdrop-filter="blur(8px)" transition-show="fade" transition-hide="fade">
    <q-card class="auth-card">

      <!-- ROLE -->
      <template v-if="step === 'role'">

        <q-card-section class="auth-header">

          <div class="auth-header-top">

            <!-- Placeholder supaya judul tetap center -->
            <div class="header-placeholder"></div>

            <div class="auth-title">
              Login
            </div>

            <q-btn flat round dense icon="close" class="header-btn" @click="modelValue = false" />

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

      <!-- FORM -->
      <template v-else>

        <q-card-section class="auth-header">

          <div class="auth-header-top">

            <q-btn flat round dense icon="arrow_back" class="header-btn" @click="goBack" />

            <div class="auth-title">

              {{ page.title }}

            </div>

            <q-btn flat round dense icon="close" class="header-btn" @click="modelValue = false" />

          </div>

          <div class="auth-subtitle">

            {{ page.subtitle }}

          </div>

        </q-card-section>

        <div class="auth-body">

          <LoginUserForm v-if="step === 'login-user'" @login-success="handleLoginSuccess"
            @change-step="step = $event" />

          <RegisterUserForm v-else-if="step === 'register'" @change-step="step = $event" />

          <LoginAdminForm v-else-if="step === 'login-admin'" @login-success="handleLoginSuccess" />

        </div>

      </template>

    </q-card>
  </q-dialog>
</template>

<script setup>
import {
  computed,
  ref,
  watch,
} from 'vue'

import LoginUserForm from './LoginUserForm.vue'
import RegisterUserForm from './RegisterUserForm.vue'
import LoginAdminForm from './LoginAdminForm.vue'

const props =
  defineProps({

    modelValue:
      Boolean,

    initialStep: {

      type:
        String,

      default:
        'role',

    },

  })

const emit =
  defineEmits([
    'update:modelValue',
    'login-success',
  ])

/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

const modelValue =
  computed({

    get:
      () => props.modelValue,

    set:
      value =>
        emit(
          'update:modelValue',
          value,
        ),

  })

/*
|--------------------------------------------------------------------------
| STEP
|--------------------------------------------------------------------------
*/

const step =
  ref(
    props.initialStep,
  )

watch(

  () =>
    props.initialStep,

  value => {

    step.value =
      value

  },

)

watch(

  () => props.modelValue,

  value => {

    if (value) {

      step.value = props.initialStep

    } else {

      step.value = 'role'

    }

  },

)

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

const pages = {

  'login-user': {

    title:
      'Login User',

    subtitle:
      'Masuk menggunakan Email, Username, atau Nomor HP.',

  },

  'login-admin': {

    title:
      'Login Admin',

    subtitle:
      'Masuk menggunakan Email atau Username.',

  },

  register: {

    title:
      'Register',

    subtitle:
      'Lengkapi data untuk membuat akun baru.',

  },

}

const page =
  computed(
    () =>
      pages[
      step.value
      ],
  )

/*
|--------------------------------------------------------------------------
| NAVIGATION
|--------------------------------------------------------------------------
*/

function goBack() {

  switch (step.value) {

    case 'register':
      step.value = 'login-user'
      break

    case 'login-user':
      step.value = 'role'
      break

    case 'login-admin':
      step.value = 'role'
      break

    default:
      step.value = 'role'

  }

}

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/

function handleLoginSuccess() {

  modelValue.value = false

  step.value = 'role'

  emit(
    'login-success',
  )

}
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| AUTH CARD
|--------------------------------------------------------------------------
*/

.auth-card {
  display: flex;
  flex-direction: column;

  width: 100%;
  max-width: 420px;

  max-height: 90vh;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  box-shadow: 0 12px 32px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.auth-header {
  padding: 24px 24px 12px;
}

.auth-header-top {
  display: grid;

  grid-template-columns: 40px 1fr 40px;

  align-items: center;
}

.auth-title {
  text-align: center;

  font-size: 1.5rem;
  font-weight: 700;

  color: var(--app-text);
}

.auth-subtitle {
  margin-top: 10px;

  text-align: center;

  font-size: .9rem;

  line-height: 1.5;

  color: var(--app-text-secondary);
}

.header-btn {
  color: var(--app-text-secondary);

  transition:
    color .2s ease,
    background-color .2s ease;
}

.header-btn:hover {
  color: var(--app-primary);

  background: var(--app-hover);
}

.auth-body {
  flex: 1;

  overflow-y: auto;
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

  border-color: var(--app-primary);

  transform: translateY(-2px);
}

.role-card:active {
  background: var(--app-active);

  transform: scale(.98);
}

.role-icon {
  font-size: 48px;

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
