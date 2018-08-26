class Game_Player < Game_Character
  alias mouse_move_update update
  def update
    mouse_move_update
    mouse_input
  end
  def mouse_input
    #return if USE_MOUSE_BUTTONS && SceneManager.scene.mouse_overlay.update
    return if !movable? || $game_map.interpreter.running?
    if !Mouse.lclick?(true) then return end
    if moving? then return end
    if MOUSE_DIR8
      x = $game_map.display_x * 32 + Mouse.pos?[0]
      y = $game_map.display_y * 32 + Mouse.pos?[1]
      x -= @x * 32 + 16
      y -= @y * 32 + 16
      angle = Math.atan(x.abs/y.abs) * (180 / Math::PI)
      angle = (90 - angle) + 90 if x > 0 && y > 0
      angle += 180 if x < 0 && y > 0
      angle = 90 - angle + 180 + 90 if x < 0 && y < 0
      move_straight(8) if angle >= 337 || angle < 22
      move_diagonal(6,8) if angle >= 22 && angle < 67
      move_straight(6) if angle >= 67 && angle < 112
      move_diagonal(6,2) if angle >= 112 && angle < 157
      move_straight(2) if angle >= 157 && angle < 202
      move_diagonal(4,2) if angle >= 202 && angle < 247
      move_straight(4) if angle >= 247 && angle < 292
      move_diagonal(4,8) if angle >= 292 && angle < 337
    else
      x = $game_map.display_x + Mouse.pos?[0] / 32
      y = $game_map.display_y + Mouse.pos?[1] / 32
      sx = distance_x_from(x)
      sy = distance_y_from(y)
      if sx.abs > sy.abs
        move_straight(sx > 0 ? 4 : 6)
        move_straight(sy > 0 ? 8 : 2) if !@move_succeed && sy != 0
      elsif sy != 0
        move_straight(sy > 0 ? 8 : 2)
        move_straight(sx > 0 ? 4 : 6) if !@move_succeed && sx != 0
      end
    end
  end
end