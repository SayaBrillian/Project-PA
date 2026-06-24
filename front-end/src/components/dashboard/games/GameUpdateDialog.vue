<template>
  <q-dialog :model-value="modelValue" @update:model-value="emit('update:modelValue', $event)">
    <q-card class="dialog-card">
      <q-card-section>
        <div class="dialog-title">Add Game</div>
      </q-card-section>

      <q-card-section class="form-section">
        <q-input v-model="form.name" label="Game Name" outlined />

        <q-input v-model="form.slug" label="Slug" outlined />

        <q-input v-model="form.game_key" label="Game Key" outlined />

        <q-input v-model="form.publisher" label="Publisher" outlined />

        <q-input v-model="form.description" label="Description" outlined type="textarea" />

        <q-input v-model="form.latest_patch" label="Latest Patch" outlined />

        <q-input v-model="form.latest_update" label="Latest Update" outlined />

        <q-input v-model="form.official_url" label="Official Website" outlined />

        <q-input v-model="form.patchnote_url" label="Patch Notes URL" outlined />

        <q-toggle v-model="form.is_active" label="Active" color="accent" />
      </q-card-section>

      <q-card-actions align="right">
        <q-btn flat label="Cancel" v-close-popup />

        <q-btn
          unelevated
          color="accent"
          label="Save Changes"
          :loading="loading"
          @click="updateGame"
        />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch } from 'vue'
import api from 'src/axios'

const props = defineProps({
  modelValue: Boolean,
  game: Object,
})

const emit = defineEmits(['update:modelValue', 'updated'])

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

watch(
  () => props.game,
  (game) => {
    if (!game) return

    form.value = {
      name: game.name || '',
      slug: game.slug || '',
      game_key: game.game_key || '',
      publisher: game.publisher || '',
      description: game.description || '',
      latest_patch: game.latest_patch || '',
      latest_update: game.latest_update || '',
      official_url: game.official_url || '',
      patchnote_url: game.patchnote_url || '',
    }
  },
  {
    immediate: true,
  },
)

const updateGame = async () => {
  try {
    loading.value = true

    await api.put(`/api/games/${props.game.id}`, form.value)

    emit('updated')

    emit('update:modelValue', false)
  } catch (error) {
    console.error('Update Game Error:', error)
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
