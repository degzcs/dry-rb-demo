require 'spec_helper'
require 'byebug'

RSpec.describe Reservation::Create do
  let(:user) { User.create(first_name: 'Pepito', last_name: 'Perez', id_number: '213', dob: '03/03/1986'.to_date)}
  let(:room) { Room.create(number: 1, number_of_beds: 1)}

  subject { described_class.new(user: user, room: room, start_date: start_date, end_date: end_date) }

  context 'when the inputs are ok' do
    let(:start_date) {  Time.current }
    let(:end_date) {  Time.current + 1.day }

    it 'should create a reservation successfully' do
      result = subject.call
      expect(result.success?).to eq true
      result.success do |res|
        expect(res).to be_a Reservation
      end
    end
  end

  context 'when the dates are wrong'do
    let(:start_date) {  Time.current }
    let(:end_date) {'wrong-type' }

    it 'raises an error' do
      expect{ subject.call }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
