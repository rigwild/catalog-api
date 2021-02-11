import postgres from 'postgres'

export const sql = postgres({ database: 'catalog_api' })

// Check if credentials are valid
try {
  console.log('Connecting to database...')
  const [{ version }] = await sql`SELECT version()`
  console.log('Connection to database successful! PostgreSQL version:')
  console.log(version)
} catch (err) {
  console.log('Failed to connect to the database')
  throw err
}
