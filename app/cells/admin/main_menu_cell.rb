class Admin::MainMenuCell < ::Admin::MenuCell

  protected

  def build_list
    add :contents, :url => admin_pages_url
    add :engines, :url=>admin_engines_url, :scope=>'railsbike'
    add :settings, :url => edit_admin_current_site_url
  end
  
  def build_item(name, attributes)
    unless attributes.key?(:label)
      attributes[:label] = localize_label(name, attributes[:scope])
    end

    attributes.merge!(:name => name, :class => name.to_s.dasherize.downcase)
  end
  
  def localize_label(label, scope_item)
    if scope_item
      I18n.t("admin.shared.menu.#{label}", :scope => scope_item)
    else
      I18n.t("admin.shared.menu.#{label}")
    end
  end

end
