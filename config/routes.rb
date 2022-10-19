Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get '/health', to: proc { [200, {}, ['success']] }

  scope '/weather' do 
    get '/current', to: 'weather#current'

    scope '/historical' do
        get '/', to: 'weather#historical'
        get '/max' , to: 'weather#max'
        get '/min' , to: 'weather#min'
        get '/avg' , to: 'weather#avg'
        get '/by_time' , to: 'weather#by_time'
      end 
  end
  root 'weather#current'
end
