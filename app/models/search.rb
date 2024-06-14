class Search < ApplicationRecord
    validates :content, presence: true
    validates :user, presence: true
    validates :count, presence: true
end
