<template>

  <section class="summary-section">

    <!-- HEADER -->
    <div class="section-header">

      <span class="section-badge">
        Ringkasan
      </span>

      <h2>
        Ringkasan Pesanan
      </h2>

      <p>
        Pastikan seluruh data sudah benar sebelum melanjutkan pembayaran.
      </p>

    </div>

    <!-- SUMMARY -->
    <div class="summary-list">

      <div class="summary-item">

        <span class="summary-label">

          Produk

        </span>

        <span class="summary-value">

          {{ selectedProduct?.name || '-' }}

        </span>

      </div>

      <div class="summary-item">

        <span class="summary-label">

          Jumlah Akun

        </span>

        <span class="summary-value">

          {{ targets.length }}

        </span>

      </div>

      <div class="summary-item">

        <span class="summary-label">

          Harga Satuan

        </span>

        <span class="summary-value">

          Rp
          {{
            selectedProduct
              ? Number(selectedProduct.price)
                .toLocaleString('id-ID')
              : 0
          }}

        </span>

      </div>

    </div>

    <!-- TOTAL -->
    <div class="summary-total">

      <div class="summary-total-label">

        Total Pembayaran

      </div>

      <div class="summary-total-price">

        Rp
        {{ totalPrice.toLocaleString('id-ID') }}

      </div>

    </div>

    <!-- ACTION -->
    <q-btn unelevated color="primary" no-caps size="lg" class="checkout-btn" label="Bayar Sekarang"
      :disable="!canCheckout" @click="
        emit('checkout')
        " />

  </section>

</template>

<script setup>
/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

defineProps({

  selectedProduct: {
    type: Object,
    default: null,
  },

  targets: {
    type: Array,
    default: () => [],
  },

  totalPrice: {
    type: Number,
    default: 0,
  },

  canCheckout: {
    type: Boolean,
    default: false,
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'checkout',
])
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.summary-section {
  display: flex;
  flex-direction: column;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.section-header {
  margin-bottom: 24px;
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

.section-header h2 {
  margin: 16px 0 10px;

  color: var(--app-text);

  font-size: 1.5rem;
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;

  font-size: .95rem;
}

/*
|--------------------------------------------------------------------------
| SUMMARY
|--------------------------------------------------------------------------
*/

.summary-list {
  display: flex;
  flex-direction: column;

  gap: 18px;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;

  gap: 16px;
}

.summary-label {
  color: var(--app-text-secondary);

  font-size: .92rem;
}

.summary-value {
  text-align: right;

  color: var(--app-text);

  font-weight: 600;

  word-break: break-word;
}

/*
|--------------------------------------------------------------------------
| TOTAL
|--------------------------------------------------------------------------
*/

.summary-total {
  margin-top: 28px;

  padding-top: 24px;

  border-top: 1px solid var(--app-border);
}

.summary-total-label {
  color: var(--app-text-secondary);

  font-size: .9rem;
}

.summary-total-price {
  margin-top: 10px;

  color: var(--app-primary);

  font-size: 2rem;
  font-weight: 700;

  line-height: 1.2;
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

.checkout-btn {
  width: 100%;

  margin-top: 32px;

  border-radius: 16px;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .summary-section {
    margin-top: 48px;
  }

  .section-header h2 {
    font-size: 1.4rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .summary-item {
    font-size: .92rem;
  }

  .summary-total-price {
    font-size: 1.75rem;
  }

}
</style>
