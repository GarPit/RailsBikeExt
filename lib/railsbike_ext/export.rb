module RailsbikeExt
  module ExportEx
    extend ActiveSupport::Concern
    
    included do
    end
    
    module InstanceMethods
      def run!
        self.initialize_site_hash

        self.log('copying assets')
        self.copy_assets

        self.log('copying theme assets')
        self.copy_theme_assets

        self.log('copying pages')
        self.copy_pages

        self.log('copying snippets')
        self.copy_snippets

        self.log('copying content types')
        self.copy_content_types

        self.log('copying config files')
        self.copy_config_files

        self.log('generating the zip file')
        self.zip_it!
      end
      
      def copy_content_types
        @site.content_types.each do |content_type|
          attributes = self.extract_attributes(content_type, %w(name description slug order_by order_direction group_by_field_name api_enabled))

          attributes['highlighted_field_name'] = content_type.highlighted_field._alias

          # custom_fields
          fields = []
          content_type.content_custom_fields.each do |field|
            field_attributes = self.extract_attributes(field, %w(label kind hint required))

            if field.target.present?
              p field
              target_klass = field['target'].constantize

              field_attributes['target'] = target_klass._parent.slug

              if field['reverse_lookup'].present?
                field_attributes['reverse'] = target_klass.custom_field_name_to_alias(field['reverse_lookup'])
              end
            end

            fields << { field._alias => field_attributes }
          end

          attributes['fields'] = fields

          @site_hash['site']['content_types'][content_type.name] = attributes.clone

          # [structure] copy it into its own file
          File.open(File.join(self.content_types_folder, "#{content_type.slug}.yml"), 'w') do |f|
            f.write(self.yaml(attributes))
          end

          # data
          data = self.extract_contents(content_type)

          # [data] copy them into their own file
          File.open(File.join(self.content_data_folder, "#{content_type.slug}.yml"), 'w') do |f|
            f.write(self.yaml(data))
          end

          @site_hash['site']['content_types'][content_type.name]['contents'] = data
        end
      end
    end
    
    module ClassMethods
    end
  end
  
end