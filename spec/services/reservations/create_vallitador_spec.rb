require 'spec_helper'
require 'byebug'

RSpec.describe Reservation::CreateValidator do
  let(:user) { User.create(first_name: 'Pepito', last_name: 'Perez', id_number: '213', dob: '03/03/1986'.to_date)}
  let(:room) { Room.create(number: 1, number_of_beds: 1)}

  subject { described_class.new.call(user_id: user_id, room_id: room_id, start_date: start_date, end_date: end_date) }

  context 'when the inputs are ok' do
    let(:user_id) { user.id }
    let(:room_id) { room.id }
    let(:start_date) {  Time.current }
    let(:end_date) {  Time.current + 1.day }

    it 'should validate the params are ok' do
      expect(subject.success?).to eq true
    end
  end

  context 'when the dates are wrong'do
    let(:user_id) { user.id }
    let(:room_id) { room.id }
    let(:start_date) {  Time.current }
    let(:end_date) {'wrong-type' }

    it 'raises an error because the passed value for end_date is incorrect' do
      expect(subject.success?).to eq false
      expect(subject.errors.messages[0].text).to eq 'must be a time'
    end
  end

  context 'when the room does not exists'do
    let(:user_id) { user.id }
    let(:room_id) { 12121212 }
    let(:start_date) {  Time.current }
    let(:end_date) { Time.current + 1.day }

    it 'raises an error because the passed value for end_date is incorrect' do
      expect(subject.success?).to eq false
      expect(subject.errors.messages[0].text).to eq 'could not be found'
    end
  end
end
