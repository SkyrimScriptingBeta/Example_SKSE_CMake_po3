#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>

extern "C" __declspec(dllexport) bool SKSEPlugin_Query(
    const SKSE::QueryInterface* a_skse, SKSE::PluginInfo* a_info
) {
    a_info->infoVersion = SKSE::PluginInfo::kVersion;
    a_info->name        = "ExampleCMakePo3";
    a_info->version     = REL::Version(0, 0, 1).pack();
    if (a_skse->IsEditor()) return false;
    return true;
}

extern "C" __declspec(dllexport) bool SKSEPlugin_Load(const SKSE::LoadInterface* a_skse) {
    SKSE::Init(a_skse);

    SKSE::GetMessagingInterface()->RegisterListener(
        "SKSE",
        [](SKSE::MessagingInterface::Message* a_msg) {
            if (a_msg->type == SKSE::MessagingInterface::kDataLoaded)
                RE::ConsoleLog::GetSingleton()->Print("Hello from ExampleCMakePo3");
        }
    );

    return true;
}