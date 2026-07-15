<template>
  <q-dialog v-model="modelValue" position="bottom" backdrop-filter="blur(8px)" transition-show="slide-up"
    transition-hide="slide-down">
    <q-card class="auth-card-mobile">
      <!-- ROLE -->
      <template v-if="step === 'role'">

        <q-card-section class="auth-header">

          <div class="auth-header-top">

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
| DIALOG
|--------------------------------------------------------------------------
*/

:deep(.q-dialog__inner--bottom) {
  padding: 0;
  align-items: flex-end;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.auth-card-mobile {
  width: 100%;

  max-height: 90vh;

  display: flex;
  flex-direction: column;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border-radius: 24px 24px 0 0;
}

/*
|--------------------------------------------------------------------------
| DRAG HANDLE
|--------------------------------------------------------------------------
*/

.auth-card-mobile::before {
  content: '';

  width: 48px;
  height: 5px;

  margin: 12px auto 0;

  border-radius: 999px;

  background: var(--app-border);

  flex-shrink: 0;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.auth-header {
  flex-shrink: 0;

  padding: 16px 20px 12px;
}

.auth-header-top {
  display: grid;

  grid-template-columns: 40px 1fr 40px;

  align-items: center;
}

.header-placeholder {
  width: 40px;
  height: 40px;
}

.header-btn {
  justify-self: end;

  color: var(--app-text-secondary);

  transition:
    color .2s ease,
    background-color .2s ease;
}

.header-btn:hover {
  color: var(--app-primary);

  background: var(--app-hover);
}

.auth-title {
  text-align: center;

  font-size: 1.35rem;
  font-weight: 700;

  color: var(--app-text);
}

.auth-subtitle {
  margin-top: 8px;

  text-align: center;

  font-size: .9rem;
  line-height: 1.5;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| BODY
|--------------------------------------------------------------------------
*/

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
  display: flex;
  flex-direction: column;

  gap: 12px;

  padding: 16px 20px 20px;
}

.role-card {
  display: flex;
  align-items: center;

  gap: 14px;

  padding: 18px;

  cursor: pointer;

  background: var(--app-surface-secondary);

  border: 1px solid var(--app-border);
  border-radius: 16px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.role-card:hover {
  border-color: var(--app-primary);

  background: var(--app-hover);
}

.role-card:active {
  transform: scale(.98);
}

.role-icon {
  flex-shrink: 0;

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

:deep(.auth-form) {
  display: flex;
  flex-direction: column;
}

/*
|--------------------------------------------------------------------------
| SCROLLBAR
|--------------------------------------------------------------------------
*/

.auth-body-scroll::-webkit-scrollbar {
  width: 6px;
}

.auth-body-scroll::-webkit-scrollbar-thumb {
  background: var(--app-border);

  border-radius: 999px;
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-height: 700px) {

  .auth-card-mobile {
    max-height: 95vh;
  }

}
</style>
