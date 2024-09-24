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

//$s16IOSSecuritySuiteAAC13amIJailbrokenSbyFZ

void shadowhook_iosSecuritySuite(HKSubstitutor* hooks){
    void *handle = dlopen(NULL, RTLD_LAZY);
    NSLog(@"[+] init");
    if (handle) {
        orig_amIReverseEngineered = (OriginalMethodType)dlsym(handle, "$s16IOSSecuritySuiteAAC20amIReverseEngineeredSbyFZ");
        orig_amIProxied = (OriginalMethodType)dlsym(handle, "$s16IOSSecuritySuiteAAC10amIProxiedSbyFZ");
        if (orig_amIReverseEngineered) {
            NSLog(@" [+] IOSSecuritySuite.amIReverseEngineered function address: %p", orig_amIReverseEngineered);
            MSHookFunction(orig_amIReverseEngineered, replaced_amIReverseEngineered, (void **)&orig_amIReverseEngineered);
        }
        if (orig_amIProxied){
            NSLog(@" [+] IOSSecuritySuite.amIProxied function address: %p", orig_amIProxied);
            MSHookFunction(orig_amIProxied, replaced_amIProxied, (void **)&orig_amIProxied);
        }
        dlclose(handle);
    }
}

