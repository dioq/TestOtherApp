//
//  TestOtherAppUITests.m
//  TestOtherAppUITests
//
//  Created by Dio Brand on 2022/8/23.
//

#import <XCTest/XCTest.h>

@interface TestOtherAppUITests : XCTestCase

@property(nonatomic,strong)XCUIApplication *app;

@end

@implementation TestOtherAppUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    _app = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.tencent.xin"];
    [_app launch];
    [_app.buttons[@"登录"] tap];
    [NSThread sleepForTimeInterval:2.0];
    [_app.buttons[@"使用其他方式登录"] tap];
    [_app.buttons[@"用微信号/QQ号/邮箱登录"] tap];
    
    XCUIElement *accountTF = [_app.textFields elementBoundByIndex:0];
    [accountTF tap];
    [accountTF typeText:@"+66837150849"];
    
    XCUIElement *pwdTF = [_app.secureTextFields elementBoundByIndex:0];
    [pwdTF tap];
    [pwdTF typeText:@"mowo4585"];
    
    [_app.buttons[@"同意并登录"] tap];
    
    [NSThread sleepForTimeInterval:2.0];
    XCUIElement *image = self.app.images[@"slider"];
    if (image.exists) {
//        NSLog(@"image\n%@",image);
        NSLog(@"%f %f %f %f",image.frame.origin.x,image.frame.origin.y,
              image.frame.size.width,image.frame.size.height);
        float x_rat = (image.frame.origin.x + (image.frame.size.width / 2)) / 375;
        float y_rat = (image.frame.origin.y + (image.frame.size.height / 2)) / 667;
        CGVector point1 = CGVectorMake(x_rat, y_rat);
        
        float x_target = (image.frame.origin.x + 150) / [UIScreen mainScreen].bounds.size.width;
        CGVector point2 = CGVectorMake(x_target, y_rat);
        XCUICoordinate *coord1 = [self.app coordinateWithNormalizedOffset:point1];
        XCUICoordinate *coord2 = [self.app coordinateWithNormalizedOffset:point2];
        // 从coord1 拖到 coord2点
        [coord1 pressForDuration:3 thenDragToCoordinate:coord2];
    }else{
        NSLog(@"滑动不存在 .....");
    }
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
