#===============================================================================
# * Falcao Pearl ABS script shelf # 1
#
# This script is the Heart of Pearl ABS Liquid, it handles all the character
# management, the tools variables and the input module, enemy registration etc.
#===============================================================================

module PearlKernel
  
  # Default enemy sensor self switch
  Enemy_Sensor = "B"
  
  # Default enemy sensor (distance in tiles the enemy is able to see the Player
  Sensor = 7
  
  # Default enemy knockdown self switch (used to display knockdowned graphic)
  KnockdownSelfW = "C"
  
  # Deafault Enemy collapse
  DefaultCollapse = 'zoom_vertical'
  
  # While in party battle on map, the game player is the manager of the group
  # Which distance the player can see the enemies?, this is used, to determine
  # wheter the follower can start fighting. enemy away from this tiles
  # whil be ignored untill the player is near them
  # distamce measured in tiles
  PlayerRange = 7
  
  # When a follower fail an action this balloon is played, runs out of mana etc.
  FailBalloon = 1
  
  # Start the game with the ABS huds turned on?
  StartWithHud = true
  
  # Do you want to activate the followers dead poses?
  FollowerDeadPose = true
  
  # Do you want to activate the single player mode?
  # this only avoid you accesing the player slection menu and the K key is used
  # to open the quick tool selection menu
  SinglePlayer = false
  
  #-----------------------------------------------------------------------------
  @gaugeback = Color.new(0, 0, 0, 100)
  def self.draw_hp(obj, battler, x, y, w, h, color, name=nil)
    puts "hp"
    puts battler
    tag = 'Hp' ; c = color
    name = battler.name if !name.nil?
    draw_gauge(obj, battler.hp, battler.mhp, x, y, w, h, c, tag, name)
  end
  
  def self.draw_mp(obj, battler, x, y, w, h, color, name=nil)
    tag = 'Mp' ; c = color
    name = battler.name if !name.nil?
    draw_gauge(obj, battler.mp, battler.mmp, x, y, w, h, c, tag, name)
  end
  
  def self.draw_exp(obj, battler, x, y, w, h, color, name=nil)
    tag = 'Exp' ; c = color
    name = battler.name if !name.nil?
    draw_gauge(obj,battler.exp, battler.next_level_exp, x, y, w, h, c, tag,name)
  end
  
  def self.draw_tp(obj, x, y, actor)
    string = 'Tp ' + (actor.tp).to_i.to_s
    obj.fill_rect(x, y + 10 , string.length * 9, 12, @gaugeback)
    obj.draw_text(x, y, obj.width, 32, string)
  end
  
  def self.draw_gauge(obj, nm, max, x, y, w, h, col, tag, name)
    obj.font.shadow = true
    w2 = w - 2 ; max = 1 if max == 0
    obj.fill_rect(x, y - 1, w, h + 2, @gaugeback)
    obj.fill_rect(x+1, y+1, w2*nm/max, h/2 - 1, col[0])
    obj.fill_rect(x+1, y + h/2, w2*nm/max, h/2 - 1, col[1])
    obj.draw_text(x, y + h - 22, w, 32, nm.to_s + ' / ' + max.to_s, 2)
    obj.draw_text(x + 4, y + h - 22, w, 32, tag)
    obj.draw_text(x, y - 25, w, 32, name, 1) if !name.nil?
  end
  
  # image based bars definition 
  def self.image_hp(bitmap, x, y, back, image, battler, name=nil)
    tag = 'Hp'
    name = battler.name if !name.nil?
    draw_i_gauge(bitmap, x, y, back, image, battler.hp, battler.mhp, tag, name)
  end
  
  def self.image_mp(bitmap, x, y, back, image, battler, name=nil)
    tag = 'Mp'
    name = battler.name if !name.nil?
    draw_i_gauge(bitmap, x, y, back, image, battler.mp, battler.mmp, tag, name)
  end
  
  def self.image_exp(bitmap, x, y, back, image, battler, name=nil)
    tag = 'Exp'
    name = battler.name if !name.nil?
    exp, nexte = battler.exp, battler.next_level_exp
    draw_i_gauge(bitmap, x, y, back, image, exp, nexte, tag, name)
  end
  
  def self.draw_i_gauge(bitmap, x, y, back, image, nm, max, tag, name)
    cw = back.width  
    ch = back.height 
    max = 1 if max == 0
    src_rect = Rect.new(0, 0, cw, ch)    
    bitmap.blt(x - 10, y - ch + 30,  back, src_rect)
    cw = image.width  * nm / max
    ch = image.height 
    src_rect = Rect.new(0, 0, cw, ch)
    bitmap.blt(x - 10, y - ch + 30, image, src_rect)
    bitmap.draw_text(x - 4, y + back.height - 14, back.width, 32, tag)
    bitmap.draw_text(x - 12, y + back.height - 14, back.width, 32, nm.to_s, 2)
    bitmap.draw_text(x - 6, y - 10, back.width, 32, name, 1) if !name.nil?
  end
  
  def self.has_data?
    !user_graphic.nil?
  end
  
  def self.load_item(item) 
    @item = item
  end
  
  def self.user_graphic()      @item.tool_data("User Graphic = ", false)    end
  def self.user_animespeed()   @item.tool_data("User Anime Speed = ")       end
  def self.tool_cooldown()     @item.tool_data("Tool Cooldown = ")          end
  def self.tool_graphic()      @item.tool_data("Tool Graphic = ", false)    end
  def self.tool_index()        @item.tool_data("Tool Index = ")             end
  def self.tool_size()         @item.tool_data("Tool Size = ")              end
  def self.tool_distance()     @item.tool_data("Tool Distance = ")          end
  def self.tool_effectdelay()  @item.tool_data("Tool Effect Delay = ")      end
  def self.tool_destroydelay() @item.tool_data("Tool Destroy Delay = ")     end
  def self.tool_speed()         @item.tool_float("Tool Speed = ")            end
  def self.tool_castime()       @item.tool_data("Tool Cast Time = ")         end
  def self.tool_castanimation() @item.tool_data("Tool Cast Animation = ")    end
  def self.tool_blowpower()     @item.tool_data("Tool Blow Power = ")        end
  def self.tool_piercing()      @item.tool_data("Tool Piercing = ", false)   end
  def self.tool_animation() @item.tool_data("Tool Animation When = ", false) end
  def self.tool_anirepeat() @item.tool_data("Tool Animation Repeat = ",false)end
  def self.tool_special() @item.tool_data("Tool Special = ", false)          end
  def self.tool_target() @item.tool_data("Tool Target = ", false)            end
  def self.tool_invoke() @item.tool_data("Tool Invoke Skill = ")             end
  def self.tool_guardrate() @item.tool_data("Tool Guard Rate = ")            end
  def self.tool_knockdown() @item.tool_data("Tool Knockdown Rate = ")        end
  def self.tool_soundse() @item.tool_data("Tool Sound Se = ", false)         end
  def self.tool_itemcost() @item.tool_data("Tool Item Cost = ")              end
  def self.tool_shortjump() @item.tool_data("Tool Short Jump = ", false)     end
  def self.tool_through() @item.tool_data("Tool Through = ", false)          end
  def self.tool_priority() @item.tool_data("Tool Priority = ")               end
  def self.tool_selfdamage() @item.tool_data("Tool Self Damage = ", false)   end
  def self.tool_hitshake() @item.tool_data("Tool Hit Shake = ", false)       end
  def self.tool_combo() @item.tool_data("Tool Combo Tool = ", false)         end
  
  def self.knock_actor(actor)
    a = actor.actor.tool_data("Knockdown Graphic = ", false)
    b = actor.actor.tool_data("Knockdown Index = ")
    c = actor.actor.tool_data("Knockdown pattern = ")
    d = actor.actor.tool_data("Knockdown Direction = ")
    return nil if a.nil?
    return [a, b, c, d]
  end
  
  def self.jump_hit?(target)
    t = target.enemy.tool_data("Hit Jump = ", false) if target.is_a?(Game_Enemy)
    t = target.actor.tool_data("Hit Jump = ", false) if target.is_a?(Game_Actor)
    return true if !t.nil? and t == "true"
    return true if t.nil?
    return false
  end
  
  def self.voices(b)
    voices = b.actor.tool_data("Battler Voices = ",false) if b.is_a?(Game_Actor)
    voices = b.enemy.tool_data("Battler Voices = ",false) if b.is_a?(Game_Enemy)
    voices = voices.split(", ") unless voices.nil?
    voices
  end
  
  def self.hitvoices(b)
    voices = b.actor.tool_data("Hit Voices = ",false) if b.is_a?(Game_Actor)
    voices = b.enemy.tool_data("Hit Voices = ",false) if b.is_a?(Game_Enemy)
    voices = voices.split(", ") unless voices.nil?
    voices
  end
  
  def self.clean_back?
    @clean_back == true
  end
