//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import "Conference.h"
#import "Constants.h"
#import "Cfp.h"


@implementation Conference {

}
- (id)initWithYAML:(NSDictionary *)yaml {
    if (self = [super init]) {
        self.name = yaml[@"name"];
        self.link = yaml[@"link"];
        self.location = yaml[@"location"];
        self.cocoaOnly = [yaml[@"cocoa-only"] boolValue];

        self.startDate = [Constants.dateFormat dateFromString:yaml[@"start"]];
        self.endDate = [Constants.dateFormat dateFromString:yaml[@"end"]];

        self.cfp = [[Cfp alloc] initWithYAML:yaml[@"cfp"]];

    }
    return self;
}
@end