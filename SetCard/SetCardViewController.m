//
//  SetCardViewController.m
//  SetCard
//
//  Created by Jonathan Lozinski on 06/10/2013.
//  Copyright (c) 2013 Jonathan Lozinski. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardView.h"

@interface SetCardViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@end

@implementation SetCardViewController

- (IBAction)setColour:(UISegmentedControl *)sender {
    self.setCardView.colour = sender.selectedSegmentIndex;
}

- (IBAction)setShape:(UISegmentedControl *)sender {
    self.setCardView.shape = sender.selectedSegmentIndex;
}

- (IBAction)setFill:(UISegmentedControl *)sender {
    self.setCardView.fill = sender.selectedSegmentIndex;
}

- (IBAction)setCount:(UISegmentedControl *)sender {
    self.setCardView.count = sender.selectedSegmentIndex + 1;
}


@end
