const imageModules = import.meta.glob(
  './games/*.webp',
  {
    eager: true,
    import: 'default'
  }
)

const gameImages = Object.fromEntries(
  Object.entries(imageModules).map(
    ([path, image]) => {
      const slug = path
        .split('/')
        .pop()
        .replace('.webp', '')

      return [slug, image]
    }
  )
)

export default gameImages