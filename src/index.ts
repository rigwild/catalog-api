import { app } from './app.js'

const SERVER_PORT = process.env.SERVER_PORT || 5000

app.listen(SERVER_PORT, () => console.log(`Server listening on http://localhost:${SERVER_PORT}`))
