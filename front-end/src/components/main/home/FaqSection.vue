<template>
    <section class="faq-section">

        <div class="section-header">

            <span class="section-badge">
                Pertanyaan Umum
            </span>

            <h2>
                Masih Ada Pertanyaan?
            </h2>

            <p>
                Temukan jawaban untuk pertanyaan yang paling sering diajukan.
            </p>

        </div>

        <div class="faq-list">

            <q-expansion-item v-for="item in faqs" :key="item.question" class="faq-item" expand-separator
                icon="help_outline" :label="item.question" header-class="faq-header">

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
        answer:
            'Sebagian besar transaksi diproses otomatis dalam hitungan detik hingga beberapa menit.',
    },
    {
        question: 'Apakah saya harus login?',
        answer:
            'Tidak. Kamu tetap bisa bertransaksi tanpa login menggunakan email atau nomor WhatsApp.',
    },
    {
        question: 'Bagaimana jika salah memasukkan UID?',
        answer:
            'Pastikan UID dan server sudah benar sebelum melakukan pembayaran karena pesanan tidak dapat dibatalkan setelah diproses.',
    },
    {
        question: 'Metode pembayaran apa saja yang tersedia?',
        answer:
            'Kami mendukung QRIS, e-wallet, virtual account, dan transfer bank.',
    },
    {
        question: 'Bagaimana cara menghubungi customer service?',
        answer:
            'Hubungi kami melalui WhatsApp atau menu bantuan yang tersedia di website.',
    },
]
</script>