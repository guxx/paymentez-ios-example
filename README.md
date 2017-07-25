# ccapi-ios-example

**

Paymentez SDK IOS
-----------------

** 


----------
**Requirements**

 - iOS 9.0 or Later
 - Xcode 7
 
 


**Framework Dependencies:**

Accelerate
AudioToolbox
AVFoundation
CoreGraphics
CoreMedia
CoreVideo
Foundation
MobileCoreServices
OpenGLES
QuartzCore
Security
UIKit
CommonCrypto
 
 **Project Configuration**
-ObjC in other linker flags in target
-lc++ in target other linker flags


----------
**INSTALLATION**

 1. Drag PaymentezSDK.framework to your project
 2. Add PaymentezSDK.framework to Embeeded Libraries
 

----------
**Usage**

Importing Swift

    import PaymentezSDK

Setting up your app,. inside AppDelegate->didFinishLaunchingWithOptions

    PaymentezSDKClient.setEnvironment("AbiColApp", secretKey: "2PmoFfjZJzjKTnuSYCFySMfHlOIBz7", testMode: true)


###Show "Add Card" WebView

This method will present a webview as modal in your application


```swift
PaymentezSDKClient.showAddViewControllerForUser("test", email: "gsotelo@paymentez.com", presenter: self) { (error, closed, added) in
            
            if closed // user closed
            {
                
            }
            else if added // was added
            {
                print("ADDED SUCCESSFUL")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertC = UIAlertController(title: "Success", message: "card added", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertC.addAction(defaultAction)
                    self.presentViewController(alertC, animated: true
                        , completion: {
                            self.refreshTable()
                    })
                })
                
                
                
            }
            else if error != nil //there was an error
            {
                print(error?.code)
                print(error?.description)
                print(error?.details)
                if error!.shouldVerify() // if the card should be verified
                {
                    print(error?.getVerifyTrx())
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "Should verify: \(error!.getVerifyTrx())", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.presentViewController(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "\(error!.descriptionCode)", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.presentViewController(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
            }
            
        }
    }
```


###List Cards


```swift
 PaymentezSDKClient.listCards("test") { (error, cardList) in
            
            if error == nil
            {
                self.cardList = cardList!
                self.tableView.reloadData()
            }
            
            
        }
```


###Debit Card

```swift
let parameters = PaymentezDebitParameters()
        parameters.cardReference = self.cardReference
        parameters.productAmount = Double(self.amountTextfield.text!)!
        parameters.productDescription = "Test"
        parameters.devReference = "1234"
        parameters.vat = 0.10
        parameters.email = "gsotelo@paymentez.com"
        parameters.uid = "test"
        PaymentezSDKClient.debitCard(parameters) { (error, transaction) in
            self.activityIndicator.stopAnimating()
            if error == nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    let alertC = UIAlertController(title: "Success", message: "transaction_id:\(transaction?.transactionId), status:\(transaction?.status)", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertC.addAction(defaultAction)
                    self.presentViewController(alertC, animated: true
                        , completion: {
                            
                    })
                })
            }
            else
            {
                if error!.shouldVerify() // if the card should be verified
                {
                    print(error?.getVerifyTrx())
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "Should verify: \(error!.getVerifyTrx())", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.presentViewController(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "\(error!.descriptionCode)", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.presentViewController(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
            }
        }

```

###Delete Card

Swift
```swift
PaymentezSDKClient.deleteCard("test", cardReference: card.cardReference!, callback: { (error, wasDeleted) in
                if wasDeleted
                {
                    //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.refreshTable()
                }
                else
                {
                    if error != nil
                    {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertC = UIAlertController(title: "error \(error!.code)", message: "\(error!.description)", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            alertC.addAction(defaultAction)
                            self.presentViewController(alertC, animated: true
                                , completion: {
                                    
                            })
                        })
                    }
                    
                }
            })

```

###Verify
Swift
``` swift
PaymentezSDKClient.verifyWithCode(self.transactionId.text!, uid: "test", verificationCode: self.verifyCodetxt.text!) { (error, attemptsRemaining, transaction) in
            self.activityIndicator.stopAnimating()
            if transaction != nil
            {
                print ("verified")
            }
            else
            {
                if attemptsRemaining > 0 //
                {
                    print("you have attempts remaining")
                }
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertC = UIAlertController(title: "error \(error!.code)", message: "\(error!.descriptionCode)", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertC.addAction(defaultAction)
                        self.presentViewController(alertC, animated: true
                            , completion: {
                                
                        })
                    })
                }
            }
        }

```
