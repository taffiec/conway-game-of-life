//
//  ViewController.swift
//  ConwayGameOfLife
//
//  Created by Taffie Coler on 11/19/19.
//  Copyright © 2019 Taffie Coler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let game = Life()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        game.resetBoard()
        collectionView.reloadData()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        game.calculateNextGeneration()
        collectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowCount = game.board.count
        return rowCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let colCount = game.board[0].count
        return colCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.lifeCellIdentifier, for: indexPath)
        
        let piece = game.returnGamePiece(at: indexPath)
        cell.backgroundColor = piece.color
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        game.changePieceState(indexPath: indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.cellSize, height: K.cellSize)
        
    }
}
