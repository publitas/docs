---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://publitas.com'>Publitas.com</a>
  - <a href='http://github.com/tripit/slate'>Powered by Slate</a>
---

# REST API v2

This API can be used to programatically list your account's groups, as well as to list and create publications based on existing PDF documents.

# Getting Started

### Get an API key

To use the rest API you need to an API key. Contact our [support team](mailto:support@publitas.com) to request an API key.

API keys are passed via the `Authorization` header as demonstrated in the code snippet to the right.

```shell
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups"
```

### Understanding Pagination

Many endpoints in the API support pagination to help manage large result sets. When using pagination, the following query parameters are available:

| Parameter | Type    | Description                                            |
| --------- | ------- | ------------------------------------------------------ |
| page      | Integer | Page number to retrieve (default: returns all results) |
| per_page  | Integer | Number of items per page (default: 25, max: 100)       |

When pagination is used, the following headers are included in the response:

| Header      | Description                         |
| ----------- | ----------------------------------- |
| X-Page      | Current page number                 |
| X-Per-Page  | Number of items per page            |
| X-Next-Page | Next page number (if available)     |
| X-Prev-Page | Previous page number (if available) |

### API Path structure

The base path of an API request is: `https://api.publitas.com/v2/`

A example of a complete path is:

`https://api.publitas.com/v2/groups/`

# Groups

```shell
# This will retrieve all the groups accessible by the user
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups"
```

> The above command returns a JSON document structured like this:

```json
{
  "groups": [
    {
      "id": 1,
      "title": "Example group",
      "slug": "example-group",
      "url": "https://api.publitas.com/v2/groups/1",
      "publications_url": "https://api.publitas.com/v2/groups/1/publications",
      "publication_count": 2,
      "public_url": "https://view.publitas.com/example-group"
    }
  ]
}
```

The attributes are as follows:

| Field             | Type    | Description                                                                        |
| ----------------- | ------- | ---------------------------------------------------------------------------------- |
| id                | Integer | Group ID                                                                           |
| title             | String  | Group title                                                                        |
| slug              | String  | Group slug                                                                         |
| url               | String  | Group details URL                                                                  |
| publications_url  | String  | Publication list URL for the group. Custom domain will be applied if there is one. |
| publication_count | Integer | Amount of publications contained within the group                                  |
| public_url        | String  | Group public URL (redirects to latest online publication)                          |

# Publications

## List all publications of a group

```shell
# This will retrieve all publications for a group
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications"
```

> The above command returns JSON structured like this:

```json
{
  "publications": [
    {
      "id": 1,
      "title": "Spring 2014",
      "browser_title": "Browser Spring 2014",
      "description": "Spring 2014 description",
      "slug": "spring-2014",
      "url": "https://api.publitas.com/v2/groups/1/publications/1",
      "cover_url": "https://view.publitas.com/1/1/pages/fb7be8c8211c15f3b5aa6e7527fe6fe2efb4f60c-at800.jpg",
      "page_count": 52,
      "pdf_download_url": "https://view.publitas.com/1/1/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Spring%25202014.pdf",
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "metatag_ids": [1, 2],
      "valid_from": null,
      "collection_id": null
    },
    {
      "id": 2,
      "title": "Autumn 2014",
      "browser_title": "Browser Autumn 2014",
      "description": "Autumn 2014 description",
      "slug": "autumn-2014",
      "url": "https://api.publitas.com/v2/groups/1/publications/2",
      "cover_url": "https://view.publitas.com/1/2/pages/fb7be8c8211c15f3b5aa6e7527fe6fe2efb4f60c-at800.jpg",
      "page_count": 52,
      "pdf_download_url": "https://view.publitas.com/1/2/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Autumn%25202014.pdf",
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": "2014-09-25T15:17:20.000+02:00",
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/autumn-2014",
      "metatag_ids": [2, 3],
      "valid_from": "2014-09-26",
      "collection_id": null
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/publications`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Query Parameters

