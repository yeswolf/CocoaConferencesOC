//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Conference;


@interface ConferenceViewController : UIViewController
@property(nonatomic, strong) Conference *conference;
@property(nonatomic, strong) UILabel *label;
@end