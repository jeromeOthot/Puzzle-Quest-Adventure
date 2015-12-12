var grid:Array = [[2,3,2,2,2,4],
                  [ .. ]]; //multidimensional array
var matches:uint;
var gemType:uint;
for(col = 0; col < grid.length; col++){
    matches = 0;        
    gemType = 0; //Reserve 0 for the empty state. If we make it a normal gem type, then only 2 are needed to match for the start.
    for(i = 0; i < grid[0].length; i++){
        if(grid[col][i] == gemType){
            matches++;
        }
        if(grid[col][i] != gemType || i == grid[0].length - 1){ //subtract 1 because arrays start at 0
            if(matches >= 3){
                removeMatches(blah);
            }
            gemType = grid[col][i];
            matches = 1;
        }
    }
}