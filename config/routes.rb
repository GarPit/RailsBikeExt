Rails.application.routes.draw do
  namespace 'admin' do
    #show engines list for each site
    match 'engines' => 'engines#index'
    resources :tree_nodes do
      get :clone, :on => :member
    end
    
    resources :tree_templates do
      get :clone, :on => :member
    end
  end
end