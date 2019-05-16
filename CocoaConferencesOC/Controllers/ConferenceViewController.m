//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ConferenceViewController.h"
#import "Conference.h"


@implementation ConferenceViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.conference.name;
    self.view.backgroundColor = UIColor.whiteColor;

    CGFloat margin = 60.0;
    CGFloat labelHeight = 40.0;

    UIView *boxView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:boxView];

    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.view.frame.size.width - 2 * margin));
        make.height.equalTo(@(self.view.frame.size.height - 2 * margin));
        make.left.equalTo(@(0));
        make.top.equalTo(@80);
    }];

    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    linkLabel.text = [NSString stringWithFormat:@"🔗 %@", self.conference.link];
    [boxView addSubview:linkLabel];
    [linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(labelHeight));
        make.left.equalTo(boxView.mas_left);
        make.top.equalTo(@0);
    }];
}

@end