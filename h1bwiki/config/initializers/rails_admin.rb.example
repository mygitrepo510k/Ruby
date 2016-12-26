# RailsAdmin config file. Generated on December 26, 2012 10:58
# See github.com/sferik/rails_admin for more informations
  
RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.is_admin?
  end

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['H1BWIKI', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  #config.excluded_models = [Comment, Post]

  # Add models here if you want to go 'whitelist mode':
  config.included_models = [Country, JobseekerJob, JobseekerMentor, JobseekerTraining, PostJob, PostMentor, PostTraining, UploadDatabase]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end
  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions 
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
  end

  config.model SkillList do
    object_label_method :name
    configure :name, :string
    configure :created_at, :datetime 
    configure :updated_at, :datetime
    list do
      field :id
      field :name
      field :created_at
      field :updated_at
    end
    export do; end
    show do 
      field :id
      field :name
      field :created_at
      field :updated_at
    end
    update do
      field :name
    end
    create do
      field :name
    end
    edit do
      field :name
    end
  end

  config.model UploadDatabase do
    configure :data_content,:text 
    configure :table_name
    #configure :product_id, :integer         # Hidden 
    list do
      field :data_content
      field :table_name
    
    end
    export do
      field :data_content
      field :table_name

    end
    show do
      field :data_content
      field :table_name
    end
    create do
      field :table_name,:enum do
        label "Table Name"
      enum do
        ['h1bemp','h1bemp_filling','h1bemp_topjob']
      end
      end
      field :data_content
      
    end
  end
end