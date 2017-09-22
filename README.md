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


###Show AddCard Widget

In order to create a widget you should create a PaymentezAddNativeController from the PaymentezSDKClient. Then add it to the UIView that will be the container of the add form. The min height should be 160 px

The widget can scan with your phones camera the credit card data using card.io.

```swift
        let paymentezAddVC = PaymentezSDKClient.createAddWidget()
        self.addChildViewController(paymentezAddVC)
        paymentezAddVC.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.addView.frame.size.height)
        self.addView.translatesAutoresizingMaskIntoConstraints = true
        self.addView.addSubview(paymentezAddVC.view)
        paymentezAddVC.didMove(toParentViewController: self)
```

### Scan Card
If you want to do the scan yourself.

```swift
PaymentezSDKClient.scanCard(self) { (closed, number, expiry, cvv) in
            if !closed // user did not closed the scan card dialog
            {
            })
```

### Add Card (Just PCI Integrations)
For custom form integrations 

```swift 
 let card = PaymentezCard.createCard(cardHolder:"Gustavo Sotelo", cardNumber:"4111111111111111", expiryMonth:10, expiryYear:2020, cvc:"123")
 
 if card != nil  // A valid card was created
 {
 	PaymentezSDKClient.createToken(card, uid: "69123", email: "gsotelo@paymentez.com", callback: { (error, cardAdded) in
            
            if cardAdded != nil 
            {
            	//the request was succesfully sent, you should check the cardAdded status 
            }
                    
    })
 }
 else 
 {
 //handle invalid card
 }
```


### Secure Session Id

Debit actions should be implemented in your own backend. For security reasons we provide a secure session id generation, for kount fraud systems. This will collect the device information in background

```swift
        let sessionId = PaymentezSDKClient.getSecureSessionId()
```
