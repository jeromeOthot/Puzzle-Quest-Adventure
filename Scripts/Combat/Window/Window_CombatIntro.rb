#------------------------------------------------------------------------------
#  Affiche l'intro d'un combat
#==============================================================================
class Window_CombatIntro < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize()
    super(0, 0, 640, 480)
    back_opacity = 255
    contents_opacity = 255
    draw_background
    draw_hero
    draw_enemy
    draw_vs
  end
  
  #--------------------------------------------------------------------------
  # Dessine le background de la présentation du combat
  #--------------------------------------------------------------------------
  def draw_background
   #bitmap_board = $data_troops[1]
   #bitmap_board =  $game_map.battleback1_name 
   #bitmap_board = $data_mapinfos[1].battleback1_name 
   #self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 216, 216))
#   puts("background: " + $data_mapinfos[1].battleback1_name )
   #source = SceneManager.background_bitmap
   
   #$game_map.setup(16)  --> Bug a cette ligne
   
    backGround1 = Bitmap.new("Graphics/Battlebacks1/DecorativeTile") #+ $game_map.battleback1_name) 
    #bitmap = Bitmap.new(540, 410)
   # bitmap.stretch_blt(bitmap.rect, backGround1, backGround1.rect)
    #bitmap.radial_blur(120, 16)
    self.z = 100
    self.contents.blt(2, 2, backGround1, Rect.new(0, 0, 640, 480))
    
    
    backGround2 = Bitmap.new("Graphics/Battlebacks2/DarkSpace") #+ $game_map.battleback2_name) 
    self.z = 100
    self.contents.blt(2, 2, backGround2, Rect.new(0, 0, 640, 480))
   
   #refresh()
 end
 
 def draw_hero
    bitmap_heroFace = Bitmap.new("Graphics/Battlers/Hero_m")
   self.z = 200
   self.contents.blt(0, 108, bitmap_heroFace, Rect.new(0, 0, 250, 200))
 end  
 
 def draw_enemy
   bitmap_heroFace = Bitmap.new("Graphics/Battlers/Minotaur")
   self.z = 200
   self.contents.blt(385, 108, bitmap_heroFace, Rect.new(0, 0, 250, 200))
 end
 
 def draw_vs
   bitmap_vs = Bitmap.new("Graphics/Pictures/Vs_Big")
   self.z = 200
   self.contents.blt(270, 158, bitmap_vs, Rect.new(0, 0, 100, 100))
 end
end