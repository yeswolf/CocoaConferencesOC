//
// Created by jetbrains on 2019-05-16.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ConferenceViewController.h"
#import "Conference.h"
#import "Constants.h"
#import "Cfp.h"


@implementation ConferenceViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.conference.name;
    self.view.backgroundColor = UIColor.whiteColor;

    CGFloat margin = 60.0;
    CGFloat left = 20;
    CGFloat labelHeight = 40.0;

    UIView *boxView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:boxView];

    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.view.frame.size.width));
        make.height.equalTo(@(self.view.frame.size.height - 2 * margin));
        make.left.equalTo(@(left));
        CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
        make.top.equalTo(@(height * 2));
    }];

    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    linkLabel.text = [NSString stringWithFormat:@"🔗 %@", self.conference.link];
    [boxView addSubview:linkLabel];
    [linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(labelHeight));
        make.left.equalTo(boxView.mas_left);
        make.top.equalTo(boxView.mas_top);
    }];

    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [boxView addSubview:dateLabel];
    dateLabel.text = [NSString stringWithFormat:@"🗓 %@", [Constants.friendlyDateFormat stringFromDate:self.conference.startDate]];
    if (self.conference.endDate != nil) {
        dateLabel.text = [NSString stringWithFormat:@"%@ - %@", dateLabel.text, [Constants.friendlyDateFormat stringFromDate:self.conference.endDate]];
    }
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(labelHeight));
        make.left.equalTo(boxView.mas_left);
        make.top.equalTo(linkLabel.mas_bottom);
    }];

    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [boxView addSubview:locationLabel];
    locationLabel.text = self.conference.location;
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(labelHeight));
        make.left.equalTo(boxView.mas_left);
        make.top.equalTo(dateLabel.mas_bottom);
    }];

    Cfp *cfp = self.conference.cfp;
    if (cfp != nil) {
        UILabel *cfpLinkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        cfpLinkLabel.text = cfp.link;
        [boxView addSubview:cfpLinkLabel];
        [cfpLinkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(@(labelHeight));
            make.left.equalTo(boxView.mas_left);
            make.top.equalTo(locationLabel.mas_bottom);
        }];

        UILabel *cfpDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        if (cfp.deadline != nil) {
            [boxView addSubview:cfpDateLabel];
            cfpDateLabel.text = [NSString stringWithFormat:@"🖊🗓 %@", [Constants.friendlyDateFormat stringFromDate:cfp.deadline]];
            [cfpDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.view.mas_width);
                make.height.equalTo(@(labelHeight));
                make.left.equalTo(boxView.mas_left);
                make.top.equalTo(cfpLinkLabel.mas_bottom);
            }];
        }
    }

    /*
    if let cfp = conference?.cfp {
        self.cfpLinkLabel.text = "🖊🔗 \(cfp.link)"
        if let deadline = cfp.deadline {
                self.cfpDateLabel.text = "🖊🗓 \(friendlyDateFormat.string(from: deadline))"
            } else {
            cfpDateLabel.isHidden = true
        }
        boxView.addSubview(cfpLinkLabel)
        cfpLinkLabel.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(labelHeight)
            maker.left.equalTo(0)
            maker.topMargin.equalTo(locationLabel.snp.bottom)
        }
        boxView.addSubview(cfpDateLabel)
        cfpDateLabel.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(labelHeight)
            maker.left.equalTo(0)
            maker.topMargin.equalTo(cfpLinkLabel.snp.bottom)
        }

    } else {
        cfpLinkLabel.isHidden = true
        cfpDateLabel.isHidden = true
    }*/

}

@end