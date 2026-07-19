<template>

  <section class="contact-section">

    <!-- HEADER -->
    <div class="section-header">

      <h2>
        Informasi Kontak
      </h2>

      <p>
        Digunakan untuk konfirmasi pesanan dan status transaksi.
      </p>

    </div>

    <!-- FORM -->
    <div class="contact-form">

      <q-input v-model="customerEmail" outlined type="email" label="Email" class="form-field" :error="customerEmail !== '' &&
        !isEmailValid
        " error-message="Format email tidak valid">

        <template #prepend>

          <q-icon name="mail" />

        </template>

      </q-input>

      <q-input v-model="customerWhatsapp" outlined label="WhatsApp" class="form-field" :error="customerWhatsapp !== '' &&
        !isWhatsappValid
        " error-message="Nomor WhatsApp minimal 10 digit">

        <template #prepend>

          <q-icon name="smartphone" />

        </template>

      </q-input>

    </div>

  </section>

</template>

<script setup>
import { computed } from 'vue'

/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props = defineProps({

  customerEmail: {
    type: String,
    default: '',
  },

  customerWhatsapp: {
    type: String,
    default: '',
  },

  isEmailValid: {
    type: Boolean,
    default: true,
  },

  isWhatsappValid: {
    type: Boolean,
    default: true,
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'update:customerEmail',
  'update:customerWhatsapp',
])

/*
|--------------------------------------------------------------------------
| V-MODEL
|--------------------------------------------------------------------------
*/

const customerEmail = computed({

  get: () => props.customerEmail,

  set: value =>

    emit(
      'update:customerEmail',
      value,
    ),

})

const customerWhatsapp = computed({

  get: () => props.customerWhatsapp,

  set: value =>

    emit(
      'update:customerWhatsapp',
      value,
    ),

})
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| SECTION
|--------------------------------------------------------------------------
*/

.contact-section {
  display: flex;
  flex-direction: column;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.section-header {
  display: flex;
  flex-direction: column;

  gap: 10px;

  margin-bottom: 24px;
}

.section-header h2 {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(1.8rem, 4vw, 2.3rem);
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

.contact-form {
  display: flex;
  flex-direction: column;

  gap: 18px;
}

.form-field {
  width: 100%;
}

.form-field :deep(.q-field__control) {
  border-radius: 16px;

  background: var(--app-surface);
}

.form-field :deep(.q-field__prepend) {
  color: var(--app-text-secondary);
}

.form-field :deep(.q-field--focused .q-field__prepend) {
  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

}
</style>
