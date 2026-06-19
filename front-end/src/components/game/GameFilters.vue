<template>
  <div class="filters">
    <q-btn v-for="item in items" :key="item" flat no-caps :label="item" class="filter-btn"
      :class="{ 'filter-btn--active': modelValue === item }" @click="$emit('update:modelValue', item)" />
  </div>
</template>

<script setup>
defineProps({
  items: {
    type: Array,
    required: true
  },

  modelValue: {
    type: String,
    required: true
  }
})

defineEmits(['update:modelValue'])
</script>

<style lang="scss" scoped>
.filters {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.filter-btn {
  color: rgba(255, 255, 255, 0.7);

  border-radius: 999px;

  transition: all 0.2s ease;
}

.filter-btn--active {
  background: rgba($sakura, 0.12);
  color: $sakura;
}
</style>
