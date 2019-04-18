# Popups Lighttouch Theme
This theme is composed of a varieties of html + css only popups 

Currently available popups:
- Announcement 
- Login Form

This was design to allow for the button that triggers the popup to have any design you want

# How to Use

Quick guide in how to use each popup

### General Aspects:

#### Behavior 
All popups will close once you click outside of them 

#### Custom Sass Variables 
You can recompile the file ```popup_styles.scss``` into the ```popup_styles.css``` with your own custom values in the ```_setting.scss``` file
The values that affect all popups are: 

| Name  | Value | Description |
| ------------- | ------------- | ------------- |
| ```$filler_z_index``` | Numeric ```1``` | z index of the shade that fills the screen once a popup is open |
| ```$popup_z_index```  | Numeric ```1```| z index any popup  |
| ```$popup_custom_shade```  | Color ```rgba(0,0,0,.5)```| Color of the custom color shade  |

and the variables of that affect each popup will be described in their respective sections

#### Using custom Color Shade 
To use a different shade just send the variable shade ```{%set shade = "dark"%}``` with any of the following string values:

| Value | Description |
| ------------- | ------------- |
| ```"dark"``` | Black Shade |
| ```"light"``` | White Shade |
| ```"custom"``` | Custom Color Shade |
| ```Null``` | No Shade/Transparent |

#### Setting up variables and Custom Button
All variables need to be reasigned to their respective names before the instance of the button that will trigger the popup and the popup itself , as seen in the example below:

```Django
  {% set popup_type = "announcement" %}

  {% set shade = "light" %}

  {% set popup_data = popups.data %}

  {% set popup_id = "my_unique_and_cool_id" %}

  <!-- Custom Button -->
  <label for="{{popup_id}}" class="bg-blue" >SHOW MY POPUP</label> 

  <!-- Popup -->
  {% include "chunks/popups_component.html" %}

```
All variables can be send as parameters by scl files and reasigned in the template for more organization , but more complex variable like ```popup_data``` should always be sended over by parameters becuase this represend HashMap objects
```
data = {
  title = "lorem",
  subtitle = "Lorem Ipsum",
  message = "Quis qui ullamco cillum magna enim qui in. Deserunt sunt laborum laboris nulla ex officia nisi eiusmod duis sunt non. Voluptate velit id ea ea et duis culpa.",
  button = "Lorem Ipsum"
}
```
All popups use the following variables

| Name  | Description |
| ------------- | ------------- |
| ```popup_id``` | Id of the popup and custom label to allow the popup to work |
| ```popup_data``` | Hash object fill with information to be display inside the popup |

## Announcement
This is a drop down popup that slides in from the top of the page.
To use this popup the popup type must be equals to ```"announcement"```
  
```{% set popup_type = "announcement" %}```

#### Variables
In the html template the popup will read the following variables

| Name  | Description |
| ------------- | ------------- |
| ```popup_data.message``` | Information to display |
| ```popup_data.button``` | Name to displayed in the button |

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

#### Variables
In the html template the popup will read the following variables

| Name  | Description |
| ------------- | ------------- |
| ```popup_data.title``` | Title of in the form , welcoming message or something else |
| ```popup_data.subtitle``` | Subtitle with information or some instructions |
| ```popup_data.button``` | Name to displayed in the button to login |


#### Custom Color Sass Variables 
| Name  | Description |
| ------------- | ------------- |
| ```$login_form__container_bg``` | Background color of the Container |
| ```$login_form__container_text``` | Text color of the Container |
| ```$login_form__button_bg``` | Background color of the login button |
| ```$login_form__button_text``` | Text color of the login button |


# New Implementation with Models
---
The popup components need a popup and popup component both of them can be created manually or with the built-in document interface at the ```/popup``` and ```/popup_button```
this url will be added automatically once the respective model files are added at ```packages/send-file-package/models/``` , this file can be found in the ```.models/``` folder in this repository

## Popup Model description (WIP)

**[OPT]:** Optional will be applied only if the component implements it

**[WIP]:** Functionally not implemented or completed yet

| Name  | Description | Values |
| ------------- | ------------- | ------------- |
| name | popup name | string |
| title | title of the popup **OPT** | string |
| subtitle | subtitle of the popup **OPT** | string |
| message | main information of the popup **OPT** | string |
| image_url | url source of the main image withing the popup | url |
| cancel_message | deny message to close the popup **OPT** | string|
| popup_button | reference to the popup button | uuid |
| shade | color of shade to use when the popup its open | "dark", "light", "custom" |
| submit_button_text | text of the button in the popup , mostly to accept or submit something | string |
| close_behaviour  | Closing behavior of the popup , the pop will always close if the main submit button is clicked.  | "shade", "exit_icon", "shade_exit_icon",  |

### Loading popup

Using this function will load the popup to work with the template standart considering that all the needed fields are available and that both the `popup` the `popup_button` have been recreated and linked correctly.

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
local popup_fields = loadpopup(popup_id)```