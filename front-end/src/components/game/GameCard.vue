<template>
  <q-card class="game-card" flat clickable :to="`/products/${game.slug}`">

    <div class="game-image-wrapper">

      <img :src="`/games/${game.slug}.webp`" :alt="game.name" class="game-image">

      <div v-if="!game.is_available" class="coming-soon">
        Coming Soon
      </div>

    </div>

    <q-card-section class="game-content">
      <div class="game-name">
        {{ game.name }}
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

  background: rgba(255, 255, 255, .03);

  border: 1px solid rgba($sakura, .12);
  border-radius: 20px;

  cursor: pointer;

  transition:
    transform .25s ease,
    border-color .25s ease,
    box-shadow .25s ease;
}

.game-card:hover {
  transform: translateY(-6px);

  border-color: rgba($sakura, .25);

  box-shadow:
    0 10px 30px rgba(0, 0, 0, .25),
    0 0 20px rgba($sakura, .08);
}

.game-image-wrapper {
  position: relative;

  aspect-ratio: 16 / 9;

  overflow: hidden;
}

.game-image {
  width: 100%;
  height: 100%;

  object-fit: cover;

  transition: transform .4s ease;
}

.game-card:hover .game-image {
  transform: scale(1.05);
}

.coming-soon {
  position: absolute;

  top: 12px;
  right: 12px;

  padding: 6px 12px;

  background: rgba(0, 0, 0, .75);

  backdrop-filter: blur(8px);

  border: 1px solid rgba(255, 255, 255, .1);
  border-radius: 999px;

  color: white;
  font-size: .75rem;
  font-weight: 600;
}

.game-content {
  padding: 18px;
}

.game-name {
  text-align: center;

  font-size: 1rem;
  font-weight: 600;

  color: white;
}
</style>
