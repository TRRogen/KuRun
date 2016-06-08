//
//  KRRegisterViewController.h
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^registerSuccessBlock)(NSString * userName , NSString* password);

@interface KRRegisterViewController : UIViewController

@property(nonatomic,copy)registerSuccessBlock registerCompleteHandle;

@end
