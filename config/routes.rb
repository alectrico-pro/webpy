Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'product_index#index'

  get 'webpayplus/create', to: 'webpay#create'
  post 'webpayplus/create', to: 'webpay#send_create'
  post '/webpayplus/return_url', to: 'webpay#commit'
  post '/webpayplus/refund', to: 'webpay#refund'
  get '/webpayplus/status/:token', to: 'webpay#status'

  get 'webpayplus/diferido/create', to: 'webpay_deferred#create'
  post 'webpayplus/diferido/create', to: 'webpay_deferred#send_create'
  post 'webpayplus/diferido/return_url', to: 'webpay_deferred#commit'
  post 'webpayplus/diferido/capture', to: 'webpay_deferred#capture'
  get 'webpayplus/diferido/status/:token', to: 'webpay_deferred#status'
  post "/webpayplus/diferido/refund", to: 'webpay_deferred#refund'

  get '/webpayplus/mall/create', to: 'webpay#mall_create'
  post '/webpayplus/mall/create', to: 'webpay#send_mall_create'
  post '/webpayplus/mall/return_url', to: 'webpay#mall_commit'
  get '/webpayplus/mall/status/:token', to: 'webpay#mall_status'
  post '/webpayplus/mall/refund', to: 'webpay#mall_refund'
end
