<template>
  <q-page class="product-details-page">
    <!-- GAME SELECTOR -->
    <section class="game-selector-section">
      <div class="section-label">Pilih Game</div>

      <q-select
        v-model="selectedGame"
        :options="games"
        option-label="name"
        option-value="id"
        emit-value
        map-options
        outlined
        dark
        class="game-select"
      >
        <template #prepend>
          <q-icon name="sports_esports" />
        </template>
      </q-select>
    </section>

    <!-- GAME INFO -->
    <section v-if="currentGame" class="game-info-card">
      <div class="game-banner">
        <div class="game-banner-image">
          <img
            :src="gameImages[currentGame.slug]"
            :alt="currentGame.name"
            class="game-banner-image"
          />
        </div>

        <div class="game-banner-content">
          <h2>
            {{ currentGame.name }}
          </h2>

          <div class="publisher">
            {{ currentGame.publisher }}
          </div>

          <p class="game-description">
            {{ currentGame.description }}
          </p>

          <div class="game-meta">
            <div class="meta-item">
              <span class="meta-label"> Versi Terbaru </span>

              <span class="meta-value">
                {{ currentGame.latest_patch }}
              </span>
            </div>

            <div class="meta-item">
              <span class="meta-label"> Update Terakhir </span>

              <span class="meta-value">
                {{ currentGame.latest_update }}
              </span>
            </div>
          </div>

          <div class="game-links">
            <q-btn
              outline
              color="accent"
              icon="description"
              label="Patch Notes"
              :href="currentGame.patchnote_url"
              target="_blank"
              rel="noopener noreferrer"
            />

            <q-btn
              unelevated
              color="accent"
              icon="public"
              label="Official Website"
              :href="currentGame.official_url"
              target="_blank"
              rel="noopener noreferrer"
            />
          </div>
        </div>
      </div>
    </section>
    <!-- PRODUCT SECTION -->
    <section class="product-section">
      <div class="section-header">
        <h2>Pilih Produk</h2>

        <p>Pilih nominal atau paket yang ingin dibeli.</p>
      </div>

      <div class="product-grid">
        <div
          v-for="product in products"
          :key="product.id"
          class="product-card"
          :class="{
            selected: selectedProduct?.id === product.id,
          }"
          @click="selectedProduct = product"
        >
          <div class="product-name">
            {{ product.name }}
          </div>

          <div class="product-price">Rp {{ Number(product.price).toLocaleString('id-ID') }}</div>
        </div>
      </div>
    </section>
    <!-- CHECKOUT SECTION -->
    <section class="checkout-section">
      <!-- LEFT -->
      <div class="checkout-left">
        <div class="checkout-card">
          <div class="section-header">
            <div>
              <div class="section-title">Data Akun</div>

              <div class="section-subtitle">Tambahkan satu atau lebih akun tujuan top up.</div>
            </div>

            <q-btn flat round icon="restart_alt" color="grey-5" @click="clearForm">
              <q-tooltip> Kosongkan Form </q-tooltip>
            </q-btn>
          </div>

          <div class="account-form">
            <q-input v-model="gameUid" outlined dark label="UID" class="form-field" />

            <q-select
              v-model="gameServer"
              :options="servers"
              option-label="server_name"
              option-value="server_name"
              emit-value
              map-options
              outlined
              dark
              label="Server"
              class="form-field"
            />

            <q-btn
              unelevated
              color="accent"
              icon="add"
              label="Tambah Akun"
              class="add-account-btn"
              @click="addTarget"
            />
          </div>

          <div class="account-list">
            <div class="account-list-title">Daftar Akun</div>

            <div v-if="targets.length === 0" class="account-empty">
              Belum ada akun yang ditambahkan.
            </div>

            <div v-else class="account-list-grid">
              <div v-for="(target, index) in targets" :key="index" class="account-item">
                <div class="account-uid">UID: {{ target.game_uid }}</div>

                <div class="account-footer">
                  <div class="account-server">
                    {{ target.game_server }}
                  </div>

                  <q-btn
                    flat
                    round
                    dense
                    icon="delete"
                    color="negative"
                    @click="removeTarget(index)"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- RIGHT -->
      <div class="checkout-right">
        <div class="checkout-card">
          <div class="section-title">Informasi Kontak</div>

          <div class="section-subtitle">Digunakan untuk konfirmasi dan status pesanan.</div>

          <div class="account-form">
            <q-input
              v-model="customerEmail"
              outlined
              dark
              type="email"
              label="Email"
              class="form-field"
            />

            <q-input v-model="customerWhatsapp" outlined dark label="WhatsApp" class="form-field" />
          </div>
        </div>

        <div class="checkout-card">
          <div class="section-title">Ringkasan Pesanan</div>

          <div class="summary-list">
            <div class="summary-item">
              <span class="summary-label"> Produk </span>

              <span class="summary-value">
                {{ selectedProduct?.name || 'Belum dipilih' }}
              </span>
            </div>

            <div class="summary-item">
              <span class="summary-label"> Total Akun </span>

              <span class="summary-value">
                {{ targets.length }}
              </span>
            </div>

            <div class="summary-item">
              <span class="summary-label"> Harga Satuan </span>

              <span class="summary-value">
                Rp
                {{ selectedProduct ? Number(selectedProduct.price).toLocaleString('id-ID') : 0 }}
              </span>
            </div>
          </div>

          <div class="summary-total">
            <div class="summary-total-label">Total Pembayaran</div>

            <div class="summary-total-price">
              Rp
              {{ totalPrice.toLocaleString('id-ID') }}
            </div>
          </div>

          <q-btn
  unelevated
  color="accent"
  size="lg"
  class="checkout-btn"
  label="Bayar Sekarang"
  @click="checkout"
