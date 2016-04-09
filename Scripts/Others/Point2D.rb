#==============================================================================
# ** Point2D
#------------------------------------------------------------------------------
# Cette classe repr�sente un point 2D de coordon�e cart�sien en x et y
#==============================================================================
class Point2D
  attr_accessor :x
  attr_accessor :y
  
  def initialize( x =0, y =0)
    @x = x
    @y = y
  end
  
  #Op�rateur = 
  def Point2D=(other); 
    if(self && other)
      self.x = other.x 
      self.y = other.y
    end
  end 
  
  #Op�rateur == 
  def == (other); 
    if(self && other)
      self.x == other.x && self.y == other.y
    end
  end 
  
  #Op�rateur != 
  def != (other); 
    if(self && other)
      self.x != other.x || self.y != other.y
    end
  end 
  
  #--------------------------------------------------------------------------
  # * Affiche les coordonn�es du point en x et y
  #--------------------------------------------------------------------------
  def toString
    return "Point: (" + x.to_s + " : " + y.to_s + ")"
  end
  
  def to_s
    return "Point: (" + x.to_s + " : " + y.to_s + ")"
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance entre le point courant et les coordonn�e x et y pass�e en param�tre
  #--------------------------------------------------------------------------
  def distanceCoord(x2, y2)
    return Math.sqrt( (x2-@x)*(x2-@x) + (y2-@y)*(y2-@y) ) 
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance entre le point courant et un point pass� en param�tre
  #--------------------------------------------------------------------------
  def distance(point)
    return Math.sqrt( distanceX(point)*distanceX(point) + distanceY(point)*distanceY(point) ) 
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance en x entre le point courant et un point pass� en param�tre
  #--------------------------------------------------------------------------
  def distanceX(point)
    return point.x - @x
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance en y entre le point courant et un point pass� en param�tre
  #--------------------------------------------------------------------------
  def distanceY(point)
    return point.y - @y
  end
  
end