<template>
  <section class="faq-section">
    <div class="section-header">
      <span class="section-badge">
        Pertanyaan Umum
      </span>

      <h2>Masih Ada Pertanyaan?</h2>

      <p>
        Temukan jawaban untuk pertanyaan yang paling sering diajukan.
      </p>
    </div>

    <div class="faq-list">
      <q-expansion-item
        v-for="item in faqs"
        :key="item.question"
        class="faq-item"
        expand-separator
        :label="item.question"
        icon="help_outline"
        header-class="faq-header"
      >
        <div class="faq-answer">
          {{ item.answer }}
        </div>
      </q-expansion-item>
    </div>
  </section>
</template>

<script setup>
const faqs = [
  {
    question: 'Berapa lama proses top up?',
    answer: 'Sebagian besar transaksi diproses otomatis dalam hitungan detik hingga beberapa menit.'
  },
  {
    question: 'Apakah saya harus login?',
    answer: 'Tidak. Kamu tetap bisa bertransaksi tanpa login menggunakan email atau nomor WhatsApp.'
  },
  {
    question: 'Bagaimana jika salah memasukkan UID?',
    answer: 'Pastikan UID dan server sudah benar sebelum melakukan pembayaran karena pesanan tidak dapat dibatalkan setelah diproses.'
  },
  {
    question: 'Metode pembayaran apa saja yang tersedia?',
    answer: 'Kami mendukung QRIS, e-wallet, virtual account, dan transfer bank.'
  },
  {
    question: 'Bagaimana cara menghubungi customer service?',
    answer: 'Hubungi kami melalui WhatsApp atau menu bantuan yang tersedia di website.'
  }
]
</script>

<style lang="scss" scoped>
.faq-section {
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

.faq-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.faq-item {
  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.1);
  border-radius: 18px;

  overflow: hidden;

  transition: all 0.25s ease;
}

.faq-item:hover {
  border-color: rgba($sakura, 0.25);
}

:deep(.faq-header) {
  padding: 18px 20px;

  color: white;
  font-weight: 600;
}

.faq-answer {
  padding: 0 20px 20px;

  color: rgba(255, 255, 255, 0.7);
  line-height: 1.7;
}
</style>
