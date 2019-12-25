//
//  AtmosplayBannerCustomEvent.m
//  PlayableMopubAd
//
//  Created by Michael Tang on 2019/10/31.
//  Copyright © 2019 lgd. All rights reserved.
//

#import "AtmosplayBannerCustomEvent.h"
#import <AtmosplayAds/AtmosplayBanner.h>

@interface AtmosplayBannerCustomEvent ()<AtmosplayBannerDelegate>
@property (nonatomic)AtmosplayBanner *banner;

@end

@implementation AtmosplayBannerCustomEvent
- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup{
    NSString *appID =  [info objectForKey:@"AppID"];
    appID = [appID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *adUnitID = [info objectForKey:@"AdUnitID"];
    adUnitID = [adUnitID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.banner = [[AtmosplayBanner alloc] initWithAppID:appID
                                                        adUnitID:adUnitID
                                              rootViewController:[self.delegate viewControllerForPresentingModalView]];
        weakSelf.banner.delegate = self;
        weakSelf.banner.bannerSize = kAtmosplayBanner320x50;
        if (size.width == 728) {
            weakSelf.banner.bannerSize = kAtmosplayBanner728x90;
        }
        [weakSelf.banner loadAd];
    });
}

#pragma mark: AtmosplayBannerDelegate
/// Tells the delegate that an ad has been successfully loaded.
- (void)AtmosplayBannerViewDidLoad:(AtmosplayBanner *)bannerView {
    if ([self.delegate respondsToSelector:@selector(bannerCustomEvent:didLoadAd:)]) {
        [self.delegate bannerCustomEvent:self didLoadAd:bannerView];
    }
}

/// Tells the delegate that a request failed.
- (void)AtmosplayBannerView:(AtmosplayBanner *)bannerView didFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(bannerCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    }
}

/// Tells the delegate that the banner view has been clicked.
- (void)AtmosplayBannerViewDidClick:(AtmosplayBanner *)bannerView {
    if ([self.delegate respondsToSelector:@selector(bannerCustomEventWillBeginAction:)]) {
        [self.delegate bannerCustomEventWillBeginAction:self];
    }
    if ([self.delegate respondsToSelector:@selector(bannerCustomEventDidFinishAction:)]) {
        [self.delegate bannerCustomEventDidFinishAction:self];
    }
}
    
- (void)dealloc {
    if (self.banner.delegate) {
        self.banner.delegate = nil;
    }
    if (self.banner) {
        self.banner = nil;
    }
}

@end
