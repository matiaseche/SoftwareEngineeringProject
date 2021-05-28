# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  devise :omniauthable, omniauth_providers: [:facebook]

  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :username, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }

  has_many :forum_threads, dependent: :destroy
  has_many :forum_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :polls, dependent: :destroy

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100#' },
                             default_url: ':style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_liker
  acts_as_follower
  acts_as_voter

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where([
                                'lower(username) =
                                 :value OR lower(email) = :value', {
                                   value: login.downcase
                                 }
                              ]).first

    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
        u.email = auth.info.email
        u.password = Devise.friendly_token(length = 10)
        u.username = auth.info.email.split(/#|@/).first
        u.last_name = auth.info.last_name
        u.first_name = auth.info.first_name
        u.save!
        logger.info '>> ENVIANDO USER <<'
        return u
        logger.info '>> USER ENVIADO <<'
      end
    end
  end
end
