class Equipment_Mouse
  #Hero Equipment
  WINDOW_WEAPON_POS_X = 76 
  WINDOW_WEAPON_POS_Y = 11
  WINDOW_SHIELD_POS_X = 108 
  WINDOW_SHIELD_POS_Y = 11  
  WINDOW_ARMOR_POS_X = 44
  WINDOW_ARMOR_POS_Y = 43
  WINDOW_HELMET_POS_X = 76
  WINDOW_HELMET_POS_Y = 43
  WINDOW_BOOTS_POS_X = 108
  WINDOW_BOOTS_POS_Y = 43
  WINDOW_ACESSORY_POS_X = 140
  WINDOW_ACESSORY_POS_Y = 43
    
  WINDOW_ITEMUSE_POS_X = 140
  WINDOW_ITEMUSE_POS_Y = 11



  #Enemy Equipment
  WINDOW_ENEMY_WEAPON_POS_X = 519
  WINDOW_ENEMY_WEAPON_POS_Y = 11
  WINDOW_ENEMY_SHIELD_POS_X = 551
  WINDOW_ENEMY_SHIELD_POS_Y = 11
  WINDOW_ENEMY_ARMOR_POS_X = 487
  WINDOW_ENEMY_ARMOR_POS_Y = 43
  WINDOW_ENEMY_HELMET_POS_X = 519
  WINDOW_ENEMY_HELMET_POS_Y = 43
  WINDOW_ENEMY_BOOTS_POS_X = 551
  WINDOW_ENEMY_BOOTS_POS_Y = 43
  WINDOW_ENEMY_ACESSORY_POS_X = 583
  WINDOW_ENEMY_ACESSORY_POS_Y = 43

  
  def initialize(gameBattle, actor, enemy)
    @gameBattle = gameBattle
    @actor = actor
    @enemy = enemy
  end 
  
  #Détermine si le joueur a cliqué sur son arme pour attacker
  def checkLeftClickWeapon(window_HeroEquipment, window_VS)
    if($cursor.x.to_i >= WINDOW_WEAPON_POS_X && $cursor.x.to_i <= ( WINDOW_WEAPON_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_WEAPON_POS_Y && $cursor.y.to_i <= ( WINDOW_WEAPON_POS_Y + 24 ))
      #TODO: Mettre une conditions pour savoir si le héro a une arme ou pas OU si il ne peut attacker
     # @gameBattle.attackEnemy()
    else
      return false 
    end
  end
    
  
  #Détermine si le joueur a clické sur le bouton item (icon potion)
  def checkLeftClickItemUse(inPauseMode, inItemSelectionMode)
     if($cursor.x.to_i >= WINDOW_ITEMUSE_POS_X && $cursor.x.to_i <= ( WINDOW_ITEMUSE_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ITEMUSE_POS_Y && $cursor.y.to_i <= ( WINDOW_ITEMUSE_POS_Y + 24 ))
        
       #Si le menu item est activé ou pas
       if( $inItemSelectionMode == false )
          $windowItemUse = Window_ItemUse.new
          $cursor.x = 151 #Permet d'arranger un bug mais n'as aucun effet sur le jeu
        else
          $inItemSelectionMode = false
          $windowItemUse = nil
       end   
       return true
      else
        return false
     end
  end
  
  def show_damage()
       @info_viewport = Viewport.new unless Viewport.nil? 
    @info_viewport.rect.y = 200
    @info_viewport.rect.height = 200
    @info_viewport.z = 200
    @info_viewport.ox = 0
      @info_viewport.oy = 0
    
    #viewport1 = self.viewport.new()
    Sound.play_enemy_damage
    #viewport1 =  Viewport.new()
    #viewport1.z = 200
      #  puts(@info_viewport)
        #puts($data_animations[1])
    
    @numberSprite1 = Sprite_Base.new(@info_viewport)
      #@numberSprite1.update()
      @numberSprite1.visible = true
    @numberSprite1.x = 100
    @numberSprite1.y = 100
    @numberSprite1.start_animation( $data_animations[21])
    
    @numberSprite1.update()
    
    
    @numberSprite1.visible = false
    #viewport1 = self.viewport.new()
    #Sound.play_enemy_damage
    #viewport1 =  Viewport.new()
    #viewport1.z = 200
    #@umberSprite1 = Sprite_Base.new()
    #@numberSprite1.start_animation( $data_animations[1])
    #@numberSprite1.bitmap = Cache.picture("un")
    #@numberSprite1.visible = true
    #@numberSprite1.x = 330
    #@numberSprite1.y = 90
    #@numberSprite1.z = 200
    #@numberSprite1.flash(nil, 100) 
    #@numberSprite1.update
  end
  
  
  
   #pop une window sur la description des armes et armures du héro
   def checkClickHoverHeroEquipment()
      if($cursor.x.to_i >= WINDOW_WEAPON_POS_X && $cursor.x.to_i <= ( WINDOW_WEAPON_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_WEAPON_POS_Y && $cursor.y.to_i <= ( WINDOW_WEAPON_POS_Y + 24 ))    
        @windowHeroWeapon = Window_ItemDescription.new(@actor.equips[0], 0, 40) unless @windowHeroWeapon
      else
        @windowHeroWeapon.dispose if @windowHeroWeapon
        @windowHeroWeapon = nil
      end
      
      if($cursor.x.to_i >= WINDOW_SHIELD_POS_X && $cursor.x.to_i <= ( WINDOW_SHIELD_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_SHIELD_POS_Y && $cursor.y.to_i <= ( WINDOW_SHIELD_POS_Y + 24 ))    
        @windowHeroShield = Window_ItemDescription.new(@actor.equips[1], 0, 40) unless @windowHeroShield
      else
        @windowHeroShield.dispose if @windowHeroShield
        @windowHeroShield = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ARMOR_POS_X && $cursor.x.to_i <= ( WINDOW_ARMOR_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ARMOR_POS_Y && $cursor.y.to_i <= ( WINDOW_ARMOR_POS_Y + 24 ))    
        @windowHeroArmor = Window_ItemDescription.new(@actor.equips[3], 0, 72) unless @windowHeroArmor
      else
        @windowHeroArmor.dispose if @windowHeroArmor
        @windowHeroArmor = nil
      end
      
       if($cursor.x.to_i >= WINDOW_HELMET_POS_X && $cursor.x.to_i <= ( WINDOW_HELMET_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_HELMET_POS_Y && $cursor.y.to_i <= ( WINDOW_HELMET_POS_Y + 24 ))    
        @windowHeroHelmet = Window_ItemDescription.new(@actor.equips[2], 0, 72) unless @windowHeroHelmet
      else
        @windowHeroHelmet.dispose if @windowHeroHelmet
        @windowHeroHelmet = nil
      end
      
      if($cursor.x.to_i >= WINDOW_BOOTS_POS_X && $cursor.x.to_i <= ( WINDOW_BOOTS_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_BOOTS_POS_Y && $cursor.y.to_i <= ( WINDOW_BOOTS_POS_Y + 24 ))    
        @windowHeroBoots = Window_ItemDescription.new(@actor.equips[4], 0, 72) unless @windowHeroBoots
      else
        @windowHeroBoots.dispose if @windowHeroBoots
        @windowHeroBoots = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ACESSORY_POS_X && $cursor.x.to_i <= ( WINDOW_ACESSORY_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ACESSORY_POS_Y && $cursor.y.to_i <= ( WINDOW_ACESSORY_POS_Y + 24 ))    
        @windowHeroAcessory = Window_ItemDescription.new(@actor.equips[4], 0, 72) unless @windowHeroAcessory
      else
        @windowHeroAcessory.dispose if @windowHeroAcessory
        @windowHeroAcessory = nil
      end
      
      #Héro item menu
      if($cursor.x.to_i >= WINDOW_ITEMUSE_POS_X && $cursor.x.to_i <= ( WINDOW_ITEMUSE_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ITEMUSE_POS_Y && $cursor.y.to_i <= ( WINDOW_ITEMUSE_POS_Y + 24 ))
        @windowMenuItemInfo = Window_Text.new(150, 50, 395) unless @windowMenuItemInfo
        @windowMenuItemInfo.set_text("Permet d'utiliser des items de l'inventaire !");
      else
        @windowMenuItemInfo.dispose if @windowMenuItemInfo
        @windowMenuItemInfo = nil
      end
    end
    
    
    #pop une window sur la description des armes et armures de l'enemy
    def checkClickHoverEnemyEquipment()
      if($cursor.x.to_i >= WINDOW_ENEMY_WEAPON_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_WEAPON_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_WEAPON_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_WEAPON_POS_Y + 24 ))    
        @windowEnemyWeapon = Window_ItemDescription.new($data_weapons[@enemy.weapon.to_i], 315, 40) unless @windowEnemyWeapon
      else
        @windowEnemyWeapon.dispose if @windowEnemyWeapon
        @windowEnemyWeapon = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ENEMY_SHIELD_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_SHIELD_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_SHIELD_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_SHIELD_POS_Y + 24 ))    
        @windowEnemyShield = Window_ItemDescription.new($data_armors[@enemy.shield.to_i], 315, 40) unless @windowEnemyShield
      else
        @windowEnemyShield.dispose if @windowEnemyShield
        @windowEnemyShield = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ENEMY_ARMOR_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_ARMOR_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_ARMOR_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_ARMOR_POS_Y + 24 ))    
        @windowEnemyArmor = Window_ItemDescription.new($data_armors[@enemy.armor.to_i], 315, 72) unless @windowEnemyArmor
      else
        @windowEnemyArmor.dispose if @windowEnemyArmor
        @windowEnemyArmor = nil
      end
      
       if($cursor.x.to_i >= WINDOW_ENEMY_HELMET_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_HELMET_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_HELMET_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_HELMET_POS_Y + 24 ))    
        @windowEnemyHelmet = Window_ItemDescription.new($data_armors[@enemy.helmet.to_i],315, 72) unless @windowEnemyHelmet
      else
        @windowEnemyHelmet.dispose if @windowEnemyHelmet
        @windowEnemyHelmet = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ENEMY_BOOTS_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_BOOTS_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_BOOTS_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_BOOTS_POS_Y + 24 ))    
        @windowEnemyBoots = Window_ItemDescription.new($data_armors[@enemy.boots.to_i], 315, 72) unless @windowEnemyBoots
      else
        @windowEnemyBoots.dispose if @windowEnemyBoots
        @windowEnemyBoots = nil
      end
      
      if($cursor.x.to_i >= WINDOW_ENEMY_ACESSORY_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_ACESSORY_POS_X + 24 ) && $cursor.y.to_i >= WINDOW_ENEMY_ACESSORY_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_ACESSORY_POS_Y + 24 ))    
        @windowEnemyAcessory = Window_ItemDescription.new($data_armors[@enemy.accessory.to_i], 315, 72) unless @windowEnemyAcessory
      else
        @windowEnemyAcessory.dispose if @windowEnemyAcessory
        @windowEnemyAcessory = nil
      end
    end

end