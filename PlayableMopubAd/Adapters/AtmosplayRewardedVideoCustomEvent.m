//
//  AtmosplayRewardedVideoCustomEvent.h
//  PlayableMopubAd
//
//  Created by lgd on 2017/11/2.
//  Copyright © 2017年 lgd. All rights reserved.
//

#import "AtmosplayRewardedVideoCustomEvent.h"
#import "MPLogging.h"
#import "MPRewardedVideoError.h"
#import "MPRewardedVideoReward.h"
#import <AtmosplayAds/AtmosplayRewardedVideo.h>

@interface AtmosplayRewardedVideoCustomEvent() <AtmosplayRewardedVideoDelegate>
@property (nonatomic) AtmosplayRewardedVideo *rewardedVideo;

@end

@implementation AtmosplayRewardedVideoCustomEvent
- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *appID =  [info objectForKey:@"AppID"];
    appID = [appID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *adUnitID = [info objectForKey:@"AdUnitID"];
    adUnitID = [adUnitID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.rewardedVideo = [[AtmosplayRewardedVideo alloc] initWithAppID:appID adUnitID:adUnitID];
    self.rewardedVideo.autoLoad = NO;
    self.rewardedVideo.delegate = self;
    
    [self.rewardedVideo loadAd];
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    if (self.rewardedVideo.isReady){
        [self.rewardedVideo showRewardedVideoWithViewController:nil];
    }else{
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:nil];
    }
}

- (BOOL)hasAdAvailable {
    return self.rewardedVideo.ready;
}

#pragma mark - AtmosplayRewardedVideoDelegate
/// Tells the delegate that the user should be rewarded.
- (void)atmosplayRewardedVideoDidReceiveReward:(AtmosplayRewardedVideo *)ads {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoShouldRewardUserForCustomEvent:reward:)]) {
        MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:@"atmosplay" amount:[NSNumber numberWithInt:1]];
        [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
    }
}

/// Tells the delegate that succeeded to load ad.
- (void)atmosplayRewardedVideoDidLoad:(AtmosplayRewardedVideo *)ads {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidLoadAdForCustomEvent:)]) {
        [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
    }
}

/// Tells the delegate that failed to load ad.
- (void)atmosplayRewardedVideo:(AtmosplayRewardedVideo *)ads didFailToLoadWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidFailToLoadAdForCustomEvent:error:)]) {
        [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
    }
}

/// Tells the delegate that user starts playing the ad.
- (void)atmosplayRewardedVideoDidStartPlaying:(AtmosplayRewardedVideo *)ads {
    
}

/// Tells the delegate that the ad is being fully played.
- (void)atmosplayRewardedVideoDidEndPlaying:(AtmosplayRewardedVideo *)ads {
    
}

/// Tells the delegate that the landing page did present on the screen.
- (void)atmosplayRewardedVideoDidPresentLandingPage:(AtmosplayRewardedVideo *)ads {
    
}

/// Tells the delegate that the ad did animate off the screen.
- (void)atmosplayRewardedVideoDidDismissScreen:(AtmosplayRewardedVideo *)ads {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidDisappearForCustomEvent:)]) {
        [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
    }
}

/// Tells the delegate that the ad is clicked
- (void)atmosplayRewardedVideoDidClick:(AtmosplayRewardedVideo *)ads {
    if ([self.delegate respondsToSelector:@selector(rewardedVideoDidReceiveTapEventForCustomEvent:)]) {
        [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    }
}

- (void)dealloc {
    if (self.rewardedVideo.delegate) {
        self.rewardedVideo.delegate = nil;
    }
    if (self.rewardedVideo) {
        self.rewardedVideo = nil;
    }
}

@end
