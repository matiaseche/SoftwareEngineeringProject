# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
  config.cdn_url = "//cdn.ckeditor.com/4.2.4/basic/ckeditor.js"
end
