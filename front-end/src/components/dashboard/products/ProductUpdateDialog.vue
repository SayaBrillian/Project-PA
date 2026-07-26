<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle" />

        <div class="header-content">

          <div>

            <h2 class="dialog-title">

              Update Product

            </h2>

            <p class="dialog-subtitle">

              Perbarui informasi produk.

            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <!-- PRODUCT INFORMATION -->

        <section class="dialog-section">

          <h3 class="section-title">

            Product Information

          </h3>

          <div class="form-grid">

            <q-select v-model="form.game_id" outlined emit-value map-options :options="gameOptions" label="Game" />

            <q-input v-model="form.name" outlined label="Product Name" />

            <q-input v-model="form.slug" outlined label="Slug" />

          </div>

        </section>

        <!-- PRICING -->

        <section class="dialog-section">

          <h3 class="section-title">

            Pricing

          </h3>

          <div class="form-grid">

            <q-input v-model.number="form.price" outlined type="number" prefix="Rp" label="Price" />

            <q-input v-model.number="form.display_order" outlined type="number" label="Display Order" />

          </div>

        </section>

        <!-- SETTINGS -->

        <section class="dialog-section">

          <h3 class="section-title">

            Settings

          </h3>

          <q-toggle v-model="form.is_active" color="accent" label="Product Active" />

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" icon="save" no-caps label="Update Product" :loading="loading"
            @click="updateProduct" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  ref,
  watch,
  onMounted,
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

  price: null,

  display_order: 0,

  is_active: true,
})

/*
|--------------------------------------------------------------------------
| LOAD GAMES
|--------------------------------------------------------------------------
*/

const loadGames = async () => {

  try {

    const response =
      await api.get('/api/games')

    gameOptions.value =
      response.data.games.map(game => ({
        label: game.name,
        value: game.id,
      }))

  } catch (error) {

    console.error(
      'Load Games Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| WATCH PRODUCT
|--------------------------------------------------------------------------
*/

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

/*
|--------------------------------------------------------------------------
| UPDATE PRODUCT
|--------------------------------------------------------------------------
*/

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

/*
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadGames()

})
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {
  width: 900px;
  max-width: 96vw;
  height: 85vh;
  max-height: 85vh;

  display: flex;
  flex-direction: column;

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
  flex-shrink: 0;
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

  font-size: 1.45rem;
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
  flex: 1;

  overflow-y: auto;

  padding: 24px;
}

.dialog-section:not(:last-child) {
  margin-bottom: 28px;
}

.section-title {
  margin: 0 0 18px;

  color: var(--app-text);

  font-size: 1rem;
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

:deep(.q-field) {
  border-radius: 14px;
}

:deep(.q-field__control) {
  border-radius: 14px;
}

:deep(.q-field__native),
:deep(.q-field__input) {
  color: var(--app-text);
}

:deep(.q-field__label) {
  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {
  flex-shrink: 0;

  padding: 18px 24px;
}

.footer-actions {
  display: flex;

  justify-content: flex-end;
}

.footer-actions .q-btn {
  min-width: 180px;

  border-radius: 14px;

  font-weight: 600;
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
  border-radius: 999px;

  background: rgba(127, 127, 127, .35);
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .dialog-card {
    width: 100vw;
    max-width: 100vw;

    height: 92vh;
    max-height: 92vh;

    border-radius: 22px 22px 0 0;
  }

  .header-content {
    padding: 18px;
  }

  .dialog-content {
    padding: 18px;
  }

  .dialog-footer {
    padding: 18px;
  }

  .form-grid {
    grid-template-columns: 1fr;
  }

  .footer-actions .q-btn {
    width: 100%;
  }

}
</style>
