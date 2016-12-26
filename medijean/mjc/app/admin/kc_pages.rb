ActiveAdmin.register KcPage do

  form do |f|
    f.inputs do
      f.input :url
      f.input :title
      f.input :sort_order
      f.input :published
      f.input :html, :as => :ckeditor
    end
    f.buttons
  end

end
