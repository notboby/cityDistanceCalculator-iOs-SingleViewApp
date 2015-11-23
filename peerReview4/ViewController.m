//
//  ViewController.m
//  peerReview4
//
//  Created by Robin Fabre on 22/11/2015.
//  Copyright © 2015 Robin Fabre. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;


@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;

@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocationB;

@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;

@property (weak, nonatomic) IBOutlet UILabel *distanceC;


@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitController;

@end


@implementation ViewController


- (IBAction)calculateButtonTaped:(id)sender {
    
    self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
    NSArray *dests = @[destA, destB, destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakself = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakself;
        if(!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
      
        //calculate first destination
        if(responses[0] != badResult){
            double num;
            
            if(strongSelf.unitController.selectedSegmentIndex == 0){
                num =([responses[0] floatValue]/1.0);
                NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                strongSelf.distanceA.text = x;
            }
            else if (strongSelf.unitController.selectedSegmentIndex == 1){
                num =([responses[0] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceA.text = x;
            }
            else{
                num =([responses[0] floatValue]*0.0006215);
                NSString *x = [NSString stringWithFormat:@"%.2f Miles", num];
                strongSelf.distanceA.text = x;
            }
            
        }
        else{
            strongSelf.distanceA.text = @"Error";
        }
        
       //calculate second destination
        
        if(responses[1] != badResult){
            double num;
            
            if(strongSelf.unitController.selectedSegmentIndex == 0){
                num =([responses[1] floatValue]/1.0);
                NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                strongSelf.distanceB.text = x;
            }
            else if (strongSelf.unitController.selectedSegmentIndex == 1){
                num =([responses[1] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceB.text = x;
            }
            else{
                num =([responses[1] floatValue]*0.0006215);
                NSString *x = [NSString stringWithFormat:@"%.2f Miles", num];
                strongSelf.distanceB.text = x;
            }
            
        }
        else{
            strongSelf.distanceB.text = @"Error";
        }
        
      //calculate third destination
        
        if(responses[2] != badResult){
            double num;
            
            if(strongSelf.unitController.selectedSegmentIndex == 0){
                num =([responses[2] floatValue]/1.0);
                NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                strongSelf.distanceC.text = x;
            }
            else if (strongSelf.unitController.selectedSegmentIndex == 1){
                num =([responses[2] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceC.text = x;
            }
            else{
                num =([responses[2] floatValue]*0.0006215);
                NSString *x = [NSString stringWithFormat:@"%.2f Miles", num];
                strongSelf.distanceC.text = x;
            }
            
        }
        else{
            strongSelf.distanceC.text = @"Error";
        }
        
        
        
        
        strongSelf.req = nil;
        
        strongSelf.calculateButton.enabled = YES;
    
    };
    
    [self.req start];
    
    
}


@end
