require 'sinatra'
require_relative '../config/environment'
class Api < Sinatra::Base

  get '/' do
  end

  post '/reservations' do
    new_params = params == {} ? JSON.parse(request.body.read) : params
    reservation = Reservation::CreateValidator.new.call(new_params).to_monad
    .bind { |valid_params| Reservation::Create.new(valid_params.to_h).call }
    .or do |result|
        message = result.is_a?(String) ? result : result.errors.messages.map(&:to_h).join(', ')
        return [500, {}, message]
    end
    reservation.to_json
	end
end
