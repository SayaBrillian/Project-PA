<template>
  <q-expansion-item
    class="faq-item"
    expand-separator
    :label="item.question"
  >
    <div class="faq-answer">
      {{ item.answer }}
    </div>
  </q-expansion-item>
</template>

<script setup>
defineProps({
  item: {
    type: Object,
    required: true
  }
})
</script>

<style lang="scss" scoped>
.faq-item {
  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.1);
  border-radius: 16px;

  overflow: hidden;

  transition: border-color 0.25s ease;
}

.faq-item:hover {
  border-color: rgba($sakura, 0.25);
}

.faq-answer {
  padding: 0 16px 20px;

  color: rgba(255, 255, 255, 0.7);
  line-height: 1.7;
}
</style>
