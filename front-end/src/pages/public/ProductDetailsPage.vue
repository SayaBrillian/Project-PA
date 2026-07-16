<template>

  <q-page class="product-details-page">

    <!-- GAME -->
    <GameSection :games="games" :current-game="currentGame" :game-images="gameImages"
      v-model:selected-game="selectedGame" />

    <!-- PRODUCT -->
    <ProductSection :products="products" v-model:selected-product="selectedProduct" />

    <!-- CHECKOUT -->
    <section class="checkout-section">

      <!-- LEFT -->
      <div class="checkout-left">

        <AccountSection :servers="servers" :targets="targets" v-model:game-uid="gameUid"
          v-model:game-server="gameServer" @add-target="addTarget" @remove-target="removeTarget"
          @clear-form="clearForm" />

      </div>

      <!-- RIGHT -->
      <div class="checkout-right">

        <div class="checkout-card">

          <ContactSection v-model:customer-email="customerEmail" v-model:customer-whatsapp="customerWhatsapp"
            :is-email-valid="isEmailValid" :is-whatsapp-valid="isWhatsappValid" />

        </div>

        <div class="checkout-card">

          <SummarySection :selected-product="selectedProduct" :targets="targets" :total-price="totalPrice"
            :can-checkout="canCheckout" @checkout="
              showConfirmation = true
              " />

        </div>

      </div>

    </section>

    <!-- ORDER CONFIRMATION -->

    <CheckoutConfirmationDialog v-model="showConfirmation" :order="confirmationOrder" @confirm="processCheckout" />

    <!-- SNAP -->

    <SnapContainer v-model="showSnap" :snap-token="snapToken" />

  </q-page>

</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'

import api from 'src/axios'
import gameImages from 'src/assets/images'

import GameSection from 'components/main/productdetails/GameSection.vue'
import ProductSection from 'components/main/productdetails/ProductSection.vue'
import AccountSection from 'components/main/productdetails/AccountSection.vue'
import ContactSection from 'components/main/productdetails/ContactSection.vue'
import SummarySection from 'components/main/productdetails/SummarySection.vue'

import CheckoutConfirmationDialog from 'components/main/productdetails/CheckoutConfirmationDialog.vue'
import SnapContainer from 'components/SnapContainer.vue'

/*
|--------------------------------------------------------------------------
| ROUTER
|--------------------------------------------------------------------------
*/

const route = useRoute()
const router = useRouter()

/*
|--------------------------------------------------------------------------
| DIALOG
|--------------------------------------------------------------------------
*/

const showConfirmation = ref(false)
const showSnap = ref(false)
const snapToken = ref('')

/*
|--------------------------------------------------------------------------
| GAME
|--------------------------------------------------------------------------
*/

const games = ref([])
const selectedGame = ref(null)

const products = ref([])
const selectedProduct = ref(null)

const servers = ref([])

/*
|--------------------------------------------------------------------------
| ACCOUNT
|--------------------------------------------------------------------------
*/

const gameUid = ref('')
const gameServer = ref(null)

const targets = ref([])

/*
|--------------------------------------------------------------------------
| CONTACT
|--------------------------------------------------------------------------
*/

const customerEmail = ref('')
const customerWhatsapp = ref('')

/*
|--------------------------------------------------------------------------
| COMPUTED
|--------------------------------------------------------------------------
*/

const currentGame = computed(() => {

  return games.value.find(

    game => game.id === selectedGame.value

  )

})

const isEmailValid = computed(() => {

  if (!customerEmail.value.trim()) {

    return true

  }

  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    .test(customerEmail.value.trim())

})

const isWhatsappValid = computed(() => {

  if (!customerWhatsapp.value.trim()) {

    return true

  }

  return customerWhatsapp.value
    .trim()
    .length >= 10

})

const hasContact = computed(() => {

  return (

    customerEmail.value.trim() ||

    customerWhatsapp.value.trim()

  )

})

const totalPrice = computed(() => {

  if (!selectedProduct.value) {

    return 0

  }

  return (

    Number(selectedProduct.value.price) *

    targets.value.length

  )

})

const confirmationOrder = computed(() => ({

  gameName:
    currentGame.value?.name || '',

  productName:
    selectedProduct.value?.name || '',

  quantity:
    targets.value.length,

  totalPrice:
    totalPrice.value,

  customerEmail:
    customerEmail.value,

  customerWhatsapp:
    customerWhatsapp.value,

  targets:
    targets.value,

}))