/>
        </div>
      </div>
    </section>
  </q-page>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from 'src/axios'
import gameImages from 'src/assets/images'

const route = useRoute()
const router = useRouter()

const games = ref([])
const selectedGame = ref(null)
const products = ref([])
const selectedProduct = ref(null)
const gameUid = ref('')
const gameServer = ref(null)
const servers = ref([])
const targets = ref([])
const customerEmail = ref('')
const customerWhatsapp = ref('')

const loadGames = async () => {
  try {
    const response = await api.get('/api/games')

    games.value = response.data.games

    const gameFromUrl = games.value.find(
      (game) => game.slug === route.params.slug
    )

    if (gameFromUrl) {
      selectedGame.value = gameFromUrl.id
    } else if (games.value.length > 0) {
      selectedGame.value = games.value[0].id
    }
  } catch (error) {
    console.error('Load Games Error:', error)
  }
}

const loadProducts = async (gameId) => {
  try {
    const response = await api.get(`/api/products/game/${gameId}`)

    products.value = response.data.products

    selectedProduct.value = null
  } catch (error) {
    console.error('Load Products Error:', error)
  }
}

const currentGame = computed(() => {
  return games.value.find((game) => game.id === selectedGame.value)
})

const loadServers = async (gameId) => {
  try {
    const response = await api.get(`/api/games/${gameId}/servers`)

    servers.value = response.data.servers

    gameServer.value = null
  } catch (error) {
    console.error('Load Servers Error:', error)
  }
}

const addTarget = () => {
  if (!gameUid.value) return

  if (!gameServer.value) return

  targets.value.push({
    game_uid: gameUid.value,
    game_server: gameServer.value,
  })

  gameUid.value = ''
  gameServer.value = null
}

const clearForm = () => {
  gameUid.value = ''
  gameServer.value = null
}

const removeTarget = (index) => {
  targets.value.splice(index, 1)
}

const totalPrice = computed(() => {
  if (!selectedProduct.value) return 0

  return Number(selectedProduct.value.price) * targets.value.length
})

const checkout = async () => {
  try {

    const response =
      await api.post(
        '/api/transactions',
        {
          user_id: null,

          product_id:
            selectedProduct.value.id,

          quantity:
            targets.value.length,

          total_price:
            totalPrice.value,

          customer_email:
            customerEmail.value,

          customer_whatsapp:
            customerWhatsapp.value,

          notes: null,

          targets:
            targets.value,
        }
      )
const orderId =
  response.data.transaction.order_id

const paymentResponse =
  await api.post(
    '/api/payments/create',
    {
      order_id: orderId
    }
  )

window.snap.pay(
  paymentResponse.data.token,
  {
    onSuccess(result) {
      console.log(
        'SUCCESS',
        result
      )
    },

    onPending(result) {
      console.log(
        'PENDING',
        result
      )
    },

    onError(result) {
      console.log(
        'ERROR',
        result
      )
    },

    onClose() {
      console.log(
        'User closed popup'
      )
    }
  }
)
    console.log(
      'Transaction Created:',
      response.data
    )

  } catch (error) {

    console.error(
      'Checkout Error:',
      error
    )

  }
}

watch(selectedGame, (gameId) => {
  if (!gameId) return

  const selectedGameData =
    games.value.find(
      (game) => game.id === gameId
    )

  if (selectedGameData) {

    router.replace(
      `/products/${selectedGameData.slug}`
    )

  }

  loadProducts(gameId)

  loadServers(gameId)
})

onMounted(() => {
  loadGames()
})
</script>

<style lang="scss" scoped>
.product-details-page {
  max-width: 1280px;
  margin: 0 auto;
}

.game-selector-section {
  margin-bottom: 24px;
}

.section-label {
  margin-bottom: 10px;

  font-size: 0.9rem;
  font-weight: 600;

  color: rgba(255, 255, 255, 0.7);
}

.game-select {
  max-width: 420px;
}

.game-info-card {
  padding: 32px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 24px;
}

.game-header {
  margin-bottom: 12px;
}

.game-header h1 {
  margin: 0;

  font-size: 2rem;
  font-weight: 700;
}

.game-banner {
  display: flex;
  gap: 32px;
}

.game-banner-image {
  width: 240px;
  flex-shrink: 0;
}

.game-banner-image img {
  width: 100%;
  display: block;

  border-radius: 20px;
  object-fit: cover;
}

