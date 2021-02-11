import type { Express } from 'express'

import { router as usersRouter } from './users.js'
import { router as moviesRouter } from './movies.js'
import { router as genresRouter } from './genres.js'
import { router as peopleRouter } from './people.js'

export const importRouters = (app: Express) => {
  app.use('/users', usersRouter)
  app.use('/movies', moviesRouter)
  app.use('/genres', genresRouter)
  app.use('/people', peopleRouter)
}
