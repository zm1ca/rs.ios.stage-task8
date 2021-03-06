//
//  TimerVC.swift
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 16.07.21.
//

import UIKit

@objc public protocol TimerDelegate {
    func timerDidPick(value: Float)
}

@objc public class TimerVC: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stepper: UISlider!
    
    @objc public var timerValue: NSNumber!
    @objc public weak var delegate: TimerDelegate!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        stepper.value = timerValue.floatValue
        updateUI()
    }
    
    func updateUI() {
        timerLabel.text = String(format: "%.2f", stepper.value) + " s"
    }
    
    @IBAction func stepperValueChanged(_ sender: UISlider) {
        updateUI()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        delegate.timerDidPick(value: stepper.value)
        UIView.animate(withDuration: 0.25) { [self] in
            view.frame = CGRect(x: 0, y: view.bounds.size.height, width: view.bounds.size.width, height: view.bounds.size.height)
        } completion: { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
