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

    <q-card
      v-if="product"
      class="dialog-card"
    >

      <q-card-section>

        <div class="product-title">
          {{ product.name }}
        </div>

        <div class="product-game">
          {{ product.game_name }}
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="detail-grid">

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
              Currency Amount
            </span>

            <strong>
              {{ product.currency_amount }}
            </strong>

          </div>

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

          <div class="detail-item">

            <span>
              Display Order
            </span>

            <strong>
              {{ product.display_order }}
            </strong>

          </div>

          <div class="detail-item">

            <span>
              Status
            </span>

            <q-badge
              :color="
                product.is_active
                  ? 'positive'
                  : 'negative'
              "
            >
              {{
                product.is_active
                  ? 'Active'
                  : 'Inactive'
              }}
            </q-badge>

          </div>

        </div>

      </q-card-section>

      <q-card-actions align="right">

        <q-btn
          flat
          color="negative"
          label="Delete"
          @click="
            emit(
              'delete',
              product
            )
          "
        />

        <q-btn
          flat
          color="accent"
          label="Update"
          @click="
            emit(
              'update',
              product
            )
          "
        />

        <q-btn
          flat
          label="Close"
          v-close-popup
        />

      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>

defineProps({
  modelValue: Boolean,
  product: Object,
})

const emit = defineEmits([
  'update:modelValue',
  'update',
  'delete',
])

</script>

<style lang="scss" scoped>

.dialog-card {
  width: 700px;
  max-width: 95vw;

  border-radius: 24px;
}

.product-title {
  font-size: 1.4rem;
  font-weight: 700;

  color: $dark;
}

.product-game {
  margin-top: 4px;

  color: rgba(
    0,
    0,
    0,
    .55
  );
}

.detail-grid {
  display: grid;

  grid-template-columns:
    repeat(
      2,
      1fr
    );

  gap: 16px;
}

.detail-item {
  display: flex;

  flex-direction: column;
}

.detail-item span {
  color: rgba(
    0,
    0,
    0,
    .5
  );

  font-size: .85rem;
}

@media (max-width: 768px) {

  .detail-grid {

    grid-template-columns:
      1fr;

  }

}

</style>