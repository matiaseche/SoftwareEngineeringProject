Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'welcome#index'
  get 'forum_thread/:id/follows', to: 'forum_threads#follows', as: :follows
  get 'forum_thread/:id/unfollows', to: 'forum_threads#unfollows', as: :unfollows
  get 'user/:id/mis_foros', to: 'users#mis_foros', as: :mis_foros
  get 'forum_thread/:id/forum_posts?forum_thread=:id/likes', to: 'forum_posts#likes', as: :likes
  get 'user/:id/mis_publicaciones', to: 'users#mis_publicaciones', as: :mis_publicaciones
  get 'estadisticas', to: 'estadisticas#show', as: :estadisticas
  #match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :users do
    get 'mis_publicaciones', to: 'users#mis_publicaciones', as: :mis_publicaciones
    get 'destroy', to: 'users#destroy', as: :destroy
  end

  resources :forum_threads do
    resources :requests do

      get 'aceptar', to: 'requests#aceptar', as: :aceptar
      get 'rechazar', to: 'requests#rechazar', as: :rechazar
    end

    resources :polls do
      resources :answers do
        put 'vote', to: 'answers#vote', as: :vote
      end
    end

  	resources :forum_posts do

      get 'likes', to: 'forum_posts#likes', as: :likes
      get 'favoritos', to: 'forum_posts#favoritos', as: :favoritos
      get 'sacar_favoritos', to: 'forum_posts#sacar_favoritos', as: :sacar_favoritos
      get 'dislikes', to: 'forum_posts#dislikes', as: :dislikes

      resources :comments do
        get 'likes', to: 'comments#likes', as: :likes
        get 'dislikes', to: 'comments#dislikes', as: :dislikes
      end
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
