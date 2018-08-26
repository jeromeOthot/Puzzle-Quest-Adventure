class Scene_File < Scene_MenuBase
  alias mouse_update update
  def update
    mouse_update
    mouse_input
  end
  def mouse_input
    xx = 0
    yy = 56
    width = Graphics.width
    rectcm1 = Rect.new(xx, yy, width, savefile_height)
    rectcm2 = Rect.new(xx, yy + rectcm1.height, width, savefile_height)
    rectcm3 = Rect.new(xx, yy + rectcm1.height * 2, width, savefile_height)
    rectcm4 = Rect.new(xx, yy + rectcm1.height * 3, width, savefile_height)
    rectttl = Rect.new(xx, yy, width, rectcm1.height * 4)
    rectcmA = Rect.new(0, yy - 12, Graphics.width, 24)
    rectcmB = Rect.new(0, Graphics.height - 12, Graphics.width, 24)
    @scroll = self.top_index
    last_index = @index
    @index = (0 + @scroll) if Mouse.within?(rectcm1)
    @index = (1 + @scroll) if Mouse.within?(rectcm2)
    @index = (2 + @scroll) if Mouse.within?(rectcm3)
    @index = (3 + @scroll) if Mouse.within?(rectcm4)
    cursor_down(false) if Mouse.within?(rectcmB) and Mouse.slowpeat
    cursor_up(false) if Mouse.within?(rectcmA) and Mouse.slowpeat
    if @index != last_index
      Sound.play_cursor
      @savefile_windows[last_index].selected = false
      @savefile_windows[@index].selected = true
    end
    on_savefile_ok if Mouse.lclick? and Mouse.within?(rectttl)
    on_savefile_cancel if Mouse.rclick? and Mouse.within?(rectttl)
  end
end