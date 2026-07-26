<template>
  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined"
    @update:model-value="emit('update:modelValue', $event)">
    <q-card v-if="product" class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle" />

        <div class="header-content">

          <div>

            <h2 class="dialog-title">
              Disable Product
            </h2>

            <p class="dialog-subtitle">
              Produk tidak akan dihapus dari database.
            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <q-icon name="warning_amber" color="negative" size="60px" class="warning-icon" />

        <h3 class="product-name">
          {{ product.name }}
        </h3>

        <p class="warning-text">
          Apakah Anda yakin ingin menonaktifkan produk ini?
        </p>

        <div class="info-box">

          <div class="info-item">

            <span>Game</span>

            <strong>
              {{ product.game_name }}
            </strong>

          </div>

          <div class="info-item">

            <span>Status Saat Ini</span>

            <q-badge :color="product.is_active ? 'positive' : 'negative'">
              {{ product.is_active ? 'Active' : 'Inactive' }}
            </q-badge>

          </div>

        </div>

        <q-banner rounded class="warning-banner">
          Setelah dinonaktifkan, produk tidak akan muncul pada halaman pelanggan,
          tetapi data masih tersimpan dan dapat diaktifkan kembali melalui Update Product.
        </q-banner>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <q-btn unelevated color="negative" icon="delete" no-caps label="Disable Product" :loading="loading"
          @click="deleteProduct" />

      </div>

    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref } from 'vue'
import { useQuasar } from 'quasar'
import api from 'src/axios'

const $q = useQuasar()

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

    $q.notify({
      type: 'positive',
      message: 'Product berhasil dinonaktifkan.',
    })

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

    $q.notify({
      type: 'negative',
      message: 'Gagal menonaktifkan product.',
    })

  } finally {

    loading.value = false

  }

}
</script>

<style lang="scss" scoped>
.dialog-card {
  width: 560px;
  max-width: 96vw;

  border-radius: 24px;

  background: var(--app-surface);

  color: var(--app-text);

  overflow: hidden;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {
  padding: 0;
}

.dialog-handle {
  width: 48px;
  height: 5px;

  margin: 12px auto 0;

  border-radius: 999px;

  background: var(--app-border);
}

.header-content {
  display: flex;

  justify-content: space-between;
  align-items: center;

  padding: 20px 24px;
}

.dialog-title {
  margin: 0;

  color: var(--app-text);

  font-size: 1.35rem;
  font-weight: 700;
}

.dialog-subtitle {
  margin-top: 6px;

  color: var(--app-text-secondary);

  font-size: .92rem;
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 18px;

  padding: 30px 24px;

  text-align: center;
}

.warning-icon {
  margin-bottom: 4px;
}

.product-name {
  margin: 0;

  color: var(--app-text);

  font-size: 1.3rem;
  font-weight: 700;
}

.warning-text {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

.info-box {
  width: 100%;

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 16px;
}

.info-item {
  display: flex;
  flex-direction: column;

  gap: 6px;

  padding: 14px;

  border: 1px solid var(--app-border);

  border-radius: 14px;
}

.info-item span {
  color: var(--app-text-secondary);

  font-size: .82rem;
}

.info-item strong {
  color: var(--app-text);

  font-size: .95rem;
}

.warning-banner {
  width: 100%;

  background: rgba(255, 193, 7, .12);

  color: var(--app-text);

  text-align: left;
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {
  display: flex;

  justify-content: flex-end;

  padding: 18px 24px;
}

.dialog-footer .q-btn {
  min-width: 180px;

  border-radius: 14px;

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .dialog-card {
    width: 100vw;

    border-radius: 22px 22px 0 0;
  }

  .info-box {
    grid-template-columns: 1fr;
  }

  .dialog-footer .q-btn {
    width: 100%;
  }

}
</style>
