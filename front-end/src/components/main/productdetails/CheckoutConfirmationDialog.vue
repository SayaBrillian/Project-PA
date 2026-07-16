<template>

  <q-dialog :model-value="modelValue" @update:model-value="
    emit('update:modelValue', $event)
    ">

    <q-card class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div>

          <span class="section-badge">
            Konfirmasi
          </span>

          <h2 class="dialog-title">
            Konfirmasi Pesanan
          </h2>

          <p class="dialog-subtitle">
            Pastikan seluruh data sudah benar sebelum melanjutkan pembayaran.
          </p>

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <!-- PRODUCT -->

        <section class="dialog-section">

          <h3 class="section-title">
            Informasi Produk
          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>Game</span>

              <strong>
                {{ order.gameName }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Produk</span>

              <strong>
                {{ order.productName }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Jumlah</span>

              <strong>
                {{ order.quantity }}
              </strong>

            </div>

            <div class="detail-item">

              <span>Total</span>

              <strong>

                Rp
                {{
                  Number(order.totalPrice)
                    .toLocaleString('id-ID')
                }}

              </strong>

            </div>

          </div>

        </section>

        <!-- TARGET -->

        <section class="dialog-section">

          <h3 class="section-title">

            Akun Tujuan

          </h3>

          <div class="target-list">

            <div v-for="
(target, index)
  in order.targets
              " :key="index" class="target-card">

              <div class="target-title">

                Akun #{{ index + 1 }}

              </div>

              <div class="detail-grid">

                <div class="detail-item">

                  <span>

                    UID

                  </span>

                  <strong>

                    {{ target.game_uid }}

                  </strong>

                </div>

                <div class="detail-item">

                  <span>

                    Server

                  </span>

                  <strong>

                    {{ target.game_server }}

                  </strong>

                </div>

              </div>

            </div>

          </div>

        </section>

        <!-- CONTACT -->

        <section class="dialog-section">

          <h3 class="section-title">

            Informasi Kontak

          </h3>

          <div class="detail-grid">

            <div class="detail-item">

              <span>

                Email

              </span>

              <strong>

                {{ order.customerEmail }}

              </strong>

            </div>

            <div class="detail-item">

              <span>

                WhatsApp

              </span>

              <strong>

                {{ order.customerWhatsapp }}

              </strong>

            </div>

          </div>

        </section>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="payment-total">

          <div class="payment-label">

            Total Pembayaran

          </div>

          <div class="payment-price">

            Rp
            {{
              Number(order.totalPrice)
                .toLocaleString('id-ID')
            }}

          </div>

        </div>

        <q-checkbox v-model="confirmed" class="agreement"
          label="Saya telah memastikan seluruh data tujuan sudah benar." />

        <div class="footer-actions">

          <q-btn flat no-caps label="Kembali" @click="
            emit(
              'update:modelValue',
              false
            )
            " />

          <q-btn unelevated color="primary" no-caps label="Lanjut ke Pembayaran" :disable="!confirmed"
            @click="continuePayment" />

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

/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

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
      quantity: 0,
      totalPrice: 0,
      customerEmail: '',
      customerWhatsapp: '',
      targets: [],
    }),
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'update:modelValue',
  'confirm',
])

/*
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const confirmed = ref(false)

/*
|--------------------------------------------------------------------------
| RESET CHECKBOX
|--------------------------------------------------------------------------
*/

watch(

  () => props.modelValue,

  (value) => {

    if (value) {

      confirmed.value = false

    }

  },

)

/*
|--------------------------------------------------------------------------
| ACTION
|--------------------------------------------------------------------------
*/

function continuePayment() {

  emit('confirm')

  emit(
    'update:modelValue',
    false,
  )

}
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {
  width: 760px;
  max-width: 95vw;

  height: 85vh;

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

.section-badge {
  display: inline-flex;
  align-items: center;

  padding: 8px 16px;

  border-radius: 999px;

  background: var(--app-hover);
  border: 1px solid var(--app-border);

  color: var(--app-primary);

  font-size: .8rem;
  font-weight: 600;
}

.dialog-title {
  margin: 18px 0 10px;

  color: var(--app-text);

  font-size: 1.8rem;
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
  color: var(--app-text-secondary);

  font-size: .82rem;
}

.detail-item strong {
  color: var(--app-text);

  font-weight: 600;

  word-break: break-word;
}

/*
|--------------------------------------------------------------------------
| TARGET
|--------------------------------------------------------------------------
*/

.target-list {
  display: flex;
  flex-direction: column;

  gap: 16px;
}

.target-card {
  padding: 18px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  transition:
    background-color .2s ease,
    border-color .2s ease,
    transform .2s ease;
}

.target-card:hover {
  transform: translateY(-2px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.target-title {
  margin-bottom: 18px;

  color: var(--app-primary);

  font-size: .95rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {
  position: sticky;
  bottom: 0;

  padding: 24px 28px;

  background: var(--app-bg);

  border-top: 1px solid var(--app-border);

  z-index: 5;
}

.payment-total {
  margin-bottom: 20px;
}

.payment-label {
  color: var(--app-text-secondary);

  font-size: .9rem;
}

.payment-price {
  margin-top: 8px;

  color: var(--app-primary);

  font-size: 2rem;
  font-weight: 700;
}

.agreement {
  margin-bottom: 24px;
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

@media (max-width: 768px) {

  .dialog-card {
    width: 100vw;
    max-width: 100vw;

    height: 90vh;

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

  .dialog-title {
    font-size: 1.5rem;
  }

  .detail-grid {
    grid-template-columns: 1fr;
  }

  .payment-price {
    font-size: 1.7rem;
  }

  .footer-actions {
    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 12px;
  }

  .footer-actions :deep(.q-btn) {
    width: 100%;
  }

}
</style>
