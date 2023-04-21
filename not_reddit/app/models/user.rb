class User < ApplicationRecord
    attr_reader :password
    before_validation :ensure_session_token
    validates :username, :session_token, presence:true, uniqueness:true
    validates :password_digest, presence:true 
    validates :password, length:{minumum:6, allow_nil: true}

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password= password

    end

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && is_password?(password)
            @user 
        else
            nil
        end
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token || generate_session_token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token        
    end
end
