//
//  ViewController.m
//  Demo-iOS-Davivienda
//
//  Created by Jonathan Alonso Pinto on 8/8/16.
//  Copyright © 2016 Jonathan Alonso Pinto. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerEasy (){
    AppDelegate *appDelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self notifyDeviceHealt];
    [self conectionSecurePortalEasySolutions];
    //[self conectionSecurePortalEasySolutions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*****************************************
 
 Este método permite habilitar o deshabilitar el servicio que envia los eventos
 
 ****************************************/
- (void)disableServiceEvent{
    [appDelegate.dsbProtectorObj setEventsReportingEnable:TRUE];
}

/*****************************************
 
 Este método permite habilitar o deshabilitar el servicio de actualizaciones automaticas
 
 ****************************************/
- (void)updateAutomatic{
    [appDelegate.dsbProtectorObj setAutomaticUpdateInterval:120000];
    [appDelegate.dsbProtectorObj setAutomaticUpdateEnabled:TRUE];
}

/*****************************************
 
 Este método permite enviar el username de forma cifrada
 
 ****************************************/
- (void)sendUserCipher{
    [[DSB sdk] setEventReportingUsername:@"USERNAME" publicKeyID:123123 cipher:TRUE];
}

/*****************************************
 
 Estos métodos permiten obtener la informacion del dispositivo
 
 ****************************************/
- (void)notifyDeviceHealt{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onScanDeviceState:) name:@"onScanDeviceStateEvent" object:nil];
    [[[DSB sdk] DEVICE_PROTECTOR_API] scanDeviceStatus];
}
-(void)onScanDeviceState:(NSNotification*)notification{ NSDictionary *dictionary = notification.userInfo;
    NSLog(@"Dictionario que tiene la informacion del dispositivo%@", dictionary);
}

/*****************************************
 
 Estos métodos informa cuando la conexión hacia los servidores de Easy fue comprometida
 
 ****************************************/
-(void)notifyConnectionServerEasySolutions{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onBlockedConnectionNotification:) name:@"onBlockedConnection" object:nil];
}

- (void) onBlockedConnectionNotification:(NSNotification *)notification{
    //Desición del cliente cuando es bloqueada la conexión
}

/*****************************************
 
 Estos métodos permiten analizar el dispositivo en cualquier momento de la aplicacion
 
 ****************************************/

- (void)analizeDevice{
    [[[DSB sdk] DEVICE_PROTECTOR_API] scanDeviceStatus];
}

/*****************************************
 
 Estos métodos permiten analizar si el dispositivo tiene jailbreak
 
 ****************************************/

- (void)analizeJailbreakDevice{
    BOOL jailbreak = [[[DSB sdk] DEVICE_PROTECTOR_API] deviceHasJailbreak];
    NSLog(@"True or false %d", jailbreak);
}

/*****************************************
 
 Estos métodos permiten analizar si la conexión establecida es segura
 
 ****************************************/

- (void)conectionSecurePortalEasySolutions{
    NSString* url = @"https://checkout.paymentez.com/";
    BOOL secure = [[[DSB sdk] CONNECTION_PROTECTOR_API] isSecureConnection:url];
    if(secure){
        //Conexión segura
    }else{
        //Conexión con problemas de seguridad
    }
}

/*****************************************
 
 Estos métodos permiten analizar si el dispositivo es seguro basado en los parámetros del portal 
 
 ****************************************/

- (void)analizeDevicePortalEasySolutions{
    BOOL secure = [[[DSB sdk] CONNECTION_PROTECTOR_API] isSecureByRiskRules];
    if(secure){
        //Conexión segura
    }else{
        //Conexión con problemas de seguridad
    }
}


@end
