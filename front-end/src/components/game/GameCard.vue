<template>
  <q-card class="game-card" flat clickable>

    <div class="game-image-wrapper">
      <img :src="game.image" :alt="game.name" class="game-image">

      <div v-if="game.isUpdated" class="update-badge">
        Updated
      </div>
    </div>

    <q-card-section class="game-content">
      <div class="game-name">
        {{ game.name }}
      </div>

      <div class="game-category">
        {{ game.category }}
      </div>
    </q-card-section>

  </q-card>
</template>

<script setup>
defineProps({
  game: {
    type: Object,
    required: true
  }
})
</script>

<style lang="scss" scoped>
.game-card {
  overflow: hidden;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 20px;

  transition:
    transform 0.25s ease,
    border-color 0.25s ease;
}

.game-card:hover {
  transform: translateY(-4px);
  border-color: rgba($sakura, 0.25);
}

.game-image-wrapper {
  position: relative;
  aspect-ratio: 16 / 9;
}

.game-image {
  width: 100%;
  height: 100%;

  object-fit: cover;
}

.update-badge {
  position: absolute;
  top: 12px;
  right: 12px;

  padding: 4px 10px;

  background: rgba($accent, 0.9);

  color: $dark;
  font-size: 12px;
  font-weight: 600;

  border-radius: 999px;
}

.game-content {
  padding: 16px;
}

.game-name {
  font-size: 1rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.65);
}

.game-category {
  margin-top: 6px;

  color: rgba(255, 255, 255, 0.65);
  font-size: 0.875rem;
}
</style>
