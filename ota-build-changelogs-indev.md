# Indev ota changelogs
## https://anki2.ca/otas/1.6-rebuild/indev/
## If you want to use 1.6-rebuild do NOT use these images, use the release ones instead

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
