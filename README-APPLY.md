# Apply CI/CD configuration

Target repository: `nguyenquephong13062003/Webservice_Session04_JPA`  
Target branch: `main`

Copy the files in this bundle into the repository while preserving their relative paths.

## GitHub Actions secrets

Add these repository secrets under Settings -> Secrets and variables -> Actions:

- `DOCKERHUB_USERNAME`: Docker Hub username.
- `DOCKERHUB_TOKEN`: Docker Hub access token with Read & Write permissions.

The CD workflow publishes only after the `CI` workflow succeeds on `main`.
It pushes two tags:

- `<dockerhub-username>/webservice-session04-jpa:latest`
- `<dockerhub-username>/webservice-session04-jpa:<full-commit-sha>`

## Run locally with Docker Compose

Set a non-default password before starting, for example in a local `.env` file:

```dotenv
POSTGRES_DB=jb_ioc_251229_ss4
POSTGRES_USER=postgres
POSTGRES_PASSWORD=replace_with_a_strong_local_password
POSTGRES_PORT=5432
APP_PORT=8080
```

Then run:

```bash
docker compose up --build -d
docker compose ps
docker compose logs -f app
```

Stop:

```bash
docker compose down
```

Keep `.env` out of Git. The provided `.dockerignore` excludes it from Docker build context.

## Security follow-up

The existing datasource password in the repository's committed `application.properties` must be considered exposed. Rotate it in the database and remove the old credential from any environments where it was reused. The updated properties read credentials from environment variables.
