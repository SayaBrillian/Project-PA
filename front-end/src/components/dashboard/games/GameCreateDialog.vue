<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined" @update:model-value="
    emit('update:modelValue', $event)">

    <q-card class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle"></div>

        <div class="header-content">

          <div>

            <h2 class="dialog-title">

              Add Game

            </h2>

            <p class="dialog-subtitle">

              Tambahkan game baru ke dalam sistem.

            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <!-- BASIC INFORMATION -->

        <div class="dialog-section">

          <h3 class="section-title">

            Basic Information

          </h3>

          <div class="form-grid">

            <q-input v-model="form.name" outlined label="Game Name" />

            <q-input v-model="form.slug" outlined label="Slug" />

            <q-input v-model="form.game_key" outlined label="Game Key" />

            <q-input v-model="form.publisher" outlined label="Publisher" />

          </div>

        </div>

        <!-- GAME INFORMATION -->

        <div class="dialog-section">

          <h3 class="section-title">

            Game Information

          </h3>

          <q-input v-model="form.description" outlined autogrow type="textarea" label="Description" />

          <div class="form-grid">

            <q-input v-model="form.latest_patch" outlined label="Latest Patch" />

            <q-input v-model="form.latest_update" outlined label="Latest Update">

              <template #append>

                <q-icon name="event" class="cursor-pointer">

                  <q-popup-proxy cover transition-show="scale" transition-hide="scale">

                    <q-date v-model="form.latest_update" mask="YYYY-MM-DD" />

                  </q-popup-proxy>

                </q-icon>

              </template>

            </q-input>

          </div>

        </div>

        <!-- LINKS -->

        <div class="dialog-section">

          <h3 class="section-title">

            Links

          </h3>

          <q-input v-model="form.official_url" outlined type="url" label="Official Website" />

          <q-input v-model="form.patchnote_url" outlined type="url" label="Patch Notes URL" />

          <q-toggle v-model="form.is_active" color="accent" label="Active" />

        </div>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" no-caps icon="add" label="Create Game" :loading="loading"
            @click="createGame" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  ref,
  watch,
} from 'vue'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

const $q = useQuasar()

const props = defineProps({

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

  is_active: true,

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

    is_active: true,

  }

}

watch(

  () => props.modelValue,

  (opened) => {

    if (opened) {

      resetForm()

    }

  }

)

const createGame = async () => {

  try {

    loading.value = true

    await api.post(

      '/api/games',

      form.value,

    )

    emit('created')

    emit(

      'update:modelValue',

      false,

    )

    resetForm()

  }

  catch (error) {

    console.error(

      'Create Game Error:',

      error,

    )

  }

  finally {

    loading.value = false

  }

}

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

.dialog-section {

  display: flex;
  flex-direction: column;

  gap: 20px;

  margin-bottom: 32px;

}

.dialog-section:last-child {

  margin-bottom: 0;

}

.section-title {

  margin: 0;

  color: var(--app-text);

  font-size: 1.05rem;
  font-weight: 700;

}

.form-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

.col-span-2 {

  grid-column: span 2;

}

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

:deep(.q-field__control) {

  border-radius: 14px;

}

:deep(.q-field__native) {

  color: var(--app-text);

}

:deep(.q-field__label) {

  color: var(--app-text-secondary);

}

:deep(.q-toggle) {

  margin-top: 8px;

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

  min-width: 180px;

  border-radius: 14px;

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

  background: var(--app-border);

  border-radius: 999px;

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

  .col-span-2 {

    grid-column: span 1;

  }

  .footer-actions {

    display: grid;

  }

  .footer-actions :deep(.q-btn) {

    width: 100%;

  }

}
</style>
