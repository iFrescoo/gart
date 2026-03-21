# Docker Conventions

## Applies When
Docker files (`Dockerfile`, `docker-compose.yml`, `.dockerignore`, `**/*.dockerfile`)

## Rules

### Dockerfile Best Practices
- **Multi-stage builds** — separate build and runtime stages
- **Minimal base images** — use `alpine` or `slim` variants
- **No root user** — add `USER node` or `USER appuser`
- **Layer caching** — put rarely-changing layers first (deps before source code)

### Layer Order (optimal caching)
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./          # 1. Dependencies (cached if unchanged)
RUN npm ci --production        # 2. Install (cached if package.json unchanged)
COPY . .                       # 3. Source code (invalidates on any change)
RUN npm run build              # 4. Build

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER node
CMD ["node", "dist/index.js"]
```

### .dockerignore
Must include: `node_modules`, `.git`, `.env`, `*.md`, `tests/`, `.vscode/`

### Docker Compose
- Pin image versions (no `latest` tag)
- Use `depends_on` with health checks
- Store secrets in `.env` (not in compose file)
- Use named volumes for persistent data

### Security
- Scan images for vulnerabilities (`docker scout`, `trivy`)
- Don't store secrets in images (use env vars or secrets manager)
- Keep base images updated
- Minimize installed packages (no `curl`, `wget` in production)
