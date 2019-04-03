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

# How to Use

Quick guide in how to use each popup

### General Aspects:

#### Behavior 
All popups will close once you click outside of them 

#### Custom Sass Variables 
You can recompile the file ```popup_styles.scss``` into the ```popup_styles.css``` with your custom values in the ```_setting.scss``` file
The values that affect all popups are: 

| Name  | Value | Description |
| ------------- | ------------- | ------------- |
| ```$filler_z_index``` | Numeric ```1``` | z index of the shade that fills the screen once a popup is open |
| ```$popup_z_index```  | Numeric ```1```| z index any popup  |
| ```$popup_custom_shade```  | Color ```rgba(0,0,0,.5)```| Color of the custom color shade  |

#### Using custom Color Shade 
To use a different shade just send the variable shade ```{%set shade = "dark"%}``` with any of the following string values:

| Value | Description |
| ------------- | ------------- |
| ```"dark"``` | Black Shade |
| ```"light"``` | White Shade |
| ```"custom"``` | Custom Color Shade |
| ```Null``` | No Shade/Transparent |
## Announcement
This is a drop down popup that slides in from the top of the page

#### Variables
In the html template the popup will read the following variables

| Name  | Description |
| ------------- | ------------- |
| ```popup_data.message``` | Information to display |
| ```popup_data.message``` | Name to displayed in the button |

by default the button only closes the popup
#### Custom Color Sass Variables 
| Name  | Description |
| ------------- | ------------- |
| ```$announcement__container_bg``` | Container Background Color |
| ```$announcement__container_text``` | Container Text Color |
| ```$announcement__button_bg``` | Button Background Color |
| ```$announcement__button_text``` | Button Text Color |
