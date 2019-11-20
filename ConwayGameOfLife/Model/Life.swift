//
//  Life.swift
//  ConwayGameOfLife
//
//  Created by Taffie Coler on 11/19/19.
//  Copyright © 2019 Taffie Coler. All rights reserved.
//

import Foundation

class Life{
    
    var board = [[GamePiece]]()
    
    init(){
        self.board = createNewBoard()
    }
    
    // Creates a game board filled with GamePieces set to default value
    func createNewBoard()->[[GamePiece]]{
        var newBoard = [[GamePiece]]()
               for _ in 0..<K.gridSize{
                   let row = Array(repeating: GamePiece(), count: K.gridSize)
                   newBoard.append(row)
               }
        return newBoard
    }
    
    // Resets current game board
    func resetBoard(){
        for i in 0..<K.gridSize{
            for j in 0..<K.gridSize{
                self.board[i][j] = GamePiece()
            }
        }
    }
    
    // Returns a GamePiece from an indexPath on the board
    func returnGamePiece(at indexPath: IndexPath) -> GamePiece{
        return self.board[indexPath.row][indexPath.section]
    }
    
    // Flips the state of a GamePiece at an indexPath on the board
    func changePieceState(indexPath: IndexPath){
        var gamePiece = returnGamePiece(at: indexPath)
        gamePiece.flipState()
        
        self.board[indexPath.row][indexPath.section] = gamePiece
    }
    
    func calculateNextGeneration(){
        var nextGeneration = createNewBoard()
        
        for (i, row) in self.board.enumerated(){
            for (j, gamePiece) in row.enumerated() {
                let neighborCount = calculateNeighbors(x: i, y: j)
                let newPiece = determineFate(piece: gamePiece, neighbors: neighborCount)
                nextGeneration[i][j] = newPiece
            }
        }
    
        self.board = nextGeneration
    }
    
    // Determines who neighbors of center element will be
    func determineNeighbors(x:Int, y:Int)->[GamePiece]{
        var neighborArray = [GamePiece]()
        
        // make an array of all cells that surround center element
        for i in -1...1{
            for j in -1...1{
                neighborArray.append(self.board[(x+i + K.gridSize) % K.gridSize][(y+j + K.gridSize) % K.gridSize])
            }
        }
        // remove center element
        neighborArray.remove(at: 4)
        return(neighborArray)
    }
    
    // Counts the number of alive neighbors for central element
    func calculateNeighbors(x: Int, y:Int)->Int{
        let neighborArray = determineNeighbors(x: x, y: y)
        // Return number of "Alive" tiles
        return neighborArray.filter{$0.alive}.count
    }
    
    func determineFate(piece: GamePiece, neighbors: Int)->GamePiece{
        
        // If alive, return dead piece if neighbors are less than 2 or greater than 3
        if (piece.alive && (neighbors < 2 || neighbors > 3)){
            return GamePiece(alive: false)
            
        } // If dead, resurrected piece if we have exactly 3 neighbors
        else if (piece.alive == false && neighbors == 3){
            return GamePiece(alive: true)
        }
        
        // If no state change necessary, return original piece
        return piece
    }
}
