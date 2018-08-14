class User < ApplicationRecord

  def self.find_or_create_from_auth_hash(auth, state)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.picture = auth.info.image
      user.state = state
      user.save!
    end
  end

  def self.encrypt_user_state(state)
    return Sha256.new({string: state, salt: GlobalConstant::Base.sha256_salt[:session]}).perform
  end

end