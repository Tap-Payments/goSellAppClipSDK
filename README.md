# goSell App Clip iOS SDK

iOS SDK to use [goSell API][1].

[![Platform](https://img.shields.io/cocoapods/p/goSellAppClipSDK.svg?style=flat)](https://tap-payments.github.io/goSellSDK-iOS)
[![Build Status](https://travis-ci.org/Tap-Payments/goSellSDK-iOS.svg?branch=master)](https://travis-ci.org/Tap-Payments/https://img.shields.io/Tap-Payments/v/goSellAppClipSDK)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/goSellAppClipSDK.svg?style=flat)](https://img.shields.io/Tap-Payments/v/goSellAppClipSDK)
[![Documentation](docs/badge.svg)](https://tap-payments.github.io/goSellSDK-iOS)

A library that fully covers payment/authorization/card saving process inside your iOS application.

# Table of Contents 

---

1. [Requirements](#requirements)
2. [Installation](#installation)
   1. [Installation with CocoaPods](#installation_with_cocoapods)
3. [Setup](#setup)
   1. [goSellSDK Class Properties](#setup_gosellsdk_class_properties)
   2. [goSellSDK Class Methods](#setup_gosellsdk_class_methods)
   3. [Setup Steps](#setup_steps)
4. [Usage](#usage)
   1. [SDK modes](#sdk_modes)
   2. [Pay Button](#pay_button)
      1. [Pay Button Placement](#pay_button_placement)
      2. [Properties](#pay_button_properties)
      3. [Methods](#pay_button_methods)
   3. [Session](#session)
      1. [Properties](#session_properties)
       2. [Methods](#session_methods)
   4. [API Session](#api_session)
      1. [Properties](#api_session_properties)
       2. [Methods](#api_session_methods)
   5. [Session Data Source](#session_data_source)
      1. [Structure](#session_data_source_structure)
      2. [Samples](#session_data_source_samples)
   6. [Session Delegate](#session_delegate)
      1. [Payment Success Callback](#payment_success_callback)
      2. [Payment Failure Callback](#payment_failure_callback)
      3. [Authorization Success Callback](#authorization_success_callback)
      4. [Authorization Failure Callback](#authorization_failure_callback)
      5. [Card Saving Success Callback](#card_saving_success_callback)
      6. [Card Saving Failure Callback](#card_saving_failure_callback)
      7. [Card Tokenization Success Callback](#card_tokenization_success_callback)
      8. [Card Tokenization Failure Callback](#card_tokenization_failure_callback)
      9. [Session Is Starting Callback](#session_is_starting_callback)
      10. [Session Has Started Callback](#session_has_started_callback)
      11. [Session Has Failed to Start Callback](#session_has_failed_to_start_callback)
      12. [Session Cancel Callback](#session_cancel_callback)
   7. [Session Appearance](#session_appearance)
5. [Sample](#sample) 
        

<a name="requirements"></a>

# Requirements

---

To use the SDK the following requirements must be met:

1. **Xcode 12.0** or newer
2. **Swift 4.0** or newer (preinstalled with Xcode)   
3. Deployment target SDK for the  app: **iOS 14.0** or later

<a name="installation"></a>

# Installation

---

<a name="installation_with_cocoapods"></a>

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager, which automates and simplifies the process of using 3rd-party libraries in your projects.<br>You can install it with the following command:

```bash
$ gem install cocoapods
```

### Podfile

**To integrate goSellSDK into your App clip target Xcode 12+ project using CocoaPods**


specify it in your `Podfile`:

```ruby
platform :ios, '14.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target 'MyApp' do
    
    pod 'goSellSDK'

end

target 'MyAppClip' do
    
    pod 'goSellAppClipSDK'

end
```

Then, run the following command:

```bash
$ pod update
```



<a name="setup"></a>

# Setup

---

After installing the pod as mentioned in the previous section, please follow the following steps to make sure it is reflected properly into your App Clip.

1. Click on your project from the navigator as follows:

   1. ![Project](https://i.ibb.co/zZ1mydr/1.jpg)

2. Click on your app clip target as follows:

   1. ![App Clip settings](https://i.ibb.co/jDHzjSR/2.jpg)

3. Click on Build Phases tab as follows:

   1. ![App Clip settings](https://i.ibb.co/MCDkTMy/3.jpg)

4. Click on the + sign and add a new script with the following details:

   1. Title : [CP] Embed Pods Frameworks
   2. Script: "${PODS_ROOT}/Target Support Files/Pods-[AppClipTargetName]/Pods-[AppClipTargetName]-frameworks.sh"
   3. ![App Clip settings](https://i.ibb.co/3Wd6qzh/4.jpg)

   

   <a name="setup_gosellsdk_class_properties"></a>

## goSellSDK 

To know about the goSellSDK and the checkout experience please follow the documentation of : [goSellSDK](https://github.com/Tap-Payments/goSellSDK-iOS) 



# Documentation

---



Documentation is available at [github-pages][3].<br>
Also documented sources are attached to the library.

[1]:https://www.tap.company/developers/
[2]:Example
[3]:https://tap-payments.github.io/goSellSDK-iOS/
