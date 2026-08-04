<template>

  <q-drawer :mini="mini" show-if-above :width="280" :mini-width="72" bordered class="dashboard-drawer">

    <!-- PROFILE -->

    <div class="drawer-profile">

      <q-avatar size="52px" color="accent" text-color="white">

        {{ userInitial }}

      </q-avatar>

      <template v-if="!mini">

        <div class="profile-info">

          <div class="profile-name">

            {{ user.name }}

          </div>

          <div class="profile-role">

            {{ roleLabel }}

          </div>

        </div>

      </template>

    </div>

    <!-- NAVIGATION -->

    <q-list class="drawer-menu">

      <q-item v-for="item in visibleNavigationItems" :key="item.to" clickable :to="item.to" exact class="drawer-item">

        <q-item-section avatar>

          <q-icon :name="item.icon" />

        </q-item-section>

        <q-item-section v-if="!mini">

          {{ item.label }}

        </q-item-section>

        <q-tooltip v-if="mini" anchor="center right" self="center left">

          {{ item.label }}

        </q-tooltip>

      </q-item>

    </q-list>

    <div class="drawer-divider"></div>

    <!-- ACCOUNT -->

    <q-list class="drawer-menu">

      <q-item clickable :to="profileRoute" class="drawer-item">

        <q-item-section avatar>

          <q-icon name="person" />

        </q-item-section>

        <q-item-section v-if="!mini">

          Profile

        </q-item-section>

      </q-item>

      <q-item clickable :to="storeRoute" class="drawer-item">

        <q-item-section avatar>

          <q-icon name="storefront" />

        </q-item-section>

        <q-item-section v-if="!mini">

          EI Gaming Store

        </q-item-section>

      </q-item>

      <q-item clickable class="drawer-item logout-item" @click="emit('logout')">

        <q-item-section avatar>

          <q-icon name="logout" />

        </q-item-section>

        <q-item-section v-if="!mini">

          Logout

        </q-item-section>

      </q-item>

    </q-list>

  </q-drawer>

</template>

<script setup>

import {

  computed

} from 'vue'

const props = defineProps({

  mini: Boolean,

  user: {

    type: Object,

    required: true,

  },

  navigationItems: {

    type: Array,

    default: () => [],

  },

  profileRoute: {

    type: String,

    default: '/profile',

  },

  storeRoute: {

    type: String,

    default: '/',

  },

  roleLabel: {

    type: String,

    default: '',

  },

})

const emit = defineEmits([

  'logout',

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

/*
|--------------------------------------------------------------------------
| PROFILE
|--------------------------------------------------------------------------
*/

const userInitial = computed(() => {

  if (!props.user?.name) {

    return '?'

  }

  return props.user.name
    .charAt(0)
    .toUpperCase()

})

</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DRAWER
|--------------------------------------------------------------------------
*/

.dashboard-drawer {
  background: var(--app-surface);

  border-right: 1px solid var(--app-border);
}

/*
|--------------------------------------------------------------------------
| PROFILE
|--------------------------------------------------------------------------
*/

.drawer-profile {
  display: flex;
  align-items: center;

  gap: 16px;

  padding: 24px 20px;

  min-height: 92px;
}

.profile-info {
  display: flex;
  flex-direction: column;

  gap: 4px;

  overflow: hidden;
}

.profile-name {
  color: var(--app-text);

  font-size: 1rem;
  font-weight: 600;

  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.profile-role {
  color: var(--app-text-secondary);

  font-size: .85rem;

  text-transform: capitalize;
}

/*
|--------------------------------------------------------------------------
| DIVIDER
|--------------------------------------------------------------------------
*/

.drawer-divider {
  margin: 8px 16px 16px;

  border-top: 1px solid var(--app-border);
}

/*
|--------------------------------------------------------------------------
| MENU
|--------------------------------------------------------------------------
*/

.drawer-menu {
  padding: 0 12px;
}

.drawer-item {
  margin-bottom: 6px;

  border-radius: 14px;

  color: var(--app-text-secondary);

  transition:
    background .2s ease,
    color .2s ease;
}

.drawer-item:hover {
  background: rgba(var(--app-primary-rgb), .08);

  color: var(--app-text);
}

:deep(.q-router-link--active) {
  background: rgba(var(--app-primary-rgb), .12);

  color: var(--app-primary);

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
| SPECIAL ITEM
|--------------------------------------------------------------------------
*/

.logout-item {
  color: var(--app-negative);
}

.logout-item:hover {
  background: rgba(239, 68, 68, .08);

  color: var(--app-negative);
}

/*
|--------------------------------------------------------------------------
| MINI DRAWER
|--------------------------------------------------------------------------
*/

:deep(.q-drawer--mini) .drawer-profile {
  justify-content: center;

  padding: 20px 0;
}

:deep(.q-drawer--mini) .drawer-menu {
  padding: 0 8px;
}

:deep(.q-drawer--mini) .drawer-item {
  justify-content: center;
}

:deep(.q-drawer--mini) .q-item__section--avatar {
  min-width: auto;
}

/*
|--------------------------------------------------------------------------
| SCROLLBAR
|--------------------------------------------------------------------------
*/

:deep(.q-scrollarea__content) {
  padding-bottom: 20px;
}
</style>
