<template>
  <section class="welcome-section">

    <div class="welcome-image">

      <img src="src/assets/March7.webp" alt="EI Gaming Store">

    </div>

    <div class="welcome-content">

      <span class="welcome-badge">
        🎮 Selamat Datang di EI Gaming Store
      </span>

      <h1 class="welcome-title">
        Tempat terbaik untuk kebutuhan game favoritmu.
      </h1>

      <p class="welcome-description">
        Temukan item, voucher, top-up, dan berbagai produk gaming
        dengan harga kompetitif, proses cepat, dan transaksi aman.
      </p>

      <div class="welcome-actions">

        <q-btn unelevated color="primary" no-caps label="Lihat Produk" to="/product" />

        <q-btn flat no-caps label="Pelajari Lebih Lanjut" to="/about" class="welcome-secondary-btn" />

      </div>

    </div>

  </section>
</template>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| WELCOME
|--------------------------------------------------------------------------
*/

.welcome-section {
  display: grid;

  grid-template-columns: 1.1fr 1fr;

  gap: 48px;

  align-items: center;
}

/*
|--------------------------------------------------------------------------
| IMAGE
|--------------------------------------------------------------------------
*/

.welcome-image img {
  width: 100%;
  height: auto;

  display: block;

  object-fit: cover;

  border-radius: 24px;
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.welcome-content {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

.welcome-badge {
  display: inline-flex;
  align-items: center;

  padding: 8px 16px;

  margin-bottom: 20px;

  border-radius: 999px;

  border: 1px solid var(--app-border);

  background: var(--app-hover);

  color: var(--app-primary);

  font-size: .9rem;
  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| TITLE
|--------------------------------------------------------------------------
*/

.welcome-title {
  margin: 0 0 20px;

  color: var(--app-text);

  font-size: clamp(2.5rem, 5vw, 4rem);

  line-height: 1.1;

  font-weight: 800;
}

/*
|--------------------------------------------------------------------------
| DESCRIPTION
|--------------------------------------------------------------------------
*/

.welcome-description {
  margin: 0 0 32px;

  color: var(--app-text-secondary);

  line-height: 1.8;

  font-size: 1.05rem;
}

/*
|--------------------------------------------------------------------------
| ACTIONS
|--------------------------------------------------------------------------
*/

.welcome-actions {
  display: flex;

  gap: 16px;

  flex-wrap: wrap;
}

.welcome-secondary-btn {
  color: var(--app-text);
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 900px) {

  .welcome-section {

    grid-template-columns: 1fr;

    gap: 28px;

  }

  .welcome-image {

    order: -1;

  }

}

@media (max-width: 600px) {

  .welcome-section {
    gap: 24px;

    padding: 0 16px;
  }

  .welcome-image {
    order: -1;
  }

  .welcome-image img {
    width: 90%;

    margin: 0 auto;

    display: block;

    border-radius: 20px;
  }

  .welcome-content {
    align-items: center;

    text-align: center;
  }

  .welcome-title {
    font-size: clamp(2rem, 8vw, 2.6rem);
  }

  .welcome-description {
    font-size: .95rem;
  }

  .welcome-actions {
    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 12px;

    width: 100%;
  }

  .welcome-actions :deep(.q-btn) {
    width: 100%;
  }

}
</style>
