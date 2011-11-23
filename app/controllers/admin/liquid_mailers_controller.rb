module Admin
  class LiquidMailersController < BaseController
    actions :all
    sections 'engines', 'liquid_mailers'
    
    def update
      update! do |format|
        format.html {redirect_to collection_url}
      end
    end
  end
end