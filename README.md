merge_strings
=============

This tiny script is for you, managing Localizable.strings by hand and grouping keys and values like you wish. it does not put everything in alphabetically order and does not simply add everything at the bottom.

Install
-------

    gem install merge_strings


Example scenario
----------------

Say, your base language is Japanese, and maintain the strings file by hand as implementation goes.

ja.lproj/Localizable.strings:

    /* common alerts and dialogs */
    "yes" = "はい"; /* yes button */
    "no" = "いいえ"; /* no button */
    /* Login */
    "Login failed." = "ログインできませんでした。";

You need to add English as a supported language. It will be OK to copy strings file and modify values for the first time.

en.lproj/Localizable.strings:

    /* common alerts and dialogs */
    "yes" = "Yes"; /* yes button */
    "no" = "No"; /* no button */
    /* Login */
    "Login failed." = "Login failed.";

You added a new feature and added a new localizable key in ja.lproj/Localizable.strings:

    /* common alerts and dialogs */
    "yes" = "はい"; /* yes button */
    "no" = "いいえ"; /* no button */
    /* Settings */
    "Font size" = "フォントサイズ";
    /* Login */
    "Login failed." = "ログインできませんでした。";

 Run merge_strings.rb!

    merge_strings.rb ja.lproj/Localizable.strings en.lproj/Localizable.strings

You will see in en.lproj/Localizable.strings:

    /* common alerts and dialogs */
    "yes" = "Yes"; /* yes button */
    "no" = "No"; /* no button */
    /* Settings */
    "Font size" = "Font size"; /* TRANSLATION REQUIRED */
    /* Login */
    "Login failed." = "Login failed.";

