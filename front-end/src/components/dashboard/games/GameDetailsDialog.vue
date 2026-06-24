<template>
  <q-dialog
    :model-value="modelValue"
    @update:model-value="
      emit(
        'update:modelValue',
        $event
      )
    "
  >

    <q-card
      v-if="game"
      class="dialog-card"
    >

      <q-card-section>

        <div class="game-title">
          {{ game.name }}
        </div>

        <div class="game-publisher">
          {{ game.publisher }}
        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="detail-grid">

          <div class="detail-item">
            <span>Slug</span>
            <strong>
              {{ game.slug }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Game Key</span>
            <strong>
              {{ game.game_key }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Status</span>

            <q-badge
              :color="
                game.is_active
                  ? 'positive'
                  : 'negative'
              "
            >
              {{
                game.is_active
                  ? 'Active'
                  : 'Inactive'
              }}
            </q-badge>
          </div>

          <div class="detail-item">
            <span>Latest Patch</span>
            <strong>
              {{ game.latest_patch }}
            </strong>
          </div>

          <div class="detail-item">
            <span>Latest Update</span>
            <strong>
              {{ game.latest_update }}
            </strong>
          </div>

        </div>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="section-title">
          Description
        </div>

        <p>
          {{ game.description }}
        </p>

      </q-card-section>

      <q-separator />

      <q-card-section>

        <div class="links">

          <q-btn
            outline
            color="accent"
            icon="public"
            label="Website"
            :href="game.official_url"
            target="_blank"
          />

          <q-btn
            outline
            color="accent"
            icon="description"
            label="Patch Notes"
            :href="game.patchnote_url"
            target="_blank"
          />

        </div>

      </q-card-section>

      <q-card-actions align="right">

        <q-btn
          flat
          color="negative"
          label="Delete"
          @click="
            emit(
              'delete',
              game
            )
          "
        />

        <q-btn
          flat
          color="accent"
          label="Update"
          @click="
            emit(
              'update',
              game
            )
          "
        />

        <q-btn
          flat
          label="Close"
          v-close-popup
        />

      </q-card-actions>

    </q-card>

  </q-dialog>
</template>

<script setup>

defineProps({
  modelValue: Boolean,
  game: Object,
})

const emit = defineEmits([
  'update:modelValue',
  'update',
  'delete',
])

</script>

<style lang="scss" scoped>

.dialog-card {
  width: 800px;
  max-width: 95vw;

  border-radius: 24px;
}

.game-title {
  font-size: 1.5rem;
  font-weight: 700;
}

.game-publisher {
  margin-top: 4px;

  color: rgba(
    0,
    0,
    0,
    .55
  );
}

.detail-grid {
  display: grid;

  grid-template-columns:
    repeat(
      2,
      1fr
    );

  gap: 16px;
}

.detail-item {
  display: flex;
  flex-direction: column;
}

.detail-item span {
  color: rgba(
    0,
    0,
    0,
    .5
  );

  font-size: .85rem;
}

.section-title {
  margin-bottom: 12px;

  font-weight: 700;
}

.links {
  display: flex;

  gap: 12px;
}

</style>