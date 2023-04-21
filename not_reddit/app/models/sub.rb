class Sub < ApplicationRecord
    validates :user_id, presence: true

    belongs_to :author,
        class_name: :User,
        foreign_key: :user_id, 
        inverse_of: :owned_subs
    has_many :posts,
        foreign_key: :sub_id,
        class_name: :Post,
        dependent: :destroy
end
