//
//  ViewController.swift
//  collectionViewReversePaginated
//
//  Created by Laura Evans on 9/29/17.
//  Copyright © 2017 Laura Evans. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var numbers: [Int] = [0]
    var data: [Int] = []
    var scrollAmount: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcNumbers()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.semanticContentAttribute = .forceRightToLeft
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcNumbers() {
        for _ in 1...10 {
            let last = numbers.last! + 1
            numbers.append(last)
        }
        data = numbers
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.textLabel.text = data[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("willDisplay", indexPath.row)
        
        print(collectionView.contentOffset.x, collectionView.contentSize.width)
        
        if indexPath.row == data.count - 2 {
            
            if scrollAmount.x == 0 {
                let width = collectionView.contentSize.width
                let amount = width + 50
                scrollAmount = CGPoint(x: amount, y: 0)

            }
            
            print("load more ", indexPath.row)
            calcNumbers()
            DispatchQueue.main.async(execute: {
                self.collectionView.reloadData()
                self.collectionView.setContentOffset(self.scrollAmount, animated: false)
            })
        }
    }

}