end

($imported ||= {})["Falcao Pearl ABS Liquid"] = true

class RPG::BaseItem
  attr_reader :has_data
  def tool_data(comment, sw=true)
    if @note =~ /#{comment}(.*)/i
      @has_data = true
      return sw ? $1.to_i : $1.to_s.sub("\r","")
    end
  end
  
  def tool_float(comment)
    return  $1.to_f if @note =~ /#{comment}(.*)/i
  end
  
  def cool_enabled?
    @cd_dis = @note.include?("Tool Cooldown Display = true") if @cd_dis.nil?
    @cd_dis
  end
  
  def itemcost
    if @i_cost.nil?
      @note =~ /Tool Item Cost = (.*)/i ? @i_cost = $1.to_i : @i_cost = 0
    end
    @i_cost
  end
end

# Pearl ABS Input module
module PearlKey
 
  # numbers
  N0 = 0x30; N1 = 0x31; N2 = 0x32; N3 = 0x33; N4 = 0x34
  N5 = 0x35; N6 = 0x36; N7 = 0x37; N8 = 0x38; N9 = 0x39
  
  # keys
  A = 0x41; B = 0x42; C = 0x43; D = 0x44; E = 0x45
  F = 0x46; G = 0x47; H = 0x48; I = 0x49; J = 0x4A
  K = 0x4B; L = 0x4C; M = 0x4D; N = 0x4E; O = 0x4F
  P = 0x50; Q = 0x51; R = 0x52; S = 0x53; T = 0x54
  U = 0x55; V = 0x56; W = 0x57; X = 0x58; Y = 0x59; Z = 0x5A

  @unpack_string = 'b'*256
  @last_array = '0'*256
  @press = Array.new(256, false)
  @trigger = Array.new(256, false)
  @release = Array.new(256, false)
  @getKeyboardState = Win32API.new('user32', 'GetKeyboardState', ['P'], 'V')
  @getAsyncKeyState = Win32API.new('user32', 'GetAsyncKeyState', 'i', 'i')
  @getKeyboardState.call(@last_array)
  
  @last_array = @last_array.unpack(@unpack_string)
  for i in 0...@last_array.size
    @press[i] = @getAsyncKeyState.call(i) == 0 ? false : true
  end
 
  def self.update
    @trigger = Array.new(256, false)
    @release = Array.new(256, false)
    array = '0'*256
    @getKeyboardState.call(array)
    array = array.unpack(@unpack_string)
    for i in 0...array.size
      if array[i] != @last_array[i]
        @press[i] = @getAsyncKeyState.call(i) == 0 ? false : true
        if !@press[i]
          @release[i] = true
        else
          @trigger[i] = true
        end
      else
        if @press[i] == true
          @press[i] = @getAsyncKeyState.call(i) == 0 ? false : true
          @release[i] = true if !@press[i]
        end
      end
    end
    @last_array = array
  end
  
  def self.press?(key)
    return @press[key]
  end
 
  def self.trigger?(key)
    return @trigger[key]
  end
end

# Input module update engine
class << Input
  alias falcaopearl_abs_cooldown_update update
  def Input.update
    update_pearl_abs_cooldown
    update_popwindow if !$game_temp.nil? and !$game_temp.pop_windowdata.nil?
    falcaopearl_abs_cooldown_update
  end
  
  alias falcaopearl_trigger trigger?
  def trigger?(constant)
    return true if constant == :B and PearlKey.trigger?(PearlKey::B)
    falcaopearl_trigger(constant)
  end
  
  # pop window global
  def update_popwindow
    $game_temp.pop_windowdata[0] -= 1 if $game_temp.pop_windowdata[0] > 0
    if @temp_window.nil?
      tag = $game_temp.pop_windowdata[2]
      string = $game_temp.pop_windowdata[1] + tag
      width = (string.length * 9) - 10
      x, y = Graphics.width / 2 - width / 2,  Graphics.height / 2 - 64 / 2
      @temp_window = Window_Base.new(x, y, width, 64)
      @temp_window.contents.font.size = 20
      @temp_window.draw_text(-10, -6, width, 32, tag, 1)
      @temp_window.draw_text(-10, 14, width, 32, $game_temp.pop_windowdata[1],1)
      @current_scene = SceneManager.scene.class 
    end
    
    if $game_temp.pop_windowdata[0] == 0 || 
      @current_scene != SceneManager.scene.class 
      @temp_window.dispose
      @temp_window = nil
      $game_temp.pop_windowdata = nil
    end
  end
  
  def update_pearl_abs_cooldown
    PearlKey.update
    eval_cooldown($game_party.all_members) if !$game_party.nil?
    eval_cooldown($game_map.enemies) if !$game_map.nil?
  end
  
  # cooldown update
  def eval_cooldown(operand)
    for sub in operand
      sub.skill_cooldown.each {|sid, sv| # skill
      if sub.skill_cooldown[sid] > 0
        sub.skill_cooldown[sid] -= 1
        sub.skill_cooldown.delete(sid) if sub.skill_cooldown[sid] == 0
      end}
      sub.item_cooldown.each {|iid, iv| # item
      if sub.item_cooldown[iid] > 0
        sub.item_cooldown[iid] -= 1
        sub.item_cooldown.delete(iid) if sub.item_cooldown[iid] == 0
      end}
      sub.weapon_cooldown.each {|wid, wv| # weapon
      if sub.weapon_cooldown[wid] > 0
        sub.weapon_cooldown[wid] -= 1
        sub.weapon_cooldown.delete(wid) if sub.weapon_cooldown[wid] == 0
      end}
      sub.armor_cooldown.each {|aid, av| #armor
      if sub.armor_cooldown[aid] > 0
        sub.armor_cooldown[aid] -= 1 
        sub.armor_cooldown.delete(aid) if sub.armor_cooldown[aid] == 0
      end}
    end
  end
end

#===============================================================================
#===============================================================================
# Game character

