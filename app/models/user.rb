class User < ActiveRecord::Base
  
  has_many :events
  has_many :plans

  acts_as_authentic do |c|
    c.login_field = :username
    c.validate_login_field = true 
    c.merge_validates_length_of_email_field_options({:allow_nil => true})
    c.merge_validates_format_of_email_field_options({:allow_nil => true})
    c.merge_validates_uniqueness_of_email_field_options({:if=>:false?})
  end
  #cludge for - above merge_validates_uniqueness_of_email 
  # basically this feeds a false so we never validate the email is unique. 
  def false?
    false
  end 

  def email= new_value
    if !new_value.blank? and new_value != self.email
      self.validated_email = false
      self.validate_email_token = Authlogic::Random.friendly_token
      self.write_attribute(:email, new_value) 
      UsersMailer.deliver_email_validation_instruction(self) 
    end
  end
  
  def reset_password 
    delivered = false
    if self.validated_email
      new_pass = Authlogic::Random.friendly_token[0..5]
      delivered = UsersMailer.deliver_email_password(self, new_pass) 
      if delivered
        self.password = new_pass
        self.password_confirmation = new_pass
        delivered = self.save_without_session_maintenance
      end 
    end 
    return delivered
  end


  private

  def validate
    if username =~ /f+u+c+k+|c+u+n+t+|ba+sta+rd|sh+i+t+|b+i+t+ch|n+i+gg+e+r+/i 
      errors.add(:username, "Please avoid profanity in your username.")
    end
  end
end
