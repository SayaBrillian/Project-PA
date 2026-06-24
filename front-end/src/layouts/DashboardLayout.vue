<template>
  <q-layout view="hHh Lpr lFf" class="dashboard-layout">

    <!-- HEADER -->
    <q-header class="dashboard-header">

      <q-toolbar>

        <q-btn
          flat
          round
          dense
          icon="menu"
          class="mobile-menu-btn"
          @click="leftDrawerOpen = !leftDrawerOpen"
        />

        <q-toolbar-title>
          Dashboard Admin
        </q-toolbar-title>

        <q-avatar
          size="40px"
          color="accent"
          text-color="white"
        >
          A
        </q-avatar>

      </q-toolbar>

    </q-header>

    <!-- SIDEBAR -->
    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      :width="280"
      class="dashboard-drawer"
    >

      <div class="sidebar-header">

        <div class="sidebar-logo">
          EI Gaming
        </div>

        <div class="sidebar-subtitle">
          Admin Dashboard
        </div>

      </div>

      <q-list>

        <q-item
          v-for="item in menuItems"
          :key="item.label"
          clickable
          :to="item.to"
          exact
          class="sidebar-item"
        >
          <q-item-section avatar>
            <q-icon :name="item.icon" />
          </q-item-section>

          <q-item-section>
            {{ item.label }}
          </q-item-section>
        </q-item>

      </q-list>

      <div class="sidebar-divider" />

      <q-list>

        <q-item
          v-for="item in accountItems"
          :key="item.label"
          clickable
          :to="item.to"
          class="sidebar-item"
        >
          <q-item-section avatar>
            <q-icon :name="item.icon" />
          </q-item-section>

          <q-item-section>
            {{ item.label }}
          </q-item-section>
        </q-item>

        <q-item
          clickable
          class="sidebar-item logout-item"
        >
          <q-item-section avatar>
            <q-icon name="logout" />
          </q-item-section>

          <q-item-section>
            Logout
          </q-item-section>
        </q-item>

      </q-list>

    </q-drawer>

    <!-- CONTENT -->
    <q-page-container>

      <div class="dashboard-content">
        <router-view />
      </div>

    </q-page-container>

  </q-layout>
</template>

<script setup>
import { ref } from 'vue'

const leftDrawerOpen = ref(true)

const menuItems = [
  {
    label: 'Overview',
    icon: 'dashboard',
    to: '/dashboard',
  },
  {
    label: 'Games',
    icon: 'sports_esports',
    to: '/dashboard/games',
  },
  {
    label: 'Products',
    icon: 'inventory_2',
    to: '/dashboard/products',
  },
  {
    label: 'Transactions',
    icon: 'receipt_long',
    to: '/dashboard/transactions',
  },
]

const accountItems = [
  {
    label: 'Profile',
    icon: 'person',
    to: '/dashboard/profile',
  },
  {
    label: 'Settings',
    icon: 'settings',
    to: '/dashboard/settings',
  },
]
</script>

<style lang="scss" scoped>

.dashboard-layout {
  background: $sakura;
}

.dashboard-header {
  background: $dark;

  color: white;

  border-bottom:
    1px solid rgba(
      $sakura,
      .15
    );
}

.dashboard-drawer {
  background: $secondary !important;

  color: white;

  border-right:
    1px solid rgba(
      $sakura,
      .15
    );
}
:deep(.q-drawer) {
  background: $secondary !important;
}

:deep(.q-drawer__content) {
  background: $secondary !important;
}

.sidebar-header {
  padding: 28px 24px;
}

.sidebar-logo {
  color: $sakura;

  font-size: 1.4rem;
  font-weight: 700;
}

.sidebar-subtitle {
  margin-top: 4px;

  color: rgba(
  255,
  255,
  255,
  .55
);

  font-size: .85rem;
}

.sidebar-divider {
  margin: 16px 20px;

  border-top: 1px solid rgba(
    $sakura,
    .12
  );
}

.sidebar-item {
  margin: 4px 12px;

  border-radius: 12px;

  color: rgba(
  255,
  255,
  255,
  .85
);

  transition:
    background .2s ease,
    color .2s ease;
}

.sidebar-item:hover {
  background: rgba(
    $sakura,
    .12
  );

  color: white;
}

:deep(.q-router-link--active) {
  background: rgba(
    $sakura,
    .18
  );

  color: white;

  font-weight: 600;
}

.logout-item {
  color: #ff6b81;
}

.logout-item:hover {
  background: rgba(
    255,
    107,
    129,
    .08
  );

  color: #ff6b81;
}

.dashboard-content {
  min-height: 100vh;

  padding: 24px;

  background:
    linear-gradient(
      180deg,
      rgba($sakura, .06) 0%,
      #ffffff 100%
    );
}

.mobile-menu-btn {
  display: none;
}

:deep(.q-item__section--avatar) {
  min-width: 40px;
}

:deep(.q-icon) {
  font-size: 1.2rem;
}

@media (max-width: 1024px) {

  .mobile-menu-btn {
    display: inline-flex;
  }

  .dashboard-content {
    padding: 16px;
  }

}

</style>