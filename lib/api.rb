require 'sinatra'
require_relative '../config/environment'
class Api < Sinatra::Base

  get '/' do
  end

  post '/reservations' do
    Reservation::CreateValidator.new.call(params).to_monad
    .bind { |valid_params| Reservation::Create.new(valid_params.to_h).call }
    .or do |result|
        [500, {}, result.errors.messages.map(&:to_h).join(', ')]
    end
	end
end
