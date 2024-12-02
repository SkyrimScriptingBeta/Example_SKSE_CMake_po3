#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>

const auto PLUGIN_VERSION = REL::Version(1, 0, 0);

extern "C" __declspec(dllexport) bool SKSEPlugin_Query(
    const SKSE::QueryInterface* a_skse, SKSE::PluginInfo* a_info
) {
    a_info->infoVersion = SKSE::PluginInfo::kVersion;
    a_info->name        = "My 1.5.97 po3 plugin";
    a_info->version     = PLUGIN_VERSION.pack();
    if (a_skse->IsEditor()) return false;
    return true;
}

extern "C" __declspec(dllexport) bool SKSEPlugin_Load(const SKSE::LoadInterface* a_skse) {
    SKSE::Init(a_skse);

    SKSE::GetMessagingInterface()->RegisterListener(
        "SKSE",
        [](SKSE::MessagingInterface::Message* a_msg) {
            if (a_msg->type == SKSE::MessagingInterface::kDataLoaded) {
                if (auto* consoleLog = RE::ConsoleLog::GetSingleton()) {
                    consoleLog->Print("Hello, world!");
                }
            }
        }
    );

    return true;
}