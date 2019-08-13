Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get    '/login' => 'session#new', as: "login"
  post   '/login' => 'session#create', as: "login_create"
  delete '/logout' => 'session#destroy', as: "logout"
  post "contact_us" => "home#contact_us", as: "save_contact_us"
  get 'tentang-kompor-induksi' => 'home#kompor_induksi', as: "kompor_induksi"

  get "admin" => "admin/dashboard#index", as: "admin"
  namespace :admin do
    resources :banners
    resources :categories
    resources :products do
      member do
        resources :product_images, except: [:index], param: :product_image_id
      end
    end
  end

  root to: "home#index"
end
