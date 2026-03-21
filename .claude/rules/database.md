# Database Conventions

## Applies When
Database files (`migrations/**`, `models/**`, `schema/**`, `**/*.sql`, `prisma/**`)

## Rules

### Queries
- **Always** use parameterized queries — never concatenate user input
- **Always** add indexes on foreign keys and frequently queried columns
- **Avoid** `SELECT *` — select only needed columns
- **Limit** result sets — always paginate large queries

### Migrations
- One migration per change (don't combine unrelated changes)
- Migrations must be reversible (`up` + `down`)
- Test migrations against production-like data volumes
- Never modify a migration that's been deployed — create a new one

### Schema Design
- Use UUIDs or auto-increment for primary keys (be consistent)
- Add `created_at` and `updated_at` timestamps to all tables
- Use soft deletes (`deleted_at`) for recoverable data
- Normalize to 3NF, then denormalize intentionally for performance

### Transactions
- Use transactions for multi-step operations
- Keep transactions short (don't hold locks unnecessarily)
- Handle deadlocks with retry logic
- Set appropriate isolation levels

### ORM Patterns
- Watch for N+1 queries — use eager loading/includes
- Don't trust ORM to generate optimal queries — check SQL output
- Use raw queries for complex operations
- Use connection pooling (don't create connections per request)

### Don'ts
- No `DROP TABLE` or `TRUNCATE` without explicit user confirmation
- No schema changes in application code (use migrations)
- No storing passwords in plain text (use bcrypt/argon2)
- No storing sensitive data without encryption at rest
