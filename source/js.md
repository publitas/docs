---
title: Viewer API Reference

language_tabs:
  - javascript

toc_footers:
 - <a href='https://publitas.com'>Publitas.com</a>
 - <a href='http://github.com/tripit/slate'>Powered by Slate</a>
---

# Viewer JavaScript API v1

This API can be used to customize some behaviors in the Publitas.com Viewer.


# Getting Started

``` javascript
window.viewerReady = function (api, platform) {
  switch(platform)
};
```

To access the Publitas.com JavaScript API you need to inject JavaScript code into the Viewer. This can be achieved using the code injection field in your group or publication settings. The basic usage is shown to the right. Please make sure to wrap it in a `<script>` tag when setting it in the header.

The arguments passed to this function are

  * `api`, an object exposing API properties and methods
  * `platform`, a string specifying the current device category. Can be *desktop*, *tablet* or *mobile*


# Targeting Different Devices

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

## Getting basic publication information

``` javascript
window.viewerReady = function (api, platform) {
  var publication = api.publication;

 /*
  * Assuming your publication url is:
  * https://view.publitas.com/my-group/my-publication/
  */
  publication.slug; // 'my-publication'
  publication.groupSlug; // 'my-group'
}
```

The `api.publication` property exposes information of the current publication. It contains the following properties:

| Property      | Type        | Description         |
| ------------- |-------------| ------------------- |
| slug          | String      | publication identifier |
| groupSlug     | String      | unique group identifier  |

The `slug` and `groupSlug` properties are the building blocks of publication URLs, which have the structure:

*https://view.publitas.com/groupSlug/slug/*

They can be used to construct a unique identifier for the current publication
(e.g. to be used for custom analytics tracking).

Note that several publications can have the same slug as long as they are from different groups. 
To ensure to get a unique identifier for your publication,
use both the group and the publication slug.

<aside class="notice">
If you have a custom domain configured,
your URLs will have the structure:

*http(s)://your-custom.domain/slug*

Using just the publication slug might be sufficient if you are doing tracking per domain.
</aside>

# API Methods

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

Using the `setHomeButtonAction(action [, title])` you can specify a custom action when the user clicks the home button in the main menu. `action` can be a URL string or a function. `title` is an optional string argument, that sets the home button title.

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

Using the `setCartButtonAction(action [, title])` you can specify a custom action when the user clicks the shopping cart button in the main menu. `action` can be a URL string or a function. `title` is an optional string argument, that sets the cart button title.

## Updating the shopping cart icon

``` javascript
api.cartContentChanged({ numItems: <num-items> })
```

The shopping cart icon can display the number of items currently in the cart, using the cartContentChange method.

The appearance of the shopping cart icon will change from 'empty' to 'full' if there are more than 0 items in the cart. To change the cart to empty again, set numItems to 0.


### Updating the shopping cart from an iframe

``` javascript
parent.postMessage( JSON.stringify(['cartContentChanged', {
  numItems: numItems
}]), "*");

```

If you use an iframe (check [the section](#showing-external-content-in-an-iframe) on iframes) and you need to update the shopping cart icon from within the iframed content, you can use the `postMessage` as shown to the left.


The message consists of an array, but because IE 8 & 9 only support sending string messages, it needs to be serialized using `JSON.stringify`.

The second parameter to postMessage controls the target origin the parent window should have to receive the message. Using `"*"` is a good default, but you can implement a more restrictive policy. Check [the postMessage documentation](https://developer.mozilla.org/en-US/docs/Web/API/Window.postMessage) for more details.

## Showing external content in an iframe

``` javascript

var options = {
  width: '800px',
  background: '#ffffff'
};

api.showExternalContent('http://some.url', options);
```

Using the `showExternalContent(url [, options])`  method, you can display custom content in a popover (or sliding panel on mobile). This is commonly used for showing a custom product details page in combination with setProductAction described below.

The first parameter is a URL string and the second an optional object with options. Supported options are

  * `width`, a css string to set the width of the iframe. Default is different per device category:
    * *desktop* : `'800px'`
    * *tablet*  : `'720px'`
    * *mobile*  : `'100%'` (cannot be overruled)
  * `background`, a css string to set the background color of the popover. You can use this to match the background color of your content. Default is `'#ffffff'`


### callbacks

``` javascript
var content = api.showExternalContent('http://some.url');

content.on('close', function () {
  // do something when the iframe closes
});
```

`showExternalContent` returns a proxy on which you can register event listeners. The only supported event at the moment is `close` which gets triggered whenever the user closes the iframe. The syntax is shown in the second example on the right. For a full use case, check the next section on setting custom product actions.


## Custom Product Action

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (products) {
    // do something here
  });
}
```


Using the `setProductAction(action [, onOpen[, onClose[, callOriginal[, index]]]])` you can specify a custom action when the user clicks on a product on the Viewer. `action` needs to be a function. It will receive the an array of products that belong to the clicked hotspot as an argument. Products have the following properties:


| Property      | Type        | Description         |
| ------------- |-------------| ------------------- |
| id            | Integer     | Product id     |
| hotspotId     | Integer     | Id of the related hotspot     |
| title         | String      | Product title |
| description   | String      | Product description   |
| price         | Float       | Product price  |
| discountedPrice | Float       | Product price with discount |
| webshopIdentifier | String  | Product id from the webshop |
| webshopUrl    | String      | Direct link to the product on the webshop   |
| photos        | Array       | Array of product photos containing 0 - 6 photos   |
| video         | Object      | Object with property 'youtubeId' if product has a YouTube video |

### `onOpen` and `onClose`

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (products, onOpen, onClose) {
    var url = ...; // create a URL based on products

    onOpen(); // update the address bar and browser title

    // show custom product page
    api.showExternalContent(url, {width: '600px'})
      // revert the address bar and browser title once iframe is closed
      .on('close', onClose);
  });
}
```

These are optional callbacks that you can evoke if you are implementing a custom product popover. The default behavior of the catalog viewer is to update the address bar URL to


*http://url.of/your/publication/product/&lt;product-id&gt;*

whenever the product view opens. This way, users can directly link to a product within the catalog and refreshing the page will leave the product view intact. If you want to keep this behavior for your custom product action, please make sure to invoke these callbacks at appropriate times. The second example to the right highlights this use case.


### `callOriginal` and `index`

``` javascript
window.viewerReady = function (api, platform) {
  api.setProductAction(function (products, _o, _c, callOriginal, index) {
    console.log('product viewed', products[index]);
    callOriginal();
  });
}
```

The fifth param provides the index of the current product within the product array. It is used to identify which product was clicked in a multi product hotspot.


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
Using the `setLinkAction(action)` you can specify a custom action when the user clicks on an external link in the Viewer. `action` needs to be a function. It will receive the original URL as an argument.


## Custom Menu Item

``` javascript
window.viewerReady = function (api, platform) {
  api.addMenuItem({
    name: 'custom_item_1',
    title: 'Custom Title 1',
    iconUrl: 'https://icons.com/b7803b.jpg',
    action: function(){ 
      // do something here 
    },
    order: 2,
  });
}
```
Using the `addMenuItem(object)` you can add a custom item into the main menu. `item` needs to be an object. `name` is a unique identifier in case you need to address it for further actions (for instance, custom styling it). `title` sets item title. `iconUrl` is the source of the icon displayed for item, may be external url or image data. `action` could be a function as well as an external url (to keep compatibility among all browsers, we recommend not using arrow functions). `order` is a number indicating item's position starting from the top of the main menu, regardless of the amount of items being displayed for a specific publication. It is the only optional parameter, when it's not defined, item will be pushed to bottom of main menu.