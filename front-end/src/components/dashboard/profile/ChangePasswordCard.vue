<template>

  <q-card class="password-card">

    <div class="card-header">

      <div>

        <h2 class="card-title">
          Change Password
        </h2>

        <p class="card-subtitle">
          Gunakan password yang kuat untuk menjaga keamanan akun.
        </p>

      </div>

    </div>

    <q-separator />

    <div class="card-content">

      <div class="form-grid">

        <q-input v-model="form.current_password" outlined :type="showCurrent ? 'text' : 'password'"
          label="Current Password">

          <template #append>

            <q-icon :name="showCurrent ? 'visibility_off' : 'visibility'" class="cursor-pointer"
              @click="showCurrent = !showCurrent" />

          </template>

        </q-input>

        <div></div>

        <q-input v-model="form.new_password" outlined :type="showNew ? 'text' : 'password'" label="New Password">

          <template #append>

            <q-icon :name="showNew ? 'visibility_off' : 'visibility'" class="cursor-pointer"
              @click="showNew = !showNew" />

          </template>

        </q-input>

        <q-input v-model="form.confirm_password" outlined :type="showConfirm ? 'text' : 'password'"
          label="Confirm Password">

          <template #append>

            <q-icon :name="showConfirm ? 'visibility_off' : 'visibility'" class="cursor-pointer"
              @click="showConfirm = !showConfirm" />

          </template>

        </q-input>

      </div>

    </div>

    <q-separator />

    <div class="card-footer">

      <q-btn unelevated color="accent" icon="lock_reset" no-caps label="Change Password" :loading="loading"
        @click="changePassword" />

    </div>

  </q-card>

</template>

<script setup>
import { ref } from 'vue'

defineProps({

  loading: {
    type: Boolean,
    default: false
  }

})

const emit = defineEmits([
  'save'
])

const showCurrent = ref(false)

const showNew = ref(false)

const showConfirm = ref(false)

const form = ref({

  current_password: '',

  new_password: '',

  confirm_password: ''

})

const resetForm = () => {

  form.value = {

    current_password: '',

    new_password: '',

    confirm_password: ''

  }

}

const changePassword = () => {

  emit(
    'save',
    {
      ...form.value
    },
    resetForm
  )

}
</script>

<style scoped lang="scss">
.password-card {

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
