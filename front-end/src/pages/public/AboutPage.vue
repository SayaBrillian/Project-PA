<template>
  <q-page class="about-page">

    <!-- HEADER -->
    <section class="page-header">

      <span class="section-badge">
        Tentang Kami
      </span>

      <h1>
        Kenali Lebih Dekat EI Gaming Store
      </h1>

      <p>
        Platform top up game yang menghadirkan transaksi cepat,
        aman, dan terpercaya untuk seluruh gamer di Indonesia.
      </p>

    </section>

    <!-- ABOUT -->
    <section class="about-section">

      <div class="about-content">

        <h2>
          Siapa Kami?
        </h2>

        <p>
          EI Gaming Store merupakan platform digital yang menyediakan
          layanan top up game, voucher, dan berbagai produk digital
          dengan proses yang cepat serta metode pembayaran yang aman.
        </p>

        <p>
          Kami percaya bahwa pengalaman pelanggan adalah prioritas utama.
          Oleh karena itu, setiap transaksi dirancang agar mudah,
          transparan, dan nyaman bagi seluruh pengguna.
        </p>

      </div>

    </section>

    <!-- VISION MISSION -->
    <section class="vision-section">

      <div class="vision-card">

        <q-icon name="rocket_launch" class="vision-icon" />

        <h3>
          Visi
        </h3>

        <p>
          Menjadi platform top up game terpercaya yang memberikan
          pengalaman transaksi digital terbaik bagi seluruh gamer.
        </p>

      </div>

      <div class="vision-card">

        <q-icon name="flag" class="vision-icon" />

        <h3>
          Misi
        </h3>

        <p>
          Menyediakan layanan yang cepat, aman, mudah digunakan,
          serta didukung pelayanan terbaik untuk setiap pelanggan.
        </p>

      </div>

    </section>

    <!-- VALUES -->
    <section class="values-section">

      <div class="section-header">

        <span class="section-badge">
          Nilai Kami
        </span>

        <h2>
          Komitmen Kami
        </h2>

        <p>
          Nilai-nilai yang menjadi dasar dalam setiap layanan yang kami berikan.
        </p>

      </div>

      <div class="values-grid">

        <div v-for="item in values" :key="item.title" class="value-card">

          <q-icon :name="item.icon" class="value-icon" />

          <div class="value-title">

            {{ item.title }}

          </div>

          <div class="value-description">

            {{ item.description }}

          </div>

        </div>

      </div>

    </section>

    <!-- CTA -->
    <section class="about-cta">

      <div class="cta-card">

        <h2>
          Siap Memulai?
        </h2>

        <p>
          Jelajahi berbagai game dan produk digital yang tersedia
          di EI Gaming Store.
        </p>

        <q-btn unelevated color="primary" no-caps icon="sports_esports" label="Lihat Semua Produk" to="/product" />

      </div>

    </section>

  </q-page>
</template>

<script setup>
/*
|--------------------------------------------------------------------------
| VALUES
|--------------------------------------------------------------------------
*/

const values = [
  {
    icon: 'bolt',
    title: 'Cepat',
    description:
      'Proses transaksi otomatis dalam hitungan detik hingga beberapa menit.',
  },
  {
    icon: 'security',
    title: 'Aman',
    description:
      'Pembayaran diproses melalui sistem yang aman dan terpercaya.',
  },
  {
    icon: 'verified',
    title: 'Terpercaya',
    description:
      'Berkomitmen memberikan layanan yang transparan dan dapat diandalkan.',
  },
  {
    icon: 'support_agent',
    title: 'Pelayanan',
    description:
      'Tim kami siap membantu pelanggan dengan pelayanan yang ramah dan responsif.',
  },
]
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PAGE
|--------------------------------------------------------------------------
*/

