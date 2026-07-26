<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card v-if="game" class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle"></div>

        <div class="header-content">

          <div>

            <h2 class="dialog-title">

              Delete Game

            </h2>

            <p class="dialog-subtitle">

              Tindakan ini tidak dapat dibatalkan.

            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <div class="warning-box">

          <q-icon name="warning" color="negative" size="30px" />

          <div>

            <div class="warning-title">

              Anda akan menghapus game berikut

            </div>

            <div class="warning-subtitle">

              Data game akan dihapus dari sistem.

            </div>

          </div>

        </div>

        <div class="dialog-section">

          <h3 class="section-title">

            Game Information

          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Game Name</span>

              <strong>

                {{ game.name }}

              </strong>

            </div>

            <div class="detail-item">

              <span>Publisher</span>

              <strong>

                {{ game.publisher || '-' }}

              </strong>

            </div>

            <div class="detail-item">

              <span>Game Key</span>

              <strong>

                {{ game.game_key }}

              </strong>

            </div>

            <div class="detail-item">

              <span>Status</span>

              <strong>

                {{
                  game.is_active
                    ? 'Active'
                    : 'Inactive'
                }}

              </strong>

            </div>

          </div>

        </div>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="negative" icon="delete" no-caps label="Delete Game" :loading="loading"
            @click="deleteGame" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  ref,
} from 'vue'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

const $q = useQuasar()

const props = defineProps({

  modelValue: Boolean,

  game: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'deleted',

])

const loading = ref(false)

const deleteGame = async () => {

  if (!props.game) return

  try {

    loading.value = true

    await api.delete(

      `/api/games/${props.game.id}`

    )

    emit('deleted')

    emit('update:modelValue', false)

  }

  catch (error) {

    console.error(

      'Delete Game Error:',

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

  width: 560px;
  max-width: 95vw;

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

  font-size: 1.6rem;
  font-weight: 700;

}

.dialog-subtitle {

  margin: 0;

  color: var(--app-text-secondary);

}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {

  padding: 28px;

}

.warning-box {

  display: flex;

  gap: 16px;

  padding: 18px;

  margin-bottom: 28px;

  border-radius: 16px;

  background: rgba(244, 67, 54, .08);

}

.warning-title {

  font-weight: 700;

  color: var(--app-text);

}

.warning-subtitle {

  margin-top: 4px;

  color: var(--app-text-secondary);

  line-height: 1.6;

}

.dialog-section {

  display: flex;
  flex-direction: column;

  gap: 18px;

}

.section-title {

  margin: 0;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;

}

.detail-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

.detail-item {

  display: flex;
  flex-direction: column;

  gap: 6px;

}

.detail-item span {

  color: var(--app-text-secondary);

  font-size: .82rem;

}

.detail-item strong {

  color: var(--app-text);

}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {

  padding: 24px 28px;

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
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .dialog-card {

    width: 100vw;

    max-width: 100vw;

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

  }

  .detail-grid {

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
