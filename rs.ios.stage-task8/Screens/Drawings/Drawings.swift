//
//  Drawings.swift
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 16.07.21.
//

import UIKit

@objc public protocol DrawingsDelegate {
    func updateDrawingWith(drawing: NSString)
}

@objc public class Drawings: UIViewController {
    
    @IBOutlet var patternButtons: [RSButton]!
    
    @objc public var selectedDrawing: NSString!    
    @objc public weak var delegate: DrawingsDelegate!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let selectedButton = patternButtons.first { $0.titleLabel?.text == selectedDrawing as String }!
        selectedButton.setHighlightedTint()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.updateDrawingWith(drawing: NSString(string: selectedDrawing))
    }
    
    @IBAction func patternButtonTapped(_ sender: RSButton) {
        patternButtons.filter { $0 != sender }.forEach { $0.setDefaultTint() }
        sender.setHighlightedTint()
        
        selectedDrawing = sender.titleLabel!.text! as NSString
    }
    
}
