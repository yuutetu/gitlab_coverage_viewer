GitlabCoverageViewer::Engine.routes.draw do
  resources :coverage,  only: [:show], constraints: {id: /.+/}
end
