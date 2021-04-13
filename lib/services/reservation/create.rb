require 'dry/monads'

class Reservation::Create
  include Dry::Monads[:result]
  include Dry::Monads[:try]
  include Dry.Types
  extend Dry::Initializer

  option :user, type: Instance(User), reader: :private
  option :room, type: Instance(Room), reader: :private
  option :start_date, type: Strict::Time, reader: :private
  option :end_date, type: Strict::Time, reader: :private
  option :notes, type: Strict::String, reader: :private, optional: true

  def call
    check_if_room_available
      .bind { create_reservation }
      .bind(method(:send_notification))
  end

  private

  attr_reader :user, :room, :start_date, :end_date, :notes

  def check_if_room_available
    Try(ActiveRecord::ActiveRecordError) { existing_reservations.exists? }.to_result.bind do |result|
      if result
        Failure('The room is not available in requested time range')
      else
        Success(nil)
      end
    end
  end

  def create_reservation
    reservation = Reservation.new(
      user: user, room: room, start_date: start_date, end_date: end_date, notes: notes
    )

    if reservation.save
      Success(reservation: reservation)
    else
      Failure('The reservation could not be created')
    end
  end

  def send_notification(reservation:)
    NotificationMailer
      .notify_room_booked(user: user, reservation: reservation)
      .deliver_later

    Success(reservation)
  end

  def existing_reservations
    Reservation.where(room: room, start_date: start_date, end_date: end_date)
  end
end
