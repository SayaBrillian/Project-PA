<template>
  <div class="testimonial-card">
    <div class="card-top">
      <q-avatar color="primary" text-color="white">
        {{ testimonial.name.charAt(0) }}
      </q-avatar>

      <div>
        <div class="customer-name">
          {{ testimonial.name }}
        </div>

        <div class="purchase-info">
          {{ testimonial.product }} • {{ testimonial.game }}
        </div>
      </div>
    </div>

    <div class="rating">
      <q-icon
        v-for="star in testimonial.rating"
        :key="star"
        name="star"
        color="warning"
        size="18px"
      />
    </div>

    <p class="comment">
      "{{ testimonial.comment }}"
    </p>

    <div class="card-footer">
      <span class="verified">
        ✓ Pembelian Terverifikasi
      </span>

      <span class="time">
        {{ testimonial.time }}
      </span>
    </div>
  </div>
</template>

<script setup>
defineProps({
  testimonial: {
    type: Object,
    required: true
  }
})
</script>

<style lang="scss" scoped>
.testimonial-card {
  padding: 24px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.1);
  border-radius: 20px;

  transition:
    transform 0.25s ease,
    border-color 0.25s ease;
}

.testimonial-card:hover {
  transform: translateY(-4px);
  border-color: rgba($sakura, 0.25);
}

.card-top {
  display: flex;
  align-items: center;
  gap: 16px;

  margin-bottom: 20px;
}

.customer-name {
  font-weight: 600;
}

.purchase-info {
  margin-top: 4px;

  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.6);
}

.rating {
  display: flex;
  gap: 2px;

  margin-bottom: 16px;
}

.comment {
  margin: 0 0 24px;

  color: rgba(255, 255, 255, 0.8);
  line-height: 1.6;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;

  font-size: 0.8rem;
}

.verified {
  color: $positive;
}

.time {
  color: rgba(255, 255, 255, 0.5);
}
</style>
