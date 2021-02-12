import type { Express } from 'express'

import { router as usersRouter } from './users.js'

export const importRouters = (app: Express) => {
  app.use('/users', usersRouter)
}
