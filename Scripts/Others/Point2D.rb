#==============================================================================
# ** Point2D
#------------------------------------------------------------------------------
# Cette classe représente un point 2D de coordonée cartésien en x et y
#==============================================================================
class Point2D
  attr_accessor :x
  attr_accessor :y
  
  def initialize( x =0, y =0)
    @x = x
    @y = y
  end
  
  #Opérateur = 
  def Point2D=(other); 
    if(self && other)
      self.x = other.x 
      self.y = other.y
    end
  end 
  
  #Opérateur == 
  def == (other); 
    if(self && other)
      self.x == other.x && self.y == other.y
    end
  end 
  
  #Opérateur != 
  def != (other); 
    if(self && other)
      self.x != other.x || self.y != other.y
    end
  end 
  
  #--------------------------------------------------------------------------
  # * Affiche les coordonnées du point en x et y
  #--------------------------------------------------------------------------
  def toString
    return "Point: (" + x.to_s + " : " + y.to_s + ")"
  end
  
  def to_s
    return "Point: (" + x.to_s + " : " + y.to_s + ")"
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance entre le point courant et les coordonnée x et y passée en paramètre
  #--------------------------------------------------------------------------
  def distanceCoord(x2, y2)
    return Math.sqrt( (x2-@x)*(x2-@x) + (y2-@y)*(y2-@y) ) 
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance entre le point courant et un point passé en paramètre
  #--------------------------------------------------------------------------
  def distance(point)
    return Math.sqrt( distanceX(point)*distanceX(point) + distanceY(point)*distanceY(point) ) 
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance en x entre le point courant et un point passé en paramètre
  #--------------------------------------------------------------------------
  def distanceX(point)
    return point.x - @x
  end
  
  #--------------------------------------------------------------------------
  # * Calcul la distance en y entre le point courant et un point passé en paramètre
  #--------------------------------------------------------------------------
  def distanceY(point)
    return point.y - @y
  end
  
end