//
//  ViewController.m
//  ARImageScanDemo
//
//  Created by zhangbotian on 2024/3/16.
//

#import "ViewController.h"
#import "ARImageScanDemo-Swift.h"

@interface ViewController ()

@property (nonatomic, strong) ImageScanPageViewController *arViewController;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
}

- (void)presentARViewController {
    [self presentViewController:self.arViewController animated:YES completion:nil];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button setTitle:@"跳转界面" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(presentARViewController) forControlEvents:UIControlEventTouchUpInside];
        [_button sizeToFit];
        _button.center = self.view.center;
    }
    return _button;
}

- (ImageScanPageViewController *)arViewController {
    if (!_arViewController) {
        _arViewController = [[ImageScanPageViewController alloc] init];
    }
    return _arViewController;
}


@end
