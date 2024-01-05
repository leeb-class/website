class Page < ApplicationRecord
    validates :title, presence: true
    validates :url, uniqueness: true
    validates :order, uniqueness: true, 
        numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
