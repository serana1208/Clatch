class Calendar < ApplicationRecord
    #validate :error_check
    #validates :year, :filename, uniqueness: true
    validates :year, format: /[0-9]{4}/
def error_check
    unless filename.blank?
       case File.extname(filename)
       when ".pdf"
       else
        errors[:base] << '登録できる拡張子は pdf です'
       end
    end
end
end
