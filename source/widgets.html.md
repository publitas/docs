---
title: Widgets Reference

language_tabs:
  - html

toc_footers:
  - <a href='../'>API Overview</a>
  - <a href='https://publitas.com'>Publitas.com</a>
---

# Publitas Widgets

Publitas Widgets are embeddable [web components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components) that let you render an affiliate's content directly inside your own website.

Each widget is distributed as a small SDK script. Once that script is on the page, the widget becomes available as a regular HTML tag — no build step, no framework, and no bundler required. All widget tags use the `pw-` prefix.

This documentation describes the widgets we currently offer, how to load them, and the attributes they accept.

## Available widgets

| Widget                               | Tag                 | Description                                    |
| ------------------------------------ | ------------------- | ---------------------------------------------- |
| [Publications](#publications-widget) | `<pw-publications>` | Renders the publications of a given affiliate. |

<aside class='notice'>
Widgets are enabled per affiliate. If a widget is not available for the affiliate you are integrating with, please reach out to our team and we will get it enabled for you.
</aside>

# Publications Widget

The Publications widget renders an affiliate's publications on your page.

## Loading the SDK

```html
<script defer src="https://<affiliate-url>/widgets/v1/publications-sdk.js"></script>
```

The SDK is served from the affiliate's own domain:

`https://<affiliate-url>/widgets/v1/publications-sdk.js`

Replace `<affiliate-url>` with the affiliate you are integrating with.

## Embedding the widget

```html
<pw-publications></pw-publications>
```

With the SDK loaded, add the `<pw-publications>` tag anywhere in your markup. The widget renders itself in place.

A complete, copy‑and‑paste ready page looks like this:

```html
<!doctype html>
<html>
  <head>
    <script defer src="https://<affiliate-url>/widgets/v1/publications-sdk.js"></script>
  </head>
  <body>
    <pw-publications></pw-publications>
  </body>
</html>
```

## Sizing

```html
<!-- on the element itself -->
<pw-publications style="--pw-height: 600px"></pw-publications>

<!-- or from a stylesheet -->
<style>
  pw-publications {
    --pw-height: 600px;
  }
</style>
```

The widget is **400px** tall by default. Override that with the `--pw-height` custom property, either inline on the tag or from your own stylesheet. Because custom properties inherit, you can also set it on any ancestor element to apply it to every widget inside.

# Playground

Paste the full URL of the SDK you want to test against and press **Reload**. The preview below loads that script and renders a `<pw-publications>` tag inside an iframe.

<div class="widget-playground">
  <label class="widget-playground__label" for="pw-playground-url">SDK URL</label>
  <div class="widget-playground__controls">
    <input class="widget-playground__input" id="pw-playground-url" type="url" placeholder="https://affiliate.example.com/widgets/v1/publications-sdk.js" autocomplete="off" spellcheck="false">
    <button class="widget-playground__button" id="pw-playground-reload" type="button">Reload</button>
  </div>
  <p class="widget-playground__hint">Tip: you can pre-fill this field by adding <code>?sdk-url=https://affiliate.example.com/widgets/v1/publications-sdk.js</code> to the address of this page.</p>
  <iframe class="widget-playground__frame" id="pw-playground-frame" title="Publications widget preview" loading="lazy"></iframe>
</div>

<script>
  (function () {
    var PARAM = 'sdk-url';
    var input = document.getElementById('pw-playground-url');
    var button = document.getElementById('pw-playground-reload');
    var frame = document.getElementById('pw-playground-frame');

    function documentFor(url) {
      return `<!doctype html>
        <meta charset="utf-8">
        <script defer src="${url}"><\/script>
        <pw-publications></pw-publications>
      `;
    }

    function render() {
      var url = input.value.trim();
      if (!url) {
        frame.removeAttribute('srcdoc');
        return;
      }
      frame.removeAttribute('srcdoc');
      frame.setAttribute('srcdoc', documentFor(url));
    }

    button.addEventListener('click', render);

    input.value = new URL(window.location.href).searchParams.get(PARAM) || '';
    if (input.value) render();
  })();
</script>
