//
//  AtmosplayInterstitialCustomEvent.m
//  PlayableMopubAd
//
//  Created by lgd on 2018/4/10.
//  Copyright © 2018年 lgd. All rights reserved.
//

#import "AtmosplayInterstitialCustomEvent.h"
#import <AtmosplayAds/AtmosplayInterstitial.h>

@interface AtmosplayInterstitialCustomEvent ()<AtmosplayInterstitialDelegate>
@property (nonatomic) AtmosplayInterstitial *interstitial;

@end

@implementation AtmosplayInterstitialCustomEvent
-(void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup{
    NSString *appID =  [info objectForKey:@"AppID"];
    appID = [appID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *adUnitID = [info objectForKey:@"AdUnitID"];
    adUnitID = [adUnitID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.interstitial = [[AtmosplayInterstitial alloc] initWithAppID:appID adUnitID:adUnitID];
    self.interstitial.autoLoad = NO;
    self.interstitial.delegate = self;
    
    [self.interstitial loadAd];
}

-(void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    if (self.interstitial.isReady){
        [self.interstitial showInterstitialWithViewController:nil];
    }else{
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark - AtmosplayInterstitialDelegate
/// Tells the delegate that succeeded to load ad.
- (void)atmosplayInterstitialDidLoad:(AtmosplayInterstitial *)ads {
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
        [self.delegate interstitialCustomEvent:self didLoadAd:nil];
    }
}

/// Tells the delegate that failed to load ad.
- (void)atmosplayInterstitial:(AtmosplayInterstitial *)ads didFailToLoadWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
}

/// Tells the delegate that user starts playing the ad.
- (void)atmosplayInterstitialDidStartPlaying:(AtmosplayInterstitial *)ads {
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidAppear:)]) {
        [self.delegate interstitialCustomEventDidAppear:self];
    }
}

/// Tells the delegate that the ad is being fully played.
- (void)atmosplayInterstitialDidEndPlaying:(AtmosplayInterstitial *)ads {
    
}

/// Tells the delegate that the landing page did present on the screen.
- (void)atmosplayInterstitialDidPresentLandingPage:(AtmosplayInterstitial *)ads {
    
}

/// Tells the delegate that the ad did animate off the screen.
- (void)atmosplayInterstitialDidDismissScreen:(AtmosplayInterstitial *)ads {
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
}

/// Tells the delegate that the ad is clicked
- (void)atmosplayInterstitialDidClick:(AtmosplayInterstitial *)ads {
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidReceiveTapEvent:)]) {
        [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    }
}

- (void)dealloc {
    if (self.interstitial.delegate) {
        self.interstitial.delegate = nil;
    }
    if (self.interstitial) {
        self.interstitial = nil;
    }
}

@end
