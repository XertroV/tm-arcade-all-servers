LoadAllClubRoomsHook@ hook = LoadAllClubRoomsHook();

void Main() {Load();}
void OnEnabled() {Load();}
void OnDestroyed() {Unload();}
void OnDisabled() {Unload();}
void Unload() {MLHook::UnregisterMLHooksAndRemoveInjectedML();}
void Load() {MLHook::RegisterMLHook(hook, hook.type, true);}

class LoadAllClubRoomsHook : MLHook::HookMLEventsByType {
    LoadAllClubRoomsHook() {
        super("TMNext_ClubStore_Action_LoadAllClubRoomsPage");
    }

    void OnEvent(MLHook::PendingEvent@ event) override {
        if (event.data.Length != 3) {
            warn("got bad length for load all club rooms page event: " + event.data.Length);
        } else if (event.data[0] == "") {
            // event.data: {query, offset, length} -- all strings
            MLHook::Queue_Menu_SendCustomEvent("TMNext_ClubStore_Action_LoadAllClubRoomsPage", {"_", event.data[1], event.data[2]});
        }
    }
}
