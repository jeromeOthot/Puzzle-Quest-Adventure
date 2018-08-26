class Mouse_Cursor < Sprite_Base
  def initialize
    super
    draw_cursor
    self.z = 999
  end
  def draw_cursor
    self.bitmap = nil
    self.bitmap = Cache.system("Bigset")
    rect = Rect.new(MOUSE_ICON % 16 * 24, MOUSE_ICON / 16 * 24, 24, 24)
    self.bitmap.blt(0, 0, self.bitmap, rect)
    self.src_rect.set(0, 0, 24, 24)  
  end
end