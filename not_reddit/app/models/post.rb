class Post < ApplicationRecord
    validates :title, :user_id, presence: true
    belongs_to :sub,
        foreign_key: :sub_id,
        class_name: :Sub,
        inverse_of: :posts

    belongs_to :user,
        class_name: :User,
        foreign_key: :user_id,
        inverse_of: :posts
end
