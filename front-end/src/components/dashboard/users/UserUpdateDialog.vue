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
          Update User
        </div>

        <div class="dialog-subtitle">
          Perbarui informasi pengguna.
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="form-grid">

          <q-input v-model="form.name" label="Full Name" outlined />

          <q-input v-model="form.email" label="Email" outlined type="email" />

        </div>

      </q-card-section>

      <q-separator />

      <q-card-actions align="right">

        <q-btn flat label="Cancel" v-close-popup />

        <q-btn unelevated color="accent" label="Update User" :loading="loading" @click="updateUser" />
      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  ref,
  watch,
} from 'vue'

import api from 'src/axios'

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
  email: '',
})

watch(
  () => props.user,
  (user) => {

    if (!user) return

    form.value = {

      name: user.name,

      email: user.email,

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
      `/api/users/${props.user.id}`,
      form.value
    )

    emit('updated')

    emit(
      'update:modelValue',
      false
    )

  } catch (error) {

    console.error(
      'Update User Error:',
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
