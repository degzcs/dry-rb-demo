class User < ActiveRecord::Base
  validate_presence_of :first_name
end

