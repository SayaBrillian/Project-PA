<template>
  <q-page class="home-page">

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-image">
        <!-- Nanti ganti dengan URL CDN -->
        <img src="https://placehold.co/600x400" alt="Gaming Banner">
      </div>
      <div class="hero-content">
        <span class="hero-badge">
          🎮 Selamat Datang di EI Gaming Store
        </span>

        <h1 class="hero-title">
          Tempat terbaik untuk kebutuhan game favoritmu.
        </h1>

        <p class="hero-description">
          Temukan item, voucher, top-up, dan berbagai produk gaming
          dengan harga kompetitif, proses cepat, dan transaksi aman.
        </p>

        <div class="hero-actions">
          <q-btn unelevated color="accent" label="Lihat Produk" to="/product" no-caps />

          <q-btn flat color="white" label="Pelajari Lebih Lanjut" to="/about" no-caps />
        </div>
      </div>

    </section>

    <!-- Why Choose Us -->
    <section class="why-section">

      <div class="section-header">
        <h2>Kenapa Belanja di Sini?</h2>

        <p>
          Kami berfokus pada pengalaman belanja yang cepat,
          aman, dan nyaman.
        </p>
      </div>

      <div class="feature-grid">

        <q-card flat class="feature-card">
          <q-icon name="sell" class="feature-icon" />

          <h3>Murah</h3>

          <p>
            Harga kompetitif dengan berbagai promo menarik.
          </p>
        </q-card>

        <q-card flat class="feature-card">
          <q-icon name="bolt" class="feature-icon" />

          <h3>Cepat</h3>

          <p>
            Proses transaksi instan dan efisien.
          </p>
        </q-card>

        <q-card flat class="feature-card">
          <q-icon name="security" class="feature-icon" />

          <h3>Aman</h3>

          <p>
            Data dan pembayaran terlindungi dengan baik.
          </p>
        </q-card>

        <q-card flat class="feature-card">
          <q-icon name="verified" class="feature-icon" />

          <h3>Terpercaya</h3>

          <p>
            Didukung layanan profesional dan pelanggan setia.
          </p>
        </q-card>

      </div>

    </section>
    <GameSection title="Most Popular" description="Game yang paling banyak dimainkan oleh pengguna."
      :games="popularGames" :filters="['All Time', 'Month', 'Week', 'Day']" />

    <GameSection title="Latest Update" description="Update dan patch terbaru dari game favoritmu."
      :games="popularGames" />
  </q-page>
</template>

<script setup>
import GameSection from 'components/game/GameSection.vue'

const popularGames = [
  {
    id: 1,
    name: 'Genshin Impact',
    category: 'Open World',
    image: 'https://placehold.co/600x340',
    isUpdated: true
  },
  {
    id: 2,
    name: 'Honkai Star Rail',
    category: 'RPG',
    image: 'https://placehold.co/600x340',
    isUpdated: false
  }
]
</script>

<style lang="scss" scoped>
.home-page {
  display: flex;
  flex-direction: column;
  gap: 10px;

  padding: 32px 0 64px;
}

.hero-section {
  display: grid;
  grid-template-columns: 1.1fr 1fr;
  gap: 48px;
  align-items: center;
}

.hero-badge {
  display: inline-block;

  padding: 8px 16px;
  margin-bottom: 20px;

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;

  background: rgba($sakura, 0.08);
  color: $sakura;
}

.hero-title {
  margin: 0 0 20px;

  font-size: clamp(2.5rem, 5vw, 4rem);
  line-height: 1.1;
  font-weight: 800;
}

.hero-description {
  margin-bottom: 32px;

  color: rgba(255, 255, 255, 0.72);
  line-height: 1.8;
  font-size: 1.05rem;
}

.hero-actions {
  display: flex;
  gap: 16px;
}

.hero-image img {
  width: 100%;
  height: auto;

  border-radius: 24px;

  object-fit: cover;

  border: 1px solid rgba($sakura, 0.15);

  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.3),
    0 0 24px rgba($sakura, 0.08);
}

.why-section {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.section-header {
  text-align: center;
}

.section-header h2 {
  margin-bottom: 12px;
  font-size: 2rem;
}

.section-header p {
  color: rgba(255, 255, 255, 0.72);
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.feature-card {
  padding: 20px 16px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 24px;

  text-align: center;

  transition:
    transform 0.25s ease,
    border-color 0.25s ease,
    background-color 0.25s ease;
}

.feature-card:hover {
  transform: translateY(-6px);

  background: rgba($sakura, 0.06);
  border-color: rgba($sakura, 0.2);
}

.feature-icon {
  font-size: 32px;
  color: $sakura;

  margin-bottom: 12px;
}

.feature-card h3 {
  margin: 0 0 8px;

  font-size: 1rem;
  font-weight: 600;
}

.feature-card p {
  margin: 0;

  font-size: 0.875rem;
  line-height: 1.5;

  color: rgba(255, 255, 255, 0.72);
}

@media (max-width: 900px) {
  .hero-section {
    grid-template-columns: 1fr;
  }

  .hero-image {
    order: -1;
  }

  .feature-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 600px) {
  .feature-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
  }

  .hero-actions {
    flex-direction: column;
  }
}
</style>
