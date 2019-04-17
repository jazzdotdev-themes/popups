event = ["homepage_requested"]
priority = 1
input_parameters = ["request"]

local slideshow_id = settings.slideshow
local slideshow_fields = contentdb.read_document(slideshow_id)

local slide_weights = {}

-- 
-- Popup test new implementation
-- 

-- Method to prepare a popup for the template standart 
-- @params
-- popup_id : uuid : the id of the popup
function loadpopup(popup_id)
  local popup = contentdb.read_document(popup_id)
  local popup_button = contentdb.read_document(popup.popup_button)
  popup.id = popup_id
  popup.button = popup_button
  
  return popup
end

local popup_fields = loadpopup(settings.popups.popup_id)
-- 
-- 
-- 


contentdb.walk_documents(nil, function (slide_id, fields, body)
  if fields.model == "slide" and fields.slideshow == slideshow_id then
    table.insert(slide_weights, {
      content = render("homepage-slide.html", {
        img = fields["image-address"],
        title = fields.title,
        body = body,
      }),
      weight = fields.weight or math.maxinteger,
    })
  end
end)

table.sort(slide_weights, function (a, b) return a.weight < b.weight end)
local slides = map(slide_weights, function (it) return it.content end)



local homepage = render("index.html", {
  SITE_URL = "/",
  SITENAME = settings.sitename,
  articles = {},
  slides = slides,
  popup = popup_fields,
})

return {
  status = 200,
  headers = {
    ["content-type"] = "text/html",
  },
  body = homepage
}
