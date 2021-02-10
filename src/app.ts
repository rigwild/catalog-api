import express from 'express'
import * as bodyParser from 'body-parser'

import { importRouters } from './routes'

export const app = express()

app.use(
  bodyParser.json({
    limit: '50mb',
    verify(req: any, res, buf, encoding) {
      req.rawBody = buf
    }
  })
)

importRouters(app)
