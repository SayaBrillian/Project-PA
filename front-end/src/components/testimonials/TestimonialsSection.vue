<template>
  <section class="testimonials-section">
    <div class="section-header">
      <span class="section-badge">
        Bukti Nyata
      </span>

      <h2>Apa Kata Pelanggan Kami?</h2>

      <p>
        Ribuan transaksi berhasil dilakukan setiap hari.
      </p>
    </div>

    <div class="testimonials-grid">
      <TestimonialCard
        v-for="item in testimonials"
        :key="item.id"
        :testimonial="item"
      />
    </div>
  </section>
</template>

<script setup>
import TestimonialCard from './TestimonialCard.vue'

const testimonials = [
  {
    id: 1,
    name: 'Rizky A.',
    game: 'Genshin Impact',
    product: 'Welkin Moon',
    rating: 5,
    comment: 'Top up masuk kurang dari dua menit.',
    time: '2 jam lalu'
  },
  {
    id: 2,
    name: 'Andi P.',
    game: 'Honkai: Star Rail',
    product: 'Express Supply Pass',
    rating: 5,
    comment: 'Pembayaran mudah dan proses sangat cepat.',
    time: '5 jam lalu'
  },
  {
    id: 3,
    name: 'Dimas R.',
    game: 'Mobile Legends',
    product: 'Weekly Diamond Pass',
    rating: 5,
    comment: 'Sudah langganan berkali-kali dan selalu aman.',
    time: '1 hari lalu'
  }
]
</script>

<style lang="scss" scoped>
.testimonials-section {
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

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

@media (max-width: 900px) {
  .testimonials-grid {
    grid-template-columns: 1fr;
  }
}
</style>
