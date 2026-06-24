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

    <q-card
      v-if="product"
      class="dialog-card"
    >

      <q-card-section>

        <div class="dialog-title">
          Nonaktifkan Product
        </div>

      </q-card-section>

      <q-card-section>

        <p>
          Apakah Anda yakin ingin
          menonaktifkan produk:
        </p>

        <div class="product-name">
          {{ product.name }}
        </div>

        <p class="warning-text">
          Produk tidak akan dihapus,
          tetapi tidak akan tampil
          sebagai produk aktif.
        </p>

      </q-card-section>

      <q-card-actions align="right">

        <q-btn
          flat
          label="Batal"
          v-close-popup
        />

        <q-btn
          unelevated
          color="negative"
          label="Nonaktifkan"
          :loading="loading"
          @click="deleteProduct"
        />

      </q-card-actions>

    </q-card>

  </q-dialog>
</template>

<script setup>
import { ref } from 'vue'
import api from 'src/axios'

const props = defineProps({
  modelValue: Boolean,
  product: Object,
})

const emit = defineEmits([
  'update:modelValue',
  'deleted',
])

const loading = ref(false)

const deleteProduct = async () => {

  try {

    loading.value = true

    await api.delete(
  `/api/products/${props.product.id}`
)

    emit('deleted')

    emit(
      'update:modelValue',
      false
    )

  } catch (error) {

    console.error(
      'Delete Product Error:',
      error
    )

  } finally {

    loading.value = false

  }

}
</script>

<style lang="scss" scoped>

.dialog-card {
  width: 500px;
  max-width: 95vw;

  border-radius: 24px;
}

.dialog-title {
  font-size: 1.25rem;
  font-weight: 700;

  color: $dark;
}

.product-name {
  margin-top: 12px;

  color: $dark;

  font-size: 1.1rem;
  font-weight: 700;
}

.warning-text {
  margin-top: 16px;

  color: rgba(
    0,
    0,
    0,
    .6
  );
}

</style>