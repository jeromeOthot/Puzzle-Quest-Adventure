class Sprite_Movement < Sprite_Base
  attr_reader    :moving
  def initialize(bitmap, posX, posY, viewport)
    super(viewport)
    @moving = false
    self.bitmap = bitmap #Cache.picture("Vs_Big")
    self.x = posX
    self.y = posY
    self.z = 500
    self.opacity = 255
    @x_float = self.x.to_f
    @y_float = self.y.to_f
    @removeAfterMove = false
    @moving = false
    @time = 0
  end
  
#~   def moveToPosition(dest_x, dest_y, time)
#~     @dest_x = dest_x
#~     @dest_y = dest_y
#~     @time = time
#~     @move_x = @dest_x - self.x
#~     @move_y = @dest_y - self.y
#~     @dx_per_frame = @move_x.to_f / @time
#~     @dy_per_frame = @move_y.to_f / @time
#~     @moving = true
#~   end
  
  def moveToPosition(vectorMove, time)
    @dest_x = self.x + vectorMove.i
    @dest_y = self.y + vectorMove.j
    @time = time
    #@move_x = @dest_x - self.x
    #@move_y = @dest_y - self.y
    @move_x = vectorMove.i
    @move_y = vectorMove.j
    @dx_per_frame = @move_x.to_f / @time
    @dy_per_frame = @move_y.to_f / @time
    @moving = true
  end
  
  def moveWithDistance(distX, distY, time, removeAfterMove)
    #doAnimation(1, false)
    moveToPosition(self.x + distX, self.y + distY, time)
    @removeAfterMove = removeAfterMove
  end
  
  def moveWithVector(vectorMove, time, removeAfterMove)
    #doAnimation(1, false)
    moveToPosition(vectorMove, time)
    @removeAfterMove = removeAfterMove
  end
  
  def update
      if( super )

      else
        return false
      end
      moving_sprite if @moving #&& @compteur % 2 == 0
      @time -= 1
    
      #Permet de déterminer si on doit updater au prochain tour ou pas
      if( @time != 0 )
        return true
      else
        return false
      end
  end
  #--------------------------------------------------------------------------
  # * Deplace le sprite
  #   Le sprite se deplace selon deux positions (x,y) synchronisees, un integer 
  #   et un float. Cela cause des erreurs de precision.
  #   
  #   La variable de classe @time contient le nombre de frame restants au 
  #   deplacement. lors du dernier frame de deplacement, la position est 
  #   ajustee exactement a la destination. Cela permet de corriger les erreurs
  #   de precision des floats. pour plus d'info voir le roman que marc a ecrit qui est situe dans 
  #   le tiroir de mon 2e bureau
  #--------------------------------------------------------------------------
  def moving_sprite
    if (@time == 0)
      self.x = @dest_x
      @x_float = self.x.to_f
      self.y = @dest_y
      @y_float = self.y.to_f
      @moving = false
      
      if( @removeAfterMove )
        self.dispose
      end
      
    else 
      @x_float += @dx_per_frame
      self.x = @x_float.to_i
      @y_float += @dy_per_frame
      self.y = @y_float.to_i
    end
  end
  
  #--------------------------------------------------------------------------
  # Permet de faire une animation sur le sprite 
  # Nb: Doit être appelé dans un update d'une scène
  #--------------------------------------------------------------------------
  def doAnimation( idAnimation, isMirror )
    start_animation($data_animations[idAnimation], isMirror)
    #@time = $data_animations[idAnimation].frame_max 
    
    
#~     if(  @time == 0 )
#~       return true
#~     else
#~        puts("stop animation "  )
#~        @moving = false
#~        end_animation
#~        return false
#~     end
  end
  
  #--------------------------------------------------------------------------
  # * Update Animation
  #--------------------------------------------------------------------------
  def update_animation
    if( ! animation? )
#~        ###@time = 0 
#~        ###@moving = false
#~        ###end_animation
      return false #unless animation?
    end
    
    @ani_duration -= 1
    if @ani_duration % @ani_rate == 0
      if @ani_duration > 0
        frame_index = @animation.frame_max 
        frame_index -= (@ani_duration + @ani_rate - 1) / @ani_rate
        animation_set_sprites(@animation.frames[frame_index])
          puts("update2: " + frame_index.to_s )
        @animation.timings.each do |timing|
        animation_process_timing(timing) if timing.frame == frame_index
        
       # if( frame_index == @animation.frame_max )
       puts( (frame_index +1).to_s + " != " + @animation.frame_max.to_s   )
       if( (frame_index +1) != @animation.frame_max )
           puts("return true "  )
          return true
        else
#~ ##           end_animation
#~ ##           puts("return false "  )
#~ ##           @time = 0
#~ ##           @moving = false
          return false
        end
        
        end
      else
#~ #        end_animation
#~ #        @time = 0
#~ #        @moving = false
        return false
      end
    end
  end
end