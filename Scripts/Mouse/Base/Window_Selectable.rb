class Window_Selectable
  alias mouse_update update
  alias mouse_init initialize
  def initialize(x,y,w,h)
    mouse_init(x,y,w,h)
    @mouse_all_rects = []
  end
  def update
    mouse_update
    update_mouse if self.active
  end
  def update_mouse
    @mouse_all_rects = []
    item_max.times {|i|
      rect = item_rect(i)
      rect.x += self.x + standard_padding - self.ox
      rect.y += self.y + standard_padding - self.oy
      if !self.viewport.nil?
        rect.x += self.viewport.rect.x - self.viewport.ox
        rect.y += self.viewport.rect.y - self.viewport.oy
      end
      @mouse_all_rects.push(rect) }
    item_max.times {|i|
      next unless Mouse.within?(@mouse_all_rects[i])
      self.index = i }
    process_ok if Mouse.lclick? && ok_enabled?
    process_cancel if Mouse.rclick? && cancel_enabled?
  end
end