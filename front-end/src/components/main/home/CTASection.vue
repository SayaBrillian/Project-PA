<template>
    <section class="cta-section">

        <div class="cta-card">

            <span class="section-badge">
                Siap Bermain?
            </span>

            <h2>
                Top Up Game Favoritmu Sekarang
            </h2>

            <p>
                Proses cepat, pembayaran lengkap,
                dan layanan pelanggan siap membantu kapan saja.
            </p>

            <div class="cta-actions">

                <q-btn unelevated no-caps color="primary" label="Lihat Semua Produk" to="/product" />

                <q-btn flat no-caps class="cta-secondary-btn" label="Hubungi Kami" to="/help" />

            </div>

        </div>

    </section>
</template>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| CTA
|--------------------------------------------------------------------------
*/

.cta-section {
    padding: 12px 0 24px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.cta-card {
    display: flex;
    flex-direction: column;
    align-items: center;

    gap: 20px;

    padding: 56px 32px;

    text-align: center;

    background: var(--app-surface);

    border: 1px solid var(--app-border);
    border-radius: 28px;

    transition:
        background-color .2s ease,
        border-color .2s ease,
        transform .2s ease;
}

.cta-card:hover {
    transform: translateY(-4px);

    background: var(--app-hover);

    border-color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| BADGE
|--------------------------------------------------------------------------
*/

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

/*
|--------------------------------------------------------------------------
| TITLE
|--------------------------------------------------------------------------
*/

.cta-card h2 {
    margin: 0;

    max-width: 720px;

    color: var(--app-text);

    font-size: clamp(2rem, 4vw, 2.8rem);

    line-height: 1.2;

    font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| DESCRIPTION
|--------------------------------------------------------------------------
*/

.cta-card p {
    max-width: 620px;

    margin: 0;

    color: var(--app-text-secondary);

    font-size: 1rem;

    line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| ACTIONS
|--------------------------------------------------------------------------
*/

.cta-actions {
    display: flex;
    justify-content: center;

    gap: 16px;

    margin-top: 8px;
}

.cta-secondary-btn {
    color: var(--app-text);
}

/*
|--------------------------------------------------------------------------
| BUTTON
|--------------------------------------------------------------------------
*/

.cta-actions :deep(.q-btn) {
    min-width: 180px;

    border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

    .cta-section {
        padding: 8px 16px 24px;
    }

    .cta-card {
        gap: 18px;

        padding: 36px 22px;

        border-radius: 22px;
    }

    .cta-card h2 {
        font-size: 1.7rem;
    }

    .cta-card p {
        font-size: .92rem;
    }

    .cta-actions {
        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 12px;

        width: 100%;
    }

    .cta-actions :deep(.q-btn) {
        width: 100%;

        min-width: unset;
    }

}
</style>