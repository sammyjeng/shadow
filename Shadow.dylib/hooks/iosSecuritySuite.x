#import "hooks.h"

typedef bool (*OriginalMethodType)(void);

OriginalMethodType orig_amIReverseEngineered;
bool replaced_amIReverseEngineered() {
    bool retval = orig_amIReverseEngineered();
    retval = NO; 
    return retval;
}

OriginalMethodType orig_amIProxied;
bool replaced_amIProxied(){
    bool retval = orig_amIProxied();
    retval = NO;
    return retval;
}

OriginalMethodType orig_amIJailBroken;
bool replaced_amIJailBroken(){
    bool retval = orig_amIJailBroken();
    retval = NO;
    return retval;
}

void shadowhook_iosSecuritySuite(HKSubstitutor* hooks){
    void *handle = dlopen(NULL, RTLD_LAZY);
    NSLog(@"[+] init");
    if (handle) {
        orig_amIReverseEngineered = (OriginalMethodType)dlsym(handle, "$s16IOSSecuritySuiteAAC20amIReverseEngineeredSbyFZ");
        orig_amIProxied = (OriginalMethodType)dlsym(handle, "$s16IOSSecuritySuiteAAC10amIProxiedSbyFZ");
        orig_amIJailBroken = (OriginalMethodType)dlsym(handle, "$s16IOSSecuritySuiteAAC13amIJailbrokenSbyFZ");
        if (orig_amIReverseEngineered) {
            NSLog(@" [+] IOSSecuritySuite.amIReverseEngineered function address: %p", orig_amIReverseEngineered);
            MSHookFunction(orig_amIReverseEngineered, replaced_amIReverseEngineered, (void **)&orig_amIReverseEngineered);
        }
        if (orig_amIProxied){
            NSLog(@" [+] IOSSecuritySuite.amIProxied function address: %p", orig_amIProxied);
            MSHookFunction(orig_amIProxied, replaced_amIProxied, (void **)&orig_amIProxied);
        }
        if (orig_amIJailBroken){
            NSLog(@" [+] IOSSecuritySuite.JailBroken function address: %p", orig_amIJailBroken);
            MSHookFunction(orig_amIJailBroken, replaced_amIJailBroken, (void **)&orig_amIJailBroken);
        }
        dlclose(handle);
    }
}