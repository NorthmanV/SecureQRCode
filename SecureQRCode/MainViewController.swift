//
//  MainViewController.swift
//  SecureQRCode
//
//  Created by Руслан Акберов on 25.04.2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var QRCodeImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        if textField.text?.isEmpty == true {
            return
        }
        
        if qrcodeImage == nil {
            let data = textField.text?.data(using: String.Encoding.isoLatin1)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = filter?.outputImage
            displayQRCodeImage()
            textField.resignFirstResponder()
            generateButton.setTitle("Clear", for: .normal)
        } else {
            QRCodeImageView.image = nil
            qrcodeImage = nil
            generateButton.setTitle("Generate", for: .normal)
        }
    }
    
    @IBAction func changeImageViewScale(_ sender: UISlider) {
        QRCodeImageView.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    func displayQRCodeImage() {
        let scaleX = QRCodeImageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = QRCodeImageView.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX,y: scaleY))
        QRCodeImageView.image = UIImage(ciImage: transformedImage)
    }
    
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {
        
    }
    
    
}












