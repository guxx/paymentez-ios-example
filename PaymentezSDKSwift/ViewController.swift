//
//  ViewController.swift
//  PaymentezSDKSample
//
//  Created by Gustavo Sotelo on 27/04/16.
//  Copyright © 2016 Paymentez. All rights reserved.
//

import UIKit
import PaymentezSDK

class ViewController: UIViewController {
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var verifyButton: UIButton!
    var cardReference = "22"
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
    }
    @IBAction func debitAction(_ sender: AnyObject) {
        self.activityIndicator.startAnimating()
        let parameters = PaymentezDebitParameters()
        parameters.cardReference = self.cardReference
        parameters.productAmount = Double(self.amountTextfield.text!)!
        parameters.productDescription = "Test"
        parameters.devReference = "1234"
        parameters.vat = 0.10
        parameters.email = "guxsotelo@gmail.com"
        parameters.uid = "123gux"
        PaymentezSDKClient.debitCard(parameters) { (error, transaction) in
            self.activityIndicator.stopAnimating()
            if error == nil
            {
                DispatchQueue.main.async(execute: {
                    let alertC = UIAlertController(title: "Success", message: "transaction_id:\(transaction?.transactionId), status:\(transaction?.status)", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertC.addAction(defaultAction)
                    self.present(alertC, animated: true
                        , completion: {
                            
                    })
                })
            }
            else
            {
                if error!.shouldVerify() // if the card should be verified
                {
                    self.verifyButton.isHidden = false
                    print(error?.getVerifyTrx())
                    DispatchQueue.main.async(execute: {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "Should verify: \(error!.getVerifyTrx())", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.present(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "\(error!.descriptionCode)", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.present(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

