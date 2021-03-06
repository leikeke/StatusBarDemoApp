//
//  ViewController.m
//  RouterDemo
//
//  Created by Alexcai on 2018/11/23.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <PassKit/PassKit.h>
#import <StoreKit/StoreKit.h>
#import "XCAppEnterViewController.h"
#import "XCView.h"
#import <objc/runtime.h>

@interface ViewController ()<PKPaymentAuthorizationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%s",__FUNCTION__);
//}
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    NSLog(@"%s",__FUNCTION__);
//}


- (IBAction)clickPayButton:(UIButton *)sender {
//    NSLog(@"button frame = %@",NSStringFromCGRect(sender.frame));
//    [self p_testDispatchRunloop];
    static NSString *imgName = @"red";
    if ([imgName isEqualToString:@"yellow"]) {
        imgName = @"red";
    }else{
        imgName = @"yellow";
    }
    
    
//    self.imgView.image = [UIImage imageNamed:imgName];
    
//    sender.imageView.image = [UIImage imageNamed:imgName];
//    NSLog(@"%@",NSStringFromCGRect(sender.imageView.frame));
    
//    unsigned int count;
//    Ivar *lists =  class_copyIvarList([sender class], &count);
//
//    for (int i = 0; i < count; i++) {
//       const char *p_name =  ivar_getName(lists[i]);
//
//        NSLog(@"%s",p_name);
//
//    }
    UIImageView *backgroundView =  [sender valueForKeyPath:@"backgroundView"];
    NSLog(@"back view frame = %@, image = %@",NSStringFromCGRect(backgroundView.frame),backgroundView.image);
    backgroundView.image = [UIImage imageNamed:imgName];
    NSLog(@"back view frame = %@, image = %@",NSStringFromCGRect(backgroundView.frame),backgroundView.image);
//    [sender setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//    [sender setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
//    NSLog(@"button frame = %@",NSStringFromCGRect(sender.frame));
}
- (IBAction)pushButtonAction:(UIButton *)sender {
}
- (IBAction)pushAction:(UIBarButtonItem *)sender {
}
/** 点击push button */
- (IBAction)clickPushButton:(UIButton *)sender {
    XCAppEnterViewController *controller = [[XCAppEnterViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - private method

- (void)p_didLoad{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dipatch main code ...");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"button");
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"inner button");
            });
        });
        
    });
}

- (void)p_testDispatchRunloop{
    NSLog(@"%s", __PRETTY_FUNCTION__);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (int i = 0; i < 10000; i++) {
//            NSString *str = [NSString stringWithFormat:@"%d",1];
//            NSLog(@"%@",str);
//        }
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"async main queue");
//        });
//    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger i = 1;
        /** 只有当 while 执行完毕 才会更新UI */
        while (i) {
            i ++;
            if (i == 20) {
                self.label.text = @"aaaaa";
                i = 0;
            }
        }
    });
}

- (void)p_testRunloopDispatch{
    NSLog(@"click Button");
    UILabel *outerLabel = [[UILabel alloc]initWithFrame:CGRectInset(self.view.bounds, 100, 100)];
    outerLabel.backgroundColor = UIColor.redColor;
    outerLabel.text = @"outer Label";
    [self.view addSubview:outerLabel];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"button");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"inner main queue");
            UILabel *innerLabel = [[UILabel alloc]initWithFrame:CGRectInset(self.view.bounds, 130, 150)];
            innerLabel.backgroundColor = UIColor.orangeColor;
            innerLabel.text = @"inner Label";
            [self.view addSubview:innerLabel];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"third  main queue");
            });
        });
    });
    NSLog(@"after.....");
}

- (void)p_testRuntimeForFramework{
    unsigned int imageCount = 0;
    const char **images = objc_copyImageNames(&imageCount);
    
    for (int i = 0; i < imageCount; i++) {
        NSLog(@"%s",images[i]);
    }
}
/** apple pay  */
- (void)p_testApplePay{
    NSDecimalNumber *payNumber = [[NSDecimalNumber alloc]initWithString:@"20.5"];
    
    PKPaymentSummaryItem *payItem = [PKPaymentSummaryItem summaryItemWithLabel:@"Hello Pay~" amount:payNumber];
    
    
    
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc]init];
    payRequest.countryCode = @"CN";
    payRequest.currencyCode = @"CNY";
    payRequest.merchantIdentifier = @"com.day.g";
    
    
    /**
     PKPaymentNetworkAmex
     PKPaymentNetworkCarteBancaire
     PKPaymentNetworkCarteBancaires
     PKPaymentNetworkCartesBancaires
     PKPaymentNetworkChinaUnionPay
     PKPaymentNetworkDiscover
     PKPaymentNetworkEftpos
     PKPaymentNetworkElectron
     PKPaymentNetworkIDCredit
     PKPaymentNetworkInterac
     PKPaymentNetworkJCB
     PKPaymentNetworkMaestro
     PKPaymentNetworkMasterCard
     PKPaymentNetworkPrivateLabel
     PKPaymentNetworkQuicPay
     PKPaymentNetworkSuica
     PKPaymentNetworkVisa
     PKPaymentNetworkVPay
     */
    payRequest.supportedNetworks = @[PKPaymentNetworkInterac];
    /**
     PKMerchantCapability3DS                                  = 1UL << 0,   // Merchant supports 3DS
     PKMerchantCapabilityEMV                                  = 1UL << 1,   // Merchant supports EMV
     PKMerchantCapabilityCredit NS_ENUM_AVAILABLE_IOS(9_0) = 1UL << 2,   // Merchant supports credit
     PKMerchantCapabilityDebit
     */
    payRequest.merchantCapabilities = PKMerchantCapabilityDebit;//PKMerchantCapabilityCredit;
    payRequest.paymentSummaryItems = @[payItem];
    
    PKPaymentAuthorizationViewController * controller = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:payRequest];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
/** iap */
- (void)p_testStoreKit{
    
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate
- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
