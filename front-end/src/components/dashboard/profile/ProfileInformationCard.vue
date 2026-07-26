<template>

  <q-card class="profile-card">

    <div class="card-header">

      <div>

        <h2 class="card-title">
          Personal Information
        </h2>

        <p class="card-subtitle">
          Perbarui informasi akun Anda.
        </p>

      </div>

    </div>

    <q-separator />

    <div class="card-content">

      <div class="form-grid">

        <q-input v-model="form.name" outlined label="Full Name" />

        <q-input v-model="form.username" outlined label="Username" />

        <q-input v-model="form.email" outlined label="Email" type="email" />

        <q-input v-model="form.phone" outlined label="Phone Number" />

        <q-input v-model="form.birth_date" outlined label="Birth Date" type="date" />

      </div>

    </div>

    <q-separator />

    <div class="card-footer">

      <q-btn unelevated color="accent" icon="save" no-caps label="Save Changes" :loading="loading"
        @click="saveProfile" />

    </div>

  </q-card>

</template>

<script setup>
import {
  ref,
  watch
} from 'vue'

const props = defineProps({

  profile: {
    type: Object,
    default: () => ({})
  },

  loading: {
    type: Boolean,
    default: false
  }

})

const emit = defineEmits([
  'save'
])

const form = ref({
  name: '',
  username: '',
  email: '',
  phone: '',
  birth_date: ''
})

watch(

  () => props.profile,

  (profile) => {

    if (!profile) return

    form.value = {

      name: profile.name || '',

      username: profile.username || '',

      email: profile.email || '',

      phone: profile.phone || '',

      birth_date: profile.birth_date || ''

    }

  },

  {
    immediate: true
  }

)

const saveProfile = () => {

  emit(
    'save',
    {
      ...form.value
    }
  )

}
</script>

<style scoped lang="scss">
.profile-card {

  border-radius: 24px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);

}

.card-header {

  padding: 24px;

}

.card-title {

  margin: 0;

  color: var(--app-text);

  font-size: 1.25rem;

  font-weight: 700;

}

.card-subtitle {

  margin-top: 6px;

  color: var(--app-text-secondary);

}

.card-content {

  padding: 24px;

}

.form-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

.card-footer {

  display: flex;

  justify-content: flex-end;

  padding: 20px 24px;

}

:deep(.q-field) {

  background: transparent;

}

@media (max-width:768px) {

  .form-grid {

    grid-template-columns: 1fr;

  }

}
</style>