See the [Pagination](#pagination) section for pagination parameters.

The JSON response returns a list of publications with the following attributes:

| Field               | Type     | Description                                                                                            |
| ------------------- | -------- | ------------------------------------------------------------------------------------------------------ |
| id                  | Integer  | Publication ID                                                                                         |
| title               | String   | Publication Title                                                                                      |
| browser_title       | String   | SEO title                                                                                              |
| description         | String   | SEO description                                                                                        |
| slug                | String   | Publication Slug                                                                                       |
| url                 | String   | Publication details URL                                                                                |
| cover_url           | String   | URL for the cover image (@800 resolution)                                                              |
| page_count          | Integer  | Number of pages in the publication                                                                     |
| pdf_download_url    | String   | Source PDF download URL                                                                                |
| state               | String   | The publication state (see table below for a better description)                                       |
| online_at           | DateTime | Time at which the publication was last set online                                                      |
| offline_at          | DateTime | Time at which the publication was last set offline                                                     |
| schedule_online_at  | DateTime | Time at which the publication is scheduled to go online                                                |
| schedule_offline_at | DateTime | Time at which the publication is scheduled to go offline                                               |
| public_url          | String   | Publication public URL or `null` when the publication is still converting.                             |
| metatag_ids         | Array    | List of metatag IDs assigned to the publication                                                        |
| valid_from          | Date     | Validity date of the publication. This is a descriptive parameter and has no effect on the publication |
| collection_id       | Integer  | ID of the collection this publication belongs to, or `null` if not part of any collection              |

The `state` field can have one of the following values:

| Value   | Description                          |
| ------- | ------------------------------------ |
| offline | Publication is not publicly visible. |
| online  | Publication is publicly visible.     |

### Filtering results

You can filter the results list with the following query params:

```shell
# This will retrieve only publicly listed publications
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications?state=public&collection_id=1"
```

| Param         | Options                                 | Description                                                                                                                                                  |
| ------------- | --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| state         | public<br>unlisted<br>online<br>offline | Return only publicly listed publications<br>Return only unlisted publications<br>Return public and unlisted publications<br>Return only offline publications |
| collection_id | Integer                                 | Filter publications by collection ID. Returns only publications that belong to the specified collection                                                      |

## Get a specific publication

```shell
# This endpoint retrieves a specific publication.
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications/222"
```

> The above command returns JSON structured like this:

```json
{
  "publication": [
    {
      "id": 222,
      "title": "Spring 2014",
      "browser_title": "Browser Spring 2014",
      "description": "Spring 2014 description",
      "slug": "spring-2014",
      "url": "https://api.publitas.com/v2/groups/1/publications/222",
      "cover_url": "https://view.publitas.com/1/222/pages/fb7be8c8211c15f3b5aa6e7527fe6fe2efb4f60c-at800.jpg",
      "page_count": 52,
      "pdf_download_url": "https://view.publitas.com/1/222/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Spring%25202014.pdf",
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "metatag_ids": [2, 3],
      "valid_from": null,
      "collection_id": null
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>`

### URL Parameters

| Parameter      | Description                      |
| -------------- | -------------------------------- |
| Group ID       | The ID of a specific group       |
| Publication ID | The ID of a specific publication |

## Create a publication

```shell
# This will create a publication with the title Winter2014, browser title BrowserWinter2014, description Winter2014Description and source URL http://example.com/winter2014.pdf.
curl -H "Authorization: ApiKey <api_key>" --data "publication[title]=Winter2014&publication[source_url]=http://example.com/winter2014.pdf&publication[browser_title]=BrowserWinter2014&publication[description]=Winter2014Description" "https://api.publitas.com/v2/groups/1/publications"
```

> The above command returns JSON structured like this:

```json
{
  "publication": {
    "id": 3,
    "title": "Winter2014",
    "browser_title": "BrowserWinter2014",
    "description": "Winter2014Description",
    "slug": "winter2014",
    "url": "https://api.publitas.com/v2/groups/1/publications/3",
    "cover_url": null,
    "page_count": 0,
    "pdf_download_url": "https://view.publitas.com/1/3/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Winter%25202014.pdf",
    "state": "offline",
    "online_at": null,
    "offline_at": null,
    "schedule_online_at": null,
    "schedule_offline_at": null,
    "public_url": null,
    "metatag_ids": [],
    "valid_from": null
  }
}
```

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/publications`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Request body parameters

The following fields need to be sent within a publication scope (see the right panel for an example):

| Name                | Type     | Required | Description                                                                                                                                             |
| ------------------- | -------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| source_url          | String   | Yes      | URL where the PDF file resides. HTTP and HTTPS are accepted, and it needs to be a public accessible file.                                               |
| title               | String   | Yes      | The title for the publication                                                                                                                           |
| browser_title       | String   | No       | The SEO title for the publication                                                                                                                       |
| description         | String   | No       | The SEO description for the publication                                                                                                                 |
| language            | String   | No       | 2-digit language code. See [the language table](#languages) below for allowed values                                                                    |
| schedule_online_at  | DateTime | No       | Time at which the publication is scheduled to be online. If the current time is provided, the publication will be put online as soon as it is converted |
| schedule_offline_at | DateTime | No       | Time at which the publication is scheduled to be offline                                                                                                |
| metatag_ids         | Array    | No       | List of metatag IDs you want to assign to the publication                                                                                               |
| metatags_category   | String   | No       | Assigns all metatags in that category to the publication. This can be sent in combination with metatag_ids                                              |
| valid_from          | Date     | No       | Validity date of the publication. This is a descriptive parameter and has no effect on the publication                                                  |
| collection_id       | Integer  | No       | Associate publication to a collection by ID                                                                                                             |
| extraction_options  | Object   | No       | Define settings to extract hotspots from the PDF file. See [extraction options](#extraction-options) for allowed fields                                 |

## Update a publication

```shell
# This will update a publication with the browser title UpdatedBrowserTitle, description UpdatedDescription and assign metatags with IDs 1 and 2.
curl -H "Authorization: ApiKey <api_key>" -H "Content-Type: application/json" -X PUT --data '{"publication": {"browser_title": "UpdatedBrowserTitle", "description": "UpdatedDescription", "metatag_ids": [1,2]}}' "https://api.publitas.com/v2/groups/1/publications/3"
```

> The above command returns JSON structured like this:

```json
{
  "publication": {
    "id": 3,
    "title": "Winter2014",
    "browser_title": "UpdatedBrowserTitle",
    "description": "UpdatedDescription",
    "slug": "winter2014",
    "url": "https://api.publitas.com/v2/groups/1/publications/3",
    "cover_url": null,
    "page_count": 0,
    "pdf_download_url": "https://view.publitas.com/1/3/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Winter%25202014.pdf",
    "state": "offline",
    "online_at": null,
    "offline_at": null,
    "schedule_online_at": null,
    "schedule_offline_at": null,
    "public_url": null,
    "metatag_ids": [1, 2],
    "valid_from": null
  }
}
```

### HTTP Request

`PUT https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>`

### URL Parameters

| Parameter      | Description                      |
| -------------- | -------------------------------- |
| Group ID       | The ID of a specific group       |
| Publication ID | The ID of a specific publication |

### Request body parameters

The following fields need to be sent within a publication scope (see the right panel for an example):

| Name              | Type   | Required | Description                                                                                                                                   |
| ----------------- | ------ | -------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| browser_title     | String | No       | The SEO title for the publication                                                                                                             |
| description       | String | No       | The SEO description for the publication                                                                                                       |
| metatag_ids       | Array  | No       | List of metatag IDs you want to assign to the publication. This replaces current assignments (sending an empty array will clear assignments). |
| metatags_category | String | No       | Assigns all metatags in that category to the publication. This can be sent in combination with metatag_ids                                    |
| valid_from        | Date   | No       | Validity date of the publication. This is a descriptive parameter and has no effect on the publication                                        |

## Mark a publication as online

```shell
# This endpoint marks a publication as being online.
curl -H "Authorization: ApiKey <api_key>" -X POST "https://api.publitas.com/v2/groups/1/publications/222/online"
```

> When the response code is 200 the command returns JSON structured like this:

```json
{
  "publication": [
    {
      "id": 222,
      "title": "Spring 2014",
      "browser_title": "Browser Spring 2014",
      "description": "Spring 2014 description",
      "slug": "spring-2014",
      "url": "https://api.publitas.com/v2/groups/1/publications/222",
      "cover_url": "https://view.publitas.com/1/222/pages/fb7be8c8211c15f3b5aa6e7527fe6fe2efb4f60c-at800.jpg",
      "page_count": 52,
      "pdf_download_url": "https://view.publitas.com/1/222/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Spring%25202014.pdf",
      "state": "online",
      "online_at": "2015-01-28T16:05:28.309+01:00",
      "offline_at": null,
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "valid_from": null
    }
  ]
}
```

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/online`

### Response codes

This endpoint returns one of the following HTTP codes:

| Code | Description                             |
| ---- | --------------------------------------- |
| 200  | Publication is online                   |
| 402  | You have reached your publishing limit. |

## Mark a publication as offline

```shell
# This endpoint marks a publication as being offline.
curl -H "Authorization: ApiKey <api_key>" -X POST "https://api.publitas.com/v2/groups/1/publications/222/offline"
```

> The above command returns JSON structured like this:

```json
{
  "publication": [
    {
      "id": 222,
      "title": "Spring 2014",
      "browser_title": "Browser Spring 2014",
      "description": "Spring 2014 description",
      "slug": "spring-2014",
      "url": "https://api.publitas.com/v2/groups/1/publications/222",
      "cover_url": "https://view.publitas.com/1/222/pages/fb7be8c8211c15f3b5aa6e7527fe6fe2efb4f60c-at800.jpg",
      "page_count": 52,
      "pdf_download_url": "https://view.publitas.com/1/222/pdfs/ba113516-f927-4f81-a814-68d050d8fb85.pdf?response-content-disposition=attachment%3B+filename%2A%3DUTF-8%27%27Browser%2520Spring%25202014.pdf",
      "state": "offline",
      "online_at": "2015-01-28T16:05:28.309+01:00",
      "offline_at": "2015-01-28T17:05:28.309+01:00",
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "valid_from": null
    }
  ]
}
```

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/offline`

### Response codes

This endpoint returns the `200` response code.

## Archive Publication

```shell
# This endpoint archives a publication
curl -H "Authorization: ApiKey <api_key>" -X DELETE "https://api.publitas.com/v2/groups/1/publications/222"
```

> The above command returns a 204 with no content

### HTTP Request

`DELETE https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>`

### URL Parameters

| Parameter      | Description                      |
| -------------- | -------------------------------- |
| Group ID       | The ID of a specific group       |
| Publication ID | The ID of a specific publication |

# Metatags

## List all metatags of a group

```shell
# This will retrieve all metatags for a group
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/metatags"
```

> The above command returns JSON structured like this:

```json
{
  "metatags": [
    {
      "id": 1,
      "group_id": 1,
      "category": "category_1",
      "value": "value_1"
    },
    {
      "id": 2,
      "group_id": 1,
      "category": "category_1",
      "value": "value_2"
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/metatags`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Query Parameters

See the [Pagination](#pagination) section for pagination parameters.

The JSON response returns a list of metatags with the following attributes:

| Field    | Type    | Description      |
| -------- | ------- | ---------------- |
| id       | Integer | Publication ID   |
| group_id | Integer | Group ID         |
| category | String  | Metatag category |
| value    | String  | Metatag value    |

## Get a specific metatag

```shell
# This endpoint retrieves a specific metatag.
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/metatags/222"
```

> The above command returns JSON structured like this:

```json
{
  "metatag": [
    {
      "id": 222,
      "group_id": 1,
      "category": "category_1",
      "value": "value_1"
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/metatags/<Metatag ID>`

### URL Parameters

| Parameter  | Description                  |
| ---------- | ---------------------------- |
| Group ID   | The ID of a specific group   |
| Metatag ID | The ID of a specific metatag |

## Create a metatag

```shell
# This will create a metatag with the categordy category_3 and value value_3.
curl -H "Authorization: ApiKey <api_key>" --data "metatag[category]=category_3&metatag[value]=value_3" "https://api.publitas.com/v2/groups/1/metatags"
```

> The above command returns JSON structured like this:

```json
{
  "metatag": {
    "id": 3,
    "group_id": 1,
    "category": "category_3",
    "value": "value_3"
  }
}
```

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/metatags`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Request body parameters

The following fields need to be sent within a metatag scope (see the right panel for an example):

| Name     | Type   | Required | Description             |
| -------- | ------ | -------- | ----------------------- |
| category | String | Yes      | Category of the metatag |
| value    | String | Yes      | Value of the metatag    |

## Update a metatag

```shell
# This will update a metatag with the category new_category and value value_4.
curl -H "Authorization: ApiKey <api_key>" -X PUT --data "metatag[category]=new_category&metatag[value]=value_4" "https://api.publitas.com/v2/groups/1/metatags/3"
```

> The above command returns JSON structured like this:

```json
{
  "metatag": {
    "id": 3,
    "group_id": 1,
    "category": "new_category",
    "value": "value_4"
  }
}
```

### HTTP Request

`PUT https://api.publitas.com/v2/groups/<Group ID>/metatags/<Metatag ID>`

### URL Parameters

| Parameter  | Description                  |
| ---------- | ---------------------------- |
| Group ID   | The ID of a specific group   |
| Metatag ID | The ID of a specific metatag |

### Request body parameters

The following fields need to be sent within a metatag scope (see the right panel for an example):

| Name     | Type   | Required | Description             |
| -------- | ------ | -------- | ----------------------- |
| category | String | No       | Category of the metatag |
| value    | String | No       | Value of the metatag    |

## Delete a metatag

```shell
# This will try to delete a metatag with id 4.
curl -H "Authorization: ApiKey <api_key>" -X DELETE "https://api.publitas.com/v2/groups/1/metatags/4"
```

> The above command returns a 409 error and the following JSON if metatag is assigned to a publication:

```json
{
  "error": "Metatag is currently in use, send \"force_delete=true\" to delete anyway"
}
```

```shell
# This will delete the metatag with id 4 even if it's assigned to a publication.
curl -H "Authorization: ApiKey <api_key>" -X DELETE "https://api.publitas.com/v2/groups/1/metatags/4?force_delete=true"
```

> The above command returns a 204 with no content

### HTTP Request

`DELETE https://api.publitas.com/v2/groups/<Group ID>/metatags/<Metatag ID>`

### URL Parameters

| Parameter    | Description                                                 |
| ------------ | ----------------------------------------------------------- |
| Group ID     | The ID of a specific group                                  |
| Metatag ID   | The ID of a specific metatag                                |
| force_delete | Send "true" to override "Metatag is currently in use" error |

# Collections

## List all collections of a group

```shell
# This will retrieve all collections for a group
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/collections"
```

> The above command returns JSON structured like this:

```json
{
  "collections": [
    {
      "id": 1,
      "title": "Collection 1"
    },
    {
      "id": 2,
      "title": "Collection 2"
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/collections`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Query Parameters

See the [Pagination](#pagination) section for pagination parameters.

The JSON response returns a list of collections with the following attributes:

| Field | Type    | Description      |
| ----- | ------- | ---------------- |
| id    | Integer | Collection ID    |
| title | String  | Collection Title |

## Create a collection

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/collections`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

```shell
curl -H "Authorization: ApiKey <api_key>" --data "{
  "collection": {
    "title": "New Collection"
  }
}"
```

> The above command returns JSON structured like this:

```json
{
  "collection": {
    "id": 42,
    "title": "New Collection"
  }
}
```

### Request body parameters

The following fields need to be sent within a collection scope (see the right panel for an example):

| Name  | Type   | Required | Description      |
| ----- | ------ | -------- | ---------------- |
| title | String | Yes      | Collection Title |

# Pages

## Add pages to publication

Add pages to a publication from a PDF file

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/pages`

### URL Parameters

| Parameter      | Description                              |
| -------------- | ---------------------------------------- |
| Group ID       | ID of a group containing the publication |
| Publication ID | The ID of a publication to add pages to  |

```shell
curl --location 'https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/pages' \
--header 'Authorization: ApiKey <api_key>' \
--header 'Content-Type: application/json' \
--data '{
    "source_url": "https://some/file.pdf"
  }'
```

### Request body parameters

| Name                | Type    | Required | Description                                                                                               |
| ------------------- | ------- | -------- | --------------------------------------------------------------------------------------------------------- |
| source_url          | String  | Yes      | URL of the PDF file to upload. HTTP and HTTPS are accepted, and it needs to be a publicly accessible file |
| source_page_numbers | Array   | No       | List of page numbers in the pdf file to be added into the publication                                     |
| position            | Integer | No       | Page number where new pages should be inserted (by default add pages at the end)                          |
| extraction_options  | Object  | No       | Hotspot extraction (auto-tagging) settings, see [extraction options](#extraction-options) for details     |

### Response codes

This endpoint returns the `200` response code.

## Replace a publication page

Replace a page in a publication

### HTTP Request

`PUT https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/pages/<Page Number>`

### URL Parameters

| Parameter      | Description                                              |
| -------------- | -------------------------------------------------------- |
| Group ID       | ID of a group containing the publication                 |
| Publication ID | The ID of a publication to replace a page in             |
| Page Number    | The number of the page to be replaced in the publication |

```shell
curl --location --request PUT 'https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/pages/<Page Number>' \
--header 'Authorization: ApiKey <api_key>' \
--header 'Content-Type: application/json' \
--data '{
  "page": {
    "source_url": "https://some/file.pdf"
  }
}'
```

### Request body parameters

The following fields need to be sent within a page scope (see the right panel for an example):

| Name               | Type    | Required | Description                                                                                              |
| ------------------ | ------- | -------- | -------------------------------------------------------------------------------------------------------- |
| source_url         | String  | Yes      | URL where the PDF file resides. HTTP and HTTPS are accepted, and it needs to be a public accessible file |
| source_page_number | Integer | No       | PDF page number to be used on replace (by default page number 1 is used)                                 |
| extraction_options | Object  | No       | Hotspot extraction (auto-tagging) settings, see [extraction options](#extraction-options) for details    |
| remove_hotspots    | Boolean | No       | Remove existing hotspots on the specified page (based on page number parameter)                          |

### Response codes

This endpoint returns the `200` response code.

## Remove a publication page

### HTTP Request

`DELETE https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>/pages/<Page Number>`

```shell
curl -H "Authorization: ApiKey <api_key>" -X DELETE "https://api.publitas.com/v2/groups/1/publications/222"
```

### URL Parameters

| Parameter      | Description                                             |
| -------------- | ------------------------------------------------------- |
| Group ID       | ID of a group containing the publication                |
| Publication ID | The ID of a publication to remove a page from           |
| Page Number    | The number of the page to be removed in the publication |

### Response codes

This endpoint returns the `200` response code.

# Product Feeds

## List recent product feeds

Lists last 5 product feed imports

```shell
curl --location "http://api.publitas.com/v2/groups/1/product_feeds" --header "Authorization: ApiKey <api_key>"
```

> The above command returns a JSON document structured like this:

```json
{
  "product_feeds": [
    {
      "id": 28,
      "group_id": 1,
      "url": "http://some/feed/file.xml",
      "state": "processing",
      "success_count": 0,
      "failed_count": 0
    },
    {
      "id": 27,
      "group_id": 1,
      "url": "http://some/feed/file.xml",
      "state": "success",
      "success_count": 1891,
      "failed_count": 0
    },
    {
      "id": 26,
      "group_id": 1,
      "url": "http://some/feed/file.xml",
      "state": "failed",
      "success_count": 1,
      "failed_count": 1890
    },
    {
      "id": 25,
      "group_id": 1,
      "url": "http://some/feed/file.xml",
      "state": "success",
      "success_count": 1891,
      "failed_count": 0
    },
    {
      "id": 24,
      "group_id": 1,
      "url": "http://some/feed/file.xml",
      "state": "success",
      "success_count": 1891,
      "failed_count": 0
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/product_feeds`

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

## Create a product feed

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/product_feeds`

```shell
curl --location 'http://api.publitas.com/v2/groups/1/product_feeds' \
--header 'Authorization: ApiKey <api_key>' \
--header 'Content-Type: application/json' \
--data '{
    "product_feed": {
        "url": "http://some/feed/file.xml"
    }
}'
```

> The above command returns a JSON document structured like this:

```json
{
  "product_feed": {
    "id": 42,
    "group_id": 1,
    "url": "http://some/feed/file.xml",
    "state": "processing",
    "success_count": 0,
    "failed_count": 0
  }
}
```

### URL Parameters

| Parameter | Description                |
| --------- | -------------------------- |
| Group ID  | The ID of a specific group |

### Request body parameters

The following fields need to be sent within a product feed scope (see the right panel for an example):

| Name | Type   | Required | Description                                                                                                           |
| ---- | ------ | -------- | --------------------------------------------------------------------------------------------------------------------- |
| url  | String | Yes      | URL of the feed file to upload. HTTP, HTTPS, FTP and SFTP are accepted, and it needs to be a publicly accessible file |

# Conversions

## List last conversions

List last 5 conversions of a publication

```shell
curl --location "https://api.publitas.com/v2/groups/1/publications/222/conversions/" --header "Authorization: ApiKey <api_key>"
```

> The above command returns a JSON document structured like this:

```json
{
  "conversions": [
    {
      "id": 1404,
      "group_id": 1,
      "publication_id": 222,
      "state": "finished",
      "state_details": null,
      "source_type": "api_add_pages",
      "total_pages": 110,
      "converted_pages": 110,
      "extraction_options": null
    },
    {
      "id": 1403,
      "group_id": 1,
      "publication_id": 222,
      "state": "failed",
      "state_details": {
        "error": "Fail to download given source file: https://some/pdf/file.pdf"
      },
      "source_type": "api_add_pages",
      "total_pages": null,
      "converted_pages": 0,
      "extraction_options": null
    },
    {
      "id": 1402,
      "group_id": 1,
      "publication_id": 222,
      "state": "finished",
      "state_details": null,
      "source_type": "api_replace_page",
      "total_pages": 100,
      "converted_pages": 1,
      "extraction_options": null
    },
    {
      "id": 1401,
      "group_id": 1,
      "publication_id": 222,
      "state": "finished",
      "state_details": null,
      "source_type": "page_manager",
      "total_pages": 100,
      "converted_pages": 2,
      "extraction_options": null
    },
    {
      "id": 1400,
      "group_id": 1,
      "publication_id": 222,
      "state": "finished",
      "state_details": null,
      "source_type": "new_publication",
      "total_pages": 100,
      "converted_pages": 100,
      "extraction_options": null
    }
  ]
}
```

### URL Parameters

| Parameter      | Description                      |
| -------------- | -------------------------------- |
| Group ID       | The ID of a specific group       |
| Publication ID | The ID of a specific publication |

The JSON response returns a list of publications with the following attributes:

| Field              | Type    | Description                                                                            |
| ------------------ | ------- | -------------------------------------------------------------------------------------- |
| id                 | Integer | Conversion ID                                                                          |
| group_id           | Integer | Group ID                                                                               |
| publication_id     | Integer | Publication ID                                                                         |
| state              | String  | The conversion state (see table below for a better description)                        |
| state_details      | Object  | Additional info about conversion state (see object structure on section bellow)        |
| source_type        | String  | Action which has create the conversion                                                 |
| total_pages        | Integer | Total of pages to be processed in the conversion                                       |
| converted_pages    | Integer | Count of pages already processed in the conversion                                     |
| extraction_options | Object  | Conversion hotspots extraction settings. See [extraction options](#extraction-options) |

The `state` field can have one of the following values:

| Value      | Description                                   |
| ---------- | --------------------------------------------- |
| new        | Conversion waiting to be processed            |
| preparing  | PDF source file is being download             |
| converting | PDF pages being converted to publication page |
| finished   | Conversion process finished                   |
| canceled   | Conversion process canceled                   |
| failed     | Conversion process failed                     |

The `state_details` is object with the following attributes:

| Value | Type   | Description                                      |
| ----- | ------ | ------------------------------------------------ |
| error | String | Error message describing conversion failed state |

## Get a specific conversion

```shell
# This endpoint retrieves a specific publication conversion.
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications/222/conversion/1404"
```

> The above command returns JSON structured like this:

```json
{
  "conversion": {
    "id": 1404,
    "group_id": 1,
    "publication_id": 222,
    "state": "finished",
    "state_details": null,
    "source_type": "api_add_pages",
    "total_pages": 110,
    "converted_pages": 110,
    "extraction_options": null
  }
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>`

### URL Parameters

| Parameter      | Description                      |
| -------------- | -------------------------------- |
| Group ID       | The ID of a specific group       |
| Publication ID | The ID of a specific publication |
| Conversion ID  | The ID of a specific conversion  |

# Languages

| Name       | Code |
| ---------- | ---- |
| Basque     | eu   |
| Bulgarian  | bg   |
| Chinese    | zh   |
| Croatian   | hr   |
| Czech      | cs   |
| Danish     | da   |
| Dutch      | nl   |
| English    | en   |
| French     | fr   |
| Finnish    | fi   |
| German     | de   |
| Hungarian  | hu   |
| Italian    | it   |
| Lithuanian | lt   |
| Norwegian  | no   |
| Polish     | pl   |
| Portuguese | pt   |
| Romanian   | ro   |
| Russian    | ru   |
| Serbian    | sr   |
| Slovak     | sk   |
| Spanish    | es   |
| Swedish    | sv   |
| Turkish    | tr   |
| Ukranian   | uk   |

# Extraction Options

The following fields define options to extract hotspots from a PDF

> Extraction options field JSON object structured like this:

```json
{
  "extraction_options": {
    "links": { "icons": true },
    "products": { "icons": false }
  }
}
```

| Name     | Type   | Required | Description                                                                                                                               |
| -------- | ------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| links    | Object | No       | Extracts link hotspots for any URL, document link, and email address found in PDF file (see object definition table below)                |
| products | Object | No       | Extracts product hotspots for any SKU found in PDF file, matching product feed or product library set (see object definition table below) |

Both 'links' and 'products' allow the fields below:

| Name  | Type    | Required | Description                                                                                                                                                              |
| ----- | ------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| icons | Boolean | No       | Show or hide hotspot icons for extracted hotspot. This setting is not applicable to hotspots extracted from PDF annotations (those are defined in the annotation itself) |

# Errors

> When there is an error the command returns JSON structured like this:

```json
{
  "errors": {
    "state": ["You have reached your publication limit"]
  }
}
```

The Publitas API uses the following error codes:

| Error Code | Meaning                                                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| 402        | Payment Required -- You have reached your publishing limit                                                                           |
| 403        | Forbidden -- You requested access to a resource which you don't have permission                                                      |
| 404        | Not Found -- The path or document could not be found                                                                                 |
| 405        | Method Not Allowed -- You tried to access the API with an invalid method                                                             |
| 406        | Not Acceptable -- You requested a format that isn't json                                                                             |
| 418        | I'm a teapot                                                                                                                         |
| 422        | Unprocessable Entity -- We found validation errors on one or more fields, a detailed error message can be found in the response body |
| 500        | Internal Server Error -- We had a problem with our server. Try again later                                                           |
| 503        | Service Unavailable -- We're temporarially offline for maintenance. Please try again later                                           |
