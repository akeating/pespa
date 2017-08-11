# pespa
Single page applications with Elixir and Phoenixframework.

Distinctly separate client (Vuejs) with api server (Elixir/Phoenixframework).

Updated to `phoenix 1.3`.

# Client


- [x] Vuejs

# Server
- [x] API server written in Elixir with Phoenix, Graphql, JWTs, Postgres.

# Setup

Requires `postgres`, `node`, `yarn`, `elixir`.

Modify `src/server/apps/domain/config/dev.exs` to suit your `postgres` setup.

In a terminal window:
```
cd src/server
mix deps.get
mix compile
mix ecto.reset
mix s
```

In a another terminal window:
```
cd src/client
yarn
yarn run dev
```

Browse to `http://localhost:8080`. The default email `demo@example.com` and password `foo` is hardcoded for convenience.

# Running the production client build

I'm using `caddy`, but you could use something like `nginx` too.

```
cd src/client
yarn run build
caddy
```

The build is in `dist`. Browse to `http://localhost:8081` to view.
