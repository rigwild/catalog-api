import Router from 'express-promise-router'
import boom from '@hapi/boom'

import { sql } from '../db.js'

export const router = Router()

router.get('/', async (req, res) => res.json(await sql`SELECT * FROM genre`))

router.post('/', async (req, res) => {
  const { name } = req.body
  const [genre] = await sql`INSERT INTO genre (name) VALUES (${name}) RETURNING *`
  res.status(201).json(genre)
})

router.get('/:genreId', async (req, res) => {
  const { genreId } = req.params
  const [genre] = await sql`SELECT * FROM genre WHERE genre_id = ${genreId}`
  if (!genre) throw boom.notFound('Genre not found')
  res.json(genre)
})

router.put('/:genreId', async (req, res) => {
  const { genreId } = req.params
  const { name } = req.body
  await sql`UPDATE genre SET name = ${name} WHERE genre_id = ${genreId}`
  res.status(204).end()
})
