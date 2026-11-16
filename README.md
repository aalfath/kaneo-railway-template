# Kaneo on Railway

This repo is the source of the Kaneo template on Railway. It deploys [Kaneo](https://github.com/usekaneo/kaneo), an open-source project management tool with boards, lists and tasks, as one service built from this repo's `Dockerfile`, plus a Railway PostgreSQL database.

- **Version:** Kaneo v2.49.0, official image `ghcr.io/usekaneo/kaneo:2.49.0`, pinned by digest in the `Dockerfile`.
- **Services:** `Kaneo` (web app and API on port 5173, health check `/api/health`) and `Postgres` (all data, on a Railway volume).
- **First login:** open the public URL and sign up. Accounts are created in the app; there is no default user or password.

## Variables

| Variable | Value in the template | Purpose |
|---|---|---|
| `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` | Connection to the Railway Postgres service over the private network |
| `KANEO_CLIENT_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Public URL of the app. The API URL (`/api`) is derived from it. Change it if you add a custom domain |
| `AUTH_SECRET` | generated 64-character hex secret | Signs login sessions. Keep it stable |
| `PORT` | `5173` | Port the bundled nginx listens on |

Optional features, such as SMTP (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASSWORD`, `SMTP_FROM`), GitHub sign-in (`GITHUB_OAUTH_CLIENT_ID`, `GITHUB_OAUTH_CLIENT_SECRET`), S3-compatible file uploads (`S3_ENDPOINT`, `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`) and turning off sign-ups (`DISABLE_REGISTRATION=true`), are set as service variables after deploying. See Kaneo's [`.env.sample`](https://github.com/usekaneo/kaneo/blob/main/.env.sample).

## Updates

The `Dockerfile` pins one Kaneo release. When a new release is tested, it is merged to `main` with an entry in `CHANGELOG.md`, and Railway shows an "update available" notice to everyone who deployed the template. You choose when to apply it. Kaneo runs its database migrations on start, so back up the Postgres volume before a major update.
