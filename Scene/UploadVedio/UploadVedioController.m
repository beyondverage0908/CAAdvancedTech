//
//  UploadVedioController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/11/15.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "UploadVedioController.h"
#import <AVKit/AVKit.h>
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>


@interface UploadVedioController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation UploadVedioController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 50)];
    [button setTitle:@"相册获取视频" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(pickVedio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *liveVedioBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 50)];
    [liveVedioBtn setTitle:@"拍摄获取视频" forState:UIControlStateNormal];
    liveVedioBtn.backgroundColor = [UIColor cyanColor];
    [liveVedioBtn addTarget:self action:@selector(liveVedioAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:liveVedioBtn];
    
    UIImageView *videoThuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    [self.view addSubview:videoThuImageView];
    videoThuImageView.image = [self getPlaceholderImageFromVideo:@"http://119.23.148.104/image/931345031250313216.mp4"];
    
    UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width - 40, 50)];
    [upButton setTitle:@"播放视频" forState:UIControlStateNormal];
    upButton.backgroundColor = [UIColor yellowColor];
    [upButton addTarget:self action:@selector(playVidea:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 播放视频

- (void)playVidea:(UIButton *)btn {
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Alladin" withExtension:@"mp4"];
    NSURL *url = [NSURL URLWithString:@"http://119.23.148.104/image/931345031250313216.mp4"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerViewController *playController = [[AVPlayerViewController alloc] init];
    playController.player = player;
    [playController.player play];
    [self presentViewController:playController animated:YES completion:nil];
}

#pragma mark - 视频缩略图

- (UIImage *)getPlaceholderImageFromVideo:(NSString *)videoURL {
    NSURL *url = [NSURL URLWithString:videoURL];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    CMTime time = [asset duration];
    time.value = 0;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbnail;
}
#pragma mark - UIImagePickerController 代理触发

- (void)pickVedio {
    [self choosevideo];
}

- (void)liveVedioAction {
    [self startvideo];
}

#pragma mark - 选择视频， 录制视频

//选择本地视频
- (void)choosevideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
}

//录制视频
- (void)startvideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    //Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.videoMaximumDuration = 30.0f;//30秒
    ipc.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    ipc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo; // 拍照模式
    ipc.cameraDevice = UIImagePickerControllerCameraDeviceRear; // 前置/后置摄像头 default rear
    
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 250, 100, 150)];
    overlayView.backgroundColor = [UIColor yellowColor];
    ipc.cameraOverlayView = overlayView;
    
    ipc.delegate = self;//设置
}

#pragma mark - 视频大小

//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat)getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0 * size / 1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//此方法可以获取视频文件的时长。
- (CGFloat) getVideoLength:(NSURL *)URL {
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

#pragma mark - 压缩

//完成视频录制，并压缩后显示大小、时长
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
    NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
}


- (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
             case AVAssetExportSessionStatusCompleted:
             {
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 dispatch_async(dispatch_get_main_queue() , ^{
                     [self alertUploadVideo:outputURL];
                 });
             }
                 break;
             default:
                 NSLog(@"defalut");
         }
         
     }];
}

- (void)alertUploadVideo:(NSURL *)URL{
    CGFloat size = [self getFileSize:[URL path]];
    NSString *message;
    NSString *sizeString;
    CGFloat sizemb= size / 1024;
    if(size <= 1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }

    if( sizemb < 2){
        [self uploadVideo:URL];
    } else if(sizemb<=5){
        message = [NSString stringWithFormat:@"视频%@，大于2MB会有点慢，确定上传吗？", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self uploadVideo:URL];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (sizemb>5){
        message = [NSString stringWithFormat:@"视频%@，超过5MB，不能上传，抱歉。", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 上传视频

- (void)uploadVideo:(NSURL *)url {
    NSLog(@"--->>> 上传视频");
    
    NSLog(@"upload:上传视频");
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:@"videoUrl"] name:@"video_file" fileName:@"Movie4.mp4" mimeType:@"video/quicktime" error:nil];
    } error:nil];
    [request setValue:@"IOS" forHTTPHeaderField:@"User-Agent"];
    NSURLSessionUploadTask * uploadTask = [manager
                                           uploadTaskWithStreamedRequest:request
                                           progress:^(NSProgress * _Nonnull uploadProgress) {
                                               // This is not called back on the main queue.
                                               // You are responsible for dispatching to the main queue for UI updates
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   //Update the progress view
                                                   //                          [progressView setProgress:uploadProgress.fractionCompleted];
                                                   [self.view setUserInteractionEnabled:false];
                                                   //                                                   [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"处理中..."];
                                                   if (uploadProgress.fractionCompleted>=1.0) {
                                                       //                                                       [SVProgressHUD dismiss];
                                                       [self.view setUserInteractionEnabled:true];
                                                   }
                                               });
                                           }
                                           completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                               if (error) {
                                                   NSLog(@"Error: %@", error);
                                               } else {
                                                   NSLog(@"%@", responseObject);
                                                   if ([[responseObject objectForKey:@"ok"] isEqualToString:@"1"]) {
                                                       //上传之后选图片
                                                       //                                                       PhotoViewController *photoVC = [[PhotoViewController alloc] init];
                                                       //                                                       [self.navigationController pushViewController:photoVC animated:true];
                                                   }
                                                   else{
                                                       //                                                       [SVProgressHUD showErrorWithStatus:@"提交出现错误，请重新提交"];
                                                   }
                                               }
                                           }];
    
    [uploadTask resume];
}

@end
