<template>
  <q-dialog
    :model-value="modelValue"
    @update:model-value="
      emit(
        'update:modelValue',
        $event
      )
    "
  >
    <q-card class="dialog-card">

      <q-card-section>
        <div class="dialog-title">
          Add Game
        </div>
      </q-card-section>

      <q-card-section class="form-section">

        <q-input
          v-model="form.name"
          label="Game Name"
          outlined
        />

        <q-input
          v-model="form.slug"
          label="Slug"
          outlined
        />
        
<q-input
  v-model="form.game_key"
  label="Game Key"
  outlined
/>

        <q-input
          v-model="form.publisher"
          label="Publisher"
          outlined
        />

        <q-input
          v-model="form.description"
          label="Description"
          outlined
          type="textarea"
        />

        <q-input
          v-model="form.latest_patch"
          label="Latest Patch"
          outlined
        />

        <q-input
          v-model="form.latest_update"
          label="Latest Update"
          outlined
        />

        <q-input
          v-model="form.official_url"
          label="Official Website"
          outlined
        />

        <q-input
          v-model="form.patchnote_url"
          label="Patch Notes URL"
          outlined
        />

        <q-toggle
          v-model="form.is_active"
          label="Active"
          color="accent"
        />

      </q-card-section>

      <q-card-actions align="right">

        <q-btn
          flat
          label="Cancel"
          v-close-popup
        />

        <q-btn
          unelevated
          color="accent"
          label="Create"
          :loading="loading"
          @click="createGame"
        />

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
  slug: '',
  game_key: '',
  publisher: '',
  description: '',
  latest_patch: '',
  latest_update: '',
  official_url: '',
  patchnote_url: '',
})

const resetForm = () => {
  form.value = {
  name: '',
  slug: '',
  game_key: '',
  publisher: '',
  description: '',
  latest_patch: '',
  latest_update: '',
  official_url: '',
  patchnote_url: '',
}
}

const createGame = async () => {
  try {
    loading.value = true

    await api.post(
      '/api/games',
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
      'Create Game Error:',
      error
    )

  } finally {

    loading.value = false

  }
}
</script>

<style lang="scss" scoped>

.dialog-card {
  width: 700px;
  max-width: 95vw;

  border-radius: 24px;
}

.dialog-title {
  font-size: 1.3rem;
  font-weight: 700;
}

.form-section {
  display: flex;
  flex-direction: column;

  gap: 16px;
}

</style>