<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined"
    @update:model-value="emit('update:modelValue', $event)">

    <q-card class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle"></div>

        <div class="header-content">

          <div>

            <h2 class="dialog-title">
              Add Admin
            </h2>

            <p class="dialog-subtitle">
              Tambahkan administrator baru.
            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <section class="dialog-section">

          <h3 class="section-title">
            Informasi Administrator
          </h3>

          <div class="form-grid">

            <q-input v-model="form.name" outlined label="Full Name" />

            <q-input v-model="form.username" outlined label="Username" />

            <q-input v-model="form.birth_date" outlined type="date" label="Birth Date" />

            <q-input v-model="form.phone" outlined label="Phone" />

            <q-input v-model="form.email" outlined type="email" label="Email" />

            <q-select v-model="form.role" outlined label="Role" :options="[
              'admin',
              'super_admin'
            ]" />

            <q-input v-model="form.password" outlined :type="showPassword ? 'text' : 'password'" label="Password">

              <template #append>

                <q-icon :name="showPassword
                  ? 'visibility_off'
                  : 'visibility'
                  " class="cursor-pointer" @click="
                    showPassword =
                    !showPassword
                    " />

              </template>

            </q-input>

          </div>

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" icon="person_add" no-caps label="Create Admin" :loading="loading"
            @click="createAdmin" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  ref,
  watch,
} from 'vue'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

const $q = useQuasar()

const props = defineProps({

  modelValue: Boolean,

})

const emit = defineEmits([

  'update:modelValue',

  'created',

])

const loading = ref(false)

const showPassword = ref(false)

const form = ref({

  name: '',

  username: '',

  birth_date: '',

  email: '',

  phone: '',

  password: '',

  role: 'admin',

})

const resetForm = () => {

  form.value = {

    name: '',

    username: '',

    birth_date: '',

    email: '',

    phone: '',

    password: '',

    role: 'admin',

  }

  showPassword.value = false

}

watch(

  () => props.modelValue,

  (opened) => {

    if (opened) {

      resetForm()

    }

  }

)

const createAdmin = async () => {

  try {

    loading.value = true

    await api.post(

      '/api/auth/register-admin',

      form.value,

    )

    emit('created')

    emit(
      'update:modelValue',
      false,
    )

  }

  catch (error) {

    console.error(
      'Create Admin Error:',
      error,
    )

  }

  finally {

    loading.value = false

  }

}

</script>

<style scoped lang="scss">
.dialog-card {

  width: 700px;
  max-width: 95vw;
  max-height: 85vh;

  display: flex;
  flex-direction: column;

  border-radius: 24px;

  background: var(--app-surface);

  overflow: hidden;

}

/* -------------------------------------------------------------------------- */
/* HEADER */
/* -------------------------------------------------------------------------- */

.dialog-header {

  padding: 24px 28px 20px;

  background: var(--app-surface);

}

.dialog-handle {

  width: 48px;
  height: 5px;

  margin: 0 auto 18px;

  border-radius: 999px;

  background: var(--app-border);

}

.header-content {

  display: flex;

  justify-content: space-between;

  align-items: flex-start;

  gap: 20px;

}

.dialog-title {

  margin: 0 0 8px;

  color: var(--app-text);

  font-size: 1.45rem;
  font-weight: 700;

}

.dialog-subtitle {

  margin: 0;

  color: var(--app-text-light);

  font-size: .95rem;

  line-height: 1.5;

}

/* -------------------------------------------------------------------------- */
/* CONTENT */
/* -------------------------------------------------------------------------- */

.dialog-content {

  flex: 1;

  overflow-y: auto;

  padding: 28px;

}

.dialog-section {

  display: flex;

  flex-direction: column;

  gap: 20px;

}

.section-title {

  margin: 0;

  color: var(--app-text);

  font-size: 1rem;

  font-weight: 600;

}

/* -------------------------------------------------------------------------- */
/* FORM */
/* -------------------------------------------------------------------------- */

.form-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

:deep(.q-field) {

  background: white;

  border-radius: 14px;

}

:deep(.q-field__control) {

  border-radius: 14px;

}

/* Password full width */

.form-grid .q-field:last-child {

  grid-column: 1 / -1;

}

/* -------------------------------------------------------------------------- */
/* FOOTER */
/* -------------------------------------------------------------------------- */

.dialog-footer {

  padding: 20px 28px;

  background: var(--app-surface);

}

.footer-actions {

  display: flex;

  justify-content: flex-end;

}

.footer-actions .q-btn {

  min-width: 170px;

  border-radius: 12px;

}

/* -------------------------------------------------------------------------- */
/* SCROLLBAR */
/* -------------------------------------------------------------------------- */

.dialog-content::-webkit-scrollbar {

  width: 8px;

}

.dialog-content::-webkit-scrollbar-thumb {

  background: var(--app-border);

  border-radius: 999px;

}

/* -------------------------------------------------------------------------- */
/* MOBILE */
/* -------------------------------------------------------------------------- */

@media (max-width: 768px) {

  .dialog-card {

    width: 100%;

    max-width: 100%;

    height: 92vh;

    max-height: 92vh;

    border-radius: 24px 24px 0 0;

  }

  .dialog-header {

    padding: 18px 20px 16px;

  }

  .dialog-content {

    padding: 20px;

  }

  .dialog-footer {

    position: sticky;

    bottom: 0;

    padding: 16px 20px;

    border-top: 1px solid var(--app-border);

    background: var(--app-surface);

    z-index: 5;

  }

  .footer-actions {

    width: 100%;

  }

  .footer-actions .q-btn {

    width: 100%;

  }

  .form-grid {

    grid-template-columns: 1fr;

  }

  .form-grid .q-field:last-child {

    grid-column: auto;

  }

}
</style>
