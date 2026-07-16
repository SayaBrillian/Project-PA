<template>

  <q-dialog v-model="modelValue" :position="$q.screen.lt.md ? 'bottom' : 'standard'" persistent>

    <q-card :class="[
      $q.screen.lt.md
        ? 'snap-card-mobile'
        : 'snap-card',
    ]">

      <!-- DRAG HANDLE -->
      <div v-if="$q.screen.lt.md" class="sheet-handle" />

      <!-- HEADER -->
      <q-card-section class="snap-header">

        <div class="snap-header-top">

          <div v-if="$q.screen.lt.md" class="header-placeholder" />

          <div class="snap-title-group">

            <div class="snap-title">

              Pembayaran

            </div>

            <div class="snap-subtitle">

              Selesaikan pembayaran untuk melanjutkan pesanan.

            </div>

          </div>

          <q-btn flat round dense icon="close" class="header-btn" @click="closeDialog" />
        </div>

      </q-card-section>

      <!-- BODY -->

      <div class="snap-body">

        <div id="snap-container" class="snap-container" />

      </div>

    </q-card>

  </q-dialog>

</template>

<script setup>
import {
  computed,
  watch,
} from 'vue'

import { useQuasar } from 'quasar'

const $q = useQuasar()

/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props =
  defineProps({

    modelValue:
      Boolean,

    snapToken: {

      type:
        String,

      default:
        '',

    },

  })

const emit =
  defineEmits([
    'update:modelValue',
    'close',
    'success',
    'pending',
    'error',
  ])

/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

const modelValue =
  computed({

    get:
      () => props.modelValue,

    set:
      value =>
        emit(
          'update:modelValue',
          value,
        ),

  })
let snapLoaded = false
/*
|--------------------------------------------------------------------------
| SNAP
|--------------------------------------------------------------------------
*/

watch(

  () =>
    props.snapToken,

  token => {

    if (

      modelValue.value &&
      token

    ) {

      initSnap()

    }

  },

)

watch(

  () =>
    modelValue.value,

  value => {

    if (

      value &&
      props.snapToken

    ) {

      initSnap()

    }

  },

)

/*
|--------------------------------------------------------------------------
| MIDTRANS
|--------------------------------------------------------------------------
*/

function initSnap() {

  if (snapLoaded) {

    return

  }

  if (!window.snap) {

    console.error(
      'Midtrans Snap belum dimuat.'
    )

    return

  }

  snapLoaded = true

  window.snap.embed(

    props.snapToken,

    {

      embedId: 'snap-container',

      onSuccess(result) {

        emit(
          'success',
          result,
        )

        closeDialog()

      },

      onPending(result) {

        emit(
          'pending',
          result,
        )

      },

      onError(result) {

        emit(
          'error',
          result,
        )

      },

      onClose() {

        emit(
          'close',
        )

        closeDialog()

      },

    },

  )

}

/*
|--------------------------------------------------------------------------
| CLOSE
|--------------------------------------------------------------------------
*/

function closeDialog() {

  snapLoaded = false

  modelValue.value = false

  emit('close')

}

watch(

  () => props.snapToken,

  () => {

    snapLoaded = false

    const container =
      document.getElementById(
        'snap-container'
      )

    if (container) {

      container.innerHTML = ''

    }

  },

)
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

:deep(.q-dialog__inner--bottom) {
  padding: 0;
}

/*
|--------------------------------------------------------------------------
| DESKTOP CARD
|--------------------------------------------------------------------------
*/

.snap-card {
  width: min(960px, 95vw);

  height: 85vh;

  display: flex;
  flex-direction: column;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border: 1px solid var(--app-border);
  border-radius: 24px;

  box-shadow: 0 20px 48px var(--app-shadow);
}

/*
|--------------------------------------------------------------------------
| MOBILE CARD
|--------------------------------------------------------------------------
*/

.snap-card-mobile {
  width: 100%;

  height: 90vh;

  display: flex;
  flex-direction: column;

  overflow: hidden;

  background: var(--app-surface);
  color: var(--app-text);

  border-radius: 24px 24px 0 0;
}

/*
|--------------------------------------------------------------------------
| HANDLE
|--------------------------------------------------------------------------
*/

.sheet-handle {
  width: 48px;
  height: 5px;

  margin: 12px auto 4px;

  border-radius: 999px;

  background: var(--app-border);

  flex-shrink: 0;
}

/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.snap-header {
  flex-shrink: 0;

  padding: 20px 24px 18px;

  border-bottom: 1px solid var(--app-border);
}

.snap-header-top {
  display: grid;

  grid-template-columns: 40px 1fr 40px;

  align-items: center;
}

.header-placeholder {
  width: 40px;
  height: 40px;
}

.snap-title-group {
  text-align: center;
}

.snap-title {
  color: var(--app-text);

  font-size: 1.3rem;
  font-weight: 700;
}

.snap-subtitle {
  margin-top: 6px;

  color: var(--app-text-secondary);

  font-size: .88rem;

  line-height: 1.6;
}

.header-btn {
  justify-self: end;

  color: var(--app-text-secondary);

  transition:
    color .2s ease,
    background-color .2s ease;
}

.header-btn:hover {
  color: var(--app-primary);

  background: var(--app-hover);
}

/*
|--------------------------------------------------------------------------
| BODY
|--------------------------------------------------------------------------
*/

.snap-body {
  flex: 1;

  overflow: hidden;

  background: var(--app-bg);
}

/*
|--------------------------------------------------------------------------
| SNAP
|--------------------------------------------------------------------------
*/

.snap-container {
  width: 100%;
  height: 100%;

  overflow-y: auto;
}

.snap-container::-webkit-scrollbar {
  width: 6px;
}

.snap-container::-webkit-scrollbar-thumb {
  background: var(--app-border);

  border-radius: 999px;
}

.snap-container {
  scrollbar-width: thin;

  scrollbar-color:
    var(--app-border) transparent;
}

/*
|--------------------------------------------------------------------------
| RESPONSIVE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .snap-header {
    padding: 16px 20px;
  }

  .snap-title {
    font-size: 1.15rem;
  }

  .snap-subtitle {
    font-size: .82rem;
  }

}
</style>