class Game_CharacterBase
  attr_accessor :just_hitted, :anime_speed, :blowpower, :targeting, :x, :y
  attr_accessor :battler_guarding, :knockdown_data, :colapse_time, :opacity
  attr_accessor :zoomfx_x, :zoomfx_y, :targeted_character, :stuck_timer
  attr_accessor :send_dispose_signal, :follower_attacktimer, :stopped_movement
  attr_accessor :hookshoting, :battler_chain, :pattern, :user_move_distance
  attr_accessor :move_speed, :through, :being_grabbed, :making_spiral
  attr_accessor :direction, :direction_fix, :zfx_bol, :buff_pop_stack
  attr_accessor :die_through, :target_index, :using_custom_g, :combodata
  attr_accessor :originalasp, :doingcombo, :angle_fx
  alias falcaopearl_abmain_ini initialize
  def initialize
    @zfx_bol = false
    @just_hitted = 0
    @anime_speed = 0
    @blowpower = [0, dir=2, dirfix=false, s=4, wait_reset=0]
    @user_casting = [0, nil]
    @send_dispose_signal = false
    @targeting = [false, item=nil, char=nil]
    @colapse_time = 0
    @stopped_movement = 0
    @follower_attacktimer = 0
    set_hook_variables
    @target_index = 0
    @using_custom_g = false
    @combodata = []
    @angle_fx = 0.0
    #--------------
    @zoomfx_x = 1.0
    @zoomfx_y = 1.0
    @stuck_timer = 0
    @battler_guarding = [false, nil]
    @knockdown_data = [0, nil, nil, nil, nil]
    @state_poptimer = [0, 0]
    @making_spiral = false
    @buff_pop_stack = []
    @doingcombo = 0
    @range_view = 2
    @originalasp = 0
    falcaopearl_abmain_ini
  end
  
  def set_hook_variables
    @hookshoting = [on=false, hooking=false, grabing=false, delay=0]
    @battler_chain = []
    @user_move_distance = [steps=0, speed=nil, trought=nil, cor=nil, evmove=nil]
    @being_grabbed = false
  end
 
  # projectiles at nt
  def projectiles_xy_nt(x, y)
    $game_player.projectiles.select {|pro| pro.pos_nt?(x, y) }
  end
  
  # collide with projectiles
  def collide_with_projectiles?(x, y)
    projectiles_xy_nt(x, y).any? do |pro|
      pro.normal_priority? || self.is_a?(Projectile)
    end
  end
  
  def zoom(x, y)
    @zoomfx_x = x
    @zoomfx_y = y
  end
  
  alias falcaopearl_collide_with collide_with_characters?
  def collide_with_characters?(x, y)
    return true if collide_with_projectiles?(x, y)
    falcaopearl_collide_with(x, y)
  end
  
  # follow character straigh and diagonal
  def follow_char(character)
    sx = distance_x_from(character.x)
    sy = distance_y_from(character.y)
    if sx != 0 && sy != 0
      move_diagonal(sx > 0 ? 4 : 6, sy > 0 ? 8 : 2)
    elsif sx != 0
      move_straight(sx > 0 ? 4 : 6)
    elsif sy != 0
      move_straight(sy > 0 ? 8 : 2)
    end
  end
  
  def on_battle_screen?(out = 0)
    max_w = (Graphics.width / 32).to_i - 1
    max_h = (Graphics.height / 32).to_i - 1
    sx = (screen_x / 32).to_i
    sy = (screen_y / 32).to_i
    if sx.between?(0 - out, max_w + out) and sy.between?(0 - out, max_h + out)
      return true
    end
    return false
  end
  
   # jump to specific tiles
  def jumpto_tile(x, y)
    jumpto(0, [x, y])
  end
  
  # jumpto character ( 0 = Game Player, 1 and up event id)
  def jumpto(char_id, tilexy=nil)
    char_id > 0 ? char = $game_map.events[char_id] : char = $game_player
    tilexy.nil? ? condxy = [char.x, char.y] : condxy = [tilexy[0], tilexy[1]]
    jx = + eval_distance(tilexy.nil? ? char : tilexy)[0] if condxy[0] >= @x
    jy = - eval_distance(tilexy.nil? ? char : tilexy)[1] if condxy[1] <= @y
    jx = - eval_distance(tilexy.nil? ? char : tilexy)[0] if condxy[0] <= @x
    jy = - eval_distance(tilexy.nil? ? char : tilexy)[1] if condxy[1] <= @y
    jx = - eval_distance(tilexy.nil? ? char : tilexy)[0] if condxy[0] <= @x
    jy = + eval_distance(tilexy.nil? ? char : tilexy)[1] if condxy[1] >= @y
    jx = + eval_distance(tilexy.nil? ? char : tilexy)[0] if condxy[0] >= @x
    jy = + eval_distance(tilexy.nil? ? char : tilexy)[1] if condxy[1] >= @y
    jump(jx, jy)
  end
  
  # distance
  def eval_distance(target)
    if target.is_a?(Array)
      distance_x = (@x - target[0]).abs
      distance_y = (@y - target[1]).abs
    else
      distance_x = (@x - target.x).abs
      distance_y = (@y - target.y).abs
    end
    return [distance_x, distance_y] 
  end
  
  # check if the game player and follower are executing an action
  def battler_acting?
    return true if @user_casting[0] > 0 || @targeting[0]
    return true if @knockdown_data[0] > 0 and battler.deadposing.nil?
    return true if @anime_speed > 0
    return true if @hookshoting[0] || @making_spiral
    if self.is_a?(Game_Player)
      $game_player.followers.each {|f| return true if f.battler_acting?}
    end
    return false
  end

  def battler
  end
  
  def use_weapon(id)
    return unless tool_can_use?
    process_tool_action($data_weapons[id])
  end
  
  def use_item(id)
    return unless tool_can_use?
    process_tool_action($data_items[id])
  end
  
  def use_skill(id)
    return unless tool_can_use?
    process_tool_action($data_skills[id])
  end
  
  def use_armor(id)
    return unless tool_can_use?
    process_tool_action($data_armors[id])
  end
  
  def tool_can_use?
    return false if @hookshoting[0] || @making_spiral
    return false if @user_casting[0] > 0 || @targeting[0]
    return false if battler.nil?
    return false if battler.dead?
    return false if @doingcombo > 0 || @battler_guarding[0]
    return false if $game_message.busy?
    return true
  end
  
  def load_target_selection(item)
    @targeting[0] = true; @targeting[1] = item
    if self.is_a?(Game_Player)
      $game_player.pearl_menu_call = [:battler, 2]
    elsif self.is_a?(Game_Follower)
      @targeting[2] = @targeted_character
      @targeting = [false, item=nil, char=nil] if @targeting[2].nil?
    elsif self.is_a?(Projectile)
      if user.is_a?(Game_Player)
        user.targeting[0] = true; user.targeting[1] = item
        $game_player.pearl_menu_call = [:battler, 2]
      end
      if user.is_a?(Game_Follower)
        @targeting[2] = user.targeted_character
        @targeting = [false, item=nil, char=nil] if @targeting[2].nil?
      end
    end
  end
  
  def playdead
    @angle_fx = 90
  end
  
  def resetplaydead
    @angle_fx = 0.0
  end

  #action canceling
  def force_cancel_actions
    @user_casting[0] = 0
    @anime_speed = 0
  end
  
  def speed(x)
    @move_speed = x
  end
  
  def anima(x)
    @animation_id = x
  end
  
  # aply melee params
  def apply_weapon_param(weapon, add)
    id = 0
    for param in weapon.params
      add ? battler.add_param(id, param) : battler.add_param(id, -param)
      id += 1
    end
  end
  
  # Short script call for poping damage text
  def pop_damage(custom=nil)
    $game_player.damage_pop.push(DamagePop_Obj.new(self, custom))
  end
  
  #check if target is unable to move
  def force_stopped?
    return true if @anime_speed > 0 || @knockdown_data[0] > 0 ||
    @stopped_movement > 0 || @hookshoting[0] || @angle_fx != 0.0
    return true if @making_spiral
    return false
  end
  
  # sensor 
  def obj_size?(target, size)
    return false if size.nil?
    distance = (@x - target.x).abs + (@y - target.y).abs
    enable   = (distance <= size-1)
    return true if enable
    return false
  end
  
  # sensor body
  def body_size?(target, size)
    distance = (@x - target[0]).abs + (@y - target[1]).abs
    enable   = (distance <= size-1)
    return true if enable
    return false
  end
  
  def faceto_face?(target)
    return true if @direction == 2 and target.direction == 8
    return true if @direction == 4 and target.direction == 6
    return true if @direction == 6 and target.direction == 4
    return true if @direction == 8 and target.direction == 2
    return false
  end
  
  def adjustcxy
    push_x, push_y =   0,   1 if @direction == 2
    push_x, push_y = - 1,   0 if @direction == 4
    push_x, push_y =   1,   0 if @direction == 6
    push_x, push_y =   0, - 1 if @direction == 8
    return [push_x, push_y]
  end
  
  def in_frontof?(target)
    return true if @direction == 2 and @x == target.x and (@y+1) == target.y
    return true if @direction == 4 and (@x-1) == target.x and @y == target.y
    return true if @direction == 6 and (@x+1) == target.x and @y == target.y
    return true if @direction == 8 and @x == target.x and (@y-1) == target.y
    return false
  end
  
  # detect map edges ignoring loop maps
  def facing_corners?
    case $game_map.map.scroll_type
    when 1 then return false if @direction == 2 || @direction == 8
    when 2 then return false if @direction == 4 || @direction == 6
    when 3 then return false
    end
    m = $game_map
    unless @x.between?(1, m.width - 2) && @y.between?(1, m.height - 2)
      return true if @x == 0 and @direction == 4
      return true if @y == 0 and @direction == 8
      return true if @x == m.width  - 1  and @direction == 6
      return true if @y == m.height - 1  and @direction == 2
    end
    return false
  end
  
  # item usable test
  def usable_test_passed?(item)
    return true if battler.is_a?(Game_Enemy) && item.is_a?(RPG::Item)
    itemcost = item.tool_data("Tool Item Cost = ")
    invoke = item.tool_data("Tool Invoke Skill = ")
    if battler.is_a?(Game_Actor) and itemcost != nil and itemcost != 0
      return false if !battler.usable?($data_items[itemcost])
    end
    if item.is_a?(RPG::Skill) || item.is_a?(RPG::Item)
      return false if !battler.usable?(item)
    else
      if invoke != nil and invoke != 0
        return false if !battler.usable?($data_skills[invoke])
      else
        return false if !battler.attack_usable?
      end
    end
    return true
  end
  
  # process the tool and verify wheter can be used
  def process_tool_action(item)
    PearlKernel.load_item(item)
    return if !battler.tool_ready?(item)
  
    unless PearlKernel.has_data?
      if item.is_a?(RPG::Weapon) || item.is_a?(RPG::Armor)
        msgbox('Tool data missing') if $DEBUG
        return
      end
      if item.scope.between?(1, 6)
        msgbox('Tool data missing') if $DEBUG
        return
      elsif item.scope == 0
        return
        
      elsif !battler.usable?(item)
        RPG::SE.new("Cursor1", 80).play if self.is_a?(Game_Player)
        return 
      end
    end
    
    if PearlKernel.has_data? and not usable_test_passed?(item)
      RPG::SE.new("Cursor1", 80).play if self.is_a?(Game_Player)
      return
    end
    
    @user_casting = [PearlKernel.tool_castime,item] if PearlKernel.has_data?
    if @user_casting[0] > 0
      @animation_id = 0
      @animation_id = PearlKernel.tool_castanimation
    else
      load_abs_tool(item)
    end
  end
  
  # load the abs tool
  def load_abs_tool(item)
    return if @knockdown_data[0] > 0
    PearlKernel.load_item(item)
  
    return if self.is_a?(Game_Follower) and @targeted_character.nil?
    
    if !@targeting[0] and  self.battler.is_a?(Game_Actor)
      if item.is_a?(RPG::Skill) || item.is_a?(RPG::Item)
        # apply target to skills items 
        if PearlKernel.tool_target == "true" || item.scope == 7 ||
          item.scope == 9
          load_target_selection(item)
          return
        end
      else
        # apply target parsing the invoked skill to weapons and armors
        invoke = PearlKernel.tool_invoke
        if invoke != nil && invoke > 0 && invoke != 1 && invoke != 2
          invokeskill = $data_skills[invoke]
          if PearlKernel.tool_target == "true" || invokeskill.scope == 7 ||
            invokeskill.scope == 9
            load_target_selection(item)
            return
          end
          # apply target to normal weapon and armor without invoking
        else
          if PearlKernel.tool_target == "true"
            load_target_selection(item)
            return
          end
        end
      end
    end
    if item.is_a?(RPG::Skill) || item.is_a?(RPG::Item)
      battler.use_item(item) 
    else
      if PearlKernel.tool_invoke != 0
        battler.use_item($data_skills[PearlKernel.tool_invoke])
      end
    end
    
    # if the tool has data continue
    if PearlKernel.has_data?
      consume_ammo_item(item) if battler.is_a?(Game_Actor) and
      PearlKernel.tool_itemcost != 0
      @anime_speed = PearlKernel.user_animespeed
      battler.apply_cooldown(item, PearlKernel.tool_cooldown)
    end
    create_projectile_object(item)
    create_anime_sprite_object(item)
  end
  
  # projectile creator
  def create_projectile_object(item)
    if PearlKernel.tool_special == "hook"
      PearlKernel.tool_distance.times {|i|
      $game_player.projectiles.push(Projectile.new(self, item, i))}
      @hookshoting[0] = true
    elsif PearlKernel.tool_special == "triple"       # loads 3 projectiles
      for i in [:uno, :dos, :tres]
        $game_player.projectiles.push(Projectile.new(self, item, i))
      end
    elsif PearlKernel.tool_special == "quintuple"     #loads 5 projectiles
      for i in [:uno, :dos, :tres, :cuatro, :cinco]
        $game_player.projectiles.push(Projectile.new(self, item, i))
      end
    elsif PearlKernel.tool_special == "octuple"       # loads 8 projectiles
      for i in [:uno, :dos, :tres, :cuatro, :cinco, :seis, :siete, :ocho]
        $game_player.projectiles.push(Projectile.new(self, item, i))
      end
    else # load default projectile
      $game_player.projectiles.push(Projectile.new(self, item))
    end
  end
  
  # User anime sprite creation
  def create_anime_sprite_object(item)
    $game_player.anime_action.each {|i|
    if i.user == self
      if i.custom_graphic
        @transparent = false 
        i.user.using_custom_g = false
      end
      $game_player.anime_action.delete(i)
    end}
    if PearlKernel.user_graphic != "nil"
      return if PearlKernel.user_graphic.nil?
      $game_player.anime_action.push(Anime_Obj.new(self, item))
    end
  end
  
  # consume ammo item
  def consume_ammo_item(item)
    itemcost = $data_items[PearlKernel.tool_itemcost]
    return if item.is_a?(RPG::Item) and item.consumable and item == itemcost
    battler.use_item(itemcost)
  end
  
  alias falcaopearl_chaupdate update
  def update
    update_falcao_pearl_abs
    falcaopearl_chaupdate
  end
  
  # Falcao pearl abs main update
  def update_falcao_pearl_abs
    if @user_move_distance[0] > 0 and not moving?
      move_forward ; @user_move_distance[0] -= 1
    end
    return if battler.nil?
    update_pearlabs_timing
    update_followers_attack if self.is_a?(Game_Follower) && self.visible?
    if @targeting[2] != nil
      load_abs_tool(@targeting[1]) if battler.is_a?(Game_Actor)
      @targeting = [false, item=nil, char=nil]
    end
    update_battler_collapse
    update_state_effects
    
    @combodata.each {|combo|
    if combo[3] > 0
      combo[3] -= 1
      if combo[3] == 0
        perform_combo(combo[0], combo[1], combo[2])
        @combodata.delete(combo)
      end
      break
    end}
  end

  def perform_combo(kind, id, jumpp)
    if jumpp == 'jump'
      jump(0, 0)
      move_forward
    end
    case kind
    when :weapon then use_weapon(id)
    when :armor  then use_armor(id)
    when :item   then use_item(id)
    when :skill  then use_skill(id)
    end
    @doingcombo = 12
  end
  
  #========================================================================
  #     * followers attacks engine
  
  def fo_tool
    return actor.equips[0]       if actor.primary_use == 1
    return actor.equips[1]       if actor.primary_use == 2
    return actor.assigned_item   if actor.primary_use == 3
    return actor.assigned_item2  if actor.primary_use == 4
    return actor.assigned_item3  if actor.primary_use == 5
    return actor.assigned_item4  if actor.primary_use == 6
    return actor.assigned_skill  if actor.primary_use == 7
    return actor.assigned_skill2 if actor.primary_use == 8
    return actor.assigned_skill3 if actor.primary_use == 9
    return actor.assigned_skill4 if actor.primary_use == 10
  end
  
  # followers attack engine
  def update_followers_attack
    if fo_tool.nil? || battler.dead?
      @targeted_character = nil if @targeted_character != nil
      return
    end
    return if @stopped_movement > 0
    if @follower_attacktimer > 0
      @follower_attacktimer -= 1
      if @follower_attacktimer == 40 and !moving?
        r = rand(3)
        move_random if r == 0 || r == 1
        move_away_from_character(@targeted_character) if 
        !@targeted_character.nil? and r == 2
      end
    end
    
     # si la skill es para el player 
    if @targeted_character != nil and @targeted_character.is_a?(Game_Player)
      if all_enemies_dead?
        delete_targetf
        return
      end
      use_predefined_tool
      return
    end
    
    # si la skill es para un enemigo continuar
    if @targeted_character != nil
      use_predefined_tool
      return if @targeted_character.nil?
      # reset if the target is dead
      if @targeted_character.collapsing?
        force_cancel_actions
        delete_targetf
      end
    else
      # select a follower slected target
      $game_player.followers.each do |follower|
        if !follower.targeted_character.nil?
          next if follower.targeted_character.is_a?(Game_Player)
          if follower.stuck_timer >= 10
            follower.targeted_character = nil
            return
          end
          @targeted_character = follower.targeted_character
          break
        end
      end
    end
  end
  
  # prepare the tool usage
  def setup_followertool_usage
    @range_view = 2
    @range_view = 6 if fo_tool.tool_data("Tool Target = ", false) == "true" ||
    fo_tool.tool_data("Tool Special = ", false) == "autotarget"
    
    if fo_tool.is_a?(RPG::Skill) || fo_tool.is_a?(RPG::Item)
      if fo_tool.scope.between?(1, 6)
        setup_target 
      else ; @targeted_character = $game_player
        @range_view = 6
      end
      # prepare tool for invoke follower
    elsif fo_tool.is_a?(RPG::Weapon) || fo_tool.is_a?(RPG::Armor)
      invoke = fo_tool.tool_data("Tool Invoke Skill = ")
      if invoke > 0
        if $data_skills[invoke].scope.between?(1, 6)
          setup_target
        else ; @targeted_character = $game_player
          @range_view = 6
        end
      else
        # no invoke skill just set up an enemy target
        setup_target
      end
    end
  end
  
  # use the predifined tool
  def use_predefined_tool
    update_follower_movement
    return if @targeted_character.nil?
    if obj_size?(@targeted_character, @range_view) && @follower_attacktimer == 0
      turn_toward_character(@targeted_character) 
      use_weapon(fo_tool.id) if actor.primary_use == 1 
      use_armor(fo_tool.id)  if actor.primary_use == 2
      use_item(fo_tool.id)   if actor.primary_use == 3 || actor.primary_use == 4 ||
      actor.primary_use == 5 || actor.primary_use == 6
                            
      use_skill(fo_tool.id)  if actor.primary_use==7 || actor.primary_use==8 ||
      actor.primary_use == 9 || actor.primary_use == 10
      
      if fo_tool.tool_data("User Graphic = ", false).nil?
        @targeted_character = nil
        turn_toward_player
      end
      @follower_attacktimer = 60
    end
    delete_targetf if self.actor.dead?
  end
  
  def all_enemies_dead?
    for event in $game_map.event_enemies
      if event.on_battle_screen? && event.enemy_ready?
        return false if $game_player.obj_size?(event,PearlKernel::PlayerRange+1)
      end
    end
    return true
  end
  
  def delete_targetf
    @targeted_character = nil
  end
  
  #------------------------
  # follower movement attack
  def reset_targeting_settings(target)
    target.being_targeted = false if target.is_a?(Game_Event)
    delete_targetf
    turn_toward_player
    @stuck_timer = 0
  end
  
  def update_follower_movement
    target = @targeted_character
    if @stuck_timer >= 30
      reset_targeting_settings(target)
      return
    end
    
    # if the follower is unabble to use the tool
    unless usable_test_passed?(fo_tool)
      if SceneManager.scene_is?(Scene_Map)
        reset_targeting_settings(target)
        @balloon_id = PearlKernel::FailBalloon
        return
      end
    end
    
    return if target.nil?
    @stuck_timer += 1 if !obj_size?(target, @range_view) and !moving?
  
    if moving? || @anime_speed > 0 || @making_spiral || @hookshoting[0] ||
      @knockdown_data[0] > 0
      @stuck_timer = 0
    end
    return if moving?
    if fo_tool.tool_data("Tool Target = ", false) == "true" || 
      fo_tool.tool_data("Tool Special = ", false) == "autotarget" ||
      target.is_a?(Game_Player)
      # using skill con target true magical
      cpu_reactiontype(1, target)
      return 
      # target not exist
    else
    
      if fo_tool.is_a?(RPG::Skill) || fo_tool.is_a?(RPG::Item)
        fo_tool.scope.between?(1, 6) ? cpu_reactiontype(2, target) : # to enemy
        cpu_reactiontype(1, target) # benefical
      else
        # for weapon armor without target
        cpu_reactiontype(2, target)
      end
    end
    return if !obj_size?(target, @range_view)
    return if target.is_a?(Game_Player)
    case rand(40)
    when 4  then move_backward
    when 10 then move_random
    end
  end
  
  # cpu reaction
  def cpu_reactiontype(type, target)
    unless on_battle_screen?
      3.times.each {|i|  move_toward_player}
      return
    end
    move_toward_character(target) if !obj_size?(target, @range_view) if type==1
    if @follower_attacktimer == 0 || !obj_size?(target, @range_view)
      move_toward_character(target) if type == 2
    end
  end
  #-------------------------------------------------
  
  # buff timer 
  def update_buff_timing
    battler.buff_turns.each do |id, value|
      if battler.buff_turns[id] > 0
        battler.buff_turns[id] -= 1
        if battler.buff_turns[id] <= 0
          battler.remove_buff(id)
          pop_damage
        end
      end
    end
  end
  
  #blow power effect
  def update_blow_power_effect
    if @blowpower[4] > 0
      @blowpower[4] -= 1
      if @blowpower[4] == 0
        @direction_fix = @blowpower[2]
        @move_speed = @blowpower[3]
      end
    end
    if @blowpower[0] > 0 and !moving?
      @move_speed = 5.5
      @direction_fix = true
      move_straight(@blowpower[1]); @blowpower[0] -= 1
      if @blowpower[0] == 0
        @blowpower[4] = 10
      end
    end
  end
  
  # Pearl timing
  def update_pearlabs_timing
    @just_hitted -= 1 if @just_hitted > 0
    @stopped_movement -= 1 if @stopped_movement > 0
    @doingcombo -= 1 if @doingcombo > 0
    # hookshooting
    if @hookshoting[3] > 0
      @hookshoting[3] -= 1
      if @hookshoting[3] == 0
        @hookshoting = [false, false, false, 0] 
        @user_move_distance[3].being_grabbed = false if
        @user_move_distance[3].is_a?(Game_Event)
        @user_move_distance[3] = nil
      end
    end
    update_buff_timing
    update_blow_power_effect
    # anime 
    if @anime_speed > 0
      @pattern = 0 
      @anime_speed -= 1
    end
    # casting
    if @user_casting[0] > 0
      @user_casting[0] -= 1
      load_abs_tool(@user_casting[1]) if @user_casting[0] == 0 
    end
    update_knockdown
  end
  
  # Update battler collapse
  def update_battler_collapse
    if @colapse_time > 0
      @colapse_time -= 1 
      force_cancel_actions
      if battler.is_a?(Game_Actor)
        Sound.play_actor_collapse if @secollapse.nil?
        @secollapse = true
        if @colapse_time == 0
          @secollapse = nil
          for event in $game_map.event_enemies 
            if event.agroto_f == self
              event.agroto_f = nil
            end
          end
          
          member = $game_party.battle_members
          # swap and reset player
          if self.is_a?(Game_Player)
            reset_knockdown_actors
            battler.deadposing=$game_map.map_id if PearlKernel::FollowerDeadPose
            $game_party.swap_order(0,3) if !member[3].nil? and !member[3].dead?
            $game_party.swap_order(0,2) if !member[2].nil? and !member[2].dead?
            $game_party.swap_order(0,1) if !member[1].nil? and !member[1].dead?
            
            # wap followers
          else
            if PearlKernel::FollowerDeadPose
              battler.deadposing = $game_map.map_id
              if !$game_player.follower_fighting? and member.size > 2
                swap_dead_follower
              else
                $game_player.reserved_swap << battler.id if member.size > 2
              end
            end
          end
        end
        
      elsif battler.is_a?(Game_Enemy)
        @die_through = @through if @die_through.nil?
        @through = true
        apply_collapse_anime(battler.collapse_type)
        @secollapse = true
        battler.object ? @transparent = true : @opacity -= 2 if !@deadposee
        if @colapse_time == 0
          self.kill_enemy
        end
      end
    end
  end
  
  def swap_dead_follower
    reset_knockdown_actors
    member = $game_party.battle_members
    count = 0
    member.size.times.each {|i|
    break if member[i] == self.actor
    count += 1}
    alive = []
    member.each {|m| alive << m.id unless m.dead?}
    case member.size
    when 3
      return if count == 2
      $game_party.swap_order(alive.size, count)
    when 4
      return if count == 3
      $game_party.swap_order(alive.size, count)
    end
  end
  
  def apply_collapse_anime(type)
    # sound and animation
    if battler.die_animation != nil
      @animation_id = battler.die_animation if @secollapse.nil?
    else
      Sound.play_enemy_collapse if @secollapse.nil? and !battler.object
    end
    return if battler.object
    if @deadposee
      @knockdown_data[0] = 8
      return
    end
    type = PearlKernel::DefaultCollapse if type.nil?
    case type.to_sym
    when :zoom_vertical
      @zoomfx_x -= 0.03
      @zoomfx_y += 0.02
    when :zoom_horizontal
      @zoomfx_x += 0.03
      @zoomfx_y -= 0.02
    when :zoom_maximize
      @zoomfx_x += 0.02
      @zoomfx_y += 0.02
    when :zoom_minimize
      @zoomfx_x -= 0.02
      @zoomfx_y -= 0.02
    end
  end
  
  # konck down engine update
  def update_knockdown
    if @knockdown_data[0] > 0
      @knockdown_data[0] -= 1
      @knockdown_data[0] == 0 ? knowdown_effect(2) : knowdown_effect(1)
      if @knockdown_data[1] != nil
        @pattern = @knockdown_data[2]
        @direction = @knockdown_data[3]
      end
    end
  end
  
  def knowdown_effect(type)
    return if self.is_a?(Projectile)
    if type[0] == 1
      if @knockdown_data[1] == nil
        if battler.is_a?(Game_Enemy)
          if self.knockdown_enable
            force_cancel_actions
            self_sw = PearlKernel::KnockdownSelfW
            $game_self_switches[[$game_map.map_id, self.id, self_sw]] = true
            @knockdown_data[1] = self_sw
            self.refresh
            @knockdown_data[2] = self.page.graphic.pattern
            @knockdown_data[3] = self.page.graphic.direction
            $game_map.screen.start_shake(7, 4, 20)
          end
          
          @knockdown_data[0] = 0 if @knockdown_data[1] == nil
       elsif battler.is_a?(Game_Actor)
         if PearlKernel.knock_actor(self.actor) != nil and
           if @knockdown_data[1] == nil
             force_cancel_actions
             @knockdown_data[1] = @character_name
             @knockdown_data[4] = @character_index
             @character_name = PearlKernel.knock_actor(self.actor)[0]
             @character_index = PearlKernel.knock_actor(self.actor)[1]
             @knockdown_data[2] = PearlKernel.knock_actor(self.actor)[2]
             @knockdown_data[3] = PearlKernel.knock_actor(self.actor)[3]
             $game_map.screen.start_shake(7, 4, 20) if battler.deadposing.nil?
           end
         end
         @knockdown_data[0] = 0 if @knockdown_data[1] == nil
        end
      end
    elsif type == 2
      if battler.is_a?(Game_Enemy)
        if @deadposee and battler.dead?
          @knockdown_data[1] = nil
          return 
        end
        $game_self_switches[[$game_map.map_id, self.id, 
        @knockdown_data[1]]] = false if @knockdown_data[1] != nil
        @knockdown_data[1] = nil
      else
        @character_name = @knockdown_data[1]
        @character_index = @knockdown_data[4]
        @knockdown_data[1] = nil
      end
    end
  end
  
  #================================
  # states
  def primary_state_ani
    return nil if battler.states[0].nil?
    return battler.states[0].tool_data("State Animation = ")
  end
  
  # higer priority state animation displayed
  def update_state_effects
    @state_poptimer[0] += 1 unless primary_state_ani.nil?
    if @state_poptimer[0] == 30
      @animation_id = primary_state_ani
      @animation_id = 0 if @animation_id.nil?
    elsif @state_poptimer[0] == 180
      @state_poptimer[0] = 0
    end
    update_state_action_steps 
  end
  
  # update state actions
  def update_state_action_steps
    for state in battler.states
      if state.remove_by_walking
        if !battler.state_steps[state.id].nil? &&
          battler.state_steps[state.id] > 0
          battler.state_steps[state.id] -= 1 
        end
        if battler.state_steps[state.id] == 0
          battler.remove_state(state.id)
          pop_damage
        end
      end
      if state.restriction == 4
        @stopped_movement = 10
        @pattern = 2 if @knockdown_data[0] == 0
      end
      state.features.each do |feature|
        if feature.code == 22 
          @knockdown_data[0] =10 if state.restriction == 4 && feature.data_id==1
          next unless feature.data_id.between?(7, 9)
          apply_regen_state(state, feature.data_id)
        end
      end
    end
  end
  
  # apply regen for hp, mp and tp
  def apply_regen_state(state, type)
    random = state.tool_data("State Effect Rand Rate = ") 
    random = 120 if random.nil?
    if rand(random) == 1
      battler.regenerate_hp if type == 7
      battler.regenerate_mp if type == 8
      battler.regenerate_tp if type == 9
      if type == 7 and battler.result.hp_damage == 0
        @colapse_time = 80
        battler.add_state(1)
        return
      end
      type == 9 ? pop_damage("Tp Up!") : pop_damage
    end
  end
  
  alias falcaopearl_update_anime_pattern update_anime_pattern
  def update_anime_pattern
    return if @anime_speed > 0 || @knockdown_data[0] > 0
    falcaopearl_update_anime_pattern
  end
  
  #=============================================================================
  # Reset Pearl ABS System
  
  # reset from game player call
  def reset_knockdown_actors
    # reset knock down
    if @knockdown_data[1] != nil
      @knockdown_data[0] = 0
      knowdown_effect(2)
    end
    # force clear knock down
    $game_player.followers.each do |follower|
      if follower.knockdown_data[1] != nil
        follower.knockdown_data[0] = 0
        follower.knowdown_effect(2)
      end
    end
  end
  
  # reset knockdown enemies game player call
  def reset_knockdown_enemies
    $game_map.events.values.each do |event|
      if event.knockdown_data[1] != nil
        event.knockdown_data[0] = 0
        event.knowdown_effect(2)
      end
      if event.deadposee and event.killed
        $game_self_switches[[$game_map.map_id, event.id,
        PearlKernel::KnockdownSelfW]] = false
      end
    end
  end
  
  # glabal reseting
  def pearl_abs_global_reset
    force_cancel_actions
    battler.remove_state(9) if @battler_guarding[0]
    @battler_guarding = [false, nil]
    @making_spiral = false
    set_hook_variables
    @using_custom_g = false
    $game_player.followers.each do |f|
      f.targeted_character = nil if !f.targeted_character.nil?
      f.stuck_timer = 0 if f.stuck_timer > 0
      f.follower_attacktimer = 0 if f.follower_attacktimer > 0
      f.force_cancel_actions unless f.visible?
      f.battler.remove_state(9) if f.battler_guarding[0]
      f.battler_guarding = [false, nil]
      f.set_hook_variables
      f.making_spiral = false
    end
    reset_knockdown_actors
    reset_knockdown_enemies
    $game_player.projectiles.clear
    $game_player.damage_pop.clear
    $game_player.anime_action.clear
    $game_player.enemy_drops.clear
    @send_dispose_signal = true
  end
