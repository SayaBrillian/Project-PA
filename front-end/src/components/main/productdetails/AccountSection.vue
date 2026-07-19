<template>

  <section class="account-section">

    <!-- HEADER -->
    <div class="section-header">

      <div>

        <h2>
          Tambahkan Akun
        </h2>

        <p>
          Tambahkan satu atau lebih akun tujuan top up.
        </p>

      </div>

      <q-btn flat round icon="restart_alt" class="reset-btn" @click="
        emit('clear-form')
        ">

        <q-tooltip>

          Kosongkan Form

        </q-tooltip>

      </q-btn>

    </div>

    <!-- FORM -->
    <div class="account-form">

      <q-input v-model="gameUid" outlined label="UID" class="form-field" />

      <q-select v-model="gameServer" :options="servers" option-label="server_name" option-value="server_name" emit-value
        map-options outlined label="Server" class="form-field" />

      <q-btn unelevated color="primary" icon="add" label="Tambah Akun" no-caps class="add-account-btn" @click="
        emit('add-target')
        " />

    </div>

    <!-- LIST -->
    <div class="account-list">

      <div class="account-list-title">

        Daftar Akun

      </div>

      <div v-if="
        targets.length === 0
      " class="account-empty">

        Belum ada akun yang ditambahkan.

      </div>

      <div v-else class="account-grid">

        <div v-for="
(target, index)
  in targets
          " :key="index" class="account-card">

          <div class="account-info">

            <div class="account-item">

              <span class="account-label">

                UID

              </span>

              <span class="account-value">

                {{ target.game_uid }}

              </span>

            </div>

            <div class="account-item">

              <span class="account-label">

                Server

              </span>

              <span class="account-value">

                {{ target.game_server }}

              </span>

            </div>

          </div>

          <q-btn flat round dense icon="delete" color="negative" @click="
            emit(
              'remove-target',
              index
            )
            " />

        </div>

      </div>

    </div>

  </section>

</template>

<script setup>
import { computed } from 'vue'

/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props = defineProps({

  servers: {
    type: Array,
    default: () => [],
  },

  gameUid: {
    type: String,
    default: '',
  },

  gameServer: {
    type: String,
    default: null,
  },

  targets: {
    type: Array,
    default: () => [],
  },

})

/*
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

const emit = defineEmits([
  'update:gameUid',
  'update:gameServer',
  'add-target',
  'remove-target',
  'clear-form',
])

/*
|--------------------------------------------------------------------------
| V-MODEL
|--------------------------------------------------------------------------
*/

const gameUid = computed({

  get: () => props.gameUid,

  set: value =>

    emit(
      'update:gameUid',
      value,
    ),

})

const gameServer = computed({

  get: () => props.gameServer,

  set: value =>

    emit(
      'update:gameServer',
      value,
    ),

})
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| HEADER
|--------------------------------------------------------------------------
*/

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;

  gap: 16px;

  margin-bottom: 28px;
}

.section-header>div {
  display: flex;
  flex-direction: column;

  gap: 10px;
}

.section-header h2 {
  margin: 0;

  color: var(--app-text);

  font-size: clamp(1.8rem, 4vw, 2.3rem);
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: var(--app-text-secondary);

  line-height: 1.7;
}

.reset-btn {
  color: var(--app-text-secondary);

  transition:
    color .2s ease,
    background-color .2s ease;
}

.reset-btn:hover {
  background: var(--app-hover);

  color: var(--app-primary);
}

/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

.account-form {
  display: flex;
  flex-direction: column;

  gap: 16px;
}

.form-field {
  width: 100%;
}

.form-field :deep(.q-field__control) {
  border-radius: 16px;
}

.add-account-btn {
  align-self: flex-start;

  border-radius: 14px;
}

/*
|--------------------------------------------------------------------------
| LIST
|--------------------------------------------------------------------------
*/

.account-list {
  margin-top: 36px;

  padding-top: 28px;

  border-top: 1px solid var(--app-border);
}

.account-list-title {
  margin-bottom: 18px;

  color: var(--app-text);

  font-size: 1rem;
  font-weight: 700;
}

.account-empty {
  padding: 32px 20px;

  text-align: center;

  color: var(--app-text-secondary);

  background: var(--app-surface);

  border: 1px dashed var(--app-border);
  border-radius: 18px;
}

/*
|--------------------------------------------------------------------------
| GRID
|--------------------------------------------------------------------------
*/

.account-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill,
      minmax(240px, 1fr));

  gap: 16px;
}

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.account-card {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;

  gap: 20px;

  padding: 18px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 18px;

  transition:
    background-color .2s ease,
    border-color .2s ease,
    transform .2s ease;
}

.account-card:hover {
  transform: translateY(-2px);

  background: var(--app-hover);

  border-color: var(--app-primary);
}

.account-info {
  flex: 1;

  display: flex;
  flex-direction: column;

  gap: 16px;
}

.account-item {
  display: flex;
  flex-direction: column;

  gap: 4px;
}

.account-label {
  color: var(--app-text-secondary);

  font-size: .8rem;
}

.account-value {
  color: var(--app-text);

  font-size: .95rem;
  font-weight: 700;

  word-break: break-word;
}

/*
|--------------------------------------------------------------------------
| DELETE BUTTON
|--------------------------------------------------------------------------
*/

.account-card :deep(.q-btn) {
  flex-shrink: 0;

  margin-top: -4px;
}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 600px) {

  .account-section {
    padding-inline: 16px;
  }

  .section-header {
    flex-direction: column;
  }

  .reset-btn {
    align-self: flex-end;
  }

  .section-header h2 {
    font-size: 1.6rem;
  }

  .section-header p {
    font-size: .9rem;
  }

  .add-account-btn {
    width: 100%;
  }

  .account-grid {
    grid-template-columns: 1fr;
  }

}
</style>
