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
          Update Product
        </div>

        <div class="dialog-subtitle">
          Update produk baru ke dalam game.
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
  label="Update Product"
  :loading="loading"
  @click="updateProduct"
/>

      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  ref,
  watch,
  onMounted
} from 'vue'

import api from 'src/axios'

const props = defineProps({
  modelValue: Boolean,
  product: Object,
})

const emit = defineEmits([
  'update:modelValue',
  'updated',
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
  is_active: true,
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

watch(
  () => props.product,
  (product) => {

    if (!product) return

    form.value = {
      game_id:
        product.game_id,

      name:
        product.name,

      slug:
        product.slug,

      currency_amount:
        product.currency_amount,

      price:
        product.price,

      display_order:
        product.display_order,

      is_active:
        product.is_active,
    }

  },
  {
    immediate: true,
  }
)
const updateProduct = async () => {

  try {

    loading.value = true

    await api.put(
      `/api/products/${props.product.id}`,
      form.value
    )

    emit('updated')

    emit(
      'update:modelValue',
      false
    )

  } catch (error) {

    console.error(
      'Update Product Error:',
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