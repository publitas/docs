---
title: Javascript API Reference

language_tabs:
  - javascript

toc_footers:
 - <a href='https://publitas.com'>Publitas.com</a>
 - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>
---

# JavaScript API v1.0

This API can be used to customize some behaviors in the Publitas.com catalog viewer.


## Getting Started

``` javascript
window.viewerReady = function (api, platform) {
  switch(platform)
};
```

To access the Publitas.com JavaScript API you need to inject javascript code into the Viewer. This can be achieved using the custom header option in your group settings. The basic usage is shown to the right. Please make sure to wrap it in a `<script>` tag when setting it in the header.

The arguments passed to this function are

  * `api`, an object exposing the API methods
  * `platform`, a string specifying the current device category. Can be *desktop*, *tablet* or *mobile*


## Targeting Different Devices

``` javascript
window.viewerReady = function (api, platform) {
  switch (platform) {
    case "desktop":
      // desktop only customizations here
      break;
    case "tablet":
      // tablet only customizations here
      break;
    case "mobile":
      // mobile only customizations here
      break;
  }
};
```
By default, customizations are applied to all device categories. This example shows how you could use the `platform` parameter to implement different customizations depending on the device the Viewer is running on.


## Custom Home Button Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setHomeButtonAction("http://your.custom.url");

  // or

  api.setHomeButtonAction(function () {
    // do something here
  });
}
```

Using the `setHomeButtonAction(action)` you can specify a custom action when the user clicks the home button in the main menu. `action` can be a url string or a function

## Custom Product Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (product) {
    // do something here
  });
}
```

Using the `setProductAction(action)` you can specify a custom action when the user clicks on a product on the Viewer. `action` needs to be a function. It will receive the clicked product as an argument. It has the following properties:


| Field         | Type        | Description         |
| ------------- |-------------| ------------------- |
| id            | Integer     | Product id     |
| hotspotId     | Integer     | Id of the related hotspot     |
| title         | String      | Product title |
| description   | String      | Product description   |
| price         | Float       | Product price  |
| webshopIdentifier | String  | Product id from the webshop |
| webshopUrl    | String      | Direct link to the product on the webshop   |
| photos        | Array       | Array of product photos containing 0 - 6 photos   |


## Custom Product CTA

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductCtaAction(function (webshopUrl) {
    // do something here
  });
}
```

Using the `setProductCtaAction(action)` you can specify a custom action when the user clicks the 'Go To Webshop' button (call to action) in the product details view. `action` needs to be a function. It will receive the original webshop url as an argument.


## Custom Link Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setLinkAction(function (url) {
    // do something here
  });
}
```
Using the `setLinkAction(action)` you can specify a custom action when the user clicks on an external link in the Viewer. `action` needs to be a function. It will receive the original url as an argument.
