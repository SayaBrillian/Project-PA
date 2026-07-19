<template>
  <q-page class="help-page">

    <!-- HEADER -->
    <section class="page-header">

      <h1>
        Kami Siap Membantu
      </h1>

      <p>
        Temukan jawaban atas pertanyaan yang paling sering diajukan atau hubungi tim kami jika membutuhkan bantuan lebih
        lanjut.
      </p>

    </section>

    <!-- CONTACT -->
    <section class="contact-section">

      <div v-for="item in contacts" :key="item.title" class="contact-card">

        <q-icon :name="item.icon" class="contact-icon" />

        <div class="contact-title">
          {{ item.title }}
        </div>

        <div class="contact-subtitle">
          {{ item.subtitle }}
        </div>

        <div class="contact-value">
          {{ item.value }}
        </div>

      </div>

    </section>

    <!-- FAQ -->
    <section class="faq-section">

      <div class="section-header">

        <h2>
          Pertanyaan Umum
        </h2>

        <p>
          Berikut beberapa pertanyaan yang sering ditanyakan pelanggan.
        </p>

      </div>

      <div class="faq-list">

        <q-expansion-item v-for="item in faqs" :key="item.question" class="faq-item" expand-separator :icon="item.icon"
          :label="item.question" header-class="faq-header">

          <div class="faq-answer">

            {{ item.answer }}

          </div>

        </q-expansion-item>

      </div>

    </section>

    <!-- CTA -->
    <section class="help-cta">

      <div class="cta-card">

        <h2>
          Masih Membutuhkan Bantuan?
        </h2>

        <p>
          Tim kami siap membantu jika kamu mengalami kendala saat melakukan transaksi atau memiliki pertanyaan lainnya.
        </p>

        <q-btn unelevated no-caps color="primary" icon="chat" label="Hubungi Kami" />

      </div>

    </section>

  </q-page>
</template>

<script setup>
/*
|--------------------------------------------------------------------------
| CONTACT
|--------------------------------------------------------------------------
*/

const contacts = [
  {
    icon: 'chat',
    title: 'WhatsApp',
    subtitle: 'Chat langsung dengan tim kami.',
    value: '+62 812-3456-7890',
  },
  {
    icon: 'mail',
    title: 'Email',
    subtitle: 'Kirim pertanyaan melalui email.',
    value: 'support@eigamingstore.com',
  },
  {
    icon: 'schedule',
    title: 'Jam Operasional',
    subtitle: 'Layanan pelanggan tersedia.',
    value: '08.00 - 22.00 WIB',
  },
]

/*
|--------------------------------------------------------------------------
| FAQ
|--------------------------------------------------------------------------
*/

const faqs = [
  {
    icon: 'bolt',
    question: 'Berapa lama proses top up?',
    answer:
      'Sebagian besar transaksi diproses secara otomatis dalam hitungan detik hingga beberapa menit.',
  },
  {
    icon: 'person',
    question: 'Apakah saya harus login?',
    answer:
      'Tidak. Kamu tetap dapat melakukan transaksi tanpa login menggunakan Email atau Nomor HP.',
  },
  {
    icon: 'badge',
    question: 'Bagaimana jika salah memasukkan UID?',
    answer:
      'Pastikan UID dan Server sudah benar sebelum melakukan pembayaran karena pesanan yang telah diproses tidak dapat dibatalkan.',
  },
  {
    icon: 'payments',
    question: 'Metode pembayaran apa saja yang tersedia?',
    answer:
      'Kami mendukung QRIS, E-Wallet, Virtual Account, Transfer Bank, dan metode pembayaran lain yang tersedia di Midtrans.',
  },
  {
    icon: 'support_agent',
    question: 'Bagaimana cara menghubungi customer service?',
    answer:
      'Kamu dapat menghubungi kami melalui WhatsApp atau Email yang tersedia pada halaman ini.',
  },
]
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PAGE
|--------------------------------------------------------------------------
*/

.help-page {
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
  max-width: 680px;

  margin: 0 auto;

  text-align: center;
}

.page-header h1 {
  margin: 16px 0 12px;

  color: var(--app-text);

  font-size: clamp(2rem, 4vw, 2.6rem);
  font-weight: 700;
}

.page-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| CONTACT
|--------------------------------------------------------------------------
*/

.contact-section {
  display: grid;

  grid-template-columns: repeat(3, 1fr);

  gap: 20px;
}

.contact-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  padding: 28px 24px;

  text-align: center;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 22px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.contact-card:hover {
  transform: translateY(-4px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.contact-icon {
  margin-bottom: 16px;

  font-size: 42px;

  color: var(--app-primary);
}

.contact-title {
  color: var(--app-text);

  font-size: 1.05rem;
  font-weight: 700;
}

.contact-subtitle {
  margin-top: 8px;

  color: var(--app-text-secondary);

  font-size: .9rem;

  line-height: 1.6;
}

.contact-value {
  margin-top: 18px;

  color: var(--app-primary);

  font-weight: 600;
}

/*
|--------------------------------------------------------------------------
| FAQ
|--------------------------------------------------------------------------
*/

.faq-section {
  display: flex;
  flex-direction: column;

  gap: 32px;
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

.faq-list {
  display: flex;
  flex-direction: column;

  gap: 14px;
}

.faq-item {
  overflow: hidden;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  transition:
    transform .2s ease,
    background-color .2s ease,
    border-color .2s ease;
}

.faq-item:hover {
  transform: translateY(-2px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

:deep(.faq-header) {
  min-height: 64px;

  padding: 0 20px;

  color: var(--app-text);

  font-weight: 600;
}

:deep(.faq-header .q-icon) {
  color: var(--app-primary);
}

:deep(.q-item__label) {
  color: var(--app-text);
}

:deep(.q-item__section--side) {
  color: var(--app-text-secondary);
}

:deep(.q-expansion-item__content) {
  border-top: 1px solid var(--app-border);
}

.faq-answer {
  padding: 0 20px 20px;

  color: var(--app-text-secondary);

  line-height: 1.8;
}

/*
|--------------------------------------------------------------------------
| CTA
|--------------------------------------------------------------------------
*/

.help-cta {
  margin-bottom: 24px;
}

.cta-card {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 18px;

  padding: 48px 32px;

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

.cta-card h2 {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(1.8rem, 4vw, 2.5rem);
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

  .contact-section {
    grid-template-columns: repeat(2, 1fr);
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .help-page {
    gap: 48px;

    padding-inline: 16px;
  }

  .page-header h1 {
    font-size: 1.7rem;
  }

  .page-header p {
    font-size: .9rem;
  }

  .contact-section {
    grid-template-columns: 1fr;

    gap: 14px;
  }

  .contact-card {
    padding: 22px 18px;
  }

  .contact-icon {
    font-size: 36px;
  }

  .contact-title {
    font-size: 1rem;
  }

  .contact-subtitle,
  .contact-value {
    font-size: .88rem;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  :deep(.faq-header) {
    min-height: 58px;

    padding: 0 16px;
  }

  .faq-answer {
    padding: 0 16px 16px;

    font-size: .88rem;
  }

  .cta-card {
    padding: 36px 22px;

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
