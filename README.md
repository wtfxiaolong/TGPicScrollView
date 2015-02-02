# TGPicScrollView 
Just try the best ScrollView to show the different images.<br>
The main mind of the project is reusing the three UIImageView.<br>
I found it just need three views in a scrollview.<br>
#####USAGE:
    NSArray *array = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    CGRect rect = CGRectMake(20, 150, 270, 120);
    
    PicScroView *adView = [[PicScroView alloc] initWithFrame:rect delegate:self imageArray:array];
    [adView startTurnning];
    [self.view addSubview:adView];
<br>
![](./123.gif)
