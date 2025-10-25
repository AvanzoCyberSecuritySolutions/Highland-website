import 'dart:html' as html;

void updateSeoMeta({
  required String title,
  required String description,
  String? image,
  String? url,
}) {
  html.document.title = title;

  html.MetaElement? descTag = html.document.head
      ?.querySelector('meta[name="description"]') as html.MetaElement?;
  if (descTag == null) {
    descTag = html.MetaElement()..name = 'description';
    html.document.head?.append(descTag);
  }
  descTag.content = description;

  void setOgTag(String property, String content) {
    html.MetaElement? tag = html.document.head
        ?.querySelector('meta[property="$property"]') as html.MetaElement?;
    if (tag == null) {
      tag = html.MetaElement()..setAttribute('property', property);
      html.document.head?.append(tag);
    }
    tag.content = content;
  }

  setOgTag('og:title', title);
  setOgTag('og:description', description);
  if (image != null) setOgTag('og:image', image);
  if (url != null) setOgTag('og:url', url);

  void setTwitterTag(String name, String content) {
    html.MetaElement? tag = html.document.head
        ?.querySelector('meta[name="$name"]') as html.MetaElement?;
    if (tag == null) {
      tag = html.MetaElement()..name = name;
      html.document.head?.append(tag);
    }
    tag.content = content;
  }

  setTwitterTag(
      'twitter:card', image != null ? 'summary_large_image' : 'summary');
  setTwitterTag('twitter:title', title);
  setTwitterTag('twitter:description', description);
  if (image != null) setTwitterTag('twitter:image', image);
}
