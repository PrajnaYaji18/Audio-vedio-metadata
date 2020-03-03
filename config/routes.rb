Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
	  resources :accounts do
	    resources :medias
	  end
	end
  end
end
