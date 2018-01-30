class Contact < ApplicationRecord
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def friendly_updated_time
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japanese_phone
    " +81 #{phone_number}"
  end

  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      full_name: full_name,
      bio: bio,
      email: email,
      phone_number: japanese_phone,
      updated_at: friendly_updated_time
    }
  end
end
