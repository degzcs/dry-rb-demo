class NotificationMailer
    def self.notify_room_booked(user:, reservation:)
      OpenStruct.new(deliver_later: true)
    end
end
