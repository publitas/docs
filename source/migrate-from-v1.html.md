---
title: Migrate from API v1

toc_footers:
  - <a href='../'>API Overview</a>
  - <a href='https://publitas.com'>Publitas.com</a>

search: false
---

# Migrate from API v1

API v1 will be deprecated. It is only available to accounts that already use it, and we'll announce the date it stops working well in advance. After that date, API v1 requests will return an error (HTTP 403 or 404).

## Choose where to move

Where you move depends on whose publications you read with API v1, and what you do with them.

| You use API v1 to… | Move to |
| --- | --- |
| Show your own publications on your website or in your app | [Embed the Viewer](#embed-the-viewer). This is the right choice for most retailers. |
| Read your own publications, hotspots and products into your own systems | [REST API v2](#move-to-rest-api-v2) |
| Draw the pages of your own publications in your own custom catalog viewer | [Contact our support team](mailto:support@publitas.com) to discuss your setup |
| Show catalogs from the retailers you work with, as an affiliate partner, for example on a deals site or in a shopping app | [GraphQL API](#move-to-the-graphql-api). It gives you the publications of every retailer you work with through Publitas, with one API key. |

REST API v2 and the GraphQL API both need an API key, so call them from your own server. Never put an API key in a web page or app, because anyone can read it there.

# Embed the Viewer

This section and the next are for you if you are a retailer reading your own publications.

The Publitas Viewer shows your publication with its pages, hotspots, products and search, and it keeps up with changes you make in Publitas. Instead of building this yourself from API v1 data, link to the publication or embed it on your site.

- Get the publication's address from `public_url` in [REST API v2](rest-v2.html#get-a-specific-publication), or copy it from Publitas.
- To react to what happens in an embedded Viewer, for example when a visitor turns the page, use the [Viewer Message API](viewer-message-api.html).
- To customise the Viewer itself, use the [Viewer JavaScript API](js.html).

# Move to REST API v2

Use REST API v2 to read your own publications, hotspots and products from your own server. It is the same API you use to create and publish them.

## What changes

| | API v1 | REST API v2 |
| --- | --- | --- |
| Address | `https://api.publitas.com/v1/...` | `https://api.publitas.com/v2/...` |
| Authentication | none | `Authorization: ApiKey <api_key>` header (see [Get an API key](rest-v2.html#get-an-api-key)) |
| Groups and publications | by slug | by ID. List your groups with `GET /v2/groups` to find the group ID |
| Spreads, hotspots, products | all in one response, products one call each | one call for the spreads, then one call per spread for its hotspots, with products included |
| Page images | paths per page | not available; use `cover_url` for the cover |
| Lists | all in one response | up to 1000 per page (see [pagination](rest-v2.html#understanding-pagination)) |
| Errors | HTTP 404 | HTTP 403 if the API key is missing or wrong, 404 if something is not found |
| Where to call it from | anywhere, including web pages | your own server only |

## Calls

| API v1 call | REST API v2 replacement |
| --- | --- |
| `GET /v1/groups/:group/publications.json` | `GET /v2/groups/:group_id/publications?state=public` |
| `GET /v1/groups/:group/publications/:slug.json` | `GET /v2/groups/:group_id/publications/:id`, then `GET /v2/publications/:id/spreads` and `GET /v2/spreads/:spread_id/hotspots` for each spread |
| `GET /v1/groups/:group/publications/:slug/products/:id.json` | the product in its product hotspot (`GET /v2/spreads/:spread_id/hotspots`) |

API v1 only returned publications that are online and not password-protected. With `state=public`, REST API v2 returns online publications that are not unlisted; use `state=online` to include unlisted ones. Skip publications where `secured` is `true` to leave out password-protected ones.

REST API v2 also returns image, slideshow and text hotspots, which API v1 left out. Ignore the types you don't use.

## Field names

| API v1 | REST API v2 |
| --- | --- |
| list `id`, `slug`, `title`, `browserTitle`, `onlineAt` | `id`, `slug`, `title`, `browser_title`, `online_at` |
| list `url` | `url` (the REST API v2 address of the publication); `public_url` for the Viewer address |
| `config.publicationId` | `publication.id` |
| `config.publicationTitle` | `publication.browser_title` |
| `config.locale`, `config.language` | `publication.language` |
| `config.description`, `config.slug` | `publication.description`, `publication.slug` |
| `config.downloadPdfUrl` (a path) | `publication.pdf_download_url` (a full URL) |
| `spreads[]` | `spreads[]` from `GET /v2/publications/:id/spreads` |
| `hotspots[].type` (`product`, `externalLink`, `pageReference`, `video`) | `type` (`product`, `external_link`, `page_reference`, `video`) |
| `hotspots[].position.left/top/width/height` | `left`, `top`, `width`, `height` |
| `hotspots[].position.iconLeft/iconTop` | `icon_left`, `icon_top` |
| `hotspots[].showIndication` | `show_indication` |
| `hotspots[].pageNumber` | `page_number` |
| `hotspots[].youtubeId` | `video_id` (with `video_provider`) |
| `hotspots[].products[]` (IDs only) | `products[]` (full products) |
| product `photos[].photoUrl` | product `photoUrls[].full` |
| product `video[].youtubeId` | product `videoId` |
| product `hotspotId` | the `id` of the hotspot that contains it |

Product IDs are strings in REST API v2. Other product fields (`title`, `description`, `price`, `discountedPrice`, `webshopIdentifier`, `webshopUrl`, `promotionalLabel` and the unit price fields) keep their names.

## What has no replacement in REST API v2

- **Page images** (`spreads[].pages`) and image sizes (`sizes`). If you draw the pages yourself, [contact our support team](mailto:support@publitas.com).
- **Viewer settings:** `customerName`, `relativeSize`, `websiteUrl`, `webshopCheckoutUrl`, `disableSharing`, `showPrintButton`, `enableSearch`, `searchHost`, `currencySymbol`, `currency`, `callToActionButtonText`, `styling`.
- **Viewer translations** (`translations`).

# Move to the GraphQL API

This section is for you if you are an affiliate partner and show catalogs from the retailers you work with. To get an API key, [contact our support team](mailto:support@publitas.com). Your key gives you the publications of the retailers linked to it.

## What changes

| | API v1 | GraphQL |
| --- | --- | --- |
| Address | `https://api.publitas.com/v1/...` (one address per call) | `https://affiliate.publitas.com/graphql` (one address for everything) |
| Method | `GET` | `POST`, JSON body with `query` and `variables` |
| Authentication | none | `x-api-key` header |
| Lists (publications, spreads) | all in one response | 50 per page; follow `pageInfo` |
| Products | one call per product | included in each product hotspot |
| Images | paths to complete yourself | full URLs per size |
| Errors | HTTP 404 | HTTP 403 if the API key is missing or wrong, 429 if you send too many requests. Otherwise HTTP 200, with an `errors` list in the body when something is not found. Check both. |
| Where to call it from | anywhere, including web pages | your own server only |

## Calls

| API v1 call | GraphQL replacement |
| --- | --- |
| `GET /v1/groups/:group/publications.json` | `publications(groupSlug:)` |
| `GET /v1/groups/:group/publications/:slug.json` | `publication(groupSlug:, slug:)` |
| `GET /v1/groups/:group/publications/:slug/products/:id.json` | `publication(groupSlug:, slug:)`, then the product in its product hotspot |

You can also find a publication by its ID (`publication(id:)`) or by its viewer address (`publicationByUrl(url:)`).

### List a group's publications

```graphql
query ($groupSlug: String!, $after: String) {
  publications(groupSlug: $groupSlug, first: 50, after: $after) {
    pageInfo { hasNextPage endCursor }
    edges { node { id publicationSlug publicationTitle onlineAt scheduleOnlineAt } }
  }
}
```

```bash
curl https://affiliate.publitas.com/graphql \
  -H "x-api-key: YOUR_KEY" -H "Content-Type: application/json" \
  -d '{"query":"query ($groupSlug: String!, $after: String) { publications(groupSlug: $groupSlug, first: 50, after: $after) { pageInfo { hasNextPage endCursor } edges { node { id publicationSlug publicationTitle onlineAt scheduleOnlineAt } } } }","variables":{"groupSlug":"retailer-group"}}'
```

The list only includes groups linked to your key. If a retailer you work with is missing, ask our support team to check that their groups are linked to your key. Unlisted publications are not included, but you can still fetch them one at a time by slug.

Unlike API v1, GraphQL also returns publications that are scheduled to go online later. To show only live publications, skip any whose `scheduleOnlineAt` is in the future. Scheduled publications appear in the list even if they will be unlisted. The same applies when you fetch a single publication.

### Get one publication, with pages, hotspots and products

```graphql
query ($groupSlug: String!, $slug: String!, $after: String) {
  publication(groupSlug: $groupSlug, slug: $slug) {
    id slug title description language currency customCurrency downloadPdfUrl scheduleOnlineAt
    sizes { at width height }
    spreads(first: 50, after: $after) {
      pageInfo { hasNextPage endCursor }
      edges { node {
        position
        pages { position width height images { size url } }
        hotspots {
          __typename id left top width height
          ... on PageReferenceHotspot { pageNumber }
          ... on ExternalLinkHotspot { url }
          ... on VideoHotspot { videoId videoProvider }
          ... on ProductHotspot { products {
            id title description price discountedPrice
            webshopIdentifier webshopUrl promotionalLabel videoId
            photoUrls { thumb full }
          } }
        }
      } }
    }
  }
}
```

If `pageInfo.hasNextPage` is true, send the query again with `after` set to `pageInfo.endCursor`.

GraphQL also returns image and slideshow hotspots, which API v1 left out. Ignore the types you don't use, or ask only for the ones you need with `hotspots(types: [PRODUCT, EXTERNAL_LINK, PAGE_REFERENCE, VIDEO])`.

### Get one product

There is no single-product query. Fetch the publication (above) and find the product in `ProductHotspot.products`. This returns more data than the API v1 call did, so cache the publication rather than fetching it per product. Asking for `hotspots(types: [PRODUCT])` keeps the response smaller.

## Field names

| API v1 | GraphQL |
| --- | --- |
| `config.publicationId` | `publication.id` |
| `config.publicationTitle` | `publication.title` |
| `config.locale`, `config.language` | `publication.language` |
| `config.currencySymbol` | `publication.customCurrency` (null when no custom symbol is set; fall back to your own default) |
| `config.downloadPdfUrl` (a path) | `publication.downloadPdfUrl` (a full URL) |
| `sizes` (an object keyed `at200`, `at600`, …) | `sizes { at width height }` (a list) |
| `spreads[].pages[]` (paths) | `spreads.pages.images { size url }` |
| `hotspots[].type` (`product`, `externalLink`, `pageReference`, `video`) | `hotspots.__typename` (`ProductHotspot`, `ExternalLinkHotspot`, `PageReferenceHotspot`, `VideoHotspot`) |
| `hotspots[].position.left/top/width/height` | `hotspots.left/top/width/height` |
| `hotspots[].youtubeId` (video hotspots) | `VideoHotspot.videoId` |
| list `slug`, `title` | `publicationSlug`, `publicationTitle` |
| product `photos[].photoUrl` | product `photoUrls { full }` |
| product `video[].youtubeId` | product `videoId` |
| product `hotspotId` | the `id` of the hotspot that contains it |

## What has no replacement in GraphQL

- **Viewer settings:** `customerName`, `relativeSize`, `websiteUrl`, `webshopCheckoutUrl`, `disableSharing`, `showPrintButton`, `enableSearch`, `searchHost`, `callToActionButtonText`, `styling`.
- **Viewer translations** (`translations`).
- **Unit prices** on products: `basePricePerUnit`, `baseMeasureQuantity`, `baseMeasureUnit`.
- **On hotspots:** `title`, `showIndication`, `showTooltip`, `position.iconLeft`, `position.iconTop`.
- **In the publications list:** `browserTitle` (use `publication.title`) and the `url` link.
