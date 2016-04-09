class Scene_Base
  alias cursor_update update_basic
  def update_basic
    cursor_update
    mouse_cursor
    #puts ($cursor.x.to_s + ", " + $cursor.y.to_s)
  end
  
  def mouse_cursor
    pos = Mouse.pos?
    $cursor.x = pos[0]
    $cursor.y = pos[1]
    #puts ($cursor.x.to_s + ", " + $cursor.y.to_s)
  end
  
end