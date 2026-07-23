<template>

  <q-dialog :model-value="modelValue" :position="$q.screen.lt.md ? 'bottom' : undefined"
    @update:model-value="emit('update:modelValue', $event)">

    <q-card v-if="admin" class="dialog-card">

      <!-- HEADER -->

      <div class="dialog-header">

        <div v-if="$q.screen.lt.md" class="dialog-handle"></div>

        <div class="header-content">

          <div>

            <h2 class="dialog-title">

              Delete Admin

            </h2>

            <p class="dialog-subtitle">

              Hapus administrator dari sistem.

            </p>

          </div>

          <q-btn flat round dense icon="close" v-close-popup />

        </div>

      </div>

      <q-separator />

      <!-- CONTENT -->

      <div class="dialog-content">

        <div class="warning-box">

          <q-icon name="warning" color="negative" size="40px" />

          <div>

            <div class="warning-title">

              Konfirmasi Penghapusan

            </div>

            <div class="warning-description">

              Admin berikut akan dihapus secara permanen.

            </div>

          </div>

        </div>

        <div class="detail-grid">

          <div class="detail-item">

            <span>Full Name</span>

            <strong>

              {{ admin.name }}

            </strong>

          </div>

          <div class="detail-item">

            <span>Username</span>

            <strong>

              {{ admin.username }}

            </strong>

          </div>

          <div class="detail-item">

            <span>Role</span>

            <strong>

              {{ admin.role }}

            </strong>

          </div>

          <div class="detail-item">

            <span>Email</span>

            <strong>

              {{ admin.email }}

            </strong>

          </div>

        </div>

      </div>

      <q-separator />

      <!-- FOOTER -->

      <div class="dialog-footer">

        <div class="footer-actions">

          <q-btn flat no-caps label="Cancel" v-close-popup />

          <q-btn unelevated color="negative" icon="delete" no-caps label="Delete Admin" :loading="loading"
            @click="deleteAdmin" />

        </div>

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>

import {
  ref,
  watch,
} from 'vue'

import {
  useQuasar,
} from 'quasar'

import api from 'src/axios'

const $q = useQuasar()

const props = defineProps({

  modelValue: Boolean,

  admin: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'deleted',

])

const loading = ref(false)

watch(

  () => props.modelValue,

  (opened) => {

    if (opened) {

      // Siap jika nanti ingin menambahkan
      // validasi atau refresh data.

    }

  }

)

const deleteAdmin = async () => {

  if (!props.admin) return

  try {

    loading.value = true

    await api.delete(

      `/api/admins/${props.admin.id}`,

    )

    emit('deleted')

    emit(
      'update:modelValue',
      false,
    )

  }

  catch (error) {

    console.error(

      'Delete Admin Error:',

      error,

    )

  }

  finally {

    loading.value = false

  }

}

</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.dialog-card {

  width: 600px;
  max-width: 95vw;

  display: flex;
  flex-direction: column;

  background: var(--app-bg);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  overflow: hidden;

}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {

  padding: 24px 28px;

}

.dialog-handle {

  width: 48px;
  height: 5px;

  margin: 0 auto 20px;

  border-radius: 999px;

  background: var(--app-border);

}

.header-content {

  display: flex;

  justify-content: space-between;

  align-items: flex-start;

  gap: 20px;

}

.dialog-title {

  margin: 0 0 8px;

  color: var(--app-text);

  font-size: 1.7rem;
  font-weight: 700;

}

.dialog-subtitle {

  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;

}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.dialog-content {

  padding: 28px;

}

/*
|--------------------------------------------------------------------------
| WARNING
|--------------------------------------------------------------------------
*/

.warning-box {

  display: flex;

  align-items: flex-start;

  gap: 18px;

  padding: 18px;

  margin-bottom: 28px;

  background: rgba(244, 67, 54, .08);

  border: 1px solid rgba(244, 67, 54, .18);

  border-radius: 18px;

}

.warning-title {

  margin-bottom: 6px;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;

}

.warning-description {

  color: var(--app-text-secondary);

  line-height: 1.6;

}

/*
|--------------------------------------------------------------------------
| DETAIL
|--------------------------------------------------------------------------
*/

.detail-grid {

  display: grid;

  grid-template-columns: repeat(2, 1fr);

  gap: 18px;

}

.detail-item {

  display: flex;

  flex-direction: column;

  gap: 6px;

}

.detail-item span {

  color: var(--app-text-secondary);

  font-size: .82rem;

}

.detail-item strong {

  color: var(--app-text);

  font-size: .96rem;
  font-weight: 600;

  word-break: break-word;

}

/*
|--------------------------------------------------------------------------
| FOOTER
|--------------------------------------------------------------------------
*/

.dialog-footer {

  padding: 24px 28px;

  background: var(--app-bg);

  border-top: 1px solid var(--app-border);

}

.footer-actions {

  display: flex;

  justify-content: flex-end;

  gap: 12px;

}

.footer-actions :deep(.q-btn) {

  border-radius: 14px;

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width:768px) {

  .dialog-card {

    width: 100vw;
    max-width: 100vw;

    margin: 0;

    border-radius: 24px 24px 0 0;

  }

  .dialog-header {

    padding: 20px;

  }

  .dialog-content {

    padding: 20px;

  }

  .dialog-footer {

    padding: 20px;

    border-top: 1px solid var(--app-border);

  }

  .dialog-title {

    font-size: 1.5rem;

  }

  .detail-grid {

    grid-template-columns: 1fr;

  }

  .warning-box {

    flex-direction: column;

    gap: 14px;

  }

  .footer-actions {

    display: grid;

    grid-template-columns: 1fr;

  }

  .footer-actions :deep(.q-btn) {

    width: 100%;

  }

}
</style>
