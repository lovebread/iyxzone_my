class AvatarAlbum < Album

	belongs_to :cover, :class_name => 'Avatar'

  belongs_to :user, :foreign_key => 'owner_id'

  has_many :photos, :class_name => 'Avatar', :dependent => :destroy, :foreign_key => 'album_id', :order => 'created_at DESC'

  acts_as_commentable :order => 'created_at ASC',
                      :delete_conditions => lambda {|user, album, comment| album.poster == user || comment.poster == user}, 
                      :create_conditions => lambda {|user, album| (album.poster == user) || (album.poster.has_friend? user)}

  def set_cover photo
    Avatar.transaction do
      user.update_attribute('avatar_id', photo.id)
      self.update_attribute('cover_id', photo.id)
    end
  rescue
    return false
  end

  def validate
    errors.add_to_base('没有拥有者') if owner_id.blank?
    # poster_id, privilege, game_id在before_create里被赋值，这里不检查
  end

end
