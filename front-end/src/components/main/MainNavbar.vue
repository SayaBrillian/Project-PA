<template>
  <template v-if="$q.screen.gt.sm">
    <q-header class="desktop-navbar" bordered>
      <q-toolbar class="navbar-toolbar">

        <!-- Logo -->
        <div class="logo">
          <span class="logo-main">
            EI GAMING STORE
          </span>
        </div>

        <q-space />

        <!-- Navigation -->
        <div class="nav-menu">

          <q-btn v-for="menu in desktopMenus" :key="menu.to" flat no-caps :label="menu.label" :to="menu.to"
            class="nav-link" active-class="nav-link--active" />

          <ProfileMenu mode="desktop" />

        </div>

      </q-toolbar>
    </q-header>
  </template>

  <!-- Mobile -->
  <template v-else>

    <!-- Header -->
    <q-header class="mobile-header" bordered>
      <q-toolbar class="mobile-toolbar">

        <div class="logo">
          <span class="logo-main">
            EI GAMING STORE
          </span>
        </div>

      </q-toolbar>
    </q-header>

    <!-- Bottom Navigation -->
    <q-footer class="mobile-footer" bordered>
      <q-toolbar class="mobile-footer-toolbar">

        <q-btn v-for="menu in mobileMenus" :key="menu.id" flat stack no-caps :icon="menu.icon" :label="menu.label"
          :to="menu.to" class="mobile-nav-link" active-class="mobile-nav-link--active" />

        <ProfileMenu mode="mobile" />

      </q-toolbar>
    </q-footer>

  </template>
</template>

<script setup>
import { useQuasar } from 'quasar'
import ProfileMenu from 'components/main/ProfileMenu.vue'

const $q = useQuasar()

const desktopMenus = [
  {
    id: 'home',
    label: 'Home',
    icon: 'home',
    to: '/',
  },
  {
    id: 'product',
    label: 'Product',
    icon: 'storefront',
    to: '/product',
  },
  {
    id: 'check',
    label: 'Check',
    icon: 'receipt_long',
    to: '/check-transaction',
  },
  {
    id: 'help',
    label: 'Help',
    icon: 'help',
    to: '/help',
  },
  {
    id: 'about',
    label: 'About Us',
    icon: 'info',
    to: '/about',
  },
]

const mobileMenus = [
  {
    id: 'home',
    label: 'Home',
    icon: 'home',
    to: '/',
  },
  {
    id: 'product',
    label: 'Product',
    icon: 'storefront',
    to: '/product',
  },
  {
    id: 'check',
    label: 'Check',
    icon: 'receipt_long',
    to: '/check-transaction',
  },
]
</script>

<style scoped lang="scss">
.desktop-navbar {
  background: var(--app-surface);

  color: var(--app-text);

  border-bottom: 1px solid var(--app-border);

  box-shadow: 0 4px 20px var(--app-shadow);
}

.navbar-toolbar {
  max-width: 1280px;
  margin: 0 auto;

  min-height: 72px;

  padding: 0 24px;
}

.logo {
  display: flex;
  align-items: center;
}

.logo-main {
  font-size: 24px;
  font-weight: 800;
  letter-spacing: .5px;

  color: var(--app-sakura);
}

.nav-menu {
  display: flex;
  align-items: center;

  gap: 8px;
}

.nav-link {
  color: var(--app-text-secondary);

  border-radius: 12px;

  font-weight: 500;

  transition:
    background-color .25s,
    color .25s;

  &:hover {
    background: rgba(123, 79, 166, .08);
    color: var(--app-text);
  }
}

:deep(.nav-link--active) {
  color: var(--app-primary);

  background: rgba(123, 79, 166, .12);

  font-weight: 600;
}

/* ==========================================
   Mobile Header
========================================== */

.mobile-header {
  background: var(--app-surface);

  color: var(--app-text);

  border-bottom: 1px solid var(--app-border);

  box-shadow: 0 2px 12px var(--app-shadow);
}

.mobile-toolbar {
  display: flex;

  justify-content: center;
  align-items: center;

  min-height: 60px;

  padding: 0 16px;
}

/* ==========================================
   Mobile Footer
========================================== */

.mobile-footer {
  background: var(--app-surface);

  border-top: 1px solid var(--app-border);

  box-shadow: 0 -2px 12px var(--app-shadow);
}

.mobile-footer-toolbar {
  display: grid;

  grid-auto-flow: column;
  grid-auto-columns: 1fr;

  align-items: center;

  min-height: 70px;

  padding: 6px 8px;
}

/* ==========================================
   Mobile Navigation
========================================== */

.mobile-nav-link {
  width: 100%;

  min-height: 58px;

  border-radius: 12px;

  color: var(--app-text-secondary);

  transition:
    background-color .2s ease,
    color .2s ease;
}

:deep(.mobile-nav-link--active) {
  color: var(--app-primary);

  background: rgba(123, 79, 166, .12);
}

.mobile-nav-link :deep(.q-icon) {
  font-size: 22px;
}

.mobile-nav-link :deep(.block) {
  margin-top: 2px;

  font-size: 11px;

  font-weight: 500;
}
</style>
