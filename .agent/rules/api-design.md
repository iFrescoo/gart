# API Design

## Applies When
API route files (`api/**`, `routes/**`, `endpoints/**`, `**/route.ts`)

## Rules

### REST Conventions
| Method | Purpose | Idempotent |
|--------|---------|-----------|
| `GET` | Read resource(s) | Yes |
| `POST` | Create resource | No |
| `PUT` | Replace resource entirely | Yes |
| `PATCH` | Partial update | Yes |
| `DELETE` | Remove resource | Yes |

### Status Codes
| Code | When |
|------|------|
| `200` | Success (with body) |
| `201` | Created (POST success) |
| `204` | Success (no body, DELETE) |
| `400` | Bad request (validation error) |
| `401` | Unauthorized (not authenticated) |
| `403` | Forbidden (authenticated but not allowed) |
| `404` | Not found |
| `409` | Conflict (duplicate, version mismatch) |
| `422` | Unprocessable entity (valid JSON, invalid semantics) |
| `429` | Too many requests (rate limited) |
| `500` | Internal server error |

### URL Design
- Nouns, not verbs: `/users`, not `/getUsers`
- Plural: `/users/123`, not `/user/123`
- Nested resources: `/users/123/orders`
- Filtering: `/users?role=admin&status=active`
- Pagination: `/users?page=2&limit=20`
- Versioning: `/api/v1/users` or `Accept: application/vnd.api.v1+json`

### Input Validation
- Validate all input at the API boundary (use zod, joi, or yup)
- Reject unknown fields
- Return detailed validation errors to the client
- Sanitize strings (trim whitespace, prevent injection)

### Response Format
```json
{
  "data": { ... },
  "meta": { "page": 1, "total": 100 },
  "errors": [{ "field": "email", "message": "Invalid format" }]
}
```
