#==============================================================================
# ** Vector2D
#------------------------------------------------------------------------------
# Cette classe represente un vecteur mathematique dans un plan cartesien
# La direction du vecteur est determiner selon l'angle par rapport a  l'axe des x 
# allant de 0 a 360 degree. Est = 0, Nord = 90, Ouest = 180, Sud = 270
#==============================================================================
class Vector2D
  attr_accessor :length
  attr_accessor :direction
  attr_accessor :i          #vecteur unitaire i qui correspond a l'axe des x
  attr_accessor :j          #vecteur unitaire j qui correspond a l'axe des y
 # attr_accessor :sens
  
  #Constantes pour les principales directions
  EAST = 0
  NORTH_EAST = 45
  NORTH = 90
  NORTH_WEST = 135
  WEST = 180
  SOUTH_WEST = 225
  SOUTH = 270
  SOUTH_EAST = 315
  
  RADIAN_TO_DEGREE = 0.017453292519943 # Un degree = 0.17453292519943 RAD
  
  #------------------------------------------------------------------------------
  # Initialise un vecteur 2D avec une longueur et une direction
  #------------------------------------------------------------------------------
  def initialize( length = 0, direction = 0)
    @length = length
    @direction = direction
    
    @i =  Math.cos( degreToRadian( @direction ) ) * @length
    #@j = 0
    @j =  (Math.sin( degreToRadian( @direction ) ) * @length )*(-1) #*(-1) a cause du sytem axe en y inverse
     puts("vector unitaire: " + i.to_s + " " + j.to_s)
  end
  
  #------------------------------------------------------------------------------
  # Initialise un vecteur 2D avec une longueur et une direction
  #------------------------------------------------------------------------------
  def initializeWithPoint( point )
    pointOrigin = Point2D.new(0,0)
    @length = pointOrigin.distance( point )
    @direction = getDirectionWith2Point(pointOrigin, point)
    @i =  point.x
    @j =  point.y * (-1) #a cause de l'axe y inverse
  end
  
  #------------------------------------------------------------------------------
  # Initialise un vecteur 2D avec une longueur et une direction
  #------------------------------------------------------------------------------
  def initializeWith2Points( point1, point2 )
    @length = point1.distance( point2 )
    @direction = getDirectionWith2Point(point1, point2)
    @i =  point2.x - point1.x
    @j = (point2.y - point1.y)*(-1) #a cause de l'axe y inverse
  end
  
  
    #------------------------------------------------------------------------------
  # les operateurs
  #------------------------------------------------------------------------------
  #Operateur = 
  def Vector2D=(other); 
    if(self && other)
      self.length = other.length
      self.direction = other.direction
    end
  end 
  
  #Operateur == 
  def == (other); 
    if(self && other)
      self.length == other.length && self.direction == other.direction
    end
  end 
  
  #Operateur != 
  def != (other); 
    if(self && other)
      self.length != other.length || self.direction != other.direction
    end
  end 
  
  #Operateur +  equivalent a addition 
  def + (other); 
    if(self && other)
      i = self.i + other.i
      j = self.j + other.j
      pt = Point2D.new(i, j)
      vectorAdd = Vector2D.new( 0, 0 )
      vectorAdd.initializeWithPoint( pt )
    end
  end 
  
  #Operateur -  equivalent a soustraction 
  def - (other); 
    if(self && other)
      i = other.i - self.i 
      j = other.j - self.j
      pt = Point2D.new(i, j)
      vectorAdd = Vector2D.new( 0, 0 )
      vectorAdd.initializeWithPoint( pt )
    end
  end 
  
  #------------------------------------------------------------------------------
  # Determine si le vecteur est nul, soit la distance = 0 
  #------------------------------------------------------------------------------
  def null?
    if( @length == 0 )
      return true
    else
      return false
    end
  end
  
  #------------------------------------------------------------------------------
  # Determine si les 2 vecteurs sont parallele
  #------------------------------------------------------------------------------
  def parallel?( vector2 )
    if( crossProduct( vector2 ) == 0 )
      return true
    else
      return false
    end
  end
  
  #------------------------------------------------------------------------------
  # Determine si les 2 vecteurs sont perpendiculaire
  #------------------------------------------------------------------------------
  def perpendicular?( vector2 )
    if( dotProduct( vector2 ) == 0 )
      return true
    else
      return false
    end
  end
  
  #------------------------------------------------------------------------------
  # Permet d'obtenir la direction du vecteur a partir de 2 points
  #------------------------------------------------------------------------------
  def getDirectionWith2Point(point1, point2)
    radian = Math.atan( point1.distanceY(point2) / point1.distanceX(point2) )
    return radianToDegre( radian )
  end
  
  #------------------------------------------------------------------------------
  # Permet d'obtenir l'angle le plus petit entre 2 vecteurs 
  #------------------------------------------------------------------------------
  def getAngleOf2Vector(vector2)
    angleRad = Math.acos(  self.dotProduct( vector2 ) / ( @length * vector2.length ) )
    angle = radianToDegre( angleRad )
    
    return angle
  end
  
  #------------------------------------------------------------------------------
  # Transforme un angle radian en degree
  #------------------------------------------------------------------------------
  def radianToDegre( radian )
    return radian / RADIAN_TO_DEGREE
  end
  
  #------------------------------------------------------------------------------
  # Transforme un angle degree en radian
  #------------------------------------------------------------------------------
  def degreToRadian( degree )
    return degree * RADIAN_TO_DEGREE
  end
  
  #------------------------------------------------------------------------------
  # Donne un vecteur resultant de l'addition de 2 vecteur
  #------------------------------------------------------------------------------
  def addition( vector2 )
    i = @i + vector2.i
    j = @j + vector2.j
    pt = Point2D.new(i, j)
    vectorAdd = Vector2D.new( 0, 0 )
    vectorAdd.initializeWithPoint( pt )
    
    return vectorAdd 
  end
  
  #------------------------------------------------------------------------------
  # Donne un vecteur resultant de la soustraction de 2 vecteur
  #------------------------------------------------------------------------------
  def soustraction( vector2 )
    i = vector2.i - @i
    j = vector2.j - @j
    pt = Point2D.new(i, j)
    vectorSoust = Vector2D.new( 0, 0 )
    vectorSoust.initializeWithPoint( pt )
    
    return vectorSoust 
  end
  
  #------------------------------------------------------------------------------
  # Multiplie un vecteur avec un scalaire
  #------------------------------------------------------------------------------
  def ScalarMultiplication( scalaire ) 
    i = @i * scalaire
    j = @j * scalaire
    
    pt = Point2D.new(i, j)
    vectorMultiSca = Vector2D.new( 0, 0 )
    vectorMultiSca.initializeWithPoint( pt )
    
    return vectorMultiSca 
  end
  
  #------------------------------------------------------------------------------
  # Produit scalaire de 2 vecteurs
  #------------------------------------------------------------------------------
  def dotProduct( vector2 )
    i = @i * vector2.i
    j = @j * vector2.j
    
    pt = Point2D.new(i, j)
    vectorDotProduct = Vector2D.new( 0, 0 )
    vectorDotProduct.initializeWithPoint( pt )
    
    return vectorDotProduct 
    
    #@length = Math.sqrt( i**2 + j**2 )
    #@angle =  Math.acos( Math.sqrt( @length / ( @length ) ) 
    #@direction
  end 

  #------------------------------------------------------------------------------
  # Produit vectoriel de 2 vecteurs
  #------------------------------------------------------------------------------
  def crossProduct( vector2 )
    @angle  =  self.getAngleOf2Vector(vector2)
    @lenght =  @length * vector2.length * @angle
    return 0
  end
  
  #------------------------------------------------------------------------------
  # Donne le contenu du vecteur en format string
  #------------------------------------------------------------------------------
  def toString()
    return "Vecteur: (" + @length.to_s + " : " + @direction.to_s + ")" 
  end
  
   def to_s()
    return "Vecteur: (" + @length.to_s + " : " + @direction.to_s + ")" 
  end
  
end