//
//  NewsViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/26/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UICollectionViewController
{
    NSMutableArray *RSSFeedArray;
    NSMutableArray *tableDataArray;
    NSString *link;
    
   // IBOutlet UITableView *feedTable;
   // IBOutlet UIProgressView *threadProgressView;
    
    UIProgressView *progressView;
    NSMutableData *receivedData;
   // UILabel *progressLabel;
    int totalfilesize;
    int filesizereceived;
    float filepercentage;
}


@end



