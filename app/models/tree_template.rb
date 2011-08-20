class TreeTemplate
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type=>String
  field :description
  has_and_belongs_to_many :tree_nodes
  
  ## associations ##
  referenced_in :site
  
  def templates_in_deptsh
    ret = {}
    self.tree_nodes.each do |node|
      node.depths.each do |depth|
        ret[depth] = node
      end
    end
    ret
  end
end


Site.class_eval do
  references_many :tree_templates
end