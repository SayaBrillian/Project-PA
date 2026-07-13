<template>

    <q-form ref="formRef" class="auth-form" @submit.prevent="registerUser">

        <!-- Nama Lengkap -->

        <q-input v-model="name" outlined autofocus hide-bottom-space lazy-rules maxlength="100" label="Nama Lengkap"
            placeholder="Masukkan nama lengkap" :rules="nameRules">

            <template #prepend>
                <q-icon name="badge" />
            </template>

        </q-input>

        <!-- Username -->

        <q-input v-model="username" outlined hide-bottom-space lazy-rules maxlength="30" label="Username"
            placeholder="Masukkan username" :rules="usernameRules">

            <template #prepend>
                <q-icon name="alternate_email" />
            </template>

            <template #append>

                <q-btn flat round dense :loading="checkingUsername" :icon="usernameChecked
                    ? (usernameAvailable ? 'task_alt' : 'cancel')
                    : 'task_alt'" :color="usernameChecked
                        ? (usernameAvailable ? 'positive' : 'negative')
                        : 'grey'" @click="checkUsername" />

            </template>

        </q-input>

        <!-- Tanggal Lahir -->

        <q-input v-model="birthDate" outlined hide-bottom-space lazy-rules type="date" label="Tanggal Lahir"
            :rules="birthDateRules">

            <template #prepend>
                <q-icon name="cake" />
            </template>

        </q-input>

        <!-- Email -->

        <q-input v-model="email" outlined clearable hide-bottom-space lazy-rules maxlength="100" type="email"
            label="Email" placeholder="contoh@email.com" :rules="emailRules">

            <template #prepend>
                <q-icon name="mail" />
            </template>

            <template #append>

                <q-btn flat round dense :disable="!email" :loading="checkingEmail" :icon="emailChecked
                    ? (emailAvailable ? 'task_alt' : 'cancel')
                    : 'task_alt'" :color="emailChecked
                        ? (emailAvailable ? 'positive' : 'negative')
                        : 'grey'" @click="checkEmail" />

            </template>

        </q-input>

        <!-- Nomor HP -->

        <q-input v-model="phone" outlined clearable hide-bottom-space lazy-rules maxlength="20" type="tel"
            label="Nomor HP" placeholder="08xxxxxxxxxx" :rules="phoneRules">>

            <template #prepend>
                <q-icon name="call" />
            </template>

            <template #append>

                <q-btn flat round dense :disable="!phone" :loading="checkingPhone" :icon="phoneChecked
                    ? (phoneAvailable ? 'task_alt' : 'cancel')
                    : 'task_alt'" :color="phoneChecked
                        ? (phoneAvailable ? 'positive' : 'negative')
                        : 'grey'" @click="checkPhone" />

            </template>

        </q-input>

        <!-- Password -->

        <q-input v-model="password" outlined hide-bottom-space lazy-rules maxlength="32"
            :type="showPassword ? 'text' : 'password'" label="Password" :rules="passwordRules">

            <template #prepend>
                <q-icon name="lock" />
            </template>

            <template #append>

                <q-icon :name="showPassword ? 'visibility_off' : 'visibility'" class="cursor-pointer"
                    @click="showPassword = !showPassword" />

            </template>

        </q-input>

        <div class="password-hint">
            {{ passwordHint }}
        </div>

        <!-- Konfirmasi Password -->

        <q-input v-model="confirmPassword" outlined hide-bottom-space lazy-rules maxlength="32"
            :type="showConfirmPassword ? 'text' : 'password'" label="Konfirmasi Password" :rules="confirmPasswordRules">

            <template #prepend>
                <q-icon name="lock_reset" />
            </template>

            <template #append>

                <q-icon :name="showConfirmPassword ? 'visibility_off' : 'visibility'" class="cursor-pointer"
                    @click="showConfirmPassword = !showConfirmPassword" />

            </template>

        </q-input>

        <!-- Register -->

        <q-btn type="submit" unelevated color="primary" label="Daftar" class="full-width" :loading="loading"
            :disable="loading || !isFormReady" />

        <div class="auth-switch">

            <span>
                Sudah punya akun?
            </span>

            <q-btn flat dense no-caps color="primary" label="Masuk" @click="$emit('change-step', 'login-user')" />

        </div>

    </q-form>

</template>

<script setup>
import { ref, computed, watch, } from 'vue'

import { useQuasar, } from 'quasar'

import api from 'src/axios'

const emit =
    defineEmits([
        'change-step',
    ])

