//
//  FileOperationController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2018/4/16.
//  Copyright © 2018年 pingjun lin. All rights reserved.
//

#import "FileOperationController.h"

@interface FileOperationController ()

@end

@implementation FileOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 测试用例-1： 存储数据
    NSArray *dataArray = @[
                            @{@"keyA1" : @"value\nA1", @"ke\nyA2" : @"valueA2"},
                            @{@"keyB1" : @"valueB2"},
                            @{@"keyC1" : @"valueC1", @"keyC2" : @"valueC2"},
                            @{@"key;D1" : @"valueD1", @"keyD2" : @"value;;D2", @"k;e\nyD3" : @"valueD4"}
                        ];
    [self store:dataArray];
    
    //
    NSArray *content = [self load:@"file"];
    NSLog(@"%@", content);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - store 存储数据
// 存储数据
- (void)store:(NSArray *)fileDataArray {
    if (!fileDataArray.count) {
        return;
    }
    
    NSMutableArray *componentArray = [NSMutableArray arrayWithCapacity:fileDataArray.count];
    for (NSDictionary *itemDict in fileDataArray) {
        NSString *str = [self getDictString:itemDict];
        [componentArray addObject:str];
    }
    
    if (componentArray.count) {
        NSString *writeString = [NSString stringWithFormat:@"text=\"%@\"", [componentArray componentsJoinedByString:@"\n"]];
        NSString *filePath = [self filePathWithFilename:@"file" andType:@"txt"];
        
        if (![self fileExistWithFilePath:filePath]) {
            [self createFileWithFilename:@"file" andType:@"txt"];
        }
        
        [writeString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSString *)getDictString:(NSDictionary *)dict {
    NSMutableArray *keyValueArray = [NSMutableArray arrayWithCapacity:dict.count];
    NSCharacterSet *charSet = [NSCharacterSet URLPathAllowedCharacterSet];
    for (NSString *key in dict.allKeys) {
        NSString *k = [key stringByAddingPercentEncodingWithAllowedCharacters:charSet];
        NSString *v = [dict[key] stringByAddingPercentEncodingWithAllowedCharacters:charSet];
        NSString *str = [NSString stringWithFormat:@"%@=%@", k, v];
        [keyValueArray addObject:str];
    }
    return [[keyValueArray copy] componentsJoinedByString:@";"];
}

#pragma mark - 加载数据

// 加载，获取文件数据
- (NSArray *)load:(NSString *)filename {
    NSString *filePath = [self filePathWithFilename:filename andType:@"txt"];
    
    NSMutableArray *contentMutableArray = [NSMutableArray array];
    if ([self fileExistWithFilePath:filePath]) {
        NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        // just great than 7 text=""
        NSString *prefixStr = @"text=\"";
        NSString *subfixStr = @"\"";
        if ([fileContent hasPrefix:prefixStr]) {
            NSRange range = NSMakeRange(prefixStr.length, fileContent.length - subfixStr.length - prefixStr.length - 1);
            NSArray *contentArray = [[fileContent substringWithRange:range] componentsSeparatedByString:@"\n"];
            
            for (NSString *itemString in contentArray) {
                NSDictionary *itemDict = [self getDictionaryWithString:itemString];
                [contentMutableArray addObject:itemDict];
            }
        }
    }
    return [contentMutableArray copy];
}

- (NSDictionary *)getDictionaryWithString:(NSString *)itemContent {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if ([itemContent containsString:@";"]) {
        NSArray *itemArray = [itemContent componentsSeparatedByString:@";"];
        for (NSString *item in itemArray) {
            NSArray *array = [item componentsSeparatedByString:@"="];
            NSString *key = [array[0] stringByRemovingPercentEncoding];
            NSString *value = [array[1] stringByRemovingPercentEncoding];
            dic[key] = value;
        }
    } else {
        NSArray *array = [itemContent componentsSeparatedByString:@"="];
        NSString *key = [array[0] stringByRemovingPercentEncoding];
        NSString *value = [array[1] stringByRemovingPercentEncoding];
        dic[key] = value;
    }
    return dic;
}

#pragma mark - 文件 文档操作

//创建文件
- (void)createFileWithFilename:(NSString *)filename andType:(NSString *)filetype {
    NSString *documentsPath = [self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, [NSString stringWithFormat:@"%@.%@", filename, filetype]];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        BOOL res = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (res) {
            NSLog(@"文件创建成功: %@" ,filePath);
        } else {
            NSLog(@"文件创建失败");
        }
    }
}

// get file path form document
- (NSString *)filePathWithFilename:(NSString *)filename andType:(NSString *)filetype {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, [NSString stringWithFormat:@"%@.%@", filename, filetype]];
    
    return filePath;
}

- (BOOL)fileExistWithFilePath:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    } else {
        return NO;
    }
}

//获取Documents目录
- (NSString *)dirDoc {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end
