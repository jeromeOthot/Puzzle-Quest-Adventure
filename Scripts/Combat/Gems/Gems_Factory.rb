############################################################################
#                  Classe qui cr�e les gemme selon le type
############################################################################
class Gems_Factory
  
  def create_gem(type, x, y)
     case type
     when 0
       Void_Gem.new(x, y)
     when 1
       Fire_Gem.new(x, y)
     when 2
       Water_Gem.new(x, y)
     when 3
       Earth_Gem.new(x, y)
     when 4
       Wind_Gem.new(x, y)
     when 5
       Gold_Gem.new(x, y)
     when 6
       Exp_Gem.new(x, y)
     when 7
       Ice_Gem.new(x, y)
     when 8
       Thunder_Gem.new(x, y)
     when 10
       Skull_Gem.new(x, y)
     when 11
       Skull5_Gem.new(x, y)
     when 12
       Skull10_Gem.new(x, y)
     when 13
       Skull20_Gem.new(x, y)
     when 20
       Multi_Gem.new(x, y, 2)
     when 21
       Multi_Gem.new(x, y, 3)
     when 22
       Multi_Gem.new(x, y, 4)
    when 23
       Multi_Gem.new(x, y, 5)
    when 24
       Multi_Gem.new(x, y, 6)
    when 25
       Multi_Gem.new(x, y, 7)
    when 26
       Multi_Gem.new(x, y, 8)
#~      when 10
#~        Dark_Gem.new(x, y)
#~      when 13
#~        Light_Gem.new(x, y)
     when 100
       Unknow_Gem.new(x, y)
     end
  end
end