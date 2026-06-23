<template>
  <q-page class="home-page">

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-image">
        <!-- Nanti ganti dengan URL CDN -->
        <img src="src/assets/March7.webp" alt="Gaming Banner">
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

    <ProductSection title="Produk Terpopuler" description="Produk yang paling banyak dibeli oleh pemain."
      :products="popularProducts" :filters="['All Time', 'Week', 'Month', 'Day']" />
  </q-page>
  <TrustStats />
  <PurchaseFlow />
  <TestimonialsSection />
  <FaqSection />
  <section class="cta-section">
    <div class="cta-card">
      <span class="section-badge">
        Siap Bermain?
      </span>

      <h2>
        Top Up Game Favoritmu Sekarang
      </h2>

      <p>
        Proses cepat, pembayaran lengkap, dan layanan tersedia 24 jam.
      </p>

      <div class="cta-actions">
        <q-btn
          unelevated
          no-caps
          label="Lihat Semua Produk"
          color="accent"
          to="/product"
        />

        <q-btn
          flat
          no-caps
          label="Hubungi Kami"
          to="/help"
          class="secondary-btn"
        />
      </div>
    </div>
  </section>
</template>

<script setup>
import GameSection from 'components/game/GameSection.vue'

const popularGames = [
  {
    id: 1,
    slug: 'genshin-impact',
    name: 'Genshin Impact',
    isUpdated: true
  },
  {
    id: 2,
    slug: 'honkai-star-rail',
    name: 'Honkai Star Rail',
    isUpdated: false
  }
]

import ProductSection from 'components/product/ProductSection.vue'

const popularProducts = [
  {
    id: 1,
    game: 'Genshin Impact',
    name: 'Blessing of the Welkin Moon',
    price: 79000,
    image: 'src/assets/Welkin.webp',
    badge: 'Best Seller'
  },
  {
    id: 2,
    game: 'Genshin Impact',
    name: '1680 Genesis Crystals',
    price: 349000,
    image: 'src/assets/GenesisCrystal.webp',
    badge: 'Popular'
  }
]

import TrustStats from 'components/trust/TrustStats.vue'
import PurchaseFlow from 'src/components/home/PurchaseFlow.vue'
import TestimonialsSection from 'src/components/testimonials/TestimonialsSection.vue'
import FaqSection from 'src/components/faq/FaqSection.vue'
</script>

<style lang="scss" scoped>
.home-page {
  display: flex;
  flex-direction: column;
  gap: 10px;

  padding: 0px 0 64px;
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
  color: rgba(255, 255, 255, 0.72);
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
  color: rgba(255, 255, 255, 0.72);
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
  color: $sakura;
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

.cta-section {
  margin: 96px 0;
}

.cta-card {
  padding: 56px 32px;
  text-align: center;

  background: linear-gradient(
    135deg,
    rgba($secondary, 0.8),
    rgba($dark, 0.9)
  );

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 32px;

  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
}

.section-badge {
  display: inline-block;

  padding: 6px 14px;

  color: $sakura;
  background: rgba($sakura, 0.08);

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;
}

.cta-card h2 {
  margin: 20px 0 16px;

  font-size: clamp(2rem, 4vw, 3rem);
}

.cta-card p {
  max-width: 560px;
  margin: 0 auto;

  color: rgba(255, 255, 255, 0.7);
  line-height: 1.7;
}

.cta-actions {
  display: flex;
  justify-content: center;
  gap: 16px;

  margin-top: 32px;
}

.secondary-btn {
  color: white;
}

@media (max-width: 600px) {
  .feature-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
  }

  .hero-actions {
    flex-direction: column;
  }
  .cta-actions {
    flex-direction: column;
  }
}
</style>
