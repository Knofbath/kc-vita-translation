Kantai Collection Vita Translation
==================================

This is a work in progress project to produce a Kantai Collection Vita
multilingual translation.

Installing The Translation
--------------------------

This assumes you have:
* a PS Vita
* VitaShell installed
* rePatch installed
* KanColle Kai v1.00 with patch v1.02 installed
* about 3gb free on the Vita
* a downloaded patcher executable from our [releases section](https://github.com/wchristian/kc-vita-translation/releases)

If you have the prerequisites, follow these steps to prepare:
* on your PC, create a path somewhere like this: d:\kancolle_kai_original\repatch\PCSG00684\
* in Vitashell, navigate to ux0:data/, triangle > new > new folder, name it kcv
* in Vitashell, navigate to ux0:app/, put the selector on PCSG00684, triangle > open decrypted
* move down the list, mark each entry with square, then triangle > copy
* navigate to ux0:data/kcv/, triangle > paste, that'll take a while
* in Vitashell, navigate to ux0:patch/, put the selector on PCSG00684, triangle > open decrypted
* move down the list, mark each entry with square, then triangle > copy
* navigate to ux0:data/kcv/, triangle > paste, that'll take a while
* hit select to connect the vita to your pc and copy the content of ux0:data/kcv/ into d:\kancolle_kai_original\repatch\PCSG00684\
* this folder will act as a backup in the future, keep it as is. maybe zip if it you're tight on space
* delete ux0:data/kcv/

With preparations done, time to create the actual translation patch
* create a copy of the folder d:\kancolle_kai_original\ as d:\kancolle_kai_translation\
* run the patcher executable, and select d:\kancolle_kai_translation\ as the folder for it to work in and click start
* once done, copy the repatch folder inside d:\kancolle_kai_translation\ to ux0: on your vita, repatch must be in the root of the ux0: drive

Now you can run the game with the translation patch.

Building The Patch
------------------

See [README_mith.txt](README_mith.txt).

Contributing Translations
-------------------------

Basically, make a fork of the repo and create pull requests. As for what files to edit:

See [README_mith.txt](README_mith.txt), and [the wiki](../../wiki) for some supplementary information.
