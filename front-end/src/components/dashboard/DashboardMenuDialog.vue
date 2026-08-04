<template>

  <q-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" position="bottom"
    transition-show="slide-up" transition-hide="slide-down">

    <q-card class="menu-dialog">

      <!-- HANDLE -->

      <div class="dialog-handle"></div>

      <!-- HEADER -->

      <div class="dialog-header">

        <h2>

          Menu

        </h2>

      </div>

      <!-- NAVIGATION -->

      <q-list class="menu-list">

        <q-item v-for="item in visibleNavigationItems" :key="item.to" clickable :to="item.to" exact class="menu-item"
          v-close-popup>

          <q-item-section avatar>

            <q-icon :name="item.icon" />

          </q-item-section>

          <q-item-section>

            {{ item.label }}

          </q-item-section>

        </q-item>

      </q-list>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  computed
} from 'vue'

const props = defineProps({

  modelValue: Boolean,

  user: {
    type: Object,
    required: true,
  },

  navigationItems: {
    type: Array,
    default: () => [],
  },

})

defineEmits([
  'update:modelValue',
])

/*
|--------------------------------------------------------------------------
| NAVIGATION
|--------------------------------------------------------------------------
*/

const visibleNavigationItems = computed(() => {

  return props.navigationItems.filter(item => {

    if (!item.roles) {

      return true

    }

    return item.roles.includes(
      props.user.role
    )

  })

})

</script>



<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

.menu-dialog {
  display: flex;
  flex-direction: column;

  width: 100%;
  max-width: 100%;

  height: auto;

  max-height: 80dvh;

  margin: 0;

  background: var(--app-surface);

  border-radius: 24px 24px 0 0;

  overflow: hidden;
}

/*
|--------------------------------------------------------------------------
| HANDLE
|--------------------------------------------------------------------------
*/

.dialog-handle {
  width: 48px;
  height: 5px;

  margin: 12px auto 20px;

  border-radius: 999px;

  background: var(--app-border);

  flex-shrink: 0;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.dialog-header {
  padding: 0 24px 20px;

  flex-shrink: 0;
}

.dialog-header h2 {
  margin: 0;

  color: var(--app-text);

  font-size: 1.35rem;
  font-weight: 700;
}

/*
|--------------------------------------------------------------------------
| MENU
|--------------------------------------------------------------------------
*/

.menu-list {
  flex: 1;

  padding: 0 16px 20px;

  overflow-y: auto;
}

.menu-item {
  margin-bottom: 8px;

  border-radius: 16px;

  color: var(--app-text-secondary);

  transition:
    background .2s ease,
    color .2s ease;
}

.menu-item:hover {
  background: rgba($accent, .08);

  color: var(--app-text);
}

:deep(.q-router-link--active) {
  background: rgba($accent, .12);

  color: $accent;

  font-weight: 600;
}

:deep(.q-item__section--avatar) {
  min-width: 44px;
}

:deep(.q-icon) {
  font-size: 1.25rem;
}

/*
|--------------------------------------------------------------------------
| SCROLLBAR
|--------------------------------------------------------------------------
*/

.menu-list::-webkit-scrollbar {
  width: 6px;
}

.menu-list::-webkit-scrollbar-thumb {
  border-radius: 999px;

  background: var(--app-border);
}
</style>
