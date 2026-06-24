const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        component: () => import('pages/public/HomePage.vue'),
      },
      {
        path: 'product',
        component: () => import('pages/public/ProductPage.vue'),
      },
      {
  path: '/check-transaction',
  component: () =>
    import(
      'pages/public/CheckTransactionPage.vue'
    ),
},
      {
        path: 'help',
        component: () => import('pages/public/HelpPage.vue'),
      },
      {
        path: 'about',
        component: () => import('pages/public/AboutPage.vue'),
      },
      {
        path: 'products/:slug',
        component: () => import('pages/public/ProductDetailsPage.vue'),
      },
    ],
  },

  {
  path: '/dashboard',
  component: () => import('layouts/DashboardLayout.vue'),
  meta: {
    requiresAuth: true,
  },
  children: [
    {
      path: '',
      component: () => import('pages/dashboard/DashboardPage.vue'),
    },
    {
      path: 'games',
      component: () => import('pages/dashboard/GamesPage.vue'),
    },
    {
      path: 'products',
      component: () => import('pages/dashboard/ProductsPage.vue'),
    },
    {
      path: 'transactions',
      component: () => import('pages/dashboard/TransactionsPage.vue'),
    },
    {
      path: 'profile',
      component: () => import('pages/dashboard/ProfilePage.vue'),
    },
    {
      path: 'settings',
      component: () => import('pages/dashboard/SettingsPage.vue'),
    },
  ],
},
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
]

export default routes
