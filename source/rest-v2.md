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

### Version

Our API is currently on version 2 beta. Click [here](index.html) to see documentation for the first version of the API.

### Authentication

Our public API requires an API key, sent in the headers in the form of `'Authorization': "ApiKey <api_key>"`. Contact our [support team](mailto:support@publitas.com) to request an API key. For convenience, we also allow sending it as a `api_key` query param and sending HTTP based authorization with the `api` user and your API key as password.

### Formats

Currently we only support JSON requests.

### Paths

The base path of an API request is: `https://api.publitas.com/v2/`

An example of a complete path is:

`https://api.publitas.com/v2/groups/?api_key=<api_key>`

# Groups

```shell
# This will retrieve all the groups accessible by the user
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups"
```
> The above command returns a JSON document structured like so:

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

|       Field       |   Type  |                    Description                             |
|-------------------|---------|------------------------------------------------------------|
| id                | Integer | Group ID                                                   |
| title             | String  | Group title                                                |
| slug              | String  | Group slug                                                 |
| url               | String  | Group details URL                                          |
| publications_url  | String  | Publication list URL for the group                         |
| publication_count | Integer | Amount of publications contained within the group          |
| public_url        | String  | Group public URL (redirects to latest online publication)  |

# Publications

## List all publications of a group

```shell
# This will retrieve all publications for a group
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications"
```
> The above command returns JSON structured like this:

``` json
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
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "metatag_ids": [1, 2],
      "valid_from": null,
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
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": "2014-09-25T15:17:20.000+02:00",
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/autumn-2014",
      "metatag_ids": [2, 3],
      "valid_from": "2014-09-26"
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/publications`

### URL Parameters

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group


The JSON response returns a list of publications with the following attributes:

|        Field        |   Type   |                           Description                                         |
|---------------------|----------|-------------------------------------------------------------------------------|
| id                  | Integer  | Publication ID                                                                |
| title               | String   | Publication Title                                                             |
| browser_title       | String   | SEO title                                                                     |
| description         | String   | SEO description                                                               |
| slug                | String   | Publication Slug                                                              |
| url                 | String   | Publication details URL                                                       |
| cover_url           | String   | URL for the cover image (@800 resolution)                                     |
| page_count          | Integer  | Number of pages in the publication                                            |
| state               | String   | The publication state (see table below for a better description)              |
| online_at           | DateTime | Time at which the publication was last set online                             |
| offline_at          | DateTime | Time at which the publication was last set offline                            |
| schedule_online_at  | DateTime | Time at which the publication is scheduled to go online                       |
| schedule_offline_at | DateTime | Time at which the publication is scheduled to go offline                      |
| public_url          | String   | Publication public URL or `null` when the publication is still converting.    |
| metatag_ids         | Array    | List of metatag IDs assigned to the publication                               |
| valid_from          | Date     | Date when publication become valid

The `state` field can have one of the following values:

|    Value    |                        Description                     |
|-------------|--------------------------------------------------------|
| offline     | Publication is not publicly visible.                   |
| online      | Publication is publicly visible.                       |

## Get a specific publication

```shell
# This endpoint retrieves a specific publication.
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/publications/222"
```
> The above command returns JSON structured like this:

``` json
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
      "state": "offline",
      "online_at": null,
      "offline_at": null,
      "schedule_online_at": null,
      "schedule_offline_at": null,
      "public_url": "https://view.publitas.com/example-group/spring-2014",
      "metatag_ids": [2, 3],
      "valid_from": null
    }
  ]
}
```

### HTTP Request

`GET https://api.publitas.com/v2/groups/<Group ID>/publications/<Publication ID>`

### URL Parameters

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group
Publication ID | The ID of a specific publication


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

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group


### Request body parameters

The following fields need to be sent within a publication scope (see right for an example.)

