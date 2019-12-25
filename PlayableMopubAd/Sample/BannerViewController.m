//
//  BannerViewController.m
//  PlayableMopubAd
//
//  Created by Michael Tang on 2019/10/31.
//  Copyright © 2019 lgd. All rights reserved.
//

#import "BannerViewController.h"
#import "MPAdView.h"

@interface BannerViewController ()<MPAdViewDelegate>

@property (nonatomic) MPAdView *adView;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)initBanner:(UIButton *)sender {
    if (!self.adView) {
        self.adView = [[MPAdView alloc] initWithAdUnitId:@"1e3656f9129a4d888e78ab5f5da4979e"];
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - 320) / 2,
        self.view.bounds.size.height - 50 - 34, 320, 50);
        [self.view addSubview:self.adView];
    }
    // banner auto refresh
    [self.adView loadAd];
    [self addLog:@"request banner..."];
}

- (IBAction)removeBanner:(UIButton *)sender {
    if (self.adView) {
        [self.adView removeFromSuperview];
        self.adView.delegate = nil;
        self.adView = nil;
        [self addLog:@"remove banner..."];
    }
}

- (void)addLog:(NSString*)msg {
    self.logTextView.text = [self.logTextView.text stringByAppendingFormat:@"\n%@", msg];
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}
- (void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    [self addLog:@"adViewDidLoadAd"];
}

- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
    NSString *errorMsg = [NSString stringWithFormat:@"adViewDidFailToLoadAd === %@",error];
    [self addLog:errorMsg];
}
/** @name Detecting When a User Interacts With the Ad View */
- (void)willPresentModalViewForAd:(MPAdView *)view{
    [self addLog:@"willPresentModalViewForAd"];
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view{
    [self addLog:@"willLeaveApplicationFromAd"];
}
- (void)didDismissModalViewForAd:(MPAdView *)view{
    [self addLog:@"didDismissModalViewForAd"];
}

@end