const canCheckout = computed(() => {

  return (

    selectedProduct.value &&

    targets.value.length > 0 &&

    hasContact.value &&

    isEmailValid.value &&

    isWhatsappValid.value

  )

})

/*
|--------------------------------------------------------------------------
| API
|--------------------------------------------------------------------------
*/

async function loadGames() {

  try {

    const response =
      await api.get('/api/games')

    games.value =
      response.data.games

    const gameFromUrl =
      games.value.find(

        game =>
          game.slug === route.params.slug

      )

    if (gameFromUrl) {

      selectedGame.value =
        gameFromUrl.id

    } else if (games.value.length > 0) {

      selectedGame.value =
        games.value[0].id

    }

  } catch (error) {

    console.error(
      'Load Games Error:',
      error
    )

  }

}

async function loadProducts(gameId) {

  try {

    const response =
      await api.get(
        `/api/products/game/${gameId}`
      )

    products.value =
      response.data.products

    selectedProduct.value =
      null

  } catch (error) {

    console.error(
      'Load Products Error:',
      error
    )

  }

}

async function loadServers(gameId) {

  try {

    const response =
      await api.get(
        `/api/games/${gameId}/servers`
      )

    servers.value =
      response.data.servers

    gameServer.value =
      null

  } catch (error) {

    console.error(
      'Load Servers Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| ACTION
|--------------------------------------------------------------------------
*/

function addTarget() {

  if (!gameUid.value) {

    return

  }

  if (!gameServer.value) {

    return

  }

  targets.value.push({

    game_uid:
      gameUid.value,

    game_server:
      gameServer.value,

  })

  clearForm()

}

function clearForm() {

  gameUid.value = ''

  gameServer.value = null

}

function removeTarget(index) {

  targets.value.splice(index, 1)

}

/*
|--------------------------------------------------------------------------
| CHECKOUT
|--------------------------------------------------------------------------
*/

async function processCheckout() {

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

          order_id:
            orderId,

        }

      )

    /*
    |--------------------------------------------------------------------------
    | TEMP SNAP
    |--------------------------------------------------------------------------
    */

    snapToken.value = paymentResponse.data.token

    showSnap.value = true

  } catch (error) {

    console.error(
      'Checkout Error:',
      error
    )

  }

}

/*
|--------------------------------------------------------------------------
| WATCH
|--------------------------------------------------------------------------
*/

watch(

  selectedGame,

  gameId => {

    if (!gameId) {

      return

    }

    const selectedGameData =
      games.value.find(

        game =>
          game.id === gameId

      )

    if (selectedGameData) {

      router.replace(

        `/products/${selectedGameData.slug}`

      )

    }

    loadProducts(gameId)

    loadServers(gameId)

  }

)

/*
|--------------------------------------------------------------------------
| LIFECYCLE
|--------------------------------------------------------------------------
*/

onMounted(() => {

  loadGames()

  const auth = JSON.parse(

    localStorage.getItem('auth')

  )

  if (auth?.type === 'user') {

    customerEmail.value =
      auth.data.email || ''

  }

})
</script>

<style scoped lang="scss">
/*
|--------------------------------------------------------------------------
| PAGE
|--------------------------------------------------------------------------
*/

.product-details-page {
  max-width: 1280px;

  margin: 0 auto;
}

/*
|--------------------------------------------------------------------------
| CHECKOUT
|--------------------------------------------------------------------------
*/

.checkout-section {
  display: grid;

  grid-template-columns: minmax(0, 1fr) 360px;

  gap: 24px;

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

/*
|--------------------------------------------------------------------------
| CARD
|--------------------------------------------------------------------------
*/

.checkout-card {
  padding: 28px;

  background: var(--app-surface);

  border: 1px solid var(--app-border);
  border-radius: 24px;
}

/*
|--------------------------------------------------------------------------
| TABLET
|--------------------------------------------------------------------------
*/

@media (max-width: 1024px) {

  .checkout-section {
    grid-template-columns: 1fr 340px;
  }

}

/*
|--------------------------------------------------------------------------
| MOBILE
|--------------------------------------------------------------------------
*/

@media (max-width: 768px) {

  .checkout-section {
    grid-template-columns: 1fr;

    gap: 32px;
  }

  .checkout-card {
    padding: 24px;
  }

}

@media (max-width: 600px) {

  .product-details-page {
    padding: 0;
  }

  .checkout-section {
    gap: 24px;

    margin-top: 40px;
  }

  .checkout-right {
    gap: 20px;
  }

  .checkout-card {
    padding: 20px;

    border-radius: 20px;
  }

}
</style>
