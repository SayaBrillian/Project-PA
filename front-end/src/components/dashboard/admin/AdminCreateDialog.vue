<template>

  <q-dialog seamless :model-value="modelValue" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card class="dialog-card">

      <q-card-section>

        <div class="dialog-title">
          Add Admin
        </div>

        <div class="dialog-subtitle">
          Tambahkan administrator baru.
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="form-grid">

          <q-input v-model="form.name" label="Full Name" outlined />

          <q-input v-model="form.email" label="Email" outlined type="email" />

          <q-input v-model="form.password" label="Password" outlined type="password" />

          <q-input v-model="form.level" label="Level" outlined type="number" />

        </div>

      </q-card-section>

      <q-separator />

      <q-card-actions align="right">

        <q-btn flat label="Cancel" v-close-popup />

        <q-btn unelevated color="accent" label="Create Admin" :loading="loading" @click="createAdmin" />

      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>
import { ref } from 'vue'

import api from 'src/axios'

defineProps({

  modelValue: Boolean,

})

const emit = defineEmits([

  'update:modelValue',

  'created',

])

const loading = ref(false)

const form = ref({

  name: '',

  email: '',

  password: '',

  level: 80,

})

const resetForm = () => {

  form.value = {

    name: '',

    email: '',

    password: '',

    level: 80,

  }

}

const createAdmin = async () => {

  try {

    loading.value = true

    await api.post(

      '/api/auth/register-admin',

      form.value

    )

    emit('created')

    emit(
      'update:modelValue',
      false
    )

    resetForm()

  } catch (error) {

    console.error(
      'Create Admin Error:',
      error
    )

  } finally {

    loading.value = false

  }

}
</script>

<style lang="scss" scoped>
.dialog-card {
  width: 800px;
  max-width: 95vw;

  border-radius: 24px;

  background: white;
}

.dialog-title {
  color: $dark;

  font-size: 1.4rem;
  font-weight: 700;
}

.dialog-subtitle {
  margin-top: 6px;

  color: rgba(0,
      0,
      0,
      .55);

  font-size: .9rem;
}

.form-grid {
  display: grid;

  grid-template-columns:
    repeat(2,
      1fr);

  gap: 16px;
}

:deep(.q-field) {
  background: white;
}

@media (max-width: 768px) {

  .form-grid {

    grid-template-columns:
      1fr;

  }

}
</style>
