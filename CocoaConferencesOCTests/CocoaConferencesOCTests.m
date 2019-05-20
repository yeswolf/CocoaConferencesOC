#import <Specta/Specta.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <YAMLFrameworkOrdered/YAMLSerialization.h>
#import "Conference.h"
#import "Constants.h"
#import "Cfp.h"

SpecBegin(NetworkTests)

    describe(@"API", ^{
        it(@"should load conference list", ^{
            waitUntil(^(DoneCallback done) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
                manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithArray:@[@"text/plain"]];

                [manager GET:kConfUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                    NSData *data = responseObject;
                    NSInputStream *stream = [[NSInputStream alloc] initWithData:data];
                    NSArray *yaml = (NSArray *) [YAMLSerialization objectWithYAMLStream:stream
                                                                                options:kYAMLReadOptionStringScalars
                                                                                  error:nil];
                    NSMutableArray <Conference *> *conferences = [NSMutableArray arrayWithCapacity:0];
                    for (NSDictionary *item  in yaml) {
                        Conference *c = [[Conference alloc] initWithYAML:item];
                        [conferences addObject:c];
                    }
                    XCTAssertGreaterThan(conferences.count, 0);
                    XCTAssertNotNil(conferences[0].name);
                    done();
                }    failure:^(NSURLSessionTask *operation, NSError *error) {
                    done();
                }];
            });
        });
        it(@"should load conference with CFP", ^{
            NSString *text = @"- name: mDevCamp\n"
                             "  link: https://mdevcamp.eu/\n"
                             "  start: 2019-05-30\n"
                             "  end: 2019-05-31\n"
                             "  location: 🇨🇿 Prague, Czech Republic\n"
                             "  cocoa-only: false\n"
                             "  cfp:\n"
                             "    link: https://goo.gl/forms/eoX2WfG1LRoZPxxo1\n"
                             "    deadline: 2019-02-28\n";
            NSArray *yaml = (NSArray *) [YAMLSerialization objectWithYAMLString:text options:kYAMLReadOptionStringScalars error:nil];
            Conference *c = [[Conference alloc] initWithYAML:yaml[0]];
            XCTAssertEqualObjects(c.name, @"mDevCamp");
            XCTAssertEqualObjects(c.startDate, [Constants zeroDateComponents:@"2019-05-30"]);
            XCTAssertEqualObjects(c.endDate, [Constants zeroDateComponents:@"2019-05-31"]);
            XCTAssertEqual(c.cocoaOnly, NO);
            XCTAssertEqualObjects(c.location, @"🇨🇿 Prague, Czech Republic");
            Cfp *cfp = [[Cfp alloc] init];
            cfp.link = @"https://goo.gl/forms/eoX2WfG1LRoZPxxo1";
            cfp.deadline = [Constants zeroDateComponents:@"2019-02-28"];
            XCTAssertEqualObjects(c.cfp.link, cfp.link);
            XCTAssertEqualObjects(c.cfp.deadline, cfp.deadline);
        });
        it(@"should load conference without CFP", ^{
            NSString *text = @"- name: mDevCamp\n"
                             "  link: https://mdevcamp.eu/\n"
                             "  start: 2019-05-30\n"
                             "  end: 2019-05-31\n"
                             "  location: 🇨🇿 Prague, Czech Republic\n"
                             "  cocoa-only: false\n";
            NSArray *yaml = (NSArray *) [YAMLSerialization objectWithYAMLString:text options:kYAMLReadOptionStringScalars error:nil];
            Conference *c = [[Conference alloc] initWithYAML:yaml[0]];
            XCTAssertEqualObjects(c.name, @"mDevCamp");
            XCTAssertEqualObjects(c.startDate, [Constants zeroDateComponents:@"2019-05-30"]);
            XCTAssertEqualObjects(c.endDate, [Constants zeroDateComponents:@"2019-05-31"]);
            XCTAssertEqual(c.cocoaOnly, NO);
            XCTAssertEqualObjects(c.location, @"🇨🇿 Prague, Czech Republic");
            XCTAssertNotNil(c.cfp);
        });
    });

SpecEnd