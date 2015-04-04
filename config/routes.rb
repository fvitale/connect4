Connect4::Application.routes.draw do
  get 'games/get_board', to: 'games#get_board'
  get 'games/:id', to: 'games#show'
  put 'games/:id', to: 'games#play'

  root :to => 'games#index'
end
