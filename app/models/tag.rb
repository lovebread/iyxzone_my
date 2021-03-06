class Tag < ActiveRecord::Base

	has_many :taggings, :dependent => :destroy

	named_scope :game_tags, :conditions => {:taggable_type => 'Game'}

	named_scope :profile_tags, :conditions => {:taggable_type => 'Profile'}

  named_scope :unverified, :conditions => {:verified => 0}, :order => "created_at DESC"
  named_scope :accept, :conditions => {:verified => 1}, :order => "created_at DESC"
  named_scope :reject, :conditions => {:verified => 2}, :order => "created_at DESC"
  
  attr_protected :verified
  
	def validate_on_create
		if name.nil?
			errors.add_to_base('没有名字')
      return
    end

    if taggable_type.blank?
      errors.add_to_base('没有类型')
		elsif !Tag.find_by_name_and_taggable_type(name, taggable_type).blank?
			errors.add_to_base('名字已经有了')
		end
	end

end
