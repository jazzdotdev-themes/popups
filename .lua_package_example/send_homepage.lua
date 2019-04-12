event = ["homepage_requested"]
priority = 1
input_parameters = ["request"]

local slideshow_id = settings.slideshow
local slideshow_fields = contentdb.read_document(slideshow_id)

local slide_weights = {}

-- 
-- Popup test new implementation
-- 
local popup_id = settings.popups.popup_id

local popup_fields = contentdb.read_document(popup_id)

local popup_button_id = settings.popups.popup_button_id
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
  -- popups = settings.popups,
})

return {
  status = 200,
  headers = {
    ["content-type"] = "text/html",
  },
  body = homepage
}
