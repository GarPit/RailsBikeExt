class TreeNode
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type=>String
  field :depths_collection, :type=>String
  field :template
  
  has_and_belongs_to_many :tree_templates
  
  ## associations ##
  referenced_in :site
  
  def depths
    ret = []
    begin
      ret = eval("[#{self.depths_collection}]").flatten
    rescue Exception => e
        
    end
    ret
  end
end

Site.class_eval do
  references_many :tree_nodes
end