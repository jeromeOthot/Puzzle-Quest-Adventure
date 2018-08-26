module DataManager
  class << self
    alias mouse_init init
  end
  def self.init
    mouse_init
    $cursor = Mouse_Cursor.new
  end
end