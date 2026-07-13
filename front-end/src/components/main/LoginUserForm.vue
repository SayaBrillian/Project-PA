<template>
    <q-form ref="formRef" class="auth-form" @submit.prevent="loginUser">
        <q-input v-model="credential" outlined clearable autofocus hide-bottom-space lazy-rules maxlength="100"
            label="Email, Username, atau Nomor HP" placeholder="Masukkan Email, Username, atau Nomor HP"
            autocomplete="username" :rules="credentialRules">
            <template #prepend>
                <q-icon name="person" />
            </template>
        </q-input>

        <q-input v-model="password" outlined hide-bottom-space lazy-rules maxlength="100"
            :type="showPassword ? 'text' : 'password'" label="Password" autocomplete="current-password"
            :rules="passwordRules">
            <template #prepend>
                <q-icon name="lock" />
            </template>

            <template #append>
                <q-icon :name="showPassword ? 'visibility_off' : 'visibility'" class="cursor-pointer"
                    @click="showPassword = !showPassword" />
            </template>
        </q-input>

        <q-btn type="submit" unelevated color="primary" label="Login" class="full-width" :loading="loading"
            :disable="loading" />

        <div class="auth-switch">

            <span>
                Belum punya akun?
            </span>

            <q-btn flat dense no-caps color="primary" label="Daftar" @click="$emit('change-step', 'register')" />

        </div>

    </q-form>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useQuasar } from 'quasar'

import api from 'src/axios'

const emit = defineEmits([
    'login-success',
    'change-step'
])

const router = useRouter()
const $q = useQuasar()

const LOGIN_URL = '/api/auth/login-user'

const formRef = ref(null)

const credential = ref('')
const password = ref('')

const showPassword = ref(false)
const loading = ref(false)

/*
|--------------------------------------------------------------------------
| VALIDATION
|--------------------------------------------------------------------------
*/

const credentialRules = [
    value => !!value || 'Credential wajib diisi'
]

const passwordRules = [
    value => !!value || 'Password wajib diisi'
]

/*
|--------------------------------------------------------------------------
| HELPER
|--------------------------------------------------------------------------
*/

function resetForm() {

    credential.value = ''
    password.value = ''

    showPassword.value = false

}

/*
|--------------------------------------------------------------------------
| LOGIN
|--------------------------------------------------------------------------
*/

async function loginUser() {

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
                    credential: credential.value.trim(),
                    password: password.value
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

        resetForm()

        emit('login-success')

        router.replace('/user')

    } catch (error) {

        console.error(error)

        $q.notify({
            type: 'negative',
            message:
                error.response?.data?.message ||
                'Login gagal.'
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

  transition: color .2s ease;
}

.cursor-pointer:hover {
  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

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
| LOGIN BUTTON
|--------------------------------------------------------------------------
*/

.full-width {
  margin-top: 4px;
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

  gap: 6px;

  margin-top: 18px;

  font-size: .9rem;

  color: var(--app-text-secondary);
}

.auth-switch :deep(.q-btn) {
  min-height: auto;

  padding: 4px 8px;

  border-radius: 8px;
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

  .auth-switch {
    flex-direction: column;

    gap: 4px;
  }

}
</style>