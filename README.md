# Popups Lighttouch Theme

**ATENTION: This theme is a work in progress and its functionality and documentations is susceptible to changes.**

This theme is composed of a varieties of html + css only popups

Currently available popups:

- Announcement
- Login Form
- Email Subscription

This was design to allow for the button that triggers the popup to have any design you want

## How to Use

Quick guide in how to use each popup

### General Aspects

#### Models

The popup models can be found in the ```.models/``` folder of this repository. This models must be added into the model folder of your project. This files are by default in the folder ```packages/send-file-package/models``` of the project.

#### Popup

| Name  | Description | Values | Required |
| ------------- | ------------- | ------------- | ------------- |
| id | default autogenarated id for the popup to work | uuid | :white_check_mark: |
| name | popup name for identification | string | :heavy_check_mark: |
| title | title of the popup | string | :x: |
| subtitle | subtitle of the popup | string | :x: |
| message | main information of the popup | string | :x: |
| image_url | url source of the main image withing the popup | url | :x: |
| cancel_message | deny message to close the popup | string| :x: |
| popup_button | reference to the popup button | uuid | :heavy_check_mark: |
| shade | color of shade to use when the popup its open, any not valid name will result in a transparent shade | "dark", "light", "custom" | :x: |
| custom_shade_color | A color in any valid css format, recommended to have some level of reduced opacity | string | :x: |
| submit_button_text | text of the button in the popup , mostly to accept or submit something | string | :heavy_check_mark: |
| close_behaviour  | Additional closing behavior for the popup, the popup will always close if the main submit button is clicked.  | ```"shade", "exit_icon", "shade_exit_icon"```   | :x: |

#### Popup Button

Each popup must have it's own popup button

| Name  | Description | Values | Required |
| ------------- | ------------- | ------------- | ------------- |
| id | default autogenarated id for the popup to work | uuid | :white_check_mark: |
| name | name to identify the popup | string | :heavy_check_mark: |
| text | text displayed in the button | string | :heavy_check_mark: |
| class_references | css class names to add give style for the button | string | :heavy_check_mark: |
| position | **not implemented yet** marker for the button position on the screen when the position is absolute | string | :x: |

#### Behavior

A popup behavior can be changed easily by changing the data of it without needing to change anythin within the template it is being used

##### Closing behavior

This can be changed by the ```close_behaviour``` parameter in the popup model

#### Custom Sass Variables

You can recompile the file ```popup_styles.scss``` into the ```popup_styles.css``` with your own custom values in the ```_setting.scss``` file
The values that affect all popups are:

| Name  | Value | Description |
| ------------- | ------------- | ------------- |
| ```$filler_z_index``` | Numeric ```1``` | z index of the shade that fills the screen once a popup is open |
| ```$popup_z_index```  | Numeric ```1```| z index any popup  |
| ```$popup_custom_shade```  | Color ```rgba(0,0,0,.5)```| Color of the custom color shade  |

and the variables of that affect each popup will be described in their respective sections

#### Setting up the popup

Once you have created your popup and popup model it's recomended that you load your popup in your .lua code with the following function.

Using this function will load the popup to work with the template standard considering that all the needed fields are available and that both the `popup` and the `popup_button` have been created and linked correctly.

```lua
-- Method to prepare a popup for the template standard
-- @params
-- popup_id : uuid : the id of the popup
function loadpopup(popup_id)
  local popup = contentdb.read_document(popup_id)
  local popup_button = contentdb.read_document(popup.popup_button)
  popup.id = popup_id
  popup.button = popup_button
  
  return popup
end
local popup_fields = loadpopup(popup_id)
```

#### Using the popup in the template

Once you created all the data just include the desired popup and assign the popup values.

Existing popups templates:

- ```chunks/popups_login_form.html```
- ```chunks/popups_email_subscription.html```
- ```chunks/popups_announcement.html```

Example:

```Django
  {% set popup = my_popup %}
  
  {% include "chunks/popups_login_form.html" %}
```

##### Custom styles

If you are using custom shade colors or possibly any other custom style option that might be added in the future you must add this in the head level of the template where the popup is

```html
<head>
  {% set popup = mypopup %}
  <style type="text/css">
    {% include "stylesheets/custom_popup_styles.css" %}
  </style>  
</head>
```

Example if you are using block templates like ```base_theme```.

```Django
{% block style %}
  {{ super() }} {# IMPORTANT to add the super tag #}
  
  {% set popup = mypopup %}
  <style type="text/css">
    {% include "stylesheets/custom_popup_styles.css" %}
  </style>  

{% endblock style %}
```

The only difference is that you will use the block tag insted of adding it directly in the head being way more easy to work with.

## Announcement

This is a drop down popup that slides in from the top of the page.

### Variables

In the html template the popup will read the following required variables:

- ```message```

by default the button only closes the popup

#### Custom Color Sass Variables

| Name  | Description |
| ------------- | ------------- |
| ```$announcement__container_bg``` | Background color of the Container |
| ```$announcement__container_text``` | Text color of the Container |
| ```$announcement__button_bg``` | Background color of the button |
| ```$announcement__button_text``` | Text color of the button |

## Login Form

This is popup with a circular shape , zoom in animation and a login form for users to log into your website

### Variables

In the html template the popup will read the following required variables:

- ```title```
- ```subtitle```

| Name  | Description |
| ------------- | ------------- |
| ```popup_data.title``` | Title of in the form , welcoming message or something else |
| ```popup_data.subtitle``` | Subtitle with information or some instructions |
| ```popup_data.button``` | Name to displayed in the button to login |


### Custom Color Sass Variables

| Name  | Description |
| ------------- | ------------- |
| ```$login_form__container_bg``` | Background color of the Container |
| ```$login_form__container_text``` | Text color of the Container |
| ```$login_form__button_bg``` | Background color of the login button |
| ```$login_form__button_text``` | Text color of the login button |


## Examples

You can find examples of usages of this theme in the ```.examples``` for html template implementation, in ```.content``` you can find examples of how the popup and popup_button files look like, in ```.lua_package_example``` is custom version of the ```homepage-package/actions/send_homepage.lua``` where it implements and send the popups
