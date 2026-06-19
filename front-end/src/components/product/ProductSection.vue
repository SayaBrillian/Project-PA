<template>
  <section class="product-section">

    <div class="section-header">

      <div class="section-title">

        <span class="section-badge">
          Featured
        </span>

        <h2>{{ title }}</h2>

        <p class="section-description">
          {{ description }}
        </p>

      </div>

      <ProductFilters v-if="filters.length" v-model="selectedFilter" :items="filters" />

    </div>

    <div class="section-divider" />

    <div class="products-grid">

      <ProductCard v-for="product in products" :key="product.id" :product="product" />

    </div>

  </section>
</template>

<script setup>
import { ref } from 'vue'

import ProductCard from './ProductCard.vue'
import ProductFilters from './ProductFilters.vue'

defineProps({
  title: {
    type: String,
    required: true
  },

  description: {
    type: String,
    default: ''
  },

  products: {
    type: Array,
    required: true
  },

  filters: {
    type: Array,
    default: () => []
  }
})

const selectedFilter = ref('All')
</script>

<style lang="scss" scoped>
.product-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 24px;
}

.section-title {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.section-badge {
  width: fit-content;

  padding: 6px 12px;

  background: rgba($sakura, 0.08);

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 999px;

  color: $sakura;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.section-title h2 {
  margin: 0;

  font-size: clamp(1.75rem, 3vw, 2.25rem);
  font-weight: 700;
}

.section-description {
  margin: 0;

  color: rgba(255, 255, 255, 0.65);
}

.section-divider {
  width: 100%;
  height: 1px;

  background: linear-gradient(90deg,
      rgba($sakura, 0.25),
      rgba(255, 255, 255, 0.06));
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

@media (max-width: 1024px) {
  .products-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .section-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .products-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
  }
}
</style>
