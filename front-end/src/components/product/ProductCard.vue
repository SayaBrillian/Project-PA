<template>
  <q-card class="product-card" flat clickable>
    <div class="product-image-wrapper">
      <img :src="product.image" :alt="product.name" class="product-image" />

      <div v-if="product.badge" class="product-badge">
        {{ product.badge }}
      </div>
    </div>

    <q-card-section class="product-content">
      <div class="product-game">
        {{ product.game }}
      </div>

      <div class="product-name">
        {{ product.name }}
      </div>

      <div class="product-price">Rp {{ formatPrice(product.price) }}</div>
    </q-card-section>
  </q-card>
</template>

<script setup>
defineProps({
  product: {
    type: Object,
    required: true,
  },
})

const formatPrice = (value) => {
  return new Intl.NumberFormat('id-ID').format(value)
}
</script>

<style lang="scss" scoped>
.product-card {
  overflow: hidden;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 20px;

  transition:
    transform 0.25s ease,
    border-color 0.25s ease;
}

.product-card:hover {
  transform: translateY(-4px);
  border-color: rgba($sakura, 0.25);
}

.product-image-wrapper {
  position: relative;
  aspect-ratio: 16 / 9;
}

.product-image {
  width: 100%;
  height: 100%;

  object-fit: cover;
}

.product-badge {
  position: absolute;
  top: 12px;
  right: 12px;

  padding: 6px 10px;

  background: rgba($accent, 0.95);

  color: $dark;
  font-size: 12px;
  font-weight: 700;

  border-radius: 999px;
}

.product-content {
  padding: 16px;
}

.product-game {
  margin-bottom: 8px;

  color: rgba(255, 255, 255, 0.55);
  font-size: 0.8rem;
}

.product-name {
  margin-bottom: 12px;

  font-size: 1rem;
  font-weight: 600;
}

.product-price {
  color: $sakura;
  font-size: 1.1rem;
  font-weight: 700;
}
</style>
