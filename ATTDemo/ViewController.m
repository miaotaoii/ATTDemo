//
//  ViewController.m
//  ATTDemo
//
//  Created by pluto on 2021/5/18.
//

#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [self showPreDialog];
    
}

//展示前置弹窗
-(void)showPreDialog{
    if (![self shouldShowPreDialog]) {
        NSLog(@"用户已选择过授权弹窗");
        return;
    }
    NSString *title = @"GET A PERSONALIZED EXPERIENCE!";
    NSString *msg = @"Ads help support our business. Please Tap Allow tracking";
    
    
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getATTState];
    }];
    [alertController addAction:okAction];
    [self.view.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

///是否需要展示前置弹窗
//根据游戏业务设计，可选择在14.0 以上展示或 在14.5以上展示
-(BOOL)shouldShowPreDialog{
    if (@available(iOS 14.5,*)) {
        ATTrackingManagerAuthorizationStatus states = [ATTrackingManager trackingAuthorizationStatus];
        NSLog(@"获取ATT权限 status=%lu",(unsigned long)states);
        if(states==ATTrackingManagerAuthorizationStatusNotDetermined){
            return YES;
        }else{
            return NO;
        }
    }
    return  NO;
}


-(void)getATTState{
    //todo 判断是否是ios14
    if(@available(iOS 14.5,*)){
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            //获取授权结果后 继续游戏逻辑
        }];
    }
}


@end
