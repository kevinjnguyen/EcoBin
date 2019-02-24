//
//  ResultsViewController.swift
//  Bin
//
//  Created by Mike Choi on 2/23/19.
//  Copyright © 2019 Mike JS. Choi. All rights reserved.
//

import UIKit
import Vision

class ResultsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var progressViewOne: UIProgressView!
    @IBOutlet weak var progressViewTwo: UIProgressView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var secondaryStackView: UIStackView!
    @IBOutlet weak var recycleButton: UIButton!
    
    var classifications: [VNClassificationObservation]?
    var category: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        processClassifications()
    }
    
    @IBAction func recycle(_ sender: Any) {
        guard let trash = category else {
            return
        }
        
        switch trash {
        case "Trash":
            do {
                try RecycleRepository.shared.shouldLandfill()
            } catch {
                print("error")
            }
        case "Plastic":
            do {
                try RecycleRepository.shared.shouldCompost()
            } catch {
                print("error")
            }
        default:
            do {
                try RecycleRepository.shared.shouldRecycle()
            } catch {
                print("error")
            }
        }
    }
    
    func setup() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.image = image
        
        recycleButton.layer.masksToBounds = true
        recycleButton.layer.cornerRadius = 12.0
        
        _ = [progressViewOne, progressViewTwo].map {
            $0?.progress = 0.0
            $0!.transform = $0!.transform.scaledBy(x: 1, y: 2)
        }
        
        _ = [labelOne, labelTwo].map {
            $0?.text = ""
        }
    }
    
    func processClassifications() {
        guard let topMatches = classifications?.prefix(2) else {
            mainStackView.removeArrangedSubview(secondaryStackView)
            labelOne.text = "Could not classify image"
            return
        }
        
        
        for (i, classification) in topMatches.enumerated() {
            if i == 0 {
                labelOne.text = classification.identifier
                progressViewOne.setProgress(classification.confidence, animated: true)
                category = classification.identifier
            } else {
                labelTwo.text = classification.identifier
                progressViewTwo.setProgress(classification.confidence, animated: true)
            }
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
