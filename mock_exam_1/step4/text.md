### Create a ConfigMap named `app-config` with the following key-value pairs:
- `database_url=postgresql://localhost:5432/mydb`
- `api_key=abc123xyz`
- `environment=production`

Then create a pod named `config-pod` with image `nginx` that uses these values as environment variables.

