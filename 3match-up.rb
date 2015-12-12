def FindMatches()
	NumMatchesFound = 0
	IsMatched = false
	#On passe tous les gems pour vérifier une combinaison en x
	for(0...nbGems)
		NumMatchesFound = 1
		CheckMatchesX(PosX, posY, type)
		
		if( NumMatchesFound  >= 3 )
			IsMatched = true
		end
	end
	
	for(0...nbGems)
		NumMatchesFound = 1
		CheckMatchesY(PosX, posY, type)
		
		if( NumMatchesFound  >= 3 )
			IsMatched = true
		end
	end
	
	#On passe tous les gems pour vérifier une combinaison en y
	if( IsMatched == true )
		Wait(0.1)
		destroyGem
	end
end


def CheckMatchesX(PosX, PosY, Type)
	if(  x == PosX + 1 )
		if( y == y )
			if( type = Type )
				NumMatchesFound += 1
				CheckMatchesX(PosX + 1, y, type)
				
				if( NumMatchesFound  >= 3 )
                    IsMatched = True
				end
			end
		end
	end
end