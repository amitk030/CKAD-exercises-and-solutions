### Create a secret named `db-credentials` in the `secure-ns` namespace with the following data:
- `username=admin`
- `password=secretpass123`

Then create a pod named `db-pod` with image `nginx` in the same namespace that uses these secret values as environment variables named `DB_USER` and `DB_PASSWORD`.

