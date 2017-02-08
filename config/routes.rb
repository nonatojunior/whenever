Rails.application.routes.draw do
	root to: 'arquivos#index'
  get 'arquivos/index'
  post 'arquivos/upload_arquivo'
  post 'arquivos/download_arquivo'
end
