<template>

  <q-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" position="bottom"
    transition-show="slide-up" transition-hide="slide-down">

    <q-card class="profile-dialog">

      <!-- HANDLE -->

      <div class="dialog-handle"></div>

      <!-- PROFILE -->

      <div class="profile-header">

        <q-avatar size="72px" color="accent" text-color="white">

          {{ userInitial }}

        </q-avatar>

        <div class="profile-name">

          {{ user.name }}

        </div>

        <div class="profile-role">

          {{ roleLabel }}

        </div>

      </div>

      <div class="dialog-divider"></div>

      <!-- ACCOUNT -->

      <q-list class="profile-menu">

        <q-item clickable to="/dashboard/profile" class="profile-item" v-close-popup>

          <q-item-section avatar>

            <q-icon name="person" />

          </q-item-section>

          <q-item-section>

            Profile

          </q-item-section>

        </q-item>

        <q-item clickable to="/" class="profile-item" v-close-popup>

          <q-item-section avatar>

            <q-icon name="storefront" />

          </q-item-section>

          <q-item-section>

            EI Gaming Store

          </q-item-section>

        </q-item>

        <q-item clickable class="profile-item logout-item" @click="$emit('logout')" v-close-popup>

          <q-item-section avatar>

            <q-icon name="logout" />

          </q-item-section>

          <q-item-section>

            Logout

          </q-item-section>

        </q-item>

      </q-list>

    </q-card>

  </q-dialog>

</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({

  modelValue: Boolean,

  user: {
    type: Object,
    required: true,
  },

})

defineEmits([
  'update:modelValue',
  'logout',
])

const userInitial = computed(() => {

  if (!props.user?.name) {

    return '?'

  }

  return props.user.name.charAt(0).toUpperCase()

})

const roleLabel = computed(() => {

  return props.user.role === 'super_admin'
    ? 'Super Admin'
    : 'Admin'

})
</script>

<style scoped lang="scss">
.profile-dialog {
  width: 100%;
  max-width: 100%;

  margin: 0;

  background: var(--app-surface);

  border-radius: 24px 24px 0 0;

  overflow: hidden;
}

.dialog-handle {
  width: 48px;
  height: 5px;

  margin: 12px auto 24px;

  border-radius: 999px;

  background: var(--app-border);
}

.profile-header {
  display: flex;
  flex-direction: column;

  align-items: center;

  padding: 0 24px 28px;
}

.profile-name {
  margin-top: 16px;

  color: var(--app-text);

  font-size: 1.15rem;
  font-weight: 700;
}

.profile-role {
  margin-top: 6px;

  color: var(--app-text-secondary);

  font-size: .9rem;
}

.dialog-divider {
  margin: 0 20px;

  border-top: 1px solid var(--app-border);
}

.profile-menu {
  padding: 20px 16px 24px;
}

.profile-item {
  margin-bottom: 8px;

  border-radius: 16px;

  color: var(--app-text-secondary);

  transition:
    background .2s ease,
    color .2s ease;
}

.profile-item:hover {
  background: rgba($accent, .08);

  color: var(--app-text);
}

.logout-item {
  color: var(--app-negative);
}

.logout-item:hover {
  background: rgba(239, 68, 68, .08);

  color: var(--app-negative);
}

:deep(.q-item__section--avatar) {
  min-width: 44px;
}

:deep(.q-icon) {
  font-size: 1.25rem;
}
</style>