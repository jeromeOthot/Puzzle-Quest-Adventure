class Window_Message < Window_Base
  def input_pause
    self.pause = true
    wait(10)
    Fiber.yield until Input.trigger?(:B) || Input.trigger?(:C) || Mouse.lclick? if !SceneManager.scene_is?(Scene_Map)
    Input.update
    self.pause = false
  end
end