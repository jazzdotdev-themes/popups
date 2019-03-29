# Popups Lighttouch Theme
this theme is composed of a varieties of popups 

Currently available popups:
- Announcement 

Example of implementation:
In scl file
```
announcement_info = {
  message = "Quis qui ullamco cillum magna enim qui in.",
  button = "Lorem Ipsum"
}
```
In html template
```
  {% set popup_type = "announcement" %}

  {% set popup_announcement = announcement_info %}
  {% set shade = "light" %}

  {% set popup_id = "my_unique_and_cool_id" %}

  <label for="{{popup_id}}" class="bg-blue" >SHOW MY POPUP</label>
  {% include "chunks/popups_component.html" %}

```
This design allows for the button that triggers the popup to have any design you want