end

#===============================================================================
# Evets as enemies registration

class Game_Event < Game_Character
  attr_accessor :enemy, :move_type, :page, :deadposee
  attr_accessor :being_targeted, :agroto_f, :draw_drop, :dropped_items
  attr_accessor :start_delay, :epassive, :erased, :killed, :boom_grabdata
  attr_reader   :token_weapon, :token_armor,:token_item,:token_skill,:boom_start
  attr_reader   :hook_pull, :hook_grab, :event, :knockdown_enable, :boom_grab
  alias falcaopearlabs_iniev initialize
  def initialize(map_id, event)
    @inrangeev = nil
    @being_targeted = false
    @agroto_f = nil
    @draw_drop = false
    @dropped_items = []
    @epassive = false
    @touch_damage = 0
    @start_delay = 0
    @touch_atkdelay = 0
    @killed = false
    @knockdown_enable = false
    @deadposee = false
    create_token_arrays
    falcaopearlabs_iniev(map_id, event)
    register_enemy(event)
  end
  
  def create_token_arrays
    @token_weapon = []
    @token_armor  = []
    @token_item   = []
    @token_skill  = []
  end
  
  alias falcaopearl_setup_page_settings setup_page_settings
  def setup_page_settings
    create_token_arrays
    falcaopearl_setup_page_settings
    wtag = string_data("<start_with_weapon: ")
    @token_weapon = wtag.split(",").map { |s| s.to_i } if wtag != nil
    atag = string_data("<start_with_armor: ")
    @token_armor = atag.split(",").map { |s| s.to_i } if atag != nil
    itag = string_data("<start_with_item: ")
    @token_item = itag.split(",").map { |s| s.to_i } if itag != nil
    stag = string_data("<start_with_skill: ")
    @token_skill = stag.split(",").map { |s| s.to_i } if stag != nil
    @hook_pull = string_data("<hook_pull: ") == "true"
    @hook_grab = string_data("<hook_grab: ") == "true"
    @boom_grab = string_data("<boom_grab: ") == "true"
    @boom_start = string_data("<boomed_start: ") == "true"
    @direction_fix = false if @hook_grab
    if has_token? || @hook_pull || @hook_grab || @boom_grab || @boom_start
      $game_map.events_withtags.push(self) unless
      $game_map.events_withtags.include?(self)
    end
  end
  
  def has_token?
    !@token_weapon.empty? || !@token_armor.empty? || !@token_item.empty? ||
    !@token_skill.empty?
  end
  
  def register_enemy(event)
    @enemy  = Game_Enemy.new(0, $1.to_i) if event.name =~ /<enemy: (.*)>/i
    if @enemy != nil
      passive = @enemy.enemy.tool_data("Enemy Passive = ", false)
      @epassive = true if passive == "true"
      touch = @enemy.enemy.tool_data("Enemy Touch Damage Range = ")
      @sensor = @enemy.esensor
      @touch_damage = touch if touch != nil
      $game_map.event_enemies.push(self) # new separate enemy list
      $game_map.enemies.push(@enemy)     # just enemies used in the cooldown
      @event.pages.each do |page|
        if page.condition.self_switch_valid and
          page.condition.self_switch_ch == PearlKernel::KnockdownSelfW
          @knockdown_enable = true
          break
        end
      end
      pose = @enemy.enemy.tool_data("Enemy Dead Pose = ", false) == "true"
      @deadposee = true if pose and @knockdown_enable
    end
  end
  
  def update_state_effects
    @killed ? return : super
  end
  
  def collapsing?
    return true if @killed || @colapse_time > 0
    return false
  end
  
  def enemy_ready?
    return false if @enemy.nil? || @page.nil? || collapsing? || @enemy.object
    return true
  end
  
  def battler
    return @enemy
  end
  
  def apply_respawn
    return if @colapse_time > 0
    @draw_drop = false
    @dropped_items.clear
    @through = @die_through
    @through = false if @through.nil?
    @die_through = nil
    @secollapse = nil
    @colapse_time = 0
    @erased = false ; @opacity = 255
    @zoomfx_x = 1.0 ; @zoomfx_y = 1.0
    @killed = false
    @priority_type = 1 if @deadposee
    resetdeadpose
    refresh
  end
  
  def resetdeadpose
    if @deadposee
      $game_self_switches[[$game_map.map_id, @id,
      PearlKernel::KnockdownSelfW]] = false
    end
  end
  
  def kill_enemy
    @secollapse = nil
    @killed = true
    @priority_type = 0 if @deadposee
    gain_exp
    gain_gold
    etext = 'Exp '  + @enemy.exp.to_s if @enemy.exp > 0
    gtext = 'Gold ' + @enemy.gold.to_s if @enemy.gold > 0
    $game_player.pop_damage("#{etext} #{gtext}") if etext || gtext
    make_drop_items
    run_assigned_commands
  end
  
  def run_assigned_commands
    transform = @enemy.enemy.tool_data("Enemy Die Transform = ")
    switch = @enemy.enemy.tool_data("Enemy Die Switch = ")
    $game_switches[switch] = true if switch != nil
    variable = @enemy.enemy.tool_data("Enemy Die Variable = ")
    $game_variables[variable] += 1 if variable != nil
    self_sw = @enemy.enemy.tool_data("Enemy Die Self Switch = ", false)
    $game_map.event_enemies.delete(self) if @enemy.object
    $game_map.enemies.delete(self) if @enemy.object
    if self_sw.is_a?(String)
      $game_self_switches[[$game_map.map_id, self.id, self_sw]] = true
      apply_respawn
      @enemy = nil
    else
      erase unless @deadposee
    end
    if transform != nil
      @enemy = Game_Enemy.new(0, transform) 
      apply_respawn
    end
  end
  
  def make_drop_items
    @dropped_items = @enemy.make_drop_items
    unless @dropped_items.empty?
      $game_player.enemy_drops.push(self)
      $game_map.events_withtags.push(self) unless 
      $game_map.events_withtags.include?(self)
    end
  end
  
  def gain_exp
    return if @enemy.exp == 0
    $game_party.all_members.each do |actor|
      actor.gain_exp(@enemy.exp)
    end
  end
  
  def gain_gold
    return if @enemy.gold == 0
    $game_party.gain_gold(@enemy.gold)
  end
  
  alias falcaopearlabs_updatev update
  def update
    @start_delay -= 1 if @start_delay > 0
    @touch_atkdelay -= 1 if @touch_atkdelay > 0
    update_enemy_sensor unless @enemy.nil?
    update_enemy_touch_damage unless @enemy.nil?
    falcaopearlabs_updatev
  end
  
  def update_enemy_touch_damage
    return unless @touch_damage > 0
    return if @epassive || @killed
    return if @touch_atkdelay > 0
    unless @enemy.object
      @agroto_f.nil? ? target = $game_player : target = @agroto_f
    else
      target = $game_player
      $game_player.followers.each do |follower|
        next unless follower.visible?
        if obj_size?(follower, @touch_damage) and !follower.battler.dead?
          execute_touch_damage(follower)
        end
      end
    end
    execute_touch_damage(target) if obj_size?(target, @touch_damage)
  end
  
  def execute_touch_damage(target)
    target.battler.attack_apply(@enemy)
    target.pop_damage
    @touch_atkdelay = 50
    target.colapse_time = 60 if target.battler.dead?
    return if target.battler.result.hp_damage == 0
    target.jump(0, 0)
  end
  
  # enemy sensor
  def update_enemy_sensor
    return if @hookshoting[0]
    return if @epassive
    if @sensor != nil
      @agroto_f.nil? ? target = $game_player : target = @agroto_f
      if obj_size?(target, @sensor)
        data = [$game_map.map_id, @id, PearlKernel::Enemy_Sensor]
        if @inrangeev.nil? and !$game_self_switches[[data[0], data[1],
          data[2]]]
          $game_self_switches[[data[0], data[1], data[2]]] = true
          @inrangeev = true
        end
      elsif @inrangeev != nil
        data = [$game_map.map_id, @id, PearlKernel::Enemy_Sensor]
        if $game_self_switches[[data[0], data[1], data[2]]]
          $game_self_switches[[data[0], data[1], data[2]]] = false
          @inrangeev = nil
        end
      end
    end
  end
  
  # on battle pixel, take a lot of time procesing, but it is very exact
  def on_battle_pixel?(out=0)
    w = Graphics.width + out; h = Graphics.height + out
    return true if screen_x.between?(0 - out,w) and screen_y.between?(0 - out,h)
    return false
  end

  def cmt_data(comment)
    return 0 if @list.nil? or @list.size <= 0
    for item in @list
      if item.code == 108 or item.code == 408
        return $1.to_i if item.parameters[0] =~ /#{comment}(.*)>/i
      end
    end
    return 0
  end
  
  def string_data(comment)
    return nil if @list.nil? or @list.size <= 0
    for item in @list
      if item.code == 108 or item.code == 408
        return $1.to_s if item.parameters[0] =~ /#{comment}(.*)>/i
      end
    end
    return nil
  end
  
  # stop event movement
  alias falcaopearl_update_self_movement update_self_movement
  def update_self_movement
    return if !@boom_grabdata.nil?
    return if force_stopped? || @colapse_time > 0 || @blowpower[0] > 0
    falcaopearl_update_self_movement
  end
