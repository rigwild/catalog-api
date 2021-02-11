import Router from 'express-promise-router'
import boom from '@hapi/boom'

import { sql } from '../db.js'

export const router = Router()

router.get('/', async (req, res) => res.json(await sql`SELECT * FROM account`))

router.post('/', async (req, res) => {
  const { name, email, age } = req.body
  const [account] = await sql`INSERT INTO account (name, email, age) VALUES (${name},${email},${age}) RETURNING *`
  res.status(201).json(account)
})

router.get('/:accountId', async (req, res) => {
  const { accountId } = req.params
  const [account] = await sql`SELECT * FROM view_account_full WHERE account_id = ${accountId}`
  if (!account) throw boom.notFound('User not found')
  res.json(account)
})

router.get('/:accountId/playlist', async (req, res) => {
  const { accountId } = req.params
  const rows = await sql`
    SELECT movie_id, title, age_rating, duration_minutes, popularity, director, casting, genres
    FROM view_account_playlist_full
    WHERE account_id = ${accountId}
  `
  res.json(rows)
})

router.put('/:accountId/playlist', async (req, res) => {
  const { accountId } = req.params
  const { movieId } = req.body
  try {
    await sql`INSERT INTO account_playlist (account_id, movie_id) VALUES (${accountId}, ${movieId})`
  } catch (err) {
    // Catch unique violations for PUT idempotency
    if (!err.message.includes('duplicate key value violates unique constraint')) throw err
  }
  res.status(204).end()
})

router.get('/:accountId/suggestions', async (req, res) => {
  const { accountId } = req.params
  const rows = await sql`
    SELECT movie_id, title, age_rating, duration_minutes, popularity, director, casting, genres
    FROM view_account_suggestions_full
    WHERE account_id = ${accountId}
  `
  res.json(rows)
})

router.put('/:accountId/suggestions', async (req, res) => {
  const { accountId } = req.params
  const { movieId } = req.body
  try {
    await sql`INSERT INTO account_suggestions (account_id, movie_id) VALUES (${accountId}, ${movieId})`
  } catch (err) {
    // Catch unique violations for PUT idempotency
    if (!err.message.includes('duplicate key value violates unique constraint')) throw err
  }
  res.status(204).end()
})
