<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined"
    @update:model-value="emit('update:modelValue', $event)">

    <q-card v-if="user" class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle"></div>

        <div class="header-content">

          <div>

            <h2 class="dialog-title">
              User Details
            </h2>

            <p class="dialog-subtitle">
              Informasi lengkap pengguna.
            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <!-- ACCOUNT -->

        <section class="dialog-section">

          <h3 class="section-title">
            Account Information
          </h3>

          <div class="detail-grid">

            <div class="detail-item">
              <span>User ID</span>
              <strong>#{{ user.id }}</strong>
            </div>

            <div class="detail-item">
              <span>Username</span>
              <strong>{{ user.username || '-' }}</strong>
            </div>

            <div class="detail-item">
              <span>Full Name</span>
              <strong>{{ user.name || '-' }}</strong>
            </div>

            <div class="detail-item">
              <span>Birth Date</span>

              <strong>
                {{
                  user.birth_date
                    ? new Date(user.birth_date).toLocaleDateString('id-ID')
                    : '-'
                }}
              </strong>

            </div>

          </div>

        </section>

        <!-- CONTACT -->

        <section class="dialog-section">

          <h3 class="section-title">
            Contact Information
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Email</span>

              <strong>{{ user.email || '-' }}</strong>

            </div>

            <div class="detail-item">

              <span>Phone</span>

              <strong>{{ user.phone || '-' }}</strong>

            </div>

          </div>

        </section>

        <!-- SYSTEM -->

        <section class="dialog-section">

          <h3 class="section-title">
            System Information
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Registered</span>

              <strong>
                {{
                  new Date(user.created_at)
                    .toLocaleString('id-ID')
                }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Last Updated</span>

              <strong>
                {{
                  new Date(user.updated_at)
                    .toLocaleString('id-ID')
                }}
              </strong>

            </div>

          </div>

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn unelevated color="accent" icon="edit" no-caps label="Update User" @click="emit('update', user)" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  useQuasar
} from 'quasar'

const $q = useQuasar()

defineProps({

  modelValue: Boolean,

  user: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'update',

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

.dialog-section:not(:first-child) {

  margin-top: 36px;

}

/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.section-title {

  margin: 0 0 18px;

  color: var(--app-text);

  font-size: 1.1rem;
  font-weight: 700;

}

/*
|--------------------------------------------------------------------------
| DETAIL
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

  font-size: .82rem;

  color: var(--app-text-secondary);

}

.detail-item strong {

  font-size: .96rem;

  color: var(--app-text);

  font-weight: 600;

  word-break: break-word;

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

  .footer-actions {

    display: grid;

  }

  .footer-actions :deep(.q-btn) {

    width: 100%;

  }

}
</style>
