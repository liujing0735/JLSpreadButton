//
//  ViewController.m
//  JLSpreadButton
//
//  Created by JohnnyLiu on 2016/11/24.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import "ViewController.h"
#import "JLSpreadButton.h"

@interface ViewController () <JLSpreadButtonDelegate>

@property (strong, nonatomic) JLSpreadButton *spreadButton0;
@property (strong, nonatomic) JLSpreadButton *spreadButton1;
@property (strong, nonatomic) JLSpreadButton *spreadButton2;
@property (strong, nonatomic) JLSpreadButton *spreadButton3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _spreadButton0 = [[JLSpreadButton alloc] initWithFrame:CGRectMake(200, 200, 30, 30) delegate:self];
    [_spreadButton0 setImage:[UIImage imageNamed:@"en"] forState:UIControlStateNormal];
    [_spreadButton0 setImages:@[[UIImage imageNamed:@"en"],[UIImage imageNamed:@"nl"],[UIImage imageNamed:@"de"],[UIImage imageNamed:@"fr"],[UIImage imageNamed:@"it-IT"]]];
    [self.view addSubview:_spreadButton0];
    
    _spreadButton1 = [[JLSpreadButton alloc] initWithFrame:CGRectMake(200, 250, 30, 30) delegate:self];
    [_spreadButton1 setImage:[UIImage imageNamed:@"en"] forState:UIControlStateNormal];
    [_spreadButton1 setImages:@[[UIImage imageNamed:@"en"],[UIImage imageNamed:@"nl"],[UIImage imageNamed:@"de"],[UIImage imageNamed:@"fr"],[UIImage imageNamed:@"it-IT"]]];
    [_spreadButton1 setSpreadOrientation:JLSpreadOrientationDown];
    [_spreadButton1 setAutoChoosePicture:NO];
    [self.view addSubview:_spreadButton1];
    
    _spreadButton2 = [[JLSpreadButton alloc] initWithFrame:CGRectMake(150, 225, 30, 30) delegate:self];
    [_spreadButton2 setImage:[UIImage imageNamed:@"en"] forState:UIControlStateNormal];
    [_spreadButton2 setImages:@[[UIImage imageNamed:@"en"],[UIImage imageNamed:@"nl"],[UIImage imageNamed:@"de"],[UIImage imageNamed:@"fr"],[UIImage imageNamed:@"it-IT"]]];
    [_spreadButton2 setSpreadOrientation:JLSpreadOrientationLeft];
    [_spreadButton2 setRotate:NO];
    [self.view addSubview:_spreadButton2];
    
    _spreadButton3 = [[JLSpreadButton alloc] initWithFrame:CGRectMake(250, 225, 30, 30) delegate:self];
    [_spreadButton3 setImage:[UIImage imageNamed:@"en"] forState:UIControlStateNormal];
    [_spreadButton3 setImages:@[[UIImage imageNamed:@"en"],[UIImage imageNamed:@"nl"],[UIImage imageNamed:@"de"],[UIImage imageNamed:@"fr"],[UIImage imageNamed:@"it-IT"]]];
    [_spreadButton3 setSpreadOrientation:JLSpreadOrientationRight];
    [_spreadButton3 setAutoChoosePicture:NO];
    [_spreadButton3 setRotate:NO];
    [self.view addSubview:_spreadButton3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JLSpreadButtonDelegate
- (void)spreadButton:(JLSpreadButton *)spreadButton spreadState:(BOOL)state {

    if (spreadButton == _spreadButton0) {
        
    }else if (spreadButton == _spreadButton1) {
    
    }else if (spreadButton == _spreadButton2) {
        
    }else if (spreadButton == _spreadButton3) {
        
    }
}

- (void)spreadButton:(JLSpreadButton *)spreadButton clickButtonAtIndex:(NSInteger)index {

    if (spreadButton == _spreadButton0) {
        
    }else if (spreadButton == _spreadButton1) {
        
    }else if (spreadButton == _spreadButton2) {
        
    }else if (spreadButton == _spreadButton3) {
        
    }
}

@end
