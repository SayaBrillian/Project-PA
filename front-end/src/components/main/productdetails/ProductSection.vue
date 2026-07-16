<template>

  <section class="product-section">

    <!-- HEADER -->
    <div class="section-header">

      <span class="section-badge">
        Produk
      </span>

      <h2>
        Pilih Produk
      </h2>

      <p>
        Pilih nominal atau paket yang ingin dibeli.
      </p>

    </div>

    <!-- PRODUCT GRID -->
    <div class="product-grid">

      <div v-for="product in products" :key="product.id" class="product-card" :class="{
        'product-card--selected':
          selectedProduct?.id === product.id,
      }" @click="
        selectedProduct = product
        ">

        <q-icon v-if="
          selectedProduct?.id === product.id
        " name="check_circle" class="selected-icon" />

        <div class="product-name">

          {{ product.name }}

        </div>

        <div class="product-price">

          Rp
          {{
            Number(product.price)
              .toLocaleString('id-ID')
          }}

        </div>

      </div>

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

  products: {
    type: Array,
    default: () => [],
  },

  selectedProduct: {
    type: Object,
    default: null,
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'update:selectedProduct',
])

/*
|--------------------------------------------------------------------------
| V-MODEL
|--------------------------------------------------------------------------
*/

const selectedProduct = computed({

  get: () => props.selectedProduct,

  set: value =>

    emit(
      'update:selectedProduct',
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

.product-section {
  margin-top: 56px;
}

.section-header {
  margin-bottom: 24px;
}

.section-badge {
  display: inline-flex;
  align-items: center;

  padding: 8px 16px;

  border-radius: 999px;

  background: var(--app-hover);
  border: 1px solid var(--app-border);

  color: var(--app-primary);

  font-size: .8rem;
  font-weight: 600;
}

.section-header h2 {
  margin: 16px 0 10px;

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
| GRID
|--------------------------------------------------------------------------
*/

.product-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill,
      minmax(220px, 1fr));

  gap: 16px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.product-card {
  position: relative;

  display: flex;
  flex-direction: column;
  justify-content: space-between;

  min-height: 120px;

  padding: 20px;

  cursor: pointer;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  transition:
    background-color .2s ease,
    border-color .2s ease,
    transform .2s ease,
    box-shadow .2s ease;
}

.product-card:hover {
  transform: translateY(-3px);

  background: var(--app-hover);

  border-color: var(--app-primary);

  box-shadow: 0 10px 24px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| SELECTED
|--------------------------------------------------------------------------
*/

.product-card--selected {
  background: var(--app-hover);

  border-color: var(--app-primary);

  box-shadow: 0 0 0 1px var(--app-primary);
}

.selected-icon {
  position: absolute;

  top: 14px;
  right: 14px;

  color: var(--app-primary);

  font-size: 1.3rem;
}

/*
|--------------------------------------------------------------------------
| CONTENT
|--------------------------------------------------------------------------
*/

.product-name {
  padding-right: 28px;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;

  line-height: 1.5;
}

.product-price {
  margin-top: 18px;

  color: var(--app-primary);

  font-size: 1.1rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .product-section {
    margin-top: 48px;

    padding-inline: 16px;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .product-grid {
    grid-template-columns: repeat(2, 1fr);

    gap: 12px;
  }

  .product-card {
    min-height: 105px;

    padding: 16px;
  }

  .product-name {
    font-size: .92rem;
  }

  .product-price {
    margin-top: 14px;

    font-size: 1rem;
  }

}
</style>
