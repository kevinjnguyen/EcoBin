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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var confettiView: SAConfettiView = {
        let confetti = SAConfettiView(frame: self.view.bounds)
        return confetti
    }()
    
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
        activityIndicator.isHidden = false
        recycleButton.setTitle("", for: UIControl.State.normal)
        activityIndicator.startAnimating()
        
        guard let trash = category else {
            return
        }
        
        var finalCategory: String? = nil
        
        switch trash.lowercased() {
        case "trash":
            do {
                try RecycleRepository.shared.shouldLandfill()
                finalCategory = "Landfill"
            } catch {
                NativePopup.show(image: Preset.Feedback.cross, title: "Error", message: "Could not connect with gRPC Server")
            }
        case "plastic":
            do {
                try RecycleRepository.shared.shouldCompost()
                finalCategory = "Plastic"
            } catch {
                NativePopup.show(image: Preset.Feedback.cross, title: "Error", message: "Could not connect with gRPC Server")
            }
        default:
            do {
                try RecycleRepository.shared.shouldRecycle()
                finalCategory = "Recyclables"
            } catch {
                NativePopup.show(image: Preset.Feedback.cross, title: "Error", message: "Could not connect with gRPC Server")
            }
        }
        
        if finalCategory != nil {
        // To make it look like we are doing complicated stuff
            view.addSubview(confettiView)
            confettiView.startConfetti()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.activityIndicator.isHidden = true
                self.recycleButton.setTitle("Recycle", for: UIControl.State.normal)
                self.activityIndicator.stopAnimating()
                NativePopup.show(image: UIImage(named: "leaf")!, title: "Placed in \(finalCategory!)", message: nil, duration: 1.0, initialEffectType: .fadeIn)
                self.confettiView.stopConfetti()
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setup() {
        activityIndicator.isHidden = true
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
