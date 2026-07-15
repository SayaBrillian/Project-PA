<template>
  <section class="reason-section">

    <div class="section-header">

      <h2 class="section-title">
        Kenapa Belanja di EI Gaming Store?
      </h2>

      <p class="section-description">
        Kami menghadirkan pengalaman belanja game yang cepat,
        aman, dan nyaman untuk semua pemain.
      </p>

    </div>

    <div class="reason-grid">

      <q-card v-for="reason in reasons" :key="reason.title" flat class="reason-card">

        <q-icon :name="reason.icon" class="reason-icon" />

        <h3>
          {{ reason.title }}
        </h3>

        <p>
          {{ reason.description }}
        </p>

      </q-card>

    </div>

  </section>
</template>

<script setup>
const reasons = [
  {
    icon: 'sell',
    title: 'Harga Terbaik',
    description:
      'Nikmati harga kompetitif dengan promo menarik setiap saat.',
  },
  {
    icon: 'bolt',
    title: 'Proses Cepat',
    description:
      'Pesanan diproses dengan cepat tanpa menunggu lama.',
  },
  {
    icon: 'security',
    title: 'Pembayaran Aman',
    description:
      'Seluruh transaksi terlindungi dan menggunakan sistem terpercaya.',
  },
  {
    icon: 'verified',
    title: 'Terpercaya',
    description:
      'Dipercaya banyak pemain dengan pelayanan yang profesional.',
  },
]
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| REASON
|--------------------------------------------------------------------------
*/

.reason-section {
  display: flex;
  flex-direction: column;

  gap: 36px;
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

.section-title {
  margin: 0 0 12px;

  color: var(--app-text);

  font-size: clamp(1.9rem, 4vw, 2.3rem);
  font-weight: 700;
}

.section-description {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| GRID
|--------------------------------------------------------------------------
*/

.reason-grid {
  display: grid;

  grid-template-columns: repeat(4, 1fr);

  gap: 18px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.reason-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 12px;

  padding: 22px 18px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;

  transition:
    transform .2s ease,
    border-color .2s ease,
    background-color .2s ease;
}

.reason-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| ICON
|--------------------------------------------------------------------------
*/

.reason-icon {
  font-size: 32px;

  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| TEXT
|--------------------------------------------------------------------------
*/

.reason-card h3 {
  margin: 0;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;
}

.reason-card p {
  margin: 0;

  color: var(--app-text-secondary);

  font-size: .9rem;
  line-height: 1.6;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .reason-grid {
    grid-template-columns: repeat(2, 1fr);

    gap: 16px;
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .reason-section {
    gap: 28px;

    padding-inline: 16px;
  }

  .section-title {
    font-size: 1.6rem;
  }

  .section-description {
    font-size: .9rem;
  }

  .reason-grid {
    grid-template-columns: repeat(2, 1fr);

    gap: 12px;
  }

  .reason-card {
    gap: 10px;

    padding: 18px 14px;

    border-radius: 18px;
  }

  .reason-icon {
    font-size: 28px;
  }

  .reason-card h3 {
    font-size: .95rem;
  }

  .reason-card p {
    font-size: .8rem;

    line-height: 1.5;
  }

}
</style>
