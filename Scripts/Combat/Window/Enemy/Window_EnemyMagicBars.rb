class Window_EnemyMagicBars < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(enemy)
    super(395, 113, 150, 55)
     @enemy = enemy
     draw_magic()
  end
  
  def draw_magic()
      contents.font.size = 16
    draw_icon(7936, 0, 0, true)
      draw_text( 0, 14, 15, 14, @enemy.fire_magic)
    draw_icon(7939, 26, 0, true)
      draw_text( 26, 14, 15, 14, @enemy.water_magic)
    draw_icon(7940, 52, 0, true)
      draw_text( 52, 14, 15, 14, @enemy.earth_magic)
    draw_icon(7941, 78, 0, true)
      draw_text( 78, 14, 15, 14, @enemy.wind_magic)
    draw_icon(7943, 103, 0, true)
      draw_text( 103, 14, 15, 14, @enemy.dark_magic)
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
  end
end