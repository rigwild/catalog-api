import postgres from 'postgres'

export const sql = postgres({ database: 'catalog_api' })
