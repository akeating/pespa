# pespa
Single page applications with Elixir and Phoenixframework.

Distinctly separate clients with api server (Elixir/Phoenixframework).

- [x] Updated to `phoenix 1.4`.
- [x] Demonstration of graphql subsciptions

If you connect the client applications in different browser tabs, you will see the subsctions at work in real-time.

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

In yet another terminal window:
```
cd src/client/elm
npm install
npm start
```

Browse to `http://localhost:8080`. The default email `demo@example.com` and password `foo` is hardcoded for convenience.

# Running the production client build

I'm using `caddy`, but you could use something like `nginx` too.

```
cd src/client/vue
yarn run build
caddy
```

The build is in `dist`. Browse to `http://localhost:8081` to view.
