<template>
  <section class="purchase-section">

    <div class="section-header">

      <span class="section-badge">
        Mudah & Cepat
      </span>

      <h2>
        Cara Pembelian
      </h2>

      <p>
        Top up game favoritmu hanya dalam beberapa langkah.
      </p>

    </div>

    <div class="step-grid">

      <div v-for="(step, index) in steps" :key="step.title" class="step-card">

        <div class="step-top">

          <div class="step-number">
            {{ index + 1 }}
          </div>

          <div v-if="index < steps.length - 1" class="step-line" />

        </div>

        <q-icon :name="step.icon" class="step-icon" />

        <div class="step-title">
          {{ step.title }}
        </div>

        <div class="step-description">
          {{ step.description }}
        </div>

      </div>

    </div>

    <div class="payment-section">

      <h3>
        Metode Pembayaran
      </h3>

      <div class="payment-grid">

        <div v-for="payment in payments" :key="payment.name" class="payment-card">

          <img :src="payment.logo" :alt="payment.name" class="payment-logo">

        </div>

      </div>

      <p class="payment-note">
        Mendukung berbagai metode pembayaran populer di Indonesia.
      </p>

    </div>

  </section>
</template>

<script setup>
import qrisLogo from 'src/assets/payment/qris.svg'
import danaLogo from 'src/assets/payment/dana.svg'
import gopayLogo from 'src/assets/payment/gopay.svg'

const steps = [
  {
    icon: 'sports_esports',
    title: 'Pilih Game',
    description: 'Temukan game dan produk yang ingin dibeli.'
  },
  {
    icon: 'contact_mail',
    title: 'Masukkan Kontak',
    description: 'Isi email atau nomor WhatsApp untuk notifikasi.'
  },
  {
    icon: 'badge',
    title: 'Isi UID & Server',
    description: 'Masukkan data akun game dengan aman.'
  },
  {
    icon: 'payments',
    title: 'Bayar',
    description: 'Pilih metode pembayaran favoritmu.'
  },
  {
    icon: 'flash_on',
    title: 'Pesanan Diproses',
    description: 'Produk dikirim secara otomatis.'
  }
]

const payments = [
  {
    name: 'QRIS',
    logo: qrisLogo
  },
  {
    name: 'DANA',
    logo: danaLogo
  },
  {
    name: 'GoPay',
    logo: gopayLogo
  }
]
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PURCHASE
|--------------------------------------------------------------------------
*/

.purchase-section {
  display: flex;
  flex-direction: column;

  gap: 40px;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.section-header {
  max-width: 640px;

  margin: 0 auto;

  text-align: center;
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
  margin: 16px 0 12px;

  color: var(--app-text);

  font-size: clamp(1.9rem, 4vw, 2.3rem);
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| STEP GRID
|--------------------------------------------------------------------------
*/

.step-grid {
  display: grid;

  grid-template-columns: repeat(5, 1fr);

  gap: 18px;
}

/*
|--------------------------------------------------------------------------
| STEP CARD
|--------------------------------------------------------------------------
*/

.step-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  text-align: center;

  padding: 22px 18px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.step-card:hover {

  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);

}

/*
|--------------------------------------------------------------------------
| STEP TOP
|--------------------------------------------------------------------------
*/

.step-top {
  display: flex;
  align-items: center;

  width: 100%;

  margin-bottom: 18px;
}

.step-number {
  width: 38px;
  height: 38px;

  display: flex;
  align-items: center;
  justify-content: center;

  flex-shrink: 0;

  border-radius: 50%;

  background: var(--app-primary);

  color: white;

  font-size: .9rem;
  font-weight: 700;
}

.step-line {
  flex: 1;

  height: 2px;

  margin-left: 10px;

  background: var(--app-border);
}

/*
|--------------------------------------------------------------------------
| STEP CONTENT
|--------------------------------------------------------------------------
*/

.step-icon {
  margin-bottom: 14px;

  font-size: 30px;

  color: var(--app-primary);
}

.step-title {
  margin-bottom: 8px;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;
}

.step-description {
  color: var(--app-text-secondary);

  font-size: .9rem;

  line-height: 1.6;
}

/*
|--------------------------------------------------------------------------
| PAYMENT
|--------------------------------------------------------------------------
*/

.payment-section {
  text-align: center;
}

.payment-section h3 {
  margin-bottom: 24px;

  color: var(--app-text);
}

.payment-grid {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;

  gap: 14px;
}

.payment-card {
  display: flex;
  align-items: center;
  justify-content: center;

  width: 90px;
  height: 60px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 16px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.payment-card:hover {

  transform: translateY(-3px);

  background: var(--app-hover);

  border-color: var(--app-primary);

}

.payment-logo {
  width: 58px;

  height: auto;

  object-fit: contain;
}

.payment-note {
  margin-top: 20px;

  color: var(--app-text-secondary);

  font-size: .9rem;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 1100px) {

  .step-grid {

    grid-template-columns: repeat(3, 1fr);

  }

}

@media (max-width: 800px) {

  .step-grid {

    grid-template-columns: repeat(2, 1fr);

  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:600px) {

  .purchase-section {

    gap: 28px;

    padding-inline: 16px;

  }

  .section-header h2 {

    font-size: 1.6rem;

  }

  .section-header p {

    font-size: .9rem;

  }

  .step-grid {

    grid-template-columns: 1fr;

    gap: 14px;

  }

  .step-card {

    align-items: flex-start;

    text-align: left;

    padding: 18px 16px;

  }

  .step-top {

    margin-bottom: 14px;

  }

  .step-icon {

    margin-bottom: 10px;

    font-size: 26px;

  }

  .step-title {

    font-size: .95rem;

  }

  .step-description {

    font-size: .82rem;

  }

  .payment-grid {

    gap: 10px;

  }

  .payment-card {

    width: 84px;
    height: 54px;

  }

}
</style>
