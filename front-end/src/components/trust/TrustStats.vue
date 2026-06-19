<template>
  <section class="trust-section">

    <div class="section-header">
      <span class="section-badge">
        Trusted by Gamers
      </span>

      <h2>Dipercaya Ribuan Gamer</h2>

      <p>
        Kami berkomitmen memberikan layanan top up yang cepat, aman, dan terpercaya.
      </p>
    </div>

    <div class="stats-grid">

      <q-card v-for="item in stats" :key="item.label" flat class="stat-card">
        <q-icon :name="item.icon" class="stat-icon" />

        <div class="stat-value">
          {{ item.value }}
        </div>

        <div class="stat-label">
          {{ item.label }}
        </div>
      </q-card>

    </div>

  </section>
</template>

<script setup>
const stats = [
  {
    value: '50K+',
    label: 'Transaksi Berhasil',
    icon: 'shopping_bag'
  },
  {
    value: '12K+',
    label: 'Pelanggan Aktif',
    icon: 'groups'
  },
  {
    value: '< 1 Menit',
    label: 'Rata-rata Proses',
    icon: 'bolt'
  },
  {
    value: '24/7',
    label: 'Layanan Bantuan',
    icon: 'support_agent'
  }
]
</script>

<style lang="scss" scoped>
.trust-section {
  margin-top: 10px;
}

.section-header {
  max-width: 640px;
  margin: 0 auto 40px;

  text-align: center;
}

.section-badge {
  display: inline-block;

  padding: 6px 14px;

  background: rgba($sakura, 0.08);

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;

  color: $sakura;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.section-header h2 {
  margin: 16px 0 12px;

  font-size: clamp(2rem, 4vw, 2.75rem);
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: rgba(255, 255, 255, 0.65);
  line-height: 1.7;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.stat-card {
  padding: 28px 20px;

  text-align: center;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 24px;

  transition:
    transform 0.25s ease,
    border-color 0.25s ease,
    background-color 0.25s ease;
}

.stat-card:hover {
  transform: translateY(-4px);

  background: rgba($sakura, 0.05);
  border-color: rgba($sakura, 0.2);
}

.stat-icon {
  font-size: 2rem;
  color: $sakura;

  margin-bottom: 16px;
}

.stat-value {
  font-size: 2rem;
  font-weight: 700;

  color: white;
}

.stat-label {
  margin-top: 8px;

  color: rgba(255, 255, 255, 0.65);
  font-size: 0.95rem;
}

@media (max-width: 900px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 500px) {
  .trust-section {
    margin-top: 72px;
  }

  .stats-grid {
    gap: 16px;
  }

  .stat-card {
    padding: 20px 16px;
  }

  .stat-value {
    font-size: 1.5rem;
  }
}
</style>
