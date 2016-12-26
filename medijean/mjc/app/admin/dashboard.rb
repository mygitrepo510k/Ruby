ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    section "Recently updated content" do
      table_for Version.order('id desc').limit(10) do
        # column "Item" do |v| link_to(v.item.present? ? v.item.label : "Deleted", v.item) end
        column "item id" do |v|
          v.item_id
        end
        
        column "Type" do |v| v.item_type.underscore.humanize end
        column "Event" do |v|
          v.event
        end
        column "Description" do |v|
          item = v.item
          if item.present?
            type = item.class.name
            method_name = "admin_#{type.downcase}_path"
            link_to item.to_s, send(method_name, item)
          else
            item = v.reify if item.blank?
            if item.present?
              item.to_s
            else
              "Created"
            end
          end
        end
        column "Data" do |v| v.object end
        column "Modified at" do |v| v.created_at.to_s :long end
        column "Admin" do |v| 
          link_to AdminUser.find(v.whodunnit).email, admin_admin_user_path(AdminUser.find(v.whodunnit)) if v.whodunnit.present?
        end
      end
    end
  end # content
end
