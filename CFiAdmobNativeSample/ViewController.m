//
//  ViewController.m
//  CFiAdmobNativeSample
//
//  Created by CF-NB on 2019/9/7.
//  Copyright © 2019年 CF-NB. All rights reserved.
//

#import "ViewController.h"

// Native Advanced ad unit ID for testing.
static NSString *const ClickforceTestAdUnit = @"ca-app-pub-7236340530869760/9573036878";


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [nativeAdview removeFromSuperview];
    [self setAdview];
    
    GADVideoOptions *videoOptions = [[GADVideoOptions alloc] init];
    videoOptions.startMuted = YES;
    
    adLoader = [[GADAdLoader alloc] initWithAdUnitID:ClickforceTestAdUnit
                                  rootViewController:self
                                             adTypes:@[GADAdLoaderAdTypeNative]
                                             options:@[videoOptions]];
    
    adLoader.delegate = self;
    GADRequest*req = [GADRequest request];
//    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"" ];//set your Test deivce id.
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ GADSimulatorID ];//set Test Simulators ID
    [adLoader loadRequest:req];
//    [GADMobileAds.sharedInstance presentAdInspectorFromViewController:self
//      completionHandler:^(NSError *error) {
//        // Error will be non-nil if there was an issue and the inspector was not displayed.
//    }];
}

- (void) setAdview{
    
    nativeAdview = [[GADNativeAdView alloc] initWithFrame:CGRectMake(0, 50, 359, 300)];
    
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    Adtittle = [[UILabel alloc] initWithFrame:CGRectMake(57, 15, 285, 20)];
    Advertiser = [[UILabel alloc] initWithFrame:CGRectMake(57, 38, 285, 17)];
    Adbody = [[UILabel alloc] initWithFrame:CGRectMake(57, 63, 330, 33)];
    mediaView = [[GADMediaView alloc] initWithFrame:CGRectMake(65, 102, 250, 150)];
    Adbutton = [[UIButton alloc] initWithFrame:CGRectMake(260, 260, 80, 34)];
    Adbutton.userInteractionEnabled = NO;
    
    [nativeAdview addSubview:Adtittle];
    [nativeAdview addSubview:iconView];
    [nativeAdview addSubview:Advertiser];
    [nativeAdview addSubview:Adbody];
    [nativeAdview addSubview:mediaView];
    [nativeAdview addSubview:Adbutton];
    [self.view addSubview:nativeAdview];
    
    nativeAdview.headlineView = Adtittle;
    nativeAdview.iconView = iconView;
    nativeAdview.advertiserView = Advertiser;
    nativeAdview.bodyView = Adbody;
    nativeAdview.mediaView = mediaView;
    nativeAdview.callToActionView = Adbutton;
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"%@ failed with error: %@", adLoader, error);
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADNativeAd *)nativeAd {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    GADNativeAdView *native = nativeAdview;
    
    heightConstraint.active = YES;
    
    native.nativeAd = nativeAd;
    
    nativeAd.delegate = self;
    
    
    ((UILabel *)native.headlineView).text = nativeAd.headline;
    native.headlineView.hidden = nativeAd.headline ? NO : YES;
    
    native.mediaView.mediaContent = nativeAd.mediaContent;
    
    
    ((UILabel *) native.bodyView).text = nativeAd.body;
    native.bodyView.hidden = nativeAd.body ? NO : YES;
    
    
    ((UIImageView *)native.iconView).image = nativeAd.icon.image;
    native.iconView.hidden = nativeAd.icon ? NO : YES;
    
    
    ((UILabel *)native.advertiserView).text = nativeAd.advertiser;
    native.advertiserView.hidden = nativeAd.advertiser ? NO : YES;
    
    
    [((UIButton *)native.callToActionView) setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    [((UIButton *)native.callToActionView) setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    native.callToActionView.hidden = nativeAd.callToAction ? NO : YES;
    
    NSLog(@"Native adapter class name: %@", nativeAd.responseInfo.loadedAdNetworkResponseInfo.adNetworkClassName);//Check the value of adNetworkClassName
}

- (void)nativeAdDidRecordImpression:(GADNativeAd *)nativeAd {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)nativeAdDidRecordClick:(GADNativeAd *)nativeAd {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
