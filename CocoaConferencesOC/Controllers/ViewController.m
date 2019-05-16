//
//  ViewController.m
//  CocoaConferencesOC
//
//  Created by jetbrains on 2019-05-16.
//  Copyright © 2019 JetBrains. All rights reserved.
//

#import "ViewController.h"
#import "ConferenceCell.h"
#import "Constants.h"
#import "Conference.h"
#import "ConferenceViewController.h"
#import <YAMLFrameworkOrdered/YAMLSerialization.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Conferences";

    self.conferences = [NSMutableArray <Conference *> array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

    [self.tableView registerClass:[ConferenceCell class] forCellReuseIdentifier:@"id"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self loadConferences];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

- (void)loadConferences {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithArray:@[@"text/plain"]];

    [manager GET:kConfUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSData *data = responseObject;
        NSInputStream *stream = [[NSInputStream alloc] initWithData:data];
        NSArray *yaml = (NSArray *) [YAMLSerialization objectWithYAMLStream:stream
                                                                    options:kYAMLReadOptionStringScalars
                                                                      error:nil];
        for (NSDictionary *item  in yaml) {
            Conference *c = [[Conference alloc] initWithYAML:item];
            [self.conferences addObject:c];
            [self.tableView reloadData];
        }

        NSLog(@"%s", [[yaml description] UTF8String]);
    }    failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conferences.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    Conference *conference = self.conferences[indexPath.row];
    cell.textLabel.text = conference.name;
    cell.detailTextLabel.text = conference.location;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConferenceViewController *controller = [[ConferenceViewController alloc] init];
    Conference *conference = self.conferences[indexPath.row];
    controller.conference = conference;
    [self.navigationController pushViewController:controller animated:YES];

}


@end