.about-page {
  display: flex;
  flex-direction: column;

  gap: 72px;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.page-header {
  max-width: 720px;

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

.page-header h1 {
  margin: 16px 0 12px;

  color: var(--app-text);

  font-size: clamp(2rem, 4vw, 2.7rem);
  font-weight: 700;
}

.page-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| ABOUT
|--------------------------------------------------------------------------
*/

.about-section {
  display: flex;
  justify-content: center;
}

.about-content {
  max-width: 840px;

  text-align: center;
}

.about-content h2 {
  margin-bottom: 20px;

  color: var(--app-text);

  font-size: 2rem;
  font-weight: 700;
}

.about-content p {
  margin: 0 0 18px;

  color: var(--app-text-secondary);

  line-height: 1.9;

  font-size: 1rem;
}

/*
|--------------------------------------------------------------------------
| VISION
|--------------------------------------------------------------------------
*/

.vision-section {
  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 24px;
}

.vision-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  padding: 32px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  transition:
    transform .2s ease,
    border-color .2s ease,
    background-color .2s ease;
}

.vision-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.vision-icon {
  margin-bottom: 18px;

  font-size: 48px;

  color: var(--app-primary);
}

.vision-card h3 {
  margin: 0 0 14px;

  color: var(--app-text);

  font-size: 1.3rem;
  font-weight: 700;
}

.vision-card p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| VALUES
|--------------------------------------------------------------------------
*/

.values-section {
  display: flex;
  flex-direction: column;

  gap: 36px;
}

.section-header {
  max-width: 640px;

  margin: 0 auto;

  text-align: center;
}

.section-header h2 {
  margin: 16px 0 12px;

  color: var(--app-text);

  font-size: clamp(1.8rem, 4vw, 2.3rem);
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

.values-grid {
  display: grid;

  grid-template-columns: repeat(4, 1fr);

  gap: 20px;
}

.value-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  padding: 26px 22px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 22px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.value-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.value-icon {
  margin-bottom: 18px;

  font-size: 42px;

  color: var(--app-primary);
}

.value-title {
  margin-bottom: 10px;

  color: var(--app-text);

  font-size: 1.05rem;
  font-weight: 700;
}

.value-description {
  color: var(--app-text-secondary);

  line-height: 1.7;

  font-size: .9rem;
}

/*
|--------------------------------------------------------------------------
| CTA
|--------------------------------------------------------------------------
*/

.about-cta {
  margin-bottom: 24px;
}

.cta-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 20px;

  padding: 52px 32px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 28px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.cta-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.cta-card h2 {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(1.9rem, 4vw, 2.5rem);
  font-weight: 700;
}

.cta-card p {
  max-width: 620px;

  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

.cta-card :deep(.q-btn) {
  margin-top: 6px;

  min-width: 220px;

  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .vision-section {
    grid-template-columns: 1fr;
  }

  .values-grid {
    grid-template-columns: repeat(2, 1fr);
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .about-page {
    gap: 48px;

    padding-inline: 16px;
  }

  .page-header h1 {
    font-size: 1.7rem;
  }

  .page-header p {
    font-size: .9rem;
  }

  .about-content h2 {
    font-size: 1.5rem;
  }

  .about-content p {
    font-size: .9rem;
  }

  .vision-card {
    padding: 24px 20px;
  }

  .vision-icon {
    font-size: 40px;
  }

  .vision-card h3 {
    font-size: 1.15rem;
  }

  .vision-card p {
    font-size: .9rem;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .values-grid {
    grid-template-columns: repeat(2, 1fr);

    gap: 14px;
  }

  .value-card {
    padding: 20px 16px;
  }

  .value-icon {
    font-size: 34px;
  }

  .value-title {
    font-size: .95rem;
  }

  .value-description {
    font-size: .82rem;
  }

  .cta-card {
    padding: 38px 22px;

    border-radius: 22px;
  }

  .cta-card h2 {
    font-size: 1.6rem;
  }

  .cta-card p {
    font-size: .9rem;
  }

  .cta-card :deep(.q-btn) {
    width: 100%;

    min-width: unset;
  }

}
</style>