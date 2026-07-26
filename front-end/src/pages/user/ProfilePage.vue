<template>

  <q-page class="profile-page">

    <ProfileHeader :profile="profile" />

    <ProfileInformationCard :profile="profile" :loading="profileLoading" @save="updateProfile" />

    <ChangePasswordCard :loading="passwordLoading" @save="changePassword" />

  </q-page>

</template>

<script setup>
import {
  ref,
  onMounted
} from 'vue'

import { Notify } from 'quasar'

import api from 'src/axios'

import ProfileHeader from 'src/components/dashboard/profile/ProfileHeader.vue'
import ProfileInformationCard from 'src/components/dashboard/profile/ProfileInformationCard.vue'
import ChangePasswordCard from 'src/components/dashboard/profile/ChangePasswordCard.vue'

const profile = ref({})

const profileLoading = ref(false)

const passwordLoading = ref(false)

/*
|--------------------------------------------------------------------------
| LOAD PROFILE
|--------------------------------------------------------------------------
*/

const loadProfile = async () => {

  try {

    const response =
      await api.get(
        '/api/user/me'
      )

    profile.value =
      response.data.user

  } catch (error) {

    console.error(
      'Load Profile Error:',
      error
    )

    Notify.create({

      type: 'negative',

      message: 'Gagal memuat data profile.'

    })

  }

}

/*
|--------------------------------------------------------------------------
| UPDATE PROFILE
|--------------------------------------------------------------------------
*/

const updateProfile = async (form) => {

  try {

    profileLoading.value = true

    await api.put(
      '/api/user/profile',
      form
    )

    Notify.create({

      type: 'positive',

      message: 'Profile berhasil diperbarui.'

    })

    await loadProfile()

  } catch (error) {

    console.error(
      'Update Profile Error:',
      error
    )

    Notify.create({

      type: 'negative',

      message:
        error.response?.data?.message ||
        'Gagal memperbarui profile.'

    })

  } finally {

    profileLoading.value = false

  }

}

/*
|--------------------------------------------------------------------------
| CHANGE PASSWORD
|--------------------------------------------------------------------------
*/

const changePassword = async (
  form,
  resetForm
) => {

  try {

    passwordLoading.value = true

    await api.put(
      '/api/user/change-password',
      form
    )

    Notify.create({

      type: 'positive',

      message:
        'Password berhasil diperbarui.'

    })

    resetForm()

  } catch (error) {

    console.error(
      'Change Password Error:',
      error
    )

    Notify.create({

      type: 'negative',

      message:
        error.response?.data?.message ||
        'Gagal mengubah password.'

    })

  } finally {

    passwordLoading.value = false

  }

}

onMounted(() => {

  loadProfile()

})
</script>

<style scoped lang="scss">
.profile-page {

  max-width: 1100px;

  margin: 0 auto;

  padding: 24px;

  display: flex;

  flex-direction: column;

  gap: 24px;

}

/*
|--------------------------------------------------------------------------
| CARD ANIMATION
|--------------------------------------------------------------------------
*/

.profile-page>* {

  animation: fadeUp .25s ease;

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .profile-page {

    padding: 16px;

    gap: 16px;

  }

}

/*
|--------------------------------------------------------------------------
| ANIMATION
|--------------------------------------------------------------------------
*/

@keyframes fadeUp {

  from {

    opacity: 0;

    transform: translateY(12px);

  }

  to {

    opacity: 1;

    transform: translateY(0);

  }

}
</style>
