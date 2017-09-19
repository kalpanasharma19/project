Rails.application.routes.draw do
  resources :products

  resources :sessions, only: [:new, :create, :destroy]

  resources :customers do
    resources :delivery_addresses, only: [:create, :destroy]
    resources :shopping_cart_items, only: [:destroy]
    resources :orders, except: [:index, :edit, :update]
  end

  get 'shopping_cart_items/show'
  post 'shopping_cart_items/:id/add' => "shopping_cart_items#add_quantity", as: "shopping_cart_item_add"
  post 'shopping_cart_items/:id/reduce' => "shopping_cart_items#reduce_quantity", as: "shopping_cart_item_reduce"
  post 'shopping_cart_items' => "shopping_cart_items#create"
  get 'orders/show'
  get 'welcome/index'
  root 'welcome#index'

end
