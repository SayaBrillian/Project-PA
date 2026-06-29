<template>

  <q-dialog seamless :model-value="modelValue" @update:model-value="
    emit(
      'update:modelValue',
      $event
    )
    ">

    <q-card v-if="user" class="dialog-card">

      <q-card-section>

        <div class="product-title">
          {{ user.name }}
        </div>

        <div class="product-game">
          {{ user.email }}
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="detail-grid">

          <div class="detail-item">

            <span>User ID</span>

            <strong>
              {{ user.id }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Name</span>

            <strong>
              {{ user.name }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Email</span>

            <strong>
              {{ user.email }}
            </strong>

          </div>

          <div class="detail-item">

            <span>Registered</span>

            <strong>
              {{ user.created_at }}
            </strong>

          </div>

        </div>

      </q-card-section>

      <q-card-actions align="right">

        <q-btn flat color="accent" label="Update" @click="
          emit(
            'update',
            user
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
  user: Object,
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

.product-title {
  font-size: 1.4rem;
  font-weight: 700;

  color: $dark;
}

.product-game {
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
