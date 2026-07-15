import axios from 'axios'

const api = axios.create({

  baseURL: 'http://localhost:3000',

})

/*
|--------------------------------------------------------------------------
| REQUEST
|--------------------------------------------------------------------------
*/

api.interceptors.request.use(

  (config) => {

    const auth =
      JSON.parse(
        localStorage.getItem('auth')
      )

    if (auth?.token) {

      config.headers.Authorization =
        `Bearer ${auth.token}`

    }

    return config

  },

  (error) => {

    return Promise.reject(error)

  },

)

/*
|--------------------------------------------------------------------------
| RESPONSE
|--------------------------------------------------------------------------
*/

api.interceptors.response.use(

  (response) => {

    return response

  },

  (error) => {

    if (error.response?.status === 401) {

      localStorage.removeItem('auth')

      window.location.replace('/')

    }

    return Promise.reject(error)

  },

)

export default api
