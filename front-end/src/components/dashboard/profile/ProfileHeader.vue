<template>
  <div class="profile-header">

    <div class="profile-avatar">

      <q-avatar size="92px" color="accent" text-color="white">
        {{ initials }}
      </q-avatar>

    </div>

    <div class="profile-content">

      <h1 class="profile-name">
        {{ profile?.name || '-' }}
      </h1>

      <div class="profile-meta">

        <q-chip dense color="accent" text-color="white" icon="person">
          {{ profile?.username || '-' }}
        </q-chip>

        <q-chip v-if="profile?.role" dense color="primary" text-color="white" icon="verified_user">
          {{ formatRole(profile.role) }}
        </q-chip>

      </div>

      <p class="profile-description">
        Kelola informasi akun dan keamanan akun Anda.
      </p>

    </div>

  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  profile: {
    type: Object,
    default: () => ({})
  }
})

const initials = computed(() => {

  if (!props.profile?.name) return '?'

  return props.profile.name
    .split(' ')
    .map(word => word[0])
    .join('')
    .substring(0, 2)
    .toUpperCase()

})

const formatRole = (role) => {

  if (!role) return ''

  return role
    .replaceAll('_', ' ')
    .replace(/\b\w/g, char => char.toUpperCase())

}
</script>

<style scoped lang="scss">
.profile-header {

  display: flex;

  align-items: center;

  gap: 24px;

  padding: 32px;

  border: 1px solid var(--app-border);

  border-radius: 24px;

  background: var(--app-surface);

}

.profile-avatar {

  flex-shrink: 0;

}

.profile-content {

  flex: 1;

}

.profile-name {

  margin: 0;

  color: var(--app-text);

  font-size: 2rem;

  font-weight: 700;

}

.profile-meta {

  display: flex;

  flex-wrap: wrap;

  gap: 8px;

  margin: 14px 0;

}

.profile-description {

  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;

}

:deep(.q-chip) {

  font-weight: 600;

}

@media (max-width: 768px) {

  .profile-header {

    flex-direction: column;

    align-items: center;

    text-align: center;

    padding: 24px;

  }

  .profile-meta {

    justify-content: center;

  }

  .profile-name {

    font-size: 1.6rem;

  }

}
</style>
