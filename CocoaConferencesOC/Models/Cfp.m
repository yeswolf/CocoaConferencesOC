//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import "Cfp.h"
#import "Constants.h"


@implementation Cfp

- (id)initWithYAML:(NSDictionary *)yaml {
    if (self = [super init]) {
        if (yaml.count > 0) {
            self.link = yaml[@"link"];
            self.deadline = [Constants.dateFormat dateFromString:yaml[@"deadline"]];
        }
    }
    return self;
}
@end