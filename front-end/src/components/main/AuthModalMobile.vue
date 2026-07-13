<template>
    <q-dialog v-model="modelValue" position="bottom" backdrop-filter="blur(8px)" transition-show="slide-up"
        transition-hide="slide-down">
        <q-card class="auth-card-mobile">

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

                        <q-icon name="person" size="36px" class="role-icon" />

                        <div class="text-subtitle1 text-weight-medium">
                            User
                        </div>

                    </div>

                    <div class="role-card" @click="step = 'login-admin'">

                        <q-icon name="admin_panel_settings" size="36px" class="role-icon" />

                        <div class="text-subtitle1 text-weight-medium">
                            Admin
                        </div>

                    </div>

                </q-card-section>

            </template>

            <!-- FORM -->
            <template v-else>

                <q-card-section class="auth-header">

                    <div class="auth-header-actions">

                        <q-btn flat round dense icon="arrow_back" class="header-btn" @click="step = 'role'" />

                        <q-space />

                        <q-btn flat round dense icon="close" class="header-btn" @click="modelValue = false" />

                    </div>

                    <div class="auth-title">

                        {{ page.title }}

                    </div>

                    <div class="auth-subtitle">

                        {{ page.subtitle }}

                    </div>

                </q-card-section>

                <LoginUserForm v-if="step === 'login-user'" @login-success="handleLoginSuccess"
                    @change-step="step = $event" />

                <RegisterUserForm v-else-if="step === 'register'" @change-step="step = $event" />

                <LoginAdminForm v-else-if="step === 'login-admin'" @login-success="handleLoginSuccess" />

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

    () =>
        props.modelValue,

    value => {

        if (value) {

            step.value =
                props.initialStep

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
| AUTH
|--------------------------------------------------------------------------
*/

function handleLoginSuccess() {

    emit(
        'login-success',
    )

    modelValue.value =
        false

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

    background: var(--app-surface);

    color: var(--app-text);

    border-radius: 24px 24px 0 0;

    overflow: hidden;
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
    padding: 16px 20px 12px;

    flex-shrink: 0;
}

.auth-header-actions {
    display: flex;
    align-items: center;
}

.header-btn {
    color: var(--app-text-secondary);
}

.auth-title {
    margin-top: 8px;

    font-size: 1.4rem;
    font-weight: 700;

    color: var(--app-text);
}

.auth-subtitle {
    margin-top: 4px;

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
    display: flex;
    flex-direction: column;

    gap: 14px;

    padding: 20px;
}

.role-card {
    display: flex;
    align-items: center;

    gap: 16px;

    padding: 18px;

    border-radius: 16px;

    border: 1px solid var(--app-border);

    background: var(--app-surface-secondary);

    cursor: pointer;

    transition:
        transform .2s ease,
        background-color .2s ease,
        border-color .2s ease;
}

.role-card:active {
    transform: scale(.98);
}

.role-card:hover {
    border-color: var(--app-primary);
}

.role-icon {
    color: var(--app-primary);

    flex-shrink: 0;
}

/*
|--------------------------------------------------------------------------
| FORM CONTAINER
|--------------------------------------------------------------------------
*/

:deep(.auth-form) {
    overflow-y: auto;

    flex: 1;
}

/*
|--------------------------------------------------------------------------
| SCROLLBAR
|--------------------------------------------------------------------------
*/

:deep(.auth-form::-webkit-scrollbar) {
    width: 6px;
}

:deep(.auth-form::-webkit-scrollbar-thumb) {
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
