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
              Update User
            </h2>

            <p class="dialog-subtitle">
              Perbarui informasi pengguna.
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
            Informasi Pengguna
          </h3>

          <div class="form-grid">

            <q-input v-model="form.name" label="Full Name" outlined />

            <q-input v-model="form.username" label="Username" outlined />

            <q-input v-model="form.birth_date" label="Birth Date" type="date" outlined />

            <q-input v-model="form.email" label="Email" type="email" outlined />

            <q-input v-model="form.phone" label="Phone" outlined />

          </div>

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" icon="save" no-caps label="Update User" :loading="loading"
            @click="updateUser" />

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

  user: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'updated',

])

const loading = ref(false)

const form = ref({

  name: '',

  username: '',

  birth_date: '',

  email: '',

  phone: '',

})

watch(

  () => props.user,

  (user) => {

    if (!user) return

    form.value = {

      name: user.name,

      username: user.username,

      birth_date: user.birth_date?.slice(0, 10),

      email: user.email,

      phone: user.phone,

    }

  },

  {
    immediate: true,
  }

)

const updateUser = async () => {

  try {

    loading.value = true

    await api.put(

      `/api/user/${props.user.id}`,

      form.value,

    )

    emit('updated')

    emit(
      'update:modelValue',
      false,
    )

  }

  catch (error) {

    console.error(
      'Update User Error:',
      error,
    )

  }

  finally {

    loading.value = false

  }

}

</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {

  width: 700px;
  max-width: 95vw;

  max-height: 85vh;

  display: flex;
  flex-direction: column;

  background: var(--app-bg);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  overflow: hidden;

}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {

  padding: 24px 28px;

}

.dialog-handle {

  width: 48px;
  height: 5px;

  margin: 0 auto 20px;

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

  font-size: 1.7rem;
  font-weight: 700;

}

.dialog-subtitle {

  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;

}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {

  flex: 1;

  overflow-y: auto;

  padding: 28px;

}

.section-title {

  margin: 0 0 18px;

  color: var(--app-text);

  font-size: 1.05rem;
  font-weight: 700;

}

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

.form-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

:deep(.q-field--outlined .q-field__control) {

  border-radius: 14px;

}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {

  padding: 20px 28px;

  border-top: 1px solid var(--app-border);

  background: var(--app-bg);

}

.footer-actions {

  display: flex;

  justify-content: flex-end;

}

.footer-actions :deep(.q-btn) {

  border-radius: 14px;

}

/*
|--------------------------------------------------------------------------
| SCROLLBAR
|--------------------------------------------------------------------------
*/

.dialog-content::-webkit-scrollbar {

  width: 8px;

}

.dialog-content::-webkit-scrollbar-thumb {

  background: var(--app-border);

  border-radius: 999px;

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .dialog-card {

    width: 100vw;
    max-width: 100vw;

    height: 90vh;
    max-height: 90vh;

    margin: 0;

    border-radius: 24px 24px 0 0;

  }

  .dialog-header {

    padding: 20px;

  }

  .dialog-content {

    padding: 20px;

  }

  .dialog-footer {

    padding: 20px;

    box-shadow: 0 -6px 18px rgba(0, 0, 0, .08);

  }

  .dialog-title {

    font-size: 1.5rem;

  }

  .form-grid {

    grid-template-columns: 1fr;

  }

  .footer-actions {

    display: grid;

  }

  .footer-actions :deep(.q-btn) {

    width: 100%;

  }

}
</style>
