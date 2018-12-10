1. get app and patch
2. decrypt both <url>
3. copy app, then patch into dir "original", overwriting as necessary
4. copy dir "original" to dir "translation", overwrite with contents of translation patch

next up, unityex unpacking, sadly gameobjects tree view cannot be unpacked from command line, and ui unpack doesn't create nested trees

first task though should be creating a script to create translation from original using the repo

the unity asset manipulations tools <url> are not great, so they'll mostly be used manually and then binary patches created, i think (xdelta)

dds files extracted via conversion from asset files don'd loat in faststone, but irfanview can handle them. support contacted


assembly-csharp was unpacked with jetbrains c# decompiler but not yet repackable. binary patch?

wtf is a monobehavior, is the file format described? found mention that it's a base class of unity objects and the exact type is clarified by the ids. needs more research.

quest descriptions have space for 4 lines, seem to need newlines as they break below ui elements otherwise,
fit about this much: "Have 2 ships in your main fleet. Mmmmmmm mmm"

ship greeting texts have space for 4 lines and auto-break,
fit about this much: "mmm mmmmmm mmmmmm mmmmm mmmmmm", 630 px

font for both appears to be A-OTF-ShinGoPro-Regular.ttf, 18, line leading setting of -5


選択 6 "Select"
提督コマンド 18 "Admiral Command   "
戦略へ 9 "Strategy "
決定 6 "Choose"
戻る 6 "Return"

wrote a script to inject english versions of jp strings via raw string-matching

wrote a script to inject modified binary files back into .asset files in bulk



=head1 Assembly-CSharp.dll

Contains mostly strings in UCS-2 LE. But however a FEW strings (enums) are also UTF8.
No idea if the latter show up ingame.

> "Most tutorials like this, that I've seen,
> always use .NET Reflector with the Reflexil plugin.
> However, I'm going to be using ILSpy,
> which is a free alternative, with the Reflexil plugin."

https://github.com/icsharpcode/ILSpy/releases
https://github.com/sailro/Reflexil/releases
https://github.com/0xd4d/dnSpy/releases
jetbrains c# decompiler

None of these that i tried were able to recompile the dll into something that doesn't
crash the vita, so i went the way of binary modding the dll.

Sadly due to the strings being in UTF16 and binary modding not allowing
changes to the byte length, it's necessary to mod the fonts in order to
show more characters per byte than usually possible.

A-OTF-ShinGoPro-Regular.ttf in assets 2, used for quest name texts, ship greetings, ...
A-OTF-UDShinGoPro-Regular.ttf in assets 3, used for the popup button guide at the bottom, ...

online font tester: http://torinak.com/font/lsfont.html

For modding fonts i use FontForge. When using it there might be
an error window in the taskbar but not actually visible,
click on that and hit esc once.

Detailed steps from start to finish:

The following stuff doesn't need to be done everytime, it's just preparation.

- put unityex in ../unity_tools
- put the decrypted game in ../kc_original
- # unpack_original_files.pl
- open ../kc_original\Media\Managed\Assembly-CSharp.dll in JetBrains dotPeek
  - right-click Assembly-CSharp, export to project (might need two clicks (???))
  - ..\kc_original_unpack\Media\Managed\
  - progress bar in bottom right

<dll dictionary updater here (not even sure if we'll need this or just build the
dictionary manually)>

- edit the files `binary_translations.pm` and `csharp_translations.pm` to add
new japanese strings to modify, and their translations.

The next script then will do all of this:

It attempts to replace strings in unpacked binary files from the units asset
files.

It attempts to replace strings in Assembly-CSharp.dll with their translations.
It might complain, depending on whether the translation dictionary has changed,
that tuples are missing. Add them judiciously to the `font_mod_character_pairs`
file until it stops complaining. Tuples can probably be very long. The
translation will be padded if more bytes are necessary. However shorter tuples
might be useful for reusing things. (Then again we have 5000 glyphs available.)

Then it sets up the fonts to prepare them for injecting character tuples:

- Directories are created with copies of the fonts that contain 5000+
prepared glyphs in the first "Private Use Area".
- Then copies of these directories are made and multi-character strings injected
into the prepared glyphs according to `font_mod_character_pairs`.
- After that those mod directories are converted into fonts which are placed in
the appropriate translation candidate sub-directories.

(The script caches font directories in ../fonts to speed things up. If you
suspect something went wrong, deleting either of them will cause them to be
rebuilt.)

Then it injects the fonts and other asset files from the directory
`kc_original_unpack_modded` into asset files in `kc_translation_mod_candidate`.

- # perl modify_fonts_and_inject.pl

And this copies everything onto the vita mounted at E:.

- # perl vita_copy.pl
