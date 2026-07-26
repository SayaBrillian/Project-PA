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

              Game Details

            </h2>

            <p class="dialog-subtitle">

              Lihat informasi lengkap game.

            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <!-- GAME INFORMATION -->

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

              <span>Slug</span>

              <strong>

                {{ game.slug }}

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

              <q-badge :color="game.is_active
                ? 'positive'
                : 'negative'
                ">

                {{
                  game.is_active
                    ? 'Active'
                    : 'Inactive'
                }}

              </q-badge>

            </div>

          </div>

        </div>

        <!-- VERSION -->

        <div class="dialog-section">

          <h3 class="section-title">

            Version Information

          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Latest Patch</span>

              <strong>

                {{ game.latest_patch || '-' }}

              </strong>

            </div>

            <div class="detail-item">

              <span>Latest Update</span>

              <strong>

                {{ game.latest_update || '-' }}

              </strong>

            </div>

          </div>

        </div>

        <!-- DESCRIPTION -->

        <div class="dialog-section">

          <h3 class="section-title">

            Description

          </h3>

          <p class="description">

            {{ game.description || '-' }}

          </p>

        </div>

        <!-- LINKS -->

        <div class="dialog-section">

          <h3 class="section-title">

            Links

          </h3>

          <div class="links">

            <q-btn outline color="accent" icon="public" label="Official Website" :href="game.official_url"
              target="_blank" :disable="!game.official_url" />

            <q-btn outline color="accent" icon="description" label="Patch Notes" :href="game.patchnote_url"
              target="_blank" :disable="!game.patchnote_url" />

          </div>

        </div>

        <!-- SYSTEM -->

        <div class="dialog-section">

          <h3 class="section-title">

            System Information

          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Created At</span>

              <strong>

                {{

                  new Date(game.created_at)
                    .toLocaleString('id-ID')

                }}

              </strong>

            </div>

            <div class="detail-item">

              <span>Updated At</span>

              <strong>

                {{

                  new Date(game.updated_at)
                    .toLocaleString('id-ID')

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

          <q-btn flat color="negative" icon="delete" no-caps label="Delete Game" @click="emit('delete', game)" />

          <q-btn unelevated color="accent" icon="edit" no-caps label="Update Game" @click="emit('update', game)" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  useQuasar,
} from 'quasar'

const $q = useQuasar()

defineProps({

  modelValue: Boolean,

  game: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'update',

  'delete',

])

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

  font-size: 1.1rem;
  font-weight: 700;

}

/*
|--------------------------------------------------------------------------
| DETAILS
|--------------------------------------------------------------------------
*/

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

  font-size: .96rem;
  font-weight: 600;

  word-break: break-word;

}

/*
|--------------------------------------------------------------------------
| DESCRIPTION
|--------------------------------------------------------------------------
*/

.description {

  margin: 0;

  color: var(--app-text);

  line-height: 1.8;

  white-space: pre-wrap;

}

/*
|--------------------------------------------------------------------------
| LINKS
|--------------------------------------------------------------------------
*/

.links {

  display: flex;

  flex-wrap: wrap;

  gap: 12px;

}

.links :deep(.q-btn) {

  border-radius: 14px;

}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {

  width: fit-content;

  border-radius: 999px;

  padding: 6px 12px;

  font-weight: 600;

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

  gap: 12px;

}

.footer-actions :deep(.q-btn) {

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

  .detail-grid {

    grid-template-columns: 1fr;

  }

  .links {

    display: grid;

    grid-template-columns: 1fr;

  }

  .links :deep(.q-btn) {

    width: 100%;

  }

  .footer-actions {

    display: grid;

    grid-template-columns: 1fr;

  }

  .footer-actions :deep(.q-btn) {

    width: 100%;

  }

}
</style>
