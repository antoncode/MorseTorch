//
//  ARReceiverViewController.h
//  MorseTorch
//
//  Created by Anton Rivera on 4/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARMagicEvents.h"

@interface ARReceiverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *videoView;
@property (strong, nonatomic) ARMagicEvents *arMagicEvents;

@end
