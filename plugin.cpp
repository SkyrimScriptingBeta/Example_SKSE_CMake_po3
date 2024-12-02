#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>

#include "plugin-definition.h"

DEFINE_SKSE_PLUGIN("Plugin using Macro")

SKSE_PLUGIN_ENTRY_POINT(const SKSE::LoadInterface* a_skse) {
    SKSE::Init(a_skse);
    return true;
}
