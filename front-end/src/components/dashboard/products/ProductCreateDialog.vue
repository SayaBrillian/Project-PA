<template>

  <q-dialog
    seamless
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
          Add Product
        </div>

        <div class="dialog-subtitle">
          Tambahkan produk baru ke dalam game.
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="form-grid">

          <q-select
            v-model="form.game_id"
            :options="gameOptions"
            label="Game"
            outlined
            emit-value
            map-options
          />

          <q-input
            v-model="form.name"
            label="Product Name"
            outlined
          />

          <q-input
            v-model="form.slug"
            label="Slug"
            outlined
          />

          <q-input
            v-model="form.currency_amount"
            label="Currency Amount"
            outlined
            type="number"
          />

          <q-input
            v-model="form.price"
            label="Price"
            outlined
            type="number"
            prefix="Rp"
          />

          <q-input
            v-model="form.display_order"
            label="Display Order"
            outlined
            type="number"
          />

        </div>

      </q-card-section>

      <q-separator />

      <q-card-actions align="right">

        <q-btn
          flat
          label="Cancel"
          v-close-popup
        />

        <q-btn
  unelevated
  color="accent"
  label="Create Product"
  :loading="loading"
  @click="createProduct"
/>

      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  ref,
  onMounted
} from 'vue'

import api from 'src/axios'

defineProps({
  modelValue: Boolean,
})

const emit = defineEmits([
  'update:modelValue',
  'created',
])

const loading = ref(false)

const gameOptions = ref([])

const form = ref({
  game_id: null,
  name: '',
  slug: '',
  currency_amount: null,
  price: null,
  display_order: 0,
})

const loadGames = async () => {

  try {

    const response =
      await api.get(
        '/api/games'
      )

    gameOptions.value =
      response.data.games.map(
        (game) => ({
          label: game.name,
          value: game.id,
        })
      )

  } catch (error) {

    console.error(
      'Load Games Error:',
      error
    )

  }

}
const resetForm = () => {

  form.value = {
    game_id: null,
    name: '',
    slug: '',
    currency_amount: null,
    price: null,
    display_order: 0,
  }

}
const createProduct = async () => {

  try {

    loading.value = true

    await api.post(
      '/api/products',
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
      'Create Product Error:',
      error
    )

  } finally {

    loading.value = false

  }

}
onMounted(() => {

  loadGames()

})
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

  color: rgba(
    0,
    0,
    0,
    .55
  );

  font-size: .9rem;
}

.form-grid {
  display: grid;

  grid-template-columns:
    repeat(
      2,
      1fr
    );

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