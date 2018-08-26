class Window_HeroMagicBars < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 113, 150, 55)
    back_opacity = 255
    @actor = actor 
    draw_magic()
  end
  
  def refresh()
    contents.clear
    draw_magic
  end
  
  def draw_magic()
      contents.font.size = 16
    draw_icon(7936, 0, 0, true)
      draw_text( 0, 14, 15, 14, @actor.actor.fire_magic)
    draw_icon(7939, 26, 0, true)
      draw_text( 26, 14, 15, 14, @actor.actor.water_magic)
    draw_icon(7940, 52, 0, true)
      draw_text( 52, 14, 15, 14, @actor.actor.earth_magic)
    draw_icon(7941, 78, 0, true)
      draw_text( 78, 14, 15, 14, @actor.actor.wind_magic)
    draw_icon(7616, 103, 0, true)
      draw_text( 103, 14, 15, 14, @actor.actor.light_magic)
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
  end
end