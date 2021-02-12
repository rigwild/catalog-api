import Router from 'express-promise-router'
import type { Express } from 'express'

import { createAppServer } from '../../app.js'

// Redis KV
const stats = {
  rentCount: 0,
  rentCountPerMovie: {} as Record<string, number>
}

export const router = Router()

router.get('/', async (req, res) => res.json(stats))

router.post('/singleStats/:statName/increment', async (req, res) => {
  const { statName } = req.params
  const name = statName as keyof Omit<typeof stats, 'rentCountPerMovie'>
  stats[name] = (stats[name] || 0) + 1
  res.status(201).json(stats.rentCount)
})

router.post('/rentCountPerMovie/:movieId/increment', async (req, res) => {
  const { movieId } = req.params
  stats.rentCountPerMovie[movieId] = (stats.rentCountPerMovie[movieId] || 0) + 1
  res.status(201).json(stats.rentCountPerMovie[movieId])
})

export const importRouters = (app: Express) => {
  app.use('/stats', router)
}

export const app = createAppServer(importRouters)
export const SERVER_PORT = process.env.SERVER_PORT ? parseInt(process.env.SERVER_PORT, 10) : 8883
app.listen(SERVER_PORT, () => console.log(`Server listening on http://localhost:${SERVER_PORT}`))
