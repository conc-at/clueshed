class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable

  has_many :contribs
  has_many :interests
  has_many :votes

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_presence_of :username
  validates :username,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => {
      :with => /\A[\w-]+\z/
    }

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # If the email is unconfirmed and we get one from another provider use it
    if user && !user.email_verified? && auth.info.email
      user.email = auth.info.email
      user.confirm!
      user.save!
    end

    # Create the user if needed
    user = get_user auth if user.nil?

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def update_without_password(params, *options)

    about_to_change_password = false
    # If the user changes the password we reset the no_password flag
    if no_password && !params[:password].blank? && params[:password] == params[:password_confirmation]
      about_to_change_password = true
    else
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords

    if about_to_change_password
      self.no_password = false
      self.save
    end

    result
  end

  private
    def get_user(auth)
      # Get the existing user by email
      # If no email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email = auth.info.email
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      user = create_user auth, email if user.nil?
      user
    end

    def create_user(auth, email)
      user = User.new(
        username: auth.info.nickname || auth.uid,
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20],
        no_password: true
      )
      user.skip_confirmation!
      user.save!
      user
    end
end
