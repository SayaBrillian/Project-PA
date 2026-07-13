<template>

  <q-form
    ref="formRef"
    class="auth-form"
    @submit.prevent="loginAdmin"
  >

    <q-input
      v-model="credential"
      outlined
      clearable
      autofocus
      hide-bottom-space
      lazy-rules
      maxlength="100"
      label="Email atau Username"
      placeholder="Masukkan Email atau Username"
      autocomplete="username"
      :rules="credentialRules"
    >

      <template #prepend>
        <q-icon name="admin_panel_settings" />
      </template>

    </q-input>

    <q-input
      v-model="password"
      outlined
      hide-bottom-space
      lazy-rules
      maxlength="32"
      :type="showPassword ? 'text' : 'password'"
      label="Password"
      autocomplete="current-password"
      :rules="passwordRules"
    >

      <template #prepend>
        <q-icon name="lock" />
      </template>

      <template #append>

        <q-icon
          :name="showPassword ? 'visibility_off' : 'visibility'"
          class="cursor-pointer"
          @click="showPassword = !showPassword"
        />

      </template>

    </q-input>

    <q-btn
      type="submit"
      unelevated
      color="primary"
      label="Login"
      class="full-width"
      :loading="loading"
      :disable="loading"
    />

  </q-form>

</template>

<script setup>
import {
  ref,
} from 'vue'

import {
  useRouter,
} from 'vue-router'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

const router =
  useRouter()

const $q =
  useQuasar()

const emit =
  defineEmits([
    'login-success',
  ])

/*
|--------------------------------------------------------------------------
| API
|--------------------------------------------------------------------------
*/

const LOGIN_URL =
  '/api/auth/login-admin'

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

const formRef =
  ref(null)

const credential =
  ref('')

const password =
  ref('')

/*
|--------------------------------------------------------------------------
| PASSWORD
|--------------------------------------------------------------------------
*/

const showPassword =
  ref(false)

/*
|--------------------------------------------------------------------------
| LOADING
|--------------------------------------------------------------------------
*/

const loading =
  ref(false)

/*
|--------------------------------------------------------------------------
| VALIDATION
|--------------------------------------------------------------------------
*/

const credentialRules = [

  value =>
    !!value ||
    'Email atau Username wajib diisi',

]

const passwordRules = [

  value =>
    !!value ||
    'Password wajib diisi',

]

/*
|--------------------------------------------------------------------------
| HELPER
|--------------------------------------------------------------------------
*/

function resetForm() {

  formRef.value?.resetValidation()

  credential.value = ''
  password.value = ''

  showPassword.value = false

}

/*
|--------------------------------------------------------------------------
| LOGIN
|--------------------------------------------------------------------------
*/

async function loginAdmin() {

  const valid =
    await formRef.value.validate()

  if (!valid) {
    return
  }

  loading.value = true

  try {

    const response =
      await api.post(
        LOGIN_URL,
        {
          credential:
            credential.value.trim(),

          password:
            password.value,
        },
      )

    localStorage.setItem(
      'auth',
      JSON.stringify({

        type: 'admin',

        token:
          response.data.token,

        data:
          response.data.admin,

      }),
    )

    $q.notify({

      type: 'positive',

      message:
        'Login admin berhasil.',

    })

    resetForm()

    emit(
      'login-success',
    )

    router.replace(
      '/dashboard',
    )

  } catch (error) {

    console.error(error)

    $q.notify({

      type: 'negative',

      message:
        error.response?.data?.message ||
        'Login admin gagal.',

    })

  } finally {

    loading.value = false

  }

}
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

.auth-form {
  display: flex;
  flex-direction: column;

  gap: 18px;

  padding: 24px;
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

:deep(.q-field__native) {
  color: var(--app-text);
}

:deep(.q-field__label) {
  color: var(--app-text-secondary);
}

:deep(.q-field__prepend),
:deep(.q-field__append) {
  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| PASSWORD
|--------------------------------------------------------------------------
*/

.cursor-pointer {
  cursor: pointer;

  transition:
    color .2s ease;
}

.cursor-pointer:hover {
  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

.full-width {
  margin-top: 8px;
}

:deep(.q-btn) {
  border-radius: 14px;

  transition:
    transform .2s ease,
    background-color .2s ease;
}

:deep(.q-btn:active) {
  transform: scale(.98);
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.auth-footer {
  margin-top: 18px;

  text-align: center;

  font-size: .85rem;
  line-height: 1.5;

  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 599px) {

  .auth-form {
    padding: 20px;
  }

  .auth-footer {
    font-size: .8rem;
  }
}
</style>