.game-banner-content {
  flex: 1;
}

.game-banner-content h2 {
  margin-top: 0;
  margin-bottom: 8px;
  color: $sakura;
}

.publisher {
  margin-bottom: 20px;

  color: rgba(255, 255, 255, 0.65);
}

.game-meta {
  display: flex;
  gap: 32px;

  margin: 24px 0;
}

.meta-item {
  display: flex;
  flex-direction: column;
}

.meta-label {
  font-size: 0.8rem;
  color: rgba(255, 255, 255, 0.5);
}

.meta-value {
  margin-top: 4px;
  color: rgba(255, 255, 255, 0.9);
  font-weight: 600;
}

.game-links {
  display: flex;
  gap: 12px;

  margin-top: 28px;
}

.product-section {
  margin-top: 48px;
}

.section-header {
  margin-bottom: 24px;
}

.section-header h2 {
  margin: 0 0 8px;

  color: rgba(255, 255, 255, 0.92);

  font-size: 2rem;
  font-weight: 700;
}

.section-header p {
  margin: 0;

  color: rgba(255, 255, 255, 0.65);

  font-size: 0.95rem;
}

.product-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));

  gap: 16px;
}

.product-card {
  padding: 18px;

  cursor: pointer;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);

  border-radius: 16px;

  transition: all 0.2s ease;
}

.product-card:hover {
  border-color: rgba($sakura, 0.3);

  transform: translateY(-2px);
}

.product-card.selected {
  border-color: $sakura;

  background: rgba($sakura, 0.08);
}

.product-name {
  color: rgba(255, 255, 255, 0.92);

  font-weight: 600;
}

.product-price {
  margin-top: 8px;

  color: $sakura;

  font-weight: 700;
}

.checkout-section {
  display: grid;

  grid-template-columns: 1fr 360px;

  gap: 12px;

  margin-top: 48px;
}

.checkout-left {
  min-width: 0;
}

.checkout-right {
  display: flex;

  flex-direction: column;

  gap: 24px;
}

.checkout-card {
  padding: 24px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);
  border-radius: 20px;
}
.section-header {
  display: flex;

  justify-content: space-between;

  align-items: flex-start;

  margin-bottom: 12px;
}
.section-title {
  margin-bottom: 1280pxpx;

  color: rgba(255, 255, 255, 0.95);

  font-size: 1.1rem;
  font-weight: 700;
}
.section-subtitle {
  margin-bottom: 24px;

  color: rgba(255, 255, 255, 0.72);
  font-size: 0.9rem;
}

.account-form {
  display: flex;
  flex-direction: column;

  gap: 16px;
}

.form-field {
  width: 100%;
}

.add-account-btn {
  align-self: flex-start;
}
.account-list {
  margin-top: 32px;

  padding-top: 24px;

  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.account-list-title {
  margin-bottom: 16px;

  color: rgba(255, 255, 255, 0.92);

  font-weight: 700;
}

.account-list-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));

  gap: 12px;
}

.account-item {
  padding: 14px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);

  border-radius: 14px;
}

.account-uid {
  color: rgba(255, 255, 255, 0.92);

  font-weight: 600;
}

.account-footer {
  display: flex;

  justify-content: space-between;

  align-items: center;

  margin-top: 10px;
}

.account-server {
  color: rgba(255, 255, 255, 0.65);

  font-size: 0.9rem;
}

.account-empty {
  color: rgba(255, 255, 255, 0.5);
}

.account-list-grid {
  display: grid;

  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));

  gap: 12px;

  margin-top: 16px;
}

.account-item {
  padding: 16px;

  background: rgba(255, 255, 255, 0.03);

  border: 1px solid rgba($sakura, 0.12);

  border-radius: 14px;
}

.account-uid {
  color: rgba(255, 255, 255, 0.92);

  font-weight: 700;
}

.account-footer {
  display: flex;

  justify-content: space-between;

  align-items: center;

  margin-top: 10px;
}

.account-server {
  color: rgba(255, 255, 255, 0.65);

  font-size: 0.9rem;
}
.contact-form {
  display: flex;

  flex-direction: column;

  gap: 16px;
}

.summary-list {
  display: flex;

  flex-direction: column;

  gap: 16px;
}

.summary-item {
  display: flex;

  justify-content: space-between;

  align-items: center;
}

.summary-label {
  color: rgba(255, 255, 255, 0.65);
}

.summary-value {
  color: rgba(255, 255, 255, 0.92);

  font-weight: 600;
}

.summary-total {
  margin-top: 24px;

  padding-top: 24px;

  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.summary-total-label {
  color: rgba(255, 255, 255, 0.65);
}

.summary-total-price {
  margin-top: 8px;

  color: $sakura;

  font-size: 1.6rem;
  font-weight: 700;
}

.checkout-btn {
  width: 100%;

  margin-top: 24px;
}
@media (max-width: 768px) {
  .game-meta {
    flex-direction: column;
    gap: 12px;
  }

  .game-links {
    flex-direction: column;
  }
  .checkout-section {
    grid-template-columns: 1fr;
  }
}
</style>
