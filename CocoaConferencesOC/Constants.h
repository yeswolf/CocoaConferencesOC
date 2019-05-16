//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kConfUrl @"https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/conferences.yml"

@interface Constants : NSObject

+ (NSDateFormatter *)dateFormat;

+ (NSDateFormatter *)friendlyDateFormat;

+ (NSDate *)zeroDateComponents:(NSString *)stringDate;

@end