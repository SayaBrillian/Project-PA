<template>
  <section class="testimonials-section">

    <div class="section-header">

      <span class="section-badge">
        Bukti Nyata
      </span>

      <h2>
        Apa Kata Pelanggan Kami?
      </h2>

      <p>
        Ribuan transaksi berhasil dilakukan setiap hari.
      </p>

    </div>

    <div class="testimonials-grid">

      <q-card v-for="item in testimonials" :key="item.id" flat class="testimonial-card">

        <div class="card-top">

          <q-avatar class="customer-avatar">

            {{ item.name.charAt(0).toUpperCase() }}

          </q-avatar>

          <div class="customer-info">

            <div class="customer-name">

              {{ item.name }}

            </div>

            <div class="purchase-info">

              {{ item.product }} • {{ item.game }}

            </div>

          </div>

        </div>

        <div class="rating">

          <q-icon v-for="star in item.rating" :key="star" name="star" class="rating-star" />

        </div>

        <p class="comment">

          "{{ item.text }}"

        </p>

        <div class="card-footer">

          <span class="verified">

            ✓ Pembelian Terverifikasi

          </span>

          <span class="time">

            {{ item.time }}

          </span>

        </div>

      </q-card>

    </div>

  </section>
</template>

<script setup>
const testimonials = [
  {
    id: 1,
    name: 'Rizky A.',
    game: 'Genshin Impact',
    product: 'Welkin Moon',
    rating: 5,
    text: 'Top up masuk kurang dari dua menit.',
    time: '2 jam lalu',
  },
  {
    id: 2,
    name: 'Andi P.',
    game: 'Honkai: Star Rail',
    product: 'Express Supply Pass',
    rating: 5,
    text: 'Pembayaran mudah dan proses sangat cepat.',
    time: '5 jam lalu',
  },
  {
    id: 3,
    name: 'Dimas R.',
    game: 'Mobile Legends',
    product: 'Weekly Diamond Pass',
    rating: 5,
    text: 'Sudah langganan berkali-kali dan selalu aman.',
    time: '1 hari lalu',
  },
]
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| TESTIMONIALS
|--------------------------------------------------------------------------
*/

.testimonials-section {
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
| GRID
|--------------------------------------------------------------------------
*/

.testimonials-grid {
  display: grid;

  grid-template-columns: repeat(3, 1fr);

  gap: 18px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.testimonial-card {
  display: flex;
  flex-direction: column;

  padding: 22px 20px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.testimonial-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| TOP
|--------------------------------------------------------------------------
*/

.card-top {
  display: flex;
  align-items: center;

  gap: 14px;

  margin-bottom: 16px;
}

.customer-avatar {
  background: var(--app-primary);

  color: white;

  font-weight: 700;

  flex-shrink: 0;
}

.customer-info {
  display: flex;
  flex-direction: column;

  gap: 3px;
}

.customer-name {
  color: var(--app-text);

  font-weight: 700;
}

.purchase-info {
  color: var(--app-text-secondary);

  font-size: .85rem;
}

/*
|--------------------------------------------------------------------------
| RATING
|--------------------------------------------------------------------------
*/

.rating {
  display: flex;

  gap: 2px;

  margin-bottom: 14px;
}

.rating-star {
  color: #FFC107;
}

/*
|--------------------------------------------------------------------------
| COMMENT
|--------------------------------------------------------------------------
*/

.comment {
  flex: 1;

  margin: 0;

  color: var(--app-text-secondary);

  font-size: .95rem;

  line-height: 1.7;

  font-style: italic;
}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;

  margin-top: 22px;

  padding-top: 16px;

  border-top: 1px solid var(--app-border);

  font-size: .82rem;
}

.verified {
  color: var(--q-positive);

  font-weight: 600;
}

.time {
  color: var(--app-text-secondary);
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .testimonials-grid {
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

  .testimonials-section {
    gap: 28px;

    padding-inline: 16px;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .testimonials-grid {
    grid-template-columns: 1fr;

    gap: 14px;
  }

  .testimonial-card {
    padding: 18px 16px;

    border-radius: 18px;
  }

  .customer-avatar {
    width: 42px;
    height: 42px;

    font-size: .95rem;
  }

  .customer-name {
    font-size: .95rem;
  }

  .purchase-info {
    font-size: .8rem;
  }

  .comment {
    font-size: .88rem;
  }

  .card-footer {
    font-size: .78rem;
  }

}
</style>