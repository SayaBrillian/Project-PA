import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:3000',
})

api.interceptors.request.use(
  (config) => {
    const auth = JSON.parse(localStorage.getItem('auth'))

    if (auth?.token) {
      config.headers.Authorization = `Bearer ${auth.token}`
    }

    return config
  },
  (error) => {
    return Promise.reject(error)
  },
)

export default api
