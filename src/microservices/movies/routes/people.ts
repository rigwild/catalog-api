import Router from 'express-promise-router'
import boom from '@hapi/boom'

import { sql } from '../../../db.js'

export const router = Router()

router.get('/', async (req, res) => res.json(await sql`SELECT * FROM people`))

router.post('/', async (req, res) => {
  const { name, job } = req.body
  const [people] = await sql`INSERT INTO people (name, job) VALUES (${name}, ${job}) RETURNING *`
  res.status(201).json(people)
})

router.get('/:peopleId', async (req, res) => {
  const { peopleId } = req.params
  const [people] = await sql`SELECT * FROM people WHERE people_id = ${peopleId}`
  if (!people) throw boom.notFound('People not found')
  res.json(people)
})

router.put('/:peopleId', async (req, res) => {
  const { peopleId } = req.params
  const { name, job } = req.body
  await sql`UPDATE people SET name = ${name}, job = ${job} WHERE people_id = ${peopleId}`
  res.status(204).end()
})
