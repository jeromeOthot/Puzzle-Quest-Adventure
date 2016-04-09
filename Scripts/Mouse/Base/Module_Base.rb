#Basic Mouse System v2.2
#----------#
#Features: Provides a series of functions to find the current x, y position of
#           the mouse and whether it is being clicked or not (left or right click)
#
#Usage:   Script calls:
#           Mouse.pos?   - returns the x, y position as an array
#           Mouse.lclick?(repeat) - returns if left click is achieved
#                                   repeat = true for repeated checks
#           Mouse.rclick?(repeat) - same as above for right click
#           Mouse.within?(rect) - passes a Rect through to check if cursor
#                                 is within it, returns true if so
#
#No Customization
#
#----------#
#-- Script by: V.M of D.T
#
#- Questions or comments can be:
#    posted on the thread for the script
#    given by email: sumptuaryspade@live.ca
#    provided on facebook: http://www.facebook.com/DaimoniousTailsGames
#    posed on site: daimonioustails.wordpress.com
#
#--- Free to use in any non-commercial project with credit given
#-- License required for commercial project use
 
CPOS = Win32API.new 'user32', 'GetCursorPos', ['p'], 'v'
WINX = Win32API.new 'user32', 'FindWindowEx', ['l','l','p','p'], 'i'
ASKS = Win32API.new 'user32', 'GetAsyncKeyState', ['p'], 'i'
SMET = Win32API.new 'user32', 'GetSystemMetrics', ['i'], 'i'
WREC = Win32API.new 'user32', 'GetWindowRect', ['l','p'], 'v'
 
#MOUSE_ICON, set to the index of the icon to use as a cursor
MOUSE_ICON = 2
 
#Whether to use 8 directional movement or not
MOUSE_DIR8 = true
 
#Use the Mouse Button Overlay:
USE_MOUSE_BUTTONS = true
#And here is where you set up your buttons! Simple overlay:
#(Picture files are to be stored in System)
#
# [ x , y, "filename", "script call when left clicked" ]
MOUSE_BUTTONS = [
            [0,416-32,"Shadow.png","SceneManager.call(Scene_Equip)"],
            [32,416-32,"Shadow.png","SceneManager.call(Scene_Item)"], ]
 
SHOWMOUS = Win32API.new 'user32', 'ShowCursor', 'i', 'i'
SHOWMOUS.call(0)
 
module Mouse
  def self.setup
    @delay = 0
    bwap = true if SMET.call(23) != 0
    bwap ? @lmb = 0x02 : @lmb = 0x01
    bwap ? @rmb = 0x01 : @rmb = 0x02
  end
  def self.update
    self.setup if @lmb.nil?
    @delay -= 1
    @window_loc = WINX.call(0,0,"RGSS PLAYER",0)
    if ASKS.call(@lmb) == 0 then @l_clicked = false end
    if ASKS.call(@rmb) == 0 then @r_clicked = false end
    rect = '0000000000000000'
    cursor_pos = '00000000'
    WREC.call(@window_loc, rect)
    side, top = rect.unpack("ll")
    CPOS.call(cursor_pos)
    @m_x, @m_y = cursor_pos.unpack("ll")
    w_x = side + SMET.call(5) + SMET.call(45)
    w_y = top + SMET.call(6) + SMET.call(46) + SMET.call(4)
    @m_x -= w_x; @m_y -= w_y
  end
  def self.pos?
    self.update
    return [@m_x, @m_y]
  end
  def self.lclick?(repeat = false)
    self.update
    return false if @l_clicked
    if ASKS.call(@lmb) != 0 then
      @l_clicked = true if !repeat
      return true end
  end
  def self.rclick?(repeat = false)
    self.update
    return false if @r_clicked
    if ASKS.call(@rmb) != 0 then
      @r_clicked = true if !repeat
      return true end
  end
  def self.slowpeat
    self.update
    return false if @delay > 0
    @delay = 120
    return true
  end
  def self.within?(rect)
    self.update
    return false if @m_x < rect.x or @m_y < rect.y
    bound_x = rect.x + rect.width; bound_y = rect.y + rect.height
    return true if @m_x < bound_x and @m_y < bound_y
    return false
  end
end