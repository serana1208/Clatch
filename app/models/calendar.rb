class Calendar < ApplicationRecord
    #validates :year, :filename, uniqueness: true
    validates :year, format: /[0-9]{4}/
end
