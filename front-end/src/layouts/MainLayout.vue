<template>
  <q-layout view="hHh Lpr lFf" class="app-layout">
    <MainNavbar />

    <q-page-container class="page-container">
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import MainNavbar from 'components/main/MainNavbar.vue'
</script>

<style scoped lang="scss">
.app-layout {
  min-height: 100vh;
  background: var(--app-bg);
}

.page-container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding-inline: 24px;
  box-sizing: border-box;
}
</style>
