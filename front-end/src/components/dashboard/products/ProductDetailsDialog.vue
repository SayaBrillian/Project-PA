<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card v-if="product" class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle" />

        <div class="header-content">

          <div>

            <h2 class="dialog-title">

              {{ product.name }}

            </h2>

            <p class="dialog-subtitle">

              {{ product.game_name }}

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

          <div class="detail-grid">

            <div class="detail-item">

              <span>

                Product Name

              </span>

              <strong>

                {{ product.name }}

              </strong>

            </div>

            <div class="detail-item">

              <span>

                Game

              </span>

              <strong>

                {{ product.game_name }}

              </strong>

            </div>

            <div class="detail-item">

              <span>

                Slug

              </span>

              <strong>

                {{ product.slug }}

              </strong>

            </div>

            <div class="detail-item">

              <span>

                Display Order

              </span>

              <strong>

                {{ product.display_order }}

              </strong>

            </div>

          </div>

        </section>

        <!-- PRICING -->

        <section class="dialog-section">

          <h3 class="section-title">

            Pricing

          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>

                Price

              </span>

              <strong>

                Rp
                {{
                  Number(
                    product.price
                  ).toLocaleString(
                    'id-ID'
                  )
                }}

              </strong>

            </div>

          </div>

        </section>

        <!-- STATUS -->

        <section class="dialog-section">

          <h3 class="section-title">

            Status

          </h3>

          <q-badge :color="product.is_active
            ? 'positive'
            : 'negative'
            ">

            {{
              product.is_active
                ? 'Active'
                : 'Inactive'
            }}

          </q-badge>

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn flat color="negative" icon="delete" no-caps label="Delete" @click="
            emit(
              'delete',
              product
            )
            " />

          <q-btn unelevated color="accent" icon="edit" no-caps label="Update Product" @click="
            emit(
              'update',
              product
            )
            " />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>
defineProps({

  modelValue: Boolean,

  product: {
    type: Object,
    default: null,
  },

})

const emit = defineEmits([

  'update:modelValue',

  'update',

  'delete',

])
</script>

<style lang="scss" scoped>
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {
  width: 820px;
  max-width: 96vw;
  max-height: 90vh;

  display: flex;
  flex-direction: column;

  overflow: hidden;

  border-radius: 24px;

  background: var(--app-surface);
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {
  flex-shrink: 0;

  background: var(--app-surface);
}

.dialog-handle {
  width: 52px;
  height: 5px;

  margin: 12px auto 0;

  border-radius: 999px;

  background: var(--app-border);
}

.header-content {
  display: flex;

  justify-content: space-between;
  align-items: flex-start;

  padding: 24px;
}

.dialog-title {
  margin: 0;

  color: var(--app-text);

  font-size: 1.45rem;
  font-weight: 700;
}

.dialog-subtitle {
  margin: 6px 0 0;

  color: var(--app-text-secondary);

  font-size: .95rem;
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

.dialog-section+.dialog-section {
  margin-top: 32px;
}

.section-title {
  margin: 0 0 18px;

  color: var(--app-text);

  font-size: 1rem;
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

  padding: 16px;

  border: 1px solid var(--app-border);
  border-radius: 16px;

  background: var(--app-surface-2);
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
| BADGE
|--------------------------------------------------------------------------
*/

:deep(.q-badge) {
  min-width: 90px;

  justify-content: center;

  padding: 8px 14px;

  border-radius: 999px;

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {
  flex-shrink: 0;

  padding: 20px 24px;

  background: var(--app-surface);
}

.footer-actions {
  display: flex;

  justify-content: flex-end;

  gap: 12px;
}

.footer-actions :deep(.q-btn) {
  border-radius: 12px;

  padding-inline: 18px;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .dialog-card {
    width: 100%;
    max-width: 100%;

    max-height: 88vh;

    border-radius: 24px 24px 0 0;
  }

  .header-content,
  .dialog-content,
  .dialog-footer {
    padding: 20px;
  }

  .detail-grid {
    grid-template-columns: 1fr;
  }

  .footer-actions {
    flex-direction: column-reverse;
  }

  .footer-actions :deep(.q-btn) {
    width: 100%;
  }

}
</style>
