# Indev ota changelogs
## https://anki2.ca/otas/1.6-rebuild/indev/

## 1.6.1.0058 (2026/02/26)
Update victor to `41ab2cb9847bff833212f6be6943593a81550f54`, can now ask Vector `What's the date` and Vector will give you the date, bit rushed but it'll prolly be fiine.

## 1.6.1.0057 (2026/02/23)
Update victor to `287a5d0dcf1b187afb418919cc71af4eaec5b55f`, pure green bootup backpack lights, opencv has compiler optimizations now to speed things up, scanlines work, old onboarding wakeup anim, a much better Rebuild Eyes implementation for keeping eye color through reboots [here](https://github.com/Victor-Rebuild/victor-1.6-rebuild-2/commit/ef89b337970e3729f36906667c4a62bed321c09b).

## 1.6.1.0056 (2026/02/21)
Update victor to `258e4c699c713246d78dbd2e478106037333b6d8`, make performances happen more again, port true evil bump from Viccyware, bump max photos to 300 photos, show a animation if photo storage is full, fix timer cancel countdown on Vector 2.0. Update vic-verbose: Remove random lights, make init faster, set lights to green while logging, make em blue when starting processes, remove unneeded date string.

## 1.6.1.0055 (2026/02/19)
Update victor to `064e3f748430e1a8c68f2e88e2de64ae14e263d1`, make rebuild eyes persist colors through reboots.

## 1.6.1.0054 (2026/02/17)
Update victor to `8354726adbb1e00f5d067fabc223c837cbffc8f2`, more clear pairing screen.

## 1.6.1.0053 (2026/02/16)
Update victor to `fe0b958215ef3c3002447016250ae1af048c7423`, skip body overheat check on Vector 2.0, restart chrony when Vector connects to wifi, fix 914 when telling Vector to explore.

## 1.6.1.0052 (2026/02/14)
Switch to victor-1.6 public, update to commit `eca0a2ed1c7fd479855c589cb7948afddc9526f7`. Implement the oneoff charger docking animations to decrease the chances of loosepixel or binaryeyes when leaving charger in a way similar to how anki would have done it, allow more range when running over a object, changes to the age finding system: First try to get the age from `/data/persist`, if the age from `/data/persist` is older than 2016 fall back to the onboarding state file, if that's still older than 2016 rely on `onboardingState.json`, and if it doesn't exist just use the stats tracker. Rebuild (XMB) eyes uses less system resources as it now refreshes every 3/4ths of a second instead of every 1/2 of a second, upgrade mpg123 library, restore pet detection timing to 6 events, much more clearer pairing screen.

## 1.6.1.0051 (2026/02/10)
Update victor-1.6(-private) to `e2f8fc20162af484a724392ec9edeb385fb9fc74`, lessen screen tearing on 2.0, make pet detection trigger less, fix petting lights from showing up when they aren't supposed to, put held in palm in webViz, fix video in 8890, use 1.6 syscon firmware for better compatibility.

## 1.6.1.0050 (2026/02/04)
Restart victor-1.6, all previous features have remained intact, repo still private. Vector runs at 60fps now, saturaton on 2.0 is more accurate to 1.0, set vc timing back to 1.5's timing, stop tracks from moving when unexpected, port 1.7's held on palm edge reactions, more sensitive cliff detection, fix explore vc being ignored, better scale robot name and pin for 1.0 and 2.0.

## 1.6.1.0049 (2026/01/24)
Update victor to `46259d0c5e1a9d38f5cfebbdb32732d4346fd378`, just a tiny little hack to "fix" put down 914"

## 1.6.1.0048 (2026/01/24)
Update victor to `d39ee530283e6b419db7c248ef1dfb961b8baf54`, update opencv, adjust the rebuild eyes schedule to be almost matching with the PS3.

## 1.6.1.0047 (2026/01/23)
Update victor to `ed6ac69b0e2b68505a5b59a34cdc59667488f47a`, add rebuild eyes as the new eye color, rainbow eyes voice command, custom eye color now plays the transition animation, timer works up to 1 day now, you can see what server Vector is connected to for voice commands within ccis, vic-cloud is now built instead of copied in.

## 1.6.1.0046 (2026/01/18)
Update victor to `efc92b1ce8771befcb326fe44ae349083c3a42e4`, remove denoising function.

## 1.6.1.0045 (2026/01/17)
Update victor to `fa16d8816d27524bad9703dfc277ceecedefae84`, add PurplPKG, add gamma correction, add Wire's 2.0 cam fixes.

## 1.6.1.0044 (2026/01/16)
Update victor to `3ecd4f59f347dae89ec5642f2baca0d05b8a6a73`, finish multilanguage support, now french, german, and japanese have proper translated strings, albeit google translated. OpenCV updated to `6950bedb5ce1827bc025bea7c1b23df6e947a437`.

## 1.6.1.0043 (2026/01/13)
Update victor to `2119d31c9a034ccdeb91e8d63d29ed66ae358a56`, fix botname not showing full name, more 914s killed, new wired interface from WireOS, fix multilanguage support.

## 1.6.1.0042 (2026/01/11)
Update victor to `efc6fdd96204e7f19ff0d89b9a91b1c85f385e8e`, fix more 914 agaiiiin.

## 1.6.1.0041 (2026/01/06)
Update victor to `a174420402e561c6250fbf01e9d59559f65e4eac`, fix more 914 errors, new charger leaving loosepixel animation, make Vector play more and go to charger less, mainline OpenCV, indev builds now have vic-verbose for the boot anim.

## 1.6.1.0040 (2026/01/03)
Update victor to `5561c89c85a1ddede69e4cb735965b36e20f4076`, update OpenCV to 4.13, make backtraces work, add pet detection, prevent log spam from body tracks being locked.

## 1.6.1.0039 (2026/01/02)
Update victor to `326780cc7341344b8161993dd8b6a75beabe33a2`, fix blackjack and weather positions on Vector 2.0, make crashes reboot faster, 2.0 can now show low battery / overheated battery images correctly, ANKI_VERIFY won't kill the bot with 914 anymore, restore unused holiday lights anim.

## 1.6.1.0038 (2025/12/30)
Update victor to `13491153f40c922b85a8df5ceced9af4b09e9c35`, add wp detection logic to select the correct link. This WILL be the real 1.6.1.3.

## 1.6.1.0037 (2025/12/30)
Update victor to `ac1c77e7affae8e815cf1ee3e3c29e87b28ff0c6`, extremely fast knowledge graph, add system slot switch option to ccis, fix error 914, fix mirrormode, identical to release 1.6.1.3

## 1.6.1.0036 (2025/12/26)
Update victor to `ce361379d862afa70c34f09c902ac71d34f87af5`, new onboarding animation.

## 1.6.1.0035 (2025/12/25)
Christmas update! Update victor to `ca5e652b69472d22e3a4e8acd55a5c709ca92694`, add Bot Naming in :8080, you can ask Vector "What's your name" and Vector will say whatever nickname you set, Vector 2.0 no longer gets overclocked when weather or blackjack happens, fix weather crashes that seem to happen whenever weather is in the negatives, change kernel name in neofetch, update all submodules.

## 1.6.1.0034 (2025/12/19)
Update Victor to `0472bc1c3b4d011dbb149cf432c906045ef71eb2`, Reonboarding clears wirepod server status, full mute/unmute animation plays for mics, 2.0 now has the correct screen pixel count, vcs should work better since mics are more sensitive now, fix update engine weirdness.

## 1.6.1.0033 (2025/12/16)
Fix nightly reboots waking up instead of starting asleep. Identical to release.

## 1.6.1.0032 (2025/12/10)
Release today, add reonboard option, update victor-1.6 to f0ba9987427026ab1a765346b86315d7f1b5c867

## 1.6.1.0031 (2025/12/09)
Release tommorow, change rampost to show the new website

## 1.6.1.0030 (2025/12/06)
Updated submodules for bitbake, openembedded-core, and meta-openembedded.

## 1.6.1.0029 (2025/12/06)
Upgrade victor-1.6 to `ca9d49bbc1a0a418d8b63531df32eb09e674a9db`, new custom server environment up at https://anki2.ca/1.6/, new concheck endpoint to not stress froggitti's server, slightly faster build time.

## 1.6.1.0028 (2025/12/05)
Fix build id again

## 1.6.1.0027 (2025/12/03)
Set prod build id correctly to fix auto updates

## 1.6.1.0026 (2025/12/03)
FULL build system refactor, compile victor-1.6 within oelinux, refactor `update-engine-rebuild` a bit, huge ota size drop.

## 1.6.1.0025 (2025/12/02)
Update victor-1.6 to c6bf8681b9e9a07fdc37c4beb04b5b844ee83e48, rename `rebuild-update-unengine` to `update-engine-rebuild` add oskr and prod cloudless builds, add auto update urls for cloudless, add downgrade support to `rebuild-update-engine`, add emergancy force install flag just in case.

## 1.6.1.0024 (2025/11/26)
Update victor-1.6 to 5c17cea29bffd02c170add60c4e1baca890060d2, adjust timing of success/fail sound effect, fix nightly reboots staying awake.

## 1.6.1.0023 (2025/11/20)
Update victor-1.6 to 6d8c2e5c3a29ad8fd49a1e793f79ff60c4b13ea2, add snowglobe animation since it snowed here, remove now obsolete wired freqchange methods, restore frequency to what it was before instead of defaulting to balanced, tighten button press window, make crashs reboot faster.

## 1.6.1.0022 (2025/11/09)
Update victor-1.6 to 97e0c05353e8302891a4174173a266ae1555a9f1, fix authing with servers, better 2.0 eyes, correct wired typo.

## 1.6.1.0021 (2025/11/03)
Fix btop warning, hardcode neofetch ascii art, useful command aliases, add vim-tiny.

## 1.6.1.0020 (2025/10/25)
I hate myself and rebooter

## 1.6.1.0019 (2025/10/24)
Rebooter works, make it only activate if uptime is over a hour.

## 1.6.1.0018 (2025/10/24)
Can rebooter just work?

## 1.6.1.0017 (2025/10/23)
Ugh rebooter...

## 1.6.1.0016 (2025/10/23)
Actually actually "fix" rebooter, update victor to b21be4d18ea34519e0653509ec44a42380c7edbc which allows Vector to count age in years, add "wire_os" to build.prop so wp doesn't swap out vic-cloud.

## 1.6.1.0015 (2025/10/18)
Actually fix rebooter

## 1.6.1.0014 (2025/10/15)
Fix rebooter, update to victor commit ed60b0d96132bb5980e980783f023c2328a2562e, fix blackjack dealer tts, add user customizable backpack lights

## 1.6.1.0013 (2025/09/18)
Uncan prod builds, update victor to 0b916a6fe7291a1dae66cc7d371c174952066532.

## 1.6.1.0012 (2025/09/17)
Prod builds are canned, actually add the auto update stuff, nothing else right now.

## 1.6.1.0011 (2025/09/14), hotpatch
Add auto updates back in, fix wired user prefs tab by updating vic-cloud and removing gateway (Victor bumped to 0b73d0dfd0a8f18047db6cfd7f96f7be25220650).

## 1.6.1.0011 (2025/09/14)
Remove python, add rainbow rampost lights back, C++ update engine and rewritten rebooter, put toastito's bot-specific ramposts back in, add prodperf build option so proddev builds work right and we can still make user builds, make the rampost error images point to `error.vicw.xyz` instead of the now dead `support.anki.com`.

## 1.6.1.0010 (2025/09/13)
First yocto ota, remove 1.6-specific customization temporarily, temp remove auto update implementation, no need to auth to change wifi networks, re-enable alexa, change faultcodehandler time limits, remove blackjack requests.

## 1.6.1.0009 (2025/09/01)
Dev only, change 1.6 settings to 1.6-rebuild settings, add face overlays, add Falling and Space Daydream animations, mm-anki-camera always trys to target 30 fps now, brand new auto update system rerwitten from scratch.

## 1.6.1.0008 (2025/08/20)
Wired broke due to it calling for /usr/bin/sleep and not /bin/sleep, this ota is just a fix for that

## 1.6.1.0007 (2025/08/20)
Manully cleaned update-os for this build, nothing else.

## 1.6.1.0006 (2025/08/20 (Actually 2025/08/19 but it's like 11:45pm and I really don't wanna build any otas right now))
Use new rampost boot images made by Toastito in V&F, make /data executable by default, make update-os up the cpu speeds and stop anki processes remove sb_server since we use picovoice now, port over wireutils from wireOS, re-enable HMP, cleaned kernel.

## 1.6.1.0005 (2025/08/19)
Don't copy in prebuilt ramposts and modules, use the one made with the ota, remove unneeded stuff from dvcbs-reloaded to hopefully cut down repo size a little, fix dynamic cpu speed on Vector 2.0 by updating Victor commit to [dd358480a177c6fa6d9a78dcd18a51900b806bb4](https://github.com/Switch-modder/victor-1.6-rebuild/commit/dd358480a177c6fa6d9a78dcd18a51900b806bb4).

## 1.6.1.0004 (2025/08/19)
Actually make the new different ramposts apply, don't clean anki every rebuild since cmake should be able to figure out what it needs to recompile should it have to happen.

## 1.6.1.0003 (2025/08/18)
Add a seperate proddev bitbake option, use different ramposts to confirm that we can have build specific ramposts.

## 1.6.1.0002 (2025/08/18)
Fixed the prod boot images so that they boot again, add new 1.6-rebuild rampost images.

## 1.6.1.0001 (2025/08/18)
Wired fully works, PicoVoice wakeword training works, changed OSKR messages to ankidevunit.

## 1.6.1.0000 (2025/08/16)
Dev only, first ota run, basically plain vicos-oelinux-nosign but with 1.6 anki.
