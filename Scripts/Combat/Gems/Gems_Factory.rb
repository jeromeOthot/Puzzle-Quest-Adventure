############################################################################
#                  Classe qui crée les gemme selon le type
############################################################################
class Gems_Factory
 
  
  def create_gem(type, x, y, boardX, boardY)
  
     case type
     when 0
       Void_Gem.new(x, y, boardX, boardY)
     when 1
       Fire_Gem.new(x, y, boardX, boardY)
     when 2
       Water_Gem.new(x, y, boardX, boardY)
     when 3
       Earth_Gem.new(x, y, boardX, boardY)
     when 4
       Wind_Gem.new(x, y, boardX, boardY)
     when 5
       Gold_Gem.new(x, y, boardX, boardY)
     when 6
       Exp_Gem.new(x, y, boardX, boardY)
     when 7
       Ice_Gem.new(x, y, boardX, boardY)
     when 8
       Thunder_Gem.new(x, y, boardX, boardY)
	 when 9
        Dark_Gem.new(x, y, boardX, boardY)
     when 10
       Skull_Gem.new(x, y, boardX, boardY)
     when 11
       Skull5_Gem.new(x, y, boardX, boardY)
     when 12
       Skull10_Gem.new(x, y, boardX, boardY)
     when 13
       Skull20_Gem.new(x, y, boardX, boardY)
     when 20
       Multi_Gem.new(x, y, 2, boardX, boardY)
     when 21
       Multi_Gem.new(x, y, 3, boardX, boardY)
     when 22
       Multi_Gem.new(x, y, 4, boardX, boardY)
    when 23
       Multi_Gem.new(x, y, 5, boardX, boardY)
    when 24
       Multi_Gem.new(x, y, 6, boardX, boardY)
    when 25
       Multi_Gem.new(x, y, 7, boardX, boardY)
    when 26
       Multi_Gem.new(x, y, 8, boardX, boardY)
#~      when 10
#~        Dark_Gem.new(x, y)
#~      when 13
#~        Light_Gem.new(x, y)
     when 100
       Unknow_Gem.new(x, y, boardX, boardY)
     end
  end
  
  
end