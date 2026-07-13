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
  background: var(--app-bg);
}
</style>
