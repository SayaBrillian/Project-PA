<template>
  <q-layout class="app-layout">
    <q-header class="floating-navbar" bordered>
      <q-toolbar>
        <div class="logo">
          <span class="logo-main">EI GAMING STORE</span>
        </div>
        <q-space />
        <div class="nav-menu">
          <q-space />
          <q-btn flat no-caps label="Home" to="/" class="nav-link" active-class="nav-link--active" />
          <q-btn flat no-caps label="Product" to="/product" class="nav-link" active-class="nav-link--active" />
          <q-btn flat no-caps label="Check" to="/check-transaction" class="nav-link" active-class="nav-link--active" />
          <q-btn flat no-caps label="Help" to="/help" class="nav-link" active-class="nav-link--active" />
          <q-btn flat no-caps label="About Us" to="/about" class="nav-link" active-class="nav-link--active" />
          <q-space />

          <ProfileMenu />
        </div>
      </q-toolbar>
    </q-header>
    <q-page-container class="page-container">
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import ProfileMenu from 'components/ProfileMenu.vue'
</script>

<style lang="scss" scoped>
.app-layout {
  min-height: 100vh;

  background: linear-gradient(180deg,
      $dark 0%,
      $secondary 100%);
}

.floating-navbar {
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);

  width: min(1280px, calc(100vw - 32px));
  z-index: 2000;

  background: linear-gradient(135deg,
      rgba($dark, 0.92) 0%,
      rgba($secondary, 0.85) 100%);

  backdrop-filter: blur(18px);

  border: 1px solid rgba($sakura, 0.15);
  border-radius: 22px;

  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.3),
    0 0 24px rgba($sakura, 0.1);

  overflow: hidden;

  &::before {
    content: '';
    position: absolute;

    top: 0;
    left: 24px;
    right: 24px;

    height: 1px;

    background: linear-gradient(90deg,
        transparent,
        rgba($sakura, 0.8),
        transparent);
  }
}

.floating-navbar :deep(.q-toolbar) {
  min-height: 72px;
  padding: 0 20px;
}

.page-container {
  max-width: 1280px;
  margin: 0 auto;

  padding-top: 110px !important;
  padding-left: 24px;
  padding-right: 24px;
  padding-bottom: 32px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 4px;
}

.logo-main {
  font-size: 24px;
  font-weight: 800;
  line-height: 1;
  color: $sakura;
}

.nav-menu {
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-link {
  color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  font-weight: 500;

  transition:
    background-color 0.25s ease,
    color 0.25s ease,
    transform 0.25s ease;

  &:hover {
    color: white;
    background: rgba($sakura, 0.08);
    transform: translateY(-1px);
  }
}

:deep(.nav-link--active) {
  color: $sakura;

  background: rgba($sakura, 0.14);

  box-shadow:
    inset 0 0 0 1px rgba($sakura, 0.15),
    0 4px 12px rgba($sakura, 0.08);
}
</style>
