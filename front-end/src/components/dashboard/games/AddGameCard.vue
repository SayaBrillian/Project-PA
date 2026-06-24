<template>
  <q-card
    class="add-game-card"
    clickable
    @click="$emit('click')"
  >

    <div class="add-content">

      <q-icon
        name="add"
        size="64px"
        class="add-icon"
      />

      <div class="add-title">
        Add Game
      </div>

      <div class="add-description">
        Tambahkan game baru
      </div>

    </div>

  </q-card>
</template>

<script setup>
defineEmits([
  'click',
])
</script>

<style lang="scss" scoped>

.add-game-card {
  min-height: 260px;

  display: flex;

  align-items: center;
  justify-content: center;

  background: white;

  border: 2px dashed rgba(
    $sakura,
    .25
  );

  border-radius: 20px;

  cursor: pointer;

  transition:
    transform .25s ease,
    border-color .25s ease,
    box-shadow .25s ease;
}

.add-game-card:hover {
  transform: translateY(-4px);

  border-color: $sakura;

  box-shadow:
    0 10px 30px rgba(
      0,
      0,
      0,
      .08
    );
}

.add-content {
  text-align: center;
}

.add-icon {
  color: $sakura;
}

.add-title {
  margin-top: 12px;

  color: $dark;

  font-size: 1.1rem;
  font-weight: 700;
}

.add-description {
  margin-top: 6px;

  color:
    rgba(
      0,
      0,
      0,
      .5
    );

  font-size: .9rem;
}

</style>    