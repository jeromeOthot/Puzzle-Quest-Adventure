class Window_NameInput
  alias mouse_process_handling process_handling
  def process_handling
    mouse_process_handling
    process_back if Mouse.rclick?
  end
  def item_max
    return 90
  end
end