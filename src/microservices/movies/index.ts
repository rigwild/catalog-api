import { createAppServer } from '../../app.js'
import { importRouters } from './routes/index.js'

export const app = createAppServer(importRouters)
export const SERVER_PORT = process.env.SERVER_PORT ? parseInt(process.env.SERVER_PORT, 10) : 8882
app.listen(SERVER_PORT, () => console.log(`Server listening on http://localhost:${SERVER_PORT}`))
