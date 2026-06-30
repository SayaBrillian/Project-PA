<template>

  <q-dialog seamless :model-value="modelValue" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card v-if="admin" class="dialog-card">

      <q-card-section>

        <div class="detail-grid">

          <div class="detail-item">

            <span>ID</span>

            <strong>
              {{ admin.id }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Name</span>

            <strong>
              {{ admin.name }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Email</span>

            <strong>
              {{ admin.email }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Level</span>

            <q-badge color="accent">
              {{ admin.level }}
            </q-badge>

          </div>

          <div class="detail-item">

            <span>Registered</span>

            <strong>
              {{
                new Date(
                  admin.created_at
                ).toLocaleString('id-ID')
              }}
            </strong>

          </div>

        </div>

      </q-card-section>

      <q-card-actions align="right">

        <q-btn flat color="accent" label="Update" @click="
          emit(
            'update',
            admin
          )
          " />

        <q-btn flat label="Close" v-close-popup />

      </q-card-actions>

    </q-card>

  </q-dialog>

</template>

<script setup>

defineProps({

  modelValue: Boolean,

  admin: Object,

})

const emit = defineEmits([

  'update:modelValue',

  'update',

])

</script>

<style lang="scss" scoped>
.dialog-card {
  width: 700px;
  max-width: 95vw;

  border-radius: 24px;
}

.admin-title {
  font-size: 1.4rem;
  font-weight: 700;

  color: $dark;
}

.admin-email {
  margin-top: 4px;

  color: rgba(0,
      0,
      0,
      .55);
}

.detail-grid {
  display: grid;

  grid-template-columns:
    repeat(2,
      1fr);

  gap: 16px;
}

.detail-item {
  display: flex;

  flex-direction: column;
}

.detail-item span {
  color: rgba(0,
      0,
      0,
      .5);

  font-size: .85rem;
}

@media (max-width: 768px) {

  .detail-grid {

    grid-template-columns:
      1fr;

  }

}
</style>
