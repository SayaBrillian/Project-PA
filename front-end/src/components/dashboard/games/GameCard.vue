<template>
  <q-card
    class="game-card"
    clickable
    @click="$emit('details', game)"
  >
    <div class="game-image-wrapper">

      <img
        :src="
          gameImages[game.slug]
          || gameImages.placeholder
        "
        :alt="game.name"
        class="game-image"
      >

      <div
        class="game-status"
        :class="{
          active: game.is_active,
          inactive: !game.is_active,
        }"
      >
        {{
          game.is_active
            ? 'Active'
            : 'Inactive'
        }}
      </div>

    </div>

    <div class="game-content">

      <div class="game-name">
        {{ game.name }}
      </div>

      <div class="game-publisher">
        {{ game.publisher }}
      </div>

      <div class="game-key">
  {{ game.game_key }}
</div>

    </div>

  </q-card>
</template>

<script setup>
import gameImages from 'src/assets/images'

defineProps({
  game: {
    type: Object,
    required: true,
  },
})

defineEmits([
  'details',
])
</script>

<style lang="scss" scoped>

.game-card {
  overflow: hidden;

  border-radius: 20px;

  background: white;

  border: 1px solid rgba(
    $sakura,
    .12
  );

  cursor: pointer;

  transition:
    transform .25s ease,
    box-shadow .25s ease;
}

.game-card:hover {
  transform: translateY(-4px);

  box-shadow:
    0 10px 30px rgba(
      0,
      0,
      0,
      .08
    );
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
}

.game-status {
  position: absolute;

  top: 12px;
  right: 12px;

  padding: 6px 12px;

  border-radius: 999px;

  font-size: .75rem;
  font-weight: 600;
}

.active {
  background:
    rgba(
      34,
      197,
      94,
      .15
    );

  color: #16a34a;
}

.inactive {
  background:
    rgba(
      239,
      68,
      68,
      .15
    );

  color: #dc2626;
}

.game-content {
  padding: 18px;
}

.game-name {
  font-size: 1rem;
  font-weight: 700;

  color: $dark;
}

.game-publisher {
  margin-top: 6px;

  color:
    rgba(
      0,
      0,
      0,
      .55
    );

  font-size: .9rem;
}

.game-key {
  margin-top: 8px;

  color:
    rgba(
      0,
      0,
      0,
      .4
    );

  font-size: .8rem;

  font-weight: 600;

  text-transform: uppercase;
}

</style>