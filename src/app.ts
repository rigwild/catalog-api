import express from 'express'
import boom from '@hapi/boom'

import { importRouters } from './routes/index.js'

export const app = express()

app.use(express.json({ limit: '50mb' }))

importRouters(app)

// @ts-ignore
app.use((err, req, res, next) => {
  // Check whether the error is a boom error
  if (!err.isBoom) {
    // Check if error is invalid JSON body
    if (err instanceof SyntaxError && err.hasOwnProperty('body')) err = boom.badRequest(err.message)
    else if (err.name === 'UnauthorizedError') err = boom.unauthorized(err)
    // The error was not recognized, send a 500 HTTP error
    else err = boom.internal(err)
  }

  const {
    output: { payload }
  } = err

  // Pass the error to the logging handler
  let errorLogged = new Error(`Error ${payload.statusCode} - ${payload.error} - Message :\n${payload.message}`)
  errorLogged.stack = err.stack
  console.error(errorLogged)

  // Send the error to the client
  res.status(payload.statusCode).json({
    message: err.message || payload.message,
    data: err.data || undefined
  })

  next()
})
