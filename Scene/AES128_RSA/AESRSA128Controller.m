//
//  AESRSA128Controller.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/1/5.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "AESRSA128Controller.h"
#import "AES128Util.h"
#import "RSAEncryptor.h"

@interface AESRSA128Controller ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *AESKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *AESInputTextField;
@property (weak, nonatomic) IBOutlet UITextView *AESShowTextView;

@property (weak, nonatomic) IBOutlet UITextField *RSAInputTextField;
@property (weak, nonatomic) IBOutlet UITextView *RSAShowTextView;

@property (nonatomic, strong) NSString *aesKey;
@property (nonatomic, strong) NSString *aesShowText;
@property (nonatomic, strong) NSString *rsaShowText;

@end

@implementation AESRSA128Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.AESKeyTextField.delegate = self;
    self.AESInputTextField.delegate = self;
    self.RSAInputTextField.delegate = self;
    self.AESShowTextView.delegate = self;
    self.RSAShowTextView.delegate = self;
}
- (IBAction)AESEncryptedBtn:(id)sender {
    self.aesKey = self.AESKeyTextField.text;
    NSString *aesInputText = self.AESInputTextField.text;
    
    if (!aesInputText.length) {
        self.AESShowTextView.text = @"请输入需要进行AES加密的字符串";
        return;
    }
    
    self.aesShowText = [AES128Util AES128Encrypt:aesInputText key:_aesKey];
    self.AESShowTextView.text = [NSString stringWithFormat:@"AES加密后的是: %@", self.aesShowText];
}
- (IBAction)AESDecryptedBtn:(id)sender {
    self.aesShowText = [AES128Util AES128Decrypt:self.aesShowText key:_aesKey];
    self.AESShowTextView.text = [NSString stringWithFormat:@"AES解密后的是: %@", self.aesShowText];
}

- (IBAction)RSAEncryptedBtn:(id)sender {
    RSAEncryptor *rsaManager = [RSAEncryptor sharedInstance];
    [rsaManager loadPublicKeyFromFile:[[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"der"]];
    
    NSString *rsaInputText = self.RSAInputTextField.text;
    if (!rsaInputText.length) {
        self.rsaShowText = @"";
        self.RSAShowTextView.text = [NSString stringWithFormat:@"请输入需要RSA加密的字符串"];
        return;
    }
    
    self.rsaShowText = [rsaManager rsaEncryptString:rsaInputText];
    self.RSAShowTextView.text = [NSString stringWithFormat:@"RSA加密后的数据是: %@", _rsaShowText];
}
- (IBAction)RSADecryptedBtn:(id)sender {
//    RSAEncryptor *rsaManager = [RSAEncryptor sharedInstance];
//    [rsaManager loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"der"] password:@""];
//    
//    self.RSAShowTextView.text = [rsaManager rsaDecryptString:_rsaShowText];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return [textView resignFirstResponder];
}

@end
