Dry::Validation.load_extensions(:monads)

class Reservation::CreateValidator < Dry::Validation::Contract
  params do
    required(:user_id).value(:integer)
    required(:room_id).value(:integer)
    required(:start_date).value(:time)
    required(:end_date).value(:time)
    optional(:notes).value(:string)
  end

  rule(:room_id) do
    room = Room.find_by(id: value)

    if room.present?
      values[:room] = room
    else
      key.failure('could not be found')
    end
  end

  rule(:user_id) do
    user = User.find_by(id: value)

    if user.present?
      values[:user] = user
    else
      key.failure('could not be found')
    end
  end

  rule(:end_date, :start_date) do
    key.failure('must be after start date') if values[:end_date] < values[:start_date]
  end
end