const $q =
    useQuasar()

/*
|--------------------------------------------------------------------------
| API
|--------------------------------------------------------------------------
*/

const CHECK_URL =
    '/api/auth/check'

const REGISTER_URL =
    '/api/auth/register'

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

const formRef =
    ref(null)

const name =
    ref('')

const username =
    ref('')

const birthDate =
    ref('')

const email =
    ref('')

const phone =
    ref('')

const password =
    ref('')

const confirmPassword =
    ref('')

/*
|--------------------------------------------------------------------------
| PASSWORD
|--------------------------------------------------------------------------
*/

const showPassword =
    ref(false)

const showConfirmPassword =
    ref(false)

/*
|--------------------------------------------------------------------------
| LOADING
|--------------------------------------------------------------------------
*/

const loading =
    ref(false)

const checkingUsername =
    ref(false)

const checkingEmail =
    ref(false)

const checkingPhone =
    ref(false)

/*
|--------------------------------------------------------------------------
| STATUS
|--------------------------------------------------------------------------
*/

const usernameChecked =
    ref(false)

const usernameAvailable =
    ref(false)

const emailChecked =
    ref(false)

const emailAvailable =
    ref(false)

const phoneChecked =
    ref(false)

const phoneAvailable =
    ref(false)

/*
|--------------------------------------------------------------------------
| VALIDATION
|--------------------------------------------------------------------------
*/

const nameRules = [

    value =>
        !!value ||
        'Nama lengkap wajib diisi',

]

const usernameRules = [

    value =>
        !!value ||
        'Username wajib diisi',

    value =>
        value.length >= 4 ||
        'Username minimal 4 karakter',

    value =>
        value.length <= 30 ||
        'Username maksimal 30 karakter',

    value =>
        /^[a-zA-Z0-9_]+$/.test(value) ||
        'Hanya huruf, angka, dan underscore (_)',

]

const birthDateRules = [

    value =>
        !!value ||
        'Tanggal lahir wajib diisi',

]

const emailRules = [

    value =>
        !value ||
        /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value) ||
        'Format email tidak valid',

]

const phoneRules = [

    value =>
        !value ||
        /^08[0-9]{8,13}$/.test(value) ||
        'Nomor HP tidak valid',

]

const passwordRules = [

    value =>
        !!value ||
        'Password wajib diisi',

    value =>
        value.length >= 8 ||
        'Password minimal 8 karakter',

    value =>
        value.length <= 32 ||
        'Password maksimal 32 karakter',

    value =>
        /[A-Z]/.test(value) ||
        'Harus mengandung huruf besar',

    value =>
        /[a-z]/.test(value) ||
        'Harus mengandung huruf kecil',

    value =>
        /\d/.test(value) ||
        'Harus mengandung angka',

]

const confirmPasswordRules = [

    value =>
        !!value ||
        'Konfirmasi password wajib diisi',

    value =>
        value === password.value ||
        'Password tidak sama',

]

const passwordHint = 'Password minimal 8 karakter, maksimal 32 karakter, mengandung huruf besar, huruf kecil, dan angka.'

/*
|--------------------------------------------------------------------------
| WATCH
|--------------------------------------------------------------------------
*/

watch(username, () => {

    usernameChecked.value = false
    usernameAvailable.value = false

})

watch(email, () => {

    emailChecked.value = false
    emailAvailable.value = false

})

watch(phone, () => {

    phoneChecked.value = false
    phoneAvailable.value = false

})

/*
|--------------------------------------------------------------------------
| CHECK
|--------------------------------------------------------------------------
*/

async function check(field, value) {

    const response =
        await api.post(
            CHECK_URL,
            {
                field,
                value,
            },
        )

    return response.data.available

}

async function checkUsername() {

    if (!username.value.trim()) {
        return
    }

    checkingUsername.value = true

    try {

        usernameAvailable.value =
            await check(
                'username',
                username.value.trim(),
            )

        usernameChecked.value = true

        $q.notify({
            type: usernameAvailable.value
                ? 'positive'
                : 'negative',

            message: usernameAvailable.value
                ? 'Username tersedia.'
                : 'Username sudah digunakan.',
        })

    } catch (error) {

        console.error(error)

        $q.notify({
            type: 'negative',
            message: 'Gagal mengecek username.',
        })

    } finally {

        checkingUsername.value = false

    }

}

