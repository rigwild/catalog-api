import Router from 'express-promise-router'
import boom from '@hapi/boom'

import { sql } from '../../../db.js'

export const router = Router()

router.get('/', async (req, res) => res.json(await sql`SELECT * FROM view_movie_full`))

router.post('/', async (req, res) => {
  const { title, director, ageRating, durationMinutes, popularity, casting, genres } = req.body
  const [movieId] = await sql.begin(async sql => {
    const [row] = await sql`
      INSERT INTO movie (title, director, age_rating, duration_minutes, popularity)
      VALUES (${title}, ${director}, ${ageRating}, ${durationMinutes}, ${popularity})
      RETURNING movie_id
    `
    const movieId = row.movie_id
    const castingObj = casting.map((x: number[]) => ({ movie_id: movieId, people_id: x }))
    const genresObj = genres.map((x: number[]) => ({ movie_id: movieId, genre_id: x }))
    await sql`INSERT INTO movie_casting ${sql(castingObj, 'movie_id', 'people_id')}`
    await sql`INSERT INTO movie_genres ${sql(genresObj, 'movie_id', 'genre_id')}`
    return [movieId]
  })
  res.status(201).json(await sql`SELECT * FROM view_movie_full WHERE movie_id = ${movieId}`)
})

router.get('/:movieId', async (req, res) => {
  const { movieId } = req.params
  const [movie] = await sql`SELECT * FROM view_movie_full WHERE movie_id = ${movieId}`
  if (!movie) throw boom.notFound('Movie not found')
  res.json(movie)
})

router.put('/:movieId', async (req, res) => {
  const { movieId } = req.params
  const { title, director, ageRating, durationMinutes, popularity, casting, genres } = req.body
  await sql.begin(async sql => {
    await sql`
      UPDATE movie
      SET
        title = ${title},
        director = ${director},
        age_rating = ${ageRating},
        duration_minutes = ${durationMinutes},
        popularity = ${popularity}
      WHERE movie_id = ${movieId}
    `
    await sql`DELETE FROM movie_casting WHERE movie_id = ${movieId}`
    await sql`DELETE FROM movie_genres WHERE movie_id = ${movieId}`
    const castingObj = casting.map((x: number[]) => ({ movie_id: movieId, people_id: x }))
    const genresObj = genres.map((x: number[]) => ({ movie_id: movieId, genre_id: x }))
    await sql`INSERT INTO movie_casting ${sql(castingObj, 'movie_id', 'people_id')}`
    await sql`INSERT INTO movie_genres ${sql(genresObj, 'movie_id', 'genre_id')}`
  })
  res.status(204).end()
})
