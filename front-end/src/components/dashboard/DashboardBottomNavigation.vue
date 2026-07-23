<template>

  <q-footer bordered class="dashboard-bottom-nav">

    <q-toolbar>

      <q-btn flat no-caps class="nav-button" @click="$emit('overview')">

        <div class="nav-content">

          <q-icon name="dashboard" size="24px" />

          <span>
            Overview
          </span>

        </div>

      </q-btn>

      <q-btn flat no-caps class="nav-button" @click="$emit('menu')">

        <div class="nav-content">

          <q-icon name="menu" size="24px" />

          <span>
            Menu
          </span>

        </div>

      </q-btn>

      <q-btn flat no-caps class="nav-button" @click="$emit('profile')">

        <div class="nav-content">

          <q-icon name="person" size="24px" />

          <span>
            Profile
          </span>

        </div>

      </q-btn>

    </q-toolbar>

  </q-footer>

</template>

<script setup>

defineEmits([
  'overview',
  'menu',
  'profile',
])

</script>

<style scoped lang="scss">
.dashboard-bottom-nav {
  display: none;

  background: var(--app-surface);

  border-top: 1px solid var(--app-border);
}

.q-toolbar {
  justify-content: space-around;

  padding: 4px 0;
}

.nav-button {
  flex: 1;

  min-height: 64px;

  border-radius: 0;

  color: var(--app-text-secondary);
}

.nav-content {
  display: flex;
  flex-direction: column;

  align-items: center;

  gap: 4px;
}

.nav-content span {
  font-size: .75rem;

  font-weight: 500;
}

@media (max-width: 1023px) {

  .dashboard-bottom-nav {
    display: block;
  }

}
</style>
