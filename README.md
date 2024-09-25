# Publitas docs

## Install

Clone the repo, run `bundle install` and wait for it all to blow over.

## Use

Run middleman with `bundle exec middleman` and visit `http://localhost:4567`

## Edit

You only need to worry about the `.md` files in the `source/` folder.

### Edit GraphQL docs

The GraphQL docs are partially automatized, as the GraphQL References section can be auto-updated by running the command below, supplying the API key used for the production Affiliates API.

```
API_KEY=<API_KEY> npm run update-graphql-docs
```

This will refresh everything inside the `<!-- START graphql-markdown -->` and `<!-- END graphql-markdown -->` tags in `sources/graphql.md` with the latest content from the GraphQL Introspection query response. You may manually edit the example query and any other content outside the mentioned tags, though.

## Deploy

run `rake publish`


## Visit

It's hosted on github pages, the url is [http://publitas.github.io/docs](http://publitas.github.io/docs)
