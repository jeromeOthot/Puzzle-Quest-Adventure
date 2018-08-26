class Scene_Gameover
  alias mouse_update update
  def update
    mouse_update
    goto_title if Mouse.lclick? or Mouse.rclick?
  end
end