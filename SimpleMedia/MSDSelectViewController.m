//
//  MSDSelectViewController.m
//  SimpleMedia
//
//  Created by Matthew Dobson on 11/9/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDSelectViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MSDSelectViewController () {
    UILabel *track;
    UILabel *url;
}

@end

@implementation MSDSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80.0, 210.0, 160.0, 40.0)];
    [button setTitle:@"Select" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openMedia) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UILabel *trackTitle = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 270.0, 160.0, 40.0)];
    UILabel *trackUrl = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 340.0, 160.0, 40.0)];
    [trackTitle setTextColor:[UIColor redColor]];
    [trackUrl setTextColor:[UIColor redColor]];
    [trackTitle setText:@"Title of Song"];
    [trackUrl setText:@"URL of song"];
    [self.view addSubview:trackTitle];
    [self.view addSubview:trackUrl];
    track = trackTitle;
    url = trackUrl;

	// Do any additional setup after loading the view.
}

- (void)openMedia {
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = NO;
    picker.prompt = @"Pick song!";
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    if (mediaItemCollection) {
        NSArray *songs = [mediaItemCollection items];
        MPMediaItem * item = [songs objectAtIndex:0];
        NSURL *mediaUrl = [item valueForProperty:MPMediaItemPropertyAssetURL];
        NSString *mediaTitle = [item valueForProperty:MPMediaItemPropertyTitle];
        AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:mediaUrl options:nil];
        [track setText:mediaTitle];
        [url setText:[mediaUrl absoluteString]];
        NSLog(@"%@",[mediaUrl absoluteString]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
