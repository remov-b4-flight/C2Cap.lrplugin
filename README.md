C2Cap
***

Adobe Lightroom plugin to Set 'Caption' of bulk Photos.  
大量の写真に対して 「説明」を付ける為のAdobe Lightroom のプラグイン。  

#1. Introduction/はじめに.
This plugin is developped for manage bulk photos by set IPTC.  
このプラグインはAdobe Lightroomで大量の写真を管理を容易にするために
IPTCの'Caption'(説明)を迅速につけるために開発されました。

In most case, Users use collection for managing bulk photos by Lightroom,
This plugin set photo's caption to collection's name which photos are contained.   
具体的にはLightroom上で写真を管理する際、コレクションを使って写真を分類する手法が
一般的ですが、このコレクションの「名前」を使ってコレクションに含まれる写真に
'Caption'を設定します。  
Collection 2 Caption -> 'C2Cap' です。

処理の対象になる写真はコレクションに含まれる写真の中でまだ'Caption'がついていない
ものです。

#2. Install/インストール. 
(It's standard way to install Lightroom plugin./Lightroomプラグインの標準的な手順です)  
ダウンロードしたファイルをどこかのフォルダに置いて拡張子を.lrplugin (またはlrdevplugin)
にしてください。  
Lightroomのプラグインマネージャーを開き'追加'ボタンを押します。  
ダイアログで先ほどの .lrplugin(.lrdevplugin)を選択します。  
有効になっていない場合「有効にする」ボタンを押します。

#3. 使用方法. 
Select a collection to process, and select menu from 'library > plugin extra > C2Cap'.  
処理したいコレクションを選択して ライブラリ > プラグインエクストラ > C2Cap を選択します。  
コレクションに含まれる写真のなかで説明(Caption)が記入されていない全て写真に対して、  
説明にコレクションの名前を設定します。
***
Useful setting for macOS user / macOSユーザー向け便利な設定  
Keyboard in System preference. select 'shortcut' tab.  
Select Application and Add shortcut to 'Abobe Lightroom Classic' As  
Library->Plug-in Extras->   Collection  
(3 spaces between -> and Collection )  
***
#4. 設定. 
プラグインマネージャの設定で以下の処理が可能です。

##Revert Back(指定コレクションに戻る)
コレクションのCaption設定処理を終えた後、テキストボックスで指定した
コレクションに移動します。

#5. 作者・ライセンス
じゅん [twitter](https://twitter.com/remov_b4_flight @remov_b4_flight)
ライセンスはGPLです。  
開発は全てMacで行っています。  
Windowsでの動作報告歓迎します。
