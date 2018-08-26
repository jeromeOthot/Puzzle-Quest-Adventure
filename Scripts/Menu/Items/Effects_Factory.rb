############################################################################
#                  Classe qui crée les effets selon leur type et valeur
############################################################################
class Effects_Factory
  EFFECT_LIFE = 1
  EFFECT_FIRE_MANA = 2
  EFFECT_WATER_MANA = 3
  EFFECT_EARTH_MANA = 4
  EFFECT_WIND_MANA = 5
  
  def create_effect(noEffect, value, isSuffix)
     case noEffect
     when 0
       
     #Effet life  
     when 1 # EFFECT_LIFE
        Effect_Life.new(value, isSuffix)
     when 2 #EFFECT_FIRE_MANA
        Effect_Fire_Mana.new(value, isSuffix)
     when 3 ##EFFECT_WATER_MANA
        Effect_Water_Mana.new(value, isSuffix)
     when 4 #EFFECT_EARTH_MANA
        Effect_Earth_Mana.new(value, isSuffix)
     when 5 #EFFECT_WIND_MANA
        Effect_Wind_Mana.new(value, isSuffix)
     when 6

     when 7

     when 8
 
     when 10

     when 11

     when 12

     when 13

     when 20

     when 21

     when 22

    when 23
 
    when 24

    when 25
       
    when 26

     end
  end
end