class User < ActiveRecord::Base
  attr_accessible :batch, :designation, :email, :role_id, :location, :dob, :name, :organization, :password_hash, :password_salt,:password, :password_confirmation, :pic,
  BATCH = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  attr_accessor :password
  before_save :encrypt_password

  belongs_to :role
  
  validates_confirmation_of :password
  validates_presence_of :name
  validates_uniqueness_of :email
  #validates_presence_of :password, :on => :create
  validates_presence_of :location
  #validates_presence_of :dob
  #validates_presence_of :batch
  validates_presence_of :organization
  validates_presence_of :designation
  has_attached_file :pic , :styles => 
          { :medium => "300x300>", :thumb => "100x100>" }
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def is_admin?
    self.role.name.downcase == "admin" if self.role_id
  end

  def is_user?
    self.role.name.downcase == "user" if self.role_id
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  def self.search(search) 
    if search  
      where("name LIKE ?", "%#{search}%")  
    else  
      scoped  
    end  
  end  

   def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
