//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cfp : NSObject

@property(nonatomic, strong) NSString *link;
@property(nonatomic, strong) NSDate *deadline;

- (id)initWithYAML:(NSDictionary *)yaml;
@end