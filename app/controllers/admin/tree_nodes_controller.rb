module Admin
  class TreeNodesController < BaseController
    actions :all
    sections 'engines', 'tree_nodes'
    
    def create
      create! do |format|
        format.html {redirect_to collection_url}
      end
    end
    
    def update
      update! do |format|
        format.html {redirect_to collection_url}
      end
    end
    
    def clone
      resource.clone.to_a.each{|n| n.name = "copy_"+n.name}.first.save unless resource.blank?
      redirect_to collection_url
    end
  end
end