require 'spec_helper'

RSpec.describe 'POST /resevations', type: :request do
  let(:app) { Api.new }
  let(:response) { post '/reservations', params }

  let(:user) { User.create(first_name: 'Pepito', last_name: 'Perez', id_number: '213', dob: '03/03/1986'.to_date)}
  let(:room) { Room.create(number: 1, number_of_beds: 1)}
  let(:user_id) { user.id }
  let(:room_id) { room.id }
  let(:start_date) {  Time.current }
  let(:end_date) {  Time.current + 1.day }


  let(:params) do
    {
      user_id: user_id,
      room_id: room_id,
      start_date: start_date,
      end_date: end_date
    }
  end

  it 'should be 200 OK' do
    expect(response.status).to eq 200
  end

  context 'wrong params' do
  let(:end_date) { 'wrong-date' }
    it 'should be 500 error' do
      expect(response.status).to eq 500
      expect(response.body).to eq "{:end_date=>[\"must be a time\"]}"
    end
  end
end
