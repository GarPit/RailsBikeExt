Admin::RenderingController.class_eval do
  #remove_method :locomotive_page
  
  def locomotive_page
    path = (params[:path] || request.fullpath).clone # TODO: params[:path] is more consistent
    path = path.split('?').first # take everything before the query string or the lookup fails
    path.gsub!(/\.[a-zA-Z][a-zA-Z0-9]{2,}$/, '') # remove the page extension
    path.gsub!(/^\//, '') # remove the leading slash

    path = 'index' if path.blank?

    if path != 'index'
      dirname = File.dirname(path).gsub(/^\.$/, '') # also look for templatized page path
      additional_paths = []
      tmp_path = path.split('/')
      tmp_path.count.times do |t|
        t = t+1
        if tmp_path.count > t
          source_path = tmp_path[0..(tmp_path.count-(t+1))].join('/')
          additional_paths << File.join(source_path, ['content_type_template']*t).gsub(/^\//, '')
        end
      end
      path = [path] + additional_paths
    end

    if page = current_site.pages.any_in(:fullpath => [*path]).first
      if not page.published? and current_admin.nil?
        page = nil
      else
        if page.templatized?
          @content_instance = page.content_type.contents.where(:_slug => File.basename(path.first)).first

          if @content_instance.nil? || (!@content_instance.visible? && current_admin.nil?) # content instance not found or not visible
            page = nil
          end
        end
      end
    end

    page || not_found_page
  end
end