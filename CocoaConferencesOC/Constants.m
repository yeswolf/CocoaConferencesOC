//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import "Constants.h"

@implementation Constants {

}
+ (NSDateFormatter *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return formatter;
}

+ (NSDateFormatter *)friendlyDateFormat {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MMMM dd, yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return formatter;

}

+ (NSDate *)zeroDateComponents:(NSString *)stringDate {
    NSDate *date = [[Constants dateFormat] dateFromString:stringDate];
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return [NSCalendar.currentCalendar dateFromComponents:components];
}


@end