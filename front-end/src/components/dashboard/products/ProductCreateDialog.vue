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

              Add Product

            </h2>

            <p class="dialog-subtitle">

              Tambahkan produk baru ke dalam game.

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

            <q-select v-model="form.game_id" :options="gameOptions" label="Game" emit-value map-options filled
              bg-color="var(--app-surface)" />

            <q-input v-model="form.name" label="Product Name" filled bg-color="var(--app-surface)" />

            <q-input v-model="form.slug" label="Slug" filled bg-color="var(--app-surface)" />

          </div>

        </section>

        <!-- PRICING -->

        <section class="dialog-section">

          <h3 class="section-title">

            Pricing

          </h3>

          <div class="form-grid">

            <q-input v-model.number="form.price" label="Price" type="number" prefix="Rp" filled
              bg-color="var(--app-surface)" />

            <q-input v-model.number="form.display_order" label="Display Order" type="number" filled
              bg-color="var(--app-surface)" />

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

          <q-btn unelevated color="accent" icon="add" no-caps label="Create Product" :loading="loading"
            @click="createProduct" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  ref,
  onMounted,
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
      response.data.games.map(
        game => ({
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

/*
|--------------------------------------------------------------------------
| RESET FORM
|--------------------------------------------------------------------------
*/

const resetForm = () => {

  form.value = {

    game_id: null,

    name: '',

    slug: '',

    price: null,

    display_order: 0,

    is_active: true,

  }

}

/*
|--------------------------------------------------------------------------
| CREATE PRODUCT
|--------------------------------------------------------------------------
*/

const createProduct = async () => {

  try {

    loading.value = true

    await api.post(

      '/api/products',

      form.value,

    )

    emit('created')

    emit(
      'update:modelValue',
      false,
    )

    resetForm()

  } catch (error) {

    console.error(
      'Create Product Error:',
      error,
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

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {

  width: 700px;
  max-width: 95vw;

  height: 80vh;

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

.dialog-content::-webkit-scrollbar {

  width: 8px;

}

.dialog-content::-webkit-scrollbar-thumb {

  background: var(--app-border);

  border-radius: 999px;

}

/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.dialog-section:not(:first-child) {

  margin-top: 36px;

}

.section-title {

  margin: 0 0 18px;

  color: var(--app-text);

  font-size: 1.1rem;
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

  border-radius: 14px !important;

  background: var(--app-surface) !important;

}

:deep(.q-field__native),
:deep(.q-field__input) {

  color: var(--app-text);

}

:deep(.q-field__label) {

  color: var(--app-text-secondary);

}

:deep(.q-field--focused .q-field__label) {

  color: var(--q-accent);

}

/*
|--------------------------------------------------------------------------
| TOGGLE
|--------------------------------------------------------------------------
*/

:deep(.q-toggle__label) {

  color: var(--app-text);

}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {

  padding: 24px 28px;

  background: var(--app-bg);

  border-top: 1px solid var(--app-border);

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
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .dialog-card {

    width: 100vw;
    max-width: 100vw;

    height: 90vh;

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