|         Name        |   Type   | Required |                                                                               Description                                                                |
|---------------------|----------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| source_url          | String   | Yes      | URL where the PDF file resides. HTTP and HTTPS are accepted, and it needs to be a public accessible file.                                                |
| title               | String   | Yes      | The title for the publication                                                                                                                            |
| browser_title       | String   | No       | The SEO title for the publication                                                                                                                        |
| description         | String   | No       | The SEO description for the publication                                                                                                                  |
| language            | String   | No       | 2-digit language code. See [the language table](#languages) below for allowed values                                                                     |
| schedule_online_at  | DateTime | No       | Time at which the publication is scheduled to be online. If the current time is provided, the publication will be put online as soon as it is converted  |
| schedule_offline_at | DateTime | No       | Time at which the publication is scheduled to be offline                                                                                                 |
| metatag_ids         | Array    | No       | List of metatag IDs you want to assign to the publication                                                                                                |
| metatags_category   | String   | No       | Assigns all metatags in that category to the publication. This can be sent in combination with metatag_ids                                               |
| valid_from          | Date     | No       | Date when publication become valid (requires validity date feature enabled)

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

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group
Publication ID | The ID of a specific publication


### Request body parameters

The following fields need to be sent within a publication scope (see right for an example.)

|         Name        |   Type   | Required |                                                               Description                                                                     |
|---------------------|----------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| browser_title       | String   | No       | The SEO title for the publication                                                                                                             |
| description         | String   | No       | The SEO description for the publication                                                                                                       |
| metatag_ids         | Array    | No       | List of metatag IDs you want to assign to the publication. This replaces current assignments (sending an empty array will clear assignments). |
| metatags_category   | String   | No       | Assigns all metatags in that category to the publication. This can be sent in combination with metatag_ids                                    |
| valid_from          | Date     | No       | Date when publication become valid (requires validity date feature enabled)

## Mark a publication as online

```shell
# This endpoint marks a publication as being online.
curl -H "Authorization: ApiKey <api_key>" -X POST "https://api.publitas.com/v2/groups/1/publications/222/online"
```

> When the response code is 200 the command returns JSON structured like this:

``` json
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
|------|---------------------------------------- |
| 200  | Publication is online                   |
| 402  | You have reached your publishing limit. |

## Mark a publication as offline

```shell
# This endpoint marks a publication as being offline.
curl -H "Authorization: ApiKey <api_key>" -X POST "https://api.publitas.com/v2/groups/1/publications/222/offline"
```

> The above command returns JSON structured like this:

``` json
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

# Metatags

## List all metatags of a group

```shell
# This will retrieve all metatags for a group
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/metatags"
```
> The above command returns JSON structured like this:

``` json
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

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group


The JSON response returns a list of metatags with the following attributes:

|      Field    |   Type   |            Description               |
|---------------|----------|--------------------------------------|
| id            | Integer  | Publication ID                       |
| group_id      | Integer  | Group ID                             |
| category      | String   | Metatag category                     |
| value         | String   | Metatag value                        |


## Get a specific metatag

```shell
# This endpoint retrieves a specific metatag.
curl -H "Authorization: ApiKey <api_key>" "https://api.publitas.com/v2/groups/1/metatags/222"
```
> The above command returns JSON structured like this:

``` json
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

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group
Metatag ID | The ID of a specific metatag


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
    "group_id":  1,
    "category": "category_3",
    "value": "value_3"
  }
}
```

### HTTP Request

`POST https://api.publitas.com/v2/groups/<Group ID>/metatags`

### URL Parameters

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group


### Request body parameters

The following fields need to be sent within a metatag scope (see right for an example.)

|         Name        |   Type   | Required |                  Description                 |
|---------------------|----------|----------|----------------------------------------------|
| category            | String   | Yes      | Category of the metatag                      |
| value               | String   | Yes      | Value of the metatag                         |

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

Parameter | Description
--------- | -----------
Group ID | The ID of a specific group
Metatag ID | The ID of a specific metatag


### Request body parameters

The following fields need to be sent within a metatag scope (see right for an example.)

|         Name        |   Type   | Required |            Description             |
|---------------------|----------|----------|------------------------------------|
| category            | String   | No       | Category of the metatag            |
| value               | String   | No       | Value of the metatag               |

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

|    Parameter    |                        Description                          |
|---------------- | ------------------------------------------------------------|
| Group ID        | The ID of a specific group                                  |
| Metatag ID      | The ID of a specific metatag                                |
| force_delete    | Send “true” to override “Metatag is currently in use” error |

# Languages

|    Name    | Code |
|------------|------|
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

# Errors

> When there is an error the command returns JSON structured like this:

``` json
{
  "errors": {
    "state": [
        "You have reached your publication limit"
    ]
  }
}
```

The Publitas API uses the following error codes:

| Error Code |                                          Meaning                                                                                     |
|------------|--------------------------------------------------------------------------------------------------------------------------------------|
|        402 | Payment Required -- You have reached your publishing limit                                                                           |
|        404 | Not Found -- The path or document could not be found                                                                                 |
|        405 | Method Not Allowed -- You tried to access the API with an invalid method                                                             |
|        406 | Not Acceptable -- You requested a format that isn't json                                                                             |
|        418 | I'm a teapot                                                                                                                         |
|        422 | Unprocessable Entity -- We found validation errors on one or more fields, a detailed error message can be found in the response body |
|        500 | Internal Server Error -- We had a problem with our server. Try again later                                                           |
|        503 | Service Unavailable -- We're temporarially offline for maintenance. Please try again later                                           |
