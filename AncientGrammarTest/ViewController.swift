//
//  ViewController.swift
//  AncientGrammarTest
//
//  Created by Atto Allas on 09/09/2018.
//  Copyright © 2018 Atto Allas. All rights reserved.
//

import UIKit

func free_pointer<T : Any>(_ pointer: UnsafePointer<T>?) {
    free(UnsafeMutableRawPointer(OpaquePointer(pointer)))
}

class ViewController: UIViewController {

    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var StemEntry: UITextField!
    @IBOutlet weak var RoughSwitch: UISwitch!
    @IBOutlet weak var UncommonEpsilonSwitch: UISwitch!
    @IBOutlet weak var PrepositionEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func mainButton_touchUpInside(_ sender: Any) {
        var stem = StemEntry.text!
        let preposition = PrepositionEntry.text == "" ? nil : PrepositionEntry.text
        let rough = RoughSwitch.isOn
        let unceps = UncommonEpsilonSwitch.isOn
        
        if (stem == "") {
            return
        }
        
        if (preposition != nil && preposition!.count > stem.count) {
            return
        }
        
        stem = stem.applyingTransform(.stripDiacritics, reverse: false)!
        
        if (utils_is_vowel(String(stem[stem.startIndex]))) {
            if (!rough) {
                stem.insert("\u{0313}", at: stem.index(after: stem.startIndex))
            } else {
                stem.insert("\u{0314}", at: stem.index(after: stem.startIndex))
            }
        }
        
        let stringPointer = verb_calculate_augment(stem, unceps, preposition)
        MainLabel.text = "Result: " + String(cString: stringPointer!)
        free_pointer(stringPointer)
    }
    
}

