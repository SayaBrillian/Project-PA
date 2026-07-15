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

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| TRUST
|--------------------------------------------------------------------------
*/

.trust-section {
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

.stats-grid {
  display: grid;

  grid-template-columns: repeat(4, 1fr);

  gap: 18px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.stat-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 10px;

  padding: 24px 18px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 20px;

  transition:
    transform .2s ease,
    border-color .2s ease,
    background-color .2s ease;
}

.stat-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| ICON
|--------------------------------------------------------------------------
*/

.stat-icon {
  font-size: 30px;

  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| VALUE
|--------------------------------------------------------------------------
*/

.stat-value {
  color: var(--app-text);

  font-size: 1.8rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| LABEL
|--------------------------------------------------------------------------
*/

.stat-label {
  color: var(--app-text-secondary);

  font-size: .9rem;

  line-height: 1.5;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .stats-grid {
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

  .trust-section {
    gap: 28px;

    padding-inline: 16px;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .stats-grid {
    gap: 12px;
  }

  .stat-card {
    padding: 18px 14px;

    border-radius: 18px;
  }

  .stat-icon {
    font-size: 26px;
  }

  .stat-value {
    font-size: 1.4rem;
  }

  .stat-label {
    font-size: .8rem;
  }

}
</style>
