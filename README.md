# pespa
Single page applications with Elixir and Phoenixframework.

Distinctly separate clients with api server (Elixir/Phoenixframework).

- [x] A counter synced between Vue and Elm applications using graphql subscriptions
- [x] Phoenix / Elixr server updated to `phoenix 1.4.3`.

If you connect the client applications in different browser tabs, you will see the subscriptions at work in real-time.

# Client


- [x] Vuejs
- [x] Elm

# Server
- [x] API server written in Elixir with Phoenix, Graphql, JWTs, Postgres.

# Setup

Requires `postgres`, `node`, `yarn`, `elixir`, `elm 0.19`.

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
cd src/client/vue
yarn
yarn run dev
```

Browse to `http://localhost:8080`. The default email `demo@example.com` and password `foo` is hardcoded for convenience.

In yet another terminal window:
```
cd src/client/elm
npm install
npm start
```

In a different tab browse to `http://localhost:3080`. The default email `demo@example.com` and password `foo` is hardcoded for convenience.

After logging in in both tabs, you can increment and decrement the counter and observe it synced between client apps.

# Running the production client build

I'm using `caddy`, but you could use something like `nginx` too.

```
cd src/client/vue
yarn run build
caddy
```

The build is in `dist`. Browse to `http://localhost:8081` to view.
