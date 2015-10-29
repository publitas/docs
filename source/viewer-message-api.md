---
title: Viewer Message API Reference

language_tabs:
  - javascript

toc_footers:
 - <a href='https://publitas.com'>Publitas.com</a>
 - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>
---


# Viewer Message API v1.0

This API can be used to listen to events in the Viewer, for example:

- the user navigated to a page/spread
- the user opened a product


# Getting Started

The message API uses HTML5s [window.postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage) to send messages. You can access messages sent by the Viewer in two different ways:

### Using the Code Injection Tool

```javascript
window.addEventListener('message', function(message) {
  // do something with message
})
```

The code injection tool in the [Publitas CMS](revolution.publitas.com) lets you add custom HTML tags into the header of a publication. Use a `<script>` tag to include custom javacsript code.
The viewer will post messages to its window, so we can listen to to events using `window.addEventListener`


### In Your Own Website

```javascript
// get a reference to the iFrame containing the Viewer
var viewerFrame = document.getElementById('viewer-frame-id');

window.addEventListener('message', function(message) {
  // do nothing if the message comes from a different source
  if (message.source != viewerFrame.contentWindow) {
    return;
  }

  // do something with message
}
```

If you embed the Viewer using an `<iframe>` or our embed code, the Viewer will post messages to the parent window. In _your_ website you can then also listen to message events on `window`, making the code almost identical. However, since your window can also receive other messages, you might need to ensure that it originates from the Viewer you are targeting.

<aside class='notice'>
If you have several Viewers embedded in your website, you can distinguish between them by checking the message source.
</aside>

# Message Format

## Parsing Messages

```javascript
window.addEventListener('message', function(message) {
  var event = JSON.parse(message.data);
}
```

The `message` object supplied to your event listener has a data property which is JSON encoded. You can use the standard `JSON.parse` method to decode it.

## Data Format

```javascript
window.addEventListener('message', function(message) {
  var event = JSON.parse(message.data);

  var eventType = event[0];
  var eventData = event[1];
}
```

API messages, once parsed, are an array with two elements

| Index | Type   | Description              |
|-------|--------|--------------------------|
| 0     | String | event type               |
| 1     | Object | extra event data/details |

<aside class='warning'>
  The Viewer also sends a few internal messages which do not follow this format. The code described here will not break, but `eventType` will be `undefined` and you can simply ignore those messages.
</aside>

# Events

```javascript
window.addEventListener('message', function(message) {
  var event = JSON.parse(message.data);

  var eventType = event[0];
  var eventData = event[1];

  switch (eventType) {
    case 'event type A':
      // do something with eventData
      break;
    case 'event type B'
      // do something with eventData
      break;
  }
}
```

Once you've parsed the message to get the event data, you can react on the event type in your code. Currently only one event type is supported:

## stateChange Event

```javascript
window.addEventListener('message', function(message) {
  var event = JSON.parse(message.data);

  var eventType = event[0];
  var eventData = event[1];

  switch (eventType) {
    case 'stateChange':
      reactToStateChange(eventData);
      break;
  }
}

function reactToStateChange(data) {
  data.url; // e.g. https://view.publitas.com/g/p/pages/2-3
  data.state.pages; // e.g. [2, 3]
  data.state.productId // e.g. 2431
}
```

This event is triggered whenever a user does one of two things:

- navigates to a page/spread
- clicks on a product hotspot

Thus any action in the Viewer that reveals content which has its own url.

### Event Type

The event type is the String `"stateChange"`

### Event Data

The event data is an Object in the form

| Property      | Type        | Description         |
|---------------|-------------|---------------------|
| url           | String      | the deeplink url for the new state |
| state         | Object      | the state data/details |

where the `state` Object has the form

| Property      | Type        | Description         |
|---------------|-------------|---------------------|
| pages         | Array       | an array of current page numbers |
| productId     | Number      | the id of the current product (if applicable) |
