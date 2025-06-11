# Publitas docs

## Install

Clone the repo, run `bundle install` and wait for it all to blow over.

## Use

Run middleman with `bundle exec middleman` and visit `http://localhost:4567`

## Edit

Content is edited in the `.md` files in the `source/` folder. Custom styling can be applied in

- `source/stylesheets/_variables.scss`: for basic styling
- `source/stylesheets/publitas.css`: for more advanced customizations

It's best to not modify other files in order to keep merge conflicts when upgrading Slate to the minimum

### Edit GraphQL docs

To update the GraphQL docs, you need to run `npm install` first to get the required Node dependencies.

The GraphQL docs are partially automatized, as the GraphQL References section can be auto-updated by running the command below, supplying the API key used for the production Affiliates API.

```
API_KEY=<API_KEY> npm run update-graphql-docs
```

This will refresh everything inside the `<!-- START graphql-markdown -->` and `<!-- END graphql-markdown -->` tags in `sources/graphql.md` with the latest content from the GraphQL Introspection query response. You may manually edit the example query and any other content outside the mentioned tags, though.

## Deploy

run `./deploy.sh`

## Visit

It's hosted on github pages, the url is [https://developers.publitas.com/docs](https://developers.publitas.com/docs)
