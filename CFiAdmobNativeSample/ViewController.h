//
//  ViewController.h
//  CFiAdmobNativeSample
//
//  Created by CF-NB on 2019/9/7.
//  Copyright © 2019年 CF-NB. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
@import iMFAD;

@interface ViewController : UIViewController <GADNativeAdLoaderDelegate, GADNativeAdDelegate>{
    GADAdLoader *adLoader;
    GADNativeAdView *nativeAdview;
    UIImageView *iconView;
    UILabel *Adtittle;
    UILabel *Advertiser;
    UILabel *Adbody;
    GADMediaView *mediaView;
    UIButton *Adbutton;
    NSLayoutConstraint *heightConstraint;
    
}

@end