end
#===============================================================================

# mist
class Game_Map
  attr_reader   :map
  attr_accessor :event_enemies, :enemies, :events_withtags
  alias falcaopearl_enemycontrol_ini initialize
  def initialize
    @event_enemies = []
    @enemies = []
    @events_withtags = []
    falcaopearl_enemycontrol_ini
  end
  
  alias falcaopearl_enemycontrol_setup setup
  def setup(map_id)
    @event_enemies.clear
    @enemies.clear
    @events_withtags.clear
    falcaopearl_enemycontrol_setup(map_id)
    if $game_temp.loadingg != nil
      @event_enemies.each do |event|
        event.resetdeadpose
      end
      $game_temp.loadingg = nil
    end
  end
  
  alias falcaopearl_damage_floor damage_floor?
  def damage_floor?(x, y)
    return if $game_player.hookshoting[1]
    falcaopearl_damage_floor(x, y)
  end
end

class Game_Temp
  attr_accessor :pop_windowdata, :loadingg
  def pop_w(time, name, text)
    return unless @pop_windowdata.nil?
    @pop_windowdata = [time, text, name]
  end
end

class Game_Party < Game_Unit
  alias falcaopearl_swap_order swap_order
  def swap_order(index1, index2)
    unless SceneManager.scene_is?(Scene_Map)
      if $game_player.in_combat_mode?
        $game_temp.pop_w(180, 'Pearl ABS', 
        'You cannot switch player while in combat!')
        return
      elsif $game_player.any_collapsing?
        $game_temp.pop_w(180, 'Pearl ABS', 
        'You cannot switch player while collapsing!')
        return
      elsif $game_party.battle_members[index2].deadposing != nil
         $game_temp.pop_w(180, 'Pearl ABS', 
        'You cannot move a dead ally!')
        return
      end
    end
    falcaopearl_swap_order(index1, index2)
  end
end

class << DataManager
  alias falcaopearl_extract extract_save_contents
  def DataManager.extract_save_contents(contents)
    falcaopearl_extract(contents)
    $game_temp.loadingg = true
  end
end
