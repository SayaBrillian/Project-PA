<template>
  <q-page class="home-page">

    <WelcomeSection />

    <ReasonSection />

    <GameSection title="Most Popular" description="Game yang paling banyak dimainkan oleh pengguna."
      :games="popularGames" :filters="['All Time', 'Month', 'Week', 'Day']" />

    <GameSection title="Latest Update" description="Update dan patch terbaru dari game favoritmu."
      :games="popularGames" />

    <ProductSection title="Produk Terpopuler" description="Produk yang paling banyak dibeli oleh pemain."
      :products="popularProducts" :filters="['All Time', 'Week', 'Month', 'Day']" />

    <TrustStats />

    <PurchaseFlow />

    <TestimonialsSection />

    <FaqSection />

    <CTASection />

  </q-page>
</template>

<script setup>
import WelcomeSection from 'components/main/home/WelcomeSection.vue'
import ReasonSection from 'components/main/home/ReasonSection.vue'
//import CTASection from 'components/main/home/CTASection.vue'

//import TrustStats from 'components/main/home/TrustStats.vue'
//import PurchaseFlow from 'components/main/home/PurchaseFlow.vue'
//import TestimonialsSection from 'components/main/home/TestimonialsSection.vue'
//import FaqSection from 'components/main/home/FaqSection.vue'

//import GameSection from 'components/game/GameSection.vue'
//import ProductSection from 'components/product/ProductSection.vue'

const popularGames = [
  {
    id: 1,
    slug: 'genshin-impact',
    name: 'Genshin Impact',
    isUpdated: true,
  },
  {
    id: 2,
    slug: 'honkai-star-rail',
    name: 'Honkai Star Rail',
    isUpdated: false,
  },
]

const popularProducts = [
  {
    id: 1,
    game: 'Genshin Impact',
    name: 'Blessing of the Welkin Moon',
    price: 79000,
    image: 'src/assets/Welkin.webp',
    badge: 'Best Seller',
  },
  {
    id: 2,
    game: 'Genshin Impact',
    name: '1680 Genesis Crystals',
    price: 349000,
    image: 'src/assets/GenesisCrystal.webp',
    badge: 'Popular',
  },
]
</script>

<style lang="scss" scoped>
.home-page {
  display: flex;
  flex-direction: column;

  gap: 10px;

  padding: 0 0 64px;
}
</style>