async function checkEmail() {

    if (!email.value.trim()) {

        emailChecked.value = false
        emailAvailable.value = false

        return

    }

    checkingEmail.value = true

    try {

        emailAvailable.value =
            await check(
                'email',
                email.value.trim(),
            )

        emailChecked.value = true

        $q.notify({
            type: emailAvailable.value
                ? 'positive'
                : 'negative',

            message: emailAvailable.value
                ? 'Email tersedia.'
                : 'Email sudah digunakan.',
        })

    } catch (error) {

        console.error(error)

        $q.notify({
            type: 'negative',
            message: 'Gagal mengecek email.',
        })

    } finally {

        checkingEmail.value = false

    }

}

async function checkPhone() {

    if (!phone.value.trim()) {

        phoneChecked.value = false
        phoneAvailable.value = false

        return

    }

    checkingPhone.value = true

    try {

        phoneAvailable.value =
            await check(
                'phone',
                phone.value.trim(),
            )

        phoneChecked.value = true

        $q.notify({
            type: phoneAvailable.value
                ? 'positive'
                : 'negative',

            message: phoneAvailable.value
                ? 'Nomor HP tersedia.'
                : 'Nomor HP sudah digunakan.',
        })

    } catch (error) {

        console.error(error)

        $q.notify({
            type: 'negative',
            message: 'Gagal mengecek nomor HP.',
        })

    } finally {

        checkingPhone.value = false

    }

}

/*
|--------------------------------------------------------------------------
| COMPUTED
|--------------------------------------------------------------------------
*/

const isFormReady =
    computed(() => {

        const contactReady =
            (
                email.value.trim() &&
                emailChecked.value &&
                emailAvailable.value
            ) ||
            (
                phone.value.trim() &&
                phoneChecked.value &&
                phoneAvailable.value
            )

        const passwordReady =
            password.value &&
            confirmPassword.value &&
            password.value ===
            confirmPassword.value

        return (

            name.value.trim() &&

            usernameChecked.value &&
            usernameAvailable.value &&

            birthDate.value &&

            contactReady &&

            passwordReady

        )

    })

/*
|--------------------------------------------------------------------------
| HELPER
|--------------------------------------------------------------------------
*/

function resetForm() {

    formRef.value?.resetValidation()

    name.value = ''
    username.value = ''
    birthDate.value = ''

    email.value = ''
    phone.value = ''

    password.value = ''
    confirmPassword.value = ''

    showPassword.value = false
    showConfirmPassword.value = false

    usernameChecked.value = false
    usernameAvailable.value = false

    emailChecked.value = false
    emailAvailable.value = false

    phoneChecked.value = false
    phoneAvailable.value = false

}

/*
|--------------------------------------------------------------------------
| REGISTER
|--------------------------------------------------------------------------
*/

async function registerUser() {

    const valid =
        await formRef.value.validate()

    if (!valid) {
        return
    }

    if (
        !email.value.trim() &&
        !phone.value.trim()
    ) {

        $q.notify({

            type: 'warning',

            message:
                'Isi Email atau Nomor HP.'

        })

        return

    }

    loading.value = true

    try {

        const payload = {

            name:
                name.value.trim(),

            username:
                username.value.trim(),

            birthDate:
                birthDate.value,

            email:
                email.value.trim() || null,

            phone:
                phone.value.trim() || null,

            password:
                password.value,

        }

        await api.post(
            REGISTER_URL,
            payload,
        )

        $q.notify({

            type: 'positive',

            message:
                'Registrasi berhasil.'

        })

        resetForm()

        emit(
            'change-step',
            'login-user',
        )

    } catch (error) {

        console.error(error)

        $q.notify({

            type: 'negative',

            message:
                error.response?.data?.message ||
                'Registrasi gagal.'

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
| CHECK BUTTON
|--------------------------------------------------------------------------
*/

:deep(.q-field__append .q-btn) {
  width: 32px;
  height: 32px;

  min-width: 32px;

  border-radius: 50%;

  transition:
    transform .2s ease,
    background-color .2s ease;
}

:deep(.q-field__append .q-btn:hover) {
  transform: scale(1.08);
}

:deep(.q-field__append .q-btn:active) {
  transform: scale(.95);
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

.password-hint {
  margin-top: -8px;

  font-size: .8rem;
  line-height: 1.5;

  color: var(--app-text-secondary);
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
| DATE INPUT
|--------------------------------------------------------------------------
*/

:deep(input[type='date']) {
  color: var(--app-text);
}

:deep(input[type='date']::-webkit-calendar-picker-indicator) {
  cursor: pointer;

  opacity: .75;
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