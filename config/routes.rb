Myapp::Application.routes.draw do
  resources :insurance_types do 
    resources :products
  end
  devise_for :users, :controllers => { :registrations => "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}
  get 'reports/index'

  # You can have the root of your site routed with "root"
  root to: 'users#index'

  # All routes
  get 'users/index'

  get "landing/index"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/forgot_password"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"

  resources :businesses
  resources :users , except: [:create] do
    collection do
      post 'register'
    end
  end
  
end
