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

To access the Publitas.com JavaScript API you need to inject JavaScript code into the Viewer. This can be achieved using the code injection field in your group settings. The basic usage is shown to the right. Please make sure to wrap it in a `<script>` tag when setting it in the header.

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
  api.setHomeButtonAction("http://your.custom.url", "custom title");

  // or

  api.setHomeButtonAction(function () {
    // do something here
  }, "custom title");
}
```

Using the `setHomeButtonAction(action [, title])` you can specify a custom action when the user clicks the home button in the main menu. `action` can be a url string or a function. `title` is an optional string argument, that sets the home button title.

## Custom Shopping Cart Button Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setCartButtonAction("http://your.custom.url", "custom title");

  // or

  api.setCartButtonAction(function () {
    // do something here
  }, "custom title");
}
```

Using the `setCartButtonAction(action [, title])` you can specify a custom action when the user clicks the shopping cart button in the main menu. `action` can be a url string or a function. `title` is an optional string argument, that sets the cart button title.

## Custom Product Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (products) {
    // do something here
  });
}
```

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (products, onOpen, onClose) {
    // a button that will hide your custom product view
    closeButton = ...

    // an iFrame with your custom product view
    iframe = ...

    // update the address bar once the iframe loads
    iframe.onload = onOpen;

    closeButton.addEventListener('click', function () {
      // close the product view
      onClose(); // make sure the address bar
    })
  });
}
```

Using the `setProductAction(action [, onOpen[, onClose]])` you can specify a custom action when the user clicks on a product on the Viewer. `action` needs to be a function. It will receive the an array of products that belong to the clicked hotspot as an argument. Products have the following properties:


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
| video         | Object      | Object with property 'youtubeId' if product has a YouTube video |

### `onOpen` and `onClose`

These are optional callbacks that you can evoke if you are implementing a custom product popover. The default behavior of the catalog viewer is to update the address bar URL to


*http://url.of/your/publication/product/&lt;product-id&gt;*

whenever the product view opens. This way, users can directly link to a product within the catalog and refreshing the page will leave the product view intact. If you want to keep this behavior for your custom product action, please make sure to invoke these callbacks at appropriate times. The second example to the right highlights this use case.


## Custom Product CTA

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductCtaAction(function (product) {
    // do something here
  });
}
```

Using the `setProductCtaAction(action)` you can specify a custom action when the user clicks the 'Go To Webshop' button (call to action) in the product details view. `action` needs to be a function. It will receive the corresponding product as argument (same as `setProductAction`).


## Custom Link Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setLinkAction(function (url) {
    // do something here
  });
}
```
Using the `setLinkAction(action)` you can specify a custom action when the user clicks on an external link in the Viewer. `action` needs to be a function. It will receive the original url as an argument.
