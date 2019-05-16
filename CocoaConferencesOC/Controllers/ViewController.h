//
//  ViewController.h
//  CocoaConferencesOC
//
//  Created by jetbrains on 2019-05-16.
//  Copyright © 2019 JetBrains. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Conference;


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property(nonatomic, strong) NSMutableArray<Conference *> *conferences;
@property(nonatomic, strong) UITableView *tableView;
@end
