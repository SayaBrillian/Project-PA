<template>
  <section class="purchase-section">
    <div class="section-header">
      <span class="section-badge">
        Mudah & Cepat
      </span>

      <h2>Cara Pembelian</h2>

      <p>
        Top up game favoritmu hanya dalam beberapa langkah.
      </p>
    </div>

    <div class="purchase-grid">
        <div class="flow-container">
            <div
              v-for="(step, index) in steps"
              :key="step.title"
              class="step-card"
            >
            <div class="step-number">
              {{ index + 1 }}
            </div>

            <q-icon
              :name="step.icon"
              class="step-icon"
            />

            <div class="step-title">
              {{ step.title }}
            </div>

            <div class="step-description">
              {{ step.description }}
            </div>
          </div>
        </div>

        <div class="payment-section">
          <h3>Metode Pembayaran</h3>

          <div class="payment-grid">
            <div
              v-for="method in payments"
              :key="method.name"
              class="payment-card"
              >
              <img
              :src="method.logo"
              :alt="method.name"
              class="payment-logo"
              >
            </div>
          </div>

          <div class="payment-note">
             Mendukung berbagai metode pembayaran populer di Indonesia.
          </div>
        </div>
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

<style lang="scss" scoped>
.purchase-section {
  margin-top: 96px;
}

.section-header {
  text-align: center;
  margin-bottom: 48px;
}

.section-badge {
  display: inline-block;
  padding: 6px 14px;

  color: $sakura;
  background: rgba($sakura, 0.08);

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;
}

.section-header h2 {
  margin: 16px 0 12px;
}

.section-header p {
  color: rgba(255, 255, 255, 0.65);
}

.flow-container {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16px;

  margin-bottom: 48px;
}

.payment-section {
  text-align: center;
}

.payment-section h3 {
  margin-bottom: 24px;
}

.step-card {

  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;

  gap: 12px;
  padding: 24px 16px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.1);
  border-radius: 20px;
}

.step-number {
  width: 42px;
  height: 42px;

  display: flex;
  align-items: center;
  justify-content: center;

  background: rgba($sakura, 0.12);

  border-radius: 50%;

  color: $sakura;
  font-weight: 700;
}

.step-icon {
  font-size: 30px;
  color: $sakura;
}

.step-title {
  font-weight: 600;
}

.step-description {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.65);
}

.payment-container {
  padding: 24px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.1);
  border-radius: 20px;
}

.payment-container h3 {
  margin: 0 0 20px;
}

.payment-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.payment-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;

  padding: 16px;

  transition: all 0.25s ease;
}

.payment-card:hover {
  transform: translateY(-4px);
  border-color: rgba($sakura, 0.3);
}

.payment-logo {
  height: 32px;
  width: auto;

  object-fit: contain;
}

.payment-name {
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.8);
}

.payment-note {
  margin-top: 20px;

  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.6);
}

@media (max-width: 1024px) {
  .flow-container {
    grid-template-columns: repeat(3, 1fr);
  }

  .payment-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .flow-container {
    grid-template-columns: repeat(2, 1fr);
  }

  .payment-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .flow-container {
    grid-template-columns: 1fr;
  }

  .payment-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
