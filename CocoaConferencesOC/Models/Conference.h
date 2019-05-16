//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cfp;


@interface Conference : NSObject

@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSString *link;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, assign) BOOL cocoaOnly;
@property(nonatomic, strong) Cfp *cfp;

- (id)initWithYAML:(NSDictionary *)yaml;
@end