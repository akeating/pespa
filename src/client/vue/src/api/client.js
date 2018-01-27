import ApolloClient from 'apollo-client/ApolloClient';
import {ApolloLink} from 'apollo-link';
import {createHttpLink} from 'apollo-link-http';
import {hasSubscription} from '@jumpn/utils-graphql';
import {InMemoryCache} from 'apollo-cache-inmemory';

import absintheSocketLink from './link';

export default function newClient(opts) {
  // eslint-disable-next-line new-cap
  const link = new ApolloLink.split(
    operation => hasSubscription(operation.query),
    absintheSocketLink(opts),
    createHttpLink({uri: '/api/graphql'})
  );

  const client = new ApolloClient({
    link,
    cache: new InMemoryCache()
  });
  return client;
}
