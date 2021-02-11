import type { Express } from 'express'

import { router as usersRouter } from './users.js'
import { router as moviesRouter } from './movies.js'

export const importRouters = (app: Express) => {
  app.use('/users', usersRouter)
  app.use('/movies', moviesRouter)
}
