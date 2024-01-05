class Setting < ApplicationRecord
    validates :title, presence: true
    validates :page_title, presence: true
end
