require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class Users < ActiveRecord::Base
    has_secure_password
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, format: {
        with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/, 
        message: "must include both letters and numbers" 
    }
end