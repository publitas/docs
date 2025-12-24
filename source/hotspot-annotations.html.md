---
title: Hotspot Annotations

language_tabs:
  - json

toc_footers:
  - <a href='../'>API Overview</a>
  - <a href='https://publitas.com'>Publitas.com</a>

search: false
---

# Hotspot Annotations

Hotspot Annotations allow you to add interactive elements to your publications during at the import time, such as links, images, videos, and product information. They enhance the user experience by providing additional context and interactivity within your digital publications.

Currently, Publitas supports the following types of hotspot annotations:

- **Product Annotations**: Link specific products from your product catalog to designated areas within your publication.
- **Image Annotations**: Add images that can be displayed when users view the publication.
- **Video Annotations**: Embed videos that can be played directly within the publication.
- **External Content Annotations**: Link to external web content, such as web pages or other online resources.

The type of the hotspot annotation is determined by the required `type` attribute in the annotation's JSON data.

## Product Annotations
Product Annotations allow you to link specific products from your product catalog to designated areas within your publication. This is particularly useful for creating interactive catalogs where users can click on products to view more details or make a purchase.

### Supported Attributes

* `type` ("product") - The type of hotspot annotation.
* `icon` (boolean) - Whether to display an icon for the product hotspot.
* `sku` (string | array) - The SKU of the product to link to. Can also be an array of SKUs for multiple products.
* `dynamic` (boolean) - Whether the product hotspot is dynamic.

```json
{
  "type": "product",
  "icon": true,
  "sku": "1234",
  "dynamic": false
}
```

## Image Annotations
Image Annotations allow you to add images that can be displayed when users view the publication. This
is useful for adding visual elements that enhance the content of your publication.

### Supported Attributes

* `type` ("image") - The type of hotspot annotation.
* `icon` (boolean) - Whether to display an icon for the image hotspot.
* `source` (string) - The URL of the image to display.
* `appearance` ("embed" | "interactive_embed" | "hotspot") - The appearance of the image hotspot.
* `altText` (boolean) - Whether to include alt text for the image.
* `altTextValue` (string) - The alt text value for the image.
* `fillMode` ("crop" | "stretch") - The fill mode for the image.


```json
{
  "type": "image",
  "icon": true,
  "source": "https://example.com/image.jpg",
  "appearance": "embed",
  "altText": true,
  "altTextValue": "An example image",
  "fillMode": "stretch"
}
```

## Video Annotations
Video Annotations allow you to embed videos that can be played directly within the publication. This is
useful for adding multimedia content that enhances the user experience.

### Supported Attributes
* `type` ("video") - The type of hotspot annotation.
* `icon` (boolean) - Whether to display an icon for the video hotspot.
* `source` (string) - The URL of the video to embed. If the source is a YouTube or Vimeo link, it will be embedded accordingly. Otherwise, the video will be treated as a direct video file link and will be downloaded.
* `appearance` ("embed" | "animatedContent" | "hotspot") - The appearance of the video hotspot.
* `showThumbnail` (boolean) - Whether to show a thumbnail for the video.
* `autoplay` (boolean) - Whether the video should autoplay when viewed (only Vimeo).
* `loop` (boolean) - Whether the video should loop when it ends.
* `showAccessibilityControls` (boolean) - Whether to show accessibility controls for the video.
* `accessibilityText` (string) - The accessibility text for the video.

```json
{
  "type": "video",
  "icon": true,
  "source": "https://example.com/video.mp4",
  "appearance": "embed",
  "showThumbnail": true,
  "autoplay": false,
  "loop": false,
  "showAccessibilityControls": true,
  "accessibilityText": "An example video"
}
```

## External Content Annotations
External Content Annotations allow you to link to external web content, such as web pages or other online resources. This is useful for providing additional context or information that is not contained within the publication itself.

### Supported Attributes
* `type` ("externalContent") - The type of hotspot annotation.
* `icon` (boolean) - Whether to display an icon for the external content hotspot.
* `source` (string) - The URL of the external content to link to.
* `maxWidth` (integer) - The maximum width of the external content when displayed.
* `maxHeight` (integer) - The maximum height of the external content when displayed.

```json
{
  "type": "externalContent",
  "icon": true,
  "source": "https://example.com",
  "maxWidth": 800,
  "maxHeight": 600
}
```
