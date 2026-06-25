<template>
  <q-dialog
    :model-value="modelValue"
    @update:model-value="
      emit('update:modelValue', $event)
    "
  >
    <q-card class="dialog-card">

      <!-- HEADER -->

      <q-card-section>

        <div class="dialog-title">
          Confirm Your Order
        </div>

        <div class="dialog-subtitle">
          Pastikan seluruh data sudah benar sebelum melanjutkan pembayaran.
        </div>

      </q-card-section>

      <q-separator />

      <!-- PRODUCT -->

      <q-card-section>

        <div class="section-title">
          Product Information
        </div>

        <div class="detail-grid">

          <div class="detail-item">
            <span>Game</span>

            <strong>
              {{ order.gameName }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Product</span>

            <strong>
              {{ order.productName }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Quantity</span>

            <strong>
              {{ order.quantity }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Total</span>

            <strong>
              Rp
              {{ Number(order.totalPrice).toLocaleString('id-ID') }}
            </strong>
          </div>

        </div>

      </q-card-section>

      <q-separator />

      <!-- TARGET -->

      <q-card-section>

        <div class="section-title">
          Game Targets
        </div>

        <q-card
          flat
          bordered
          class="target-card"
          v-for="(target, index) in order.targets"
          :key="index"
        >

          <q-card-section>

            <div class="target-title">
              Target {{ index + 1 }}
            </div>

            <div class="detail-grid">

              <div class="detail-item">

                <span>UID</span>

                <strong>
                  {{ target.game_uid }}
                </strong>

              </div>

              <div class="detail-item">

                <span>Server</span>

                <strong>
                  {{ target.game_server }}
                </strong>

              </div>

            </div>

          </q-card-section>

        </q-card>

      </q-card-section>

      <q-separator />

      <!-- CUSTOMER -->

      <q-card-section>

        <div class="section-title">
          Customer Information
        </div>

        <div class="detail-grid">

          <div class="detail-item">

            <span>Email</span>

            <strong>
              {{ order.customerEmail }}
            </strong>

          </div>

          <div class="detail-item">

            <span>WhatsApp</span>

            <strong>
              {{ order.customerWhatsapp }}
            </strong>

          </div>

        </div>

      </q-card-section>

      <q-separator />

      <!-- AGREEMENT -->

      <q-card-section>

        <q-checkbox
          v-model="confirmed"
          color="accent"
          label="Saya telah memastikan seluruh data tujuan sudah benar."
        />

      </q-card-section>

      <!-- ACTION -->

      <q-card-actions align="right">

        <q-btn
          flat
          label="Cancel"
          v-close-popup
        />

        <q-btn
  color="accent"
  label="Continue Payment"
  :disable="!confirmed"
  @click="continuePayment"
/>

      </q-card-actions>

    </q-card>
  </q-dialog>
</template>

<script setup>
import {
  ref,
  watch,
} from 'vue'

const props = defineProps({

  modelValue: {
    type: Boolean,
    default: false,
  },

  order: {
    type: Object,
    default: () => ({
      gameName: '',
      productName: '',
      quantity: 1,
      totalPrice: 0,
      customerEmail: '',
      customerWhatsapp: '',
      targets: [],
    }),
  },

})

const emit = defineEmits([
  'update:modelValue',
  'confirm',
])

const confirmed =
  ref(false)

/*
|--------------------------------------------------------------------------
| RESET CHECKBOX
|--------------------------------------------------------------------------
*/

watch(
  () => props.modelValue,
  (value) => {

    if (value) {

      confirmed.value =
        false

    }

  }
)

/*
|--------------------------------------------------------------------------
| CONTINUE PAYMENT
|--------------------------------------------------------------------------
*/

const continuePayment =
  () => {

    emit('confirm')

    emit(
      'update:modelValue',
      false
    )

  }

</script>

<style lang="scss" scoped>

.dialog-card {

  width: 760px;

  max-width: 95vw;

  height: 80vh;

  display: flex;

  flex-direction: column;

}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-title {

  color: $dark;

  font-size: 1.4rem;
  font-weight: 700;

}

.dialog-subtitle {

  margin-top: 6px;

  color: rgba(
    0,
    0,
    0,
    .55
  );

  font-size: .9rem;

}

/*
|--------------------------------------------------------------------------
| SCROLL CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {

  flex: 1;

  overflow-y: auto;

}

/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.section-title {

  margin-bottom: 16px;

  color: $dark;

  font-size: 1rem;
  font-weight: 700;

}

/*
|--------------------------------------------------------------------------
| DETAIL GRID
|--------------------------------------------------------------------------
*/

.detail-grid {

  display: grid;

  grid-template-columns: repeat(
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

  margin-bottom: 4px;

  color: rgba(
    0,
    0,
    0,
    .55
  );

  font-size: .85rem;

}

.detail-item strong {

  color: $dark;

  font-weight: 600;

  word-break: break-word;

}

/*
|--------------------------------------------------------------------------
| TARGET CARD
|--------------------------------------------------------------------------
*/

.target-card {

  margin-bottom: 16px;

  border-radius: 16px;

  transition:
    transform .2s ease,
    box-shadow .2s ease;

}

.target-card:hover {

  transform: translateY(-2px);

  box-shadow:
    0 8px 20px rgba(
      0,
      0,
      0,
      .08
    );

}

.target-title {

  margin-bottom: 12px;

  color: $accent;

  font-weight: 700;

}

/*
|--------------------------------------------------------------------------
| ACTION
|--------------------------------------------------------------------------
*/

:deep(.q-card__actions) {

  padding: 16px 24px;

  border-top:
    1px solid rgba(
      0,
      0,
      0,
      .08
    );

  background: white;

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .dialog-card {

    width: 100%;

    max-width: 100vw;

    height: 80vh;

    border-radius: 20px;

  }

  .detail-grid {

    grid-template-columns: 1fr;

  }

}

</style>